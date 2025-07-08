/*
Question 1661. Average Time of Process per Machine
Link: https://leetcode.com/problems/average-time-of-process-per-machine/description/?envType=study-plan-v2&envId=top-sql-50

Table: Activity

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| machine_id     | int     |
| process_id     | int     |
| activity_type  | enum    |
| timestamp      | float   |
+----------------+---------+
The table shows the user activities for a factory website.
(machine_id, process_id, activity_type) is the primary key (combination of columns with unique values) of this table.
machine_id is the ID of a machine.
process_id is the ID of a process running on the machine with ID machine_id.
activity_type is an ENUM (category) of type ('start', 'end').
timestamp is a float representing the current time in seconds.
'start' means the machine starts the process at the given timestamp and 'end' means the machine ends the process at the given timestamp.
The 'start' timestamp will always be before the 'end' timestamp for every (machine_id, process_id) pair.
It is guaranteed that each (machine_id, process_id) pair has a 'start' and 'end' timestamp.
 

There is a factory website that has several machines each running the same number of processes. Write a solution to find the average time each machine takes to complete a process.

The time to complete a process is the 'end' timestamp minus the 'start' timestamp. The average time is calculated by the total time to complete every process on the machine divided by the number of processes that were run.

The resulting table should have the machine_id along with the average time as processing_time, which should be rounded to 3 decimal places.

Return the result table in any order.
*/

WITH end_process AS (
    SELECT 
        tmp.machine_id,
        tmp.process_id,
        tmp.timestamp AS end_timestamp
    FROM Activity AS tmp
    WHERE tmp.activity_type = 'end'
)

SELECT
    a.machine_id,
    ROUND(AVG(e.end_timestamp - a.timestamp)::numeric, 3) AS processing_time
FROM Activity AS a
LEFT JOIN 
    end_process AS e
    ON
        a.machine_id = e.machine_id
        AND a.process_id = e.process_id
WHERE a.activity_type = 'start'
GROUP BY a.machine_id
