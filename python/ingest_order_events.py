import os
import sys
from pathlib import Path

import pandas as pd
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


# 3. Define the required CSV columns
required_columns = [
    "event_id",
    "order_id",
    "customer_id",
    "order_status",
    "order_purchase_timestamp",
]


def load_order_events(csv_path, event_source):
    # 4. Resolve and validate the CSV path
    csv_path = Path(csv_path)

    if not csv_path.is_absolute():
        csv_path = project_folder / csv_path

    if not csv_path.is_file():
        raise FileNotFoundError(f"CSV file not found: {csv_path}")

    # 5. Validate the source
    if event_source not in ("manual_csv", "simulated"):
        raise ValueError(
            "Source must be 'manual_csv' or 'simulated'."
        )

    loaded_count = 0
    duplicate_count = 0

    # 6. Use one transaction for the complete file
    with engine.begin() as connection:
        for chunk in pd.read_csv(
            csv_path,
            dtype=str,
            keep_default_na=False,
            chunksize=1000,
        ):
            # 7. Check required columns
            missing_columns = [
                column
                for column in required_columns
                if column not in chunk.columns
            ]

            if missing_columns:
                raise ValueError(
                    f"Missing CSV columns: {missing_columns}"
                )

            # 8. Remove extra columns and trim required values
            chunk = chunk[required_columns].copy()

            for column in required_columns:
                chunk[column] = chunk[column].str.strip()

                if (chunk[column] == "").any():
                    raise ValueError(
                        f"Blank values found in {column}."
                    )

            # 9. Validate timestamps
            timestamps = pd.to_datetime(
                chunk["order_purchase_timestamp"],
                errors="coerce",
            )

            if timestamps.isna().any():
                raise ValueError(
                    "Invalid order_purchase_timestamp found."
                )

            # 10. Reject repeated event IDs inside the same chunk
            repeated_ids = chunk["event_id"].duplicated()

            duplicate_count += int(repeated_ids.sum())
            chunk = chunk.loc[~repeated_ids].copy()

            # 11. Add ingestion metadata
            chunk["event_source"] = event_source
            chunk["source_file"] = csv_path.name

            records = chunk.to_dict(orient="records")

            if not records:
                continue

            # 12. Insert events and skip IDs already in Bronze
            result = connection.execute(
                text("""
                    INSERT INTO bronze.order_events (
                        event_id,
                        order_id,
                        customer_id,
                        order_status,
                        order_purchase_timestamp,
                        event_source,
                        source_file
                    )
                    VALUES (
                        :event_id,
                        :order_id,
                        :customer_id,
                        :order_status,
                        :order_purchase_timestamp,
                        :event_source,
                        :source_file
                    )
                    ON CONFLICT (event_id) DO NOTHING
                """),
                records,
            )

            inserted = result.rowcount
            loaded_count += inserted
            duplicate_count += len(records) - inserted

    # 13. Display the results
    print(f"Source: {event_source}")
    print(f"File: {csv_path.name}")
    print(f"New events loaded: {loaded_count}")
    print(f"Duplicate events skipped: {duplicate_count}")


if __name__ == "__main__":
    try:
        if len(sys.argv) != 3:
            print(
                "Usage: python python/ingest_order_events.py "
                "<csv_path> <manual_csv|simulated>"
            )
            raise SystemExit(1)

        load_order_events(sys.argv[1], sys.argv[2])

    except Exception as error:
        print("Ingestion failed:", error)
        raise SystemExit(1)

    finally:
        engine.dispose()