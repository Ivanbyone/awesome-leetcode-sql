/*
Question 1517. Find Users With Valid E-Mails
Link: https://leetcode.com/problems/find-users-with-valid-e-mails/description/?envType=study-plan-v2&envId=top-sql-50

Table: Users

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| name          | varchar |
| mail          | varchar |
+---------------+---------+
user_id is the primary key (column with unique values) for this table.
This table contains information of the users signed up in a website. Some e-mails are invalid.
 

Write a solution to find the users who have valid emails.

A valid e-mail has a prefix name and a domain where:

The prefix name is a string that may contain letters (upper or lower case), digits, underscore '_', period '.', and/or dash '-'. The prefix name must start with a letter.
The domain is '@leetcode.com'.
Return the result table in any order.
*/

SELECT 
    user_id,
    name, --noqa: RF04
    mail
FROM Users
WHERE mail ~ '^[a-zA-Z]+([a-zA-Z0-9]?[._-]?[a-zA-Z0-9]?)*@leetcode\.com$'
