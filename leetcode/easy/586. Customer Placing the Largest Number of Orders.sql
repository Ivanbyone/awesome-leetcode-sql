/*
Question 586. Customer Placing the Largest Number of Orders
Link: https://leetcode.com/problems/customer-placing-the-largest-number-of-orders/description/

Table: Orders

+-----------------+----------+
| Column Name     | Type     |
+-----------------+----------+
| order_number    | int      |
| customer_number | int      |
+-----------------+----------+
order_number is the primary key (column with unique values) for this table.
This table contains information about the order ID and the customer ID.
 

Write a solution to find the customer_number for the customer who has placed the largest number of orders.

The test cases are generated so that exactly one customer will have placed more orders than any other customer.
*/

SELECT customer_number
FROM Orders
GROUP BY customer_number
ORDER BY COUNT(1) DESC
LIMIT 1
