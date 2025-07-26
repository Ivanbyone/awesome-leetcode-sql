/*
Question 262. Trips and Users
Link: https://leetcode.com/problems/trips-and-users/description/?envType=problem-list-v2&envId=database

Table: Trips

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| id          | int      |
| client_id   | int      |
| driver_id   | int      |
| city_id     | int      |
| status      | enum     |
| request_at  | varchar  |     
+-------------+----------+
id is the primary key (column with unique values) for this table.
The table holds all taxi trips. Each trip has a unique id, while client_id and driver_id are foreign keys to the users_id at the Users table.
Status is an ENUM (category) type of ('completed', 'cancelled_by_driver', 'cancelled_by_client').

Table: Users

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| users_id    | int      |
| banned      | enum     |
| role        | enum     |
+-------------+----------+
users_id is the primary key (column with unique values) for this table.
The table holds all users. Each user has a unique users_id, and role is an ENUM type of ('client', 'driver', 'partner').
banned is an ENUM (category) type of ('Yes', 'No').

The cancellation rate is computed by dividing the number of canceled (by client or driver) requests with unbanned users by the total number of requests with unbanned users on that day.

Write a solution to find the cancellation rate of requests with unbanned users (both client and driver must not be banned) each day between "2013-10-01" and "2013-10-03" with at least one trip. Round Cancellation Rate to two decimal points.

Return the result table in any order.
*/

SELECT
    t.request_at AS "Day",
    ROUND(COUNT(CASE WHEN t.status = 'cancelled_by_driver' OR t.status = 'cancelled_by_client' THEN 1 END) / COUNT(t.id)::numeric, 2) AS "Cancellation Rate" --noqa: RF05
FROM Trips AS t
LEFT JOIN
    Users AS u1
    ON t.client_id = u1.users_id
LEFT JOIN
    Users AS u2
    ON t.driver_id = u2.users_id
WHERE u1.banned != 'Yes' AND u2.banned != 'Yes' AND t.request_at BETWEEN '2013-10-01' AND '2013-10-03' 
GROUP BY t.request_at
