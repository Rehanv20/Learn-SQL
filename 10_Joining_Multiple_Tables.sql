-- Joining Multiple Tables - 3 Table Join

/* Task: Using SalesDB, retrive a list of all orders, along with the related 
   customer, product, and employee details. For each order, display:
   Order ID, Customer's name, Product name, Sales, Price, Sales person's name */

USE SalesDB
SELECT 
	o.OrderID,
	o.Sales,
	c.FirstName AS CustomerFirstName,
	c.LastName AS CustomerLastName,
	p.product AS Productname,
	p.Price,
	e.FirstName AS EmployeeFirstName,
	e.LastName As EmployeeLastName

FROM Sales.Orders AS o
LEFT JOIN Sales.Customers AS c
ON o.CustomerID = c.CustomerID

LEFT JOIN Sales.Products AS p
ON o.ProductID = p.ProductID

LEFT JOIN Sales.Employees AS e
ON o.SalesPersonID = e.EmployeeID