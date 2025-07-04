/*
Question 1193. Monthly Transactions I
Link: https://leetcode.com/problems/monthly-transactions-i/description/


Table: Transactions

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| country       | varchar |
| state         | enum    |
| amount        | int     |
| trans_date    | date    |
+---------------+---------+
id is the primary key of this table.
The table has information about incoming transactions.
The state column is an enum of type ["approved", "declined"].
 

Write an SQL query to find for each month and country, the number of transactions and their total amount, the number of approved transactions and their total amount.

Return the result table in any order.
*/

SELECT 
    country,
    extract(YEAR FROM trans_date)::text || '-' || lpad(extract(MONTH FROM trans_date)::text, 2, '0') AS month, --noqa: RF04
    count(id) AS trans_count,
    count(CASE WHEN state = 'approved' THEN 1 END) AS approved_count,
    sum(amount) AS trans_total_amount,
    sum(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY month, country
