/*
Question 3570. Find Books with No Available Copies
Link: https://leetcode.com/problems/find-books-with-no-available-copies/description/?envType=problem-list-v2&envId=database

Table: library_books

+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| book_id          | int     |
| title            | varchar |
| author           | varchar |
| genre            | varchar |
| publication_year | int     |
| total_copies     | int     |
+------------------+---------+
book_id is the unique identifier for this table.
Each row contains information about a book in the library, including the total number of copies owned by the library.
Table: borrowing_records

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| record_id     | int     |
| book_id       | int     |
| borrower_name | varchar |
| borrow_date   | date    |
| return_date   | date    |
+---------------+---------+
record_id is the unique identifier for this table.
Each row represents a borrowing transaction and return_date is NULL if the book is currently borrowed and hasn't been returned yet.
Write a solution to find all books that are currently borrowed (not returned) and have zero copies available in the library.

A book is considered currently borrowed if there exists a borrowing record with a NULL return_date
Return the result table ordered by current borrowers in descending order, then by book title in ascending order.
*/

WITH br AS (
    SELECT 
        book_id,
        COUNT(book_id) AS current_borrowers
    FROM borrowing_records
    WHERE return_date IS NULL
    GROUP BY book_id
)

SELECT
    lb.book_id,
    lb.title,
    lb.author,
    lb.genre,
    lb.publication_year,
    br.current_borrowers
FROM library_books AS lb
INNER JOIN
    br
    ON lb.book_id = br.book_id
WHERE (lb.total_copies - br.current_borrowers) = 0
ORDER BY br.current_borrowers DESC, lb.title ASC
