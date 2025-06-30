/*
Question 1070. Product Sales Analysis 3
Link: https://leetcode.com/problems/product-sales-analysis-iii/description/

Table: Sales

+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| sale_id     | int   |
| product_id  | int   |
| year        | int   |
| quantity    | int   |
| price       | int   |
+-------------+-------+
(sale_id, year) is the primary key (combination of columns with unique values) of this table.
product_id is a foreign key (reference column) to Product table.
Each row records a sale of a product in a given year.
A product may have multiple sales entries in the same year.
Note that the per-unit price.

Write a solution to find all sales that occurred in the first year each product was sold.

For each product_id, identify the earliest year it appears in the Sales table.

Return all sales entries for that product in that year.

Return a table with the following columns: product_id, first_year, quantity, and price.
Return the result in any order.
*/

SELECT 
    s1.product_id,
    s1.year AS first_year,
    s1.quantity,
    s1.price
FROM Sales AS s1
WHERE s1.year = (
    SELECT MIN(s2.year)
    FROM Sales AS s2
    WHERE s1.product_id = s2.product_id
)
