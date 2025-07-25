/*
Question 3451. Find Invalid IP Addresses
Link: https://leetcode.com/problems/find-invalid-ip-addresses/description/?envType=problem-list-v2&envId=database

Table:  logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| log_id      | int     |
| ip          | varchar |
| status_code | int     |
+-------------+---------+
log_id is the unique key for this table.
Each row contains server access log information including IP address and HTTP status code.
Write a solution to find invalid IP addresses. An IPv4 address is invalid if it meets any of these conditions:

Contains numbers greater than 255 in any octet
Has leading zeros in any octet (like 01.02.03.04)
Has less or more than 4 octets
Return the result table ordered by invalid_count, ip in descending order respectively. 
*/

SELECT
    ip,
    COUNT(ip) AS invalid_count
FROM logs
WHERE 
    ARRAY_LENGTH(STRING_TO_ARRAY(ip, '.'), 1) != 4
    OR LEFT(SPLIT_PART(ip, '.', 1), 1) = '0'
    OR LEFT(SPLIT_PART(ip, '.', 2), 1) = '0'
    OR LEFT(SPLIT_PART(ip, '.', 3), 1) = '0'
    OR LEFT(SPLIT_PART(ip, '.', 4), 1) = '0'
    OR SPLIT_PART(ip, '.', 1)::numeric > 255
    OR SPLIT_PART(ip, '.', 2)::numeric > 255
    OR SPLIT_PART(ip, '.', 3)::numeric > 255
    OR SPLIT_PART(ip, '.', 4)::numeric > 255
GROUP BY ip
ORDER BY invalid_count DESC, ip DESC
