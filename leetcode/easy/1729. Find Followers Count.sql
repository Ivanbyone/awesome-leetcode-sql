/*
Question 1729. Find Followers Count
Link: https://leetcode.com/problems/find-followers-count/description/

Table: Followers

+-------------+------+
| Column Name | Type |
+-------------+------+
| user_id     | int  |
| follower_id | int  |
+-------------+------+
(user_id, follower_id) is the primary key (combination of columns with unique values) for this table.
This table contains the IDs of a user and a follower in a social media app where the follower follows the user.
 

Write a solution that will, for each user, return the number of followers.

Return the result table ordered by user_id in ascending order.
*/

SELECT 
    user_id, 
    COUNT(user_id) AS followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id
