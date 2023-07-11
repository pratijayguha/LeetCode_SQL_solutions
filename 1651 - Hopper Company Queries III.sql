# Write your MySQL query statement below

WITH RECURSIVE months AS
(SELECT 1 as month UNION ALL SELECT month+1 FROM months WHERE month<=11)

, monthly_totals AS (
    SELECT MONTH(requested_at) month, SUM(ar.ride_distance) total_ride_distance, SUM(ar.ride_duration) total_ride_duration
    FROM rides r
    INNER JOIN acceptedRides ar
    ON r.ride_id = ar.ride_id
    WHERE YEAR(r.requested_at) = 2020
    GROUP BY 1
)

SELECT month
    , ROUND(SUM(total_ride_distance) OVER(ORDER BY month ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) / 3, 2) average_ride_distance
    , ROUND(SUM(total_ride_duration) OVER(ORDER BY month ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) / 3, 2) average_ride_duration
FROM (
    SELECT m.month
        , IFNULL(total_ride_distance, 0)total_ride_distance
        , IFNULL(total_ride_duration, 0)total_ride_duration
        , SUM(IF(MOD(m.month, 3)=0, 1, 0)) OVER(ORDER BY month DESC) cond
    FROM months m
    LEFT JOIN monthly_totals mt
    ON m.month = mt.month
) _
ORDER BY 1
LIMIT 10