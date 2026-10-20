import pandas as pd
from pathlib import Path

from dotenv import load_dotenv
import os

from sqlalchemy import create_engine
from sqlalchemy.engine import URL

from sklearn.model_selection import train_test_split
from sklearn.pipeline import make_pipeline
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report, confusion_matrix

import joblib


# Find the project folder and load database settings.
project_folder = Path(__file__).resolve().parent.parent
load_dotenv(project_folder / ".env")


# Read database settings from .env.
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


def load_training_data():
    """Load the saved SQL training query into a Pandas DataFrame."""
    sql_file = (
        project_folder
        / "sql"
        / "12_build_inactivity_training_data.sql"
    )

    query = sql_file.read_text(encoding="utf-8")

    with engine.connect() as connection:
        data = pd.read_sql_query(query, connection)

    return data


def main():
    print("CUSTOMER INACTIVITY-RISK MODEL")
    print("-" * 40)

    # Load the customer features and labels.
    data = load_training_data()

    print("Customer records loaded:", len(data))

    # Select model inputs and the target label.
    feature_columns = [
        "recency_days",
        "frequency",
        "monetary",
    ]

    X = data[feature_columns]
    y = data["inactive_label"]

    print("\nLabel distribution:")
    print(y.value_counts().sort_index().rename(index={
        0: "Active",
        1: "Inactive",
    }))

    # Keep both classes represented in training and test sets.
    X_train, X_test, y_train, y_test = train_test_split(
        X,
        y,
        test_size=0.20,
        random_state=42,
        stratify=y,
    )

    # Scale the features and train a baseline classifier.
    model = make_pipeline(
        StandardScaler(),
        LogisticRegression(
            class_weight="balanced",
            max_iter=1000,
            random_state=42,
        ),
    )

    model.fit(X_train, y_train)

    # Evaluate predictions on records not used for training.
    predictions = model.predict(X_test)

    print("\nClassification report:")
    print(
        classification_report(
            y_test,
            predictions,
            labels=[0, 1],
            target_names=["Active", "Inactive"],
            zero_division=0,
        )
    )

    print("Confusion matrix (rows = actual, columns = predicted):")
    print("Class order: Active (0), Inactive (1)")
    print(confusion_matrix(y_test, predictions, labels=[0, 1]))

    # Save the trained model and its feature definitions.
    model_folder = project_folder / "models"
    model_folder.mkdir(parents=True, exist_ok=True)

    model_file = model_folder / "inactivity_risk_model.joblib"

    model_bundle = {
        "model": model,
        "feature_columns": feature_columns,
        "target_column": "inactive_label",
        "feature_cutoff": "2018-06-01",
        "outcome_window": "2018-06-01 to 2018-08-29",
        "labels": {
            0: "Active",
            1: "Inactive",
        },
    }

    joblib.dump(model_bundle, model_file)

    print("\nModel saved to:", model_file)
    print("Training and evaluation completed.")


if __name__ == "__main__":
    try:
        main()
    except Exception as error:
        print("Model training failed:", error)
    finally:
        engine.dispose()