/* =================================================================
CASE Statement
------------------------------------------------------------------

Structure:
	CASE
		WHEN condition 1 THEN result 1
		WHEN condition 2 THEN result 2
		...
		ELSE result
	END
------------------------------------------------------------------
Use Cases:
	 1. Categorize Data
     2. Mapping
     3. Quick Form of Case Statement
     4. Handling Nulls
     5. Conditional Aggregation
================================================================= */


/* ==============================================================================
   USE CASE: CATEGORIZE DATA
===============================================================================*/

/* Task 1:
    Generate the report showing the total sales for each category:
	- High: Sales over 50
	- Medium: Sales between 20 and 50
	- Low: Sales 20 or less
	Sort the result from lowest to highest.
*/
SELECT 
	Category,
	SUM(Sales) AS Total_sales
FROM(
SELECT 
	OrderID,
	Sales,
	CASE
		WHEN Sales > 50 THEN 'High'
		WHEN Sales > 20 THEN 'Medium'
		ELSE 'Low'
	END category
FROM Sales.Orders
)t
GROUP BY category
ORDER BY SUM(Sales) DESC


/* ==============================================================================
   USE CASE: MAPPING DATA
===============================================================================*/

/* Task 2: 
	Retrive employee details with gender displayed as full text
*/
SELECT 
	EmployeeID
	FirstName, 
	LastName,
	Gender,
	CASE
		WHEN Gender = 'M' THEN 'Male'
		WHEN Gender = 'F' THEN 'Female'
		ELSE 'Not available'
	END [Gender Full Text]
FROM Sales.Employees

/* Task 4: 
	Retrive employee details with abbreviated country code
*/
SELECT 
	CustomerID,
	FirstName,
	LastName,
	Country,
	CASE 
		WHEN Country = 'Germany' THEN 'DE'
		WHEN Country = 'USA'	 THEN 'US'
		ELSE 'N/A'
	END CountryAbb1
FROM Sales.Customers


/* ==============================================================================
   QUICK FORM SYNTAX
===============================================================================*/
/* Task 5: 
	Retrive employee details with abbreviated country code
*/

SELECT 
	CustomerID,
	FirstName,
	LastName,
	Country,

	-- Full Form
	CASE 
		WHEN Country = 'Germany' THEN 'DE'
		WHEN Country = 'USA'	 THEN 'US'
		ELSE 'N/A'
	END CountryAbb1,

	-- Quick Form
	CASE country
		WHEN 'Germany' THEN 'DE'
		WHEN 'USA' THEN 'US'
	END CountryAbb2

FROM Sales.Customers

/* ==============================================================================
   HANDLING NULLS
===============================================================================*/

/* NULLs : NULLs are can lead to inaccurate results 
		   which can lead to wrong decision making. */

/* Task 6: 
	Find the average scores of customers and treat NULL as 0.
	Add additional provide details such as CustomersID & LastName
*/

SELECT
    CustomerID,
    LastName,
    Score,
    CASE
        WHEN Score IS NULL THEN 0
        ELSE Score
    END AS ScoreClean,

    AVG(
        CASE
            WHEN Score IS NULL THEN 0
            ELSE Score
        END
    ) OVER () AS AvgCustomerClean,

    AVG(Score) OVER () AS AvgCustomer
FROM Sales.Customers;


/* ==============================================================================
   CONDITIONAL AGGREGATION
===============================================================================*/

-- Apply aggregate functions only on subsets of data that fulfill certain conditions

/* Task 7
	Count how many times each customer has made an order 
	with sales greater than 30
*/

SELECT 
	CustomerID,
	SUM(CASE 
		WHEN Sales > 30 THEN 1
		ELSE 0
	END) TotalOrders_Sale,
	COUNT(*) AS Total_Orders
FROM Sales.Orders
GROUP BY CustomerID
