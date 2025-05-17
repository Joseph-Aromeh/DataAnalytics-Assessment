SELECT 
    uc.id AS owner_id,
    CONCAT(uc.first_name, ' ', uc.last_name) AS name,
    COUNT(DISTINCT CASE
            WHEN p.is_regular_savings = 1 THEN p.id
        END) AS savings_count,
    COUNT(DISTINCT CASE
            WHEN p.is_a_fund = 1 THEN p.id
        END) AS investment_count,
    SUM(s.confirmed_amount) AS total_deposits
FROM
    users_customuser uc
        JOIN
    plans_plan p ON uc.id = p.owner_id
        JOIN
    savings_savingsaccount s ON p.id = s.plan_id
WHERE
    s.confirmed_amount > 0
GROUP BY uc.id , uc.first_name , uc.last_name
HAVING COUNT(DISTINCT CASE
        WHEN p.is_regular_savings = 1 THEN p.id
    END) > 0
    AND COUNT(DISTINCT CASE
        WHEN p.is_a_fund = 1 THEN p.id
    END) > 0
ORDER BY total_deposits DESC;