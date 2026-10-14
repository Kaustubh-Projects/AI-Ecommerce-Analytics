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