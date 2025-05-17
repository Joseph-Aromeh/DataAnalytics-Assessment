SELECT 
    uc.id AS customer_id,
    CONCAT(uc.first_name, ' ', uc.last_name) AS name,
    TIMESTAMPDIFF(MONTH, uc.date_joined, CURDATE()) AS tenure_months,
    COUNT(ss.id) AS total_transactions,
    (COUNT(ss.id) / NULLIF(TIMESTAMPDIFF(MONTH, uc.date_joined, CURDATE()), 0)) * 12 * 
    (SUM(ss.confirmed_amount) * 0.001 / COUNT(ss.id)) AS estimated_clv
FROM
    users_customuser uc
JOIN
    savings_savingsaccount ss ON uc.id = ss.owner_id
GROUP BY 
    uc.id, uc.first_name, uc.last_name, uc.date_joined
HAVING 
    tenure_months > 0
ORDER BY 
    estimated_clv DESC;