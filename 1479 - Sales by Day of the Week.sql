# Write your MySQL query statement below

SELECT item_category category
  , SUM(CASE WHEN order_day = 0 THEN quantity
    ELSE 0 END) AS MONDAY
  , SUM(CASE WHEN order_day = 1 THEN quantity
    ELSE 0 END) AS TUESDAY
  , SUM(CASE WHEN order_day = 2 THEN quantity
    ELSE 0 END) AS WEDNESDAY
  , SUM(CASE WHEN order_day = 3 THEN quantity
    ELSE 0 END) AS THURSDAY
  , SUM(CASE WHEN order_day = 4 THEN quantity
    ELSE 0 END) AS FRIDAY
  , SUM(CASE WHEN order_day = 5 THEN quantity
    ELSE 0 END) AS SATURDAY
  , SUM(CASE WHEN order_day = 6 THEN quantity
    ELSE 0 END) AS SUNDAY
FROM (
  SELECT i.item_category, WEEKDAY(order_date) order_day, SUM(IFNULL(quantity,0)) quantity
  FROM orders o
  RIGHT JOIN items i
  ON o.item_id = i.item_id
  GROUP BY 1,2
) _
GROUP BY 1
ORDER BY 1