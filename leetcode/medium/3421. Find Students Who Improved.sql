/*
Question 3421. Find Students Who Improved
Link: https://leetcode.com/problems/find-students-who-improved/description/?envType=problem-list-v2&envId=database

Table: Scores

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| student_id  | int     |
| subject     | varchar |
| score       | int     |
| exam_date   | varchar |
+-------------+---------+
(student_id, subject, exam_date) is the primary key for this table.
Each row contains information about a student's score in a specific subject on a particular exam date. score is between 0 and 100 (inclusive).
Write a solution to find the students who have shown improvement. A student is considered to have shown improvement if they meet both of these conditions:

Have taken exams in the same subject on at least two different dates
Their latest score in that subject is higher than their first score
Return the result table ordered by student_id, subject in ascending order.
*/

WITH first_scores AS (
    SELECT
        student_id,
        subject,
        FIRST_VALUE(score) OVER (PARTITION BY student_id, subject ORDER BY exam_date ASC) AS first_score
    FROM Scores
),

last_scores AS (
    SELECT
        student_id,
        subject,
        FIRST_VALUE(score) OVER (PARTITION BY student_id, subject ORDER BY exam_date DESC) AS latest_score
    FROM Scores
),

exams AS (
    SELECT
        student_id,
        subject
    FROM Scores
    GROUP BY student_id, subject
),

all_scores AS (
    SELECT 
        e.student_id,
        e.subject,
        (
            SELECT fs.first_score
            FROM first_scores AS fs
            WHERE fs.student_id = e.student_id AND fs.subject = e.subject
            LIMIT 1
        ) AS first_score,
        (
            SELECT ls.latest_score
            FROM last_scores AS ls
            WHERE ls.student_id = e.student_id AND ls.subject = e.subject
            LIMIT 1
        ) AS latest_score
    FROM exams AS e
)

SELECT
    student_id,
    subject,
    first_score,
    latest_score
FROM all_scores
WHERE latest_score > first_score
ORDER BY student_id, subject
