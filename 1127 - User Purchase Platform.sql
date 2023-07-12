# Write your MySQL query statement below

WITH RECURSIVE platform_units AS (
    SELECT 1 AS t UNION ALL SELECT t+1 FROM platform_units WHERE t<3
)

, platforms AS (
    SELECT 
        CASE WHEN t=1 THEN 'mobile'
            WHEN t=2 THEN 'desktop'
            ELSE 'both'
        END AS platform
    FROM platform_units
)

, platform_days AS (
    SELECT spend_date, platform
    FROM (SELECT DISTINCT spend_date FROM spending) _
    join platforms
)

, spend_days_platforms AS (
    SELECT spend_date, IF(concat_platform = "desktop,mobile", "both", concat_platform) platform, SUM(amount) total_amount, COUNT(DISTINCT user_id) total_users
    FROM (
        SELECT spend_date, user_id, GROUP_CONCAT(platform ORDER BY platform) concat_platform, SUM(amount) amount
        FROM spending
        GROUP BY 1,2
    ) _
    GROUP BY 1,2
    ORDER BY 1,2
)

SELECT pd.*, IFNULL(sdp.total_amount, 0) total_amount, IFNULL(sdp.total_users, 0) total_users
FROM platform_days pd
LEFT JOIN spend_days_platforms sdp
ON pd.spend_date = sdp.spend_date
    AND pd.platform = sdp.platform