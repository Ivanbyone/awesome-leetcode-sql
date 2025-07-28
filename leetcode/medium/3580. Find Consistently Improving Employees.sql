/*
Question 3580. Find Consistently Improving Employees
Link: https://leetcode.com/problems/find-consistently-improving-employees/description/?envType=problem-list-v2&envId=database

Table: employees

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| name        | varchar |
+-------------+---------+
employee_id is the unique identifier for this table.
Each row contains information about an employee.
Table: performance_reviews

+-------------+------+
| Column Name | Type |
+-------------+------+
| review_id   | int  |
| employee_id | int  |
| review_date | date |
| rating      | int  |
+-------------+------+
review_id is the unique identifier for this table.
Each row represents a performance review for an employee. The rating is on a scale of 1-5 where 5 is excellent and 1 is poor.
Write a solution to find employees who have consistently improved their performance over their last three reviews.

An employee must have at least 3 review to be considered
The employee's last 3 reviews must show strictly increasing ratings (each review better than the previous)
Use the most recent 3 reviews based on review_date for each employee
Calculate the improvement score as the difference between the latest rating and the earliest rating among the last 3 reviews
Return the result table ordered by improvement score in descending order, then by name in ascending order.
*/

WITH review_dates AS (
    SELECT
        employee_id,
        MAX(review_date) AS review_date
    FROM performance_reviews
    GROUP BY employee_id
),

review_ratings AS (
    SELECT 
        pr.employee_id,
        pr.review_date,
        pr.rating,
        LAG(pr.rating, 1, NULL) OVER (PARTITION BY pr.employee_id ORDER BY pr.review_date) AS second_rating,
        LAG(pr.rating, 2, NULL) OVER (PARTITION BY pr.employee_id ORDER BY pr.review_date) AS third_rating
    FROM performance_reviews AS pr
)

SELECT
    e.employee_id,
    e.name,
    rr.rating - rr.third_rating AS improvement_score
FROM employees AS e
LEFT JOIN
    review_dates AS rd
    ON e.employee_id = rd.employee_id
INNER JOIN
    review_ratings AS rr
    ON
        e.employee_id = rr.employee_id
        AND rd.review_date = rr.review_date
WHERE rr.rating > rr.second_rating AND rr.second_rating > rr.third_rating
ORDER BY improvement_score DESC, e.name ASC
