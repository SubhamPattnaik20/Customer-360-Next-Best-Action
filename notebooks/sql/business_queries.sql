-- ============================================
-- Customer 360 & Next-Best-Action Analytics
-- Business SQL Queries
-- Database: customer360
-- ============================================

-- 1. Total customer count check
SELECT COUNT(*) AS total_orders
FROM customers360;

-- 2. Customers by state (top 10)
SELECT customer_state, COUNT(DISTINCT customer_unique_id) AS num_customers
FROM customers360
GROUP BY customer_state
ORDER BY num_customers DESC
LIMIT 10;

-- 3. Customer count by RFM segment
SELECT customer_segment, COUNT(*) AS num_customers
FROM customer_rfm
GROUP BY customer_segment
ORDER BY num_customers DESC;

-- 4. Average predicted CLV by segment
SELECT r.customer_segment,
       ROUND(AVG(c.predicted_clv), 2) AS avg_predicted_clv,
       COUNT(*) AS num_customers
FROM customer_rfm r
JOIN customer_clv c ON r.customer_unique_id = c.customer_unique_id
GROUP BY r.customer_segment
ORDER BY avg_predicted_clv DESC;

-- 5. Recommended action distribution
SELECT recommended_action, COUNT(*) AS num_customers
FROM next_best_action
GROUP BY recommended_action
ORDER BY num_customers DESC;

-- 6. Churn rate by segment
SELECT r.customer_segment,
       ROUND(AVG(c.churned) * 100, 2) AS churn_rate_pct,
       COUNT(*) AS num_customers
FROM customer_rfm r
JOIN customer_churn c ON r.customer_unique_id = c.customer_unique_id
GROUP BY r.customer_segment
ORDER BY churn_rate_pct DESC;