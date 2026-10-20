-- Total delivered-order revenue

SELECT
    SUM(item_revenue) AS total_delivered_revenue
FROM gold.vw_sales_performance;

-- Revenue by product category

SELECT
    product_category_name_english,
    SUM(item_revenue) AS total_revenue
FROM gold.vw_sales_performance
GROUP BY product_category_name_english
ORDER BY total_revenue DESC;

-- Delivered-order count

SELECT
    COUNT(*) AS delivered_order_count
FROM gold.vw_delivery_performance
WHERE order_status = 'delivered';