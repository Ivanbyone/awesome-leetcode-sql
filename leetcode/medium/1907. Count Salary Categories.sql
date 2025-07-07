/*
Question 1907. Count Salary Categories
Link: https://leetcode.com/problems/count-salary-categories/description/

Table: Accounts

+-------------+------+
| Column Name | Type |
+-------------+------+
| account_id  | int  |
| income      | int  |
+-------------+------+
account_id is the primary key (column with unique values) for this table.
Each row contains information about the monthly income for one bank account.
 

Write a solution to calculate the number of bank accounts for each salary category. The salary categories are:

"Low Salary": All the salaries strictly less than $20000.
"Average Salary": All the salaries in the inclusive range [$20000, $50000].
"High Salary": All the salaries strictly greater than $50000.
The result table must contain all three categories. If there are no accounts in a category, return 0.

Return the result table in any order.
*/

SELECT 
    'Low Salary' AS category,
    COUNT(income) AS accounts_count
FROM Accounts
WHERE income < 20000

UNION

SELECT 
    'Average Salary' AS category,
    COUNT(income) AS accounts_count
FROM Accounts
WHERE income BETWEEN 20000 AND 50000

UNION

SELECT 
    'High Salary' AS category,
    COUNT(income) AS accounts_count
FROM Accounts
WHERE income > 50000
