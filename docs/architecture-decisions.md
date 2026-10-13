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