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
- [ ] Silver schema transformations and data-quality rules implemented.
- [ ] Gold analytical tables implemented.

### Limitations and Follow-up
- Successful row counts do not prove complete data quality.
- Relationship validation, type conversion, duplicate policies, and business-rule checks remain Silver-layer responsibilities.
- Controlled reprocessing must be implemented and tested before changed files can be safely reloaded.
- The current ingestion process loads local historical CSVs; it does not yet provide scheduled ingestion, live event ingestion, or API ingestion.
- Bronze tables preserve source values as text. Downstream layers must convert dates and numeric values using explicit validation rules.