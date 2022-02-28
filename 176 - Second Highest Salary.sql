-- Link to problem: https://leetcode.com/problems/second-highest-salary/
-- Write your MySQL query statement below

SELECT salary AS SecondHighestSalary
FROM (
    SELECT Employee.*, RANK() OVER(ORDER BY salary DESC) AS rank_1
    FROM Employee
) as A
WHERE A.rank_1 = 2