-- Link to problem: https://leetcode.com/problems/department-top-three-salaries/
-- Write your MySQL query statement below

WITH valid_ids AS (
    SELECT s1.id, s2.id id2, s3.id id3
    FROM stadium s1
    INNER JOIN stadium s2
    ON s1.id = s2.id + 1
    INNER JOIN stadium s3
    ON s1.id = s3.id + 2
    WHERE s1.people >= 100
        AND s2.people >= 100
        AND s3.people >= 100
) 
, unique_ids AS (
    SELECT id
    FROM valid_ids
    UNION 
    SELECT id2
    FROM valid_ids
    UNION 
    SELECT id3
    FROM valid_ids
)

SELECT u.id, visit_date, people 
FROM unique_ids u
LEFT JOIN stadium s
ON u.id = s.id
ORDER BY 1