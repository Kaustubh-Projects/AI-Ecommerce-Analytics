-- ============================================================
-- File: 05_create_gold_tables.sql
-- Project: AI-Powered E-Commerce Analytics
-- Purpose: Create the eight core Gold-layer tables.
--
-- IMPORTANT:
-- 1. The silver schema and all required Silver tables must exist.
-- 2. This script creates table structures only; it does not load data.
-- 3. Run this setup script only once on a database where these
--    Gold tables do not already exist.
-- ============================================================


-- ============================================================
-- PART 1: DIMENSION TABLES
-- Dimensions store descriptive information about entities.
-- ============================================================


-- 1. Customer dimension
-- One row per customer_id from the Silver customers table.
-- customer_unique_id will be used for customer-level analysis.

CREATE TABLE gold.dim_customers (
    customer_id TEXT PRIMARY KEY,
    customer_unique_id TEXT,
    customer_zip_code_prefix TEXT,
    customer_city TEXT,
    customer_state TEXT
);


-- 2. Product dimension
-- One row per product.

CREATE TABLE gold.dim_products (
    product_id TEXT PRIMARY KEY,
    product_category_name TEXT,
    product_category_name_english TEXT,
    product_name_lenght INTEGER,
    product_description_lenght INTEGER,
    product_photos_qty INTEGER,
    product_weight_g NUMERIC(12, 2),
    product_length_cm NUMERIC(12, 2),
    product_height_cm NUMERIC(12, 2),
    product_width_cm NUMERIC(12, 2)
);


-- 3. Seller dimension
-- One row per seller.

CREATE TABLE gold.dim_sellers (
    seller_id TEXT PRIMARY KEY,
    seller_zip_code_prefix TEXT,
    seller_city TEXT,
    seller_state TEXT
);


-- 4. Date dimension
-- One row per calendar date.
-- date_key uses YYYYMMDD format, for example 20181025.

CREATE TABLE gold.dim_date (
    date_key INTEGER PRIMARY KEY,
    calendar_date DATE NOT NULL UNIQUE,
    year INTEGER NOT NULL,
    quarter INTEGER NOT NULL,
    month_number INTEGER NOT NULL,
    month_name TEXT NOT NULL,
    day_of_month INTEGER NOT NULL,
    day_of_week INTEGER NOT NULL
);


-- ============================================================
-- PART 2: FACT TABLES
-- Fact tables record business events and measurable values.
-- ============================================================


-- 5. Order fact
-- One row per order.

CREATE TABLE gold.fact_orders (
    order_id TEXT PRIMARY KEY,
    customer_id TEXT NOT NULL,
    order_status TEXT NOT NULL,

    purchase_date_key INTEGER,

    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,

    delivery_days INTEGER,
    delivery_outcome TEXT,

    CONSTRAINT fk_fact_orders_customers
        FOREIGN KEY (customer_id)
        REFERENCES gold.dim_customers (customer_id),

    CONSTRAINT fk_fact_orders_purchase_date
        FOREIGN KEY (purchase_date_key)
        REFERENCES gold.dim_date (date_key),

    CONSTRAINT chk_fact_orders_delivery_outcome
        CHECK (
            delivery_outcome IS NULL
            OR delivery_outcome IN (
                'early',
                'on_time',
                'late',
                'unknown'
            )
        )
);


-- 6. Order-item fact
-- One row per item within an order.
-- The composite key prevents duplicate order-item records.

CREATE TABLE gold.fact_order_items (
    order_id TEXT NOT NULL,
    order_item_id TEXT NOT NULL,

    product_id TEXT NOT NULL,
    seller_id TEXT NOT NULL,
    customer_id TEXT NOT NULL,

    purchase_date_key INTEGER,

    price NUMERIC(12, 2),
    freight_value NUMERIC(12, 2),

    item_quantity INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT pk_fact_order_items
        PRIMARY KEY (order_id, order_item_id),

    CONSTRAINT fk_fact_order_items_orders
        FOREIGN KEY (order_id)
        REFERENCES gold.fact_orders (order_id),

    CONSTRAINT fk_fact_order_items_products
        FOREIGN KEY (product_id)
        REFERENCES gold.dim_products (product_id),

    CONSTRAINT fk_fact_order_items_sellers
        FOREIGN KEY (seller_id)
        REFERENCES gold.dim_sellers (seller_id),

    CONSTRAINT fk_fact_order_items_customers
        FOREIGN KEY (customer_id)
        REFERENCES gold.dim_customers (customer_id),

    CONSTRAINT fk_fact_order_items_purchase_date
        FOREIGN KEY (purchase_date_key)
        REFERENCES gold.dim_date (date_key),

    CONSTRAINT chk_fact_order_items_quantity
        CHECK (item_quantity = 1)
);


-- 7. Payment fact
-- One row per payment sequence within an order.

CREATE TABLE gold.fact_payments (
    order_id TEXT NOT NULL,
    payment_sequential INTEGER NOT NULL,

    payment_type TEXT,
    payment_installments INTEGER,
    payment_value NUMERIC(12, 2),

    CONSTRAINT pk_fact_payments
        PRIMARY KEY (order_id, payment_sequential),

    CONSTRAINT fk_fact_payments_orders
        FOREIGN KEY (order_id)
        REFERENCES gold.fact_orders (order_id)
);


-- 8. Review fact
-- One row per source review record.
-- review_id is not the primary key because source review IDs repeat.

CREATE TABLE gold.fact_reviews (
    silver_review_row_id BIGINT PRIMARY KEY,

    review_id TEXT,
    order_id TEXT NOT NULL,
    customer_id TEXT NOT NULL,

    review_score INTEGER,
    satisfaction_category TEXT,

    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP,

    CONSTRAINT fk_fact_reviews_orders
        FOREIGN KEY (order_id)
        REFERENCES gold.fact_orders (order_id),

    CONSTRAINT fk_fact_reviews_customers
        FOREIGN KEY (customer_id)
        REFERENCES gold.dim_customers (customer_id),

    CONSTRAINT chk_fact_reviews_score
        CHECK (
            review_score IS NULL
            OR review_score BETWEEN 1 AND 5
        ),

    CONSTRAINT chk_fact_reviews_satisfaction
        CHECK (
            satisfaction_category IS NULL
            OR satisfaction_category IN (
                'satisfied',
                'neutral',
                'dissatisfied'
            )
        )
);