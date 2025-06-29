/*
Question 184. Department Highest Salary
Link: https://leetcode.com/problems/department-highest-salary/description/

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
departmentId is a foreign key (reference columns) of the ID from the Department table.
Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
 

Table: Department

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table. It is guaranteed that department name is not NULL.
Each row of this table indicates the ID of a department and its name.
 

Write a solution to find employees who have the highest salary in each of the departments.

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
WHERE e.salary = (
    SELECT MAX(em.salary) 
    FROM Employee AS em
    WHERE em.departmentId = e.departmentId
)
