-- ============================================================
-- 03_load_silver_tables.sql
-- Purpose: Convert selected Bronze TEXT values into Silver data types.
-- Prerequisite: Bronze tables are populated and Silver tables are empty.
-- WARNING: This is a one-time initial load. Do not rerun against populated
-- Silver tables; primary-key conflicts may occur and duplicate loads are
-- not an intended refresh strategy.
-- ============================================================

BEGIN;

-- 1. Customers
INSERT INTO silver.customers (
    customer_id, customer_unique_id, customer_zip_code_prefix,
    customer_city, customer_state, source_file, ingested_at
)
SELECT
    customer_id, customer_unique_id, customer_zip_code_prefix,
    customer_city, customer_state, source_file, ingested_at
FROM bronze.customers;

-- 2. Orders: empty date strings become NULL; valid dates become TIMESTAMP.
INSERT INTO silver.orders (
    order_id, customer_id, order_status, order_purchase_timestamp,
    order_approved_at, order_delivered_carrier_date,
    order_delivered_customer_date, order_estimated_delivery_date,
    source_file, ingested_at
)
SELECT
    order_id,
    customer_id,
    order_status,
    NULLIF(TRIM(order_purchase_timestamp), '')::TIMESTAMP,
    NULLIF(TRIM(order_approved_at), '')::TIMESTAMP,
    NULLIF(TRIM(order_delivered_carrier_date), '')::TIMESTAMP,
    NULLIF(TRIM(order_delivered_customer_date), '')::TIMESTAMP,
    NULLIF(TRIM(order_estimated_delivery_date), '')::TIMESTAMP,
    source_file,
    ingested_at
FROM bronze.orders;

-- 3. Products: descriptive counts become INTEGER and measurements become NUMERIC.
INSERT INTO silver.products (
    product_id, product_category_name, product_name_lenght,
    product_description_lenght, product_photos_qty, product_weight_g,
    product_length_cm, product_height_cm, product_width_cm,
    source_file, ingested_at
)
SELECT
    product_id,
    product_category_name,
    NULLIF(TRIM(product_name_lenght), '')::INTEGER,
    NULLIF(TRIM(product_description_lenght), '')::INTEGER,
    NULLIF(TRIM(product_photos_qty), '')::INTEGER,
    NULLIF(TRIM(product_weight_g), '')::NUMERIC(12, 2),
    NULLIF(TRIM(product_length_cm), '')::NUMERIC(12, 2),
    NULLIF(TRIM(product_height_cm), '')::NUMERIC(12, 2),
    NULLIF(TRIM(product_width_cm), '')::NUMERIC(12, 2),
    source_file,
    ingested_at
FROM bronze.products;

-- 4. Sellers
INSERT INTO silver.sellers (
    seller_id, seller_zip_code_prefix, seller_city, seller_state,
    source_file, ingested_at
)
SELECT
    seller_id, seller_zip_code_prefix, seller_city, seller_state,
    source_file, ingested_at
FROM bronze.sellers;

-- 5. Order items: dates and monetary values are converted to suitable types.
INSERT INTO silver.order_items (
    order_id, order_item_id, product_id, seller_id, shipping_limit_date,
    price, freight_value, source_file, ingested_at
)
SELECT
    order_id,
    order_item_id,
    product_id,
    seller_id,
    NULLIF(TRIM(shipping_limit_date), '')::TIMESTAMP,
    NULLIF(TRIM(price), '')::NUMERIC(12, 2),
    NULLIF(TRIM(freight_value), '')::NUMERIC(12, 2),
    source_file,
    ingested_at
FROM bronze.order_items;

-- 6. Order payments
INSERT INTO silver.order_payments (
    order_id, payment_sequential, payment_type, payment_installments,
    payment_value, source_file, ingested_at
)
SELECT
    order_id,
    NULLIF(TRIM(payment_sequential), '')::INTEGER,
    payment_type,
    NULLIF(TRIM(payment_installments), '')::INTEGER,
    NULLIF(TRIM(payment_value), '')::NUMERIC(12, 2),
    source_file,
    ingested_at
FROM bronze.order_payments;

-- 7. Order reviews: review IDs are retained as source values, not assumed unique.
INSERT INTO silver.order_reviews (
    review_id, order_id, review_score, review_comment_title,
    review_comment_message, review_creation_date, review_answer_timestamp,
    source_file, ingested_at
)
SELECT
    review_id,
    order_id,
    NULLIF(TRIM(review_score), '')::INTEGER,
    review_comment_title,
    review_comment_message,
    NULLIF(TRIM(review_creation_date), '')::TIMESTAMP,
    NULLIF(TRIM(review_answer_timestamp), '')::TIMESTAMP,
    source_file,
    ingested_at
FROM bronze.order_reviews;

-- 8. Category translation
INSERT INTO silver.category_translation (
    product_category_name, product_category_name_english, source_file, ingested_at
)
SELECT
    product_category_name, product_category_name_english, source_file, ingested_at
FROM bronze.category_translation;

-- 9. Geolocation
INSERT INTO silver.geolocation (
    geolocation_zip_code_prefix, geolocation_lat, geolocation_lng,
    geolocation_city, geolocation_state, source_file, ingested_at
)
SELECT
    geolocation_zip_code_prefix,
    NULLIF(TRIM(geolocation_lat), '')::NUMERIC(10, 7),
    NULLIF(TRIM(geolocation_lng), '')::NUMERIC(10, 7),
    geolocation_city,
    geolocation_state,
    source_file,
    ingested_at
FROM bronze.geolocation;

COMMIT;
