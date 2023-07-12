# Write your MySQL query statement below

WITH friends AS (
    SELECT user1_id, user2_id FROM friendship
    UNION ALL
    SELECT user2_id, user1_id FROM friendship
    
)

SELECT user1_id user_id, rec page_id, COUNT(user2_id) friends_likes
FROM (
    SELECT user1_id, user2_id, l.page_id rec, l1.page_id 
    FROM friends f
    LEFT JOIN likes l
    ON f.user2_id = l.user_id
    LEFT JOIN likes l1
    ON f.user1_id = l1.user_id
        AND l.page_id = l1.page_id
    WHERE l1.page_id IS NULL
) _
GROUP BY 1, 2
ORDER BY 1, 3 DESC