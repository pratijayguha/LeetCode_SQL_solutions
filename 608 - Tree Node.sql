# Write your MySQL query statement below
SELECT DISTINCT id,
  CASE WHEN p_id IS NULL THEN "Root"
  WHEN c_id_flag IS TRUE THEN "Inner"
  ELSE "Leaf" END AS type
FROM (
  SELECT DISTINCT t1.id, t1.p_id, IF(t2.id IS NULL, FALSE, TRUE) c_id_flag
  FROM tree t1
  LEFT JOIN tree t2
  ON t1.id = t2.p_id
) a