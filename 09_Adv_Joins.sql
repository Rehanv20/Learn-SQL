-- Advanced Joins
/* ------------------------------------------------------------------------
Syntax:
		SELECT *
		FROM A
		[TYPE] JOIN B
		ON A.key = B.key
		WHERE <_key IS NULL>
--------------------------------------------------------------------------
Types
1. Left Anti Join - Returns rows from left that has no match in right
2. Right Anti Join - Returns rows from right that has no match in left
3. Full Anti Join - Return only rows that don't match in either table
4. Inner Join
5. Cross Join - Combines every row from left with every row from right 
				All possible combinations [Cartesian Join]
*/

-- 1. Left Anti Join 
-- Task: get all customers who haven't place any order
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL

-- 2. Right Anti Join
-- Task: get all orders without matching customers
SELECT *
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id
WHERE c.id IS NULL

-- Task: get all orders without matching customers (using LEFT JOIN)
SELECT *
FROM orders AS o
LEFT JOIN customers AS c
ON c.id = o.customer_id
WHERE c.id IS NULL 

-- 3. Full Anti Join 
-- Task: Find customers without orders and orders without customers
SELECT *
FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id
WHERE c.id IS NULL OR o.customer_id IS NULL

-- 4. Inner Join
/* Task: Get all customers along with their orders,
   but only for customers who have placed an order 
   without usig INNER JOIN!! */

SELECT * 
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE customer_id IS NOT NULL

-- 5. Cross Join
-- Task: Generate all possible combinations of customers and orders
SELECT *
FROM customers
CROSS JOIN orders