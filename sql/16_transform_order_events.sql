
-- Day 12: Transform Bronze order events into Silver.
-- Safe to rerun for existing event IDs.

INSERT INTO silver.order_events (
    event_id,
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    event_source,
    source_file,
    received_at
)
SELECT
    event_id,
    order_id,
    customer_id,
    order_status,
    TRIM(order_purchase_timestamp)::TIMESTAMP,
    event_source,
    source_file,
    received_at
FROM bronze.order_events
ON CONFLICT (event_id) DO NOTHING;

-- Display the transformed event counts.
SELECT
    event_source,
    order_status,
    COUNT(*) AS event_count
FROM silver.order_events
GROUP BY event_source, order_status
ORDER BY event_source, order_status;