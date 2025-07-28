/*
Question 3611. Find Overbooked Employees
Link: https://leetcode.com/problems/find-overbooked-employees/description/?envType=problem-list-v2&envId=database

Table: employees

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| employee_id   | int     |
| employee_name | varchar |
| department    | varchar |
+---------------+---------+
employee_id is the unique identifier for this table.
Each row contains information about an employee and their department.
Table: meetings

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| meeting_id    | int     |
| employee_id   | int     |
| meeting_date  | date    |
| meeting_type  | varchar |
| duration_hours| decimal |
+---------------+---------+
meeting_id is the unique identifier for this table.
Each row represents a meeting attended by an employee. meeting_type can be 'Team', 'Client', or 'Training'.
Write a solution to find employees who are meeting-heavy - employees who spend more than 50% of their working time in meetings during any given week.

Assume a standard work week is 40 hours
Calculate total meeting hours per employee per week (Monday to Sunday)
An employee is meeting-heavy if their weekly meeting hours > 20 hours (50% of 40 hours)
Count how many weeks each employee was meeting-heavy
Only include employees who were meeting-heavy for at least 2 weeks
Return the result table ordered by the number of meeting-heavy weeks in descending order, then by employee name in ascending order.
*/

WITH weeks_stats AS (
    SELECT
        employee_id,
        EXTRACT(WEEK FROM meeting_date) AS week, --noqa: RF04
        SUM(duration_hours) AS meet
    FROM meetings
    GROUP BY employee_id, week
    HAVING SUM(duration_hours) > 20
)

SELECT 
    e.employee_id,
    e.employee_name,
    e.department,
    COUNT(e.employee_id) AS meeting_heavy_weeks
FROM weeks_stats AS ws
LEFT JOIN 
    employees AS e
    ON ws.employee_id = e.employee_id
GROUP BY e.employee_id, e.employee_name, e.department
HAVING COUNT(e.employee_id) >= 2
ORDER BY meeting_heavy_weeks DESC, e.employee_name ASC
