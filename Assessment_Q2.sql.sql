WITH monthly_transactions AS (
    SELECT 
        uc.id AS user_id,
        DATE_FORMAT(ss.transaction_date, '%Y-%m') AS month,
        COUNT(ss.transaction_reference) AS transaction_count
    FROM savings_savingsaccount AS ss
    JOIN users_customuser AS uc ON ss.owner_id = uc.id
    GROUP BY uc.id, DATE_FORMAT(ss.transaction_date, '%Y-%m')
),
user_frequency AS (
    SELECT 
        user_id,
        AVG(transaction_count) AS avg_transactions_per_month,
        CASE 
            WHEN AVG(transaction_count) >= 10 THEN 'High Frequency'
            WHEN AVG(transaction_count) >= 3 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM monthly_transactions
    GROUP BY user_id
)
SELECT 
    frequency_category,
    COUNT(user_id) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM user_frequency
GROUP BY frequency_category
ORDER BY 
    CASE 
        WHEN frequency_category = 'High Frequency' THEN 1
        WHEN frequency_category = 'Medium Frequency' THEN 2
        WHEN frequency_category = 'Low Frequency' THEN 3
    END;