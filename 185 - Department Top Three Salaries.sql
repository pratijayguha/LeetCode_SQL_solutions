-- Link to problem: https://leetcode.com/problems/department-top-three-salaries/
-- Write your MySQL query statement below
SELECT deptName Department, empName Employee, salary Salary
FROM (
    SELECT emp.id empId, emp.name empName ,emp.departmentId deptId, emp.salary salary, dept.name deptName,
        DENSE_RANK() OVER(PARTITION BY emp.departmentId ORDER BY emp.salary DESC) rankSalary
    FROM (
        SELECT id, name, departmentId, salary FROM Employee
    ) emp
    LEFT JOIN (
        SELECT * FROM Department
    ) dept
    ON emp.departmentId = dept.id
    ORDER BY deptName, salary DESC
) main
WHERE rankSalary <= 3
ORDER BY  deptName, rankSalary