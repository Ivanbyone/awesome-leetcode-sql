/*
Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee.
 

Write a solution to find the second highest distinct salary from the Employee table. If there is no second highest salary, return null (return None in Pandas)
*/

SELECT MAX(e1.salary) AS SecondHighestSalary
FROM Employee AS e1
WHERE e1.salary < (SELECT MAX(e2.salary) FROM Employee AS e2)
