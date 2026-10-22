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

# Day 11 — Review Sentiment Analysis and Sales Forecasting

## 1. Objective

Implement two analytical capabilities:
1. Classify customer review text into broad sentiment categories.
2. Establish a baseline for forecasting monthly delivered-order item revenue.

The goal was to learn the complete process from PostgreSQL data retrieval through Python modelling, evaluation, and saving generated outputs.

## 2. Sentiment Analysis

### Data findings

The Silver review table contains 99,224 review records. Of these, 40,968 have usable review text, while 58,256 do not.

Only reviews with non-empty text and a valid review score were used for the text-classification experiment.

### Why TF-IDF?

TF-IDF converts text into numerical features that a machine-learning algorithm can process. It gives words a weight based on their importance within the document collection.

We used unigrams and bigrams so the model could learn individual words and two-word expressions.

### Why Logistic Regression?

Logistic Regression is a relatively simple text-classification baseline. It provides a practical starting point before introducing more complex NLP models.

The model uses a scikit-learn Pipeline containing TF-IDF and Logistic Regression. This keeps text preprocessing and classification together and helps prevent preprocessing leakage across the training/test split.

### Label definition

We derived approximate sentiment labels from review scores:
- Scores 1–2: Negative
- Score 3: Neutral
- Scores 4–5: Positive

These are proxy labels, not independently verified human sentiment labels.

### Actual results

Reviews used: 40,968

Label distribution:
- Positive: 26,521
- Negative: 10,890
- Neutral: 3,557

Test classification report:

| Class | Precision | Recall | F1-score | Support |
|---|---:|---:|---:|---:|
| Negative | 0.80 | 0.78 | 0.79 | 2,178 |
| Neutral | 0.24 | 0.45 | 0.31 | 711 |
| Positive | 0.96 | 0.84 | 0.90 | 5,305 |
| Macro average | 0.66 | 0.69 | 0.67 | 8,194 |
| Weighted average | 0.85 | 0.79 | 0.82 | 8,194 |

Accuracy: 0.79.

### Interpretation

The model performs best on positive reviews. Negative classification is also useful as an initial baseline. Neutral classification is weak, with an F1-score of 0.31.

The classes are imbalanced, and a numeric review score does not always represent the sentiment expressed in the text. Therefore, these results measure agreement with score-derived labels, not verified human sentiment accuracy.

### Output

Python script:
`python/review_sentiment_analysis.py`

Generated predictions:
`data/processed/review_sentiment_predictions.csv`

The output contains the original review fields, score-derived sentiment labels, and predicted sentiment.

The generated CSV is an output artifact and should not be included in the normal source-code commit.

## 3. Sales Forecasting

### Data preparation

The SQL query aggregates delivered-order item revenue by purchase month.

We used:
- `DATE_TRUNC('month', order_purchase_timestamp)` to aggregate by month.
- `COUNT(DISTINCT order_id)` to count orders without multiplying orders containing several items.
- `SUM(order_items.price)` to calculate item revenue without freight.

SQL file:
`sql/14_sales_forecasting_data.sql`

### Why a chronological split?

Time-series forecasting must respect time order. Training on later observations and testing on earlier ones would not simulate a real future prediction.

We used the first 19 monthly observations for training and the final five months for testing.

The observed period contains 24 calendar months, from September 2016 through August 2018.

### Why start with a simple baseline?

Before choosing a complex forecasting model, we need a benchmark. The baseline predicts every test month using the final training month's revenue.

This makes it possible to check whether a future model improves on a simple reference.

### Actual baseline results

| Month | Actual item revenue | Baseline forecast |
|---|---:|---:|
| April 2018 | R$973,534.09 | R$953,356.25 |
| May 2018 | R$977,544.69 | R$953,356.25 |
| June 2018 | R$856,077.86 | R$953,356.25 |
| July 2018 | R$867,953.46 | R$953,356.25 |
| August 2018 | R$838,576.64 | R$953,356.25 |

MAE: R$68,365.41

RMSE: R$78,642.62

### Interpretation

MAE measures average absolute forecasting error. RMSE gives larger errors more weight.

The baseline does not adapt to the declining revenue in the later test months. The evaluation is limited because it uses only five test observations.

The historical dataset ends in 2018. These results must not be presented as evidence of current 2026 sales performance or a reliable current sales forecast.

### Output

Python script:
`python/sales_forecasting.py`

Generated evaluation:
`data/processed/sales_forecast_evaluation.csv`

The generated CSV should remain outside the normal source-code commit.

## 4. Errors and Lessons

- The first sentiment script failed because `test_db_connection.py` did not define the assumed `get_engine()` function.
- We preserved the existing connection-test script and adapted the sentiment script to create its own SQLAlchemy engine using the existing `.env` settings.
- The review dataset contains substantial missing text, so not every review can be classified.
- The sentiment labels are derived from scores and are not perfect ground truth.
- Class imbalance affects sentiment evaluation, particularly neutral sentiment.
- A successful script execution does not prove that a model is reliable.
- A chronological test split is more appropriate for forecasting than a random split.
- A constant baseline is useful for comparison but does not capture changing trends or seasonality.

## 5. Current Status

Completed:
- Review data inspection.
- Sentiment classification baseline.
- Classification evaluation.
- Sentiment prediction CSV generation.
- Monthly revenue aggregation query.
- Chronological sales forecasting baseline.
- MAE and RMSE evaluation.
- Forecast evaluation CSV generation.

Remaining:
- Compare an improved forecasting model with the baseline.
- Investigate neutral sentiment errors.
- Validate model quality beyond score-derived labels where feasible.
- Integrate evaluated outputs into the application and AI Insights Assistant later.

Day 11 establishes working experimental baselines, not production-ready models.


## Day 12 — Incoming Order Event Pipeline

### Objective
Build a pipeline that accepts manual CSV order events and simulated events, stores them in PostgreSQL, transforms them, and exposes them through a Gold view.

### Implementation Completed

1. Created `bronze.order_events` to store incoming event data.
2. Created `silver.order_events` to store transformed event data with a PostgreSQL timestamp.
3. Added indexes for order ID, purchase timestamp, and event source.
4. Implemented `python/ingest_order_events.py` to:
   - Read incoming CSV files in chunks.
   - Check required columns and reject blank required values.
   - Validate purchase timestamps.
   - Skip duplicate event IDs.
   - Record the event source and source filename.
   - Insert records into Bronze using a database transaction.
5. Implemented `python/simulate_order_events.py` to generate five synthetic events per run and save them as timestamped CSV files.
6. Implemented `python/run_pipeline.py` to orchestrate ingestion, transformation, and pipeline verification.
7. Created `sql/16_transform_order_events.sql` to transform Bronze events into Silver.
8. Created `sql/17_create_order_event_view.sql` to expose Silver events through `gold.vw_order_event_activity`.
9. Created `sql/18_validate_order_event_pipeline.sql` with 18 numbered SQL validation queries.
10. Updated `.gitignore` to exclude files inside `data/incoming/`.

### Architecture

Manual CSV or simulated events
→ Python ingestion
→ Bronze
→ SQL transformation
→ Silver
→ Gold event activity view

Incoming order events remain separate from historical Olist sales and revenue metrics.

### Results Confirmed

- Bronze events: 26
- Silver events: 26
- Gold view events: 26
- Unique event IDs in Gold: 26
- Manual CSV events: 2
- Simulated events: 24
- Duplicate event IDs were handled without creating duplicate records.
- A CSV row with a blank required customer ID was rejected.
- The duplicate-test record was removed after testing.
- The invalid-input test record was not inserted into Bronze.
- Python syntax compilation for `python/run_pipeline.py` completed without errors.

### Important Learning

- Bronze preserves incoming timestamp values as text.
- Silver stores purchase timestamps as PostgreSQL `TIMESTAMP`.
- A primary key and `ON CONFLICT (event_id) DO NOTHING` help prevent duplicate event insertion.
- Database transactions help prevent partial ingestion when a file fails during processing.
- Synthetic events are useful for testing ingestion but are not real historical sales.
- A Gold view does not automatically update historical sales or revenue metrics.

### Remaining Work

- Run end-to-end tests on the updated `python/run_pipeline.py`.
- Test duplicate IDs across CSV chunks and additional invalid-input cases.
- Complete Day 13 pipeline validation.
- Update and push the learning journal and architecture documentation.
- Update README on Day 15.

### Git

Implementation files for the incoming order-event pipeline were committed and pushed to GitHub. Documentation changes are pending.


## Day 13 — End-to-End Testing and Data Quality

### Objective
Verify the incoming order-event pipeline from CSV ingestion through Bronze, Silver, and Gold.

### Tests Completed

1. Ran the updated pipeline in simulation mode.
2. Confirmed five new simulated events were ingested.
3. Verified the updated pipeline reported zero Bronze events missing from Silver.
4. Ran manual ingestion using `data/incoming/manual_orders.csv`.
5. Re-ingested the same manual CSV and confirmed both existing event IDs were skipped.
6. Created a 1,001-row CSV to test a repeated event ID across separate 1,000-row chunks.
7. Confirmed 1,000 records were inserted and one duplicate was skipped.
8. Removed the temporary chunk-test records from Bronze and Silver.
9. Submitted a CSV containing an invalid timestamp.
10. Confirmed Python rejected the timestamp and the event was not inserted into Bronze.
11. Removed the temporary chunk-test and invalid-timestamp CSV files.
12. Rechecked the final layer counts.

### Final Results

- Bronze: 31 events
- Silver: 31 events
- Gold view: 31 events
- Unique event IDs in Gold: 31
- Manual events: 2
- Simulated events: 29
- Bronze events missing from Silver: 0

### Important Learning

- Database constraints provide protection beyond Python's within-chunk duplicate check.
- Idempotent ingestion allows the same CSV to be submitted again without inserting duplicate event IDs.
- Invalid data should be verified as absent from the database after rejection.
- Temporary test records and files must be cleaned up after testing.

### Remaining Work

- Review any remaining edge cases only if needed.
- Review FastAPI and the AI insights assistant on Day 14.
- Update and push documentation with the planned commit.
- Complete the README and final project review on Day 15.

### Git

Day 12 implementation was pushed to GitHub. Day 13 test results and documentation are pending the next documentation commit.

# Day 14 — Generative AI Assistant Integration

## 1. Objective

The objective of Day 14 was to integrate a genuinely generative AI assistant into the existing AI-Powered E-Commerce Analytics Platform.

Before this work, the project already contained:
- PostgreSQL schemas: Bronze, Silver and Gold.
- SQL analytics views.
- Python analytics functions.
- Machine-learning analyses for customer segmentation, inactivity risk, review sentiment and sales forecasting.
- A FastAPI application exposing business KPI endpoints.

The goal was to reuse these existing components rather than rebuild them.

The new assistant connects the existing analytics layer to a generative AI model through the Groq API.

## 2. Architecture Before Implementation

The existing analytics flow was:

1. Historical Olist CSV data was ingested into PostgreSQL.
2. Data was organized into Bronze, Silver and Gold schemas.
3. SQL views provided business metrics.
4. Python functions retrieved these metrics.
5. FastAPI exposed selected metrics through API endpoints.

The existing KPI endpoints were:
- `GET /`
- `GET /kpis/summary`
- `GET /kpis/categories`

The generative AI assistant was added as an additional capability without replacing these endpoints.

## 3. Why We Chose Direct API Integration

We considered using a locally hosted language model and an external AI service.

A local model would require additional setup and software, which was not preferred for this project.

We selected direct API integration because:
- The application can call a hosted language model over HTTPS.
- No additional AI SDK was required.
- Python's built-in `urllib.request` can send HTTP requests.
- The existing FastAPI application can expose the AI functionality.
- The application can provide verified business metrics as context to the model.

This approach requires an internet connection, a valid API key and an available model. Free-tier availability and request limits may change.

## 4. Groq Account and Model Setup

### Step 1: Create access

A GroqCloud account was created, and an API key was generated for the project.

The account's Billing page showed the Free plan at $0.00. The Groq Playground successfully generated a response using the selected model:

`openai/gpt-oss-120b`

The Playground test confirmed that the model could respond to a harmless prompt. It did not, by itself, prove that direct API requests would work.

### Step 2: Store the API key

The API key was stored locally in the project's `.env` file:

`GROQ_API_KEY=your_actual_groq_api_key`

The placeholder above is illustrative. The actual key must remain private.

The key must never be:
- Hardcoded into Python source code.
- Committed to GitHub.
- Included in API responses.
- Pasted into chat messages or shared screenshots.

The existing `.gitignore` excludes `.env` from version control.

### Step 3: Test direct API access

A temporary test file, `test_groq_api.py`, was created in the project root.

The test used:
- Python's `json` module to encode the request.
- Python's `os` module to read the environment variable.
- `urllib.request` to send the HTTP request.
- `urllib.error` to handle HTTP errors.
- `python-dotenv` to load `.env`.

The endpoint was:

`https://api.groq.com/openai/v1/chat/completions`

The selected model was `openai/gpt-oss-120b`.

The first request returned HTTP 403 with error code 1010. Adding the following request header allowed the test to succeed:

`User-Agent: AI-Ecommerce-Analytics/1.0`

The subsequent test returned HTTP 200 and a response beginning with `Groq API`.

This verified that the direct API request could succeed. The initial response did not reproduce the entire requested sentence, so the test was treated as a connectivity check rather than a complete prompt-quality test.

The temporary test file was retained for the time being. Its final repository status and whether it should remain as a permanent test must be reviewed before committing.

## 5. Create `python/ai_assistant.py`

The assistant module was created to separate AI-related logic from the FastAPI entry point.

It contains three main functions.

### 5.1 `get_business_context()`

Purpose: retrieve selected business metrics from the existing analytics layer.

It reuses these functions from `analytics.py`:
- `get_total_delivered_revenue()`
- `get_delivered_order_count()`
- `get_revenue_by_category()`

The returned context includes:
- Total delivered revenue.
- Delivered order count.
- The five highest-revenue categories.

The context is assembled into a Python dictionary.

Revenue values are converted to floating-point numbers, and the delivered order count is converted to an integer. Missing category names are represented as `Unknown category`.

The function reuses existing SQL analytics instead of duplicating database queries in the AI module.

### 5.2 `build_ai_prompt(question, business_context)`

Purpose: prepare the business question and evidence for the generative model.

The function converts the business context dictionary into formatted JSON using:

`json.dumps(business_context, indent=2, ensure_ascii=False)`

The prompt instructs the model to:
- Use the supplied evidence for factual claims.
- Avoid inventing figures.
- Distinguish measured facts from possible explanations.
- Acknowledge insufficient evidence.
- Give practical recommendations when appropriate.
- Treat revenue as Brazilian reais (BRL).

This is an example of prompt engineering: defining the model's role, supplying relevant context and setting response constraints.

These instructions improve the chances of a grounded answer but do not guarantee factual accuracy.

### 5.3 `ask_ai(question)`

Purpose: orchestrate the complete AI request.

The function:
1. Reads `GROQ_API_KEY` from the environment.
2. Checks that the key exists.
3. Retrieves business context.
4. Builds the prompt.
5. Creates the request payload.
6. Sends an HTTPS POST request to Groq.
7. Parses the JSON response.
8. Extracts the model-generated answer.
9. Returns the question, answer, business context and model identifier.

The request includes:
- The model identifier.
- A system message defining the assistant's role.
- A user message containing the question and business evidence.
- `temperature` set to `0.2`.
- `max_completion_tokens` set to `800`.

A lower temperature generally encourages less variable responses, but it does not ensure that an answer is correct.

The request also includes the Authorization header:

`Authorization: Bearer <API_KEY>`

The actual API key is read from the environment and is not written into the source code.

The request timeout is 60 seconds.

### 5.4 Error handling

The function handles several failure cases:
- Missing API key.
- HTTP 429 rate limiting.
- Other HTTP errors.
- Network connection errors.
- Unexpected or malformed API responses.
- Empty model answers.

The API key is not included in error messages.

The initial version maps rate limits and other handled provider errors into controlled application errors. More detailed retry logic and monitoring can be considered later if necessary.

## 6. Update `python/main.py`

The existing FastAPI entry point was updated rather than replaced with a separate application.

The following imports were added:

- `BaseModel` and `Field` from Pydantic.
- `ask_ai` from `ai_assistant`.

The existing analytics imports and KPI routes were retained.

### 6.1 Request validation with Pydantic

A `QuestionRequest` model was added.

Its `question` field has:
- Minimum length: 3 characters.
- Maximum length: 1,000 characters.

This validates the request before the AI function is called.

### 6.2 Add `POST /ai/ask`

The new endpoint accepts a JSON request containing a question.

Example:

```json
{
  "question": "What is the total delivered revenue, and how many delivered orders do we have? Give a short answer."
}
```

The endpoint:
1. Receives and validates the request.
2. Removes leading and trailing whitespace.
3. Calls `ask_ai()`.
4. Returns the result as JSON.
5. Converts handled assistant errors into an HTTP 502 response.
6. Returns a generic HTTP 500 response for other unexpected errors.

The existing KPI endpoints remain available.

FastAPI's automatic API documentation at `/docs` exposes the new endpoint for interactive testing.

## 7. End-to-End Request Flow

The completed flow is:

1. The user submits a question through FastAPI.
2. Pydantic validates the request.
3. The `/ai/ask` endpoint calls `ask_ai()`.
4. `ask_ai()` calls the existing analytics functions.
5. The analytics functions retrieve metrics from PostgreSQL.
6. The assistant constructs a business context and prompt.
7. The question and selected aggregate metrics are sent to Groq.
8. Groq generates a natural-language answer.
9. FastAPI returns the answer together with the question, business context and model identifier.

This is a retrieval-and-generation pattern: the application retrieves relevant business evidence before asking the language model to explain it.

It is not a model trained on the Olist dataset. The model generates responses using the context provided in each request.

## 8. Testing and Observed Results

### Test 1: API connectivity

The initial direct request returned HTTP 403 with error code 1010.

After adding the `User-Agent` header, the direct request succeeded.

Result: connectivity test passed.

### Test 2: Revenue and order count

Question:

```text
What is the total delivered revenue, and how many delivered orders do we have? Give a short answer.
```

Observed HTTP status: `200`

Observed response:

- Total delivered revenue: BRL 13,221,498.11.
- Delivered orders: 96,478.

These values matched the existing project analytics results.

Result: passed.

### Test 3: Category analysis and recommendations

The assistant was asked to identify the highest-revenue category among the five supplied categories and recommend a business action without claiming unsupported trends or causes.

Observed HTTP status: `200`

The assistant identified:
- Category: `health_beauty`
- Revenue: BRL 1,233,131.72

It also generated recommendations involving cross-selling, promotions and KPI monitoring.

Result: the assistant generated a relevant answer using the supplied category figures.

Important limitation: the data supplied in this request contained category revenue values, not customer-level behavior, conversion rates or repeat-purchase evidence. Suggestions concerning those factors remain hypotheses until independently tested.

### Test 4: Invalid question

The request was:

```json
{
  "question": "?"
}
```

Observed HTTP status: `422`

FastAPI returned a validation error indicating that the question must contain at least three characters.

Result: passed. This request was rejected by validation before the AI function was called.

## 9. Security and Privacy Considerations

The API key remains in `.env`.

The current assistant sends the user's question and selected aggregate business metrics to Groq. It does not need to send raw customer reviews for its current functionality.

Future enhancements must continue to minimize the data sent to the external model.

Additional considerations:
- Validate user inputs.
- Avoid returning internal exception details unnecessarily.
- Monitor rate limits and API failures.
- Keep credentials out of source control.
- Check provider data-handling terms before sending additional data.
- Avoid treating model-generated recommendations as verified business facts.
- Consider authentication and rate limiting before exposing the API publicly.

The current API runs locally. Public deployment and production security have not been established by these tests.

## 10. Current Limitations

1. The assistant has access only to the metrics included in `get_business_context()`.
2. It cannot reliably answer arbitrary business questions requiring data that has not been retrieved.
3. It does not currently execute arbitrary SQL generated by the model.
4. It does not have semantic search over customer reviews.
5. It does not provide guaranteed factual answers merely because a prompt includes accuracy instructions.
6. Free-tier model access and request limits may change.
7. API availability depends on the external provider and internet connectivity.
8. Recommendations about customer behavior or causes require additional evidence.
9. Error handling has been tested only for the cases recorded above; further failure testing is still useful.

## 11. Interview Preparation — Questions to Practise

### Q1. Why did you integrate a generative AI model into the analytics platform?

The platform already contained business metrics and machine-learning analyses. Generative AI adds a natural-language interface that can explain selected metrics and produce readable summaries and recommendations.

### Q2. Why did you use an external API instead of training your own model?

Training a language model was outside the project's scope and would require substantially more resources. The API allowed us to integrate a pre-existing generative model while retaining our own data pipeline, analytics and application logic.

### Q3. How does the model get business data?

The FastAPI endpoint calls Python analytics functions. Those functions query existing PostgreSQL analytics views. The selected results are converted into structured context and included in the model request.

### Q4. Why not let the model invent or calculate every metric itself?

The database and analytics functions are the source of truth for business figures. Supplying verified metrics reduces reliance on the language model to calculate or invent numerical results.

### Q5. Does prompt engineering eliminate hallucinations?

No. Prompt instructions can reduce some undesirable behavior, but the model can still make unsupported claims. Answers must be checked against the returned evidence, and unsupported questions should be handled explicitly.

### Q6. What is the difference between machine learning and generative AI in this project?

The existing classification, clustering and forecasting analyses use machine-learning methods to find patterns or produce predictions. The generative model creates natural-language responses based on the supplied question and evidence.

### Q7. How did you validate the API?

I tested direct API connectivity, submitted a KPI question through FastAPI, tested a category-recommendation question and submitted an invalid question to verify request validation. The two business questions returned HTTP 200, and the invalid question returned HTTP 422.

### Q8. How are API credentials protected?

The key is stored in the local `.env` file, loaded through environment configuration and used in the Authorization header. It is not hardcoded into the Python source or returned to the client.

### Q9. Why use FastAPI?

FastAPI exposes the analytics and AI functions through HTTP endpoints, validates requests with Pydantic and automatically provides interactive API documentation.

### Q10. Is the assistant production-ready?

No. The local end-to-end workflow has been tested, but public deployment, authentication, rate limiting, broader failure testing, monitoring and stronger evaluation of generated answers remain future work.

## 12. Day 14 Summary

Implemented:
- Direct Groq API access using Python's built-in HTTP functionality.
- `python/ai_assistant.py` for context retrieval, prompt construction and model invocation.
- `POST /ai/ask` in the existing FastAPI application.
- Request validation and basic error handling.
- Successful KPI and category-question tests.
- Validation of a too-short question.

The existing SQL analytics and KPI endpoints were reused.

The README has not been updated because the project plan reserves its final update for Day 15.

Before committing, review the Git changes, verify that `.env` is not staged, and decide whether the temporary `test_groq_api.py` should remain as a permanent test.

### Test 5: Question requiring unavailable evidence

Question:

"Why did revenue decline in September 2018, and what caused the decline?"

Observed HTTP status: `200`

The assistant stated that the supplied evidence did not include monthly revenue trends or data specific to September 2018. It did not claim that a decline had occurred or assert a cause.

The assistant recommended obtaining monthly revenue and order-count figures, comparing category performance, and investigating operational or marketing metrics before performing root-cause analysis.

Result: passed. The assistant acknowledged the limits of its supplied evidence rather than inventing a factual explanation.

Limitation: this was a qualitative behavior check, not a comprehensive hallucination or factuality evaluation.

# Final Project Review and Reconciled Learning Record

**Project:** AI-Powered E-Commerce Analytics Platform
**Review milestone:** Day 15 — Final Project Review and Documentation
**Primary dataset:** Brazilian E-Commerce Public Dataset by Olist
**Database:** PostgreSQL — `ecommerce_analytics`
**Main technologies:** Python, SQL, PostgreSQL, Power BI, Scikit-learn, FastAPI, Groq API and Generative AI

---

## 1. Purpose of the Final Review

This section consolidates the final implementation, technical decisions, verified results, and known limitations of the project developed from Day 1 onward.

The earlier daily entries preserve the original learning process. Some plans changed as the project developed, and some features were implemented in later milestones. This final review is the authoritative summary of the resulting architecture.

The purpose is to distinguish clearly between:

- Features that were implemented and tested.
- Analytical experiments and their measured results.
- Components that exist separately rather than forming one automated workflow.
- Planned improvements that have not yet been implemented.
- Historical observations that must not be presented as current business data.

The project demonstrates an end-to-end analytics workflow. It should not be described as a fully deployed production system or as a completely real-time platform.

## 2. Final Project Objective

The objective was to build a practical e-commerce analytics platform that transforms historical transactional data into business insights and demonstrates the integration of data engineering, SQL analytics, business intelligence, machine learning, API development, and Generative AI.

The platform was developed to support:

1. Sales and revenue analysis.
2. Customer behavior and RFM analysis.
3. Customer segmentation experiments.
4. Customer inactivity-risk analysis.
5. Product and seller performance analysis.
6. Delivery and operational performance analysis.
7. Review sentiment classification.
8. Baseline sales forecasting.
9. Interactive Power BI reporting.
10. API-based access to selected business metrics.
11. Natural-language answers to supported business questions.
12. A separate workflow for ingesting simulated and manually supplied order events.

The project uses historical Olist data, primarily from 2016–2018. Its results describe the available historical dataset and are not evidence of current e-commerce market performance.

## 3. Final Architecture

The final system contains two related but distinct workflows.

### 3.1 Historical analytics workflow

Historical Olist CSV files
→ Python Bronze ingestion
→ PostgreSQL Bronze schema
→ SQL transformations and validation
→ PostgreSQL Silver schema
→ Gold analytical tables and views
→ Python analytics functions
→ Power BI dashboards and selected FastAPI endpoints
→ Groq-powered AI assistant using retrieved business evidence

### 3.2 Incoming order-event workflow

Simulated order events or manually supplied CSV files
→ Python event ingestion
→ PostgreSQL Bronze event table
→ SQL transformation
→ PostgreSQL Silver event table
→ Gold order-event activity view

**Important architectural decision:** The incoming order-event workflow is separate from the historical sales analytics workflow. The synthetic and manually supplied events are not automatically combined with the original Olist sales data, and they do not automatically update the existing historical revenue metrics or Power BI dashboards.

These two workflows must not be described as one fully integrated real-time analytics pipeline.

## 4. PostgreSQL Database Architecture

The project uses one PostgreSQL database, `ecommerce_analytics`, with three principal schemas.

### Bronze schema

Purpose: preserve ingested source data and provide ingestion traceability.

The historical ingestion process loads nine source CSV files into Bronze tables. Source values are initially preserved in text form, with ingestion metadata and a technical row identifier.

The historical ingestion process also records batch information, including file fingerprints, status, row counts, timestamps, and error information.

The separate incoming-event workflow uses its own Bronze event table.

### Silver schema

Purpose: store standardized data with suitable data types, key constraints, and validated relationships.

Silver contains the nine historical Olist tables:

- `silver.orders`
- `silver.customers`
- `silver.order_items`
- `silver.products`
- `silver.sellers`
- `silver.order_payments`
- `silver.order_reviews`
- `silver.category_translation`
- `silver.geolocation`

It also contains the separate `silver.order_events` table for incoming order events.

Important decisions include:

- Use primary keys appropriate to each table's row grain.
- Use composite keys where one business identifier is not sufficient.
- Preserve missing source values unless a justified rule says otherwise.
- Use appropriate date, numeric, and identifier data types.
- Add foreign keys after checking relationships.
- Retain repeated review identifiers because the source investigation found they were not unique.
- Avoid using geolocation ZIP prefixes as unique keys because multiple records can share the same prefix.
- Keep `ingested_at` separate from `silver_processed_at`.

### Gold schema

Purpose: provide analytics-ready datasets for business reporting and reusable queries.

The historical analytical layer includes eight Gold tables and six analytical views:

- `gold.vw_sales_performance`
- `gold.vw_delivery_performance`
- `gold.vw_customer_rfm`
- `gold.vw_product_performance`
- `gold.vw_seller_performance`
- `gold.vw_customer_satisfaction_repurchase`

The separate incoming-event workflow exposes event activity through:

- `gold.vw_order_event_activity`

Gold views simplify repeatable business analysis and help provide consistent metric definitions to downstream components.

### Why use three schemas?

The Bronze, Silver, and Gold structure separates source preservation, standardization, and business analytics. It improves organization and traceability without requiring three separate databases.

A schema by itself does not guarantee data quality. Validation queries, appropriate constraints, and correct transformation logic are still required.

## 5. Historical Dataset and Ingestion Results

Nine historical CSV files were ingested into the Bronze layer.

| Bronze table | Rows |
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

The total includes more than one million geolocation records. It is the combined number of rows across nine datasets, not the number of orders.

The nine corresponding historical Silver tables were loaded and validated against their expected row counts during implementation.

### Important data-quality findings

- The source orders dataset contains 99,441 rows.
- The source contains 96,478 orders marked as delivered.
- The original investigation found missing values in several delivery-related timestamp fields.
- Two orders marked as delivered lacked a customer delivery timestamp in the final Silver investigation described in the project records.
- The source contains missing product-category and descriptive information.
- Review identifiers are repeated, so review IDs cannot automatically be treated as unique.
- Geolocation ZIP prefixes are not unique.
- Some date-sequence and payment-related anomalies require careful interpretation.

These findings informed schema design, validation, and analytical decisions. They do not establish the cause of every anomaly.

### Important learning

A successful CSV load and a matching row count do not prove that all source records are correct. Data quality requires separate checks for missing values, uniqueness, relationships, valid data types, and business rules.

## 6. Final Decision: Python Versus SQL

During the early database-design phase, a question arose about why data transformations were being performed in SQL when Python and Pandas could also perform many of the same operations.

The final decision was to choose the technology based on the task rather than to use both technologies unnecessarily.

**SQL is used for:**

- Database-side transformations.
- Joins, aggregations, and analytical views.
- Relational constraints.
- Database validation queries.
- Transformations between database layers.

**Python is used for:**

- CSV ingestion and pipeline orchestration.
- File hashing and ingestion tracking.
- Exploratory data analysis.
- Reusable database analytics functions.
- Machine-learning experiments.
- Review text processing.
- Forecasting.
- Simulated event generation and event ingestion.
- FastAPI and Generative AI integration.

Python can also clean data before loading it into SQL in a different workflow. However, that is an alternative implementation approach, not the architecture adopted for the main historical pipeline.

There is no need to undo the existing SQL transformations simply to move them to Python. Future transformations should use the tool best suited to the requirement and should not duplicate work without a clear reason.

## 7. Gold Analytics and Business Rules

The Gold layer supports sales, delivery, customer, product, seller, and satisfaction-related analysis.

Important rules include:

- Item `price` represents item revenue; `freight_value` is treated separately.
- Revenue calculations use the appropriate order-status and metric filters.
- Distinct counts are required when counting unique business entities.
- A grouped order count must not automatically be summed across multiple dimensions and treated as a distinct order total.
- Review scores 4–5 are classified as satisfied, 3 as neutral, and 1–2 as dissatisfied for the implemented analysis.
- Customer RFM segments are based on recency, frequency, and monetary value.
- A customer who does not repurchase during the available historical window cannot automatically be classified as someone who will never return.
- Review-level associations with individual products require caution because an order may contain multiple products while the review is associated with the order.
- A correlation or association does not establish causation.

### Verified historical metrics

| Metric | Recorded result |
|---|---:|
| Delivered item revenue | BRL 13,221,498.11 |
| Delivered orders | 96,478 |
| Highest-revenue category in the recorded analysis | `health_beauty` |
| Recorded revenue for `health_beauty` | BRL 1,233,131.72 |

Other high-revenue categories in the recorded analysis included `watches_gifts`, `bed_bath_table`, `sports_leisure`, and `computers_accessories`.

These are historical dataset results. Revenue represents item revenue under the project's metric definition, not necessarily total customer payments including freight or every other possible financial adjustment.

## 8. Power BI Implementation

The Power BI report is stored at the project root as:

`AI_Ecommerce_Analytics.pbix`

The report contains four pages.

### Page 1 — Executive Overview

Provides high-level business performance metrics, including revenue, order-related KPIs, monthly revenue trends, and category performance.

### Page 2 — Customer Analytics

Supports customer behavior analysis, repeat-purchase metrics, RFM segments, and satisfaction-related analysis.

### Page 3 — Delivery & Operations

Focuses on delivery outcomes, punctuality, delivery rates, and delivery duration.

### Page 4 — Product & Seller Performance

Supports analysis of product performance, category performance, seller comparisons, delivery volume, and late-order rates.

### Power BI learning

The report demonstrates the importance of choosing the correct source, aggregation, filters, relationships, and visual for each business question.

The grain of the underlying data must be understood before using counts or sums. A visual can look correct while still showing a misleading number if the underlying metric is defined incorrectly.

The report is based on the historical analytical dataset. Automatic refresh from the separate incoming order-event pipeline has not been implemented as part of the recorded architecture.

## 9. Python Analytics Integration

The project includes `python/analytics.py`, which provides reusable functions to retrieve selected business metrics from PostgreSQL.

The recorded functions include:

- `get_total_delivered_revenue()`
- `get_revenue_by_category()`
- `get_delivered_order_count()`

These functions are reused by the FastAPI application and the AI assistant.

The recorded delivered revenue and delivered-order count were compared with the corresponding SQL analytics results.

**Learning:** Reusable analytics functions avoid duplicating the same database logic in every application component and provide a consistent source for the metrics they expose.

## 10. Machine-Learning Experiments

Machine learning was introduced after the main historical database and analytical layers were available.

These are experimental models and analytical baselines, not all production-ready predictive systems.

### 10.1 Customer segmentation

Script: `python/customer_segmentation.py`

Method: K-Means clustering.

Recorded configuration and result:

- Number of clusters: 2.
- Silhouette score: approximately 0.7418.

The silhouette score indicates separation under the chosen features and configuration. It does not independently prove that the two groups are commercially meaningful. Business interpretation and stability checks are still important.

RFM segmentation and K-Means clustering are different approaches. RFM uses business-defined scoring rules, while K-Means groups records based on feature-space similarity.

### 10.2 Customer inactivity-risk model

Script: `python/inactivity_risk_model.py`

Prediction script: `python/predict_inactivity_risk.py`

The model was implemented as an experiment to identify customer inactivity risk.

The recorded evaluation showed weak performance for the evaluated active class, including approximately:

- Recall: 0.54.
- Precision: 0.01.

The low precision means that many records flagged by the model were false positives under the evaluation definition.

The model must not be presented as a reliable production churn or inactivity system without further work on label definitions, features, class imbalance, evaluation, and business usefulness.

### 10.3 Review sentiment classification

Script: `python/review_sentiment_analysis.py`

The experiment used TF-IDF text features and Logistic Regression to classify review sentiment using review-score-derived labels.

Recorded evaluation:

- Accuracy: approximately 0.79.
- Macro F1-score: approximately 0.67.
- Neutral-class F1-score: approximately 0.31.

The labels are derived from review scores, which are proxies for sentiment rather than perfect independent ground truth. Missing review text and class imbalance also limit interpretation.

The model demonstrates a working text-classification experiment, but the neutral class and label quality require further investigation.

### 10.4 Sales forecasting

Script: `python/sales_forecasting.py`

The forecasting experiment used a baseline method and chronological evaluation.

Recorded evaluation:

- MAE: approximately 68,365.41.
- RMSE: approximately 78,642.62.

MAE measures average absolute prediction error. RMSE gives greater weight to larger errors.

The evaluation used only five test observations, so the result is limited and should not be treated as evidence of a robust forecasting model. A more comprehensive evaluation and comparison with stronger baselines are future improvements.

### Overall machine-learning conclusion

The project demonstrates the process of preparing data, implementing models, evaluating results, and recognizing limitations. The models should not be described as production-ready merely because the scripts ran successfully.

## 11. Incoming Order-Event Pipeline

The incoming-event pipeline was added separately from the historical Olist workflow.

Relevant files include:

- `python/ingest_order_events.py`
- `python/simulate_order_events.py`
- `python/run_pipeline.py`
- `sql/15_create_order_event_tables.sql`
- `sql/16_transform_order_events.sql`
- `sql/17_create_order_event_view.sql`
- `sql/18_validate_order_event_pipeline.sql`

The workflow accepts simulated or manually supplied CSV event records, validates required fields and timestamps, ingests records into Bronze, transforms records into Silver, and exposes the resulting activity through a Gold view.

### Recorded final validation results

- Bronze events: 31.
- Silver events: 31.
- Gold view events: 31.
- Unique event IDs in Gold: 31.
- Manual events: 2.
- Simulated events: 29.
- Bronze events missing from Silver: 0.

Additional tests covered:

- Re-ingestion of the same manual CSV.
- Duplicate event IDs across CSV chunks.
- Invalid timestamps.
- Rejection of invalid input.
- Removal of temporary test records and test files.

The repeated-CSV test confirmed that existing event IDs were skipped. The chunk test inserted 1,000 unique records and skipped one duplicate.

### Important learning

- Primary keys and database conflict handling help prevent duplicate insertion.
- Idempotent ingestion allows the same file to be submitted again without creating duplicate event records.
- Invalid input should be verified as absent from the database after rejection.
- Synthetic events are useful for testing pipeline behavior but are not real historical transactions.
- A Gold event view does not automatically update the historical sales metrics.

The pipeline demonstrates event ingestion and transformation. It should not be described as a deployed streaming system or a real-time update to the historical sales dashboards.

## 12. FastAPI Implementation

The project uses FastAPI to expose selected analytical capabilities through HTTP endpoints.

The recorded endpoints include:

- `GET /`
- `GET /kpis/summary`
- `GET /kpis/categories`
- `POST /ai/ask`

The request body for the AI endpoint contains a question. Pydantic validates the question length before the AI request is made.

FastAPI also provides interactive documentation through:

`http://127.0.0.1:8000/docs`

The address is available when the application is running locally. It is not a public deployment URL.

### Learning

FastAPI provides a convenient way to expose Python functionality as API endpoints. Pydantic request validation helps reject invalid input before performing downstream processing.

The local API tests do not establish that the application is production-ready. Public deployment, authentication, rate limiting, monitoring, and further security testing remain separate tasks.

## 13. Generative AI Assistant

Files:

- `python/ai_assistant.py`
- `python/main.py`
- `test_groq_api.py`

The AI assistant uses the Groq API with the model identifier:

`openai/gpt-oss-120b`

The API key is stored in the local `.env` file as `GROQ_API_KEY`. It must not be hardcoded in source code, committed to GitHub, or included in screenshots or shared documentation.

The assistant reuses the existing analytics functions to retrieve selected evidence:

- Total delivered revenue.
- Delivered-order count.
- Revenue for the five highest-revenue categories.

The application then constructs a prompt containing the question and this evidence, calls the external model, and returns the generated answer through FastAPI.

### Recorded tests

**KPI question:** Returned HTTP 200 and included BRL 13,221,498.11 delivered revenue and 96,478 delivered orders.

**Category question:** Returned HTTP 200 and identified `health_beauty` with recorded revenue of BRL 1,233,131.72.

**Invalid question:** A question shorter than the minimum required length returned HTTP 422.

**Question requiring unavailable evidence:** When asked why revenue declined in September 2018, the assistant acknowledged that the supplied context did not establish a monthly decline or its cause.

The last test is important because the assistant should not invent a cause when the required evidence has not been retrieved.

### Final capability boundary

The AI assistant answers questions using the evidence supplied by the current analytics functions. It does not have unrestricted access to every table or metric in the database, and it does not execute arbitrary SQL generated by the model.

It cannot reliably answer a question that requires data it has not retrieved. For example, questions about monthly revenue trends, the cause of a business decline, individual product rankings, or seller-specific metrics require the corresponding analytical functions and evidence to be added.

The implementation is best described as an evidence-grounded Generative AI assistant for selected business metrics. It should not be described as a fully developed vector-search RAG platform or an unrestricted database agent.

### Security and privacy

The current workflow sends the question and selected aggregate business metrics to the external Groq service. It does not need to send raw customer reviews for its current functionality.

Before adding new AI features, the project should continue to minimize external data sharing, protect credentials, validate inputs, and review the provider's data-handling terms.

## 14. Final Project File Organization

The repository is organized around the following responsibilities.

### `python/`

Contains the historical ingestion process, dataset inspection and exploration, database connection test, reusable analytics functions, machine-learning experiments, event-processing scripts, FastAPI application, and AI assistant.

Important files include:

- `environment_check.py`
- `inspect_dataset.py`
- `analyze_orders.ipynb`
- `analyze_orders.py`
- `test_db_connection.py`
- `ingest_bronze.py`
- `analytics.py`
- `customer_segmentation.py`
- `inactivity_risk_model.py`
- `predict_inactivity_risk.py`
- `review_sentiment_analysis.py`
- `sales_forecasting.py`
- `ingest_order_events.py`
- `simulate_order_events.py`
- `run_pipeline.py`
- `main.py`
- `ai_assistant.py`

The notebook is the interactive exploration workspace. `analyze_orders.py` is retained separately for now; its role should be reviewed before deleting it or expanding it into a duplicate implementation.

### `sql/`

Contains organized, version-controlled SQL scripts for database creation, transformation, validation, analytics, and the incoming-event workflow.

The SQL work is organized in numbered files from `01_create_bronze_tables.sql` through `18_validate_order_event_pipeline.sql`.

New SQL queries must be saved in the appropriate `.sql` file under `sql/`. They must not be left only in pgAdmin Query Tool history.

Before ending a SQL work session, identify which SQL files need to be created or updated and include them in the Git review and commit workflow.

### `docs/`

Contains the project learning journal, architecture decisions, and AI assistant question guide.

- `docs/learning/project-learning.md` — the day-by-day learning record.
- `docs/architecture-decisions.md` — significant architectural decisions and their reasoning.
- `docs/ai-assistant-questions.md` — supported question types, unsupported question types, and the assistant's current boundaries.

The personal interview explanation, resume wording, and LinkedIn post are personal career-preparation materials and do not need to be added to the technical project documentation.

### Other important files

- `.env` — local credentials and configuration; must remain private.
- `.gitignore` — excludes sensitive files and selected generated or local data.
- `AI_Ecommerce_Analytics.pbix` — Power BI report.
- `README.md` — repository overview and setup documentation.
- `test_groq_api.py` — direct Groq API connectivity test.
- `screenshots/` — intended location for selected project screenshots.

Generated data, temporary test files, API keys, credentials, and other private material must not be committed unintentionally.

## 15. Final Technical Decisions That Supersede Earlier Plans

The following decisions are authoritative when earlier notes describe a different plan.

### Decision 1: One database with three schemas

**Final decision:** Use `ecommerce_analytics` with Bronze, Silver, and Gold schemas.

The layers are schemas in one PostgreSQL database, not three separate databases.

### Decision 2: Select Python or SQL based on the task

**Final decision:** Do not move existing SQL transformations to Python merely to demonstrate Pandas, and do not force every transformation into SQL. Choose the implementation that fits the task.

### Decision 3: Preserve historical data and document anomalies

**Final decision:** Do not automatically delete missing, duplicated, or anomalous source records without a justified rule. Investigate anomalies and document the decisions.

### Decision 4: Keep RFM, clustering, inactivity risk, sentiment, and forecasting distinct

**Final decision:** RFM is rule-based customer analysis; K-Means is clustering; inactivity risk is a predictive classification experiment; sentiment analysis is text classification; sales forecasting is a time-based prediction task.

They are not interchangeable methods, and their results must be interpreted using their respective definitions and evaluation metrics.

### Decision 5: Keep the incoming-event pipeline separate

**Final decision:** Simulated and manually supplied order events have their own ingestion and transformation workflow. They are not automatically merged with historical Olist sales data or the existing Power BI report.

### Decision 6: Keep the AI assistant evidence-bound

**Final decision:** The AI assistant receives selected metrics from existing analytics functions. It does not have unrestricted access to every business metric, does not generate arbitrary SQL for execution, and must acknowledge when the supplied evidence is insufficient.

### Decision 7: Do not claim production deployment

**Final decision:** The project has a tested local FastAPI application and external Groq API integration. Public cloud deployment, production security, and automated integration of incoming events into the historical reporting pipeline are not established by the recorded work.

### Decision 8: Keep SQL version-controlled

**Final decision:** Every SQL query used for project work must be saved in an organized `.sql` file in the repository's `sql/` directory and reviewed through Git.

### Decision 9: Protect secrets and sensitive data

**Final decision:** Keep `.env` and API keys private. Review staged files before committing. Do not upload credentials, raw private data, or screenshots containing secrets.

### Decision 10: Separate technical documentation from personal career notes

**Final decision:** The project journal and README should describe the technical implementation. The interview explanation, resume description, and LinkedIn post remain in the user's personal Word document.

## 16. Final Known Limitations

The following limitations remain important when explaining or extending the project.

1. The historical Olist dataset primarily covers 2016–2018.
2. Source anomalies and missing values require careful interpretation.
3. The RFM and clustering outputs need business interpretation before they can drive actions.
4. The inactivity-risk model has very low recorded precision for the evaluated active class.
5. The neutral sentiment class has a low recorded F1-score.
6. The forecasting baseline was evaluated on only five test observations.
7. The AI assistant can answer only questions supported by the context its analytics functions retrieve.
8. Generative AI can still produce incorrect or unsupported statements.
9. The incoming-event pipeline is separate from historical sales analytics.
10. The current API is locally run, not a demonstrated public production deployment.
11. Production authentication, rate limiting, monitoring, and broader failure testing remain potential improvements.
12. Automated refresh of the existing Power BI report from incoming events has not been established.
13. The repository and documentation must be checked before public sharing to ensure no secrets or unintended generated files are included.

## 17. Future Enhancements

The following are possible future improvements, not completed features.

- Improve inactivity-risk model labels, features, class balance, and evaluation.
- Evaluate alternative clustering configurations and assess whether customer segments are actionable.
- Improve sentiment classification, particularly neutral-class performance.
- Compare more sophisticated forecasting methods against suitable baselines with a larger chronological test period.
- Extend the AI assistant with additional validated analytics functions for monthly trends, seller performance, product performance, delivery delays, and customer behavior.
- Add stronger tests for AI answer grounding and unsupported questions.
- Integrate incoming order events into the analytical reporting model if unified historical and incoming-event analysis is required.
- Add authentication, rate limiting, monitoring, and production-grade error handling before public deployment.
- Improve setup reproducibility by documenting required dependencies and environment configuration.
- Complete and verify project screenshots, including the Power BI pages, PostgreSQL schema inventory, and FastAPI/AI response.
- Review and finalize the README so that it describes only implemented and verified features.

## 18. Final Learning Summary

This project progressed from inspecting CSV files to designing a relational database, implementing data layers, developing analytical views, creating Power BI reports, experimenting with machine learning, building an incoming-event workflow, exposing metrics through FastAPI, and integrating a Generative AI assistant.

The most important lessons were:

- Understand the source data and its grain before designing tables or calculating metrics.
- Use data-quality checks to validate assumptions.
- Choose SQL and Python based on the task rather than using tools unnecessarily.
- Keep the raw, standardized, and analytical layers conceptually separate.
- Validate business metrics independently.
- Evaluate machine-learning models with suitable metrics and honest limitations.
- Ground AI answers in retrieved evidence instead of relying on prompt instructions alone.
- Keep separate pipelines separate until an explicit integration is designed and tested.
- Save SQL queries in version-controlled files.
- Protect credentials and verify intended Git changes before committing.
- Record decisions and corrections so that the project remains understandable after development ends.

## 19. Final Completion Status

The project has implemented the core historical analytics architecture, SQL analytical views, four Power BI report pages, reusable Python analytics, machine-learning experiments, a separate incoming order-event workflow, FastAPI endpoints, and a Groq-powered AI assistant.

The recorded tests support the core behaviors described in this journal. The known model limitations, restricted AI context, separate event pipeline, and local-only application status remain part of the final project description.

The final documentation and repository review should verify that the README reflects the actual implementation, the required files are saved, the screenshots intended for the repository are present, and the Git changes include only the intended project files.

**Final conclusion:** The AI-Powered E-Commerce Analytics Platform is an end-to-end portfolio project demonstrating data engineering, SQL analytics, business intelligence, machine-learning experimentation, API development, and evidence-grounded Generative AI. Its strongest feature is the integration of these components with documented reasoning and testing, while clearly identifying the boundaries of the current implementation.