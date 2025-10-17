-- All essensitial Clauses

/* Clauses
1. SELECT
2. FROM
3. WHERE
4. ORDER BY
5. GROUP BY 
6. HAVING
7. DISTINCT
8. TOP
*/
/* ======================================================================
1. SELECT : Use to read data inside table
========================================================================= */

-- Retrive all data from customers
SELECT *
FROM customers

-- Retrive all data from orders
SELECT *
FROM orders

-- Task: Retrive each customer name, country, score
SELECT 
	first_name,
	country,
	score
FROM customers

/* ======================================================================
3. WHERE : Filter data based on condition
========================================================================= */

-- Task: Retrive customers with a score not equal to 0
SELECT *
FROM customers
WHERE score != 0

-- Task: Retrive customers from Germany
SELECT *
FROM customers
WHERE country = 'Germany'

/* ======================================================================
4. ORDER BY: Sort the data  
   i. Ascending			ii. Descending
========================================================================= */

/* Task: Reteive all the customers and sort 
   the result by the highest score first */
SELECT *
FROM customers 
ORDER BY score DESC

/* Task: Retrive all the customers and sort 
   the result by the lowest score first */
SELECT *
FROM customers
ORDER BY score ASC

/* Retrive all the customers and sort the result 
   by the country and then by the highest score */
SELECT *
FROM customers
ORDER BY country ASC, score DESC

/* ======================================================================
5. GROUP BY : Combine rows with the same value
			  Aggregates a column By another column
========================================================================= */
-- AS(Alias): Shorthand name (label) assigned to a column or table in a query 

-- Task: Find the total score for each country 
SELECT 
	country,
	SUM(score) AS total_score
FROM customers
GROUP BY country

-- Task: Find the total score and total number of customers for each country
SELECT 
	country,
	SUM(score) AS Total_score,
	COUNT(id) AS Total_customer
FROM customers
GROUP BY country

/* ======================================================================
6. HAVING : Filter the data after the aggregation
========================================================================= */

/* Task: Find the average score for each country 
   considering only customers with score not equal to 0 and
   return only those country which average score greater than 430 */

SELECT 
	country,
	AVG(score) AS avg_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430

/* ======================================================================
7. DISTINCT : Remove Duplicates (Repeated values)
========================================================================= */

-- Task: Return unique list of all countries
SELECT DISTINCT country 
FROM customers

/* ======================================================================
8. TOP (Limit) : Restrict the number of rows returned
========================================================================= */

-- Task: Return the top 3 customers with highest score 
SELECT TOP 3 *
FROM customers 
ORDER BY score DESC

-- Task: Return the top 2 customers with lowest score 
SELECT TOP 2 *
FROM customers
ORDER BY score ASC 

-- Task: Get 2 most recent orders
SELECT TOP 2 *
FROM orders
ORDER BY order_date DESC 