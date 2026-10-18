
-- ============================================================
-- File: 06_load_gold_tables.sql
-- Purpose: Load all eight Gold tables from the Silver layer.
-- Source: Silver tables
-- Target: Gold dimensions and fact tables
--
-- IMPORTANT:
-- Run after 05_create_gold_tables.sql.
-- Run this script only once on empty Gold tables.
-- ============================================================


-- PART 1: LOAD CUSTOMER DIMENSION

INSERT INTO gold.dim_customers (
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
)
SELECT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
FROM silver.customers;


-- PART 2: LOAD PRODUCT DIMENSION

INSERT INTO gold.dim_products (
    product_id,
    product_category_name,
    product_category_name_english,
    product_name_lenght,
    product_description_lenght,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
)
SELECT
    p.product_id,
    p.product_category_name,
    ct.product_category_name_english,
    p.product_name_lenght,
    p.product_description_lenght,
    p.product_photos_qty,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm
FROM silver.products AS p
LEFT JOIN silver.category_translation AS ct
    ON p.product_category_name = ct.product_category_name;


-- PART 3: LOAD SELLER DIMENSION

INSERT INTO gold.dim_sellers (
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
)
SELECT
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
FROM silver.sellers;


-- PART 4: LOAD DATE DIMENSION

-- Create one date row for every calendar day between
-- the earliest and latest order purchase dates.

INSERT INTO gold.dim_date (
    date_key,
    calendar_date,
    year,
    quarter,
    month_number,
    month_name,
    day_of_month,
    day_of_week
)
SELECT
    TO_CHAR(d.calendar_date, 'YYYYMMDD')::INTEGER AS date_key,
    d.calendar_date,
    EXTRACT(YEAR FROM d.calendar_date)::INTEGER,
    EXTRACT(QUARTER FROM d.calendar_date)::INTEGER,
    EXTRACT(MONTH FROM d.calendar_date)::INTEGER,
    TO_CHAR(d.calendar_date, 'FMMonth'),
    EXTRACT(DAY FROM d.calendar_date)::INTEGER,
    EXTRACT(ISODOW FROM d.calendar_date)::INTEGER
FROM GENERATE_SERIES(
    (
        SELECT MIN(order_purchase_timestamp)::DATE
        FROM silver.orders
        WHERE order_purchase_timestamp IS NOT NULL
    ),
    (
        SELECT MAX(order_purchase_timestamp)::DATE
        FROM silver.orders
        WHERE order_purchase_timestamp IS NOT NULL
    ),
    INTERVAL '1 day'
) AS d(calendar_date);


-- PART 5: LOAD ORDER FACT

INSERT INTO gold.fact_orders (
    order_id,
    customer_id,
    order_status,
    purchase_date_key,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date,
    delivery_days,
    delivery_outcome
)
SELECT
    o.order_id,
    o.customer_id,
    o.order_status,
    TO_CHAR(o.order_purchase_timestamp::DATE, 'YYYYMMDD')::INTEGER,
    o.order_approved_at,
    o.order_delivered_carrier_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,

    CASE
        WHEN o.order_delivered_customer_date IS NOT NULL
         AND o.order_purchase_timestamp IS NOT NULL
        THEN
            o.order_delivered_customer_date::DATE
            - o.order_purchase_timestamp::DATE
        ELSE NULL
    END AS delivery_days,

    CASE
        WHEN o.order_delivered_customer_date IS NULL
          OR o.order_estimated_delivery_date IS NULL
        THEN 'unknown'
        WHEN o.order_delivered_customer_date::DATE
           < o.order_estimated_delivery_date::DATE
        THEN 'early'
        WHEN o.order_delivered_customer_date::DATE
           = o.order_estimated_delivery_date::DATE
        THEN 'on_time'
        ELSE 'late'
    END AS delivery_outcome

FROM silver.orders AS o;


-- PART 6: LOAD ORDER ITEM FACT

INSERT INTO gold.fact_order_items (
    order_id,
    order_item_id,
    product_id,
    seller_id,
    customer_id,
    purchase_date_key,
    price,
    freight_value,
    item_quantity
)
SELECT
    oi.order_id,
    oi.order_item_id,
    oi.product_id,
    oi.seller_id,
    o.customer_id,
    TO_CHAR(o.order_purchase_timestamp::DATE, 'YYYYMMDD')::INTEGER,
    oi.price,
    oi.freight_value,
    1
FROM silver.order_items AS oi
JOIN silver.orders AS o
    ON oi.order_id = o.order_id;


-- PART 7: LOAD PAYMENT FACT

INSERT INTO gold.fact_payments (
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value
)
SELECT
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value
FROM silver.order_payments;


-- PART 8: LOAD REVIEW FACT

INSERT INTO gold.fact_reviews (
    silver_review_row_id,
    review_id,
    order_id,
    customer_id,
    review_score,
    satisfaction_category,
    review_creation_date,
    review_answer_timestamp
)
SELECT
    r.silver_review_row_id,
    r.review_id,
    r.order_id,
    o.customer_id,
    r.review_score,

    CASE
        WHEN r.review_score IN (4, 5) THEN 'satisfied'
        WHEN r.review_score = 3 THEN 'neutral'
        WHEN r.review_score IN (1, 2) THEN 'dissatisfied'
        ELSE NULL
    END AS satisfaction_category,

    r.review_creation_date,
    r.review_answer_timestamp

FROM silver.order_reviews AS r
JOIN silver.orders AS o
    ON r.order_id = o.order_id;


-- END OF GOLD TABLE LOADING