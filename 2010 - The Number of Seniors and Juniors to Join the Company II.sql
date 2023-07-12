# Write your MySQL query statement below

SELECT employee_id
FROM (
  SELECT employee_id, experience, salary, SUM(salary) OVER(ORDER BY experience DESC, salary) cum_salary
  FROM (
    SELECT employee_id, experience, salary
    FROM (
      SELECT employee_id, experience, salary, SUM(salary) OVER(PARTITION BY experience ORDER BY salary) cum_salary, 70000 target
      FROM candidates
    ) _
    WHERE cum_salary <= target
      AND experience = "Senior"
    UNION ALL
    SELECT employee_id, experience, salary
    FROM candidates
    WHERE experience = "Junior"
  ) _
) __
WHERE cum_salary < 70000