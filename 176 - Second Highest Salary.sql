-- Link to problem: https://leetcode.com/problems/second-highest-salary/
-- Write your MySQL query statement below

SELECT if(count(salary)>0,salary,Null) AS SecondHighestSalary
FROM (
    SELECT Employee.*, DENSE_RANK() OVER(ORDER BY salary DESC) AS rank_1
    FROM Employee
) as A
WHERE A.rank_1 = 2