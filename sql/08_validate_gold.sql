
-- ============================================================
-- File: 12_validate_gold_completely.sql
-- Project: AI-Powered E-Commerce Analytics
--
-- PURPOSE:
-- Validate the Gold layer after loading tables and creating
-- the six analytical views.
--
-- IMPORTANT:
-- 1. Run against the ecommerce_analytics database.
-- 2. This script is read-only. It does not modify data.
-- 3. Some checks compare values; others report known data
--    quality conditions for review.
-- 4. All checks are returned together in one result grid.
-- ============================================================


WITH checks AS (

    -- --------------------------------------------------------
    -- CHECK 1: CUSTOMER ROW COUNT
    -- Gold customer dimension should match Silver customers.
    -- --------------------------------------------------------
    SELECT
        1 AS check_order,
        'Customer dimension row count' AS check_name,
        (SELECT COUNT(*) FROM gold.dim_customers)::NUMERIC
            AS actual_value,
        (SELECT COUNT(*) FROM silver.customers)::NUMERIC
            AS expected_value,
        'equal' AS rule,
        'Gold customers should match Silver customers.'
            AS explanation

    UNION ALL

    -- CHECK 2: PRODUCT ROW COUNT
    SELECT
        2,
        'Product dimension row count',
        (SELECT COUNT(*) FROM gold.dim_products)::NUMERIC,
        (SELECT COUNT(*) FROM silver.products)::NUMERIC,
        'equal',
        'Products should be retained, including products without translations.'

    UNION ALL

    -- CHECK 3: SELLER ROW COUNT
    SELECT
        3,
        'Seller dimension row count',
        (SELECT COUNT(*) FROM gold.dim_sellers)::NUMERIC,
        (SELECT COUNT(*) FROM silver.sellers)::NUMERIC,
        'equal',
        'Gold sellers should match Silver sellers.'

    UNION ALL

    -- CHECK 4: ORDER ROW COUNT
    SELECT
        4,
        'Order fact row count',
        (SELECT COUNT(*) FROM gold.fact_orders)::NUMERIC,
        (SELECT COUNT(*) FROM silver.orders)::NUMERIC,
        'equal',
        'One Gold fact row is expected per Silver order.'

    UNION ALL

    -- CHECK 5: ORDER ITEM ROW COUNT
    SELECT
        5,
        'Order item fact row count',
        (SELECT COUNT(*) FROM gold.fact_order_items)::NUMERIC,
        (SELECT COUNT(*) FROM silver.order_items)::NUMERIC,
        'equal',
        'One Gold fact row is expected per Silver order-item row.'

    UNION ALL

    -- CHECK 6: PAYMENT ROW COUNT
    SELECT
        6,
        'Payment fact row count',
        (SELECT COUNT(*) FROM gold.fact_payments)::NUMERIC,
        (SELECT COUNT(*) FROM silver.order_payments)::NUMERIC,
        'equal',
        'Gold payment rows should match Silver payment rows.'

    UNION ALL

    -- CHECK 7: REVIEW ROW COUNT
    SELECT
        7,
        'Review fact row count',
        (SELECT COUNT(*) FROM gold.fact_reviews)::NUMERIC,
        (SELECT COUNT(*) FROM silver.order_reviews)::NUMERIC,
        'equal',
        'Gold review rows should match Silver review rows.'

    UNION ALL

    -- CHECK 8: DATE DIMENSION SIZE
    -- Historical source dates currently span 774 calendar days.
    SELECT
        8,
        'Date dimension row count',
        (SELECT COUNT(*) FROM gold.dim_date)::NUMERIC,
        774::NUMERIC,
        'equal',
        'Expected calendar coverage based on the current Olist dataset.'

    UNION ALL

    -- CHECK 9: DATE DIMENSION CONTINUITY
    -- Date dimension should contain every day in its date range.
    SELECT
        9,
        'Date dimension continuity',
        (
            SELECT COUNT(*)
            FROM gold.dim_date
        )::NUMERIC,
        (
            SELECT
                MAX(calendar_date) - MIN(calendar_date) + 1
            FROM gold.dim_date
        )::NUMERIC,
        'equal',
        'Number of dates should equal the inclusive calendar range.'

    UNION ALL

    -- CHECK 10: ORDERS WITH MISSING PURCHASE DATE KEYS
    SELECT
        10,
        'Orders missing purchase date key',
        (
            SELECT COUNT(*)
            FROM gold.fact_orders
            WHERE purchase_date_key IS NULL
        )::NUMERIC,
        0::NUMERIC,
        'equal',
        'Purchase date keys should exist for orders with purchase dates.'

    UNION ALL

    -- CHECK 11: ORDER ITEMS WITH MISSING DATE KEYS
    SELECT
        11,
        'Order items missing purchase date key',
        (
            SELECT COUNT(*)
            FROM gold.fact_order_items
            WHERE purchase_date_key IS NULL
        )::NUMERIC,
        0::NUMERIC,
        'equal',
        'Order items should inherit their order purchase date.'

    UNION ALL

    -- CHECK 12: ORPHAN ORDER ITEMS
    -- An orphan is an item whose order is absent from Gold orders.
    SELECT
        12,
        'Order items without a matching order',
        (
            SELECT COUNT(*)
            FROM gold.fact_order_items AS oi
            LEFT JOIN gold.fact_orders AS fo
                ON oi.order_id = fo.order_id
            WHERE fo.order_id IS NULL
        )::NUMERIC,
        0::NUMERIC,
        'equal',
        'Every Gold order item should reference a Gold order.'

    UNION ALL

    -- CHECK 13: INVALID PRODUCT REFERENCES
    SELECT
        13,
        'Order items without a matching product',
        (
            SELECT COUNT(*)
            FROM gold.fact_order_items AS oi
            LEFT JOIN gold.dim_products AS p
                ON oi.product_id = p.product_id
            WHERE p.product_id IS NULL
        )::NUMERIC,
        0::NUMERIC,
        'equal',
        'Every order item should reference a product dimension row.'

    UNION ALL

    -- CHECK 14: INVALID SELLER REFERENCES
    SELECT
        14,
        'Order items without a matching seller',
        (
            SELECT COUNT(*)
            FROM gold.fact_order_items AS oi
            LEFT JOIN gold.dim_sellers AS s
                ON oi.seller_id = s.seller_id
            WHERE s.seller_id IS NULL
        )::NUMERIC,
        0::NUMERIC,
        'equal',
        'Every order item should reference a seller dimension row.'

    UNION ALL

    -- CHECK 15: INVALID CUSTOMER REFERENCES IN ORDERS
    SELECT
        15,
        'Orders without a matching customer',
        (
            SELECT COUNT(*)
            FROM gold.fact_orders AS fo
            LEFT JOIN gold.dim_customers AS c
                ON fo.customer_id = c.customer_id
            WHERE c.customer_id IS NULL
        )::NUMERIC,
        0::NUMERIC,
        'equal',
        'Every order should reference a customer dimension row.'

    UNION ALL

    -- CHECK 16: INVALID DATE DIMENSION REFERENCES
    SELECT
        16,
        'Order date keys without a matching date',
        (
            SELECT COUNT(*)
            FROM gold.fact_orders AS fo
            LEFT JOIN gold.dim_date AS dd
                ON fo.purchase_date_key = dd.date_key
            WHERE fo.purchase_date_key IS NOT NULL
              AND dd.date_key IS NULL
        )::NUMERIC,
        0::NUMERIC,
        'equal',
        'Non-null order date keys should match the date dimension.'

    UNION ALL

    -- CHECK 17: PAYMENT ORDER REFERENCES
    SELECT
        17,
        'Payments without a matching order',
        (
            SELECT COUNT(*)
            FROM gold.fact_payments AS fp
            LEFT JOIN gold.fact_orders AS fo
                ON fp.order_id = fo.order_id
            WHERE fo.order_id IS NULL
        )::NUMERIC,
        0::NUMERIC,
        'equal',
        'Every payment should reference an order.'

    UNION ALL

    -- CHECK 18: REVIEW ORDER REFERENCES
    SELECT
        18,
        'Reviews without a matching order',
        (
            SELECT COUNT(*)
            FROM gold.fact_reviews AS fr
            LEFT JOIN gold.fact_orders AS fo
                ON fr.order_id = fo.order_id
            WHERE fo.order_id IS NULL
        )::NUMERIC,
        0::NUMERIC,
        'equal',
        'Every review should reference an order.'

    UNION ALL

    -- CHECK 19: REVIEW CUSTOMER REFERENCES
    SELECT
        19,
        'Reviews without a matching customer',
        (
            SELECT COUNT(*)
            FROM gold.fact_reviews AS fr
            LEFT JOIN gold.dim_customers AS c
                ON fr.customer_id = c.customer_id
            WHERE c.customer_id IS NULL
        )::NUMERIC,
        0::NUMERIC,
        'equal',
        'Every review should reference a customer.'

    UNION ALL

    -- CHECK 20: REVIEW SATISFACTION CLASSIFICATION
    SELECT
        20,
        'Incorrect review satisfaction classifications',
        (
            SELECT COUNT(*)
            FROM gold.fact_reviews
            WHERE
                (review_score IN (4, 5)
                    AND satisfaction_category
                        IS DISTINCT FROM 'satisfied')
             OR (review_score = 3
                    AND satisfaction_category
                        IS DISTINCT FROM 'neutral')
             OR (review_score IN (1, 2)
                    AND satisfaction_category
                        IS DISTINCT FROM 'dissatisfied')
             OR (review_score IS NULL
                    AND satisfaction_category IS NOT NULL)
        )::NUMERIC,
        0::NUMERIC,
        'equal',
        'Scores 4-5 are satisfied, 3 neutral, and 1-2 dissatisfied.'

    UNION ALL

    -- CHECK 21: NEGATIVE DELIVERY DURATIONS
    SELECT
        21,
        'Orders with negative delivery duration',
        (
            SELECT COUNT(*)
            FROM gold.fact_orders
            WHERE delivery_days < 0
        )::NUMERIC,
        0::NUMERIC,
        'equal',
        'Negative durations require investigation, not silent correction.'

    UNION ALL

    -- CHECK 22: DELIVERY VIEW PRESERVES ORDERS
    SELECT
        22,
        'Delivery view row count',
        (SELECT COUNT(*) FROM gold.vw_delivery_performance)::NUMERIC,
        (SELECT COUNT(*) FROM gold.fact_orders)::NUMERIC,
        'equal',
        'Delivery view should have one row per order.'

    UNION ALL

    -- CHECK 23: SALES VIEW REVENUE RECONCILIATION
    -- Compare direct delivered-order item revenue with the sales view.
    SELECT
        23,
        'Sales view item revenue difference',
        (
            SELECT COALESCE(SUM(item_revenue), 0)
            FROM gold.vw_sales_performance
        ) -
        (
            SELECT COALESCE(SUM(oi.price), 0)
            FROM gold.fact_order_items AS oi
            JOIN gold.fact_orders AS fo
                ON oi.order_id = fo.order_id
            WHERE fo.order_status = 'delivered'
        ),
        0::NUMERIC,
        'zero',
        'Difference should be zero, allowing rounding tolerance.'

    UNION ALL

    -- CHECK 24: PRODUCT VIEW REVENUE RECONCILIATION
    SELECT
        24,
        'Product view item revenue difference',
        (
            SELECT COALESCE(SUM(item_revenue), 0)
            FROM gold.vw_product_performance
        ) -
        (
            SELECT COALESCE(SUM(oi.price), 0)
            FROM gold.fact_order_items AS oi
            JOIN gold.fact_orders AS fo
                ON oi.order_id = fo.order_id
            WHERE fo.order_status = 'delivered'
        ),
        0::NUMERIC,
        'zero',
        'Product-level revenue should reconcile to delivered item revenue.'

    UNION ALL

    -- CHECK 25: SELLER VIEW REVENUE RECONCILIATION
    SELECT
        25,
        'Seller view item revenue difference',
        (
            SELECT COALESCE(SUM(item_revenue), 0)
            FROM gold.vw_seller_performance
        ) -
        (
            SELECT COALESCE(SUM(oi.price), 0)
            FROM gold.fact_order_items AS oi
            JOIN gold.fact_orders AS fo
                ON oi.order_id = fo.order_id
            WHERE fo.order_status = 'delivered'
        ),
        0::NUMERIC,
        'zero',
        'Seller-level revenue should reconcile to delivered item revenue.'

    UNION ALL

    -- CHECK 26: RFM CUSTOMER COUNT
    SELECT
        26,
        'RFM customer count',
        (SELECT COUNT(*) FROM gold.vw_customer_rfm)::NUMERIC,
        (
            SELECT COUNT(DISTINCT c.customer_unique_id)
            FROM gold.fact_orders AS fo
            JOIN gold.dim_customers AS c
                ON fo.customer_id = c.customer_id
            WHERE fo.order_status = 'delivered'
        )::NUMERIC,
        'equal',
        'RFM should have one row per unique customer with delivered purchases.'

    UNION ALL

    -- CHECK 27: RFM MONETARY RECONCILIATION
    SELECT
        27,
        'RFM monetary total difference',
        (
            SELECT COALESCE(SUM(monetary), 0)
            FROM gold.vw_customer_rfm
        ) -
        (
            SELECT COALESCE(SUM(oi.price), 0)
            FROM gold.fact_order_items AS oi
            JOIN gold.fact_orders AS fo
                ON oi.order_id = fo.order_id
            WHERE fo.order_status = 'delivered'
        ),
        0::NUMERIC,
        'zero',
        'Total RFM monetary value should equal delivered item revenue.'

    UNION ALL

    -- CHECK 28: REPURCHASE VIEW SHOULD HAVE DATA
    SELECT
        28,
        'Customer satisfaction and repurchase rows',
        (
            SELECT COUNT(*)
            FROM gold.vw_customer_satisfaction_repurchase
        )::NUMERIC,
        1::NUMERIC,
        'at_least',
        'At least one reviewed customer-product pair is expected.'

    UNION ALL

    -- CHECK 29: PRODUCTS WITHOUT ENGLISH TRANSLATIONS
    -- Informational check: some missing translations are known.
    SELECT
        29,
        'Products without English category translation',
        (
            SELECT COUNT(*)
            FROM gold.dim_products
            WHERE product_category_name IS NOT NULL
              AND product_category_name_english IS NULL
        )::NUMERIC,
        NULL::NUMERIC,
        'info',
        'Informational: missing source translations or category matches.'

    UNION ALL

    -- CHECK 30: ORDERS BY DELIVERY OUTCOME
    -- Informational: outcome distribution is useful for analysis.
    SELECT
        30,
        'Orders with unknown delivery outcome',
        (
            SELECT COUNT(*)
            FROM gold.fact_orders
            WHERE delivery_outcome = 'unknown'
        )::NUMERIC,
        NULL::NUMERIC,
        'info',
        'Informational: outcome is unknown when required dates are missing.'

    UNION ALL

    -- CHECK 31: REVIEW SCORE DISTRIBUTION COVERAGE
    SELECT
        31,
        'Reviews with missing review score',
        (
            SELECT COUNT(*)
            FROM gold.fact_reviews
            WHERE review_score IS NULL
        )::NUMERIC,
        NULL::NUMERIC,
        'info',
        'Informational: inspect missing scores before interpreting satisfaction.'

    UNION ALL

    -- CHECK 32: SELLERS WITH NO DELIVERED SALES
    SELECT
        32,
        'Sellers with no delivered sales',
        (
            SELECT COUNT(*)
            FROM gold.vw_seller_performance
            WHERE COALESCE(delivered_order_count, 0) = 0
        )::NUMERIC,
        NULL::NUMERIC,
        'info',
        'Informational: sellers can exist without delivered sales in the data.'

)

-- RETURN ALL CHECKS IN ONE RESULT GRID.
SELECT
    check_order,
    check_name,
    actual_value,
    expected_value,
    CASE
        WHEN rule = 'info' THEN 'INFO'
        WHEN rule = 'zero'
            AND ABS(actual_value) < 0.01 THEN 'PASS'
        WHEN rule = 'zero' THEN 'FAIL'
        WHEN rule = 'at_least'
            AND actual_value >= expected_value THEN 'PASS'
        WHEN rule = 'at_least' THEN 'FAIL'
        WHEN rule = 'equal'
            AND actual_value = expected_value THEN 'PASS'
        WHEN rule = 'equal' THEN 'FAIL'
        ELSE 'REVIEW'
    END AS status,
    explanation
FROM checks
ORDER BY check_order;