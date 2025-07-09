/*
Question 585. Investments in 2016
Link: https://leetcode.com/problems/investments-in-2016/description/?envType=study-plan-v2&envId=top-sql-50

Table: Insurance

+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| pid         | int   |
| tiv_2015    | float |
| tiv_2016    | float |
| lat         | float |
| lon         | float |
+-------------+-------+
pid is the primary key (column with unique values) for this table.
Each row of this table contains information about one policy where:
pid is the policyholder's policy ID.
tiv_2015 is the total investment value in 2015 and tiv_2016 is the total investment value in 2016.
lat is the latitude of the policy holder's city. It's guaranteed that lat is not NULL.
lon is the longitude of the policy holder's city. It's guaranteed that lon is not NULL.
 

Write a solution to report the sum of all total investment values in 2016 tiv_2016, for all policyholders who:

have the same tiv_2015 value as one or more other policyholders, and
are not located in the same city as any other policyholder (i.e., the (lat, lon) attribute pairs must be unique).
Round tiv_2016 to two decimal places.
*/

SELECT ROUND(SUM(i.tiv_2016)::numeric, 2) AS tiv_2016
FROM Insurance AS i
WHERE (i.lat, i.lon) IN (
    SELECT 
        i1.lat, 
        i1.lon 
    FROM Insurance AS i1
    GROUP BY i1.lat, i1.lon
    HAVING COUNT(1) = 1
) AND i.tiv_2015 IN (
    SELECT i2.tiv_2015
    FROM Insurance AS i2
    GROUP BY i2.tiv_2015
    HAVING COUNT(1) > 1
)
