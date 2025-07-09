/*
Question 180. Consecutive Numbers
Link: https://leetcode.com/problems/consecutive-numbers/description/?envType=study-plan-v2&envId=top-sql-50

Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column starting from 1.
 

Find all numbers that appear at least three times consecutively.

Return the result table in any order.
*/

WITH prev_next AS (
    SELECT 
        id,
        LAG(num) OVER(ORDER BY id) AS prev_num,
        LEAD(num) OVER(ORDER BY id) AS next_num
    FROM Logs
)

SELECT  DISTINCT l.num AS ConsecutiveNums
FROM Logs AS l
LEFT JOIN
    prev_next AS pn
    ON l.id = pn.id
WHERE l.num = pn.prev_num AND pn.prev_num = pn.next_num
