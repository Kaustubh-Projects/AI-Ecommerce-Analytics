# Project Learning Journal

## Project Name

AI-Powered E-Commerce Analytics Platform

## Purpose of This Journal

This document records the concepts, tools, implementation
details, errors, solutions, and interview questions learned
while building the project.

The objective is to understand the complete system rather
than simply copy and execute code.

---

# Phase 0: Environment Setup

## 1. Python

### Status
Installed and verified.

### Version
Python 3.11.9

### What is Python?

Python is a general-purpose programming language used for
data analysis, automation, data engineering, and machine
learning.

### Why are we using Python?

In this project, Python will be used for:

- Data ingestion
- Data cleaning
- Exploratory data analysis
- Feature engineering
- Customer segmentation
- Machine learning
- NLP and review analysis
- Revenue forecasting
- Simulated transaction generation
- API development

### What I learned

To be completed as development progresses.

---

## 2. Visual Studio Code

### Status
Installed and verified.

### Version
1.106.3

### What is VS Code?

Visual Studio Code is a code editor used to write, organize,
debug, and maintain software projects.

### Why are we using VS Code?

We will use it to develop Python scripts, SQL files,
FastAPI endpoints, documentation, and tests.

### What I learned

To be completed as development progresses.

---

## 3. Git

### Status
Installed and verified.

### Version
2.56.0.windows.2

### What is Git?

Git is a distributed version control system that records
changes to files over time.

### Why are we using Git?

Git will help us:

- Track project changes.
- Save development checkpoints.
- Review previous versions.
- Organize development history.
- Collaborate with others when needed.

### Important concepts

- Repository: A project tracked by Git.
- Commit: A recorded checkpoint of changes.
- Branch: An independent line of development.
- Working directory: The files currently being edited.
- Staging area: The changes selected for the next commit.

### What I learned

To be completed as development progresses.

---

## 4. GitHub

### Status
Repository setup pending.

### What is GitHub?

GitHub is an online platform for hosting Git repositories
and collaborating on software projects.

### Why are we using GitHub?

We will use GitHub to:

- Publish the project source code.
- Maintain project documentation.
- Track development milestones.
- Showcase the project in a portfolio.
- Demonstrate version-control practices.

### Important distinction

Git tracks changes locally.

GitHub hosts the repository online.

### What I learned

To be completed as development progresses.

---

## 5. PostgreSQL

### Status
Installed and running.

### Version
PostgreSQL 17.1, as reported by the version query.

### What is PostgreSQL?

PostgreSQL is an open-source relational database management
system used to store, organize, query, and manage data.

### Why are we using PostgreSQL?

Our project contains related information about customers,
orders, products, sellers, payments, deliveries, and reviews.

PostgreSQL will store this data and support SQL-based
analytics and data transformation.

### Important concepts to learn

- Database
- Schema
- Table
- Row and column
- Primary key
- Foreign key
- Constraints
- Index
- Transaction
- SQL query

### What I learned

To be completed as development progresses.

---

## 6. pgAdmin 4

### Status
Installed and connected to PostgreSQL.

### What is pgAdmin?

pgAdmin is a graphical administration tool for PostgreSQL.

### Why are we using pgAdmin?

We will use pgAdmin to:

- Inspect databases and tables.
- Execute SQL queries.
- Create database objects.
- Examine query results.
- Manage database connections.

### First SQL command executed

    SELECT version();

### Purpose of the command

The query returns information about the PostgreSQL
server version.

### What I learned

To be completed as development progresses.

---

## 7. Power BI Desktop

### Status
Installed.

### What is Power BI?

Power BI is a business intelligence platform used to
transform data into interactive reports and dashboards.

### Why are we using Power BI?

We will create dashboards for:

- Sales performance
- Customer behavior
- Product performance
- Delivery operations
- Customer satisfaction
- Forecasts and AI-generated insights

### Important concepts to learn

- Power Query
- Data modeling
- Relationships
- DAX
- Measures
- Calculated columns
- Slicers
- Drill-through
- Dashboard design

### What I learned

To be completed as development progresses.

---

# Git Configuration

## Git Author Name

Configured locally. Value verified during setup.

## Git Author Email

Configured locally. Value verified during setup.

## Important Note

Git author configuration identifies the author of commits.
It does not authenticate the user with GitHub.

---

# Project Development Log

## Current Milestone

Environment setup and project documentation.

## Completed

- Python installation verified.
- VS Code installation verified.
- Git installation verified.
- PostgreSQL server connection verified.
- pgAdmin connection verified.
- Power BI Desktop installation confirmed.

## Pending

- Complete initial project documentation.
- Initialize and verify the Git repository.
- Create the GitHub repository.
- Prepare the Python development environment.
- Download and inspect the Olist dataset.
- Design the PostgreSQL database.

---

# Interview Questions

## Git and GitHub

1. What is Git?
2. What is GitHub?
3. What is the difference between Git and GitHub?
4. What is a Git repository?
5. What is a Git commit?
6. What is the purpose of a .gitignore file?

## PostgreSQL

1. What is PostgreSQL?
2. What is a relational database?
3. What is a primary key?
4. What is a foreign key?
5. What is the difference between a database and a table?

## Python

1. Why is Python used in data analytics?
2. What is a Python library?
3. What is the purpose of Pandas?

## Power BI

1. What is Power BI?
2. What is Power Query?
3. What is DAX?
4. Why do we need data modeling?

Answers will be added as we learn each topic.

---

# Learning Rule

For every major implementation step:

1. Understand the problem.
2. Learn the required concepts.
3. Implement the solution.
4. Test the result.
5. Understand and fix errors.
6. Document what was learned.
7. Record important interview questions.
8. Commit the completed changes to Git.

## Python Environment Setup and Troubleshooting

### What is a virtual environment?
A virtual environment isolates the Python dependencies of a project
from those of other projects.

### What is pip?
pip is Python's package installer, used to install and manage
third-party libraries.

### Python vs VS Code
Python executes code, while VS Code provides the editor and
development tools. VS Code must use the correct Python interpreter.

### PowerShell activation issue
PowerShell blocked the virtual environment's Activate.ps1 script
because of its execution policy.

Instead of changing security settings, I ran Python directly:

.\.venv\Scripts\python.exe python\environment_check.py

### What I learned
- Creating and activating a virtual environment are different.
- A virtual environment can run Python without being activated.
- PowerShell execution policies are separate from Python.
- Explicitly selecting the interpreter helps avoid environment confusion.

### Verification
Record the actual Python version, executable path, and test result
from environment_check.py.

## First Data Inspection Milestone

### Dataset
- Source: Brazilian E-Commerce Public Dataset by Olist, downloaded from Kaggle.
- Local directory: `data/raw/`
- Files discovered: 9 CSV files.
- Total records across the nine files: 1,758,922.
- The total includes geolocation records and is not the number of orders.

### Implementation
Created `python/inspect_dataset.py` as a reusable dataset inspection tool.

The script:
- Locates the project and raw-data directories using `pathlib`.
- Discovers CSV files and displays their row counts, column counts, and headers.
- Checks required columns in the orders dataset.
- Counts blank values in selected required fields.
- Counts repeated nonblank order IDs.
- Displays the order-status distribution.
- Reads source files without modifying them.

### Concepts learned

**CSV and headers:** CSV files store tabular data. The first row commonly contains column names.

**Table grain:** The grain defines what one row represents. An orders row represents an order, while an order-items row represents an item within an order.

**Primary key:** A column or combination of columns intended to uniquely identify each record.

**Foreign key:** A field that references a record in another table and helps establish relationships.

**Data quality:** Data validation includes checking identifiers, missing values, required columns, and business rules.

**Business context:** A blank value is not automatically an error. For example, a delivery timestamp may be blank for an order that was never delivered.

### Initial findings

- Orders dataset: 99,441 rows.
- Unique nonblank order IDs: 99,441.
- Order IDs appearing more than once: 0.
- Blank values in the four required fields checked: 0.
- Delivered orders: 96,478 (approximately 97.02%).
- The checks above apply only to the fields and identifiers examined by the script; they do not prove that every dataset is free of data-quality issues.

### Design decision

Keep `inspect_dataset.py` focused on inspecting raw CSV files and performing basic checks. More advanced transformations, database loading, and analytics will be implemented in separate components.

### Next step
Install Pandas in the project's virtual environment and use it to explore the dataset through a separate analysis script.

## Day 1 — Initial Dataset Exploration (14 October 2026)

### Objective
Explore the Olist Brazilian E-Commerce dataset using Python and Pandas before starting data cleaning and database development.

### Files Used
- `python/inspect_dataset.py` — inspects CSV files and performs basic data-quality checks.
- `python/analyze_orders.ipynb` — interactively explores the orders dataset using Pandas.
- `python/analyze_orders.py` — retained for now; no new analysis implementation was added to this file.

### Work Completed
1. Loaded `olist_orders_dataset.csv` into a Pandas DataFrame.
2. Examined dataset dimensions, the first five rows, column names, data types and missing values.
3. Analysed order-status counts and percentage distribution.
4. Investigated missing customer delivery timestamps by order status.

### Initial Findings
- Orders dataset: 99,441 rows and 8 columns.
- All eight columns were initially read as strings.
- `order_approved_at`: 160 missing values.
- `order_delivered_carrier_date`: 1,783 missing values.
- `order_delivered_customer_date`: 2,965 missing values.
- Order statuses: delivered 96,478; shipped 1,107; canceled 625; unavailable 609; invoiced 314; processing 301; created 5; approved 2.
- Eight orders marked `delivered` have a missing customer delivery timestamp.
- Among these eight records, seven have a carrier timestamp and one does not.

### Concepts Learned
- Pandas DataFrames and CSV loading.
- `shape`, `head()` and `info()`.
- Missing-value analysis with `isnull().sum()`.
- Frequency analysis with `value_counts()`.
- Filtering with multiple conditions.
- Grouping records with `groupby()`.

### Decisions and Cautions
- The original CSV files were not modified.
- Missing values will not be automatically deleted or filled.
- Records with missing delivery timestamps require appropriate handling in analyses that depend on actual delivery dates.
- Timestamp columns need conversion to datetime types in a later analysis step.

### Next Steps
- Convert timestamp columns to datetime types.
- Investigate date consistency and missing-value patterns.
- Inspect relationships among the nine source CSV files.
- Continue toward PostgreSQL ingestion and analytical transformations.

### Milestone Status
Initial exploratory analysis completed. Data cleaning, PostgreSQL ingestion, dashboards, API development and machine learning remain future tasks.

## Day 2 — Data Quality and Relationship Analysis (15 October 2026)

### Objective

Inspect all nine Olist CSV datasets, investigate date and data-quality issues, and identify how the datasets may relate before designing the PostgreSQL schema.

### Work Completed

1. Inspected the nine CSV datasets and reviewed their sizes and columns.
2. Converted order timestamp columns to datetime values in the notebook and checked for conversion failures.
3. Investigated missing delivery timestamps and date-sequence anomalies.
4. Checked customer, order-item, product, seller, and payment identifier matching.
5. Investigated an order without a payment record across related datasets.
6. Checked review identifiers and order relationships.
7. Checked product-category translation coverage.
8. Investigated ZIP-prefix matching and coordinate duplication in geolocation.

### Key Findings

#### Dataset relationships

- Customer IDs in the orders dataset matched records in the customers dataset.
- All order IDs in the order-items dataset matched existing orders.
- 775 orders had no order-item records. Most were unavailable or canceled, but the remaining statuses require investigation rather than assumptions.
- Product IDs and seller IDs referenced by order items matched the products and sellers datasets.
- All payment order IDs matched existing orders, but one order had no payment record.
- All review order IDs matched existing orders.
- Product category translation keys were unique in the translation dataset.

#### Payment investigation

Order `bfbd0f9bdef84302105ad712db648a6c` was marked delivered but had no matching payment record. It had three order-item rows and one review with a score of 1. The review reported that the customer had not received the product.

This is a discrepancy requiring investigation. The available data does not establish why the payment record is missing or whether the recorded delivery status is correct.

#### Reviews

- Total review rows: 99,224.
- Unique review IDs: 98,410.
- Distinct review IDs appearing more than once: 789.
- Rows belonging to repeated review IDs: 1,603.
- Exact duplicate rows across all columns: 0.
- Unique order IDs represented in reviews: 98,673.
- Orders with multiple review rows: 547.
- Review rows referencing nonexistent orders: 0.

The review ID should not be assumed to be unique without further investigation. The appropriate key and row grain must be decided before database constraints are designed.

#### Product categories

- Translation dataset: 71 rows and 71 unique source category names.
- Two product categories had no matching translation: `pc_gamer` and `portateis_cozinha_e_preparadores_de_alimentos`.
- 610 products had missing category names.

Original category values should be preserved. Missing or untranslated categories should not be assigned invented values.

#### Geolocation

- Geolocation dataset: 1,000,163 rows.
- Unique ZIP prefixes: 19,015.
- ZIP-prefix rows beyond the first occurrence: 981,148.
- ZIP prefixes with multiple distinct coordinate pairs: 17,781.
- Maximum distinct coordinate pairs for one ZIP prefix: 746.
- Distinct customer ZIP prefixes without a geolocation match: 157.
- Distinct seller ZIP prefixes without a geolocation match: 7.

ZIP prefixes are not unique geolocation keys. Directly joining the raw geolocation dataset may multiply customer or seller rows and distort analytical results. A safe approach must be determined before using geolocation in reporting.

#### Date and delivery checks

- No invalid date values were identified during the timestamp-conversion checks.
- Several date-sequence anomalies were found, including carrier timestamps preceding purchase timestamps and customer delivery timestamps preceding carrier timestamps.
- Delivery-performance results, using calendar dates when both actual and estimated delivery dates were available:
  - Early: 88,649 orders.
  - Same calendar date: 1,292 orders.
  - Late: 6,535 orders.
  - Total with both dates available: 96,476 orders.

These results depend on the stated date-comparison method. Anomalies should be investigated before correction.

### Concepts Learned

- Candidate relationships can be identified from column names and business meaning, then verified with matching and uniqueness checks.
- A primary key must uniquely identify a record at the intended table grain.
- Foreign-key compatibility requires checking unmatched values, missing values, and cardinality.
- One-to-many joins can multiply rows when the join key is not unique on the expected side.
- Missing values, repeated identifiers, and conflicting business records require investigation rather than automatic deletion.
- A dataset's row count does not necessarily represent the number of distinct business entities.

### Decisions and Cautions

- The raw CSV files remain the source data and should not be modified during exploration.
- Findings are recorded as investigation items; they do not automatically establish the cause of an anomaly.
- The nine identified connections are candidate relationships, not yet a final set of database foreign-key constraints.
- PostgreSQL schema design will follow the relationship analysis.
- `analyze_orders.ipynb` remains the interactive analysis workspace. `analyze_orders.py` is retained for now and should not be expanded merely to duplicate the notebook.

### Next Steps

- Finish documenting and reviewing the relationship findings.
- Review and commit the intended Day 2 changes.
- Design the PostgreSQL schema based on the verified data grain and relationships.
- Begin database creation and Python connectivity after the schema design is agreed.

### Milestone Status

Initial dataset inspection, date checks, and major candidate-relationship investigations completed. PostgreSQL schema design, ingestion, transformations, dashboards, API development, and machine learning remain future work.


## Day 3 — PostgreSQL Schema Design and Bronze Ingestion

### Goal
Create the PostgreSQL database structure, connect Python to PostgreSQL, load all nine historical Olist CSV files into the Bronze layer, and verify the results.

### 1. Doubt: How Should We Organize the Database?

Should the project use one PostgreSQL database with three schemas, one schema with table-name prefixes, or separate databases for Bronze, Silver, and Gold?

### Solution
Selected one PostgreSQL database named `ecommerce_analytics` with three schemas:

- `bronze`
- `silver`
- `gold`

### Why We Use This Structure
- Bronze preserves ingested source data.
- Silver will contain validated, cleaned, and standardized data.
- Gold will contain business-ready analytical tables and metrics.
- One database simplifies querying and integration with Python and Power BI.
- Separate schemas organize the layers and make the architecture easier to understand.

### Alternatives Considered
- Table prefixes: simple to start, but less convenient for organizing a growing number of tables and permissions.
- Separate databases: useful when stronger operational separation is required, but adds complexity for this portfolio project.

### Important Learning
A PostgreSQL schema is a namespace inside a database. It organizes database objects but does not automatically enforce data quality or make transformations safe.

### 2. Doubt: How Should the Bronze Layer Preserve Source Data?

How can we preserve source values, missing values, and duplicate rows while adding enough metadata to trace ingestion?

### Solution
Created nine source tables in the `bronze` schema, one for each CSV file.

Each source table has:
- `bronze_row_id`: generated technical primary key.
- Original CSV columns, retaining their original names.
- Source columns stored as `TEXT` and allowed to contain `NULL`.
- `source_file`: identifies the source CSV.
- `ingested_at`: records the ingestion timestamp.

The source tables do not enforce foreign keys or automatically remove duplicate source records.

### Why We Use This Design
- A technical key identifies a stored row independently of the source business key.
- Text columns preserve the original source representation until validation and type conversion happen in Silver.
- Nullable source columns preserve missing information rather than inventing replacement values.
- Source metadata improves traceability.
- Keeping Bronze separate from Silver allows us to reprocess data without losing the original source layer.

### 3. Doubt: How Should We Track CSV Ingestion Attempts?

How can we prevent accidental duplicate loads and retain a record of failed attempts?

### Solution
Created `bronze.ingestion_batches` with eight columns:

- `batch_id`
- `source_file`
- `file_hash`
- `status`
- `started_at`
- `completed_at`
- `row_count`
- `error_message`

The status is restricted to `in_progress`, `completed`, or `failed`.

The Python script calculates a SHA-256 fingerprint for each file. If identical content has already loaded successfully, the script skips it. If a previously loaded filename has changed content, the script stops and requires controlled reprocessing rather than silently appending another copy.

### Why We Use This Design
- The fingerprint helps identify identical file contents.
- The batch table preserves the history of ingestion attempts.
- Status and error details make failures easier to investigate.
- Each CSV is processed in its own transaction.
- A failed file load rolls back that file's inserted rows without undoing previously committed files.

### 4. Python and PostgreSQL Connection

Installed the following packages in the project virtual environment:

- Pandas 3.0.6
- SQLAlchemy 2.1.4
- Psycopg 3.3.6
- python-dotenv 1.2.4

Created `python/test_db_connection.py` to verify that Python could connect to `ecommerce_analytics`.

Database credentials are stored in the local `.env` file, which is excluded from Git through `.gitignore`. Credentials must not be committed to GitHub.

### 5. Python CSV Ingestion

Created `python/ingest_bronze.py`.

The script:
- Maps each CSV filename to its corresponding Bronze table.
- Calculates a SHA-256 fingerprint.
- Reads CSV files in chunks to limit memory usage.
- Preserves source column names and text values.
- Adds the `source_file` metadata column.
- Relies on PostgreSQL to generate `bronze_row_id` and `ingested_at`.
- Records batch outcomes and row counts.
- Skips previously successful identical files.
- Rolls back a failed file transaction and records the error.

### 6. Error Encountered and Solution

The first customer ingestion attempt failed because `bronze.customers.source_file` is required but the Python script did not supply it.

Error:
`NotNullViolation: null value in column "source_file" violates not-null constraint`

Solution:
Added the source filename to each Pandas chunk before inserting it:

`chunk["source_file"] = file_name`

The failed attempt remained in the ingestion history. The next attempt succeeded with 99,441 rows.

This demonstrated the importance of aligning Python inserts with database constraints and retaining failed-attempt history for troubleshooting.

### 7. Ingestion Results

All nine CSV files loaded successfully.

| Bronze table | Rows loaded |
|---|---:|
| `bronze.customers` | 99,441 |
| `bronze.geolocation` | 1,000,163 |
| `bronze.order_items` | 112,650 |
| `bronze.order_payments` | 103,886 |
| `bronze.order_reviews` | 99,224 |
| `bronze.orders` | 99,441 |
| `bronze.products` | 32,951 |
| `bronze.sellers` | 3,095 |
| `bronze.category_translation` | 71 |
| **Total** | **1,758,922** |

The total includes geolocation records and is not the total number of orders.

### 8. Verification

Verified in pgAdmin that:
- All nine source tables contain the expected row counts.
- All nine files have successful ingestion records.
- Successful batches have recorded row counts and completion timestamps.
- Successful batches have `NULL` error messages.
- The original failed customer attempt and successful retry are both retained.

These checks confirm row counts and ingestion status. They do not yet prove that every source value is correct or that all relationships are valid.

### Important Learning
- Database metadata can be inspected through `information_schema.columns`.
- Actual records are queried from their application tables, such as `bronze.ingestion_batches`.
- A successful database connection does not guarantee a successful insert; database constraints must also be satisfied.
- Row counts verify ingestion volume but are not a complete data-quality test.
- Bronze preserves the ingested source representation. Validation, type conversion, relationship checks, and cleaning belong in Silver.

### Current Status
**Completed:** PostgreSQL database and schemas, Bronze tables, Python connection test, CSV ingestion script, and ingestion verification.

**Not yet implemented:** Silver transformations, Gold analytical tables, automated data-quality checks, Power BI dashboards, ML models, API ingestion, and deployment.

### Next Step
Begin the Silver layer by defining data types, key constraints, validation rules, duplicate-handling policies, and relationship checks before implementing transformations.

# Day 4 — Silver Layer Implementation and Learning Record

## 1. Goal

Implement the Silver layer of the AI-Powered E-Commerce Analytics Platform using PostgreSQL. Learn how to design tables, choose data types, transform raw data, validate results, establish relationships, and document technical decisions.

The goal is not simply to execute SQL successfully. Every implementation must have a clear purpose, an explainable design, and evidence that it works.

## 2. Architecture Understanding

The project uses three database layers:

- **Bronze:** Stores the original CSV data in PostgreSQL, preserving source values as text and recording ingestion metadata.
- **Silver:** Stores standardized data using appropriate data types, primary keys, and validated relationships.
- **Gold:** Will contain business-ready datasets for analytical queries, KPIs, and Power BI dashboards.

Current flow:

CSV files → Python ingestion process → Bronze tables → SQL transformations → Silver tables → Gold analytical datasets → Power BI and other analytics services.

Python is used when it provides a clear benefit, such as file ingestion, complex data processing, machine learning, NLP, or forecasting. SQL is used when it is appropriate for transformations and validation inside PostgreSQL.

## 3. Database Schemas

Created the following schemas in the `ecommerce_analytics` database:

- `bronze`
- `silver`
- `gold`

A schema organizes database objects. Creating the `silver` schema does not create any Silver tables automatically.

## 4. Silver Table Implementation

Created and loaded nine Silver tables.

| Table | Verified row count |
|---|---:|
| `silver.orders` | 99,441 |
| `silver.customers` | 99,441 |
| `silver.order_items` | 112,650 |
| `silver.products` | 32,951 |
| `silver.sellers` | 3,095 |
| `silver.order_payments` | 103,886 |
| `silver.order_reviews` | 99,224 |
| `silver.category_translation` | 71 |
| `silver.geolocation` | 1,000,163 |

Total Silver rows: 1,758,922.

These counts were confirmed through the validation outputs during implementation.

## 5. Detailed Implementation Record

### 5.1 Creating `silver.orders`

**Why:** Orders contain purchase dates, approval dates, delivery dates, status, and customer references. These fields are essential for delivery analysis, sales analysis, and customer analytics.

**Important design decisions:**

- `order_id` is the primary key.
- `customer_id` is required.
- Date columns use `TIMESTAMP` because the source dataset does not provide timezone information for these business dates.
- Missing dates are allowed because not every order has completed every stage.
- `source_file` and `ingested_at` preserve ingestion lineage.
- `silver_processed_at` records when a row enters Silver.

**Transformation:** Text date values were converted using PostgreSQL timestamp casts. `NULLIF(TRIM(value), '')` handles blank strings by converting them to SQL `NULL`.

**Validation performed:**

- 99,441 rows.
- 99,441 unique order IDs.
- Zero missing order IDs.
- Zero missing processing timestamps.
- Missing date counts matched the earlier investigation.

Expected missing-date counts:

| Date column | Missing values |
|---|---:|
| `order_purchase_timestamp` | 0 |
| `order_approved_at` | 160 |
| `order_delivered_carrier_date` | 1,783 |
| `order_delivered_customer_date` | 2,965 |
| `order_estimated_delivery_date` | 0 |

**Learning:** Missing values must be interpreted in context. For example, a canceled order may legitimately lack a delivery date. Missing dates should not automatically lead to record deletion.

### 5.2 Creating `silver.customers`

**Why:** Customer data is required for repeat-purchase analysis, customer segmentation, RFM analysis, and future customer-level metrics.

**Important design decisions:**

- `customer_id` is the primary key.
- `customer_unique_id` is preserved separately.
- ZIP-code prefixes remain text because they are identifiers and may contain leading zeros.
- The source city and state are preserved without inventing corrections.
- The same three metadata conventions are used as in `silver.orders`.

**Validation performed:**

- 99,441 rows.
- 99,441 unique customer IDs.
- Zero missing customer IDs.
- Zero missing processing timestamps.

### 5.3 Establishing the orders-to-customers relationship

Before creating the foreign key, checked whether any order referenced a customer absent from Bronze. The earlier Bronze check returned zero unmatched customer IDs.

After loading both Silver tables, ran a separate SQL relationship check against Silver. It returned zero unmatched orders.

**Decision:** Add a foreign key from `silver.orders.customer_id` to `silver.customers.customer_id`.

**Why:** PostgreSQL can now reject an order referencing a nonexistent customer. This prevents invalid relationships from entering the database.

**Important concept:** A foreign key belongs to the referencing table. Here, the referencing table is `silver.orders`, so the constraint is stored in `silver.orders`, not in `silver.customers`.

### 5.4 Creating `silver.order_items`

**Why:** Each order can contain multiple items. Order items connect orders to products and sellers and are needed for product revenue, seller performance, and item-level analysis.

**Important design decisions:**

- The composite primary key is `(order_id, order_item_id)`.
- `order_id` alone is not unique because one order can contain multiple items.
- `price` and `freight_value` use `NUMERIC(12, 2)` for currency values.
- `shipping_limit_date` uses `TIMESTAMP`.
- Source and processing metadata are preserved.

**Transformation:** Converted the shipping limit date to a timestamp and financial values to numeric types. Blank date or numeric strings are converted to `NULL`.

**Validation performed:**

- 112,650 rows.
- 112,650 unique composite keys.
- Zero missing key values.
- Zero missing prices.
- Zero missing freight values.
- Zero missing processing timestamps.

**Relationship decisions:**

- `order_id` references `silver.orders(order_id)`.
- `product_id` references `silver.products(product_id)`.
- `seller_id` references `silver.sellers(seller_id)`.

The `order_id` foreign key was included when the table was created. Product and seller foreign keys were added only after their corresponding relationship checks returned zero unmatched IDs.

**Learning:** A table may contain multiple foreign keys. The primary key identifies an item record, while the foreign keys connect that item to the order, product, and seller.

### 5.5 Creating and loading the remaining Silver tables

The following tables were created and loaded using a grouped SQL workflow.

**`silver.products`**

- 32,951 rows.
- `product_id` is the primary key.
- Whole-number descriptive fields use integer types.
- Physical measurements use numeric types.
- Missing category information is preserved rather than invented.

**`silver.sellers`**

- 3,095 rows.
- `seller_id` is the primary key.
- Location descriptions and ZIP-code prefixes are preserved.

**`silver.order_payments`**

- 103,886 rows.
- Composite primary key: `(order_id, payment_sequential)`.
- Payment installments use an integer type.
- Payment values use `NUMERIC(12, 2)`.
- `order_id` references `silver.orders(order_id)`.

**`silver.order_reviews`**

- 99,224 rows.
- A generated identity column, `silver_review_row_id`, is used as the primary key.
- `review_id` is not treated as unique because repeated review IDs were found during source investigation.
- `order_id` references `silver.orders(order_id)`.
- Review text is preserved, including missing comments.

**`silver.category_translation`**

- 71 rows.
- `product_category_name` is the primary key.
- Source categories and English translations are preserved.
- Categories without a translation are not assigned invented translations.

**`silver.geolocation`**

- 1,000,163 rows.
- A generated identity column, `silver_geolocation_row_id`, is used as the primary key.
- ZIP prefixes are not used as primary keys because many records share the same prefix.
- Coordinates use numeric types.
- Original geographic records are preserved instead of being arbitrarily deduplicated.

### 5.6 Grouped load and validation workflow

The remaining six tables were processed in three groups:

1. Table creation.
2. Data insertion and type conversion.
3. Validation of row counts, key integrity, missing values, and relationships.

The load was wrapped in a transaction. The intended benefit was to avoid treating a partially completed group as a successful load.

**Learning:** Successful insertion does not prove data quality. Row counts, uniqueness, missing-value checks, and relationship checks must be considered separately.

## 6. Python Versus SQL — User Question and Final Decision

**User's doubt:** Why are transformations being performed in SQL when Python and Pandas can also transform data?

**Explanation:** Both tools can perform many of the same operations. SQL is suitable for transformations inside PostgreSQL; Python is useful for complex custom processing, file ingestion, machine learning, NLP, forecasting, and other tasks where its capabilities provide a clear benefit.

**Correction to the original approach:** Python should not be given additional tasks merely to demonstrate its use. Likewise, SQL should not be forced into tasks better suited to Python.

**Final decision:** Choose the implementation tool according to the task. Do not duplicate transformations simply to use both technologies. Keep the existing SQL transformation of `silver.orders`; there is no need to undo successful work.

## 7. Why We Added `silver_processed_at`

**User's doubt:** Why was `silver_processed_at` added without prior explanation?

**Resolution:** The column was retained after the user explicitly chose to keep it.

**Purpose:** It records when a row is processed into Silver. It differs from `ingested_at`, which records the original Bronze ingestion time.

**Implementation:** `TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP`.

PostgreSQL automatically supplies the default when an inserted row does not provide a value.

**Learning:** New columns and structural changes must be explained before implementation. The explanation should cover purpose, necessity, alternatives, and consequences.

## 8. How Expected Validation Results Are Established

**User's doubt:** Where do expected results come from, and which checks were performed previously in Python versus SQL?

**Resolution:** Expected results must be supported by source inspection, Bronze database checks, documented constraints, or explicit business rules.

Evidence already established in Python/Jupyter included:

- 32,951 product rows.
- 610 products missing category and related descriptive fields.
- Various source date and relationship anomalies documented during earlier exploration.

Bronze ingestion counts were checked during the ingestion milestone. Some checks, such as the exact unique product ID count and missing product ID count, could not be confirmed as previously executed in a specific earlier query from the available records.

**Decision:** Do not claim a check was previously performed unless its execution is known. Distinguish source inspection, Bronze verification, and Silver verification. If evidence is unavailable, perform a new check or explicitly record the uncertainty.

## 9. User Doubts, Corrections, and Solutions

| Doubt or correction | Resolution |
|---|---|
| Why was `silver_processed_at` added without explanation? | Explained its purpose and retained it after explicit approval. |
| Why preview Bronze if the source had already been inspected? | A preview was optional; the team chose not to repeat the ten-row preview and proceeded with the transformation. |
| Why use SQL rather than Python? | Tool selection is based on task requirements, not an artificial need to use a technology. |
| Why validate results already checked in Python? | Silver validation checks the actual transformed database data; it is distinct from source discovery. Avoid unnecessary repetition. |
| Why are foreign keys in `order_items` rather than `orders`, `products`, or `sellers`? | Foreign keys reside in the referencing table. `order_items` references orders, products, and sellers. |
| Why was `order_id` not added with the later product and seller constraints? | Its foreign key was already included in the original `CREATE TABLE silver.order_items` statement. |
| How were expected outputs established? | Trace each expectation to a real observation, database constraint, or documented rule. Do not invent prior verification. |
| Why preserve missing values and repeated source identifiers? | Their meaning is not always erroneous. Preserve source information until a justified cleaning rule is established. |
| Why group the remaining table queries? | Grouping creation, insertion, and validation improves efficiency and makes the workflow easier to review. |

## 10. Final Relationship Map

- `silver.orders.customer_id` → `silver.customers.customer_id`
- `silver.order_items.order_id` → `silver.orders.order_id`
- `silver.order_items.product_id` → `silver.products.product_id`
- `silver.order_items.seller_id` → `silver.sellers.seller_id`
- `silver.order_payments.order_id` → `silver.orders.order_id`
- `silver.order_reviews.order_id` → `silver.orders.order_id`

The foreign keys are stored in the referencing tables: `orders`, `order_items`, `order_payments`, and `order_reviews`, respectively.

No foreign key was added from geolocation ZIP prefixes because those prefixes are not unique. The category translation relationship requires care because some source product categories have no translation.

## 11. Current Status and Remaining Work

**Completed during Day 4:**

- Created the Silver and Gold schemas.
- Created and loaded all nine Silver tables.
- Verified the recorded row counts and key checks.
- Validated customer, product, and seller relationships before adding the relevant foreign keys.
- Added the agreed foreign-key constraints.
- Documented table design, data types, primary keys, foreign keys, missing-value handling, and processing metadata.
- Recorded the main doubts, explanations, corrections, and technical decisions.

**Current documentation and Git status:**

- Day 4 learning notes have been added.
- Architecture decisions have been documented.
- SQL scripts have been prepared for review and version control.
- Git staging, commit, and push have not yet been confirmed.

**Next steps:**

1. Review the four SQL scripts without rerunning their creation or data-loading statements.
2. Verify the final documentation and SQL file list.
3. Stage only the intended documentation and SQL files.
4. Review the staged changes and commit them.
5. Push to GitHub and verify the repository status.
6. Begin Gold-layer design after the Silver implementation is documented and committed.

## 12. Learning Rule for Future Work

For every significant step, record:

1. Goal and reason.
2. Alternatives considered.
3. Decision and justification.
4. SQL or code implemented.
5. Expected output and its evidence.
6. Actual output.
7. Errors, doubts, corrections, and solutions.
8. Concepts learned and interview relevance.
9. Remaining limitations and next action.

Never claim a command ran, a check passed, or a file was updated without evidence.

# Day 5 — Gold Layer Design, Implementation, and Validation

**Project:** AI-Powered E-Commerce Analytics
**Date:** 18 October 2026
**Working directory:** `C:\Users\Lenovo\Documents\AI-Ecommerce-Analytics
**Database:** `ecommerce_analytics`
**Main objective:** Design and implement a business-oriented Gold layer on top of the validated Silver layer, create analytical views, validate key metrics, and record the reasoning behind the decisions.

> Documentation rule: this journal records what was actually discussed, implemented, and observed during Day 5. It distinguishes verified results from design intentions and known limitations. The SQL files were saved and executed by the project owner in VS Code/pgAdmin; this document does not claim that the assistant edited the local repository directly.

---

## 1. Starting point and objective

At the start of Day 5:

- Bronze ingestion was complete for all nine historical Olist CSV files.
- Silver tables had been created, populated, and validated on Day 4.
- The `gold` schema already existed, but Gold tables and analytical views had not yet been implemented.
- The goal was to create an analytics-ready model suitable for SQL analysis and later Power BI reporting.
- The business scope had already been discussed and approved.

The goal was not to copy Silver data into another schema without a reason. Gold was intended to organize cleaned records into facts and dimensions, add derived/enriched attributes where useful, and expose reusable business queries through views.

## 2. Approved business questions and rules

The following scope and decisions were approved before Gold SQL implementation.

### 2.1 Business analysis scope

1. Sales/revenue by date, month, product category, customer location, and seller.
2. Order and delivery analysis: order status, delivery duration, early/on-time/late outcomes.
3. Customer analysis: repeat customers, purchase patterns, and RFM.
4. Product performance.
5. Seller performance.
6. Review satisfaction and subsequent same-product repurchase.

The user also specifically wanted to answer:

> How many customers are satisfied with a product and continue buying it, and how many try it once and do not return?

This question needs careful interpretation. The dataset's review belongs to an order, not a specific individual product. For a multi-product order, associating the order review with each product is an exploratory proxy, not proof that the customer gave each product an individual rating. A lack of later repurchase in a finite historical dataset does not prove that the customer will never return.

### 2.2 Approved business rules

- **Review satisfaction:** score 4–5 = `satisfied`; score 3 = `neutral`; score 1–2 = `dissatisfied`.
- **Revenue:** item `price` is item revenue; `freight_value` is reported separately. Do not add freight into the item-revenue metric.
- **Realized revenue:** use delivered orders only. Keep other statuses available for operational analysis, but exclude them from realized revenue.
- **Repeat purchase:** a later delivered order for the same customer and same product counts as a repeat purchase.
- **RFM reference date:** the day after the latest valid purchase date in the historical dataset.
- **RFM monetary value:** sum item prices from delivered orders; exclude freight.
- **Gold implementation:** core fact/dimension tables plus analytical views.

## 3. What was learned about Silver versus Gold

A key doubt during Day 5 was:

> If we transform Bronze into Silver, but the values copied from Silver to Gold may stay the same, why do we need Gold? Are we just loading the same data again?

Resolution:

- **Bronze** preserves source data as ingested, mostly with source values stored as text and ingestion metadata.
- **Silver** cleans and standardizes the data, converts types, applies keys/constraints, and maintains detailed source-oriented records.
- **Gold** organizes data around analytical/business concepts, using facts and dimensions, and derives useful fields or enriches records when required.
- Not every Gold column must change. Reusing a cleaned price or product identifier is intentional when that value is still needed.
- Gold is not required to alter every source value simply to be different.
- Gold tables may use a different grain, different set of columns, additional relationships, and derived attributes.
- Gold views calculate reusable business summaries from Gold tables.

### Example used to explain the concept

For `gold.fact_order_items`, source item details come from `silver.order_items`, while customer and purchase-date information are obtained by joining `silver.orders` on `order_id`. `purchase_date_key` is derived from the purchase date, and `item_quantity` is set to 1 because each source row represents one order-item line.

General pattern:

```sql
INSERT INTO gold.target_table (target_columns...)
SELECT source_columns_and_calculations...
FROM silver.source_table AS s
JOIN silver.other_source AS o
  ON s.join_key = o.join_key;
```

The `INSERT INTO` defines the Gold destination, `SELECT` defines the values to populate it, and `JOIN` combines related Silver entities where needed.

### Example business question

“Which product categories generated the most revenue from delivered orders?”

Silver has separate order, order-item, and product tables. A query joins them, filters to delivered orders, groups by category, and sums item prices. Gold has facts and dimensions organized for that analysis, and the same business question can be answered from the Gold fact/dimension model. The result should be equivalent when both queries apply the same business rules and correct joins.

Important learning: **Gold's value is its analytical organization, consistent business definitions, enrichment, and reusable reporting layer—not necessarily a change to every original value.**

## 4. Gold data model designed and implemented

Eight Gold tables were created: four dimensions and four fact tables.

### 4.1 Dimensions

| Table | Grain / purpose | Main fields and decisions |
|---|---|---|
| `gold.dim_customers` | One row per `customer_id` | `customer_id`, `customer_unique_id`, ZIP prefix, city, state |
| `gold.dim_products` | One row per `product_id` | Category, English category translation, product descriptive fields, photos, weight, dimensions |
| `gold.dim_sellers` | One row per `seller_id` | Seller ZIP prefix, city, state |
| `gold.dim_date` | One row per calendar date | Integer `date_key` formatted as YYYYMMDD, date, year, quarter, month number/name, day of month, ISO day of week |

`dim_products` uses a `LEFT JOIN` to category translation so products are retained even when the translation table has no matching English category.

`dim_date` is generated for every calendar day between the earliest and latest non-null order purchase dates. It contains 774 rows in the current dataset.

### 4.2 Facts

| Table | Grain / purpose | Main decisions |
|---|---|---|
| `gold.fact_orders` | One row per order | Order status, customer, purchase date key, order timestamps, delivery duration and outcome |
| `gold.fact_order_items` | One row per `(order_id, order_item_id)` | Product, seller, customer, purchase date key, price, freight, quantity |
| `gold.fact_payments` | One row per `(order_id, payment_sequential)` | Payment type, installments, payment value |
| `gold.fact_reviews` | One row per Silver review record | Uses `silver_review_row_id` as row identity because source `review_id` is not guaranteed unique; includes order/customer, score, satisfaction category, review timestamps |

### 4.3 Important data-type correction

During creation of `sql/05_create_gold_tables.sql`, the `order_item_id` type was corrected to match Silver:

```sql
order_item_id TEXT NOT NULL
```

The verified local output showed:

- Line 128: `order_item_id TEXT NOT NULL`
- Line 142: `PRIMARY KEY (order_id, order_item_id)`

The composite key was retained. `item_quantity INTEGER NOT NULL DEFAULT 1` and `CHECK (item_quantity = 1)` were intentional because each source row represents one item line.

### 4.4 Relationships and join safety

Gold fact tables reference dimension/fact keys according to the approved model. The item fact obtains its customer from the order. The date dimension is populated before fact rows that reference its date key.

Do not join multiple facts at their raw grains without thinking about multiplication. For example, an order with multiple item rows and multiple payment rows can multiply item and payment amounts if both fact tables are joined directly to each other. Aggregate each fact to the required grain or use the appropriate dimension model before combining measures.

Geolocation ZIP prefixes were not joined into sales facts. In the source, ZIP prefixes are not unique and can map to multiple coordinate pairs; a naïve join can multiply sales rows. A future geolocation analysis needs a defined aggregation/lookup strategy.

## 5. Delivery calculations

`gold.fact_orders.delivery_days` is calculated as the calendar-date difference between delivered-customer date and purchase date, only when both dates are present.

`delivery_outcome` is assigned as follows:

- `early`: delivered calendar date is before the estimated delivery calendar date.
- `on_time`: actual and estimated delivery calendar dates are equal.
- `late`: actual delivered calendar date is after the estimate.
- `unknown`: actual delivery date or estimated delivery date is missing.

These are calendar-day rules, not elapsed-hour calculations. Orders with unknown outcomes are retained; missing dates are not fabricated.

## 6. SQL files created/used during Day 5

The project `sql/` directory contained these files when checked:

```text
01_create_bronze_tables.sql
02_create_silver_tables.sql
03_load_silver_tables.sql
04_validate_bronze_silver.sql
05_create_gold_tables.sql
06_load_gold_tables.sql
07_create_gold_views.sql
08_validate_gold.sql
12_validate_gold_completely.sql
```

### 6.1 `sql/05_create_gold_tables.sql`

Purpose: create the eight Gold table structures only. It does not insert data.

The user ran the script in pgAdmin and verified the expected eight Gold table names. The script must not be rerun casually against the populated database because it uses `CREATE TABLE` rather than an idempotent migration.

### 6.2 `sql/06_load_gold_tables.sql`

Purpose: populate the four dimensions and four facts from Silver.

Load order:

1. `dim_customers`
2. `dim_products`
3. `dim_sellers`
4. `dim_date`
5. `fact_orders`
6. `fact_order_items`
7. `fact_payments`
8. `fact_reviews`

Reasons for this order:
- Dimensions are loaded before facts that reference them.
- The date dimension is loaded before facts reference `date_key`.
- Product translation uses a `LEFT JOIN` to preserve untranslated products.
- Fact rows retain source-level detail while adding customer/date information or derived business fields.

The user checked that all Gold tables were empty before the initial load. The initial load then succeeded according to the row counts shown in pgAdmin.

**Operational caution:** the load script is an initial-load script, not a safe rerunnable incremental load. If a script fails partway through, inspect the error and the state of each table before retrying. Do not blindly run the whole script again against partially populated tables.

### 6.3 `sql/07_create_gold_views.sql`

Purpose: create six reusable analytical views. It was executed in pgAdmin. Initially the catalog query returned no views; a diagnostic query confirmed the Gold tables existed but `gold.vw_sales_performance` was `NULL`. The user then executed the full views script; pgAdmin returned `CREATE VIEW`, and the subsequent catalog check showed all six views.

Views:

1. `gold.vw_sales_performance`
2. `gold.vw_delivery_performance`
3. `gold.vw_customer_rfm`
4. `gold.vw_product_performance`
5. `gold.vw_seller_performance`
6. `gold.vw_customer_satisfaction_repurchase`

#### View 1 — Sales performance

Grain: purchase date + product + customer location + seller. It aggregates delivered-order item revenue, freight, item count, and distinct order count.

#### View 2 — Delivery performance

One row per order, including order status, purchase date, actual delivery date, estimated delivery date, delivery duration, and delivery outcome.

#### View 3 — Customer RFM

Groups delivered purchases by `customer_unique_id` and calculates:
- Recency in calendar days relative to the day after the latest dataset purchase date.
- Frequency as distinct delivered orders.
- Monetary as sum of delivered item prices, excluding freight.
- `NTILE(5)` scores and an RFM segment.

**Scoring correction made during review:** recency score sorts by `recency_days ASC`, because fewer days since purchase is better and should receive a higher score. Frequency and monetary score ordering was retained as implemented. Segment labels in the current view are simple rules based on the sum of the three scores; they are project-defined labels, not a universal standard.

#### View 4 — Product performance

One row per product with delivered-order item count, distinct order count, item revenue, freight revenue, and average item price.

#### View 5 — Seller performance

One row per seller, including delivered item revenue, delivered freight, delivered order count, average delivery days, and late order count.

**Correction made during review:** average delivery days and late order count were restricted to `order_status = 'delivered'` so that seller delivery metrics consistently describe completed deliveries.

#### View 6 — Customer satisfaction and repurchase

One row per reviewed customer-product pair. The view associates each order review with the products in that order, then summarizes average review score and checks whether a later delivered order contains the same product for the same `customer_unique_id`.

**Correction made during review:** a `review_product_pairs` CTE uses `SELECT DISTINCT` on review row, score, order, customer identity, product, and reviewed order date before grouping. This prevents duplicate order/product associations from multiplying the same review within a product pair when the same product appears on multiple item lines in the same order.

**Limitation:** this is order-review-associated product analysis, not a confirmed product-specific rating. A multi-product order review is not evidence that the customer separately rated each product. No later same-product purchase in this historical dataset only means no matching later delivered purchase was observed in the available time window.

### 6.4 Validation scripts

- `sql/08_validate_gold.sql`: used for Gold table/view existence and related validation queries during development.
- `sql/12_validate_gold_completely.sql`: a comprehensive read-only validation script, created and run during Day 5. It returns a combined result grid with check number, name, actual value, expected value, status, and explanation.

The comprehensive script contains 32 checks:
1. Customer row count.
2. Product row count.
3. Seller row count.
4. Order fact row count.
5. Order-item fact row count.
6. Payment fact row count.
7. Review fact row count.
8. Date dimension row count (774 expected for this current dataset).
9. Date dimension continuity.
10. Orders missing purchase date key.
11. Order items missing purchase date key.
12. Order items without a matching order.
13. Order items without a matching product.
14. Order items without a matching seller.
15. Orders without a matching customer.
16. Order date keys without a matching date.
17. Payments without a matching order.
18. Reviews without a matching order.
19. Reviews without a matching customer.
20. Incorrect review satisfaction classifications.
21. Negative delivery durations.
22. Delivery view row count.
23. Sales view item revenue reconciliation.
24. Product view item revenue reconciliation.
25. Seller view item revenue reconciliation.
26. RFM customer count.
27. RFM monetary total reconciliation.
28. Satisfaction/repurchase view contains at least one row.
29. Products without English category translation (informational).
30. Orders with unknown delivery outcome (informational).
31. Reviews with missing score (informational).
32. Sellers with no delivered sales (informational).

The validation query is read-only and does not change Gold data.

## 7. Actual Gold row counts observed

The user shared a pgAdmin result grid after loading Gold. The observed counts were:

| Gold table | Observed rows | Expected / comparison |
|---|---:|---|
| `gold.dim_customers` | 99,441 | Matches `silver.customers` |
| `gold.dim_date` | 774 | Inclusive calendar range |
| `gold.dim_products` | 32,951 | Matches `silver.products` |
| `gold.dim_sellers` | 3,095 | Matches `silver.sellers` |
| `gold.fact_order_items` | 112,650 | Matches `silver.order_items` |
| `gold.fact_orders` | 99,441 | Matches `silver.orders` |
| `gold.fact_payments` | 103,886 | Matches `silver.order_payments` |
| `gold.fact_reviews` | 99,224 | Matches `silver.order_reviews` |

These matching counts support the initial load being complete at the row-count level. Matching counts alone do not prove that every individual value is correct; separate checks are still needed for values and business rules.

## 8. Actual analytical view row counts observed

The user ran a combined `COUNT(*)` query and shared the result grid:

| View | Observed rows | Interpretation |
|---|---:|---|
| `vw_customer_rfm` | 93,358 | Unique customers with delivered purchases |
| `vw_customer_satisfaction_repurchase` | 101,198 | Reviewed customer-product pairs |
| `vw_delivery_performance` | 99,441 | One row per order |
| `vw_product_performance` | 32,216 | Products with delivered sales |
| `vw_sales_performance` | 99,730 | Aggregated date/product/location/seller groups; not order count |
| `vw_seller_performance` | 3,095 | All sellers, including sellers with no delivered sales |

All six views were confirmed to exist and return data.

## 9. Comprehensive validation results observed

The user reported that checks 1–11 passed and shared a screenshot containing checks 12–32.

### 9.1 Checks reported as passing

The user confirmed checks 1–11 passed. The screenshot showed checks 12–28 passing as well.

- 1–7: Gold dimension/fact row counts match Silver source counts.
- 8: Date dimension count matches 774.
- 9: Date dimension continuity passed.
- 10–11: no missing purchase date keys.
- 12: zero order items without matching orders.
- 13: zero order items without matching products.
- 14: zero order items without matching sellers.
- 15: zero orders without matching customers.
- 16: zero non-null order date keys without matching dates.
- 17: zero payments without matching orders.
- 18: zero reviews without matching orders.
- 19: zero reviews without matching customers.
- 20: zero incorrectly classified review satisfaction categories.
- 21: zero negative delivery durations.
- 22: delivery view row count 99,441 equals order fact count.
- 23: sales view item revenue difference = 0.
- 24: product view item revenue difference = 0.
- 25: seller view item revenue difference = 0.
- 26: RFM customer count 93,358 equals the expected distinct delivered customer count.
- 27: RFM monetary total difference = 0.
- 28: satisfaction/repurchase view row count 101,198, satisfying the minimum-data check.

These checks support the initial Gold data load, relationships, classifications, and several important revenue calculations.

### 9.2 Informational findings (not failures)

| Check | Actual result | Interpretation |
|---|---:|---|
| 29 — Products without English category translation | 13 | Thirteen products have a non-null category that did not match a translation. Products with missing category names are not counted by this particular predicate. Earlier source exploration found 610 products missing category and related descriptive fields; that is a separate count. |
| 30 — Orders with unknown delivery outcome | 2,965 | Outcome is unknown when required delivery dates are missing. Earlier source analysis also found missing customer-delivery timestamps, so this result is plausible and should be documented rather than filled with invented dates. |
| 31 — Reviews with missing review score | 0 | All Gold review scores are present. |
| 32 — Sellers with no delivered sales | 125 | These sellers are in the seller dimension but have zero delivered-order sales in the current data. This is an analytical finding, not a load failure. |

### 9.3 Sales revenue reconciliation

The user ran a separate query comparing:
- Direct sum of `gold.fact_order_items.price` joined to delivered orders.
- Sum of `item_revenue` from `gold.vw_sales_performance`.

The user confirmed the totals matched. The comprehensive validation also showed zero revenue difference for:
- Sales performance view.
- Product performance view.
- Seller performance view.
- RFM monetary total.

This is an important result because careless fact-to-fact joins can multiply monetary values. The view checks support that these particular revenue totals reconcile to the delivered item-price baseline.

## 10. User doubts, corrections, and explanations during Day 5

| User doubt / concern | Explanation / resolution |
|---|---|
| “What is the difference between Silver table and Gold table?” | Silver is cleaned and structured source-oriented detail. Gold is organized around business entities and analysis, often using facts and dimensions. |
| “In Gold, we didn't change values. Is the same data loaded from Silver?” | Some original values intentionally remain unchanged. Gold can select different columns, join Silver tables, enrich attributes, derive date keys/delivery fields, and provide reusable metrics/views. Not every value must change. |
| “Show one example of organizing/calculating data for a business question.” | Used product category revenue from delivered orders: join orders, items, products; filter delivered; group by category; sum item prices. |
| “When a Gold table has a different structure, do values from multiple Silver tables go into it?” | Yes, where the model requires it: `fact_order_items` gets item details from `silver.order_items` and customer/date information from `silver.orders` through a join on `order_id`. Not every Gold table requires multiple Silver sources. |
| “Should we continue writing SQL scripts?” | Yes. The work proceeded through saved SQL scripts for Gold table creation, loading, views, and validation. |
| “Give me all queries at once.” | The complete initial load, view creation, and validation scripts were provided together rather than adding one isolated query at a time. |
| Why did the view-existence query return no rows initially? | The diagnostic confirmed Gold tables existed but `gold.vw_sales_performance` was `NULL`. The complete views script was then executed; pgAdmin returned `CREATE VIEW`, and all six views appeared in the catalog. |
| Why use `CREATE OR REPLACE VIEW`? | It allows a view definition to be created or updated without recreating underlying Gold tables or reloading data. |
| Why was the RFM recency sort changed? | Fewer days since last purchase is better. The score ordering was changed to `ORDER BY recency_days ASC` so more recent customers receive higher recency buckets. |
| Why restrict seller delivery metrics to delivered orders? | To make average delivery duration and late-order metrics consistently describe completed deliveries. |
| Why deduplicate review/product associations? | Prevent the same review from being counted repeatedly for a customer-product pair if that product appears on multiple item rows in the same order. |
| Why does a view's row count differ from its source table? | A view's grain can be different. Sales view rows are aggregated groups; RFM groups by customer identity; satisfaction view groups by reviewed customer-product pairs; product view includes only products with delivered sales. |
| Why are some results informational? | Missing translations, unknown outcomes, and sellers with no delivered sales reflect source coverage/business observations. They should be understood rather than automatically treated as failures. |
| Why validate revenue after loading? | Successful inserts and matching row counts do not prove measures are correct. Reconciliation checks compare the same business metric at different query paths. |

## 11. Important technical learning from Day 5

### 11.1 Grain matters

“Grain” means what one row represents. Examples:
- `fact_orders`: one order.
- `fact_order_items`: one order-item line.
- `fact_payments`: one payment sequence within an order.
- `fact_reviews`: one source review row.
- `dim_products`: one product.
- `vw_customer_rfm`: one customer identity with delivered purchases.
- `vw_customer_satisfaction_repurchase`: one reviewed customer-product pair.
- `vw_sales_performance`: one combination of the grouping fields.

A table or view's row count is meaningful only when its grain is understood.

### 11.2 Facts and dimensions

- **Fact tables** hold measurable events or transactional detail, such as orders, item lines, payments, and reviews.
- **Dimension tables** hold descriptive entities such as customers, products, sellers, and calendar dates.
- Facts reference dimensions to enable slicing metrics by customer, product, seller, or date.
- Dimensions should have stable unique keys appropriate to their grain.

### 11.3 Business metrics need explicit definitions

Revenue can mean different things. In this project:
- Item revenue = sum of `price`.
- Freight = sum of `freight_value`, reported separately.
- Realized revenue analysis filters to delivered orders.
- RFM monetary = delivered item-price sum.
- Frequency = distinct delivered orders, not number of item rows.
- Recency = calendar days from last delivered purchase to the selected historical reference date.

Definitions must be consistent between SQL, views, and future Power BI measures.

### 11.4 Views versus tables

- A table stores rows.
- A standard PostgreSQL view stores a query definition and calculates its result when queried; it does not store a separate copy of all result rows.
- `CREATE OR REPLACE VIEW` changes/creates the query definition.
- Gold tables were populated once; the six views were then created over those tables.
- The validation SQL is read-only.

### 11.5 A successful script is not full validation

Different evidence is needed for different questions:
- Table catalog query verifies tables exist.
- Row counts verify expected quantity at a high level.
- Foreign-key/orphan checks verify references.
- Metric reconciliation verifies totals are consistent across query paths.
- Business-rule checks verify definitions such as review categories.
- Informational checks reveal source limitations and business observations.

## 12. Day 5 implementation status

### Completed and evidenced

- [x] Gold table creation script executed.
- [x] Eight Gold tables verified in PostgreSQL.
- [x] Initial Gold load completed according to observed row counts.
- [x] All six analytical views created and verified in PostgreSQL.
- [x] All six views returned rows.
- [x] Gold table row counts compared with Silver source counts.
- [x] Relationship/orphan checks passed.
- [x] Review satisfaction classification check passed.
- [x] Delivery duration negative-value check passed.
- [x] Sales, product, seller, and RFM monetary totals reconciled.
- [x] Informational findings documented.
- [x] Core doubts about Silver-to-Gold transformation and fact/dimension organization discussed and resolved.

### Still required before calling Gold fully complete

- [ ] Save this complete Day 5 journal into `docs/learning/project-learning.md` (append it to the existing journal; do not replace the previous days).
- [ ] Review/update `docs/architecture-decisions.md` with the Gold model and business-rule decisions.
- [ ] Review the saved SQL files and ensure the comprehensive validation script is tracked.
- [ ] Perform a deeper review of satisfaction/repurchase business logic before treating it as final reporting truth.
- [ ] Consider whether the hard-coded expected date count of 774 in the validation script should remain as a dataset-specific expectation or be changed to a dynamic validation rule.
- [ ] Check `git status --short`, inspect the diff, stage only intended files, and commit/push at the agreed checkpoint.
- [ ] Do not claim the local documentation or GitHub repository has been updated until the user confirms the actual save/commit/push.

## 13. Next steps after Day 5

1. Update and review the project journal and architecture decision log.
2. Verify all intended SQL files are saved in the local `sql/` folder.
3. Review Git changes and commit/push the Gold milestone.
4. Continue with the next project milestone, likely connecting the Gold model and views to Power BI after confirming the intended analytics and metric definitions.
5. Continue documenting every question, design choice, correction, result, and limitation in the project learning journal.

## 14. Rules for future project work

For every significant step, record:
1. Goal and reason.
2. Alternatives considered.
3. Decision and justification.
4. SQL/code implemented and saved path.
5. Expected result and why it is expected.
6. Actual result and evidence.
7. User doubts, errors, corrections, and resolutions.
8. Learning and interview relevance.
9. Limitations and next action.

Additional workflow rules:
- Do not assume a file was saved or a script was executed without confirmation.
- Do not assume a query returned expected rows based only on a success message.
- Do not claim a check was performed unless its execution/result is known.
- Explain structural changes before implementing them.
- Keep SQL queries in version-controlled `sql/` files, not only in pgAdmin history.
- Do not rerun an initial-load script against populated tables without an explicit reloading plan.
- Choose SQL or Python based on the task, not merely to demonstrate a technology.
- Preserve source information unless a justified, documented cleaning rule says otherwise.

## Day 6 — Power BI Integration and Dashboard Development

### Objective
Connect Power BI to PostgreSQL and build an initial business analytics report using the Gold analytical views.

### Work Completed

- Connected Power BI Desktop to the local PostgreSQL database `ecommerce_analytics`.
- Imported the six Gold analytical views:
  - `gold.vw_sales_performance`
  - `gold.vw_delivery_performance`
  - `gold.vw_customer_rfm`
  - `gold.vw_product_performance`
  - `gold.vw_seller_performance`
  - `gold.vw_customer_satisfaction_repurchase`
- Organized the report into four pages:
  1. Executive Overview
  2. Customer Analytics
  3. Delivery & Operations
  4. Product & Seller Performance

### Executive Overview

Created visuals for total revenue, total orders, monthly revenue trend, and revenue by product category.

Revenue is based on delivered-order item prices. Freight is kept separate from item revenue. The dataset is historical and primarily covers 2016–2018; the monthly trend must not be interpreted as current business performance.

### Customer Analytics

Created visuals for:
- Repeat versus one-time customers.
- Customers by RFM segment.
- Satisfaction versus same-product repurchase.
- Satisfied customer–product pairs percentage.

The RFM view uses delivered-order purchasing behaviour. Its monetary metric excludes freight.

The satisfaction percentage is calculated from records in `gold.vw_customer_satisfaction_repurchase`. It represents the percentage of reviewed customer–product pair records classified as satisfied, not the percentage of unique customers.

The same-product repurchase analysis identifies a later delivered purchase in the available historical dataset. It does not prove that a customer will never return if no later purchase is observed. Reviews are associated with orders rather than necessarily with individual products.

### Delivery & Operations

Created visuals for delivered orders, delivery rate, delivery punctuality, and average delivery duration.

The Delivery Rate measure calculates the share of orders whose status is `delivered`.

The Average Delivery Duration card displays 12.50 days, based on delivered orders with available delivery-duration values.

Delivery outcomes are based on the available actual and estimated dates. Unknown outcomes must not be treated as late or on time.

### Product & Seller Performance

Created:
- Top 10 Products by Revenue.
- Top 10 Sellers by Revenue.
- Seller Delivery Performance scatter chart.
- Seller Late Order Rate chart.

The Top 10 charts rank products and sellers by item revenue, excluding freight.

The scatter chart compares delivered-order volume with late-order count. Absolute late-order counts can be affected by order volume, so they should not be used alone to judge seller reliability.

Created the `Late Order Rate` DAX measure:

```dax
Late Order Rate =
DIVIDE(
    SUM('gold vw_seller_performance'[late_order_count]),
    SUM('gold vw_seller_performance'[delivered_order_count]),
    0
)
```

The measure is formatted as a percentage with two decimal places. A temporary table was used to verify the calculation for a seller with 122 delivered orders and 19 late orders:

19 / 122 = 15.57%

### Power BI Learning

- A measure calculates a result dynamically according to the current filter context.
- A calculated column classifies individual rows, such as the `Customer Type` classification based on purchase frequency.
- Distinct count is appropriate when the business metric requires unique customer or order identities.
- Visual-level filters restrict the data used by an individual visual.
- A Top N filter helps display a readable ranking instead of thousands of product or seller IDs.
- Separate report pages make the dashboard easier to navigate and reduce visual clutter.

### Issues and Lessons Learned

- The PostgreSQL connection initially required selecting the correct saved credential scope.
- Power BI scatter-chart field wells differed from the initially described interface; the available fields had to be used instead.
- Searching for a specific seller ID in the visual filter did not return the expected result. This was not resolved; avoid claiming that the specific seller's rate was independently verified in the temporary table.
- A measure can calculate correctly for one seller without proving that every row and every business definition is correct. Validation should include multiple records and the intended aggregation level.

### Status at End of Day 6

- Gold tables and analytical views implemented and validated.
- Power BI connected to PostgreSQL.
- Initial four-page dashboard created.
- Power BI report saved; final local file path still needs to be verified.
- Day 6 documentation and Git review are pending.## Day 6 — Power BI Integration and Dashboard Development

### Objective
Connect Power BI to PostgreSQL and build an initial business analytics report using the Gold analytical views.

### Work Completed

- Connected Power BI Desktop to the local PostgreSQL database `ecommerce_analytics`.
- Imported the six Gold analytical views:
  - `gold.vw_sales_performance`
  - `gold.vw_delivery_performance`
  - `gold.vw_customer_rfm`
  - `gold.vw_product_performance`
  - `gold.vw_seller_performance`
  - `gold.vw_customer_satisfaction_repurchase`
- Organized the report into four pages:
  1. Executive Overview
  2. Customer Analytics
  3. Delivery & Operations
  4. Product & Seller Performance

### Executive Overview

Created visuals for total revenue, total orders, monthly revenue trend, and revenue by product category.

Revenue is based on delivered-order item prices. Freight is kept separate from item revenue. The dataset is historical and primarily covers 2016–2018; the monthly trend must not be interpreted as current business performance.

### Customer Analytics

Created visuals for:
- Repeat versus one-time customers.
- Customers by RFM segment.
- Satisfaction versus same-product repurchase.
- Satisfied customer–product pairs percentage.

The RFM view uses delivered-order purchasing behaviour. Its monetary metric excludes freight.

The satisfaction percentage is calculated from records in `gold.vw_customer_satisfaction_repurchase`. It represents the percentage of reviewed customer–product pair records classified as satisfied, not the percentage of unique customers.

The same-product repurchase analysis identifies a later delivered purchase in the available historical dataset. It does not prove that a customer will never return if no later purchase is observed. Reviews are associated with orders rather than necessarily with individual products.

### Delivery & Operations

Created visuals for delivered orders, delivery rate, delivery punctuality, and average delivery duration.

The Delivery Rate measure calculates the share of orders whose status is `delivered`.

The Average Delivery Duration card displays 12.50 days, based on delivered orders with available delivery-duration values.

Delivery outcomes are based on the available actual and estimated dates. Unknown outcomes must not be treated as late or on time.

### Product & Seller Performance

Created:
- Top 10 Products by Revenue.
- Top 10 Sellers by Revenue.
- Seller Delivery Performance scatter chart.
- Seller Late Order Rate chart.

The Top 10 charts rank products and sellers by item revenue, excluding freight.

The scatter chart compares delivered-order volume with late-order count. Absolute late-order counts can be affected by order volume, so they should not be used alone to judge seller reliability.

Created the `Late Order Rate` DAX measure:

```dax
Late Order Rate =
DIVIDE(
    SUM('gold vw_seller_performance'[late_order_count]),
    SUM('gold vw_seller_performance'[delivered_order_count]),
    0
)
```

The measure is formatted as a percentage with two decimal places. A temporary table was used to verify the calculation for a seller with 122 delivered orders and 19 late orders:

19 / 122 = 15.57%

### Power BI Learning

- A measure calculates a result dynamically according to the current filter context.
- A calculated column classifies individual rows, such as the `Customer Type` classification based on purchase frequency.
- Distinct count is appropriate when the business metric requires unique customer or order identities.
- Visual-level filters restrict the data used by an individual visual.
- A Top N filter helps display a readable ranking instead of thousands of product or seller IDs.
- Separate report pages make the dashboard easier to navigate and reduce visual clutter.

### Issues and Lessons Learned

- The PostgreSQL connection initially required selecting the correct saved credential scope.
- Power BI scatter-chart field wells differed from the initially described interface; the available fields had to be used instead.
- Searching for a specific seller ID in the visual filter did not return the expected result. This was not resolved; avoid claiming that the specific seller's rate was independently verified in the temporary table.
- A measure can calculate correctly for one seller without proving that every row and every business definition is correct. Validation should include multiple records and the intended aggregation level.


## 1. Why We Use Power BI

Power BI converts data into charts, KPI cards, and interactive reports to help businesses make decisions.

**Our data flow:**

CSV → Python → PostgreSQL Bronze → Silver → Gold → Power BI

We use Gold views because they contain prepared, business-oriented analytical data.

## 2. Visuals: When and Why to Use Them

| Visual | When to use | Our project example |
|---|---|---|
| Card | Display one important KPI | Total Revenue, Delivery Rate |
| Line chart | Show changes over time | Monthly Revenue Trend |
| Bar chart | Compare or rank categories | Top 10 Products by Revenue |
| Column chart | Compare a few categories | Repeat vs. One-Time Customers |
| 100% Stacked Column | Compare proportions across groups | Satisfaction vs. Repurchase |
| Scatter chart | Compare two numerical measures | Seller Delivery Performance |
| Table | Inspect exact values | Verify Late Order Rate |
| Slicer | Let users filter the report | Date, category, or seller filtering |

### How to choose fields

- **X-axis:** Time, categories, or a numeric measure, depending on the visual.
- **Y-axis:** Categories or numeric measures, depending on the visual.
- **Values:** The metric being calculated.
- **Legend:** Divides data into groups or series.
- **Size:** Controls the size of scatter-chart points.
- **Tooltips:** Show extra details when hovering over a visual.

The available field wells depend on the selected visual.

## 3. Aggregations: How to Choose

| Operation | Purpose | Example |
|---|---|---|
| Sum | Add numeric values | Total Revenue |
| Count | Count records or populated values | Record count |
| Distinct Count | Count unique identities | Total Orders |
| Average | Calculate the mean | Average Delivery Duration |
| Minimum / Maximum | Find the smallest or largest value | Earliest or latest date |

**Important:** Always understand the table's grain before selecting an aggregation. Our sales view contains grouped rows, so summing its `order_count` can overcount orders. We use distinct `order_id` from the one-row-per-order delivery view instead.

## 4. Filters and Conditions

| Type | Purpose | Example |
|---|---|---|
| Visual-level filter | Filter one visual | `order_status = delivered` |
| Page-level filter | Filter a report page | Analyze one year |
| Report-level filter | Filter the whole report | Restrict the reporting period |
| Top N filter | Show the highest or lowest items | Top 10 products by revenue |

We filter delivery duration to delivered orders because undelivered orders do not have a completed delivery duration.

## 5. Calculated Column vs. Measure

**Calculated column:** Creates a value for each row. Use it for row-level classifications.

Our example:

```dax
Customer Type =
IF(
    'gold vw_customer_rfm'[frequency] > 1,
    "Repeat Customer",
    "One-Time Customer"
)
```

**Measure:** Calculates a result according to the current filter context. Use it for totals, averages, rates, and percentages.

Our Late Order Rate measure:

```dax
Late Order Rate =
DIVIDE(
    SUM('gold vw_seller_performance'[late_order_count]),
    SUM('gold vw_seller_performance'[delivered_order_count]),
    0
)
```

Format this measure as a percentage with two decimal places.

## 6. Important DAX Functions

| Function | What it does |
|---|---|
| `IF` | Checks a condition and returns one of two results |
| `SUM` | Adds numeric values |
| `DISTINCTCOUNT` | Counts unique values |
| `CALCULATE` | Evaluates an expression under a modified filter context |
| `DIVIDE` | Divides safely when the denominator may be zero |
| `COUNTROWS` | Counts rows in a table expression |

A percentage measure generally returns a fraction. Percentage formatting displays `0.0971` as `9.71%`.

## 7. Our Main Business Metrics

| Metric | Meaning |
|---|---|
| Total Revenue | Sum of delivered-order item prices, excluding freight |
| Total Orders | Distinct orders across statuses |
| Delivery Rate | Delivered-status orders ÷ total orders |
| Average Delivery Duration | Average delivery days for eligible delivered orders |
| Repeat Customers | Customers with more than one delivered order |
| RFM Segments | Customer groups based on Recency, Frequency, and Monetary |
| Satisfaction Percentage | Satisfied records ÷ all records in the satisfaction view |
| Seller Late Order Rate | Late orders ÷ delivered orders |

The satisfaction percentage of 76.66% represents reviewed customer–product pair records, not unique customers.

The Olist data is historical, primarily from 2016–2018. These results are not live current business metrics.

## 8. Four Dashboard Pages

1. **Executive Overview:** Revenue, orders, monthly revenue trend, and category revenue.
2. **Customer Analytics:** Repeat customers, RFM segments, satisfaction, and repurchase.
3. **Delivery & Operations:** Delivery rate, punctuality, and average delivery duration.
4. **Product & Seller Performance:** Top products, top sellers, seller delivery volume, and late-order rate.

## 9. Key Rules to Remember

- Start with the business question before selecting a visual.
- Understand the source table's grain before counting or summing.
- Use distinct count when the question concerns unique identities.
- Keep freight separate from item revenue.
- Use the correct filters for the metric.
- A higher late-order count does not automatically mean worse seller performance; consider order volume and late-order rate.
- Correlation or association does not prove causation.
- Save the `.pbix` report with **Ctrl + S**.

**Day 6 takeaway:** Choose the right source, aggregation, filter, DAX calculation, and visual to answer each business question accurately.

# Day 7 — Project Review and Readiness Assessment

## 1. Objective

Review the existing AI-Powered E-Commerce Analytics Platform, verify the current development environment and project structure, assess completed components, and clarify the requirements for upcoming machine-learning and application-development milestones.

## 2. Environment Review

- Python version: 3.11.9
- Virtual environment: `.venv`
- Pandas: 3.0.6
- NumPy: 2.4.6
- SQLAlchemy: 2.1.4
- PostgreSQL driver: `psycopg` 3.3.6
- Configuration management: `python-dotenv` 1.2.4
- Notebook support: `ipykernel` 7.4.0

No `requirements.txt`, `pyproject.toml`, or `Pipfile` was present in the project root. The installed package list was reviewed. Additional dependencies will be considered when required by upcoming features.

**Decision:** Create an appropriate dependency manifest during a later development or documentation milestone, after reviewing the packages actually required by the project.

## 3. Project Structure Review

The visible project structure includes:

- `python/` — Python scripts and the exploratory analysis notebook.
- `sql/` — eight organized SQL scripts for Bronze, Silver, Gold, and validation.
- `docs/` — learning journal and architecture decisions.
- `data/` — raw-data directory.
- `screenshots/` — project screenshots.
- `AI_Ecommerce_Analytics.pbix` — Power BI report at the project root.
- `.env` and `.gitignore` — environment configuration and Git exclusion rules.
- `README.md` — project overview and documentation.

The `.env` file must remain excluded from GitHub. Its exclusion was not reverified during this review.

## 4. Python Exploration and Ingestion Review

### Exploration files

The project contains both `analyze_orders.ipynb` and `analyze_orders.py`.

The notebook supports interactive exploration, while the Python script contains basic order-data inspection. Their functionality overlaps.

**Decision:** Keep both files for now. Reassess the script later if it has no distinct purpose.

### Bronze ingestion

The existing `ingest_bronze.py` implements historical CSV ingestion into PostgreSQL's Bronze layer. It includes file hashing, ingestion-batch tracking, chunked loading, and handling for failed ingestion attempts.

The current implementation is designed around the existing historical dataset. It does not yet provide the complete simulated-event and manual-CSV ingestion workflow planned for the platform.

**Decision:** Preserve the existing implementation. Design and implement the additional ingestion workflow during the relevant future milestone, including validation, source identification, and duplicate handling.

## 5. SQL and Analytics Review

The project contains eight SQL scripts covering:

- Bronze table creation.
- Silver table creation and loading.
- Bronze-to-Silver validation.
- Gold table creation and loading.
- Gold analytical views.
- Gold-layer validation.

The existing Gold views support sales, delivery, customer RFM, product, seller, and customer satisfaction/repurchase analytics.

The customer RFM view already provides recency, frequency, monetary value, RFM scores, and rule-based customer segments.

**Key learning:** RFM segmentation is a business-rule-based method. It is not the same as K-means clustering or a trained customer inactivity-risk prediction model.

**Decision:** Reuse the existing RFM features for future clustering rather than rebuilding them unnecessarily.

## 6. Power BI Review

The existing Power BI report contains four pages:

1. Executive Overview
2. Customer Analytics
3. Delivery & Operations
4. Product & Seller Performance

The review confirmed that the planned visuals were present. A seller late-order-rate chart initially appeared to show only 100% values because the visual was scrollable and sorted in descending order. Scrolling revealed other rates, so no chart modification was required.

### Important metric definitions

- Revenue represents delivered-order item revenue where the relevant metric specifies delivered orders.
- Delivery rate is based on order status, not independent verification of receipt.
- The satisfaction percentage represents reviewed customer-product pairs classified as satisfied, not unique customers.
- The review-to-product association has limitations because review scores are associated with orders.

**Key learning:** Understand metric definitions, visual sorting, and scrolling before concluding that a chart or calculation is incorrect.

## 7. Future Ingestion Requirements

The platform is intended to support three data sources:

1. Historical Olist data.
2. Simulated transaction events.
3. Optional manually uploaded CSV files.

The future ingestion workflow should validate incoming data, identify its source, handle duplicates safely, report invalid records, and make accepted data available to downstream Silver and Gold processing.

Historical observations, synthetic records, and manually supplied data must remain distinguishable.

## 8. AI Insights Assistant Requirements

The planned AI Insights Assistant should answer business questions using verified analytics and appropriately evaluated model outputs.

Its intended scope includes:

- Historical sales and customer analytics.
- Analytics on newly ingested simulated or manual data.
- Comparisons between sources when their data is compatible.
- Customer segmentation and inactivity-risk predictions.
- Review sentiment insights.
- Revenue and order forecasts.
- Evidence-based business recommendations.

The assistant must not invent metrics or present synthetic data as actual business transactions.

**Important limitation:** The historical Olist dataset ends in 2018. A forecast based only on this dataset must not be presented as a current real-world sales forecast.

## 9. Development Decisions

- Preserve the current Bronze–Silver–Gold architecture.
- Keep both exploration files until their separate purposes are reassessed.
- Reuse the existing RFM view for future machine-learning work.
- Support both simulated events and manual CSV uploads in the future ingestion design.
- Build forecasts and predictions using evaluated models.
- Introduce new dependencies only when needed.
- Update the README during a later documentation milestone.
- Keep SQL queries in organized, version-controlled `.sql` files.

## 10. Next Milestones

| Milestone | Planned work |
|---|---|
| Day 8 | Python–PostgreSQL integration review and reusable analytics |
| Day 9 | K-means customer segmentation |
| Day 10 | Customer inactivity-risk baseline |
| Day 11 | Review sentiment analysis and sales forecasting |
| Day 12 | Simulated and manual CSV ingestion |
| Day 13 | FastAPI integration |
| Day 14 | AI Insights Assistant integration |
| Day 15 | End-to-end testing and final documentation |

The schedule is ambitious. Implementation, testing, and validation must take priority over simply marking milestones complete.

## 11. Day 7 Completion Summary

The project readiness review is complete. The environment, project structure, exploration files, Bronze ingestion design, SQL analytics, Power BI report, and future ingestion and AI requirements were reviewed.

No application code was changed, no packages were installed, and no Git staging, commit, or push was performed during Day 7.

**Status:** Day 7 — Completed.

# Day 8 — Python–PostgreSQL Integration and Reusable Analytics

## 1. Objective

Connect Python to the existing PostgreSQL analytics database and implement reusable functions that retrieve verified business metrics from the Gold analytical views.

## 2. Existing Database Connection

Reviewed `python/test_db_connection.py` and confirmed that it:

- Locates the project root.
- Loads database configuration from `.env`.
- Uses SQLAlchemy and the PostgreSQL `psycopg` driver.
- Checks that required database settings are available.
- Tests the connection by retrieving the current database and user.
- Disposes of the database engine after the test.

The connection test was executed successfully against `ecommerce_analytics`.

## 3. Existing Ingestion and Exploration Code

Reviewed `python/ingest_bronze.py` and `python/analyze_orders.py`.

The Bronze ingestion script loads historical CSV files into PostgreSQL and tracks ingestion batches. The exploration script reads the historical orders CSV and displays its shape, sample rows, column information, missing-value counts, and order-status distribution.

**Decision:** Keep these scripts separate from the new reusable analytics module. No refactoring was performed during Day 8.

## 4. Reusable Analytics Module

Created `python/analytics.py`.

The module loads database configuration, creates a SQLAlchemy engine, and defines three functions:

- `get_total_delivered_revenue()`
- `get_revenue_by_category()`
- `get_delivered_order_count()`

The first two functions query `gold.vw_sales_performance`. The delivered-order count uses `gold.vw_delivery_performance`.

The script also includes a verification section that runs when the file is executed directly.

## 5. Verification Results

| Metric | Verified result |
|---|---:|
| Total delivered-order item revenue | 13,221,498.11 |
| Delivered orders | 96,478 |

The top five categories returned by the category query were:

1. `health_beauty` — 1,233,131.72
2. `watches_gifts` — 1,166,176.98
3. `bed_bath_table` — 1,023,434.76
4. `sports_leisure` — 954,852.55
5. `computers_accessories` — 888,724.61

The revenue result matched the independent SQL query. The delivered-order count matched the count from `gold.vw_delivery_performance`.

## 6. Important Learning: Data Grain

The sales view groups data across dimensions such as date, product, customer location, and seller. Its aggregated `order_count` cannot automatically be treated as a count of distinct orders when summed across groups.

The delivery view contains one row per order, making it appropriate for counting orders by status.

**Lesson:** Select the analytical view according to the grain of the metric being calculated. Incorrect aggregation can produce misleading business metrics.

## 7. How This Supports Future Work

The Python analytics module establishes a reusable pattern for retrieving verified business metrics from PostgreSQL.

Future milestones can extend this approach to retrieve customer and sales data for:

- K-means customer segmentation.
- Customer inactivity-risk prediction.
- Revenue and order forecasting.
- FastAPI endpoints.
- The AI Insights Assistant.

Retrieving metrics is not itself a prediction. Machine-learning and forecasting models will require appropriate features, training, evaluation, and validation.

## 8. Decisions and Limitations

- Preserve the existing Bronze–Silver–Gold architecture.
- Keep the connection test separate from analytics functions.
- Reuse existing Gold views instead of duplicating their transformations.
- Avoid adding a shared connection module until its need is demonstrated.
- Introduce further analytics functions as required by upcoming milestones.

## 9. Day 8 Completion Status

**Status: Completed.**

Python successfully retrieved and verified total delivered-order item revenue, category-level revenue, and delivered-order counts from the existing PostgreSQL Gold views.

# Day 9 — K-means Customer Segmentation

## Objective

Apply K-means clustering to customer purchasing behaviour using the existing PostgreSQL Gold RFM view.

## Implementation

Created `python/customer_segmentation.py`.

The script:
- Retrieves customer ID, recency, frequency, and monetary value from `gold.vw_customer_rfm`.
- Scales the three numerical features using `StandardScaler`.
- Compares cluster counts from 2 to 7 using sampled silhouette scores.
- Selects the candidate with the highest sampled score.
- Fits the final K-means model on all customers.
- Saves customer-level cluster assignments to `data/processed/customer_segments.csv`.
- Prints a summary of each cluster.

## Evaluation Results

| Number of clusters | Sample silhouette score |
|---:|---:|
| 2 | 0.7418 |
| 3 | 0.4568 |
| 4 | 0.4923 |
| 5 | 0.4959 |
| 6 | 0.4273 |
| 7 | 0.4494 |

Two clusters had the highest sampled silhouette score of 0.7418 among the candidates tested.

## Cluster Summary

| Cluster | Customers | Average recency (days) | Average frequency | Average monetary |
|---:|---:|---:|---:|---:|
| 0 | 2,807 | 269.95 | 2.11 | 276.06 |
| 1 | 90,551 | 288.02 | 1.00 | 137.45 |

Cluster 0 contains a smaller group with higher average purchase frequency and monetary value. Cluster 1 contains mostly one-time customers with lower average monetary value.

These are descriptive interpretations of the observed averages, not predefined labels learned by K-means.

## Important Learning and Limitations

- K-means groups customers based on numerical feature similarity.
- Scaling helps prevent features with larger numerical ranges from dominating distance calculations.
- The silhouette score was calculated on a sample of 3,000 customers to avoid excessive memory usage.
- The final model was fitted on all 93,358 customers.
- Cluster IDs are arbitrary labels.
- The selected two-cluster solution is the best among the tested candidates, not proof that it is the only suitable business segmentation.
- RFM clustering is different from the existing rule-based RFM segmentation.
- The saved CSV is a generated data output and should remain excluded from Git.

## Day 9 Status

The K-means workflow ran successfully, cluster assignments were saved, and the initial results were recorded for future interpretation and integration.

# Day 10 — Customer Inactivity-Risk Prediction

## 1. Objective

The objective was to build a first machine-learning model that predicts whether a customer may become inactive, using historical customer purchase behaviour.

This milestone connects the existing PostgreSQL analytics pipeline to a machine-learning workflow in Python.

The goal was to learn the complete process:

1. Define a business problem that can be measured.
2. Select historical data and define a prediction target.
3. Build customer-level features using SQL.
4. Train a baseline classification model in Python.
5. Evaluate the model instead of relying only on accuracy.
6. Save the trained model for future predictions.
7. Load new customer features and generate predictions.
8. Document limitations before considering business use.

Important: this is an experimental baseline, not a production-ready customer-retention system.

## 2. Business Problem

An e-commerce business may want to identify customers who are at risk of becoming inactive so that it can investigate possible retention actions.

For this project, inactivity is defined using a specific historical observation window and a future outcome window.

A customer is labelled:

- Active (label 0): at least one delivered order during the future outcome window.
- Inactive (label 1): no delivered order during the future outcome window.

This definition is specific to this experiment. It does not mean that the customer has permanently left the business.

## 3. Why We Chose These Technologies

### PostgreSQL and SQL

We used PostgreSQL to retrieve and prepare historical customer purchase data because the source data is already stored in relational tables.

SQL is suitable for:

- Joining orders, customers, and order items.
- Filtering delivered orders.
- Grouping transactions by customer.
- Calculating recency, frequency, and monetary value.
- Creating a repeatable training dataset.

We did not move the entire relational dataset into Python to recreate every database operation. Instead, SQL prepares the required customer-level dataset and Python handles model training and prediction.

### Python and Pandas

Python is used to connect the database output to the machine-learning workflow.

Pandas provides a DataFrame that can be used to inspect labels, select features, check data types, and pass data to scikit-learn.

Python is also useful for evaluating the model, saving the trained model, and applying it to new customer records.

### Scikit-learn

Scikit-learn was selected because it provides the components needed for a straightforward, reproducible baseline:

- `train_test_split`: separates data for training and evaluation.
- `StandardScaler`: standardizes numerical features.
- `LogisticRegression`: trains a binary classification model.
- `classification_report`: reports precision, recall, F1-score, and support.
- `confusion_matrix`: shows the counts of correct and incorrect predictions.
- `Pipeline`: keeps feature scaling and model training together.

We selected Logistic Regression as a baseline because it is a relatively simple classification algorithm and gives us a starting point for comparison.

It is not automatically the best algorithm for this problem. More advanced models should only be considered after establishing a sound evaluation method.

### Why StandardScaler?

Recency, frequency, and monetary value have different numerical scales.

For example, frequency may be a small integer while monetary value may be several thousand. StandardScaler puts numerical features on a comparable scale by centring them and scaling them according to their standard deviation.

Scaling is useful for Logistic Regression because its optimization can be affected by features with very different scales.

The scaler is included in the Pipeline so that it is fitted using the training data and then applied consistently to the test data and future inputs.

### Why class_weight="balanced"?

The historical labels are highly imbalanced: very few customers purchased during the future outcome window compared with customers who did not.

A model that mostly predicts the majority class could obtain apparently good accuracy while failing to identify the less common class.

`class_weight="balanced"` adjusts the training penalty for each class according to its frequency. It gives the minority class more influence during training.

This does not guarantee a good model. It can also increase false-positive predictions, so precision, recall, and other metrics still need to be checked.

### Why save the model with joblib?

Training a model every time a prediction is requested would be unnecessary for this initial workflow.

The trained model and its supporting metadata are saved in:

`models/inactivity_risk_model.joblib`

The saved bundle includes the model and information such as the feature names, target definition, observation cutoff, outcome window, and label descriptions.

This makes it possible for a separate prediction script to load the model without repeating the training process.

The model file is a generated artifact and should not be committed to Git unless a deliberate model-versioning policy is established.

## 4. Historical Data Investigation

Before building the model, we investigated the available historical data.

Important findings:

- The historical dataset contains 99,441 rows in the orders table.
- The orders table includes multiple statuses, not just delivered orders.
- There are 96,478 orders with status `delivered`.
- The latest purchase timestamp among delivered orders was August 29, 2018.
- The latest purchase timestamp across all orders was October 17, 2018.
- The historical data does not represent current 2026 customer behaviour.

We therefore cannot describe this dataset as live customer data or claim that the resulting model has been validated on current customers.

## 5. Why We Used a Historical Cutoff

To train a predictive model, the features must be calculated from information available before the outcome being predicted.

We used June 1, 2018 as the observation cutoff.

The feature window includes delivered purchases before June 1, 2018. The outcome window covers June 1, 2018 through August 29, 2018, inclusive.

The SQL uses an exclusive upper timestamp boundary of August 30, 2018 to include all purchases on August 29.

This design helps prevent future purchase information from leaking into the historical features.

For example, a customer's purchase on July 15, 2018 must not increase the customer's frequency feature when predicting whether the customer will purchase during the June–August outcome window.

This separation between features and outcomes is essential for predictive modelling.

## 6. Customer Features

We created three features for each customer.

| Feature | Meaning | Why it matters |
|---|---|---|
| `recency_days` | Number of days between the June 1 cutoff date and the customer's latest eligible delivered purchase | Measures how recently the customer purchased |
| `frequency` | Number of distinct eligible delivered orders before the cutoff | Measures historical purchase frequency |
| `monetary` | Sum of item prices across eligible delivered orders before the cutoff | Measures historical item spending |

The monetary feature uses item prices and does not include freight charges.

These features are based on RFM analysis:

- Recency
- Frequency
- Monetary value

RFM is useful because it summarises customer behaviour in a small number of interpretable features.

However, these three features do not capture every possible factor affecting inactivity. For example, they do not include customer demographics, marketing exposure, product preferences, or reasons for not purchasing.

## 7. SQL Files Created

### `sql/11_inactivity_risk_data_check.sql`

Purpose: investigate the historical data and confirm that there is a meaningful observation period and future outcome period.

The queries examined order statuses, date coverage, eligible customers, and purchase behaviour across time windows.

Key findings:

- 75,387 eligible customers had at least one delivered order before June 1, 2018.
- 419 eligible customers had at least one delivered order in the June 1–August 29 outcome window.
- 74,968 eligible customers had no delivered order during that outcome window.

The query file keeps the investigation documented and repeatable instead of leaving the work only in pgAdmin Query Tool history.

### `sql/12_build_inactivity_training_data.sql`

Purpose: create the customer-level dataset used by the machine-learning model.

The query performs the following operations:

1. Selects eligible delivered orders before June 1, 2018.
2. Joins orders to customers and order items.
3. Calculates the value of each eligible order using item prices.
4. Aggregates orders by customer to calculate recency, frequency, and monetary value.
5. Identifies customers with delivered orders during the outcome window.
6. assigns label 0 to active customers and label 1 to inactive customers.
7. Returns one record per eligible customer.

The query produced 75,387 customer records.

The label distribution was:

- Active: 419 customers.
- Inactive: 74,968 customers.

These counts add up to 75,387.

The training query uses a historical cutoff and outcome window so that the features and labels represent different periods.

## 8. Why We Used a Train/Test Split

A model should not be evaluated only on the same records used to train it.

We used an 80/20 train/test split with stratification and a fixed random seed.

- Training data: used to fit the model.
- Test data: held aside to evaluate its predictions.
- Stratification: preserves approximately the same class proportions in both sets.
- Random seed: makes the random split reproducible.

This is a useful initial experiment, but it is not the strongest validation method for time-dependent customer behaviour.

A future improvement is to evaluate the model across multiple historical cutoffs or use a strictly later time period for testing. That would better simulate the task of predicting future behaviour from past data.

## 9. Python Model File

File: `python/inactivity_risk_model.py`

The script performs these steps:

1. Connects to PostgreSQL using the project's database configuration.
2. Executes the SQL in `sql/12_build_inactivity_training_data.sql`.
3. Loads the returned customer-level data into Pandas.
4. Separates the feature columns from the target label.
5. Splits the data into training and test sets.
6. Builds a Pipeline containing StandardScaler and Logistic Regression.
7. Trains the model using the training data.
8. Generates predictions for the held-out test data.
9. Prints the classification report and confusion matrix.
10. Saves the trained model and supporting metadata using joblib.

### Why use a Pipeline?

The Pipeline combines preprocessing and model training into one object.

This reduces the risk of accidentally applying a different scaling procedure during prediction. It also helps prevent test data from influencing the fitted scaler.

The Pipeline is a cleaner approach than manually fitting separate preprocessing steps for training and prediction.

## 10. Actual Model Evaluation

The training script ran successfully and reported the following test-set metrics:

| Metric | Active class | Inactive class |
|---|---:|---:|
| Precision | 0.01 | 1.00 |
| Recall | 0.54 | 0.59 |
| F1-score | 0.01 | 0.74 |
| Test support | 84 | 14,994 |

Test-set accuracy was approximately 0.59.

The confusion matrix, with actual classes as rows and predicted classes as columns, was:

| Actual / Predicted | Active | Inactive |
|---|---:|---:|
| Active | 45 | 39 |
| Inactive | 6,114 | 8,880 |

### How to interpret these results

For the Active class:

- 45 active customers were correctly predicted as active.
- 39 active customers were incorrectly predicted as inactive.
- The model also predicted many inactive customers as active, resulting in very low active-class precision.

For the Inactive class:

- 8,880 inactive customers were correctly predicted as inactive.
- 6,114 inactive customers were incorrectly predicted as active.

The inactive-class precision rounds to 1.00 in the displayed report because almost all records predicted as inactive were actually inactive. The displayed rounded value should not be interpreted as perfect performance.

### Main conclusion

The model has learned a classification pattern, but its performance is not good enough for reliable business decisions.

The active-class precision is approximately 0.01, which means that the model generates many false positives when trying to identify active customers.

Accuracy alone is not a suitable success measure for this dataset because the inactive class dominates the data.

The next model iteration should focus on evaluating the minority class, comparing useful baselines, examining decision thresholds, and using stronger time-based validation.

Do not claim that this model reliably identifies customers who will become inactive.

## 11. Why We Created a Separate Prediction Script

File: `python/predict_inactivity_risk.py`

The training script and prediction script have different responsibilities.

`inactivity_risk_model.py` trains and evaluates the model.

`predict_inactivity_risk.py` loads an already-trained model and applies it to new customer feature records.

Separating the scripts makes the workflow easier to understand and allows predictions to be tested without retraining the model every time.

The prediction script:

1. Loads `models/inactivity_risk_model.joblib`.
2. Reads `data/processed/new_customers_for_prediction.csv`.
3. Checks for the required feature columns and missing or invalid numerical inputs.
4. Passes the feature values to the saved Pipeline.
5. Generates predicted labels and estimated inactivity probabilities.
6. Saves the results to `data/processed/inactivity_risk_predictions.csv`.

The current input file uses these columns:

- `customer_id`
- `recency_days`
- `frequency`
- `monetary`

The `customer_id` column identifies each input record. It is not one of the three model features.

## 12. Prediction Test and Important Caveat

The prediction script ran on five example records.

The displayed results included:

| Example customer | Recency days | Frequency | Monetary value | Predicted status | Estimated inactivity probability |
|---|---:|---:|---:|---|---:|
| CUST001 | 180 | 1 | 100 | Inactive | 0.5160 |
| CUST002 | 10 | 8 | 15,000 | Inactive | 0.8226 |
| CUST003 | 60 | 3 | 2,500 | Active | 0.3016 |
| CUST004 | 300 | 1 | 50 | Inactive | 0.5610 |
| CUST005 | 30 | 5 | 5,000 | Active | 0.1796 |

These inputs are synthetic examples, not verified real customers.

The prediction for CUST002 is a useful warning: despite its recent purchase, high frequency, and high monetary value, the model estimated a high inactivity probability.

This illustrates why successful execution is not the same as a trustworthy prediction. The model's learned relationships and class weighting need further investigation.

The estimated probabilities are model outputs, not validated real-world probabilities. They have not been demonstrated to be well calibrated.

The CSV and model files are generated outputs. They should remain outside the Git commit unless there is a deliberate reason to version them.

## 13. Errors, Decisions, and Lessons

### Lesson 1: An imbalanced dataset changes how we evaluate a model

A model can have a seemingly reasonable accuracy while performing poorly on a class that matters to the business.

Always inspect class counts and use class-specific precision, recall, F1-score, and a confusion matrix.

### Lesson 2: Class weighting is not a complete solution

`class_weight="balanced"` helps the minority class influence training, but it does not guarantee useful predictions.

It can create more false positives, so its effect must be evaluated.

### Lesson 3: Historical cutoff dates matter

Features must be calculated using information available before the prediction point.

Including future purchases in historical frequency or monetary values would leak outcome information into the model.

### Lesson 4: A probability is not automatically calibrated

The model's predicted probability should not be described as the verified likelihood that a customer will become inactive.

Calibration and threshold selection require additional evaluation.

### Lesson 5: A saved model is not automatically a production service

The current model is loaded by a Python script. It is not yet connected to FastAPI, a scheduled retraining process, a live event pipeline, or a production monitoring system.

Those components must be implemented and tested separately.

### Lesson 6: Data quality and model quality are different

A SQL query can return the expected number of rows and the Python script can complete successfully while the resulting model remains weak.

Database validation confirms aspects of the input data. Model evaluation assesses predictive performance. Both are necessary.

## 14. Current Status

Implemented and executed:

- Historical customer feature and label query.
- Customer inactivity-risk baseline training script.
- Train/test evaluation.
- Saved model bundle.
- Separate prediction script.
- Prediction output CSV using synthetic example inputs.
- SQL investigation and training-query files.

Not yet established:

- Reliable predictive performance on genuinely future data.
- Performance on current 2026 customer behaviour.
- Probability calibration.
- A suitable business decision threshold.
- Scheduled retraining and model monitoring.
- Production API integration.

The model is therefore an experimental milestone, not a completed production prediction system.

## 15. Interview Learning

**Why did we use Logistic Regression?**

It provides a relatively simple baseline for binary classification. We can compare more complex models against it later.

**Why was accuracy insufficient?**

The labels are highly imbalanced. Class-specific metrics and the confusion matrix reveal errors hidden by the overall accuracy.

**What is data leakage?**

Data leakage occurs when training features include information that would not have been available at prediction time, or when evaluation information improperly influences training.

**Why use a historical cutoff?**

It separates the period used to calculate customer behaviour from the future period used to define the outcome.

**Why use a Pipeline?**

It combines preprocessing and the estimator, keeping training and prediction transformations consistent.

**What is the difference between a predicted label and a probability?**

The label is the selected class. The probability is the model's estimated score for a class; it is not automatically a calibrated real-world likelihood.

**Why is the model not production-ready?**

Its active-class precision is extremely low, its validation is limited, its probability calibration is unknown, and it has not been evaluated on a genuinely later customer population.

## 16. Next Steps

1. Preserve the current results as the baseline.
2. Compare a simple rule-based baseline with Logistic Regression.
3. Investigate the effect of class imbalance and decision thresholds.
4. Prefer time-based validation for the next model evaluation.
5. Avoid claiming reliable predictions until the evaluation supports that claim.
6. Continue with the next project milestone: review sentiment analysis and sales forecasting.