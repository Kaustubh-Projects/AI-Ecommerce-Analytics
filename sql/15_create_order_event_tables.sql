
-- Historical Olist tables remain unchanged.

-- 1. Bronze table: stores incoming event values.
CREATE TABLE IF NOT EXISTS bronze.order_events (
    event_id TEXT PRIMARY KEY,
    order_id TEXT NOT NULL,
    customer_id TEXT NOT NULL,
    order_status TEXT NOT NULL,
    order_purchase_timestamp TEXT NOT NULL,
    event_source TEXT NOT NULL
        CHECK (event_source IN ('manual_csv', 'simulated')),
    source_file TEXT NOT NULL,
    received_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 2. Silver table: stores normalized event data.
CREATE TABLE IF NOT EXISTS silver.order_events (
    event_id TEXT PRIMARY KEY,
    order_id TEXT NOT NULL,
    customer_id TEXT NOT NULL,
    order_status TEXT NOT NULL,
    order_purchase_timestamp TIMESTAMP NOT NULL,
    event_source TEXT NOT NULL
        CHECK (event_source IN ('manual_csv', 'simulated')),
    source_file TEXT NOT NULL,
    received_at TIMESTAMP NOT NULL,
    transformed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 3. Indexes to speed up common queries.
CREATE INDEX IF NOT EXISTS idx_silver_order_events_order_id
    ON silver.order_events (order_id);

CREATE INDEX IF NOT EXISTS idx_silver_order_events_purchase_timestamp
    ON silver.order_events (order_purchase_timestamp);

CREATE INDEX IF NOT EXISTS idx_silver_order_events_source
    ON silver.order_events (event_source);