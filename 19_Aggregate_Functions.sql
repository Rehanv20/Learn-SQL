/* ====================================================================================== 
	Aggregate Functions

	Aggregate Functions allow performing calculations on multiple rows 
	of data to generate summary results.

	 1. Basic Aggregate Functions
        - COUNT
        - SUM
        - AVG
        - MAX
        - MIN
     2. Grouped Aggregations
        - GROUP BY
====================================================================================== */

-- Find the total number of customers
SELECT 
	COUNT(*) AS [Total Orders]
FROM orders

-- Find the tatal sales of all orders
SELECT 
    SUM(sales) AS [Total Sales]
FROM orders

-- Find the average sales of all orders
SELECT
    AVG(sales) AS [AVG Sales]
FROM orders

-- Find the highest sales of all ordes 
SELECT 
    MAX(sales) AS [Highest Sales]
FROM orders


/* ============================================================================== 
   GROUPED AGGREGATIONS - GROUP BY
=============================================================================== */

-- Find the number of orders, total sales, average sales, highest sales, and lowest sales per customer
SELECT
    customer_id,
    COUNT(*) AS total_orders,
    SUM(sales) AS total_sales,
    AVG(sales) AS avg_sales,
    MAX(sales) AS highest_sales,
    MIN(sales) AS lowest_sales
FROM orders
GROUP BY customer_id