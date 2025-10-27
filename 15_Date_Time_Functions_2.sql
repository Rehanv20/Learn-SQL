/* =======================================================================
Formatting & Casting
	- FORMAT
	- CONVERT
	- CAST
========================================================================== */

-- 1. FORMAT() - Formats a date or time value

SELECT 
	CreationTime,
	FORMAT(CreationTime,'MM-dd-yyyy') USA_Format,
	FORMAT(CreationTime,'dd-MM-yyyy') EU_Format,
	FORMAT(CreationTime, 'dd') dd,
	FORMAT(CreationTime, 'ddd') ddd,
	FORMAT(CreationTime, 'dddd') dddd,
	FORMAT(CreationTime, 'MM') mm,
	FORMAT(CreationTime, 'MMM') mmm,
	FORMAT(CreationTime, 'MMMM') mmmm
FROM Sales.Orders

-- Task: Show CreationTime using the following format:
-- Day Wed Jan Q1 2025 12:34:56 PM

SELECT
	CreationTime,
	'Day ' + FORMAT(CreationTime, 'ddd yyyy ') + 
	'Q' + DATENAME(quarter, CreationTime) + ' ' +
	FORMAT(CreationTime, 'hh:mm:ss tt') AS Custom_Format
FROM Sales.Orders

-- Task: Show how many order each year?
SELECT 
	FORMAT(OrderDate, 'MMM - yy'),
	count(*)
FROM Sales.Orders
GROUP BY FORMAT(OrderDate, 'MMM - yy')


-- 2. CONVERT : Converts a date or time value to differnt data type & format value
SELECT
	CONVERT(INT, '123') AS [String to Int],
	CONVERT(DATE, '2025-10-25') AS [String to Date],
	CreationTime,
	CONVERT(DATE, CreationTime) AS [Datetime to Date]
FROM Sales.Orders

SELECT
	CreationTime,
	CONVERT(DATE, CreationTime) AS [Datetime to date],
	CONVERT(VARCHAR, CreationTime, 32) AS [USA style],
	CONVERT(VARCHAR, CreationTime, 34) AS [EU style]
FROM Sales.Orders

-- 3. CAST : Convert datatype into a specified datatype
SELECT 
CAST('123' AS INT) AS [String to INT],
CAST(123 AS VARCHAR) AS [INT to String],
CAST('2025-10-25' AS DATE) AS [String to DATE],
CreationTime,
CAST(CreationTime AS DATE) AS [CreationTime Only Date]
FROM Sales.Orders
