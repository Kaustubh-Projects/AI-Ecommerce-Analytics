
import os
from pathlib import Path

from dotenv import load_dotenv
from sqlalchemy import create_engine, text
from sqlalchemy.engine import URL


# 1. Find the project folder
project_folder = Path(__file__).resolve().parent.parent

# 2. Load database settings from .env
load_dotenv(project_folder / ".env")

# 3. Read database settings
db_host = os.getenv("DB_HOST")
db_port = os.getenv("DB_PORT")
db_name = os.getenv("DB_NAME")
db_user = os.getenv("DB_USER")
db_password = os.getenv("DB_PASSWORD")

# 4. Check whether all settings are available
if not all([db_host, db_port, db_name, db_user, db_password]):
    raise ValueError(
        "Database settings are missing. Check your .env file."
    )

# 5. Create the PostgreSQL connection URL
connection_url = URL.create(
    drivername="postgresql+psycopg",
    username=db_user,
    password=db_password,
    host=db_host,
    port=int(db_port),
    database=db_name,
)

# 6. Create the database engine
engine = create_engine(connection_url)


# 7. Get total delivered-order revenue
def get_total_delivered_revenue():
    query = text("""
        SELECT SUM(item_revenue)
        FROM gold.vw_sales_performance;
    """)

    with engine.connect() as connection:
        result = connection.execute(query)
        total_revenue = result.scalar_one()

    return total_revenue


# 8. Get revenue by product category
def get_revenue_by_category():
    query = text("""
        SELECT
            product_category_name_english,
            SUM(item_revenue) AS total_revenue
        FROM gold.vw_sales_performance
        GROUP BY product_category_name_english
        ORDER BY total_revenue DESC;
    """)

    with engine.connect() as connection:
        result = connection.execute(query)
        rows = result.fetchall()

    return rows


# 9. Get the number of delivered orders

# Get the total delivered-order count

# Get the number of delivered orders
def get_delivered_order_count():
    query = text("""
        SELECT COUNT(*)
        FROM gold.vw_delivery_performance
        WHERE order_status = 'delivered';
    """)

    with engine.connect() as connection:
        result = connection.execute(query)
        order_count = result.scalar_one()

    return order_count




# 10. Run verification when this file is executed directly
if __name__ == "__main__":
    try:
        print("VERIFYING PYTHON ANALYTICS")
        print("-" * 35)

        # Verify 1: Total revenue
        revenue = get_total_delivered_revenue()
        print("Total delivered-order revenue:", revenue)

        # Verify 2: Revenue by category
        category_revenue = get_revenue_by_category()
        print("\nTop 5 categories by revenue:")

        for category, amount in category_revenue[:5]:
            print(category, ":", amount)

        # Verify 3: Delivered-order count
        order_count = get_delivered_order_count()
        print("\nDelivered-order count:", order_count)

        print("\nVerification completed.")

    except Exception as error:
        print("\nAnalytics verification failed.")
        print("Error:", error)

    finally:
        engine.dispose()
