/*
Question 1890. The Latest Login in 2020
Link: https://leetcode.com/problems/the-latest-login-in-2020/description/?envType=problem-list-v2&envId=database

Table: Logins

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
+----------------+----------+
(user_id, time_stamp) is the primary key (combination of columns with unique values) for this table.
Each row contains information about the login time for the user with ID user_id.
 

Write a solution to report the latest login for all users in the year 2020. Do not include the users who did not login in 2020.

Return the result table in any order.
*/

SELECT
    user_id,
    MAX(time_stamp) AS last_stamp
FROM Logins
WHERE time_stamp::varchar LIKE '2020%'
GROUP BY user_id
