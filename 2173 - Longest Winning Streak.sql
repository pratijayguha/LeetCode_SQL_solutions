# Write your MySQL query statement below
WITH longest_streaks AS (
  SELECT player_id, MAX(len_streak) longest_streak 
  FROM (
    SELECT *
      , COUNT(match_day) OVER(PARTITION BY player_id, streak_num ORDER BY match_day) len_streak 
    FROM (
      SELECT *, SUM(cond) OVER(PARTITION BY player_id ORDER BY match_day) streak_num
      FROM (
        SELECT *
          , CASE WHEN result <> "Win" THEN 1
            WHEN (p_result <> "Win") OR(p_result IS NULL) THEN 1
            ELSE 0 END AS cond
        FROM (
          SELECT *
            , LAG(result) OVER(PARTITION BY player_id ORDER BY match_day) p_result 
          FROM matches
        ) ___
      ) __
      WHERE result = "Win"
    ) _
  ) x
  GROUP BY 1
  ORDER BY 1
)

SELECT p.player_id, IFNULL(ls.longest_streak, 0) longest_streak
FROM (
  SELECT DISTINCT player_id
  FROM matches
) p
LEFT JOIN longest_streaks ls
ON ls.player_id = p.player_id