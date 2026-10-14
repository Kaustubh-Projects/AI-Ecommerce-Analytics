
from pathlib import Path
import csv
from collections import Counter


# --------------------------------------------------
# 1. Project configuration
# --------------------------------------------------

PROJECT_ROOT = Path(__file__).resolve().parent.parent
DATA_FOLDER = PROJECT_ROOT / "data" / "raw"

ORDERS_FILE_NAME = "olist_orders_dataset.csv"

REQUIRED_ORDER_COLUMNS = [
    "order_id",
    "customer_id",
    "order_status",
    "order_purchase_timestamp",
]


# --------------------------------------------------
# 2. Inspect the structure of CSV files
# --------------------------------------------------

def inspect_csv_files():
    """Print each CSV file's name, row count, and columns."""

    csv_files = sorted(DATA_FOLDER.glob("*.csv"))

    if not csv_files:
        print(f"No CSV files found in: {DATA_FOLDER}")
        return

    print(f"CSV files found: {len(csv_files)}")
    print("=" * 60)

    for file_path in csv_files:
        try:
            with file_path.open(
                "r", encoding="utf-8-sig", newline=""
            ) as file:
                reader = csv.reader(file)
                headers = next(reader, None)

                if headers is None:
                    print(f"\nFile: {file_path.name}")
                    print("Status: Empty file")
                    continue

                row_count = sum(1 for _ in reader)

            print(f"\nFile: {file_path.name}")
            print(f"Data rows: {row_count}")
            print(f"Column count: {len(headers)}")
            print(f"Columns: {headers}")

        except (OSError, UnicodeError, csv.Error) as error:
            print(f"\nCould not inspect {file_path.name}: {error}")


# --------------------------------------------------
# 3. Check the orders dataset
# --------------------------------------------------

def inspect_orders():
    """Check required fields, repeated order IDs, and statuses."""

    orders_file = DATA_FOLDER / ORDERS_FILE_NAME

    if not orders_file.is_file():
        print(f"\nOrders file not found: {orders_file}")
        return

    missing_counts = Counter()
    order_id_counts = Counter()
    status_counts = Counter()
    total_rows = 0

    try:
        with orders_file.open(
            "r", encoding="utf-8-sig", newline=""
        ) as file:
            reader = csv.DictReader(file)
            available_columns = reader.fieldnames or []

            missing_columns = (
                set(REQUIRED_ORDER_COLUMNS) - set(available_columns)
            )

            if missing_columns:
                print(
                    "\nOrders dataset is missing required columns:",
                    sorted(missing_columns),
                )
                return

            for row in reader:
                total_rows += 1

                for column in REQUIRED_ORDER_COLUMNS:
                    value = row.get(column)
                    if value is None or not value.strip():
                        missing_counts[column] += 1

                order_id = row["order_id"].strip()
                if order_id:
                    order_id_counts[order_id] += 1

                status = row["order_status"].strip()
                status_counts[status or "(blank)"] += 1

    except (OSError, UnicodeError, csv.Error) as error:
        print(f"\nCould not inspect orders dataset: {error}")
        return

    repeated_ids = sum(
        count > 1 for count in order_id_counts.values()
    )

    print("\n\nORDERS DATA-QUALITY REPORT")
    print("=" * 60)
    print(f"Total data rows: {total_rows}")
    print(f"Unique nonblank order IDs: {len(order_id_counts)}")
    print(f"Order IDs appearing more than once: {repeated_ids}")

    print("\nBlank values in required columns:")
    for column in REQUIRED_ORDER_COLUMNS:
        print(f"  {column}: {missing_counts[column]}")

    print("\nOrder-status distribution:")
    for status, count in status_counts.most_common():
        print(f"  {status}: {count}")


# --------------------------------------------------
# 4. Program entry point
# --------------------------------------------------

def main():
    """Run the dataset inspection tasks."""

    print("E-COMMERCE DATASET INSPECTION")
    print(f"Project root: {PROJECT_ROOT}")
    print(f"Raw data folder: {DATA_FOLDER}\n")

    if not DATA_FOLDER.is_dir():
        print("Error: The data/raw directory does not exist.")
        return

    inspect_csv_files()
    inspect_orders()


if __name__ == "__main__":
    main()
