-- 3. Range Operator (BETWEEN)
/* Retrive all customers whose score falls in the 
range between 100 and 500 */
SELECT *
FROM customers
WHERE score BETWEEN 100 AND 500

-- Same query using comparison and logical operator (easily understand)
SELECT * 
FROM customers
WHERE score >= 100 AND score <= 500


-- 4. Membership Operators (IN, NOT IN)
-- Retrive all customers from either Germany or USA 
SELECT *
FROM customers
WHERE country IN ('Germany', 'USA')

-- Same query using OR, but IN is easy to use
SELECT * 
FROM customers
WHERE country = 'Germany' OR country = 'USA'


-- 5. Search Operator (LIKE)
-- Task: Retrive all customers whose first name starts with 'M'
SELECT *
FROM customers
WHERE first_name LIKE 'M%'

-- Task: Find all customers whose first name ends with 'n'
SELECT *
FROM customers
WHERE first_name LIKE '%n'

-- Task: Find all customers whose first name contains 'r'
SELECT *
FROM customers
WHERE first_name LIKE '%r%'

-- Task: Find all customers whose first name has 'r' in the 3rd position 
SELECT *
FROM customers
WHERE first_name LIKE '__r%'