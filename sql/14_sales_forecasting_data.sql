-- Day 11: Prepare monthly sales data for forecasting

-- 1. Monthly delivered-order item revenue
SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp)::date AS sales_month,
    COUNT(DISTINCT o.order_id) AS delivered_orders,
    ROUND(SUM(oi.price)::numeric, 2) AS item_revenue
FROM silver.orders AS o
JOIN silver.order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
  AND o.order_purchase_timestamp IS NOT NULL
GROUP BY DATE_TRUNC('month', o.order_purchase_timestamp)::date
ORDER BY sales_month;

-- 2. Check the monthly date range
SELECT
    MIN(DATE_TRUNC('month', o.order_purchase_timestamp)::date)
        AS first_sales_month,
    MAX(DATE_TRUNC('month', o.order_purchase_timestamp)::date)
        AS last_sales_month,
    COUNT(DISTINCT DATE_TRUNC('month', o.order_purchase_timestamp)::date)
        AS months_with_delivered_orders
FROM silver.orders AS o
WHERE o.order_status = 'delivered'
  AND o.order_purchase_timestamp IS NOT NULL;