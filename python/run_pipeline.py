import argparse
import os
import subprocess
import sys
from pathlib import Path

from dotenv import load_dotenv
from sqlalchemy import create_engine, text
from sqlalchemy.engine import URL


# 1. Find the project folder and load database settings
project_folder = Path(__file__).resolve().parent.parent
load_dotenv(project_folder / ".env")


# 2. Connect to PostgreSQL
connection_url = URL.create(
    drivername="postgresql+psycopg",
    username=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
    host=os.getenv("DB_HOST"),
    port=int(os.getenv("DB_PORT", "5432")),
    database=os.getenv("DB_NAME"),
)

engine = create_engine(connection_url)


def run_pipeline(mode, csv_path=None):
    # 3. Select the ingestion script
    if mode == "simulate":
        command = [
            sys.executable,
            str(project_folder / "python" / "simulate_order_events.py"),
        ]

    else:
        if not csv_path:
            raise ValueError(
                "Provide a CSV path using --csv in manual mode."
            )

        csv_file = Path(csv_path)

        if not csv_file.is_absolute():
            csv_file = project_folder / csv_file

        if not csv_file.is_file():
            raise FileNotFoundError(
                f"CSV file not found: {csv_file}"
            )

        command = [
            sys.executable,
            str(project_folder / "python" / "ingest_order_events.py"),
            str(csv_file),
            "manual_csv",
        ]

    # 4. Ingest incoming events
    print("\nSTEP 1: Ingest incoming events")
    subprocess.run(command, cwd=project_folder, check=True)

    # 5. Transform Bronze events into Silver
    print("\nSTEP 2: Transform Bronze to Silver")

    sql_path = project_folder / "sql" / "16_transform_order_events.sql"
    transformation_sql = sql_path.read_text(encoding="utf-8")

    with engine.begin() as connection:
        connection.execute(text(transformation_sql))

    # 6. Verify pipeline results
    print("\nSTEP 3: Verify pipeline results")

    with engine.connect() as connection:
        totals = connection.execute(
            text("""
                SELECT
                    COUNT(*) AS total_events,
                    COUNT(DISTINCT event_id) AS unique_events
                FROM gold.vw_order_event_activity
            """)
        ).mappings().one()

        sources = connection.execute(
            text("""
                SELECT
                    event_source,
                    COUNT(*) AS event_count
                FROM gold.vw_order_event_activity
                GROUP BY event_source
                ORDER BY event_source
            """)
        ).all()

        missing_silver = connection.execute(
            text("""
                SELECT COUNT(*)
                FROM bronze.order_events AS b
                LEFT JOIN silver.order_events AS s
                    ON b.event_id = s.event_id
                WHERE s.event_id IS NULL
            """)
        ).scalar_one()

    # 7. Display results
    print(f"Total Gold events: {totals['total_events']}")
    print(f"Unique event IDs: {totals['unique_events']}")
    print(f"Bronze events missing from Silver: {missing_silver}")

    for source in sources:
        print(f"{source.event_source}: {source.event_count}")

    # 8. Stop if a consistency check fails
    if totals["total_events"] != totals["unique_events"]:
        raise RuntimeError(
            "Duplicate event IDs detected in the Gold view."
        )

    if missing_silver > 0:
        raise RuntimeError(
            f"{missing_silver} Bronze events have not reached Silver."
        )

    print("\nPipeline completed successfully.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Run the incoming order-event pipeline."
    )

    parser.add_argument(
        "--mode",
        choices=["simulate", "manual"],
        default="simulate",
        help="Generate synthetic events or ingest a manual CSV.",
    )

    parser.add_argument(
        "--csv",
        help="CSV path, required when mode is manual.",
    )

    args = parser.parse_args()

    try:
        run_pipeline(args.mode, args.csv)

    except Exception as error:
        print(f"\nPipeline failed: {error}")
        raise SystemExit(1)

    finally:
        engine.dispose()