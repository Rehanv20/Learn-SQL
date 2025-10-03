-- WHERE Operators
-- 1. Comparison (=, <>, !=, >, >=, <, <=)

-- Task: Retrive all customers from Germany
SELECT * 
FROM customers
WHERE country = 'Germany'

-- Task: Retrive all customers not from Germany
SELECT *
FROM customers
WHERE country !=  'Germany'

-- Task: Retrive all customers with a score greater than 500
 SELECT * 
 FROM customers
 WHERE score > 500

 -- Task: Retrive all customers with a score 500 or more
 SELECT * 
 FROM customers
 WHERE score >= 500

 -- Task: Retrive all customers with a score less than 500
 SELECT * 
 FROM customers
 WHERE score < 500

-- Task: Retrive all customers with a score 500 or less
SELECT *
FROM customers
WHERE score <= 500


-- 2. Logical Operators (AND, OR, NOT)

/* Task: Retrive all customers who are from USA 
and have a score greater than 500 */
SELECT *
FROM customers
WHERE country = 'USA' AND score > 500

/* Task: Retrive all customers either form USA 
or have a score greater than 500 */
SELECT * 
FROM customers
WHERE country = 'USA' OR score > 500

/* Retrive all customers with a score not less than 500 */
SELECT *
FROM customers
WHERE NOT score < 500