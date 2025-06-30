/*
Question 1045. Customers Who Bought All Products
Link: https://leetcode.com/problems/customers-who-bought-all-products/description/

Table: Customer

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| customer_id | int     |
| product_key | int     |
+-------------+---------+
This table may contain duplicates rows. 
customer_id is not NULL.
product_key is a foreign key (reference column) to Product table.
 

Table: Product

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_key | int     |
+-------------+---------+
product_key is the primary key (column with unique values) for this table.
 

Write a solution to report the customer ids from the Customer table that bought all the products in the Product table.

Return the result table in any order.
*/

WITH Customer_products AS (
    SELECT customer_id, COUNT(DISTINCT product_key) as c
    FROM Customer
    GROUP BY customer_id
)
SELECT customer_id
FROM Customer_products
WHERE c = (
    SELECT COUNT(1)
    FROM Product
)