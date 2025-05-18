/* 
HIGH-VALUE DIVERSIFIED CUSTOMER ANALYSIS
 
 * This query identifies customers who have both savings and investment accounts,
 * showing their account distribution and total deposit value.
 
 * These are strategically important customers with cross-product adoption.
*/
 
SELECT 
    uc.id AS owner_id,
    CONCAT(uc.first_name, ' ', uc.last_name) AS customer_name,
    -- Count savings accounts
    COUNT(DISTINCT CASE
        WHEN p.is_regular_savings = 1 THEN p.id
    END) AS savings_count,
    -- Count investment accounts
    COUNT(DISTINCT CASE
        WHEN p.is_a_fund = 1 THEN p.id
    END) AS investment_count,
    -- Calculate total deposits across all accounts
    SUM(s.confirmed_amount) AS total_deposits
FROM
    users_customuser uc
    JOIN plans_plan p ON uc.id = p.owner_id
    JOIN savings_savingsaccount s ON p.id = s.plan_id
WHERE
    -- Only include accounts with positive balance
    s.confirmed_amount > 0
GROUP BY 
    uc.id, uc.first_name, uc.last_name
-- Filter for customers with at least one savings AND one investment account
HAVING 
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN p.id END) > 0
    AND COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) > 0
ORDER BY 
    total_deposits DESC;
