-- Joins
/* Joins are used to combine rows from two or more tables 
based on a key column
---------------------------------------------------------------------------
Syntax: 
	SELECT *
	FROM A
	[TYPE] JOIN B    ...Default = INNER
	ON A.Key = B.Key ...<condition>
---------------------------------------------------------------------------
Basic types of Joins:
1. No Join
2. Inner Join
3. Left Join
4. Right Join 
5. Full Join
*/

-- 1. No Join - Return data from table without combining

-- Task: Retrive all data from customers and orders in two diff results
SELECT * 
FROM customers

SELECT * 
FROM orders

-- 2. Inner Join - Return only mtching rows from both tables

/* Task: Get all the customers along with their orders, 
   but only for customers who placed order */
SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
INNER JOIN orders AS o
ON id = customer_id

-- 3. Left Join - Return all rows from left and only matching from right

/* Task: Get all the customers along with their orders,
   including those without orders */
SELECT
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id

-- 4. Right Join - Return all rows from right and only matching from left

/* Task: Get all the customers with their orders,
   including orders without matching customers */
SELECT
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id

/* Task: Get all the customers with their orders,
   including orders without matching customers (Using Left Join) */
SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM orders AS o
LEFT JOIN customers AS c
ON c.id = o.customer_id

-- 5. FUll Join - Return all rows from both tables

-- Task : Get all the customers if there is no match
SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id
