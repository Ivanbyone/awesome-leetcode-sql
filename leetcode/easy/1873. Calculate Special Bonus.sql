/*
Question 1873. Calculate Special Bonus
Link: https://leetcode.com/problems/calculate-special-bonus/description/?envType=problem-list-v2&envId=database

Table: Employees

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| name        | varchar |
| salary      | int     |
+-------------+---------+
employee_id is the primary key (column with unique values) for this table.
Each row of this table indicates the employee ID, employee name, and salary.
 

Write a solution to calculate the bonus of each employee. The bonus of an employee is 100% of their salary if the ID of the employee is an odd number and the employee's name does not start with the character 'M'. The bonus of an employee is 0 otherwise.

Return the result table ordered by employee_id.
*/

SELECT
    employee_id,
    (CASE
        WHEN employee_id % 2 = 0 OR LEFT(name, 1) = 'M' 
            THEN 0
        ELSE salary
    END) AS bonus
FROM Employees
ORDER BY employee_id ASC
