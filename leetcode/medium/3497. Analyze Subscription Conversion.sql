/*
Question 3497. Analyze Subscription Conversion 
Link: https://leetcode.com/problems/analyze-subscription-conversion/description/?envType=problem-list-v2&envId=database

Table: UserActivity

+------------------+---------+
| Column Name      | Type    | 
+------------------+---------+
| user_id          | int     |
| activity_date    | date    |
| activity_type    | varchar |
| activity_duration| int     |
+------------------+---------+
(user_id, activity_date, activity_type) is the unique key for this table.
activity_type is one of ('free_trial', 'paid', 'cancelled').
activity_duration is the number of minutes the user spent on the platform that day.
Each row represents a user's activity on a specific date.
A subscription service wants to analyze user behavior patterns. The company offers a 7-day free trial, after which users can subscribe to a paid plan or cancel. Write a solution to:

Find users who converted from free trial to paid subscription
Calculate each user's average daily activity duration during their free trial period (rounded to 2 decimal places)
Calculate each user's average daily activity duration during their paid subscription period (rounded to 2 decimal places)
Return the result table ordered by user_id in ascending order.
*/

WITH trial_durations AS (
    SELECT
        user_id,
        AVG(activity_duration) AS trial_avg_duration
    FROM UserActivity
    WHERE activity_type = 'free_trial'
    GROUP BY user_id
),

paid_duration AS (
    SELECT
        user_id,
        AVG(activity_duration) AS paid_avg_duration
    FROM UserActivity
    WHERE activity_type = 'paid'
    GROUP BY user_id
)

SELECT DISTINCT
    u.user_id,
    ROUND(t.trial_avg_duration, 2) AS trial_avg_duration,
    ROUND(p.paid_avg_duration, 2) AS paid_avg_duration
FROM UserActivity AS u
INNER JOIN 
    trial_durations AS t
    ON u.user_id = t.user_id
INNER JOIN
    paid_duration AS p
    ON u.user_id = p.user_id
    