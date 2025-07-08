/*
Question 1667. Fix Names in a Table
Link: https://leetcode.com/problems/fix-names-in-a-table/description/?envType=study-plan-v2&envId=top-sql-50

Table: Users

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| user_id        | int     |
| name           | varchar |
+----------------+---------+
user_id is the primary key (column with unique values) for this table.
This table contains the ID and the name of the user. The name consists of only lowercase and uppercase characters.
 

Write a solution to fix the names so that only the first character is uppercase and the rest are lowercase.

Return the result table ordered by user_id.
*/

SELECT 
    user_id,
    UPPER(SUBSTRING(name FROM 1 FOR 1)) || '' || LOWER(SUBSTRING(name FROM 2 FOR LENGTH(name))) AS name --noqa: RF04
FROM Users
ORDER BY user_id
