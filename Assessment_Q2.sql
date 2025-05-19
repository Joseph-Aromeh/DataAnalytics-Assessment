/* 
CUSTOMER TRANSACTION FREQUENCY SEGMENTATION
 
 * This query segments customers by their transaction frequency:
 * - High Frequency: 10+ transactions per month
 * - Medium Frequency: 3-9 transactions per month
 * - Low Frequency: <3 transactions per month
 * This helps identify engagement levels and target interventions.
*/
 
WITH 
-- Calculate transactions per user per month
monthly_transactions AS (
    SELECT 
        uc.id AS user_id,
        DATE_FORMAT(ss.transaction_date, '%Y-%m') AS month,
        COUNT(ss.transaction_reference) AS transaction_count
    FROM 
        savings_savingsaccount AS ss
        JOIN users_customuser AS uc ON ss.owner_id = uc.id
    GROUP BY 
        uc.id, DATE_FORMAT(ss.transaction_date, '%Y-%m')
),
-- Categorize users by average monthly transaction frequency
user_frequency AS (
    SELECT 
        user_id,
        AVG(transaction_count) AS avg_transactions_per_month,
        CASE 
            WHEN AVG(transaction_count) >= 10 THEN 'High Frequency'
            WHEN AVG(transaction_count) >= 3 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM 
        monthly_transactions
    GROUP BY 
        user_id
),
-- Calculate total users for percentage calculation
totals AS (
    SELECT 
        COUNT(user_id) AS total_users
    FROM 
        user_frequency
)
-- Generate summary statistics by frequency category
SELECT 
    frequency_category,
    COUNT(user_id) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month,
    CONCAT(ROUND(COUNT(user_id) * 100.0 / (SELECT total_users FROM totals), 1), '%') AS percentage
FROM 
    user_frequency
GROUP BY 
    frequency_category
-- Sort from highest to lowest frequency category
ORDER BY 
    CASE 
        WHEN frequency_category = 'High Frequency' THEN 1
        WHEN frequency_category = 'Medium Frequency' THEN 2
        WHEN frequency_category = 'Low Frequency' THEN 3
    END;
