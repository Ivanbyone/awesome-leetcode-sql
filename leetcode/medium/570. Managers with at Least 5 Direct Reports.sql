/*
Question 570. Managers with at Least 5 Direct Reports
Link: https://leetcode.com/problems/managers-with-at-least-5-direct-reports/description/

Table: Employee

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| department  | varchar |
| managerId   | int     |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the name of an employee, their department, and the id of their manager.
If managerId is null, then the employee does not have a manager.
No employee will be the manager of themself.
 

Write a solution to find managers with at least five direct reports.

Return the result table in any order.
*/

WITH five_direct AS (
    SELECT 
        managerId, 
        COUNT(managerId) AS manager
    FROM Employee
    GROUP BY managerId
)

SELECT e.name 
FROM Employee AS e
LEFT JOIN 
    five_direct AS f
    ON e.id = f.managerId
WHERE f.manager >= 5
