/*
Question 608. Tree Node
Link: https://leetcode.com/problems/tree-node/description/?envType=problem-list-v2&envId=database

Table: Tree

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| p_id        | int  |
+-------------+------+
id is the column with unique values for this table.
Each row of this table contains information about the id of a node and the id of its parent node in a tree.
The given structure is always a valid tree.
 

Each node in the tree can be one of three types:

"Leaf": if the node is a leaf node.
"Root": if the node is the root of the tree.
"Inner": If the node is neither a leaf node nor a root node.
Write a solution to report the type of each node in the tree.

Return the result table in any order.
*/

SELECT
    t.id,
    (CASE
        WHEN t.p_id IS NULL THEN 'Root'
        WHEN t.id IN (
            SELECT DISTINCT t1.p_id
            FROM Tree AS t1
        ) THEN 'Inner'
        ELSE 'Leaf'
    END) AS type --noqa: RF04
FROM Tree AS t
