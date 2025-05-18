/*
DORMANT ACCOUNT IDENTIFICATION
 
 * This query identifies accounts with funds that haven't had 
 * transaction activity in 365+ days (dormant accounts).
 
 * These represent opportunities for re-engagement or recovery.
 */
 
WITH 
-- Find the most recent transaction date for each plan
last_tx AS (
    SELECT 
        plan_id, 
        MAX(date_format(transaction_date, '%Y-%m-%d')) AS last_transaction_date
    FROM 
        savings_savingsaccount
    GROUP BY 
        plan_id
)
-- Select accounts that are dormant but have positive balances
SELECT
    pp.id AS plan_id,
    pp.owner_id,
    -- Determine account type
    CASE
        WHEN pp.is_regular_savings = 1 THEN 'Savings'
        WHEN pp.is_a_fund = 1 THEN 'Investment'
        ELSE 'Other'
    END AS account_type,
    lt.last_transaction_date,
    -- Calculate days since last activity
    DATEDIFF(CURDATE(), lt.last_transaction_date) AS inactivity_days
FROM
    plans_plan AS pp
    LEFT JOIN last_tx AS lt ON pp.id = lt.plan_id
WHERE
    -- Only include accounts with positive balance
    pp.id IN (
        SELECT DISTINCT plan_id 
        FROM savings_savingsaccount 
        WHERE confirmed_amount > deduction_amount
    )
    AND (
        -- Include accounts with no transactions or inactive for 1+ year
        lt.last_transaction_date IS NULL 
        OR DATEDIFF(CURDATE(), lt.last_transaction_date) >= 365
    )
-- Sort by most inactive first
ORDER BY 
    inactivity_days DESC;
