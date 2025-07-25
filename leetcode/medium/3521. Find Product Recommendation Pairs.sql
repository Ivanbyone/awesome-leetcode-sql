/*
Question 3521. Find Product Recommendation Pairs
Link: https://leetcode.com/problems/find-product-recommendation-pairs/description/?envType=problem-list-v2&envId=database

Table: ProductPurchases

+-------------+------+
| Column Name | Type | 
+-------------+------+
| user_id     | int  |
| product_id  | int  |
| quantity    | int  |
+-------------+------+
(user_id, product_id) is the unique key for this table.
Each row represents a purchase of a product by a user in a specific quantity.
Table: ProductInfo

+-------------+---------+
| Column Name | Type    | 
+-------------+---------+
| product_id  | int     |
| category    | varchar |
| price       | decimal |
+-------------+---------+
product_id is the primary key for this table.
Each row assigns a category and price to a product.
Amazon wants to implement the Customers who bought this also bought... feature based on co-purchase patterns. Write a solution to :

Identify distinct product pairs frequently purchased together by the same customers (where product1_id < product2_id)
For each product pair, determine how many customers purchased both products
A product pair is considered for recommendation if at least 3 different customers have purchased both products.

Return the result table ordered by customer_count in descending order, and in case of a tie, by product1_id in ascending order, and then by product2_id in ascending order.
*/

SELECT 
    p1.product_id AS product1_id,
    p2.product_id AS product2_id,
    p1.category AS product1_category,
    p2.category AS product2_category,
    COUNT(DISTINCT pp1.user_id) AS customer_count
FROM ProductInfo AS p1
CROSS JOIN ProductInfo AS p2
RIGHT JOIN --noqa: CV08
    ProductPurchases AS pp1
    ON p1.product_id = pp1.product_id
RIGHT JOIN --noqa: CV08
    ProductPurchases AS pp2
    ON p2.product_id = pp2.product_id AND pp1.user_id = pp2.user_id
WHERE p1.product_id < p2.product_id
GROUP BY p1.product_id, p2.product_id, p1.category, p2.category
HAVING COUNT(DISTINCT pp1.user_id) >= 3 AND COUNT(DISTINCT pp2.user_id) >= 3
ORDER BY customer_count DESC, p1.product_id ASC, p2.product_id ASC
