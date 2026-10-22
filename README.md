# AI-Powered E-Commerce Analytics Platform

An end-to-end e-commerce analytics project combining **Python, SQL, PostgreSQL, Power BI, machine learning, FastAPI, and Generative AI** to analyze historical e-commerce data, explore customer behavior, monitor operational performance, and generate evidence-based business insights.

## 1. Project Overview

This project uses the public Brazilian E-Commerce dataset by Olist to build a layered analytics platform. It transforms historical transaction data into business-ready analytical models, interactive Power BI dashboards, and Python-based analytical experiments.

The platform also includes a separate pipeline for simulated and manually supplied order-event CSV files, a FastAPI application for exposing analytics, and a Generative AI assistant that answers natural-language questions using selected business metrics.

The project demonstrates an end-to-end analytics workflow, from data ingestion and SQL transformations to visualization, predictive analytics, and AI-assisted business reporting.

**Project status:** Core historical analytics pipeline, Power BI dashboards, machine-learning experiments, order-event ingestion workflow, FastAPI endpoints, and initial AI assistant implemented and locally tested. Documentation and final validation are ongoing.

## 2. Business Objectives

### Sales Analytics
- Analyze delivered revenue and order performance.
- Identify high-revenue product categories.
- Explore monthly revenue trends.
- Compare product and seller performance.

### Customer Analytics
- Analyze customer purchasing behavior.
- Identify one-time and repeat customers.
- Perform Recency, Frequency, and Monetary (RFM) analysis.
- Experiment with customer segmentation and inactivity-risk prediction.

### Operational Analytics
- Analyze delivery duration and punctuality.
- Evaluate seller delivery performance.
- Explore late deliveries and operational patterns.

### Customer Experience
- Analyze review scores and satisfaction categories.
- Experiment with NLP-based review sentiment classification.
- Explore customer satisfaction and repurchase relationships.

### Forecasting and AI
- Evaluate a baseline for monthly revenue forecasting.
- Build a Generative AI assistant for selected business questions.
- Return natural-language answers grounded in retrieved business metrics.
- Identify when the available evidence is insufficient to answer a question.

### Data Engineering
- Ingest historical CSV files into PostgreSQL.
- Transform data through Bronze, Silver, and Gold layers.
- Validate data quality and relationships.
- Demonstrate incremental ingestion using simulated order events.
- Maintain SQL scripts and technical decisions under version control.

## 3. Technology Stack

| Area | Technologies |
|---|---|
| Programming | Python |
| Data manipulation | Pandas, NumPy |
| Database | PostgreSQL |
| Query language | SQL |
| Database integration | SQLAlchemy, Psycopg 3 |
| Business intelligence | Power BI, Power Query, DAX |
| Machine learning | Scikit-learn |
| NLP | TF-IDF, Logistic Regression |
| API development | FastAPI, Pydantic |
| Generative AI | Groq API, `openai/gpt-oss-120b` |
| Version control | Git, GitHub |
| Configuration | `python-dotenv` |

## 4. System Architecture

### 4.1 Historical Analytics Pipeline

```text
Historical Olist CSV Files
           |
           v
Python Batch Ingestion
           |
           v
PostgreSQL - Bronze
           |
           v
SQL Transformations
           |
           v
PostgreSQL - Silver
           |
           v
PostgreSQL - Gold
(Fact Tables, Dimension Tables,
and Analytical Views)
           |
           +----------------------+
           |                      |
           v                      v
       Power BI             Python Analytics
                                  |
                                  v
                         ML / NLP / Forecasting
```

### 4.2 Incoming Order-Event Pipeline

```text
Manual Event CSV / Event Simulator
                |
                v
        Python Event Ingestion
                |
                v
       Bronze: order_events
                |
                v
       SQL Transformation
                |
                v
       Silver: order_events
                |
                v
     Gold: vw_order_event_activity
```

The order-event workflow is separate from historical sales analytics. Simulated events do not automatically update historical revenue metrics or the existing historical Power BI dashboards.

### 4.3 API and Generative AI

```text
User Question
     |
     v
FastAPI
     |
     v
Python AI Assistant
     |
     +----------------------+
     |                      |
     v                      v
Existing Analytics       Groq API
Functions                (LLM)
     |                      |
     +----------+-----------+
                |
                v
       Natural-Language Answer
```

The AI assistant retrieves selected aggregate metrics from the existing analytics layer and supplies them to the language model as supporting context. It does not have unrestricted access to every database table or business metric.

## 5. Data Sources

### Historical Olist Dataset

The project uses nine CSV datasets from the public Brazilian E-Commerce dataset by Olist, covering customers, orders, order items, payments, reviews, products, sellers, geolocation, and product-category translations.

The historical data supports the initial data engineering pipeline, business analysis, dashboard development, and machine-learning experiments.

### Simulated Order Events

A Python event simulator generates synthetic order-event CSV files for testing ingestion and transformation workflows.

The events are synthetic and do not represent actual transactions from a live company.

### Manual CSV Input

The implemented manual CSV workflow supports incoming order-event files with the expected event schema.

**General-purpose uploads of arbitrary datasets are not currently implemented.** Supporting unrelated CSV structures requires additional schema mapping, validation, transformation, and integration logic.

## 6. PostgreSQL Data Model

The project uses one PostgreSQL database, `ecommerce_analytics`, with three schemas.

| Schema | Responsibility |
|---|---|
| `bronze` | Source-faithful historical data and incoming event records |
| `silver` | Typed, standardized, and validated data |
| `gold` | Business-ready fact tables, dimension tables, and analytical views |

### Bronze Layer

- Contains nine historical source tables.
- Preserves source values and ingestion metadata.
- Tracks ingestion attempts through `bronze.ingestion_batches`.
- Uses SHA-256 file fingerprints to detect previously loaded file contents.
- Uses chunk-based ingestion and per-file transaction handling.
- Avoids silently removing source duplicates.

### Silver Layer

- Converts source values into appropriate database types.
- Applies SQL transformations and documented data-quality rules.
- Enforces validated primary-key and foreign-key relationships.
- Preserves source metadata and records `silver_processed_at`.
- Uses composite or generated keys where source identifiers are not unique.

### Gold Layer

The Gold layer contains four dimension tables:

- `gold.dim_customers`
- `gold.dim_products`
- `gold.dim_sellers`
- `gold.dim_date`

It also contains four fact tables:

- `gold.fact_orders`
- `gold.fact_order_items`
- `gold.fact_payments`
- `gold.fact_reviews`

Six historical analytical views provide reusable business queries:

1. `gold.vw_sales_performance`
2. `gold.vw_delivery_performance`
3. `gold.vw_customer_rfm`
4. `gold.vw_product_performance`
5. `gold.vw_seller_performance`
6. `gold.vw_customer_satisfaction_repurchase`

The separate event workflow provides `gold.vw_order_event_activity`.

## 7. Power BI Dashboards

The Power BI report contains four implemented pages.

| Dashboard | Purpose |
|---|---|
| Executive Overview | Revenue, order counts, category performance, and monthly revenue trends |
| Customer Analytics | Repeat purchasing, RFM segments, satisfaction, and repurchase analysis |
| Delivery & Operations | Delivered orders, delivery punctuality, average delivery duration, and delivery rate |
| Product & Seller Performance | Category revenue, seller revenue, delivery volume, and late-order analysis |

The dashboards use historical analytical data. Automatic refresh and integration of simulated event data into historical sales reporting are not currently implemented.

## 8. Python Analytics and Machine Learning

The project includes four analytical experiments.

### Customer Segmentation

K-Means clustering was used to explore customer groups based on customer-level analytical features.

- Selected cluster count: 2
- Recorded silhouette score: approximately 0.7418

The result is specific to the selected experiment and is not a universal segmentation standard.

### Customer Inactivity-Risk Prediction

A Logistic Regression pipeline uses StandardScaler and customer recency, frequency, and monetary features.

The target is highly imbalanced, and the current model has weak active-class performance. It remains an experimental baseline and is not suitable for production customer-retention decisions.

### Review Sentiment Analysis

The sentiment baseline uses TF-IDF and Logistic Regression. Review scores are used to derive the sentiment labels:

- Scores 1–2: Negative
- Score 3: Neutral
- Scores 4–5: Positive

The recorded accuracy is approximately 0.79, with a neutral-class F1-score of approximately 0.31. Since labels are derived from review scores rather than independent human annotations, these results do not establish human-level sentiment accuracy.

### Monthly Revenue Forecasting

A simple baseline forecasts monthly revenue using the last observed training-month value.

The recorded evaluation uses 19 months for training and five months for testing:

- MAE: approximately R$68,365.41
- RMSE: approximately R$78,642.62

The small test window limits the strength of the evaluation. The historical dataset ends in 2018, so the results do not validate forecasts for current business conditions.

## 9. FastAPI and Generative AI Assistant

The FastAPI application exposes four endpoints.

| Method | Endpoint | Purpose |
|---|---|---|
| GET | `/` | Root endpoint |
| GET | `/kpis/summary` | Summary business KPIs |
| GET | `/kpis/categories` | Category revenue information |
| POST | `/ai/ask` | Natural-language business questions |

Interactive API documentation is available through Swagger UI at `/docs` when the application is running locally.

### AI Assistant Capabilities

The current assistant retrieves:

- Total delivered item revenue.
- Delivered order count.
- The top five product categories by revenue.

It sends the user's question and these selected aggregate metrics to the Groq API using the `openai/gpt-oss-120b` model.

The integration uses Python's built-in `urllib.request` rather than an additional AI SDK. Pydantic validates incoming questions.

### Example Question

> What is the highest-selling product category?

The assistant can use the supplied category-revenue context to identify the highest-revenue category among the retrieved results.

### Current Limitations

- The assistant can answer only questions supported by the metrics its analytics functions retrieve.
- It cannot reliably answer arbitrary monthly-trend, individual-product, seller-ranking, or customer-risk questions without additional data retrieval and analytics functions.
- It should acknowledge insufficient evidence instead of inventing metrics or causes.
- It requires internet access and an available external AI service.
- Local endpoint tests do not establish production readiness.

The current implementation sends selected aggregate metrics and the user's question to the provider. Raw customer review text is not sent by this assistant.

## 10. Selected Historical Results

The initial Bronze ingestion recorded the following row counts.

| Dataset | Rows |
|---|---:|
| Customers | 99,441 |
| Geolocation | 1,000,163 |
| Order items | 112,650 |
| Payments | 103,886 |
| Reviews | 99,224 |
| Orders | 99,441 |
| Products | 32,951 |
| Sellers | 3,095 |
| Category translation | 71 |
| **Total** | **1,758,922** |

Selected historical business results include:

| Metric | Recorded result |
|---|---:|
| Delivered orders | 96,478 |
| Delivered item revenue, excluding freight | R$13,221,498.11 |
| Highest-revenue category in the recorded analysis | `health_beauty` |
| Revenue for `health_beauty` | R$1,233,131.72 |

These figures describe the historical Olist dataset and the project's recorded analysis. They are not current 2026 business performance figures.

Selected row counts and metric reconciliations were validated during development. Validation does not prove that every business rule or interpretation is correct.

## 11. Repository Structure

```text
AI-Ecommerce-Analytics/
|
|-- docs/
|   |-- architecture-decisions.md
|   |-- ai-assistant-questions.md
|   |-- learning/
|       |-- project-learning.md
|
|-- models/
|
|-- python/
|   |-- ai_assistant.py
|   |-- analytics.py
|   |-- customer_segmentation.py
|   |-- environment_check.py
|   |-- inactivity_risk_model.py
|   |-- ingest_bronze.py
|   |-- ingest_order_events.py
|   |-- inspect_dataset.py
|   |-- main.py
|   |-- predict_inactivity_risk.py
|   |-- review_sentiment_analysis.py
|   |-- run_pipeline.py
|   |-- sales_forecasting.py
|   |-- simulate_order_events.py
|
|-- screenshots/
|
|-- sql/
|   |-- 01_create_bronze_tables.sql
|   |-- 02_create_silver_tables.sql
|   |-- 03_load_silver_tables.sql
|   |-- ...
|   |-- 18_validate_order_event_pipeline.sql
|
|-- .env                 # Local secrets; not committed
|-- .gitignore
|-- AI_Ecommerce_Analytics.pbix
|-- README.md
|-- test_groq_api.py
```

The repository also contains additional analysis scripts and notebooks. The tree above highlights the principal components rather than listing every file.

## 12. Setup and Running Locally

### Prerequisites

Install or configure:

- Python 3.11 or a compatible Python environment.
- PostgreSQL and pgAdmin 4.
- Git.
- Power BI Desktop for dashboard viewing.
- A Groq API key for the AI assistant.

### Step 1: Clone the Repository

```bash
git clone https://github.com/kalekaustubh09-commits/AI-Ecommerce-Analytics.git
cd AI-Ecommerce-Analytics
```

### Step 2: Create and Activate a Virtual Environment

On Windows PowerShell:

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
```

Install the project's required Python dependencies. Use the dependency versions documented or configured in the repository rather than assuming all packages are interchangeable across versions.

### Step 3: Configure PostgreSQL

Create or configure the `ecommerce_analytics` database. Apply the SQL scripts in the required dependency order from the `sql/` directory.

The historical pipeline requires the nine Olist CSV files to be available in the expected local data location. Check the ingestion script's configured paths before running it.

### Step 4: Configure Environment Variables

Create a local `.env` file using the variable names expected by the Python code.

At minimum, the AI assistant requires:

```text
GROQ_API_KEY=your_groq_api_key
```

Configure the database connection variables according to the application's database configuration.

**Never commit `.env` or expose API keys in source code, screenshots, or public documentation.**

### Step 5: Run the Relevant Workflow

Use the scripts and SQL files corresponding to the workflow you want to execute:

- Historical CSV ingestion: `python/ingest_bronze.py`
- Historical analytics: `python/analytics.py`
- Incoming order-event workflow: `python/run_pipeline.py`
- AI API application: start the FastAPI application using the project's configured entry point.

For the API, the local Swagger interface is available at:

```text
http://127.0.0.1:8000/docs
```

The API and AI assistant require a valid local database configuration. The AI assistant also requires a valid Groq API key and internet connectivity.

The exact execution order depends on the database setup and the component being run. Review the corresponding script and configuration before executing it.

## 13. Data Quality and Security

The project follows these principles:

- Preserve source data in Bronze for traceability.
- Validate data types and relationships before relying on downstream analytics.
- Document duplicate-handling policies rather than silently deleting records.
- Avoid fabricating missing values.
- Keep historical observations distinct from simulated events.
- Save SQL queries in version-controlled `.sql` files under `sql/`.
- Keep secrets and local environment files out of Git.
- Treat model results as experimental until their performance is adequately evaluated.
- Do not claim that data ingestion, refresh, or model retraining is automatic unless that workflow has been implemented and tested.

## 14. Known Limitations

The platform is a learning and portfolio project, not a production-ready enterprise analytics system.

Current limitations include:

- Historical data is not current operational data.
- General-purpose CSV uploads with automatic schema mapping are not implemented.
- Simulated events do not represent real production transactions.
- Incoming events do not automatically update historical sales metrics.
- Power BI refresh automation is not implemented.
- Machine-learning models require stronger evaluation before practical deployment.
- The AI assistant supports only the metrics retrieved by its current analytics functions.
- Authentication, rate limiting, production monitoring, and deployment security require further work.

## 15. Future Enhancements

Potential improvements include:

- General-purpose CSV ingestion with configurable schema mapping and validation.
- Controlled reprocessing of changed source files.
- More comprehensive automated data-quality testing.
- Additional SQL analytics for monthly trends, product rankings, seller performance, and delivery causes.
- Improved customer-risk and sentiment models.
- Stronger forecasting models with larger evaluation windows.
- Integration of additional validated metrics into the AI assistant.
- Scheduled ingestion, refresh orchestration, and monitoring.
- Authentication, rate limiting, and API security.
- Cloud deployment and production-oriented operational practices.
- Systematic evaluation of AI responses for accuracy and unsupported claims.

These items are future enhancements unless separately implemented and tested.

## 16. Project Documentation

Additional technical documentation is available in the repository:

- **Architecture decisions:** `docs/architecture-decisions.md`
- **Learning journal:** `docs/learning/project-learning.md`
- **AI assistant guide:** `docs/ai-assistant-questions.md`
- **SQL scripts and validation:** `sql/`
- **Project screenshots:** `screenshots/`

## 17. Conclusion

This project demonstrates an end-to-end analytics workflow using historical e-commerce data, PostgreSQL, SQL, Python, Power BI, machine learning, FastAPI, and Generative AI.

Its main focus is building traceable data pipelines, reusable business analytics, interactive dashboards, and an AI assistant that uses selected business metrics as evidence.

The project documents not only its implemented capabilities but also the limitations and additional work required before the platform could be used in a production environment.