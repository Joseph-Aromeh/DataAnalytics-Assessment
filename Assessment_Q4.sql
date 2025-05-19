/*
CUSTOMER LIFETIME VALUE (CLV) ANALYSIS
 
 * This query calculates estimated customer lifetime value based on:
 *  - Transaction frequency (annualized)
 *  - Average transaction value (with 0.1% revenue assumption)
 *  - Customer tenure
 * Higher CLV indicates more valuable long-term customers.
*/
 
SELECT 
    uc.id AS customer_id,
    CONCAT(uc.first_name, ' ', uc.last_name) AS customer_name,
    -- Calculate customer tenure in months
    TIMESTAMPDIFF(MONTH, uc.date_joined, CURDATE()) AS tenure_months,
    -- Count total transactions
    COUNT(ss.id) AS total_transactions,
    -- CLV Formula: (Annual Transaction Rate) * (Avg Revenue per Transaction)
    -- Assuming 0.1% revenue on transaction amounts
    (COUNT(ss.id) / NULLIF(TIMESTAMPDIFF(MONTH, uc.date_joined, CURDATE()), 0)) * 12 * 
    (SUM(ss.confirmed_amount) * 0.001 / COUNT(ss.id)) AS estimated_clv
FROM
    users_customuser AS uc
    JOIN savings_savingsaccount ss ON uc.id = ss.owner_id
GROUP BY 
    uc.id, uc.first_name, uc.last_name, uc.date_joined
-- Exclude customers with zero tenure
HAVING 
    tenure_months > 0
ORDER BY 
    estimated_clv DESC;
