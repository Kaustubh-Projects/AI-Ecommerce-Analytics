from pathlib import Path

import pandas as pd
import joblib


# Locate the project and model files.
project_folder = Path(__file__).resolve().parent.parent

model_file = (
    project_folder
    / "models"
    / "inactivity_risk_model.joblib"
)

input_file = (
    project_folder
    / "data"
    / "processed"
    / "new_customers_for_prediction.csv"
)

output_file = (
    project_folder
    / "data"
    / "processed"
    / "inactivity_risk_predictions.csv"
)


def main():
    print("CUSTOMER INACTIVITY-RISK PREDICTIONS")
    print("-" * 40)

    # Load the saved model bundle.
    model_bundle = joblib.load(model_file)
    model = model_bundle["model"]
    feature_columns = model_bundle["feature_columns"]

    # Load new customer records.
    customers = pd.read_csv(input_file)

    # Check required columns.
    missing_columns = [
        column
        for column in feature_columns
        if column not in customers.columns
    ]

    if missing_columns:
        raise ValueError(
            f"Missing required columns: {missing_columns}"
        )

    # Check that the model inputs are numeric and complete.
    features = customers[feature_columns].apply(
        pd.to_numeric,
        errors="raise",
    )

    if features.isnull().any().any():
        raise ValueError("Input features contain missing values.")

    # Predict class and estimated probability.
    customers["predicted_label"] = model.predict(features)

    probabilities = model.predict_proba(features)
    inactive_class_index = list(
        model.classes_
    ).index(1)

    customers["estimated_inactivity_probability"] = (
        probabilities[:, inactive_class_index].round(4)
    )

    # Add readable labels.
    customers["predicted_status"] = customers[
        "predicted_label"
    ].map({
        0: "Active",
        1: "Inactive",
    })

    # Save the predictions.
    output_file.parent.mkdir(parents=True, exist_ok=True)
    customers.to_csv(output_file, index=False)

    print("\nPrediction results:")
    print(customers.to_string(index=False))

    print("\nPredictions saved to:")
    print(output_file)


if __name__ == "__main__":
    main()