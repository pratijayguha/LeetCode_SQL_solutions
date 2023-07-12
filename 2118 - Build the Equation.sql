# Write your MySQL query statement below
WITH formula_terms AS (
  SELECT power, factor
    , CASE 
        WHEN factor = 0 THEN ""
        WHEN power = 0 AND factor < 0 THEN CAST(factor AS CHAR)
        WHEN power = 0 AND factor > 0 THEN CONCAT("+", CAST(factor AS CHAR))
        WHEN power = 1 AND factor < 0 THEN CONCAT(CAST(factor AS CHAR), "X")
        WHEN power = 1 AND factor > 0 THEN CONCAT("+", CAST(factor AS CHAR), "X")
        WHEN factor > 0 THEN CONCAT("+", CAST(factor AS CHAR), "X^", CAST(power AS CHAR)) 
        ELSE CONCAT(CAST(factor AS CHAR), "X^", CAST(power AS CHAR)) 
      END AS formula_term
  FROM terms
) 

SELECT CONCAT(REPLACE(GROUP_CONCAT(formula_term ORDER BY power DESC), ",", ""),"=0") equation FROM formula_terms
