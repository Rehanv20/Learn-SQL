/* ==============================================================================
   SQL Window Aggregate Functions
-------------------------------------------------------------------------------
	1. COUNT()
	2. SUM()
	3. AVG()
	4. MIN()
	5. MAX()
=============================================================================== */


/* =======================================================================
	1. COUNT - Returns the number of rows in a window
========================================================================== */

/* Task 1:
	Find the number of orders 
	Find the number of orders for each customer
	Find the number of orders and provide details such Order ID, Order date
*/
SELECT 
	OrderID,
	OrderDate,
	CustomerID,
	COUNT(*) OVER(PARTITION BY CustomerID) AS Total_Orders
FROM Sales.Orders

/* Task 2:
	Find the total number of customers
	Find the total number of scores
	Additionally provide all customers details
*/
SELECT *,
COUNT(*) OVER() AS Total_Customers,
COUNT(Score) OVER() AS Total_Scores
FROM Sales.Customers

/* Task 3: 
	To check whether the table contain the duplicates
*/
-- Data Quality Issue
-- To check duplicates in primary key by using COUNT

SELECT 
	OrderID,
	COUNT(*) OVER(PARTITION BY OrderID) AS Check_Pk
FROM Sales.Orders

-- Subquery 
SELECT *
FROM (
	SELECT 
		OrderID,
		COUNT(*) OVER(PARTITION BY OrderID) AS Check_Pk
	FROM Sales.OrdersArchive
)t WHERE Check_Pk > 1

/* =======================================================================
	2. SUM - Returns sum of values in a window
========================================================================== */

/* Task 4:
	Find the total sales across all orders
	Find the total sales for each product
	Additionally provide details such as Order ID, Order date
*/
SELECT 
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) OVER() AS Total_Sales,
	SUM(Sales) OVER(PARTITION BY ProductID) AS [Sales by Product]
FROM Sales.Orders


/* PART-TO-WHOLE Analysis : 
	Shows the contribution of each data point to the overall dataset. */

/* Task 5:
	Find the percentage contribution of each Product's sales to the Total sales
*/
SELECT 
	OrderID,
	ProductID,
	Sales,
	SUM(Sales) OVER() AS Total_Sales,
	CONCAT (ROUND (CAST (Sales AS FLOAT) / SUM(Sales) OVER() * 100, 2) , '%') AS [Percent to total]
FROM Sales.Orders


/* =======================================================================
	3. AVG - Returns average of values in a window
========================================================================== */

/* Task 6:
	Find the average score across all orders
	Find the average score for each product
	Additionally provide details such Order Id, Order date
*/
SELECT 
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	AVG(Sales) OVER() AS Avg_Sales,
	AVG(Sales) OVER(PARTITION BY ProductID) AS [Sales by Product]
FROM Sales.Orders

/* Task 7:
	Find the average scores of customers
	Additionally provide details such Customer Id and Last Name
*/
SELECT 
	CustomerID,
	LastName,
	Score,
	COALESCE(Score, 0) AS Customer_Score,
	AVG(Score) OVER() AS AVG_Score,
	AVG(COALESCE(Score, 0)) OVER() AS [Avg score without NULL]
FROM Sales.Customers

/* Task 8:
	Find all orders where the sales is higher than the average sales across all orders 
*/
SELECT *
FROM (
SELECT 
	OrderID,
	ProductID,
	CustomerID,
	Sales,
	AVG(Sales) OVER() AS Avg_Sales
FROM Sales.Orders
)t WHERE Sales > Avg_Sales

/* =======================================================================
	4. MIN - Returns the minimum value in a window
	5. MAX - Returns the maximum value in a window
========================================================================== */

/* Task 9:
	Find the highest and lowest sales for all orders 
	Find the highest and lowest sales for each product
	Additionally provide details such Order Id, Order date
*/
SELECT 
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	MAX(Sales) OVER() Maximum_Sales,
	MIN(Sales) OVER() Minimum_Sales,
	MAX(Sales) OVER (PARTITION BY ProductID) Maximum_Sales,
	MIN(Sales) OVER (PARTITION BY ProductID) Minimum_Sales
FROM Sales.Orders

/* Task 10:
	Show the employees who have highest salary
*/
SELECT *
FROM (
	SELECT *,
		MAX(Salary) OVER() AS Highest_Salary
	FROM Sales.Employees
)t WHERE Salary = Highest_Salary

/* Task 11:
	Find the deviation for each sales from the minimum and the maximum sales amount. 
*/
SELECT 
	OrderID, 
	ProductID,
	Sales,
	MIN(Sales) OVER() AS Min_Sales,
	MAX(Sales) OVER() AS Max_Sales,
	Sales - MIN(Sales) OVER() AS [Deviation from Min],
	MAX(Sales) OVER() - Sales AS [Deviation from Max]
FROM Sales.Orders

/* Task 12:
	Calculate moving average of sales for each product over time
*/
SELECT 
	OrderID,
	ProductID,
	OrderDate,
	Sales,
	AVG(Sales) OVER(PARTITION BY ProductID) AS [Avg by Product],
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) AS [Moving Avg]
FROM Sales.Orders

/* Task 13:
	Calculate moving average of sales for each product over time, including only the next order.
*/
SELECT 
	OrderID,
	ProductID,
	OrderDate,
	Sales,
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS [Moving Avg]
FROM Sales.Orders