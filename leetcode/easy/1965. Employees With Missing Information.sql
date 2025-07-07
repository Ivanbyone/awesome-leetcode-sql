/*
Question 1965. Employees With Missing Information
Link: https://leetcode.com/problems/employees-with-missing-information/description/

Table: Employees

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| name        | varchar |
+-------------+---------+
employee_id is the column with unique values for this table.
Each row of this table indicates the name of the employee whose ID is employee_id.
 

Table: Salaries

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| salary      | int     |
+-------------+---------+
employee_id is the column with unique values for this table.
Each row of this table indicates the salary of the employee whose ID is employee_id.
 

Write a solution to report the IDs of all the employees with missing information. The information of an employee is missing if:

The employee's name is missing, or
The employee's salary is missing.
Return the result table ordered by employee_id in ascending order.
*/

WITH all_employees AS (
    SELECT employee_id
    FROM Employees
    UNION
    SELECT employee_id
    FROM Salaries
)

SELECT a.employee_id 
FROM all_employees AS a
LEFT JOIN 
    Employees AS e
    ON a.employee_id = e.employee_id
LEFT JOIN 
    Salaries AS s
    ON a.employee_id = s.employee_id
WHERE e.name IS NULL OR s.salary IS NULL
ORDER BY a.employee_id ASC
