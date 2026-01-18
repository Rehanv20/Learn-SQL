/*======================================================================
	SQL Window Ranking Functions
-----------------------------------------------------------------------
	1. ROW_NUMBER() - Assign a unique number to each in a window
	2. RANK() - Assign a rank to each row in a window, with gaps
	3. DENSE_RANK() - Assign a rank to each row in a window, without gaps
	4. NTILE() - Divides the rows into a specified number of 
				 approximately equal groups
======================================================================*/


/*=====================================================================
		ROW_NUMBER() | RANK() | DENSE_RANK()
=======================================================================*/

/* Task 1:
	Rank the orders based on their sales from highest to lowest
*/
SELECT
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) AS SalesRank_rows,
	RANK()       OVER(ORDER BY Sales DESC) AS SalesRank_Rank,
	DENSE_RANK() OVER(ORDER BY Sales DESC) AS SalesRank_Dense
FROM Sales.Orders

/* Task 2:
	Use Case | TOP-N-Analysis
	Find the top highest sales for each product
*/
SELECT *
FROM (
	SELECT
		OrderID,
		ProductID,
		Sales,
		ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) AS Rank_by_Product
	FROM Sales.Orders
) t WHERE Rank_by_Product = 1

/* Task 3: 
	Use Case | BOTTOM-N-Analysis
	Find the lowest 2 customers based on their total sales
*/
SELECT *
FROM (
	SELECT 
		CustomerID,
		SUM(Sales) AS Total_Sales,
		RANK() OVER(ORDER BY SUM(Sales)) AS Rank_by_Customer
	FROM Sales.Orders
	GROUP BY CustomerID
)t WHERE Rank_by_Customer <= 2

/* Task 4: 
	Use Case | Assign Unique Id 
	Assgin unique IDs to the rows of 'OrdersArchive' table
*/
SELECT 
	ROW_NUMBER() OVER(ORDER BY OrderID) AS Unique_ID,
	*
FROM Sales.OrdersArchive

/* Task 5:
	Identify duplicate rows in the table 'OrdersArchive'
	and return the clean result withour any duplicates
*/
SELECT *
FROM (
SELECT 
	ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) AS Row_no ,
	*
FROM Sales.OrdersArchive
)t WHERE Row_no = 1


/*=====================================================================
	4. NTILE()
=======================================================================*/

/* Task 6:
	Divide the products into group based on the sales
*/
SELECT 
	OrderID,
	Sales,
	NTILE(1) OVER(ORDER BY Sales DESC) AS One_Bucket,
	NTILE(2) OVER(ORDER BY Sales DESC) AS Two_Bucket,
	NTILE(3) OVER(ORDER BY Sales DESC) AS Three_Bucket,
	NTILE(4) OVER(ORDER BY Sales DESC) AS Four_Bucket,
	NTILE(5) OVER(ORDER BY Sales DESC) AS Five_Bucket
FROM Sales.Orders

/* Use Cases:
	For Data Analyst  : Data Segmentation 
	For Data Engineer : Equalizing load processing
*/
/* Task 7: (Data Segmentation)
	Segment all orders into 3 categories: High, Medium, Low sales
*/
SELECT *,
CASE WHEN Buckets = 1 THEN 'High'
	 WHEN Buckets = 2 THEN 'Medium'
	 WHEN Buckets = 3 THEN 'Low'
END Segmented_Sales
FROM (			
	SELECT
		OrderID,
		Sales,
		NTILE(3) OVER(ORDER BY Sales DESC) AS Buckets
	FROM Sales.Orders
)t 

/* Task 8: (Equalizing load processing)
	In order to export the data, divide the orders into 2 groups.
*/
SELECT 
	NTILE(2) OVER(ORDER BY OrderID) AS Buckets,
	*
FROM Sales.Orders


/* ============================================================
   SQL WINDOW RANKING | CUME_DIST
   ============================================================ */

/* TASK 9:
   Find Products that Fall Within the Highest 40% of the Prices
*/
SELECT 
    Product,
    Price,
    DistRank,
    CONCAT(DistRank * 100, '%') AS DistRankPerc
FROM (
    SELECT
        Product,
        Price,
        CUME_DIST() OVER (ORDER BY Price DESC) AS DistRank
    FROM Sales.Products
) AS PriceDistribution
WHERE DistRank <= 0.4;