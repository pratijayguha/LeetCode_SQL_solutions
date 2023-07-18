# Write your MySQL query statement below

WITH all_friends AS (
    SELECT user1, user2 FROM friends
    UNION ALL 
    SELECT user2, user1 FROM friends
)

, distinct_users AS (
    SELECT COUNT(DISTINCT user1) total_users FROM all_friends
)

SELECT user1, ROUND(COUNT(DISTINCT user2) / MIN(du.total_users) * 100, 2) percentage_popularity
FROM all_friends
JOIN distinct_users du
GROUP BY 1
ORDER BY 1