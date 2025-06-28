/*
Question 183. Customers Who Never Order.
Link: https://leetcode.com/problems/customers-who-never-order/description/

Table: Customers

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the ID and name of a customer.
 

Table: Orders

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| customerId  | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
customerId is a foreign key (reference columns) 
of the ID from the Customers table.
Each row of this table indicates the ID 
of an order and the ID of the customer who ordered it.
 

Write a solution to find all customers who never order anything.

Return the result table in any order.
*/

SELECT Customers.name AS Customers
FROM Customers
LEFT JOIN
    Orders
    ON
        Customers.id = Orders.customerId
WHERE Orders.id IS NULL
