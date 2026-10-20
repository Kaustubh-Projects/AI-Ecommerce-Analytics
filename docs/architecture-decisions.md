# Architecture Decision Log

This document records the technical decisions made during the development of the AI-Powered E-Commerce Analytics Platform.

Each decision includes its status, reasoning, and implications.

## ADR-001: Use PostgreSQL

**Status:** Planned

**Decision:** Use PostgreSQL as the primary relational database.

**Reason:** The project contains related entities such as customers, orders, products, payments, sellers, and reviews. PostgreSQL supports relational modeling, constraints, and SQL analytics.

**Validation:** To be recorded after implementing the database.

## ADR-002: Use Python for Data Processing

**Status:** Planned

**Decision:** Use Python with Pandas and supporting libraries.

**Reason:** Python will support ingestion, data cleaning, exploratory analysis, feature engineering, machine learning, NLP, forecasting, and simulated transaction generation.

**Validation:** To be recorded as the pipelines are implemented and tested.

## ADR-003: Use Power BI for Business Intelligence

**Status:** Planned

**Decision:** Use Power BI for interactive reporting and business dashboards.

**Reason:** The project targets Data Analytics roles and needs clear, business-focused KPIs and visualizations.

**Validation:** To be recorded after connecting Power BI to the analytical data.

## ADR-004: Combine Historical and Simulated Data

**Status:** Planned

**Decision:** Use the public Olist dataset alongside simulated transaction events and optional manual CSV uploads.

**Reason:** Historical data supports realistic analysis. Simulated events and CSV uploads let us test incremental ingestion and business scenarios without claiming access to a real company's live production data.

**Validation:** To be recorded after all three ingestion paths are implemented.

## ADR-005: Use Bronze, Silver, and Gold Data Layers

**Status:** Planned

**Decision:** Organize data processing into raw, cleaned, and business-ready layers.

**Reason:** Separating these stages makes transformations easier to understand, test, troubleshoot, and maintain.

**Validation:** To be recorded after implementing the data layers.

## ADR-006: Develop Incrementally

**Status:** Accepted

**Decision:** Build and test the system one phase at a time, documenting concepts, decisions, results, and lessons learned.

**Reason:** The project is intended to demonstrate both technical ability and a clear understanding of the implementation.

**Validation:** Maintain the learning journal, automated or manual tests, and Git history throughout development.

## ADR-007: Use Git and GitHub

**Status:** Accepted

**Decision:** Use Git for local version control and GitHub to host the project repository.

**Reason:** Version history and public documentation help demonstrate a structured development process.

**Validation:** To be recorded after the first commit is pushed to GitHub.

## Future Decisions

Additional decisions will be recorded when we choose the implementation details for data ingestion, model deployment, dashboard refresh, API security, and GenAI integration.


## ADR: Use One PostgreSQL Database with Three Schemas

### Status
Accepted for project design. Database objects have not yet been created.

### Context
The AI-Powered E-Commerce Analytics Platform uses nine Olist CSV datasets. The planned pipeline separates source data, cleaned data, and business-ready analytical data into Bronze, Silver, and Gold layers.

### Decision
Use one PostgreSQL database named `ecommerce_analytics`, organized into three schemas:

- `bronze`: source-faithful ingested data.
- `silver`: validated, cleaned, and standardized data.
- `gold`: business-ready analytical tables and metrics.

### Why This Decision Was Made
- Clear separation of responsibilities between data layers.
- Straightforward SQL queries across layers in one database.
- Easier integration with Python and Power BI using a single database.
- Less operational overhead than maintaining separate databases.
- Better organization than relying only on table-name prefixes.

### Alternatives Considered
1. One schema with table prefixes: simpler initially, but less convenient for layer-level organization and permissions.
2. Separate databases for each layer: stronger operational separation, but adds configuration and cross-database coordination.

### Consequences and Limitations
- Tables must be organized and queried using the correct schema.
- Schema separation does not automatically clean data or prevent incorrect joins.
- Data-quality rules, access permissions, and transformations must be implemented and tested separately.
- Raw source data should remain traceable to the original files.

### Implementation Status
Design agreed. PostgreSQL database and schemas have not yet been created.



## ADR: PostgreSQL Layering and Bronze CSV Ingestion

### Status
Accepted and implemented. Initial historical CSV ingestion has been verified.

### Context
The project uses nine historical Olist Brazilian E-Commerce CSV files. The analytics platform needs a traceable raw-data layer that can support validation, transformations, business analytics, and future ingestion workflows.

The raw files contain missing values, repeated business keys in some datasets, and relationships that require validation. The ingestion process must preserve source information and avoid accidental duplicate file loads.

### Decision 1: Database Organization
Use one PostgreSQL database named `ecommerce_analytics` with three schemas:

- `bronze`
- `silver`
- `gold`

Bronze preserves ingested source data. Silver will contain validated and standardized data. Gold will contain business-ready analytical tables and metrics.

### Decision 2: Bronze Source Tables
Create one source table for each CSV file.

Every source table includes:
- `bronze_row_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY`
- Original source columns, using their original names and `TEXT` data types
- Nullable source columns to preserve missing values
- `source_file TEXT NOT NULL`
- `ingested_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP`

Bronze does not enforce source business-key uniqueness or foreign-key constraints. Duplicate source records are not silently removed.

### Decision 3: Batch Tracking
Use `bronze.ingestion_batches` to record ingestion attempts.

The table contains:
- `batch_id`
- `source_file`
- `file_hash`
- `status`
- `started_at`
- `completed_at`
- `row_count`
- `error_message`

Allowed statuses are `in_progress`, `completed`, and `failed`.

### Decision 4: Ingestion Implementation
Use Python, Pandas, SQLAlchemy, Psycopg 3, and python-dotenv.

The ingestion process:
1. Maps each source CSV to its Bronze table.
2. Calculates a SHA-256 file fingerprint.
3. Reads CSV data in chunks.
4. Adds source-file metadata and relies on PostgreSQL defaults for generated metadata.
5. Checks batch history before loading.
6. Records an in-progress attempt separately.
7. Loads one file within a transaction.
8. Commits the loaded rows and completed status together.
9. Records failure details after a failed transaction.

Identical file contents that have previously loaded successfully are skipped. Changed content for a previously successful filename is not automatically appended or overwritten; controlled reprocessing must be explicitly implemented.

### Rationale
- One database simplifies querying and integration with Python and Power BI.
- Separate schemas provide clear logical boundaries between data-processing layers.
- Bronze retains the source representation for traceability and reproducibility.
- Technical row identifiers distinguish stored rows from source business identifiers.
- Batch history supports troubleshooting and controlled retries.
- Per-file transactions prevent a failed file from undoing other successfully committed files.
- SHA-256 fingerprints help detect identical file contents.

### Alternatives Considered
- Table-name prefixes in a single schema: simpler initially, but less convenient for organizing a growing set of tables and permissions.
- Separate databases for each layer: stronger separation can be useful in larger systems, but increases complexity for this portfolio project.

### Implementation Status
- [x] `ecommerce_analytics` database created.
- [x] `bronze` schema created.
- [x] Nine Bronze source tables created.
- [x] `bronze.ingestion_batches` created.
- [x] Python-to-PostgreSQL connection verified.
- [x] CSV ingestion script implemented.
- [x] All nine historical CSV files loaded.
- [x] Row counts and batch outcomes verified.
- [x] Silver schema transformations and initial validation checks implemented.
- [ ] Gold analytical tables implemented.

### Limitations and Follow-up
- Successful row counts do not prove complete data quality.
- Relationship validation, type conversion, duplicate policies, and business-rule checks remain Silver-layer responsibilities.
- Controlled reprocessing must be implemented and tested before changed files can be safely reloaded.
- The current ingestion process loads local historical CSVs; it does not yet provide scheduled ingestion, live event ingestion, or API ingestion.
- Bronze tables preserve source values as text. Downstream layers must convert dates and numeric values using explicit validation rules.

## Day 4 — Silver Layer Decisions

### ADR: Silver Layer Table Design and Transformations

**Status:** Implemented

**Context:** Bronze contains the source CSV data with source columns stored as text. Analytics requires standardized data types, validated identifiers, and dependable relationships.

**Decision:** Use PostgreSQL SQL for transformations that are naturally performed inside the database. Use Python when it provides a clear advantage for ingestion, complex data processing, machine learning, NLP, forecasting, or orchestration. Do not duplicate transformations merely to demonstrate both tools.

**Rationale:** This keeps the architecture practical, avoids unnecessary data movement, and assigns each technology a responsibility based on the task.

### ADR: Silver Processing Metadata

**Status:** Implemented

**Decision:** Preserve `source_file` and `ingested_at` in Silver and include `silver_processed_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP`.

**Rationale:** Source metadata supports lineage and troubleshooting. The processing timestamp distinguishes Bronze ingestion time from Silver processing time.

### ADR: Primary Keys and Foreign Keys

**Status:** Implemented for the relationships listed below.

**Decision:** Use primary keys to enforce record identity and foreign keys to enforce validated relationships.

Implemented relationships:

- `silver.orders.customer_id` → `silver.customers.customer_id`
- `silver.order_items.order_id` → `silver.orders.order_id`
- `silver.order_items.product_id` → `silver.products.product_id`
- `silver.order_items.seller_id` → `silver.sellers.seller_id`
- `silver.order_payments.order_id` → `silver.orders.order_id`
- `silver.order_reviews.order_id` → `silver.orders.order_id`

**Rationale:** Validate relationships before adding constraints. The foreign key belongs to the referencing table, not the referenced table.

### ADR: Composite and Generated Primary Keys

**Status:** Implemented

**Decision:**

- `silver.order_items` uses `(order_id, order_item_id)` as its composite primary key.
- `silver.order_payments` uses `(order_id, payment_sequential)` as its composite primary key.
- `silver.order_reviews` uses a generated identity key because source `review_id` values repeat.
- `silver.geolocation` uses a generated identity key because ZIP prefixes repeat.

**Rationale:** Source identifiers must not be assumed unique without evidence. Keys should represent actual row identity and preserve legitimate source records.

### ADR: Missing Values and Source Preservation

**Status:** Implemented as the initial Silver policy

**Decision:** Preserve missing source values unless a documented cleaning rule justifies changing them. Convert blank strings to SQL `NULL` during relevant date and numeric transformations. Do not invent missing categories or timestamps.

**Rationale:** Missing values may be legitimate, and unexplained replacement or deletion could distort analytics.

### ADR: Validation and Evidence

**Status:** Adopted

**Decision:** Distinguish source inspection, Bronze validation, and Silver validation. Every expected result must be supported by a prior observation, a database constraint, or an explicit business rule.

**Rationale:** A successful insertion is not proof of data quality. Validation must verify the transformed result, and documentation must not claim checks that were not performed.

### Known Limitations and Follow-Up

- Some source categories lack English translations.
- Geolocation ZIP prefixes are not unique and must not be used as unique join keys without a defined aggregation or lookup strategy.
- Repeated review IDs must not be removed without investigating their meaning.
- Future pipeline reruns must be designed to avoid duplicate inserts.
- Gold-layer modeling and downstream business rules remain to be implemented.

## ADR-006: Gold Layer Uses Fact and Dimension Tables

**Status:** Implemented; initial load and selected validations verified

**Context**

The Silver layer contains cleaned, typed, source-oriented tables. Business analysis requires related data to be organized around orders, order items, customers, products, sellers, dates, payments, and reviews.

**Decision**

Create four dimension tables and four fact tables in the PostgreSQL `gold` schema.

**Dimension tables**
- `gold.dim_customers` — customer attributes
- `gold.dim_products` — product attributes and English category translation where available
- `gold.dim_sellers` — seller attributes
- `gold.dim_date` — calendar attributes and integer `YYYYMMDD` date keys

**Fact tables**
- `gold.fact_orders` — one row per order
- `gold.fact_order_items` — one row per `(order_id, order_item_id)`
- `gold.fact_payments` — one row per `(order_id, payment_sequential)`
- `gold.fact_reviews` — one row per Silver review record, identified by `silver_review_row_id`

**Rationale**

The fact/dimension model makes business analysis easier to understand and supports reusable reporting in SQL and Power BI. Gold does not need to change every source value; it organizes, enriches, and derives information where needed.

**Validation evidence**

The initial Gold row counts matched their corresponding Silver source counts. Relationship and selected metric validations also passed. This verifies the initial load at the tested level, not every possible business rule.

---

## ADR-007: Define Revenue and Delivery Metrics Explicitly

**Status:** Implemented; selected metric validations verified

**Context**

Revenue and delivery results can be misleading if different queries use different definitions or combine records at incompatible levels of detail.

**Decision**

- Item revenue is calculated from item `price`.
- `freight_value` is reported separately.
- Realized sales analysis includes orders whose status is `delivered`.
- Delivery duration is calculated as the calendar-date difference between order purchase and customer delivery dates when both dates are available.
- Delivery outcome is `early`, `on_time`, `late`, or `unknown`, based on actual and estimated delivery calendar dates.
- Missing dates are not fabricated.

**Rationale**

Explicit definitions make results consistent and easier to validate. Calendar-day delivery duration is intentional; it is not elapsed-hour duration.

**Validation evidence**

The sales, product, and seller view item-revenue totals reconciled to the direct delivered-order item-price total. No negative delivery durations were found in the validation run. Orders with unknown delivery outcomes remain present for investigation.

---

## ADR-008: Customer RFM Uses Delivered Purchases

**Status:** Implemented; selected metric validations verified

**Context**

Customer segmentation needs consistent measures of purchase recency, frequency, and monetary value.

**Decision**

The `gold.vw_customer_rfm` view groups by `customer_unique_id` and uses delivered purchases only.

- **Recency:** calendar days since the customer's latest delivered purchase, using the day after the latest dataset purchase date as the historical reference date.
- **Frequency:** count of distinct delivered orders.
- **Monetary:** sum of item prices from delivered orders, excluding freight.
- Quintile scores are calculated with PostgreSQL `NTILE(5)`.
- The recency score sorts by `recency_days ASC`, so more recent customers receive higher recency buckets.

**Rationale**

These rules give the project a consistent historical RFM definition. The reference date is dataset-based, not the current date, so this view describes historical customer behavior.

**Validation evidence**

The RFM customer count matched the distinct customer identities with delivered purchases. The RFM monetary total reconciled to delivered item revenue.

**Limitation**

The segment labels and score thresholds are project-defined rules and should not be interpreted as a universal RFM standard.

---

## ADR-009: Review Satisfaction and Repurchase Are Proxies

**Status:** Implemented; deeper business validation still required

**Context**

The business wants to understand satisfaction and whether customers later buy the same product again. Olist reviews refer to orders, and one order can contain multiple products.

**Decision**

- Review scores 4–5 are classified as `satisfied`.
- Score 3 is classified as `neutral`.
- Scores 1–2 are classified as `dissatisfied`.
- The `gold.vw_customer_satisfaction_repurchase` view associates an order review with each distinct product in that order for exploratory analysis.
- A repeat purchase requires a later delivered order containing the same product for the same `customer_unique_id`.
- Review/product associations are deduplicated before calculating customer-product review summaries.

**Rationale**

This provides an initial way to explore satisfaction-associated repurchase behavior using the available data.

**Limitations**

An order-level review is not proof of a product-specific rating. A customer may have bought multiple products in the reviewed order. Also, no later repurchase observed in the historical dataset does not prove that the customer will never return.

**Validation evidence**

The review satisfaction classification check passed. The view returned customer-product pairs, but its row count alone does not prove every repurchase classification is correct. Further business-rule testing is required before using this view as definitive product-level satisfaction reporting.

---

## ADR-010: Gold Analytical Views Provide Reusable Business Queries

**Status:** Implemented; view existence and row counts verified

**Context**

Repeatedly writing complex joins and aggregations for each report increases duplication and the risk of inconsistent definitions.

**Decision**

Create six standard PostgreSQL views:

1. `gold.vw_sales_performance`
2. `gold.vw_delivery_performance`
3. `gold.vw_customer_rfm`
4. `gold.vw_product_performance`
5. `gold.vw_seller_performance`
6. `gold.vw_customer_satisfaction_repurchase`

**Rationale**

The views provide reusable business-oriented queries for SQL analysis and the future Power BI layer. Standard PostgreSQL views store query definitions, not separate copies of the result rows.

**Validation evidence**

All six views were confirmed in the PostgreSQL catalog and returned rows. Selected sales, product, seller, and RFM monetary totals reconciled to the direct delivered-order item-price calculation.

---

## ADR-011: Validate Gold Before Reporting

**Status:** Implemented; initial validation run completed

**Context**

Successful SQL execution and matching row counts alone do not prove that data relationships and business metrics are correct.

**Decision**

Use a read-only validation script at `sql/12_validate_gold_completely.sql` to check row counts, date coverage, missing date keys, orphan relationships, satisfaction classifications, delivery durations, view counts, and selected metric reconciliations. Informational checks report known source-data limitations separately from failures.

**Rationale**

Separating validation from data loading helps detect errors without modifying the dataset and provides evidence for the project's learning journal.

**Validation evidence**

The initial run reported checks 1–28 as passing. Informational findings included:
- 13 products with a non-null category lacking an English translation match
- 2,965 orders with unknown delivery outcome
- 0 reviews with missing score
- 125 sellers with no delivered sales

These findings describe the current dataset and query definitions; they are not automatically loading failures.

**Limitation**

Passing these checks does not prove every possible business rule is correct. Satisfaction/repurchase logic still requires deeper validation, and the hard-coded expectation of 774 date rows is specific to the current dataset.

## ADR: Customer Inactivity-Risk Baseline

**Status:** Implemented experimentally; not production-ready.

### Context

The Gold layer contains customer-level analytics, and the project requires a machine-learning component that can estimate customer inactivity risk.

The historical Olist dataset is old and imbalanced for this target. The model therefore needs an explicit target definition, historical cutoff, outcome window, and evaluation report.

### Decision

Use PostgreSQL SQL to construct customer-level training records and Python with Pandas and scikit-learn to train and evaluate the model.

The initial features are:

- `recency_days`
- `frequency`
- `monetary`

Use a historical cutoff of June 1, 2018. Define the outcome using delivered purchases from June 1 through August 29, 2018.

Use a scikit-learn Pipeline containing StandardScaler and Logistic Regression with `class_weight="balanced"`.

Save the trained model bundle to `models/inactivity_risk_model.joblib` and use a separate prediction script for new customer feature records.

### Rationale

- PostgreSQL is already the source of truth for the relational historical data.
- SQL is suitable for joining and aggregating transactions into customer-level features.
- Python and scikit-learn provide the training, evaluation, and prediction tools.
- A Pipeline keeps scaling and model application consistent.
- A separate prediction script avoids retraining the model for every prediction request.
- A historical cutoff helps separate known features from future outcomes.

### Evidence and Limitations

The training dataset contains 75,387 customer records:

- Active label 0: 419.
- Inactive label 1: 74,968.

The baseline's active-class precision was approximately 0.01, and its test accuracy was approximately 0.59. These results are insufficient to establish useful real-world inactivity-risk performance.

The prediction examples were synthetic. Their outputs are functional demonstrations, not evidence of performance on real current customers.

The model has not been validated on a genuinely later customer population, its probabilities have not been shown to be calibrated, and it is not yet connected to a production API or retraining workflow.

### Consequences

- Keep the current model as an experimental baseline.
- Do not use its predictions as the sole basis for customer-retention actions.
- Do not describe its output as a verified probability of future inactivity.
- Evaluate the next version with class-specific metrics and time-based validation.
- Keep generated prediction CSV files and the saved model artifact out of normal source-code commits unless model versioning is deliberately introduced.

### Implementation Files

- `sql/11_inactivity_risk_data_check.sql`
- `sql/12_build_inactivity_training_data.sql`
- `python/inactivity_risk_model.py`
- `python/predict_inactivity_risk.py`
- `models/inactivity_risk_model.joblib` — generated artifact
- `data/processed/new_customers_for_prediction.csv` — example input
- `data/processed/inactivity_risk_predictions.csv` — generated output
- `docs/learning/project-learning.md`

### Follow-up

Improve evaluation and compare baselines before promoting the model to a downstream application.