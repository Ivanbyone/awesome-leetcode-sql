/*
Question 185. Department Top Three Salaries
Link: https://leetcode.com/problems/department-top-three-salaries/description/

Table: Employee

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |
| name         | varchar |
| salary       | int     |
| departmentId | int     |
+--------------+---------+
id is the primary key (column with unique values) for this table.
departmentId is a foreign key (reference column) of the ID from the Department table.
Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
 

Table: Department

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the ID of a department and its name.
 

A company's executives are interested in seeing who earns the most money in each of the company's departments. A high earner in a department is an employee who has a salary in the top three unique salaries for that department.

Write a solution to find the employees who are high earners in each of the departments.

Return the result table in any order.
*/

SELECT 
    d.name AS Department,
    e.name AS Employee,
    e.salary
FROM Employee AS e
LEFT JOIN 
    Department AS d
    ON e.departmentId = d.id
WHERE (e.departmentId, e.salary) IN (
    SELECT
        e2.departmentId,
        e2.salary 
    FROM Employee AS e2
    WHERE e2.departmentId = d.id 
    GROUP BY e2.departmentId, e2.salary 
    ORDER BY e2.salary DESC 
    LIMIT 3
)
