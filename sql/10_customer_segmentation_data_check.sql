-- the available columns and example customer records

SELECT *
FROM gold.vw_customer_rfm
LIMIT 5;

--the number of customers and whether the three core RFM features contain missing values

SELECT
    COUNT(*) AS customer_count,
    COUNT(*) FILTER (WHERE recency_days IS NULL) AS missing_recency,
    COUNT(*) FILTER (WHERE frequency IS NULL) AS missing_frequency,
    COUNT(*) FILTER (WHERE monetary IS NULL) AS missing_monetary
FROM gold.vw_customer_rfm;