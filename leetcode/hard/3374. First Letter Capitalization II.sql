/*
Question 3374. First Letter Capitalization II
Link: https://leetcode.com/problems/first-letter-capitalization-ii/description/?envType=problem-list-v2&envId=database

Table: user_content

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| content_id  | int     |
| content_text| varchar |
+-------------+---------+
content_id is the unique key for this table.
Each row contains a unique ID and the corresponding text content.
Write a solution to transform the text in the content_text column by applying the following rules:

Convert the first letter of each word to uppercase and the remaining letters to lowercase
Special handling for words containing special characters:
For words connected with a hyphen -, both parts should be capitalized (e.g., top-rated → Top-Rated)
All other formatting and spacing should remain unchanged
Return the result table that includes both the original content_text and the modified text following the above rules.
*/

-- The easiest solution :)

SELECT
    content_id,
    content_text AS original_text,
    INITCAP(content_text) AS converted_text
FROM user_content
