from pathlib import Path
import os

import pandas as pd
from dotenv import load_dotenv
from sqlalchemy import create_engine, text
from sqlalchemy.engine import URL

from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report
from sklearn.model_selection import train_test_split
from sklearn.pipeline import Pipeline


# 1. Find the project folder
PROJECT_ROOT = Path(__file__).resolve().parent.parent

# 2. Load database settings
load_dotenv(PROJECT_ROOT / ".env")

# 3. Read database configuration
db_host = os.getenv("DB_HOST")
db_port = os.getenv("DB_PORT")
db_name = os.getenv("DB_NAME")
db_user = os.getenv("DB_USER")
db_password = os.getenv("DB_PASSWORD")

if not all([db_host, db_port, db_name, db_user, db_password]):
    raise ValueError("Database settings are missing. Check your .env file.")

# 4. Create the database connection
connection_url = URL.create(
    drivername="postgresql+psycopg",
    username=db_user,
    password=db_password,
    host=db_host,
    port=int(db_port),
    database=db_name,
)

engine = create_engine(connection_url)

OUTPUT_FILE = (
    PROJECT_ROOT
    / "data"
    / "processed"
    / "review_sentiment_predictions.csv"
)


def load_reviews():
    """Load reviews that contain text and valid review scores."""

    query = """
        SELECT
            review_id,
            review_score,
            review_comment_message
        FROM silver.order_reviews
        WHERE review_comment_message IS NOT NULL
          AND TRIM(review_comment_message) <> ''
          AND review_score BETWEEN 1 AND 5;
    """

    with engine.connect() as connection:
        reviews = pd.read_sql_query(text(query), connection)

    return reviews


def assign_sentiment(score):
    """Create broad sentiment labels from review scores."""

    if score <= 2:
        return "Negative"
    elif score == 3:
        return "Neutral"
    else:
        return "Positive"


def main():
    try:
        # Load the review data
        reviews = load_reviews()

        print("Reviews with usable text:", len(reviews))

        # Create approximate labels from review scores
        reviews["sentiment"] = reviews["review_score"].apply(
            assign_sentiment
        )

        print("\nSentiment label distribution:")
        print(reviews["sentiment"].value_counts())

        # Separate review text and sentiment labels
        X = reviews["review_comment_message"].astype(str)
        y = reviews["sentiment"]

        # Split data for training and evaluation
        X_train, X_test, y_train, y_test = train_test_split(
            X,
            y,
            test_size=0.20,
            random_state=42,
            stratify=y,
        )

        # Convert text to numerical features and train the model
        model = Pipeline(
            [
                (
                    "tfidf",
                    TfidfVectorizer(
                        lowercase=True,
                        max_features=10000,
                        ngram_range=(1, 2),
                        min_df=2,
                    ),
                ),
                (
                    "classifier",
                    LogisticRegression(
                        max_iter=1000,
                        class_weight="balanced",
                        random_state=42,
                    ),
                ),
            ]
        )

        model.fit(X_train, y_train)

        # Evaluate on data not used for training
        predictions = model.predict(X_test)

        print("\nClassification report:")
        print(
            classification_report(
                y_test,
                predictions,
                zero_division=0,
            )
        )

        # Predict sentiment for all reviews with text
        reviews["predicted_sentiment"] = model.predict(X)

        # Save predictions
        OUTPUT_FILE.parent.mkdir(parents=True, exist_ok=True)
        reviews.to_csv(OUTPUT_FILE, index=False)

        print("\nPredictions saved to:", OUTPUT_FILE)

    finally:
        engine.dispose()


if __name__ == "__main__":
    main()