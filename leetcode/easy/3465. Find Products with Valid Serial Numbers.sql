/*
Question 3465. Find Products with Valid Serial Numbers
Link: https://leetcode.com/problems/find-products-with-valid-serial-numbers/description/?envType=problem-list-v2&envId=database

Table: products

+--------------+------------+
| Column Name  | Type       |
+--------------+------------+
| product_id   | int        |
| product_name | varchar    |
| description  | varchar    |
+--------------+------------+
(product_id) is the unique key for this table.
Each row in the table represents a product with its unique ID, name, and description.
Write a solution to find all products whose description contains a valid serial number pattern. A valid serial number follows these rules:

It starts with the letters SN (case-sensitive).
Followed by exactly 4 digits.
It must have a hyphen (-) followed by exactly 4 digits.
The serial number must be within the description (it may not necessarily start at the beginning).
Return the result table ordered by product_id in ascending order.
*/

SELECT 
    product_id,
    product_name,
    description --noqa
FROM products
WHERE description ~ '\ySN[0-9]{4}\-[0-9]{4}\y'
ORDER BY product_id ASC
