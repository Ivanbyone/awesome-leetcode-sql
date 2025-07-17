/*
Question 3220. Odd and Even Transactions
Link: https://leetcode.com/problems/odd-and-even-transactions/description/?envType=problem-list-v2&envId=database

Table: transactions

+------------------+------+
| Column Name      | Type | 
+------------------+------+
| transaction_id   | int  |
| amount           | int  |
| transaction_date | date |
+------------------+------+
The transactions_id column uniquely identifies each row in this table.
Each row of this table contains the transaction id, amount and transaction date.
Write a solution to find the sum of amounts for odd and even transactions for each day. If there are no odd or even transactions for a specific date, display as 0.

Return the result table ordered by transaction_date in ascending order.
*/

SELECT
    transaction_date,
    SUM(CASE
        WHEN amount % 2 = 1
            THEN amount
        ELSE 0
    END) AS odd_sum,
    SUM(CASE
        WHEN amount % 2 = 0
            THEN amount
        ELSE 0
    END) AS even_sum
FROM transactions
GROUP BY transaction_date
ORDER BY transaction_date ASC
