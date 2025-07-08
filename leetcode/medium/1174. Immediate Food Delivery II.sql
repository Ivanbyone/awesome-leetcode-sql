/*
Question 1174. Immediate Food Delivery II
Link: https://leetcode.com/problems/immediate-food-delivery-ii/description/?envType=study-plan-v2&envId=top-sql-50

Table: Delivery

+-----------------------------+---------+
| Column Name                 | Type    |
+-----------------------------+---------+
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
delivery_id is the column of unique values of this table.
The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order date or after it).
 

If the customer's preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.

The first order of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.

Write a solution to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.
*/

WITH first_delivery AS (
    SELECT 
        customer_id,
        MIN(order_date) AS first_order_date
    FROM Delivery
    GROUP BY customer_id
)

SELECT
    ROUND(COUNT(
        CASE
            WHEN d.customer_pref_delivery_date = f.first_order_date
                THEN 1
        END
    ) * 100.00 / COUNT(1), 2) AS immediate_percentage
FROM Delivery AS d
LEFT JOIN 
    first_delivery AS f
    ON
        d.customer_id = f.customer_id
        AND d.order_date = f.first_order_date
WHERE f.first_order_date IS NOT NULL
