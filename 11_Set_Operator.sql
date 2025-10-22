-- SET Operators
--------------------------------------------------------------------------
/* Rules:
1) ORDER BY can be used only once
2) Same no of columns
3) Matching Data Types 
4) Same order of columns
5) First Query controls Aliases
6) Mapping correct columns
--------------------------------------------------------------------------- */

-- 1. UNION - Returns all distinct rows form both queries

-- Task: Combine the data from employees and customers into one table
SELECT 
	FirstName,
	LastName
FROM sales.Customers
UNION
SELECT 
	FirstName,
	LastName
FROM sales.Employees

-- 2. UNION ALL - Returns all distinct rows from both queries

/* Task: Combine the data from employees and customers into one table including duplicates */
SELECT 
	FirstName,
	LastName
FROM sales.Customers
UNION ALL
SELECT 
	FirstName,
	LastName
FROM sales.Employees

/* 3. EXCEPT / MINUS : Returns all distinct rows from the first query 
   that are not found in the second query */

-- Task: Find employees who are not customers at the same time
SELECT 
	FirstName,
	LastName
FROM sales.Employees
EXCEPT
SELECT 
	FirstName,
	LastName
FROM sales.Customers

-- 4. INTERSECT - Returs only matching rows from both tables

-- Task: Find the employees, who are also customers
SELECT 
	FirstName,
	LastName
FROM sales.Employees
INTERSECT 
SELECT 
	FirstName,
	LastName
FROM sales.Customers


/* Bonus Task: Orders data stored in separate tables (Ordes and OrdesArchive).
   Combine all orders data into one report without duplicates. */
SELECT 
	'Orders' AS SourceTable
	,[OrderID]
	,[ProductID]
	,[CustomerID]
	,[SalesPersonID]
	,[OrderDate]
	,[ShipDate]
	,[OrderStatus]
	,[ShipAddress]
	,[BillAddress]
	,[Quantity]
	,[Sales]
	,[CreationTime]
FROM sales.Orders
UNION
SELECT 
	'OrderArchive' AS SourceTable
	,[OrderID]
    ,[ProductID]
    ,[CustomerID]
    ,[SalesPersonID]
    ,[OrderDate]
    ,[ShipDate]
    ,[OrderStatus]
    ,[ShipAddress]
    ,[BillAddress]
    ,[Quantity]
    ,[Sales]
    ,[CreationTime]
FROM sales.OrdersArchive
ORDER BY OrderID