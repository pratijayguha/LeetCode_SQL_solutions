-- Link to problem: https://leetcode.com/problems/department-top-three-salaries/
-- Write your MySQL query statement below

SELECT A.* FROM STADIUM AS A, STADIUM AS B, STADIUM AS C

WHERE ( (A.ID+1=B.ID AND A.ID+2=C.ID) OR (A.ID-1=B.ID AND A.ID+1=C.ID) OR (A.ID-2=C.ID AND A.ID-1=B.ID) )
      
      AND A.PEOPLE>=100 AND B.PEOPLE>=100 AND C.PEOPLE>=100 
      
      GROUP BY A.ID
      ORDER BY A.ID, A.visit_date;