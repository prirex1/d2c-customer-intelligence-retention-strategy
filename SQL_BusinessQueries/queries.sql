-- Q1: What separates loyal customers from discount-driven ones?
SELECT 
    customer_segment,
    COUNT(*) as total_customers,
    ROUND(AVG(purchase_amount), 2) as avg_spend,
    ROUND(AVG(previous_purchas), 2) as avg_history,
    ROUND(AVG(loyalty_score), 3) as avg_loyalty,
    ROUND(AVG(discount_applied), 2) as discount_rate
FROM customers_enriched
GROUP BY customer_segment
ORDER BY avg_loyalty DESC;
-- Q2: Which categories attract sticky vs one-time buyers?
SELECT 
    category,
    COUNT(*) as total_customers,
    ROUND(AVG(previous_purchas), 2) as avg_history,
    ROUND(AVG(loyalty_score), 3) as avg_loyalty,
    ROUND(AVG(discount_applied), 2) as discount_rate,
    ROUND(AVG(purchase_amount), 2) as avg_spend
FROM customers_enriched
GROUP BY category
ORDER BY avg_loyalty DESC;
-- Q3: Which states show organic demand vs discount-driven volume?
SELECT 
    location,
    COUNT(*) as total_customers,
    ROUND(AVG(purchase_amount), 2) as avg_spend,
    ROUND(AVG(discount_applied), 2) as discount_rate,
    ROUND(AVG(previous_purchas), 2) as avg_history,
    ROUND(
        AVG(purchase_amount) / (AVG(discount_applied) + 0.01)
    , 2) as organic_index
FROM customers_enriched
GROUP BY location
ORDER BY organic_index DESC
LIMIT 10;
SELECT 
    location,
    COUNT(*) as total_customers,
    ROUND(AVG(purchase_amount), 2) as avg_spend,
    ROUND(AVG(discount_applied), 2) as discount_rate,
    ROUND(
        AVG(purchase_amount) / (AVG(discount_applied) + 0.01)
    , 2) as organic_index
FROM customers_enriched
GROUP BY location
ORDER BY organic_index ASC
LIMIT 5;
-- Q4: Who are our highest churn risk customers and what do they look like?
SELECT 
    churn_risk,
    COUNT(*) as total_customers,
    ROUND(AVG(purchase_amount), 2) as avg_spend,
    ROUND(AVG(previous_purchas), 2) as avg_history,
    ROUND(AVG(loyalty_score), 3) as avg_loyalty,
    ROUND(AVG(discount_applied), 2) as discount_rate
FROM customers_enriched
GROUP BY churn_risk
ORDER BY avg_loyalty ASC;
SELECT 
    customer_segment,
    churn_risk,
    COUNT(*) as total_customers
FROM customers_enriched
WHERE churn_risk = 'High'
GROUP BY customer_segment, churn_risk
ORDER BY total_customers DESC;
-- Q5: Complete Ideal Customer Profile

-- Part 1: Overall profile
SELECT 
    ROUND(AVG(age), 1) as avg_age,
    ROUND(AVG(purchase_amount), 2) as avg_spend,
    ROUND(AVG(previous_purchas), 2) as avg_history,
    ROUND(AVG(loyalty_score), 3) as avg_loyalty,
    COUNT(*) as total
FROM customers_enriched
WHERE customer_segment = 'Loyal'
  AND value_tier = 'Gold';

-- Part 2: Top locations
SELECT 
    location,
    COUNT(*) as count
FROM customers_enriched
WHERE customer_segment = 'Loyal'
  AND value_tier = 'Gold'
GROUP BY location
ORDER BY count DESC
LIMIT 5;

-- Part 3: Top categories
SELECT 
    category,
    COUNT(*) as count,
    ROUND(AVG(purchase_amount), 2) as avg_spend
FROM customers_enriched
WHERE customer_segment = 'Loyal'
  AND value_tier = 'Gold'
GROUP BY category
ORDER BY count DESC;

-- Part 4: Top payment methods
SELECT 
    payment_method,
    COUNT(*) as count
FROM customers_enriched
WHERE customer_segment = 'Loyal'
  AND value_tier = 'Gold'
GROUP BY payment_method
ORDER BY count DESC;

-- Part 5: Top seasons
SELECT 
    season,
    COUNT(*) as count
FROM customers_enriched
WHERE customer_segment = 'Loyal'
  AND value_tier = 'Gold'
GROUP BY season
ORDER BY count DESC;