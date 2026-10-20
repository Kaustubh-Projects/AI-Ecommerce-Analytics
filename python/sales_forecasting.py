from pathlib import Path
import os

import pandas as pd
from dotenv import load_dotenv
from sqlalchemy import create_engine, text
from sqlalchemy.engine import URL
from sklearn.metrics import mean_absolute_error
from sklearn.metrics import mean_squared_error


# 1. Find the project folder
PROJECT_ROOT = Path(__file__).resolve().parent.parent

# 2. Load database configuration
load_dotenv(PROJECT_ROOT / ".env")

db_host = os.getenv("DB_HOST")
db_port = os.getenv("DB_PORT")
db_name = os.getenv("DB_NAME")
db_user = os.getenv("DB_USER")
db_password = os.getenv("DB_PASSWORD")

if not all([db_host, db_port, db_name, db_user, db_password]):
    raise ValueError("Database settings are missing. Check your .env file.")

# 3. Create the PostgreSQL engine
connection_url = URL.create(
    drivername="postgresql+psycopg",
    username=db_user,
    password=db_password,
    host=db_host,
    port=int(db_port),
    database=db_name,
)

engine = create_engine(connection_url)


def load_monthly_sales():
    """Load monthly delivered-order revenue from PostgreSQL."""

    query_file = PROJECT_ROOT / "sql" / "14_sales_forecasting_data.sql"
    query = query_file.read_text(encoding="utf-8")

    # Use the first SELECT in the SQL file, which returns monthly data.
    monthly_query = query.split("-- 2. Check the monthly date range")[0]

    with engine.connect() as connection:
        sales = pd.read_sql_query(text(monthly_query), connection)

    return sales


def main():
    try:
        sales = load_monthly_sales()

        sales["sales_month"] = pd.to_datetime(sales["sales_month"])
        sales = sales.sort_values("sales_month").reset_index(drop=True)

        # Add missing calendar months with zero recorded delivered revenue.
        sales = sales.set_index("sales_month").asfreq("MS")
        sales["item_revenue"] = sales["item_revenue"].fillna(0)
        sales["delivered_orders"] = sales["delivered_orders"].fillna(0)
        sales = sales.reset_index()

        print("Monthly periods:", len(sales))
        print("First month:", sales["sales_month"].min().date())
        print("Last month:", sales["sales_month"].max().date())

        if len(sales) < 6:
            raise ValueError("Not enough monthly observations to evaluate a forecast.")

        # Reserve the final 20% of months for testing.
        test_size = max(1, round(len(sales) * 0.20))
        train = sales.iloc[:-test_size]
        test = sales.iloc[-test_size:].copy()

        # Baseline: forecast each test month using the last training month's revenue.
        baseline_value = train["item_revenue"].iloc[-1]
        test["baseline_forecast"] = baseline_value

        mae = mean_absolute_error(
            test["item_revenue"],
            test["baseline_forecast"],
        )

        rmse = mean_squared_error(
            test["item_revenue"],
            test["baseline_forecast"],
        ) ** 0.5

        print("\nBaseline: last training month's revenue")
        print("Training months:", len(train))
        print("Testing months:", len(test))
        print("MAE:", round(mae, 2))
        print("RMSE:", round(rmse, 2))

        print("\nActual versus forecast:")
        print(
            test[
                ["sales_month", "item_revenue", "baseline_forecast"]
            ].to_string(index=False)
        )

        # Save the historical evaluation output.
        output_file = (
            PROJECT_ROOT
            / "data"
            / "processed"
            / "sales_forecast_evaluation.csv"
        )

        output_file.parent.mkdir(parents=True, exist_ok=True)
        test.to_csv(output_file, index=False)

        print("\nEvaluation saved to:", output_file)

    finally:
        engine.dispose()


if __name__ == "__main__":
    main()