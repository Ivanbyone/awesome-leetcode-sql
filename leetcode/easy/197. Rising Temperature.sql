/*
Question 197. Rising Temperature
Link: https://leetcode.com/problems/rising-temperature/description/?source=submission-noac

Table: Weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the column with unique values for this table.
There are no different rows with the same recordDate.
This table contains information about the temperature on a certain day.
 

Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).

Return the result table in any order.
*/

SELECT w1.id
FROM Weather AS w1
LEFT JOIN
    Weather AS w2
    ON w1.recordDate = w2.recordDate + INTERVAL '1 day'
WHERE w1.temperature > w2.temperature
