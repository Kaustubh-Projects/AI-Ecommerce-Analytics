-- Day 10: Customer Inactivity-Risk Training Dataset
-- Feature cutoff: June 1, 2018
-- Outcome window: June 1 to August 29, 2018
-- Active = 0, Inactive = 1

WITH delivered_order_values AS (
    SELECT
        c.customer_unique_id,
        o.order_id,
        o.order_purchase_timestamp,
        SUM(oi.price) AS order_value
    FROM silver.orders AS o
    JOIN silver.customers AS c
        ON o.customer_id = c.customer_id
    JOIN silver.order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
      AND o.order_purchase_timestamp < TIMESTAMP '2018-06-01'
      AND c.customer_unique_id IS NOT NULL
    GROUP BY
        c.customer_unique_id,
        o.order_id,
        o.order_purchase_timestamp
),
customer_features AS (
    SELECT
        customer_unique_id,
        DATE '2018-06-01' - MAX(order_purchase_timestamp)::date
            AS recency_days,
        COUNT(DISTINCT order_id) AS frequency,
        SUM(order_value) AS monetary
    FROM delivered_order_values
    GROUP BY customer_unique_id
),
outcome_customers AS (
    SELECT DISTINCT
        c.customer_unique_id
    FROM silver.orders AS o
    JOIN silver.customers AS c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
      AND o.order_purchase_timestamp >= TIMESTAMP '2018-06-01'
      AND o.order_purchase_timestamp < TIMESTAMP '2018-08-30'
      AND c.customer_unique_id IS NOT NULL
)
SELECT
    f.customer_unique_id,
    f.recency_days,
    f.frequency,
    f.monetary,
    CASE
        WHEN outcome.customer_unique_id IS NULL THEN 1
        ELSE 0
    END AS inactive_label
FROM customer_features AS f
LEFT JOIN outcome_customers AS outcome
    ON f.customer_unique_id = outcome.customer_unique_id
ORDER BY f.customer_unique_id;