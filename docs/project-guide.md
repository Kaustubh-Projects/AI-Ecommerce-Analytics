# AI-Powered E-Commerce Analytics Platform

## 1. Project Overview

The AI-Powered E-Commerce Analytics Platform is an end-to-end data analytics project built using the Brazilian Olist e-commerce dataset.

The project demonstrates how raw e-commerce data can be ingested, stored, transformed, analyzed, and presented through business intelligence dashboards, machine learning models, and an AI-powered question-answering interface.

### Business Objectives

- Analyze sales performance and delivered-order revenue.
- Understand customer purchasing behavior through RFM analysis and customer segmentation.
- Evaluate product categories and seller performance.
- Analyze delivery performance and customer satisfaction.
- Explore customer inactivity risk, review sentiment, and sales forecasting.
- Present business insights through Power BI dashboards.
- Allow users to ask supported business questions through a FastAPI endpoint powered by a large language model.

## 2. Technology Stack

| Technology | Purpose |
|---|---|
| Python | Data ingestion, analytics, machine learning, API and AI integration |
| Pandas and NumPy | Data handling and analysis |
| PostgreSQL | Structured data storage and analytical queries |
| SQL | Data validation, transformations, views and aggregations |
| Power BI | Interactive business intelligence dashboards |
| Scikit-learn | Machine learning and text classification |
| FastAPI | REST API development |
| Pydantic | API request validation |
| Groq API | Access to the language model used by the AI assistant |
| Git and GitHub | Version control and project management |

## 3. System Architecture

The project follows a layered data architecture.

1. **Source data:** Historical CSV files from the Brazilian Olist e-commerce dataset.
2. **Python ingestion:** Python scripts read the source data and load it into PostgreSQL Bronze tables.
3. **Bronze layer:** Stores the ingested source data.
4. **Silver layer:** Stores transformed and prepared data for analysis.
5. **Gold layer:** Contains analytical tables and views designed for business reporting.
6. **Analytics and machine learning:** Python scripts perform business analysis, customer segmentation, inactivity-risk analysis, review sentiment analysis and sales forecasting.
7. **Power BI:** Connects to analytical data to present business insights in dashboards.
8. **FastAPI:** Exposes KPI endpoints and an AI question-answering endpoint.
9. **AI assistant:** Retrieves supported business metrics through Python analytics functions and supplies that evidence, along with the user's question, to the Groq API.

### Data Flow

`Olist CSV files → Python ingestion → PostgreSQL Bronze → Silver → Gold → Analytics and Power BI`

The AI question-answering flow is:

`User question → FastAPI → Python analytics functions → Business metric evidence → Groq API → Answer returned by FastAPI`

The AI assistant currently uses a limited set of predefined metrics. It does not automatically query every table or answer every possible business question.

## 4. Data Source

The project uses the historical Brazilian Olist e-commerce dataset, which contains information about orders, customers, products, sellers, payments, reviews, order items, geolocation and product-category translations.

The historical dataset is used for analysis. Any simulated order-event functionality is separate from the original historical data and should not be described as a live connection to a real e-commerce platform.

## 5. PostgreSQL Database Architecture

The project uses PostgreSQL as its central database. Data is organized into three schemas: Bronze, Silver and Gold.

### 5.1 Bronze Schema

**Purpose:** Store data ingested from the original Olist CSV files.

The Bronze layer is the starting point of the database pipeline. Python ingestion scripts load the historical source data into Bronze tables.

The source datasets include customers, geolocation, order items, payments, reviews, orders, products, sellers and product-category translations.

### 5.2 Silver Schema

**Purpose:** Store data prepared for downstream analysis.

The Silver layer sits between raw ingestion and business reporting. SQL scripts create the Silver tables and load data from Bronze.

Validation queries are used to check the data across the Bronze and Silver layers.

### 5.3 Gold Schema

**Purpose:** Provide analytical data for business reporting.

The Gold layer contains analytical tables and views used by reporting and Python analytics functions.

The project includes these Gold views:

| View | Purpose |
|---|---|
| `vw_sales_performance` | Sales and revenue analysis |
| `vw_delivery_performance` | Delivery performance analysis |
| `vw_customer_rfm` | Customer recency, frequency and monetary analysis |
| `vw_product_performance` | Product performance analysis |
| `vw_seller_performance` | Seller performance analysis |
| `vw_customer_satisfaction_repurchase` | Customer satisfaction and repurchase analysis |

### 5.4 SQL Workflow

SQL scripts are organized in the repository's `sql/` folder and numbered to make the workflow easier to follow.

The existing scripts cover:

- Creating Bronze and Silver tables.
- Loading and validating Silver data.
- Creating and loading Gold analytical tables.
- Creating Gold views.
- Validating Gold data and Python analytics.
- Preparing data for customer segmentation, inactivity-risk analysis, review sentiment and sales forecasting.
- Creating and transforming order-event data and validating the event pipeline.

**Version-control rule:** Every SQL query created or updated during project work must be saved in the appropriate `.sql` file under `sql/`. Do not leave important queries only in pgAdmin's Query Tool history.

## 6. Data Validation and Quality

Data validation is part of the project workflow. The SQL scripts include checks for data across the Bronze and Silver layers, Gold analytical data, machine-learning inputs and order-event processing.

During initial dataset exploration, missing values were identified in several source datasets, including review titles and comments and product attributes.

These findings are documented as data-quality observations. A missing value does not automatically mean that a record should be deleted; the treatment should depend on the field and its analytical purpose.

## 7. Python Project Structure

The `python/` directory contains scripts for data ingestion, analysis, machine learning, API development and AI integration.

### 7.1 Data Ingestion and Pipeline

| File | Responsibility |
|---|---|
| `ingest_bronze.py` | Loads source CSV datasets into PostgreSQL Bronze tables. |
| `run_pipeline.py` | Coordinates the project's data pipeline steps. |
| `ingest_order_events.py` | Ingests order-event data into the database. |
| `simulate_order_events.py` | Generates simulated order events for testing the event pipeline. |

### 7.2 Data Inspection and Exploration

| File | Responsibility |
|---|---|
| `environment_check.py` | Checks aspects of the Python environment. |
| `inspect_dataset.py` | Inspects source datasets, their structure and data-quality characteristics. |
| `analyze_orders.ipynb` | Jupyter notebook for exploratory order-data analysis. |
| `analyze_orders.py` | Python script for order-data analysis. |

### 7.3 Analytics and Machine Learning

| File | Responsibility |
|---|---|
| `analytics.py` | Provides reusable analytical functions, including metrics used by the API and AI assistant. |
| `customer_segmentation.py` | Performs customer segmentation using clustering. |
| `inactivity_risk_model.py` | Trains and evaluates the customer inactivity-risk model. |
| `predict_inactivity_risk.py` | Runs inactivity-risk predictions. |
| `review_sentiment_analysis.py` | Performs review-text sentiment classification. |
| `sales_forecasting.py` | Performs sales forecasting and evaluates forecast performance. |

### 7.4 API and AI Integration

| File | Responsibility |
|---|---|
| `main.py` | Defines the FastAPI application and its endpoints. |
| `ai_assistant.py` | Retrieves supported business metrics and uses the Groq API to generate answers grounded in those metrics. |

### 7.5 Database Connection and Testing

| File | Responsibility |
|---|---|
| `test_db_connection.py` | Tests the PostgreSQL database connection. |
| `test_groq_api.py` *(repository root)* | Tests connectivity to the Groq API. |

## 8. Machine Learning Components

The project includes several machine-learning experiments.

### 8.1 Customer Segmentation

K-Means clustering is used to group customers based on selected customer features.

The recorded experiment used two clusters and achieved a silhouette score of approximately **0.7418**. This score measures cluster separation under the chosen feature preparation and clustering configuration; it does not by itself prove that the segments are commercially useful.

### 8.2 Customer Inactivity-Risk Model

The inactivity-risk model explores the identification of customers who may become inactive.

The recorded evaluation showed weak recall for the active class and very low precision (approximately 0.54 recall and 0.01 precision for that class). The model requires further evaluation and improvement before it could be considered suitable for production use.

### 8.3 Review Sentiment Analysis

The project uses TF-IDF text features and Logistic Regression to classify review sentiment. The experimental labels are derived from review scores, so they are proxy labels rather than independently verified sentiment annotations.

Recorded results:

- Accuracy: approximately 0.79
- Macro F1-score: approximately 0.67
- Neutral-class F1-score: approximately 0.31

The weaker neutral-class result indicates that performance should be assessed by class, rather than relying on accuracy alone.

### 8.4 Sales Forecasting

The forecasting experiment evaluates a simple baseline model.

Recorded results:

- MAE: approximately 68,365.41
- RMSE: approximately 78,642.62

These results are specific to the experiment's data preparation, forecast target and evaluation period. They should not be interpreted as evidence that the forecast is ready for operational decision-making.

## 9. Power BI Dashboards

The project includes a Power BI report saved as `AI_Ecommerce_Analytics.pbix` in the repository root.

The report contains four pages.

| Dashboard page | Business purpose |
|---|---|
| Executive Overview | Provides a high-level view of business performance and key metrics. |
| Customer Analytics | Supports analysis of customer behavior and customer-related metrics. |
| Delivery & Operations | Focuses on delivery performance and operational analysis. |
| Product & Seller Performance | Supports comparisons of product and seller performance. |

The dashboards convert analytical data into visual reports that help users explore business performance.

The report is a Power BI Desktop file. It should not be described as publicly published or automatically refreshed unless those capabilities are configured separately.

## 10. FastAPI Application

The FastAPI application is defined in `python/main.py`.

It exposes endpoints for basic API information, business KPIs and AI-powered question answering.

### 10.1 API Endpoints

| Method | Endpoint | Purpose |
|---|---|---|
| `GET` | `/` | Returns basic API information. |
| `GET` | `/kpis/summary` | Returns the supported summary KPI metrics. |
| `GET` | `/kpis/categories` | Returns category-level revenue information. |
| `POST` | `/ai/ask` | Accepts a business question and returns an AI-generated answer based on the supported analytical evidence. |

### 10.2 Running the API

Activate the project's virtual environment in PowerShell, then start the application from the repository root:

```powershell
.\.venv\Scripts\Activate.ps1
python -m uvicorn main:app --app-dir python --reload
```

Open the interactive API documentation in your browser:

`http://127.0.0.1:8000/docs`

Use the Swagger interface to inspect the endpoints and test requests.

The API runs locally with this configuration. It should not be described as publicly deployed.

## 11. Generative AI Assistant

The AI assistant is implemented in `python/ai_assistant.py` and is exposed through the FastAPI application.

### 11.1 How It Works

1. A user submits a question to `POST /ai/ask`.
2. FastAPI validates the request.
3. The assistant retrieves supported business metrics using existing Python analytics functions.
4. The question and selected metric evidence are sent to the Groq API.
5. The language model generates a response using the supplied evidence.
6. FastAPI returns the answer to the user.

The current implementation retrieves delivered revenue, delivered-order count and the top five product categories by revenue. It does not automatically retrieve every metric in the database.

### 11.2 Supported Questions

Examples of questions that fit the current implementation include:

- What is the total delivered revenue?
- How many orders were delivered?
- Which product categories generated the most revenue?
- What is the revenue of the highest-revenue category among the returned top five?

Questions about monthly revenue trends, individual product rankings, seller rankings, the causes of a sales decline, or the causes of delivery delays require additional analytical functions and supporting data.

The assistant should not invent explanations when the supplied data does not establish an answer.

### 11.3 API Configuration and Security

The Groq API key is stored in the local `.env` file under the `GROQ_API_KEY` environment variable.

Security rules:

- Never commit `.env` to GitHub.
- Never place API keys directly in Python source code.
- Never include API keys in screenshots, logs or public documentation.
- Keep `.env` excluded through `.gitignore`.
- Be aware that the selected question and business metrics are sent to an external API provider when the assistant makes a request.

The AI assistant uses a language model to generate responses; it is not itself a machine-learning model trained on the Olist dataset.

## 12. Key Analytical Results

The following are recorded results from the project's current analysis.

| Metric | Recorded result |
|---|---:|
| Total delivered revenue | BRL 13,221,498.11 |
| Delivered orders | 96,478 |
| Highest-revenue category in the recorded analysis | Health & Beauty |
| Health & Beauty revenue | BRL 1,233,131.72 |
| Customer segmentation silhouette score | 0.7418 |
| Inactivity-risk model active-class recall | Approximately 0.54 |
| Inactivity-risk model active-class precision | Approximately 0.01 |
| Review sentiment classification accuracy | Approximately 0.79 |
| Review sentiment macro F1-score | Approximately 0.67 |
| Review sentiment neutral-class F1-score | Approximately 0.31 |
| Sales forecasting baseline MAE | Approximately 68,365.41 |
| Sales forecasting baseline RMSE | Approximately 78,642.62 |

These values reflect the recorded experiments and analyses. Machine-learning results depend on the data preparation, selected features, evaluation method and experiment configuration.

## 13. Project Limitations

The current project has the following limitations.

1. **Historical dataset:** The primary business analysis is based on historical Olist data, not a live production e-commerce database.
2. **Limited AI context:** The AI assistant retrieves a predefined set of metrics. It cannot answer arbitrary questions about every table, time period, product or seller.
3. **External AI dependency:** The AI assistant depends on the Groq API, network connectivity, API access and the selected model's availability.
4. **Model quality:** The inactivity-risk model has weak precision for the evaluated active class. The sentiment model performs less effectively on neutral reviews.
5. **Forecasting baseline:** The recorded forecasting metrics come from a baseline experiment and do not establish production forecasting reliability.
6. **Simulated events:** Simulated order events are not equivalent to real-time events from a live business system.
7. **Deployment:** The API is currently configured for local execution. Public deployment, production authentication, monitoring and operational hardening are separate tasks.
8. **Dashboard distribution:** A Power BI Desktop report is not the same as a publicly hosted, automatically refreshing dashboard.

## 14. Future Enhancements

Potential improvements include:

- Add analytical functions for monthly revenue, product rankings, seller performance and delivery delays.
- Expand the AI assistant's supported questions using verified SQL queries and controlled analytical functions.
- Improve customer inactivity-risk modelling through feature engineering, class-imbalance handling and appropriate evaluation metrics.
- Improve neutral-review classification and evaluate the model using independently annotated sentiment data.
- Compare forecasting methods against the baseline using a time-aware evaluation strategy.
- Add automated data-quality checks and pipeline logging.
- Introduce scheduled refreshes and monitoring.
- Deploy the API to a suitable cloud environment with secure secret management.
- Add authentication, rate limiting, input controls and operational error monitoring before exposing the API publicly.
- Explore a controlled CSV-upload workflow with schema validation, data-quality checks and safe ingestion.

These are proposed enhancements, not claims that the features are already implemented.

## 15. Setup Requirements

The project was developed in a Windows environment using Python, PostgreSQL, Power BI Desktop and Git.

Before running it, prepare:

- Python 3.11 or a compatible project-tested version.
- PostgreSQL and the `ecommerce_analytics` database.
- The project's virtual environment and required Python packages.
- The historical Olist CSV files in the expected local data directory.
- A valid `.env` configuration for database access and the Groq API key when using the AI assistant.
- Power BI Desktop to open and explore `AI_Ecommerce_Analytics.pbix`.
- Git to review the repository and manage changes.

**Security:** Use your own local `.env` configuration. Never copy real credentials into this guide or commit them to version control.

## 16. How to Run the Project

Run the project components in the appropriate order. The commands below assume a Windows PowerShell terminal opened at the repository root.

### Step 1: Activate the Virtual Environment

```powershell
.\.venv\Scripts\Activate.ps1
```

### Step 2: Configure Environment Variables

Create or update the local `.env` file with the database connection settings and Groq API key required by the project.

Do not commit `.env` to GitHub.

### Step 3: Start PostgreSQL

Ensure the PostgreSQL service is running and that the `ecommerce_analytics` database is available.

### Step 4: Prepare the Database

The SQL scripts in the `sql/` directory create the database schemas and tables, load analytical data, create views and validate the pipeline.

Run the scripts in their intended dependency order. Review each script before execution, especially if it creates, replaces or reloads database objects.

Do not rerun ingestion or transformation steps against existing data without understanding whether they append, replace or otherwise modify existing records.

### Step 5: Run Data Ingestion and the Pipeline

The project includes `python/ingest_bronze.py` for Bronze ingestion and `python/run_pipeline.py` for pipeline orchestration.

Before running either script, check its current implementation and expected command-line arguments. The complete pipeline should be run only after the database and source files are configured correctly.

### Step 6: Run Analytics and Machine Learning

The individual analysis scripts are in the `python/` directory. Examples include:

- `customer_segmentation.py`
- `inactivity_risk_model.py`
- `predict_inactivity_risk.py`
- `review_sentiment_analysis.py`
- `sales_forecasting.py`

Run the relevant scripts according to their data and model dependencies.

### Step 7: Start FastAPI

From the repository root, with the virtual environment activated:

```powershell
python -m uvicorn main:app --app-dir python --reload
```

Open the Swagger documentation:

`http://127.0.0.1:8000/docs`

Use the available endpoints to test the API.

### Step 8: Use the AI Assistant

In Swagger, open `POST /ai/ask`, select **Try it out**, and submit a supported business question.

For example:

```json
{
  "question": "What is the total delivered revenue?"
}
```

The answer depends on the database, analytics functions, environment configuration and Groq API access being available.

### Step 9: Open the Power BI Report

Open `AI_Ecommerce_Analytics.pbix` in Power BI Desktop.

If Power BI requests database credentials or connection details, use the correct local configuration. Refresh the report only when the data source is available and the refresh operation is configured correctly.

## 17. Does the Project Support External Data Uploads?

**Current status: A general-purpose external CSV upload feature has not been established as implemented.**

The project supports ingestion of its configured historical datasets and has order-event ingestion and simulation scripts. These features do not, by themselves, establish that a user can upload an arbitrary CSV through a web interface or API.

To support general external uploads, the project would need an explicit workflow, such as:

1. Accept a CSV file through an upload endpoint or interface.
2. Validate the file type, columns, data types and required fields.
3. Check for missing values, duplicates and invalid records.
4. Transform the data into the expected database structure.
5. Load it into the appropriate database layer safely.
6. Report validation errors and ingestion results.

This workflow is a proposed enhancement unless an existing implementation is verified in the codebase.

## 18. Historical Analytics vs. Order-Event Processing

The project contains two related but distinct data workflows. They serve different purposes and should not be treated as one combined reporting pipeline.

### 18.1 Historical E-Commerce Analytics

The historical analytics workflow uses the original Brazilian Olist dataset.

It supports:

- Sales and delivered-revenue analysis.
- Customer analytics and segmentation.
- Product and seller performance analysis.
- Delivery performance and customer satisfaction analysis.
- Machine-learning experiments.
- Power BI dashboards.
- The currently implemented KPI endpoints and AI assistant.

The existing historical results are based on the historical dataset and the relevant analytical logic. They do not change simply because the order-event simulator runs.

### 18.2 Simulated and Manually Supplied Order Events

The order-event workflow demonstrates how incoming event records can be generated or supplied, ingested into PostgreSQL, and processed through dedicated event-related database objects.

The database contains order-event tables in the Bronze and Silver schemas, and a Gold order-event activity view is available.

The event records include fields such as event ID, order ID, customer ID, order status, purchase timestamp, event source and source file.

The event sources visible during database inspection included:

- `simulated` - artificially generated order events.
- `manual_csv` - records originating from manually supplied CSV data.

This workflow demonstrates event ingestion and processing. Simulated records are not genuine transactions from the original Olist dataset.

### 18.3 Relationship Between the Two Workflows

The presence of simulated events in PostgreSQL does not automatically include those events in the existing historical sales calculations or Power BI dashboards.

The current project should therefore be described as having a historical analytics workflow and a separate order-event processing workflow.

Combining the workflows for unified sales reporting would require an explicit integration design, including compatible data structures, source identification, appropriate transformations, and updates to the relevant analytical queries or views. Power BI would also need to use the integrated data and refresh accordingly.

This integration is not assumed to be implemented.

### 18.4 Current AI Assistant Scope

The AI assistant retrieves a predefined set of historical business metrics through Python analytics functions. Its current evidence includes delivered revenue, delivered-order count and the top five product categories by revenue.

The assistant does not currently receive a simulated-event count as part of that evidence. Consequently, it cannot reliably answer questions such as "How many simulated order events arrived?" using its existing analytical context.

A successful API response does not mean that the requested metric is available. The answer must be supported by the evidence supplied to the assistant.

### 18.5 Architectural Decision

**Decision:** Keep the historical analytics and order-event processing workflows distinct in the current implementation.

**Reason:** Each workflow demonstrates a different capability. Historical analytics supports business reporting and machine-learning experiments, while event processing demonstrates how incoming order activity can be ingested and stored.

**Consequence:** Running the simulator does not, by itself, change the historical revenue totals, existing Gold sales views, or Power BI dashboards.

**Future option:** If unified reporting becomes a requirement, integrate the event data deliberately and validate the resulting metrics before presenting combined outputs.