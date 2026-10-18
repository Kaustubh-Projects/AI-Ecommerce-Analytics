
-- ============================================================
-- File: 07_create_gold_views.sql
-- Purpose: Create six analytical views for the project.
--
-- Run only after 06_load_gold_tables.sql succeeds.
-- These views are created once; use CREATE OR REPLACE VIEW
-- when updating their definitions later.
-- ============================================================


-- VIEW 1: SALES PERFORMANCE
-- Grain: purchase date + product + customer location + seller.
-- Revenue and freight include delivered orders only.

CREATE OR REPLACE VIEW gold.vw_sales_performance AS
SELECT
    dd.calendar_date AS purchase_date,
    EXTRACT(YEAR FROM dd.calendar_date)::INTEGER AS purchase_year,
    EXTRACT(MONTH FROM dd.calendar_date)::INTEGER AS purchase_month,
    p.product_id,
    p.product_category_name,
    p.product_category_name_english,
    c.customer_state,
    c.customer_city,
    s.seller_id,
    s.seller_state,
    s.seller_city,

    SUM(oi.price) AS item_revenue,
    SUM(oi.freight_value) AS freight_revenue,
    COUNT(*) AS item_count,
    COUNT(DISTINCT oi.order_id) AS order_count

FROM gold.fact_order_items AS oi
JOIN gold.fact_orders AS fo
    ON oi.order_id = fo.order_id
JOIN gold.dim_date AS dd
    ON oi.purchase_date_key = dd.date_key
JOIN gold.dim_products AS p
    ON oi.product_id = p.product_id
JOIN gold.dim_customers AS c
    ON oi.customer_id = c.customer_id
JOIN gold.dim_sellers AS s
    ON oi.seller_id = s.seller_id

WHERE fo.order_status = 'delivered'

GROUP BY
    dd.calendar_date,
    p.product_id,
    p.product_category_name,
    p.product_category_name_english,
    c.customer_state,
    c.customer_city,
    s.seller_id,
    s.seller_state,
    s.seller_city;


-- VIEW 2: DELIVERY PERFORMANCE
-- Grain: one row per order.

CREATE OR REPLACE VIEW gold.vw_delivery_performance AS
SELECT
    fo.order_id,
    fo.customer_id,
    fo.order_status,
    purchase_date.calendar_date AS purchase_date,
    fo.order_delivered_customer_date,
    fo.order_estimated_delivery_date,
    fo.delivery_days,
    fo.delivery_outcome

FROM gold.fact_orders AS fo
LEFT JOIN gold.dim_date AS purchase_date
    ON fo.purchase_date_key = purchase_date.date_key;


-- VIEW 3: CUSTOMER RFM
-- RFM uses delivered orders only.
-- Monetary value is item price; freight is excluded.
-- Reference date = day after the latest purchase date
-- available in the dataset.

CREATE OR REPLACE VIEW gold.vw_customer_rfm AS
WITH reference_date AS (
    SELECT MAX(calendar_date) + 1 AS reference_date
    FROM gold.dim_date
),

customer_metrics AS (
    SELECT
        c.customer_unique_id,
        MAX(dd.calendar_date) AS last_purchase_date,
        COUNT(DISTINCT fo.order_id) AS frequency,
        SUM(oi.price) AS monetary

    FROM gold.fact_orders AS fo
    JOIN gold.dim_customers AS c
        ON fo.customer_id = c.customer_id
    JOIN gold.fact_order_items AS oi
        ON fo.order_id = oi.order_id
    JOIN gold.dim_date AS dd
        ON fo.purchase_date_key = dd.date_key

    WHERE fo.order_status = 'delivered'

    GROUP BY c.customer_unique_id
),

rfm_values AS (
    SELECT
        cm.customer_unique_id,
        (rd.reference_date - cm.last_purchase_date) AS recency_days,
        cm.frequency,
        cm.monetary

    FROM customer_metrics AS cm
    CROSS JOIN reference_date AS rd
),

rfm_scores AS (
    SELECT
        customer_unique_id,
        recency_days,
        frequency,
        monetary,

        NTILE(5) OVER (
            ORDER BY recency_days ASC
        ) AS recency_score,

        NTILE(5) OVER (
            ORDER BY frequency ASC
        ) AS frequency_score,

        NTILE(5) OVER (
            ORDER BY monetary ASC
        ) AS monetary_score

    FROM rfm_values
),

scored AS (
    SELECT
        *,
        recency_score + frequency_score + monetary_score
            AS rfm_score

    FROM rfm_scores
)

SELECT
    customer_unique_id,
    recency_days,
    frequency,
    monetary,
    recency_score,
    frequency_score,
    monetary_score,
    rfm_score,

    CASE
        WHEN rfm_score >= 13 THEN 'Champions'
        WHEN rfm_score >= 10 THEN 'Loyal_or_Promising'
        WHEN rfm_score >= 7 THEN 'Needs_Attention'
        ELSE 'At_Risk'
    END AS rfm_segment

FROM scored;


-- VIEW 4: PRODUCT PERFORMANCE
-- Delivered-order revenue only.

CREATE OR REPLACE VIEW gold.vw_product_performance AS
SELECT
    p.product_id,
    p.product_category_name,
    p.product_category_name_english,
    COUNT(*) AS item_count,
    COUNT(DISTINCT oi.order_id) AS order_count,
    SUM(oi.price) AS item_revenue,
    SUM(oi.freight_value) AS freight_revenue,
    AVG(oi.price) AS average_item_price

FROM gold.fact_order_items AS oi
JOIN gold.fact_orders AS fo
    ON oi.order_id = fo.order_id
JOIN gold.dim_products AS p
    ON oi.product_id = p.product_id

WHERE fo.order_status = 'delivered'

GROUP BY
    p.product_id,
    p.product_category_name,
    p.product_category_name_english;


-- VIEW 5: SELLER PERFORMANCE
-- Revenue is based on delivered orders.
-- Delivery metrics use orders that have delivery durations.

CREATE OR REPLACE VIEW gold.vw_seller_performance AS
WITH item_metrics AS (
    SELECT
        oi.seller_id,
        SUM(oi.price) FILTER (
            WHERE fo.order_status = 'delivered'
        ) AS item_revenue,

        SUM(oi.freight_value) FILTER (
            WHERE fo.order_status = 'delivered'
        ) AS freight_revenue,

        COUNT(DISTINCT oi.order_id) FILTER (
            WHERE fo.order_status = 'delivered'
        ) AS delivered_order_count

    FROM gold.fact_order_items AS oi
    JOIN gold.fact_orders AS fo
        ON oi.order_id = fo.order_id

    GROUP BY oi.seller_id
),

delivery_metrics AS (
    SELECT
        oi.seller_id,

        AVG(fo.delivery_days) FILTER (
    WHERE fo.order_status = 'delivered'
      AND fo.delivery_days IS NOT NULL
) AS average_delivery_days,

COUNT(DISTINCT fo.order_id) FILTER (
    WHERE fo.order_status = 'delivered'
      AND fo.delivery_outcome = 'late'
) AS late_order_count

    FROM gold.fact_order_items AS oi
    JOIN gold.fact_orders AS fo
        ON oi.order_id = fo.order_id

    GROUP BY oi.seller_id
)

SELECT
    s.seller_id,
    s.seller_city,
    s.seller_state,
    im.item_revenue,
    im.freight_revenue,
    im.delivered_order_count,
    dm.average_delivery_days,
    dm.late_order_count

FROM gold.dim_sellers AS s
LEFT JOIN item_metrics AS im
    ON s.seller_id = im.seller_id
LEFT JOIN delivery_metrics AS dm
    ON s.seller_id = dm.seller_id;



-- VIEW 6: CUSTOMER SATISFACTION AND REPURCHASE
-- One row per reviewed customer-product pair.
-- Reviews belong to orders, not individual products.
-- Therefore, this is order-review-associated product analysis,
-- not proof of a product-specific rating.

CREATE OR REPLACE VIEW gold.vw_customer_satisfaction_repurchase AS
WITH review_product_pairs AS (
    -- Remove duplicate order/product associations before
    -- connecting reviews to products.
    SELECT DISTINCT
        fr.silver_review_row_id,
        fr.review_score,
        fr.order_id,
        c.customer_unique_id,
        oi.product_id,
        dd.calendar_date AS reviewed_order_date
    FROM gold.fact_reviews AS fr
    JOIN gold.fact_orders AS fo
        ON fr.order_id = fo.order_id
    JOIN gold.dim_customers AS c
        ON fr.customer_id = c.customer_id
    JOIN gold.fact_order_items AS oi
        ON fr.order_id = oi.order_id
    JOIN gold.dim_date AS dd
        ON fo.purchase_date_key = dd.date_key
),

reviewed_pairs AS (
    SELECT
        customer_unique_id,
        product_id,
        MAX(reviewed_order_date) AS latest_reviewed_order_date,
        COUNT(DISTINCT silver_review_row_id) AS review_count,
        AVG(review_score::NUMERIC) AS average_review_score
    FROM review_product_pairs
    GROUP BY
        customer_unique_id,
        product_id
),

pair_results AS (
    SELECT
        rp.customer_unique_id,
        rp.product_id,
        rp.latest_reviewed_order_date,
        rp.review_count,
        rp.average_review_score,

        CASE
            WHEN rp.average_review_score >= 4 THEN 'satisfied'
            WHEN rp.average_review_score >= 3 THEN 'neutral'
            WHEN rp.average_review_score IS NOT NULL
                THEN 'dissatisfied'
            ELSE NULL
        END AS satisfaction_category,

        EXISTS (
            SELECT 1
            FROM gold.fact_order_items AS later_item
            JOIN gold.fact_orders AS later_order
                ON later_item.order_id = later_order.order_id
            JOIN gold.dim_customers AS later_customer
                ON later_order.customer_id = later_customer.customer_id
            JOIN gold.dim_date AS later_date
                ON later_order.purchase_date_key = later_date.date_key
            WHERE later_customer.customer_unique_id =
                    rp.customer_unique_id
              AND later_item.product_id = rp.product_id
              AND later_order.order_status = 'delivered'
              AND later_date.calendar_date >
                    rp.latest_reviewed_order_date
        ) AS repurchased_same_product

    FROM reviewed_pairs AS rp
)

SELECT *
FROM pair_results;