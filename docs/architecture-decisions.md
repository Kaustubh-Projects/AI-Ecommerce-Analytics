# Architecture Decision Log

## 1. Project Overview

The **AI-Powered E-Commerce Analytics Platform** is an end-to-end analytics project built using historical e-commerce data. It combines data ingestion, SQL transformations, business intelligence, machine-learning experiments, API development, and a generative AI assistant.

This document describes the final implemented architecture, the main technology decisions, and the system's current limitations.

## 2. Architecture Overview

The platform consists of three connected components: the historical analytics pipeline, the incoming order-event pipeline, and the API/AI application.

### 2.1 Historical Analytics Pipeline

```text
Olist Historical CSV Files
           |
           v
Python Ingestion (Pandas)
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
           +-------------------+
           |                   |
           v                   v
        Power BI         Python Analytics
                              |
                              v
                     ML / NLP / Forecasting
```

### 2.2 Incoming Order-Event Pipeline

```text
Manual Event CSV / Event Simulator
                |
                v
        Python Ingestion
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

This pipeline demonstrates simulated and manually supplied order-event ingestion. It remains separate from historical sales analytics; incoming events do not automatically update historical revenue metrics.

### 2.3 API and Generative AI

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

The AI assistant uses selected business metrics retrieved by existing Python analytics functions. It does not have unrestricted access to every database table or metric.

## 3. Technology Stack

| Technology | Responsibility |
|---|---|
| Python and Pandas | CSV ingestion, orchestration, analytics, and data handling |
| PostgreSQL | Central database, transformations, constraints, and analytical queries |
| SQL | Data-layer transformations, fact/dimension modeling, and business views |
| Power BI and DAX | Interactive dashboards and business reporting |
| Scikit-learn | Customer segmentation, inactivity-risk experiments, and sentiment analysis |
| TF-IDF and Logistic Regression | Review sentiment classification baseline |
| FastAPI and Pydantic | API endpoints and request validation |
| Groq API | Generative AI responses using selected business metrics |
| Git and GitHub | Version control and project documentation |

The project uses Python's built-in `urllib.request` for the Groq API call rather than an additional AI SDK.

## 4. PostgreSQL Data Architecture

The project uses one PostgreSQL database, `ecommerce_analytics`, with three schemas.

| Schema | Purpose |
|---|---|
| `bronze` | Source-faithful historical data and incoming event records |
| `silver` | Cleaned, typed, standardized, and validated data |
| `gold` | Business-ready fact tables, dimension tables, and analytical views |

### Bronze

- Contains nine source tables corresponding to the Olist CSV files.
- Preserves source values and ingestion metadata.
- Uses `source_file`, `ingested_at`, and ingestion batch tracking.
- Uses SHA-256 file fingerprints to identify previously loaded file contents.
- Avoids silently removing source duplicates.

### Silver

- Converts source values into appropriate database types.
- Applies documented transformations and data-quality rules.
- Uses primary keys and validated foreign keys where appropriate.
- Preserves source lineage and records `silver_processed_at`.
- Uses composite or generated primary keys when source identifiers are not unique.

Missing values are preserved unless a documented transformation justifies changing them. Missing information is not fabricated.

### Gold

The Gold schema uses a fact-and-dimension model.

**Dimension tables**
- `gold.dim_customers`
- `gold.dim_products`
- `gold.dim_sellers`
- `gold.dim_date`

**Fact tables**
- `gold.fact_orders`
- `gold.fact_order_items`
- `gold.fact_payments`
- `gold.fact_reviews`

The six historical analytical views are:

1. `gold.vw_sales_performance`
2. `gold.vw_delivery_performance`
3. `gold.vw_customer_rfm`
4. `gold.vw_product_performance`
5. `gold.vw_seller_performance`
6. `gold.vw_customer_satisfaction_repurchase`

The separate event pipeline also provides `gold.vw_order_event_activity`.

## 5. Key Architecture Decisions

### 5.1 SQL and Python Responsibilities

PostgreSQL SQL is used for relational transformations, joins, aggregations, constraints, data modeling, and reusable business queries.

Python is used for ingestion, orchestration, exploratory analysis, customer analytics, machine learning, NLP, forecasting, event simulation, and application logic.

Transformations are not duplicated merely to demonstrate both technologies. Each tool is used where it provides a practical advantage.

### 5.2 Historical and Simulated Data Separation

Historical Olist data supports business analysis using recorded transactions. Simulated or manually supplied order events demonstrate an additional ingestion workflow.

Simulated events are not assumed to represent real transactions, and they do not automatically modify historical sales results.

### 5.3 Data Quality and Validation

Validation is performed at multiple stages rather than relying only on successful data insertion.

Checks include row counts, key relationships, missing values, delivery outcomes, and reconciliation of selected business metrics. Known source-data limitations are documented separately from validation failures.

### 5.4 Business Metric Definitions

- Item revenue uses the order-item `price` field.
- Freight is reported separately.
- Realized sales analysis uses delivered orders.
- Delivery duration uses the calendar-date difference between purchase and customer-delivery dates when both are available.
- Delivery outcomes are classified as `early`, `on_time`, `late`, or `unknown`.
- Customer RFM analysis uses delivered purchases, groups by `customer_unique_id`, and excludes freight from monetary value.
- Review scores 1–2 are dissatisfied, 3 is neutral, and 4–5 are satisfied.

The satisfaction/repurchase analysis is exploratory because reviews are associated with orders, which may contain multiple products.

## 6. Business Intelligence

The Power BI report contains four implemented pages:

1. **Executive Overview** — high-level KPIs and sales performance.
2. **Customer Analytics** — customer behavior and RFM analysis.
3. **Delivery & Operations** — delivery performance and operational analysis.
4. **Product & Seller Performance** — product-category and seller metrics.

The dashboards use historical analytical data. Automatic refresh and integration of incoming simulated events into historical sales reporting are not part of the current implementation.

## 7. Python Analytics and Machine Learning

The project includes the following analytical experiments:

- **Customer segmentation:** K-Means with two clusters and a recorded silhouette score of approximately 0.7418.
- **Customer inactivity risk:** Logistic Regression using customer recency, frequency, and monetary features.
- **Review sentiment:** TF-IDF and Logistic Regression using review-score-derived labels.
- **Sales forecasting:** A monthly revenue baseline using the last training month's value as the forecast.

These are experimental baselines, not production-ready predictive services.

The inactivity-risk model faces severe class imbalance and weak active-class performance. The sentiment model performs less effectively on the neutral class, and its labels are proxies derived from review scores. The forecasting evaluation uses only five test months, and the historical dataset ends in 2018.

These limitations must be considered before using the results for real business decisions.

## 8. Incoming Order-Event Pipeline

The event pipeline accepts simulated or manually supplied event CSV files.

Main components:

- `python/simulate_order_events.py`
- `python/ingest_order_events.py`
- `python/run_pipeline.py`
- `sql/15_create_order_event_tables.sql`
- `sql/16_transform_order_events.sql`
- `sql/17_create_order_event_view.sql`
- `sql/18_validate_order_event_pipeline.sql`

The workflow validates required fields and timestamps, handles duplicate event IDs, and transforms event records from Bronze to Silver before exposing them through a Gold view.

It demonstrates an incremental ingestion pattern but is not a live streaming platform or a connection to a real production event source. General-purpose dataset uploads and automatic historical sales integration remain future enhancements.

## 9. FastAPI and Generative AI

The implemented API endpoints are:

| Endpoint | Purpose |
|---|---|
| `GET /` | Root endpoint |
| `GET /kpis/summary` | Summary KPIs |
| `GET /kpis/categories` | Category revenue information |
| `POST /ai/ask` | Natural-language business questions |

The AI assistant is implemented in `python/ai_assistant.py` and reuses analytics functions from `python/analytics.py`.

The current assistant retrieves:

- Total delivered item revenue.
- Delivered order count.
- The top five product categories by revenue.

It sends the selected aggregate metrics and the user's question to the Groq API using the `openai/gpt-oss-120b` model.

The API key is stored in `.env`, which is excluded from version control through `.gitignore`. Raw customer review text is not sent to the AI provider by the current implementation.

The assistant can only answer questions supported by the data retrieved by its existing analytics functions. It must acknowledge insufficient evidence rather than inventing metrics or explanations. More advanced questions require additional analytics functions and supporting data.

The API and AI workflow have been tested locally. These tests do not establish production readiness.

## 10. Repository and Documentation Practices

The repository maintains a structured separation of code, SQL, documentation, models, data, and screenshots.

- `python/` — ingestion, analytics, machine learning, API, and AI assistant code.
- `sql/` — version-controlled SQL scripts for schema creation, transformations, analysis, and validation.
- `docs/learning/project-learning.md` — chronological learning journal.
- `docs/architecture-decisions.md` — architecture and technical decisions.
- `docs/ai-assistant-questions.md` — AI assistant usage, supported questions, and limitations.
- `models/` — generated machine-learning artifacts.
- `screenshots/` — project evidence and interface screenshots.
- `README.md` — project overview, setup instructions, and usage guidance.

Every SQL query used for project work must be saved in an appropriate `.sql` file under `sql/`, not left only in pgAdmin history.

Secrets, local environment files, and generated data must not be committed accidentally. Git and GitHub are used to track source-code and documentation changes.

## 11. Limitations and Future Enhancements

The platform is a portfolio and learning project, not a production-ready enterprise system.

Potential improvements include:

- More comprehensive automated data-quality tests.
- A controlled strategy for reprocessing changed source files.
- Deeper validation of satisfaction and repurchase logic.
- Better time-based evaluation of predictive models.
- Improved sentiment classification and forecasting.
- Additional analytics for monthly revenue, product rankings, seller performance, and delivery causes.
- Integration of additional validated metrics into the AI assistant.
- General-purpose CSV ingestion with explicit schema mapping and validation.
- Scheduled ingestion, monitoring, authentication, and rate limiting.
- Cloud deployment and a documented data-refresh strategy.
- Systematic evaluation of AI answer accuracy and unsupported claims.

These are future enhancements unless separately implemented and tested.

## 12. Final Architecture Decision

The final architecture uses **PostgreSQL as the central analytical database, SQL for relational transformations and business metrics, Python for ingestion and analytical applications, Power BI for reporting, FastAPI for API access, and Groq for natural-language generation over selected verified metrics**.

Historical sales analytics and simulated order events remain separate. Machine-learning components remain experimental, and the AI assistant's capabilities are limited to the metrics retrieved by the application.

This architecture prioritizes traceability, clear separation of responsibilities, reusable analytics, and honest documentation of implemented functionality and limitations.