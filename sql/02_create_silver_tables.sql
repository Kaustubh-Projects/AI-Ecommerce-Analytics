-- ============================================================
-- 02_create_silver_tables.sql
-- Purpose: Create typed, structured Silver tables.
-- Prerequisite: The silver schema must already exist.
-- Note: This is a setup script. Do not rerun against existing tables.
-- silver_processed_at records when the row was processed into Silver;
-- ingested_at is the Bronze ingestion timestamp carried forward.
-- ============================================================

BEGIN;

CREATE TABLE silver.customers (
    customer_id TEXT PRIMARY KEY,
    customer_unique_id TEXT,
    customer_zip_code_prefix TEXT,
    customer_city TEXT,
    customer_state TEXT,
    source_file TEXT NOT NULL,
    ingested_at TIMESTAMPTZ NOT NULL,
    silver_processed_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE silver.orders (
    order_id TEXT PRIMARY KEY,
    customer_id TEXT NOT NULL,
    order_status TEXT NOT NULL,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,
    source_file TEXT NOT NULL,
    ingested_at TIMESTAMPTZ NOT NULL,
    silver_processed_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_orders_customers
        FOREIGN KEY (customer_id)
        REFERENCES silver.customers (customer_id)
);

CREATE TABLE silver.products (
    product_id TEXT PRIMARY KEY,
    product_category_name TEXT,
    product_name_lenght INTEGER,
    product_description_lenght INTEGER,
    product_photos_qty INTEGER,
    product_weight_g NUMERIC(12, 2),
    product_length_cm NUMERIC(12, 2),
    product_height_cm NUMERIC(12, 2),
    product_width_cm NUMERIC(12, 2),
    source_file TEXT NOT NULL,
    ingested_at TIMESTAMPTZ NOT NULL,
    silver_processed_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE silver.sellers (
    seller_id TEXT PRIMARY KEY,
    seller_zip_code_prefix TEXT,
    seller_city TEXT,
    seller_state TEXT,
    source_file TEXT NOT NULL,
    ingested_at TIMESTAMPTZ NOT NULL,
    silver_processed_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE silver.order_items (
    order_id TEXT NOT NULL,
    order_item_id TEXT NOT NULL,
    product_id TEXT NOT NULL,
    seller_id TEXT NOT NULL,
    shipping_limit_date TIMESTAMP,
    price NUMERIC(12, 2),
    freight_value NUMERIC(12, 2),
    source_file TEXT NOT NULL,
    ingested_at TIMESTAMPTZ NOT NULL,
    silver_processed_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_order_items PRIMARY KEY (order_id, order_item_id),
    CONSTRAINT fk_order_items_orders
        FOREIGN KEY (order_id)
        REFERENCES silver.orders (order_id),
    CONSTRAINT fk_order_items_products
        FOREIGN KEY (product_id)
        REFERENCES silver.products (product_id),
    CONSTRAINT fk_order_items_sellers
        FOREIGN KEY (seller_id)
        REFERENCES silver.sellers (seller_id)
);

CREATE TABLE silver.order_payments (
    order_id TEXT NOT NULL,
    payment_sequential INTEGER NOT NULL,
    payment_type TEXT,
    payment_installments INTEGER,
    payment_value NUMERIC(12, 2),
    source_file TEXT NOT NULL,
    ingested_at TIMESTAMPTZ NOT NULL,
    silver_processed_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_order_payments PRIMARY KEY (order_id, payment_sequential),
    CONSTRAINT fk_order_payments_orders
        FOREIGN KEY (order_id)
        REFERENCES silver.orders (order_id)
);

CREATE TABLE silver.order_reviews (
    silver_review_row_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    review_id TEXT,
    order_id TEXT NOT NULL,
    review_score INTEGER,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP,
    source_file TEXT NOT NULL,
    ingested_at TIMESTAMPTZ NOT NULL,
    silver_processed_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_order_reviews_orders
        FOREIGN KEY (order_id)
        REFERENCES silver.orders (order_id)
);

CREATE TABLE silver.category_translation (
    product_category_name TEXT PRIMARY KEY,
    product_category_name_english TEXT,
    source_file TEXT NOT NULL,
    ingested_at TIMESTAMPTZ NOT NULL,
    silver_processed_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE silver.geolocation (
    silver_geolocation_row_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    geolocation_zip_code_prefix TEXT,
    geolocation_lat NUMERIC(10, 7),
    geolocation_lng NUMERIC(10, 7),
    geolocation_city TEXT,
    geolocation_state TEXT,
    source_file TEXT NOT NULL,
    ingested_at TIMESTAMPTZ NOT NULL,
    silver_processed_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMIT;

-- Design notes:
-- 1. order_reviews.review_id is intentionally not UNIQUE because the source
--    data contains repeated review IDs associated with different orders.
-- 2. geolocation_zip_code_prefix is intentionally not UNIQUE because many
--    rows can share a ZIP prefix.
-- 3. No FK is added from products.product_category_name to category_translation
--    because two source categories have no translation.
