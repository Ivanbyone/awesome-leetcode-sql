/*
Question 3482. Analyze Organization Hierarchy
Link: https://leetcode.com/problems/analyze-organization-hierarchy/description/?envType=problem-list-v2&envId=database

Table: Employees

+----------------+---------+
| Column Name    | Type    | 
+----------------+---------+
| employee_id    | int     |
| employee_name  | varchar |
| manager_id     | int     |
| salary         | int     |
| department     | varchar |
+----------------+----------+
employee_id is the unique key for this table.
Each row contains information about an employee, including their ID, name, their manager's ID, salary, and department.
manager_id is null for the top-level manager (CEO).
Write a solution to analyze the organizational hierarchy and answer the following:

Hierarchy Levels: For each employee, determine their level in the organization (CEO is level 1, employees reporting directly to the CEO are level 2, and so on).
Team Size: For each employee who is a manager, count the total number of employees under them (direct and indirect reports).
Salary Budget: For each manager, calculate the total salary budget they control (sum of salaries of all employees under them, including indirect reports, plus their own salary).
Return the result table ordered by the result ordered by level in ascending order, then by budget in descending order, and finally by employee_name in ascending order.
*/

WITH RECURSIVE cte AS (
    SELECT
        e1.employee_id,
        e1.employee_name,
        e1.manager_id,
        e1.salary,
        1 AS rank
    FROM Employees AS e1
    WHERE e1.manager_id IS NULL

    UNION ALL 

    SELECT
        e2.employee_id,
        e2.employee_name,
        e2.manager_id,
        e2.salary,
        c.rank + 1 AS rank
    FROM Employees AS e2
    INNER JOIN 
        cte AS c
        ON e2.manager_id = c.employee_id
),

teamsize AS (
    SELECT
        e3.employee_id AS manager_id,
        e3.employee_id AS member_id,
        e3.salary AS member_salary
    FROM Employees AS e3

    UNION ALL

    SELECT 
        ts.manager_id,
        e4.employee_id AS member_id,
        e4.salary AS member_salary
    FROM Employees AS e4
    JOIN --noqa: AM05
        teamsize AS ts
        ON e4.manager_id = ts.member_id
)

SELECT
    c.employee_id,
    c.employee_name,
    c.rank AS level, --noqa: RF04
    COUNT(*) - 1 AS team_size,
    SUM(ts.member_salary) AS budget
FROM cte AS c
INNER JOIN 
    teamsize AS ts
    ON c.employee_id = ts.manager_id
GROUP BY c.employee_id, c.employee_name, c.rank
ORDER BY level ASC, budget DESC, c.employee_name ASC
