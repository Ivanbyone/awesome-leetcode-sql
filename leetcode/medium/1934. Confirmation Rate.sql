/*
Question 1934. Confirmation Rate
Link: https://leetcode.com/problems/confirmation-rate/description/?envType=study-plan-v2&envId=top-sql-50

Table: Signups

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
+----------------+----------+
user_id is the column of unique values for this table.
Each row contains information about the signup time for the user with ID user_id.
 

Table: Confirmations

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
| action         | ENUM     |
+----------------+----------+
(user_id, time_stamp) is the primary key (combination of columns with unique values) for this table.
user_id is a foreign key (reference column) to the Signups table.
action is an ENUM (category) of the type ('confirmed', 'timeout')
Each row of this table indicates that the user with ID user_id requested a confirmation message at time_stamp and that confirmation message was either confirmed ('confirmed') or expired without confirming ('timeout').
 

The confirmation rate of a user is the number of 'confirmed' messages divided by the total number of requested confirmation messages. The confirmation rate of a user that did not request any confirmation messages is 0. Round the confirmation rate to two decimal places.

Write a solution to find the confirmation rate of each user.

Return the result table in any order.
*/

SELECT
    s.user_id,
    COALESCE(CASE
        WHEN c.user_id IS NULL THEN 0.00
        ELSE ROUND((
            SELECT COUNT(c2.user_id)
            FROM Confirmations AS c2
            WHERE c2.action = 'confirmed' AND c2.user_id = s.user_id
            GROUP BY c2.user_id
        ) / COUNT(c.user_id)::numeric, 2)
    END, 0.00) AS confirmation_rate
FROM Signups AS s
LEFT JOIN 
    Confirmations AS c
    ON s.user_id = c.user_id
GROUP BY s.user_id, c.user_id
