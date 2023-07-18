# Write your MySQL query statement below

WITH RECURSIVE subtasks AS (
    SELECT 1 id
    UNION 
    SELECT id + 1 FROM subtasks WHERE id <= 19 
)

, task_mapping AS (
    SELECT task_id, s.id subtask_id
    FROM tasks t
    INNER JOIN subtasks s
    ON t.subtasks_count >= s.id

)

SELECT tm.task_id, tm.subtask_id
FROM task_mapping tm
LEFT JOIN executed e
ON tm.task_id = e.task_id
    AND tm.subtask_id = e.subtask_id
WHERE e.task_id IS NULL