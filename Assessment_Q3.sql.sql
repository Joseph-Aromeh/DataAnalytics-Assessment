WITH last_tx AS (
    SELECT 
        plan_id, 
        MAX(date_format(transaction_date, "%Y-%m-%d")) AS last_transaction_date
    FROM savings_savingsaccount
    GROUP BY plan_id
)
SELECT
    pp.id AS plan_id,
    pp.owner_id,
    CASE
        WHEN pp.is_regular_savings = 1 THEN 'Savings'
        WHEN pp.is_a_fund = 1 THEN 'Investment'
        ELSE 'Other'
    END AS type,
    lt.last_transaction_date,
    DATEDIFF(CURDATE(), lt.last_transaction_date) AS inactivity_days
FROM
    plans_plan AS pp
LEFT JOIN
    last_tx AS lt ON pp.id = lt.plan_id
WHERE
    -- We can infer an account is "active" if it has funds in it
    pp.id IN (SELECT DISTINCT plan_id FROM savings_savingsaccount 
              WHERE confirmed_amount > deduction_amount)
    AND (
        lt.last_transaction_date IS NULL 
        OR DATEDIFF(CURDATE(), lt.last_transaction_date) >= 365
    )
ORDER BY inactivity_days DESC;