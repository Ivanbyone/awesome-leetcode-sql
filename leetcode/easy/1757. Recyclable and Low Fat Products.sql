/*
Question 1757. Recyclable and Low Fat Products
Link: https://leetcode.com/problems/recyclable-and-low-fat-products/description/?envType=problem-list-v2&envId=database

Table: Products

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_id  | int     |
| low_fats    | enum    |
| recyclable  | enum    |
+-------------+---------+
product_id is the primary key (column with unique values) for this table.
low_fats is an ENUM (category) of type ('Y', 'N') where 'Y' means this product is low fat and 'N' means it is not.
recyclable is an ENUM (category) of types ('Y', 'N') where 'Y' means this product is recyclable and 'N' means it is not.
 

Write a solution to find the ids of products that are both low fat and recyclable.

Return the result table in any order.
*/

SELECT product_id 
FROM products
WHERE low_fats = 'Y' AND recyclable = 'Y'
