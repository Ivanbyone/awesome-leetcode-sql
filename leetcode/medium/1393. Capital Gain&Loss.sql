/*
Question 1393. Capital Gain/Loss
Link: https://leetcode.com/problems/capital-gainloss/description/?envType=problem-list-v2&envId=database

Table: Stocks

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| stock_name    | varchar |
| operation     | enum    |
| operation_day | int     |
| price         | int     |
+---------------+---------+
(stock_name, operation_day) is the primary key (combination of columns with unique values) for this table.
The operation column is an ENUM (category) of type ('Sell', 'Buy')
Each row of this table indicates that the stock which has stock_name had an operation on the day operation_day with the price.
It is guaranteed that each 'Sell' operation for a stock has a corresponding 'Buy' operation in a previous day. It is also guaranteed that each 'Buy' operation for a stock has a corresponding 'Sell' operation in an upcoming day.
 

Write a solution to report the Capital gain/loss for each stock.

The Capital gain/loss of a stock is the total gain or loss after buying and selling the stock one or many times.

Return the result table in any order.
*/

-- with subqueries

SELECT DISTINCT
    s.stock_name,
    (
        SELECT SUM(s1.price)
        FROM Stocks AS s1
        WHERE s1.stock_name = s.stock_name AND s1.operation = 'Sell'
    )
    - (
        SELECT SUM(s2.price)
        FROM Stocks AS s2
        WHERE s2.stock_name = s.stock_name AND s2.operation = 'Buy'
    )
    AS capital_gain_loss --noqa: LT02
FROM Stocks AS s
