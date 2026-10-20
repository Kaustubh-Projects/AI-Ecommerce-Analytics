-- Day 11: Review data checks for sentiment analysis

-- 1. Review dataset size and available scores
SELECT
    COUNT(*) AS total_reviews,
    COUNT(review_comment_message) AS reviews_with_comments,
    COUNT(*) - COUNT(review_comment_message) AS reviews_without_comments,
    COUNT(review_score) AS reviews_with_scores,
    MIN(review_score) AS minimum_score,
    MAX(review_score) AS maximum_score
FROM silver.order_reviews;

-- 2. Review-score distribution
SELECT
    review_score,
    COUNT(*) AS review_count
FROM silver.order_reviews
GROUP BY review_score
ORDER BY review_score;

-- 3. Check available review text
SELECT
    review_id,
    review_score,
    review_comment_message
FROM silver.order_reviews
WHERE review_comment_message IS NOT NULL
  AND TRIM(review_comment_message) <> ''
LIMIT 10;

-- 4. Review text availability by score
SELECT
    review_score,
    COUNT(*) AS total_reviews,
    COUNT(*) FILTER (
        WHERE review_comment_message IS NOT NULL
          AND TRIM(review_comment_message) <> ''
    ) AS reviews_with_text
FROM silver.order_reviews
GROUP BY review_score
ORDER BY review_score;