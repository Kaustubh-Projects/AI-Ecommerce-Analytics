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