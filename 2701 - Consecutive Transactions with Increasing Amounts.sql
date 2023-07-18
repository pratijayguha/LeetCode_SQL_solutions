# Write your MySQL query statement below
WITH lagged_transactions AS (
    SELECT t1.*, t2.amount lag_amount, t2.transaction_date lag_transaction_date
    FROM transactions t1
    INNER JOIN transactions t2
    ON t1.customer_id = t2.customer_id
        AND DATEDIFF(t1.transaction_date, t2.transaction_date) = 1 
) 


SELECT customer_id, MIN(lag_transaction_date) consecutive_start, MAX(transaction_date) consecutive_end
FROM (
    SELECT *, SUM(part1 + part2) OVER(PARTITION BY customer_id ORDER BY transaction_date) part
    FROM (
        SELECT *, IF(amount > lag_amount, 0, 1) part1
            , CASE WHEN lag(transaction_date, 1) OVER(PARTITION BY customer_id ORDER BY transaction_date) IS NULL THEN 0
                WHEN DATEDIFF(transaction_date, lag(transaction_date, 1) OVER(PARTITION BY customer_id ORDER BY transaction_date)) = 1 THEN 0
                ELSE 1 END AS part2
        FROM lagged_transactions
    ) _
) __
WHERE part1 = 0
GROUP BY customer_id, part
HAVING COUNT(transaction_id) >= 2
ORDER BY 1, 2