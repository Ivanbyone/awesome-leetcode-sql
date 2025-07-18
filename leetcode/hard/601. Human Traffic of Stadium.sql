/*
Question 601. Human Traffic of Stadium
Link: 

Table: Stadium

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| visit_date    | date    |
| people        | int     |
+---------------+---------+
visit_date is the column with unique values for this table.
Each row of this table contains the visit date and visit id to the stadium with the number of people during the visit.
As the id increases, the date increases as well.
 

Write a solution to display the records with three or more rows with consecutive id's, and the number of people is greater than or equal to 100 for each.

Return the result table ordered by visit_date in ascending order.
*/

WITH more_than_100 AS (
    SELECT 
        s1.id,
        s1.id - ROW_NUMBER() OVER (ORDER BY s1.id) AS c_id
    FROM Stadium AS s1
    WHERE s1.people >= 100
),

three_consecutive AS (
    SELECT s2.c_id
    FROM more_than_100 AS s2
    GROUP BY s2.c_id
    HAVING COUNT(s2.c_id) >= 3
)

SELECT 
    s.id,
    s.visit_date,
    s.people
FROM Stadium AS s
INNER JOIN 
    more_than_100 AS mt
    ON s.id = mt.id
WHERE mt.c_id IN (
    SELECT tc.c_id
    FROM three_consecutive AS tc
)
