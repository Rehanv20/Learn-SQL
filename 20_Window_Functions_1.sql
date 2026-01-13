/* ==============================================================================
   SQL Window Functions
-------------------------------------------------------------------------------
   SQL window functions enable advanced calculations across sets of rows 
   related to the current row without resorting to complex subqueries or joins.

   Table of Contents:
     1. SQL Window Basics
     2. SQL Window OVER Clause
     3. SQL Window PARTITION Clause
     4. SQL Window ORDER Clause
     5. SQL Window FRAME Clause
     6. SQL Window with GROUP BY
================================================================================== */


/* ==============================================================================
   SQL WINDOW FUNCTIONS | BASICS
===============================================================================*/

/* Task 1 
    Find the total sales across all orders.
*/
SELECT 
    SUM(sales) AS Total_sales
FROM Sales.Orders

/* Task 2 
    Find the total sales for each product.
*/
SELECT 
    ProductID,
    SUM(sales) AS Total_sales
FROM Sales.Orders
GROUP BY ProductID


/* ==============================================================================
   1. OVER CLAUSE
===============================================================================*/

/* TASK 3: 
   Find the total sales across all orders,
   additionally providing details such as OrderID and OrderDate 
*/
SELECT
    OrderID,
    OrderDate,
    ProductID,
    Sales,
    SUM(Sales) OVER () AS Total_Sales
FROM Sales.Orders;


/* ==============================================================================
   2. PARTITION CLAUSE
===============================================================================*/

/* Task 4 
    Find the total sales for each product
    Additionally provide details details such Order Id, Order date
*/
SELECT
    OrderID,
    OrderDate,
    ProductID,
    SUM(sales) OVER(PARTITION BY ProductID) AS Total_Sales
FROM Sales.Orders  

/* Task 5
    Find the total sales across all orders
    Find the total saes for each product
    Find the total sales for each combination of product and order status
    Additionally provide details such Order ID, Order date
*/
SELECT 
    OrderID, 
    OrderDate,
    ProductID,
    OrderStatus,
    Sales,
    SUM(Sales) OVER() Total_Sales,
    SUM(Sales) OVER(PARTITION BY ProductID) [Sales By Product],
    SUM(Sales) OVER(PARTITION BY ProductID, OrderStatus) [Sales by Product & Status]
FROM Sales.Orders


/* ==============================================================================
   3. ORDER BY CLAUSE
===============================================================================*/

/* Task 6
    Rank each order based on their sales from highest to lowest 
    Additionally provide details such Order ID, Order date
*/
SELECT 
    OrderID,
    OrderDate,
    RANK() OVER(ORDER BY Sales DESC) Rank_Sales
FROM Sales.Orders


/* ==============================================================================
   SQL WINDOW FUNCTIONS | FRAME CLAUSE
===============================================================================*/

/* TASK 7: 
   Calculate Total Sales by Order Status for current and next two orders 
*/

SELECT 
    OrderID,
    ProductID,
    OrderDate,
    OrderStatus,
    Sales,
    SUM(sales) OVER(
        PARTITION BY OrderStatus
        ORDER BY OrderStatus
        ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
    ) AS Total_Sales
FROM Sales.Orders

/* TASK 8: 
   Calculate Total Sales by Order Status for current and previous two orders 
*/
SELECT 
    OrderID,
    ProductID,
    OrderDate,
    OrderStatus,
    Sales,
    SUM(Sales) OVER(
        PARTITION BY OrderStatus
        ORDER BY OrderDate
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS Total_Sales
FROM Sales.Orders

/* TASK 9: 
   Calculate Total Sales by Order Status from previous two orders only 
*/
SELECT
    OrderID,
    OrderDate,
    ProductID,
    OrderStatus,
    Sales,
    SUM(Sales) OVER (
        PARTITION BY OrderStatus 
        ORDER BY OrderDate 
        ROWS 2 PRECEDING
    ) AS Total_Sales
FROM Sales.Orders

/* TASK 10: 
   Calculate cumulative Total Sales by Order Status up to the current order 
*/
SELECT 
    OrderID,
    ProductID,
    OrderDate,
    OrderStatus,
    Sales,
    SUM(Sales) OVER(
        PARTITION BY OrderStatus
        ORDER BY OrderDate
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS Total_Sales
FROM Sales.Orders

/* Task 11:
    Rank customers by their Total Sales
*/
SELECT 
    CustomerID,
    SUM(Sales) AS Total_Sales,
    RANK() OVER(ORDER BY SUM(Sales) DESC) AS Ranking
FROM Sales.Orders
GROUP BY CustomerID