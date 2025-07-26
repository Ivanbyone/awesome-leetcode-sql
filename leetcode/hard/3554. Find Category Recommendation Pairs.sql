/*
Question 3554. Find Category Recommendation Pairs
Link: https://leetcode.com/problems/find-category-recommendation-pairs/description/?envType=problem-list-v2&envId=database

Table: ProductPurchases

+-------------+------+
| Column Name | Type | 
+-------------+------+
| user_id     | int  |
| product_id  | int  |
| quantity    | int  |
+-------------+------+
(user_id, product_id) is the unique identifier for this table. 
Each row represents a purchase of a product by a user in a specific quantity.
Table: ProductInfo

+-------------+---------+
| Column Name | Type    | 
+-------------+---------+
| product_id  | int     |
| category    | varchar |
| price       | decimal |
+-------------+---------+
product_id is the unique identifier for this table.
Each row assigns a category and price to a product.
Amazon wants to understand shopping patterns across product categories. Write a solution to:

Find all category pairs (where category1 < category2)
For each category pair, determine the number of unique customers who purchased products from both categories
A category pair is considered reportable if at least 3 different customers have purchased products from both categories.

Return the result table of reportable category pairs ordered by customer_count in descending order, and in case of a tie, by category1 in ascending order lexicographically, and then by category2 in ascending order.
*/

SELECT
    p1.category AS category1,
    p2.category AS category2,
    COUNT(DISTINCT pp2.user_id) AS customer_count
FROM ProductInfo AS p1
CROSS JOIN ProductInfo AS p2
RIGHT JOIN --noqa: CV08
    ProductPurchases AS pp1
    ON p1.product_id = pp1.product_id
RIGHT JOIN --noqa: CV08
    ProductPurchases AS pp2
    ON p2.product_id = pp2.product_id AND pp1.user_id = pp2.user_id
WHERE p1.category < p2.category
GROUP BY p1.category, p2.category
HAVING COUNT(DISTINCT pp2.user_id) >= 3
ORDER BY customer_count DESC, p1.category  ASC, p2.category ASC
