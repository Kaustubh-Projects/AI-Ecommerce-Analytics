-- ============================================================
-- Order Event Pipeline Validation
-- Purpose: Validate Bronze, Silver, and Gold event processing
-- Database: ecommerce_analytics
-- ============================================================


-- TEST 1: Compare event counts across all three layers

SELECT
    'Bronze' AS data_layer,
    COUNT(*) AS total_events,
    COUNT(DISTINCT event_id) AS unique_event_ids
FROM bronze.order_events

UNION ALL

SELECT
    'Silver',
    COUNT(*),
    COUNT(DISTINCT event_id)
FROM silver.order_events

UNION ALL

SELECT
    'Gold',
    COUNT(*),
    COUNT(DISTINCT event_id)
FROM gold.vw_order_event_activity;


-- TEST 2: Check event counts by source in Gold

SELECT
    event_source,
    COUNT(*) AS total_events,
    COUNT(DISTINCT event_id) AS unique_event_ids
FROM gold.vw_order_event_activity
GROUP BY event_source
ORDER BY event_source;


-- TEST 3: Find duplicate event IDs in Bronze

SELECT
    event_id,
    COUNT(*) AS occurrences
FROM bronze.order_events
GROUP BY event_id
HAVING COUNT(*) > 1;


-- TEST 4: Find duplicate event IDs in Silver

SELECT
    event_id,
    COUNT(*) AS occurrences
FROM silver.order_events
GROUP BY event_id
HAVING COUNT(*) > 1;


-- TEST 5: Find events in Bronze that have not reached Silver

SELECT
    b.event_id,
    b.order_id,
    b.event_source
FROM bronze.order_events AS b
LEFT JOIN silver.order_events AS s
    ON b.event_id = s.event_id
WHERE s.event_id IS NULL
ORDER BY b.event_id;


-- TEST 6: Find Silver events missing from the Gold view

SELECT
    s.event_id,
    s.order_id
FROM silver.order_events AS s
LEFT JOIN gold.vw_order_event_activity AS g
    ON s.event_id = g.event_id
WHERE g.event_id IS NULL
ORDER BY s.event_id;


-- TEST 7: Check for blank required values in Bronze

SELECT
    COUNT(*) FILTER (
        WHERE event_id IS NULL OR TRIM(event_id) = ''
    ) AS blank_event_ids,

    COUNT(*) FILTER (
        WHERE order_id IS NULL OR TRIM(order_id) = ''
    ) AS blank_order_ids,

    COUNT(*) FILTER (
        WHERE customer_id IS NULL OR TRIM(customer_id) = ''
    ) AS blank_customer_ids,

    COUNT(*) FILTER (
        WHERE order_status IS NULL OR TRIM(order_status) = ''
    ) AS blank_order_statuses,

    COUNT(*) FILTER (
        WHERE order_purchase_timestamp IS NULL
           OR TRIM(order_purchase_timestamp) = ''
    ) AS blank_purchase_timestamps
FROM bronze.order_events;


-- TEST 8: Check for blank required values in Silver

SELECT
    COUNT(*) FILTER (
        WHERE event_id IS NULL OR TRIM(event_id) = ''
    ) AS blank_event_ids,

    COUNT(*) FILTER (
        WHERE order_id IS NULL OR TRIM(order_id) = ''
    ) AS blank_order_ids,

    COUNT(*) FILTER (
        WHERE customer_id IS NULL OR TRIM(customer_id) = ''
    ) AS blank_customer_ids,

    COUNT(*) FILTER (
        WHERE order_status IS NULL OR TRIM(order_status) = ''
    ) AS blank_order_statuses,

    COUNT(*) FILTER (
        WHERE order_purchase_timestamp IS NULL
    ) AS blank_purchase_timestamps
FROM silver.order_events;


-- TEST 9: Inspect recent event records in Gold

SELECT
    event_id,
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    event_source,
    source_file,
    received_at
FROM gold.vw_order_event_activity
ORDER BY received_at DESC
LIMIT 20;


-- TEST 10: Check whether Bronze and Silver have matching event sources

SELECT
    b.event_id,
    b.event_source AS bronze_source,
    s.event_source AS silver_source
FROM bronze.order_events AS b
JOIN silver.order_events AS s
    ON b.event_id = s.event_id
WHERE b.event_source <> s.event_source;


-- TEST 11: Check whether Bronze and Silver have matching order IDs

SELECT
    b.event_id,
    b.order_id AS bronze_order_id,
    s.order_id AS silver_order_id
FROM bronze.order_events AS b
JOIN silver.order_events AS s
    ON b.event_id = s.event_id
WHERE b.order_id <> s.order_id;


-- TEST 12: Check whether Bronze and Silver have matching timestamps

SELECT
    b.event_id,
    b.order_purchase_timestamp AS bronze_timestamp,
    s.order_purchase_timestamp AS silver_timestamp
FROM bronze.order_events AS b
JOIN silver.order_events AS s
    ON b.event_id = s.event_id
WHERE TRIM(b.order_purchase_timestamp)::TIMESTAMP
      <> s.order_purchase_timestamp;


-- TEST 13: Count events by status and source

SELECT
    event_source,
    order_status,
    COUNT(*) AS event_count
FROM gold.vw_order_event_activity
GROUP BY event_source, order_status
ORDER BY event_source, order_status;


-- TEST 14: Check whether every Silver event appears in Bronze

SELECT
    s.event_id,
    s.order_id
FROM silver.order_events AS s
LEFT JOIN bronze.order_events AS b
    ON s.event_id = b.event_id
WHERE b.event_id IS NULL
ORDER BY s.event_id;


-- TEST 15: Check whether every Bronze event has reached Silver

SELECT
    b.event_id,
    b.order_id
FROM bronze.order_events AS b
LEFT JOIN silver.order_events AS s
    ON b.event_id = s.event_id
WHERE s.event_id IS NULL
ORDER BY b.event_id;


-- TEST 16: Check for invalid event sources

SELECT
    event_id,
    event_source
FROM bronze.order_events
WHERE event_source NOT IN ('manual_csv', 'simulated');


-- TEST 17: Check for blank purchase timestamps in Bronze

SELECT
    event_id,
    order_purchase_timestamp
FROM bronze.order_events
WHERE order_purchase_timestamp IS NULL
   OR TRIM(order_purchase_timestamp) = '';


-- TEST 18: Final pipeline summary

SELECT
    (SELECT COUNT(*)
     FROM bronze.order_events) AS bronze_events,

    (SELECT COUNT(*)
     FROM silver.order_events) AS silver_events,

    (SELECT COUNT(*)
     FROM gold.vw_order_event_activity) AS gold_events,

    (SELECT COUNT(DISTINCT event_id)
     FROM gold.vw_order_event_activity) AS unique_gold_event_ids;