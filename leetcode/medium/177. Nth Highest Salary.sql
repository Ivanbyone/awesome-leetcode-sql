/*
Question 177. Nth Highest Salary
Link: https://leetcode.com/problems/nth-highest-salary/description/?envType=problem-list-v2&envId=database

Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee.
 

Write a solution to find the nth highest distinct salary from the Employee table. If there are less than n distinct salaries, return null.
*/

CREATE OR REPLACE FUNCTION NTHHIGHESTSALARY(N INT) RETURNS TABLE (Salary INT) AS $$ --noqa: CP03 (function NthHighestSalary)
BEGIN
  IF N <= 0 THEN
    Salary := NULL;
    RETURN NEXT;
    RETURN;
  END IF;

  RETURN QUERY (
    SELECT DISTINCT e.salary
    FROM Employee e
    ORDER BY e.salary DESC
    LIMIT 1 OFFSET (N - 1)
  );
END;
$$ LANGUAGE plpgsql;
