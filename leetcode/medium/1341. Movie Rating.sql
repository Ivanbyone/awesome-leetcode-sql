/*
Question 1341. Movie Rating
Link: https://leetcode.com/problems/movie-rating/description/

Table: Movies

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| title         | varchar |
+---------------+---------+
movie_id is the primary key (column with unique values) for this table.
title is the name of the movie.
 

Table: Users

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| name          | varchar |
+---------------+---------+
user_id is the primary key (column with unique values) for this table.
The column 'name' has unique values.
Table: MovieRating

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| user_id       | int     |
| rating        | int     |
| created_at    | date    |
+---------------+---------+
(movie_id, user_id) is the primary key (column with unique values) for this table.
This table contains the rating of a movie by a user in their review.
created_at is the user's review date. 
 

Write a solution to:

Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.
*/

SELECT name AS results 
FROM (
    SELECT u.name
    FROM MovieRating AS m
    LEFT JOIN 
        Users AS u
        ON m.user_id = u.user_id
    GROUP BY u.name
    ORDER BY COUNT(m.user_id) DESC, u.name ASC
    LIMIT 1
)

UNION ALL

SELECT title as results --noqa: CP01
FROM (
    SELECT m.title
    FROM MovieRating AS mr
    LEFT JOIN 
        Movies AS m
        ON mr.movie_id = m.movie_id
    WHERE mr.created_at BETWEEN '2020-02-01' AND '2020-02-29'
    GROUP BY m.title
    ORDER BY AVG(mr.rating) DESC, m.title ASC
    LIMIT 1
)
