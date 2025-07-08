/*
Question 550. Game Play Analysis IV
Link: https://leetcode.com/problems/game-play-analysis-iv/description/?envType=study-plan-v2&envId=top-sql-50

Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.

Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. In other words, you need to determine the number of players who logged in on the day immediately following their initial login, and divide it by the number of total players.
*/

WITH logged_again AS (
    SELECT 
        player_id,
        MIN(event_date) + INTERVAL '1 day' AS next_event_date
    FROM Activity
    GROUP BY player_id
)

SELECT
    ROUND(COUNT(CASE
        WHEN la.next_event_date IS NOT NULL
            THEN 1
    END) / COUNT(DISTINCT a.player_id)::NUMERIC, 2) AS fraction
FROM Activity AS a
LEFT JOIN
    logged_again AS la
    ON
        a.event_date = la.next_event_date
        AND a.player_id = la.player_id
    