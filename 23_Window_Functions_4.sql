/*=============================================================================
	SQL Window Value Function
-------------------------------------------------------------------------------
	1. LEAD			- Returns the value from a previews row 
	2. LAG			- Returns the value from a subsequent row
	3. FIRST_VALUE	- Returns the first value in a window 
	4. LAST_VALUE	- Returns the last value in a window
==============================================================================*/

/*=============================================================================
	1. LEAD 
	2. LAG
===============================================================================*/

/* Task 1:
	Analyze the month-over-month performance by finding the percentage change
	in sales between the current and orevious months
*/
SELECT *,
	[Curent Month Sales] - [Previous Month Sales] AS MOM_Analyze,
	ROUND(
		CAST(([Curent Month Sales] - [Previous Month Sales]) AS Float) 
		/ [Previous Month Sales] * 100, 2
	) AS MoM_Percent
FROM 
(
	SELECT 
		MONTH(OrderDate) Order_Month,
		SUM(Sales) [Curent Month Sales],
		LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) [Previous Month Sales]
	FROM Sales.Orders
	GROUP BY MONTH(OrderDate)
)t 


/* Task 2:
	In order to analyze customer loyalty,
	rank customers based on the average days between their orders.
*/
SELECT 
	CustomerID,
	AVG([Days to next Order]) Avg_Days,
	RANK() OVER(ORDER BY COALESCE(AVG([Days to next Order]), 99999)) Rank_orders
FROM (
	SELECT 
		OrderID,
		CustomerID,
		OrderDate Current_Order,
		LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) Next_Order,
		DATEDIFF(DAY, OrderDate, LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate)) [Days to next Order]
	FROM Sales.Orders
)t GROUP BY CustomerID


/*=============================================================================
	3. FIRST_VALUE
	4. LAST_VALUE
===============================================================================*/

/* Task 3:
	Find the lowest and highest sales for each product.
*/
SELECT 
	CustomerID,
	ProductID,
	Sales,
	-- Lowest Value using FIRST_VALUE
	FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) Lowest_Sales,

	-- Highest Value using LAST_VALUE
	LAST_VALUE(Sales)  OVER(PARTITION BY ProductID ORDER BY Sales
	ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) Highest_Sales,

	-- Highest Value using FIRST_VALUE
	FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales DESC) Highest_Sales_2,

	-- Using MIN & MAX
	MIN(Sales) OVER(PARTITION BY ProductID) Lowest_Sales2,
	MAX(Sales) OVER(PARTITION BY ProductID) Highest_Sales_3

FROM Sales.Orders

/* Task 4:
	Find the lowest and highest sales for each product
	Find the difference in the sales between the currrent and the lowest sales
*/
SELECT 
	CustomerID,
	ProductID,
	Sales,
	FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) Lowest_Sales,
	LAST_VALUE(Sales)  OVER(PARTITION BY ProductID ORDER BY Sales
	ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) Highest_Sales,
	Sales - FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) Sales_Diff
FROM Sales.Orders