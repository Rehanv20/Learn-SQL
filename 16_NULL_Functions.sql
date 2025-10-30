-- SQL NULL Functions
/* =======================================================================
1. For Replace values 
		- ISNULL : Replace NULL with specified value
		- COALESCE : Returns first not-null value from a list
		- NULLIF : Compares two expressions 
2. Check for NULLS : 
		- IS NULL 
		- IS NOT NULL
========================================================================== */

-- COALESCE

/* -----------------------------------------------------------------------
		Handle NULL : Data Aggregation
-------------------------------------------------------------------------- */

-- Task:  Find the average scores of the customers. Use COALESCE to replace NULL Score with 0.
SELECT 
	CustomerID,
	score,
	COALESCE(score, 0) AS score2,
	AVG(score) OVER() AVG_score1,
	AVG(COALESCE(score, 0)) OVER() AVG_score2
FROM Sales.Customers

/* -----------------------------------------------------------------------
		Handle NULL : Mathematical Operation
-------------------------------------------------------------------------- */

/* Task: 
   Display the full name of customers in a single field by merging their
   first and last names, and add 10 bonus points to each customer's score.
*/
SELECT 
	FirstName,
	LastName,
	FirstName + COALESCE(LastName, '') AS FullName,
	Score,
	COALESCE(Score, 0) + 10 AS Bonus
FROM Sales.Customers

/* -----------------------------------------------------------------------
		Handle NULL : JOIN
-------------------------------------------------------------------------- */

-- Task: Sort the customers from lowest to the highest scores, wiht null appearing last 
-- Method 1 : Assign large value to NULL (Lazy - Not too professional)
SELECT 
	CustomerID,
	COALESCE(Score, 99999)
FROM Sales.Customers
ORDER BY COALESCE(Score, 99999) 

/* =======================================================================
	NULLIF 
		Compares two expressions returns:
		- NULL, if they are equal
		- First value, if they are not equal
========================================================================== */

-- Task: Find the sales price for each order by dividing sales by quantity
SELECT 
	OrderID,
	Sales,
	Quantity,
	Sales / NULLIF(Quantity, 0) AS price
FROM Sales.Orders

/* =======================================================================
	IS NULL - Returns TRUE if value is NULL otherwise returns FALSE
	IS NOT NULL - Returns TRUE if value is NOT NULL otherwise returns FALSE
========================================================================== */

-- Task: Identify the customers who have no score
SELECT *
FROM Sales.Customers
WHERE Score IS NULL

-- Task: List all the customers who have scores
SELECT *
FROM Sales.Customers
WHERE Score IS NOT NULL

/* -----------------------------------------------------------------------
		LEFT ANTI JOIN
-------------------------------------------------------------------------- */

-- Task: List all details of customers who have not placed any orders
SELECT 
	c. *,
	o.OrderID
FROM Sales.Customers c
LEFT JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL