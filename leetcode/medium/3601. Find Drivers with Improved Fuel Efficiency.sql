/*
Question 3601. Find Drivers with Improved Fuel Efficiency
Link: https://leetcode.com/problems/find-drivers-with-improved-fuel-efficiency/description/?envType=problem-list-v2&envId=database

Table: drivers

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| driver_id   | int     |
| driver_name | varchar |
+-------------+---------+
driver_id is the unique identifier for this table.
Each row contains information about a driver.
Table: trips

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| trip_id       | int     |
| driver_id     | int     |
| trip_date     | date    |
| distance_km   | decimal |
| fuel_consumed | decimal |
+---------------+---------+
trip_id is the unique identifier for this table.
Each row represents a trip made by a driver, including the distance traveled and fuel consumed for that trip.
Write a solution to find drivers whose fuel efficiency has improved by comparing their average fuel efficiency in the first half of the year with the second half of the year.

Calculate fuel efficiency as distance_km / fuel_consumed for each trip
First half: January to June, Second half: July to December
Only include drivers who have trips in both halves of the year
Calculate the efficiency improvement as (second_half_avg - first_half_avg)
Round all results to 2 decimal places
Return the result table ordered by efficiency improvement in descending order, then by driver name in ascending order.
*/

WITH first_avg AS (
    SELECT 
        driver_id,
        AVG(distance_km::numeric / fuel_consumed) AS first_half_avg
    FROM trips
    WHERE trip_date < '2023-07-01'
    GROUP BY driver_id
),

second_avg AS (
    SELECT 
        driver_id,
        AVG(distance_km::numeric / fuel_consumed) AS second_half_avg
    FROM trips
    WHERE trip_date >= '2023-07-01'
    GROUP BY driver_id
)

SELECT 
    d.driver_id,
    d.driver_name,
    ROUND(fa.first_half_avg, 2) AS first_half_avg,
    ROUND(sa.second_half_avg, 2) AS second_half_avg,
    ROUND((sa.second_half_avg - fa.first_half_avg), 2) AS efficiency_improvement
FROM first_avg AS fa
INNER JOIN
    second_avg AS sa
    ON fa.driver_id = sa.driver_id
LEFT JOIN
    drivers AS d
    ON fa.driver_id = d.driver_id
WHERE (sa.second_half_avg - fa.first_half_avg) > 0
ORDER BY efficiency_improvement DESC, d.driver_name ASC
