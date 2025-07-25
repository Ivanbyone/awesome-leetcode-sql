/*
Question 3564. Seasonal Sales Analysis
Link: https://leetcode.com/problems/seasonal-sales-analysis/description/?envType=problem-list-v2&envId=database

Table: sales

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| sale_id       | int     |
| product_id    | int     |
| sale_date     | date    |
| quantity      | int     |
| price         | decimal |
+---------------+---------+
sale_id is the unique identifier for this table.
Each row contains information about a product sale including the product_id, date of sale, quantity sold, and price per unit.
Table: products

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| product_name  | varchar |
| category      | varchar |
+---------------+---------+
product_id is the unique identifier for this table.
Each row contains information about a product including its name and category.
Write a solution to find the most popular product category for each season. The seasons are defined as:

Winter: December, January, February
Spring: March, April, May
Summer: June, July, August
Fall: September, October, November
The popularity of a category is determined by the total quantity sold in that season. If there is a tie, select the category with the highest total revenue (quantity × price).

Return the result table ordered by season in ascending order.
*/

WITH stats AS (
    SELECT
        p.category,
        (CASE
            WHEN EXTRACT(MONTH FROM s.sale_date) BETWEEN 3 AND 5
                THEN 'Spring'
            WHEN EXTRACT(MONTH FROM s.sale_date) BETWEEN 6 AND 8
                THEN 'Summer'
            WHEN EXTRACT(MONTH FROM s.sale_date) BETWEEN 9 AND 11
                THEN 'Fall'
            ELSE 'Winter'
        END) AS season,
        SUM(s.quantity) AS total_quantity,
        SUM(s.quantity * s.price) AS total_revenue
    FROM sales AS s
    LEFT JOIN 
        products AS p
        ON s.product_id = p.product_id
    GROUP BY s.season, p.category
)

SELECT 
    s.season,
    s.category,
    s.total_quantity,
    s.total_revenue
FROM (
    SELECT 
        s1.season,
        s1.category,
        s1.total_quantity,
        s1.total_revenue,
        RANK() OVER(PARTITION BY s1.season ORDER BY s1.total_quantity DESC, s1.total_revenue DESC) AS rank
    FROM stats AS s1
) AS s
WHERE s.rank = 1
ORDER BY s.season ASC
