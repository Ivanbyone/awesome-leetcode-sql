/*
Question 1280. Students and Examinations
Link: https://leetcode.com/problems/students-and-examinations/description/?envType=study-plan-v2&envId=top-sql-50

Table: Students

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| student_id    | int     |
| student_name  | varchar |
+---------------+---------+
student_id is the primary key (column with unique values) for this table.
Each row of this table contains the ID and the name of one student in the school.
 

Table: Subjects

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| subject_name | varchar |
+--------------+---------+
subject_name is the primary key (column with unique values) for this table.
Each row of this table contains the name of one subject in the school.
 

Table: Examinations

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| student_id   | int     |
| subject_name | varchar |
+--------------+---------+
There is no primary key (column with unique values) for this table. It may contain duplicates.
Each student from the Students table takes every course from the Subjects table.
Each row of this table indicates that a student with ID student_id attended the exam of subject_name.
 

Write a solution to find the number of times each student attended each exam.

Return the result table ordered by student_id and subject_name.
*/

SELECT
    st.student_id,
    st.student_name,
    s.subject_name,
    COUNT(e.student_id) AS attended_exams
FROM Students AS st
CROSS JOIN Subjects AS s
LEFT JOIN
    Examinations AS e
    ON
        st.student_id = e.student_id
        AND s.subject_name = e.subject_name
GROUP BY st.student_id, st.student_name, s.subject_name
ORDER BY st.student_id, st.student_name, s.subject_name
