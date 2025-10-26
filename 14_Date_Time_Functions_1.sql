/* -----------------------------------------------------------------------
SQL Date and Time functions

Table of content:
1. Part Extraction Functions
	- DAY : Returns the day from a date
	- MONTH : Returns the month 
	- YEAR : Returns the year 
	- DATEPART : Returns the year 
	- DATANAME : Returns the name of a specific part of a data
	- DATATRUNC : Truncates the date to the specific part
	- EOMONTH : Returns the last day of month
-------------------------------------------------------------------------- */

-- GETDATE() - Returns the current date and time when the query is executed
SELECT 
	OrderID,
	CreationTime,
	GETDATE() AS Today
FROM Sales.Orders 

/* =======================================================================
Part Extraction 
DAY(), MONTH(), YEAR(), DATEPART(), DATENAME(), DATETRUNC(), EOMONTH()
========================================================================== */

SELECT 
	OrderID,
	CreationTime,
	-- EOMONTH Examples
	EOMONTH(CreationTime) EndOfMonth,
	DATETRUNC(month, CreationTime) StartOfMonth,

	-- DATETRUNC Examples
	DATETRUNC(day, CreationTime) Day_dt,
	DATETRUNC(minute, CreationTime) Min_dt,
	DATETRUNC(year, CreationTime) Year_dt,

	-- DATENAME Examples
	DATENAME(month, CreationTime) Month_dn,
	DATENAME(weekday, CreationTime) weekday_dn,
	DATENAME(day, CreationTime) Day_dn,
	DATENAME(year, CreationTime) Year_dn,

	-- DATEPART Examples
	DATEPART(year, CreationTime) Year_dp,
	DATEPART(month, CreationTime) Month_dp,
	DATEPART(day, CreationTime) Day_dp,
	DATEPART(hour, CreationTime) Hour_dp,
	DATEPART(minute, CreationTime) Min_dp,
	DATEPART(second, CreationTime) Second_dp,
	DATEPART(quarter, CreationTime) Quarter_dp,
	DATEPART(week, CreationTime) Week_dp,

	-- Part Extraction using DAY, MONTH, YEAR
	YEAR(CreationTime) Year,
	MONTH(CreationTime) Month,
	DAY(CreationTime) Day
FROM Sales.Orders

/* =======================================================================
	Use cases:
========================================================================== */

-- DATETRUNC 
-- Task: Aggregate orders by year using DATETRUNC on creation time
SELECT
	DATETRUNC(month, CreationTime) Time_dt,
	count(*) order_count
FROM Sales.Orders
GROUP BY DATETRUNC(month, CreationTime)

-- Task: How many orders are placed each year?
SELECT 
	YEAR(OrderDate),
	count(*)
FROM Sales.Orders
GROUP BY YEAR(OrderDate)

-- Task: How many orders are placed each month?
SELECT 
	DATENAME(month, OrderDate) AS Months,
	count(*) AS NofOrders
FROM Sales.Orders
GROUP BY DATENAME(month, OrderDate)

-- Task: Show all the orders from month of february
SELECT * 
FROM Sales.Orders
WHERE MONTH(OrderDate) = 2