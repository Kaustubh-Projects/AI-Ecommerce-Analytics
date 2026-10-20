
import os
from pathlib import Path

import pandas as pd
from dotenv import load_dotenv
from sqlalchemy import create_engine, text
from sqlalchemy.engine import URL
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import silhouette_score

# Find the project root and load database settings.
project_folder = Path(__file__).resolve().parent.parent
load_dotenv(project_folder / ".env")

db_host = os.getenv("DB_HOST")
db_port = os.getenv("DB_PORT")
db_name = os.getenv("DB_NAME")
db_user = os.getenv("DB_USER")
db_password = os.getenv("DB_PASSWORD")

if not all([db_host, db_port, db_name, db_user, db_password]):
    raise ValueError("Database settings are missing. Check your .env file.")

# Connect to PostgreSQL.
connection_url = URL.create(
    drivername="postgresql+psycopg",
    username=db_user,
    password=db_password,
    host=db_host,
    port=int(db_port),
    database=db_name,
)

engine = create_engine(connection_url)


def get_customer_data():
    """Load customer RFM features from the Gold view."""
    query = text("""
        SELECT
            customer_unique_id,
            recency_days,
            frequency,
            monetary
        FROM gold.vw_customer_rfm
        ORDER BY customer_unique_id;
    """)

    with engine.connect() as connection:
        customers = pd.read_sql(query, connection)

    return customers


def find_best_cluster_count(scaled_features):
    """Compare cluster counts using a sample for silhouette scoring."""
    sample_size = min(3000, len(scaled_features))

    # Use a fixed random seed so evaluation is reproducible.
    sample = pd.DataFrame(scaled_features).sample(
        n=sample_size,
        random_state=42,
    ).to_numpy()

    best_cluster_count = None
    best_score = -1

    for cluster_count in range(2, 8):
        model = KMeans(
            n_clusters=cluster_count,
            random_state=42,
            n_init=10,
        )

        # Fit the candidate model on the sample.
        labels = model.fit_predict(sample)

        score = silhouette_score(sample, labels)

        print(
            f"{cluster_count} clusters — "
            f"sample silhouette score: {score:.4f}"
        )

        if score > best_score:
            best_score = score
            best_cluster_count = cluster_count

    return best_cluster_count, best_score


def main():
    print("K-MEANS CUSTOMER SEGMENTATION")
    print("-" * 40)

    # Load customer data.
    customers = get_customer_data()
    print("Customers loaded:", len(customers))

    # Select the three original RFM features.
    features = customers[
        ["recency_days", "frequency", "monetary"]
    ]

    # Scale features before applying K-means.
    scaler = StandardScaler()
    scaled_features = scaler.fit_transform(features)

    # Evaluate candidate cluster counts on a sample.
    best_cluster_count, best_score = find_best_cluster_count(
        scaled_features
    )

    print("\nSelected cluster count:", best_cluster_count)
    print("Sample silhouette score:", round(best_score, 4))

    # Train the final model on all customers.
    final_model = KMeans(
        n_clusters=best_cluster_count,
        random_state=42,
        n_init=10,
    )

    customers["cluster"] = final_model.fit_predict(scaled_features)

    # Save customer segmentation results.
    output_folder = project_folder / "data" / "processed"
    output_folder.mkdir(parents=True, exist_ok=True)

    output_file = output_folder / "customer_segments.csv"
    customers.to_csv(output_file, index=False)

    print(f"\nCustomer segments saved to: {output_file}")

    # Summarize each cluster using the original RFM values.
    cluster_summary = customers.groupby("cluster").agg(
        customer_count=("customer_unique_id", "count"),
        average_recency_days=("recency_days", "mean"),
        average_frequency=("frequency", "mean"),
        average_monetary=("monetary", "mean"),
    ).round(2)

    print("\nCustomer cluster summary:")
    print(cluster_summary)

    print("\nSegmentation completed.")


if __name__ == "__main__":
    try:
        main()
    except Exception as error:
        print("Segmentation failed:", error)
    finally:
        engine.dispose()