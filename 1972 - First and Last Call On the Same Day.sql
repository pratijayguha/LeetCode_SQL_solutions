# Write your MySQL query statement below

WITH all_calls AS (
  SELECT caller_id, recipient_id, call_time
  FROM calls
  UNION
  SELECT recipient_id, caller_id, call_time
  FROM calls
)
, ranked_calls AS (
  SELECT *
  FROM (
  SELECT *, ROW_NUMBER() OVER(PARTITION BY caller_id, DATE(call_time) ORDER BY call_time) rn_asc
    , ROW_NUMBER() OVER(PARTITION BY caller_id, DATE(call_time) ORDER BY call_time DESC) rn_desc 
  FROM all_calls a
  ) _
  WHERE rn_asc = 1 OR rn_desc = 1
)
, valid_calls AS (
  SELECT r1.*
  FROM ranked_calls r1
  INNER JOIN ranked_calls r2
  WHERE r1.caller_id = r2.caller_id
    AND r1.recipient_id = r2.recipient_id
    AND r1.rn_asc = r2.rn_desc
    AND r2.rn_desc = r1.rn_asc
    
)

SELECT DISTINCT caller_id user_id FROM valid_calls