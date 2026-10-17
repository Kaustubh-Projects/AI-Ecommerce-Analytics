-- ============================================================
-- 04_validate_bronze_silver.sql
-- Purpose: Inspect schemas, row counts, data quality, and relationships.
-- Safe to run against populated tables; these statements are SELECT queries.
-- ============================================================

-- A. List every Silver table and its columns.
SELECT table_name, ordinal_position, column_name, data_type,
       is_nullable, column_default
FROM information_schema.columns
WHERE table_schema = 'silver'
ORDER BY table_name, ordinal_position;

-- B. Check all Bronze table row counts.
SELECT 'customers' AS table_name, COUNT(*) AS total_rows FROM bronze.customers
UNION ALL SELECT 'geolocation', COUNT(*) FROM bronze.geolocation
UNION ALL SELECT 'order_items', COUNT(*) FROM bronze.order_items
UNION ALL SELECT 'order_payments', COUNT(*) FROM bronze.order_payments
UNION ALL SELECT 'order_reviews', COUNT(*) FROM bronze.order_reviews
UNION ALL SELECT 'orders', COUNT(*) FROM bronze.orders
UNION ALL SELECT 'products', COUNT(*) FROM bronze.products
UNION ALL SELECT 'sellers', COUNT(*) FROM bronze.sellers
UNION ALL SELECT 'category_translation', COUNT(*) FROM bronze.category_translation
ORDER BY table_name;

-- C. Inspect the Bronze ingestion batch history.
SELECT source_file, status, row_count, started_at, completed_at, error_message
FROM bronze.ingestion_batches
ORDER BY batch_id;

-- D. Check Bronze orders for missing/duplicate IDs.
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_order_ids,
    COUNT(*) FILTER (WHERE order_id IS NULL OR TRIM(order_id) = '') AS missing_order_ids,
    COUNT(*) - COUNT(DISTINCT order_id) AS possible_duplicate_rows
FROM bronze.orders;

-- E. Review missing order dates by order status in Bronze.
SELECT
    order_status,
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (WHERE order_approved_at IS NULL OR TRIM(order_approved_at) = '') AS missing_approval_date,
    COUNT(*) FILTER (WHERE order_delivered_carrier_date IS NULL OR TRIM(order_delivered_carrier_date) = '') AS missing_carrier_date,
    COUNT(*) FILTER (WHERE order_delivered_customer_date IS NULL OR TRIM(order_delivered_customer_date) = '') AS missing_delivery_date
FROM bronze.orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- F. Check unmatched order customer IDs in Bronze.
SELECT COUNT(*) AS unmatched_customer_ids
FROM bronze.orders AS o
WHERE NOT EXISTS (
    SELECT 1 FROM bronze.customers AS c
    WHERE c.customer_id = o.customer_id
);

-- G. Silver row counts.
SELECT 'customers' AS table_name, COUNT(*) AS total_rows FROM silver.customers
UNION ALL SELECT 'orders', COUNT(*) FROM silver.orders
UNION ALL SELECT 'order_items', COUNT(*) FROM silver.order_items
UNION ALL SELECT 'products', COUNT(*) FROM silver.products
UNION ALL SELECT 'sellers', COUNT(*) FROM silver.sellers
UNION ALL SELECT 'order_payments', COUNT(*) FROM silver.order_payments
UNION ALL SELECT 'order_reviews', COUNT(*) FROM silver.order_reviews
UNION ALL SELECT 'category_translation', COUNT(*) FROM silver.category_translation
UNION ALL SELECT 'geolocation', COUNT(*) FROM silver.geolocation
ORDER BY table_name;

-- H. Validate Silver customers.
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_id) AS unique_customer_ids,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS missing_customer_ids,
    COUNT(*) FILTER (WHERE silver_processed_at IS NULL) AS missing_processing_timestamps
FROM silver.customers;

-- I. Validate Silver orders.
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_order_ids,
    COUNT(*) FILTER (WHERE order_id IS NULL) AS missing_order_ids,
    COUNT(*) FILTER (WHERE silver_processed_at IS NULL) AS missing_processing_timestamps
FROM silver.orders;

-- J. Missing order dates in Silver.
SELECT
    COUNT(*) FILTER (WHERE order_purchase_timestamp IS NULL) AS missing_purchase_dates,
    COUNT(*) FILTER (WHERE order_approved_at IS NULL) AS missing_approval_dates,
    COUNT(*) FILTER (WHERE order_delivered_carrier_date IS NULL) AS missing_carrier_dates,
    COUNT(*) FILTER (WHERE order_delivered_customer_date IS NULL) AS missing_delivery_dates,
    COUNT(*) FILTER (WHERE order_estimated_delivery_date IS NULL) AS missing_estimated_delivery_dates
FROM silver.orders;

-- K. Validate Silver order items.
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT (order_id, order_item_id)) AS unique_order_items,
    COUNT(*) FILTER (WHERE order_id IS NULL OR order_item_id IS NULL) AS missing_key_values,
    COUNT(*) FILTER (WHERE price IS NULL) AS missing_prices,
    COUNT(*) FILTER (WHERE freight_value IS NULL) AS missing_freight_values,
    COUNT(*) FILTER (WHERE silver_processed_at IS NULL) AS missing_processing_timestamps
FROM silver.order_items;

-- L. Validate product and seller references from order items.
SELECT COUNT(*) AS unmatched_product_ids
FROM silver.order_items AS oi
WHERE NOT EXISTS (SELECT 1 FROM silver.products AS p WHERE p.product_id = oi.product_id);

SELECT COUNT(*) AS unmatched_seller_ids
FROM silver.order_items AS oi
WHERE NOT EXISTS (SELECT 1 FROM silver.sellers AS s WHERE s.seller_id = oi.seller_id);

-- M. Review repeated review IDs; repeated IDs are not automatically errors.
SELECT
    COUNT(*) AS total_review_rows,
    COUNT(DISTINCT review_id) AS distinct_review_ids,
    COUNT(DISTINCT order_id) AS distinct_order_ids,
    COUNT(*) FILTER (WHERE review_id IS NULL) AS missing_review_ids,
    COUNT(*) FILTER (WHERE order_id IS NULL) AS missing_order_ids,
    COUNT(*) FILTER (WHERE review_score IS NULL) AS missing_review_scores,
    COUNT(*) FILTER (WHERE silver_processed_at IS NULL) AS missing_processing_timestamps
FROM silver.order_reviews;

-- N. Validate category translation keys and values.
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT product_category_name) AS unique_category_names,
    COUNT(*) FILTER (WHERE product_category_name IS NULL) AS missing_category_names,
    COUNT(*) FILTER (WHERE product_category_name_english IS NULL) AS missing_english_translations,
    COUNT(*) FILTER (WHERE silver_processed_at IS NULL) AS missing_processing_timestamps
FROM silver.category_translation;

-- O. Inspect geolocation row counts and ZIP-prefix uniqueness.
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT geolocation_zip_code_prefix) AS unique_zip_prefixes,
    COUNT(*) FILTER (WHERE geolocation_zip_code_prefix IS NULL) AS missing_zip_prefixes,
    COUNT(*) FILTER (WHERE geolocation_lat IS NULL OR geolocation_lng IS NULL) AS missing_coordinate_pairs,
    COUNT(*) FILTER (WHERE silver_processed_at IS NULL) AS missing_processing_timestamps
FROM silver.geolocation;

-- P. Inspect products and sellers for missing IDs / selected values.
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT product_id) AS unique_product_ids,
    COUNT(*) FILTER (WHERE product_id IS NULL) AS missing_product_ids,
    COUNT(*) FILTER (WHERE product_category_name IS NULL) AS missing_product_categories,
    COUNT(*) FILTER (WHERE silver_processed_at IS NULL) AS missing_processing_timestamps
FROM silver.products;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT seller_id) AS unique_seller_ids,
    COUNT(*) FILTER (WHERE seller_id IS NULL) AS missing_seller_ids,
    COUNT(*) FILTER (WHERE silver_processed_at IS NULL) AS missing_processing_timestamps
FROM silver.sellers;

-- Q. Validate payment composite keys and values.
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT (order_id, payment_sequential)) AS unique_payment_keys,
    COUNT(*) FILTER (WHERE order_id IS NULL OR payment_sequential IS NULL) AS missing_key_values,
    COUNT(*) FILTER (WHERE payment_value IS NULL) AS missing_payment_values,
    COUNT(*) FILTER (WHERE silver_processed_at IS NULL) AS missing_processing_timestamps
FROM silver.order_payments;

-- R. Check foreign keys currently defined on Silver tables.
SELECT
    tc.table_name,
    tc.constraint_name,
    kcu.column_name,
    ccu.table_name AS referenced_table,
    ccu.column_name AS referenced_column
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
  ON tc.constraint_name = kcu.constraint_name
 AND tc.constraint_schema = kcu.constraint_schema
JOIN information_schema.constraint_column_usage AS ccu
  ON ccu.constraint_name = tc.constraint_name
 AND ccu.constraint_schema = tc.constraint_schema
WHERE tc.constraint_type = 'FOREIGN KEY'
  AND tc.constraint_schema = 'silver'
ORDER BY tc.table_name, tc.constraint_name;
