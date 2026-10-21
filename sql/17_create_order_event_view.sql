
-- Keep incoming events separate from historical sales metrics.

CREATE OR REPLACE VIEW gold.vw_order_event_activity AS
SELECT
    event_id,
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    event_source,
    source_file,
    received_at,
    transformed_at
FROM silver.order_events;