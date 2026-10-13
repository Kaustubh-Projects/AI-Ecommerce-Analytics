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