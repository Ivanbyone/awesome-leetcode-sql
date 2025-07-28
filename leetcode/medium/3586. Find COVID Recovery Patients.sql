/*
Question 3586. Find COVID Recovery Patients
Link: https://leetcode.com/problems/find-covid-recovery-patients/description/?envType=problem-list-v2&envId=database

Table: patients

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| patient_id  | int     |
| patient_name| varchar |
| age         | int     |
+-------------+---------+
patient_id is the unique identifier for this table.
Each row contains information about a patient.
Table: covid_tests

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| test_id     | int     |
| patient_id  | int     |
| test_date   | date    |
| result      | varchar |
+-------------+---------+
test_id is the unique identifier for this table.
Each row represents a COVID test result. The result can be Positive, Negative, or Inconclusive.
Write a solution to find patients who have recovered from COVID - patients who tested positive but later tested negative.

A patient is considered recovered if they have at least one Positive test followed by at least one Negative test on a later date
Calculate the recovery time in days as the difference between the first positive test and the first negative test after that positive test
Only include patients who have both positive and negative test results
Return the result table ordered by recovery_time in ascending order, then by patient_name in ascending order.
*/

WITH first_positive AS (
    SELECT
        patient_id,
        MIN(test_date) AS positive
    FROM covid_tests
    WHERE result = 'Positive'
    GROUP BY patient_id
),

first_negative AS (
    SELECT
        ct.patient_id,
        MIN(ct.test_date) AS negative,
        MIN(fp.positive) AS positive
    FROM covid_tests AS ct
    LEFT JOIN 
        first_positive AS fp
        ON ct.patient_id = fp.patient_id
    WHERE ct.result = 'Negative' AND ct.test_date > fp.positive
    GROUP BY ct.patient_id
)

SELECT
    fn.patient_id,
    p.patient_name,
    p.age,
    fn.negative - fn.positive AS recovery_time
FROM first_negative AS fn
LEFT JOIN
    patients AS p
    ON fn.patient_id = p.patient_id
ORDER BY recovery_time ASC, p.patient_name ASC
