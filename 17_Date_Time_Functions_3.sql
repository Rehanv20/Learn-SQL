/*----------------------------------------------------------------------
	DATE CALCULATIONS
	- DATEADD
	- DATEDIFF
----------------------------------------------------------------------- */

-- 1. DATEADD - Add or subtract a specific time interval to/from a date
SELECT 
	OrderDate,
	DATEADD(year, 2, OrderDate) AS [Two Years Later],
	DATEADD(month, 4, OrderDate) AS [Four Months Later],
	DATEADD(day, 5, OrderDate) AS [Five Days Later],
	DATEADD(year, -3, OrderDate) AS [Three Years Before]
FROM Sales.Orders

-- 2. DATEDIFF - Find the differences between the two dates

-- Task: Calculate the age of employees
SELECT 
	EmployeeID,
	BirthDate,
	DATEDIFF(year, BirthDate, GETDATE()) AS Age
FROM Sales.Employees

-- Task: Calculate the average shipping duration in days for each month
SELECT 
	DATENAME(month, OrderDate) AS Months,
	AVG(DATEDIFF(day, OrderDate, ShipDate)) AS Avg_days
FROM Sales.Orders
GROUP BY DATENAME(month, OrderDate)

-- Task: Find the number of days between each order and previous order
SELECT
    OrderID,
    OrderDate AS CurrentOrderDate,
    LAG(OrderDate) OVER (ORDER BY OrderDate) AS PreviousOrderDate,
    DATEDIFF(day, LAG(OrderDate) OVER (ORDER BY OrderDate), OrderDate) AS NrOfDays
FROM Sales.Orders;

/*----------------------------------------------------------------------
	Date Validation
	- ISDATE
	Check if a value is a date.
	Returns 1 if if the string value is a valid date otherwise 0.
----------------------------------------------------------------------- */
SELECT
ISDATE('2025-12-03') Datecheck1,   -- 1
ISDATE('2025') Datecheck2,           -- 1
ISDATE('03-12-2025') Datecheck3,   -- 0
ISDATE('12') Datecheck4            -- 0
USE SalesDB
