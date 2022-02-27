-- Link to problem: https://leetcode.com/problems/trips-and-users/
-- Write your MySQL query statement below
WITH Active_Users AS (
SELECT *
FROM Users
WHERE Banned = 'No'
)

SELECT t.Request_at AS "Day",
ROUND(
COUNT(DISTINCT CASE WHEN t.Status LIKE 'cancelled%' THEN Id ELSE NULL END)
/ COUNT(DISTINCT Id)
,2) AS "Cancellation Rate"
FROM Trips t
INNER JOIN Active_Users auC ON t.Client_Id = auC.Users_id
INNER JOIN Active_Users auD ON t.Driver_Id = auD.Users_id
WHERE Request_at BETWEEN "2013-10-01" AND "2013-10-03"
GROUP BY t.Request_at
