# Write your MySQL query statement below
SELECT
  post_id,
  COALESCE(group_concat(DISTINCT topic_id
    ORDER BY
      CAST(topic_id AS FLOAT)), 'Ambiguous!') AS topic
FROM
  posts a
LEFT JOIN
  keywords b
ON
  CONCAT(' ', LOWER(a.content), ' ') LIKE CONCAT('% ', LOWER(b.word), ' %')
GROUP BY
  post_id;