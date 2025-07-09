/*
Question 1164. Product Price at a Given Date
Link: https://leetcode.com/problems/product-price-at-a-given-date/description/?envType=study-plan-v2&envId=top-sql-50

Table: Products

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |
+---------------+---------+
(product_id, change_date) is the primary key (combination of columns with unique values) of this table.
Each row of this table indicates that the price of some product was changed to a new price at some date.
Initially, all products have price 10.

Write a solution to find the prices of all products on the date 2019-08-16.

Return the result table in any order.
*/

SELECT DISTINCT
    p.product_id,
    COALESCE(
        (
            SELECT p1.new_price
            FROM Products AS p1
            WHERE
                p1.change_date <= '2019-08-16' 
                AND p1.product_id = p.product_id
            ORDER BY p1.change_date DESC
            LIMIT 1
        ), 10
    ) AS price
FROM Products AS p
