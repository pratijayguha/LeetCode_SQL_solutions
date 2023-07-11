# Write your MySQL query statement below
SELECT *
FROM (
  SELECT p1.id p1, p2.id p2, ABS((p1.x_value - p2.x_value)*(p1.y_value - p2.y_value)) area 
  FROM points p1
  LEFT JOIN points p2
  ON p1.id <> p2.id AND p1.id < p2.id
) a
WHERE area <> 0
ORDER BY 3 DESC, 1, 2