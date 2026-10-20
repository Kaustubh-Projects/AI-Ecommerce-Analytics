-- ============================================================
-- Day 10: Customer Inactivity-Risk Model
-- Purpose: Validate historical data before building the model
-- Database: ecommerce_analytics
-- Schema: silver
-- ============================================================


-- QUERY 1: Check the complete historical order date range
SELECT
    MIN(order_purchase_timestamp) AS first_order_date,
    MAX(order_purchase_timestamp) AS last_order_date,
    COUNT(*) AS total_orders
FROM silver.orders;


-- QUERY 2: Check customer counts and order records
SELECT
    COUNT(DISTINCT c.customer_unique_id) AS unique_customers,
    COUNT(DISTINCT o.customer_id) AS customer_accounts,
    COUNT(*) AS total_order_records
FROM silver.orders AS o
JOIN silver.customers AS c
    ON o.customer_id = c.customer_id;


-- QUERY 3: Check the distribution of order statuses
SELECT
    order_status,
    COUNT(*) AS order_count
FROM silver.orders
GROUP BY order_status
ORDER BY order_count DESC;


-- QUERY 4: Validate delivered-order timestamps
SELECT
    COUNT(*) AS delivered_orders,
    MIN(order_purchase_timestamp) AS first_delivered_order_purchase,
    MAX(order_purchase_timestamp) AS last_delivered_order_purchase,
    COUNT(*) FILTER (
        WHERE order_purchase_timestamp IS NULL
    ) AS missing_purchase_timestamps,
    COUNT(*) FILTER (
        WHERE order_delivered_customer_date IS NULL
    ) AS missing_delivery_timestamps
FROM silver.orders
WHERE order_status = 'delivered';


-- QUERY 5: Check delivered purchases in the proposed
-- 90-day outcome window: July 1 to September 28, 2018
SELECT
    COUNT(*) AS delivered_orders_in_window,
    COUNT(DISTINCT c.customer_unique_id)
        AS customers_with_delivered_orders
FROM silver.orders AS o
JOIN silver.customers AS c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
  AND o.order_purchase_timestamp >= TIMESTAMP '2018-07-01'
  AND o.order_purchase_timestamp < TIMESTAMP '2018-09-29';


-- QUERY 6: Check customer identity mapping
-- One customer_unique_id may be associated with
-- multiple customer account IDs.
SELECT
    COUNT(*) AS unique_customer_account_pairs,
    COUNT(DISTINCT c.customer_unique_id) AS unique_customers,
    COUNT(DISTINCT c.customer_id) AS customer_accounts,
    COUNT(*) FILTER (
        WHERE c.customer_unique_id IS NULL
    ) AS missing_unique_customer_ids
FROM silver.customers AS c;


-- QUERY 7: Check delivered-order purchase dates
-- for the proposed feature period before July 1, 2018.
SELECT
    COUNT(*) AS delivered_orders_before_cutoff,
    COUNT(DISTINCT c.customer_unique_id)
        AS customers_with_delivered_orders_before_cutoff,
    MIN(o.order_purchase_timestamp) AS earliest_purchase_before_cutoff,
    MAX(o.order_purchase_timestamp) AS latest_purchase_before_cutoff
FROM silver.orders AS o
JOIN silver.customers AS c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
  AND o.order_purchase_timestamp < TIMESTAMP '2018-07-01';


-- QUERY 8: Check delivered purchases after the proposed
-- outcome window. This helps us understand the available
-- observation horizon; it does not change the 90-day label.
SELECT
    COUNT(*) AS delivered_orders_after_outcome_window,
    MIN(order_purchase_timestamp) AS first_purchase_after_window,
    MAX(order_purchase_timestamp) AS last_purchase_after_window
FROM silver.orders
WHERE order_status = 'delivered'
  AND order_purchase_timestamp >= TIMESTAMP '2018-09-29';

 -- 09: Simple inactivity-label validation

WITH customer_purchases AS (
    SELECT
        c.customer_unique_id,
        MAX(o.order_purchase_timestamp) AS last_purchase_date
    FROM silver.orders AS o
    JOIN silver.customers AS c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
      AND c.customer_unique_id IS NOT NULL
    GROUP BY c.customer_unique_id
)
SELECT
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (
        WHERE last_purchase_date < TIMESTAMP '2018-06-01'
    ) AS no_purchase_after_cutoff,
    COUNT(*) FILTER (
        WHERE last_purchase_date >= TIMESTAMP '2018-06-01'
          AND last_purchase_date < TIMESTAMP '2018-08-30'
    ) AS purchased_during_window,
    COUNT(*) FILTER (
        WHERE last_purchase_date >= TIMESTAMP '2018-08-30'
    ) AS purchased_after_window
FROM customer_purchases;

-- QUERY 10: Count eligible customers and their outcome labels

WITH eligible_customers AS (
    SELECT DISTINCT c.customer_unique_id
    FROM silver.orders o
    JOIN silver.customers c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
      AND o.order_purchase_timestamp < TIMESTAMP '2018-06-01'
      AND c.customer_unique_id IS NOT NULL
),
window_purchases AS (
    SELECT DISTINCT c.customer_unique_id
    FROM silver.orders o
    JOIN silver.customers c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
      AND o.order_purchase_timestamp >= TIMESTAMP '2018-06-01'
      AND o.order_purchase_timestamp < TIMESTAMP '2018-08-30'
      AND c.customer_unique_id IS NOT NULL
)
SELECT
    COUNT(*) AS eligible_customers,
    COUNT(w.customer_unique_id) AS active_customers,
    COUNT(*) - COUNT(w.customer_unique_id) AS inactive_customers
FROM eligible_customers e
LEFT JOIN window_purchases w
    ON e.customer_unique_id = w.customer_unique_id;

    -- QUERY 11: Inspect last-purchase recency before the cutoff

WITH customer_last_purchase AS (
    SELECT
        c.customer_unique_id,
        MAX(o.order_purchase_timestamp) AS last_purchase_date
    FROM silver.orders AS o
    JOIN silver.customers AS c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
      AND o.order_purchase_timestamp < TIMESTAMP '2018-06-01'
      AND c.customer_unique_id IS NOT NULL
    GROUP BY c.customer_unique_id
)
SELECT
    COUNT(*) AS eligible_customers,
    COUNT(*) FILTER (
        WHERE last_purchase_date >= TIMESTAMP '2018-05-01'
    ) AS purchased_in_previous_31_days,
    COUNT(*) FILTER (
        WHERE last_purchase_date >= TIMESTAMP '2018-04-02'
          AND last_purchase_date < TIMESTAMP '2018-05-01'
    ) AS last_purchase_31_to_60_days_ago,
    COUNT(*) FILTER (
        WHERE last_purchase_date < TIMESTAMP '2018-04-02'
    ) AS last_purchase_more_than_60_days_ago
FROM customer_last_purchase;

-- QUERY 12: Validate recent customers for the inactivity model

WITH recent_customers AS (
    SELECT DISTINCT c.customer_unique_id
    FROM silver.orders o
    JOIN silver.customers c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
      AND o.order_purchase_timestamp >= TIMESTAMP '2018-04-02'
      AND o.order_purchase_timestamp < TIMESTAMP '2018-06-01'
      AND c.customer_unique_id IS NOT NULL
),
window_purchases AS (
    SELECT DISTINCT c.customer_unique_id
    FROM silver.orders o
    JOIN silver.customers c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
      AND o.order_purchase_timestamp >= TIMESTAMP '2018-06-01'
      AND o.order_purchase_timestamp < TIMESTAMP '2018-08-30'
      AND c.customer_unique_id IS NOT NULL
)
SELECT
    COUNT(*) AS eligible_recent_customers,
    COUNT(w.customer_unique_id) AS active_customers,
    COUNT(*) - COUNT(w.customer_unique_id) AS inactive_customers
FROM recent_customers r
LEFT JOIN window_purchases w
    ON r.customer_unique_id = w.customer_unique_id;

-- QUERY 13: Build customer features and inactivity labels
-- Features use delivered-order history before June 1, 2018.
-- Labels use delivered orders from June 1 through August 29, 2018.
-- Active = 0; Inactive = 1.

WITH customer_features AS (
    SELECT
        c.customer_unique_id,
        MAX(o.order_purchase_timestamp) AS last_purchase_date,
        COUNT(*) AS purchase_count,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM silver.orders AS o
    JOIN silver.customers AS c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
      AND o.order_purchase_timestamp < TIMESTAMP '2018-06-01'
      AND c.customer_unique_id IS NOT NULL
    GROUP BY c.customer_unique_id
),
customer_outcomes AS (
    SELECT DISTINCT
        c.customer_unique_id
    FROM silver.orders AS o
    JOIN silver.customers AS c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
      AND o.order_purchase_timestamp >= TIMESTAMP '2018-06-01'
      AND o.order_purchase_timestamp < TIMESTAMP '2018-08-30'
      AND c.customer_unique_id IS NOT NULL
),
training_data AS (
    SELECT
        f.customer_unique_id,
        f.last_purchase_date,
        f.purchase_count,
        f.order_count,
        CASE
            WHEN outcome.customer_unique_id IS NULL THEN 1
            ELSE 0
        END AS inactive_label
    FROM customer_features AS f
    LEFT JOIN customer_outcomes AS outcome
        ON f.customer_unique_id = outcome.customer_unique_id
)
SELECT
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE inactive_label = 0) AS active_customers,
    COUNT(*) FILTER (WHERE inactive_label = 1) AS inactive_customers,
    MIN(last_purchase_date) AS earliest_feature_purchase,
    MAX(last_purchase_date) AS latest_feature_purchase
FROM training_data;