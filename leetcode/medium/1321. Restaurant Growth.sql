/*
Question 1321. Restaurant Growth
Link: https://leetcode.com/problems/restaurant-growth/description/?envType=study-plan-v2&envId=top-sql-50

Table: Customer

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| name          | varchar |
| visited_on    | date    |
| amount        | int     |
+---------------+---------+
In SQL,(customer_id, visited_on) is the primary key for this table.
This table contains data about customer transactions in a restaurant.
visited_on is the date on which the customer with ID (customer_id) has visited the restaurant.
amount is the total paid by a customer.
 

You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).

Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). average_amount should be rounded to two decimal places.

Return the result table ordered by visited_on in ascending order.
*/

WITH visited_dates AS (
    SELECT visited_on + INTERVAL '6 days' AS dates
    FROM Customer
    GROUP BY visited_on
)

SELECT DISTINCT
    c.visited_on,
    (
        SELECT SUM(c1.amount)
        FROM Customer AS c1
        WHERE c1.visited_on BETWEEN c.visited_on - INTERVAL '6 days' AND c.visited_on
    ) AS amount,
    (
        SELECT ROUND(SUM(c2.amount)::NUMERIC / 7, 2)
        FROM Customer AS c2
        WHERE c2.visited_on BETWEEN c.visited_on - INTERVAL '6 days' AND c.visited_on
    ) AS average_amount
FROM Customer AS c
LEFT JOIN
    visited_dates AS v
    ON c.visited_on = v.dates
WHERE v.dates IS NOT NULL
