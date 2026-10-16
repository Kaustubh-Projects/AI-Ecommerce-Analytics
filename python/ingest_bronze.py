
import hashlib
from pathlib import Path

import pandas as pd
from dotenv import load_dotenv
from sqlalchemy import create_engine, text
from sqlalchemy.engine import URL
import os


# 1. Find the project folder and load database settings
project_folder = Path(__file__).resolve().parent.parent
data_folder = project_folder / "data" / "raw"

load_dotenv(project_folder / ".env")

# 2. Create the PostgreSQL connection
connection_url = URL.create(
    drivername="postgresql+psycopg",
    username=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
    host=os.getenv("DB_HOST"),
    port=int(os.getenv("DB_PORT", "5432")),
    database=os.getenv("DB_NAME"),
)

engine = create_engine(connection_url)

# 3. Map each CSV file to its Bronze table
file_table_map = {
    "olist_customers_dataset.csv": "customers",
    "olist_geolocation_dataset.csv": "geolocation",
    "olist_order_items_dataset.csv": "order_items",
    "olist_order_payments_dataset.csv": "order_payments",
    "olist_order_reviews_dataset.csv": "order_reviews",
    "olist_orders_dataset.csv": "orders",
    "olist_products_dataset.csv": "products",
    "olist_sellers_dataset.csv": "sellers",
    "product_category_name_translation.csv": "category_translation",
}


# 4. Calculate a fingerprint for the file
def calculate_file_hash(file_path):
    sha256 = hashlib.sha256()

    with open(file_path, "rb") as file:
        for chunk in iter(lambda: file.read(1024 * 1024), b""):
            sha256.update(chunk)

    return sha256.hexdigest()


# 5. Load one CSV file into its Bronze table
def load_csv(file_name, table_name):
    file_path = data_folder / file_name

    if not file_path.exists():
        print(f"File not found: {file_name}")
        return

    file_hash = calculate_file_hash(file_path)

    # Check whether identical file contents loaded successfully before
    with engine.connect() as connection:
        existing_load = connection.execute(
            text("""
                SELECT batch_id
                FROM bronze.ingestion_batches
                WHERE file_hash = :file_hash
                  AND status = 'completed'
                LIMIT 1
            """),
            {"file_hash": file_hash},
        ).first()

        # Check whether this filename was previously loaded with
        # different contents
        changed_file = connection.execute(
            text("""
                SELECT batch_id
                FROM bronze.ingestion_batches
                WHERE source_file = :source_file
                  AND status = 'completed'
                  AND file_hash <> :file_hash
                LIMIT 1
            """),
            {
                "source_file": file_name,
                "file_hash": file_hash,
            },
        ).first()

    if existing_load:
        print(f"Skipped: {file_name} was already loaded.")
        return

    if changed_file:
        print(
            f"Stopped: {file_name} has changed since its previous "
            "successful load. Controlled reprocessing is required."
        )
        return

    # Record the attempt separately so it remains visible if loading fails
    with engine.begin() as connection:
        batch_id = connection.execute(
            text("""
                INSERT INTO bronze.ingestion_batches
                    (source_file, file_hash, status)
                VALUES
                    (:source_file, :file_hash, 'in_progress')
                RETURNING batch_id
            """),
            {
                "source_file": file_name,
                "file_hash": file_hash,
            },
        ).scalar_one()

    row_count = 0

    try:
        # Load chunks and mark success in the same transaction
        with engine.begin() as connection:
            for chunk in pd.read_csv(
                file_path,
                dtype=str,
                keep_default_na=False,
                na_values=[""],
                chunksize=10000,
            ):
                chunk["source_file"] = file_name

                chunk.to_sql(
                    name=table_name,
                    con=connection,
                    schema="bronze",
                    if_exists="append",
                    index=False,
                    chunksize=1000,
                )

                row_count += len(chunk)

            connection.execute(
                text("""
                    UPDATE bronze.ingestion_batches
                    SET status = 'completed',
                        completed_at = CURRENT_TIMESTAMP,
                        row_count = :row_count,
                        error_message = NULL
                    WHERE batch_id = :batch_id
                """),
                {
                    "row_count": row_count,
                    "batch_id": batch_id,
                },
            )

        print(f"Loaded: {file_name} | Rows: {row_count}")

    except Exception as error:
        # The failed transaction rolls back its inserted rows
        with engine.begin() as connection:
            connection.execute(
                text("""
                    UPDATE bronze.ingestion_batches
                    SET status = 'failed',
                        completed_at = CURRENT_TIMESTAMP,
                        row_count = NULL,
                        error_message = :error_message
                    WHERE batch_id = :batch_id
                """),
                {
                    "error_message": str(error)[:4000],
                    "batch_id": batch_id,
                },
            )

        print(f"Failed: {file_name}")
        print("Error:", error)




if __name__ == "__main__":
    try:
        for file_name, table_name in file_table_map.items():
            print(f"\nProcessing: {file_name}")
            load_csv(file_name, table_name)

    finally:
        engine.dispose()