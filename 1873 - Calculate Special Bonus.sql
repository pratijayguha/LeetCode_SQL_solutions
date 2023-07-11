# Write your MySQL query statement below

SELECT name Customers
FROM Customers c
LEFT JOIN (
    SELECT DISTINCT customerId
    FROM Orders
) o
ON c.id = o.customerId
WHERE o.customerId IS NULL