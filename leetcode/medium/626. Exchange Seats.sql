/*
Question 626. Exchange Seats
Link: https://leetcode.com/problems/exchange-seats/description/?envType=study-plan-v2&envId=top-sql-50

Table: Seat

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| student     | varchar |
+-------------+---------+
id is the primary key (unique value) column for this table.
Each row of this table indicates the name and the ID of a student.
The ID sequence always starts from 1 and increments continuously.
 

Write a solution to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.

Return the result table ordered by id in ascending order.
*/

SELECT 
    s.id,
    (CASE
        WHEN s.id % 2 = 0 THEN s1.student
        WHEN s3.student IS NULL THEN s.student
        WHEN s.id % 2 = 1 THEN s3.student
    END) AS student
FROM Seat AS s
LEFT JOIN 
    Seat AS s1
    ON s.id = (
        SELECT MIN(s2.id) FROM Seat AS s2
        WHERE s1.id < s2.id
    )
LEFT JOIN 
    Seat AS s3
    ON s.id = (
        SELECT MAX(s4.id) FROM Seat AS s4
        WHERE s3.id > s4.id
    )
    