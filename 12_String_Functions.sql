-- SQL String Functions
/* -----------------------------------------------------------------------------------
1. Manipulation
	- CONCAT
	- UPPER
	- LOWER
	- TRIM
	- REPLACE
2. Calculation
	- LEN
3. String Extraction
	- LEFT
	- RIGHT
	- SUBSTRING
*/ -------------------------------------------------------------------------------------

-- 1. CONCAT() - String Concatenation (Combines multiple strings into one)

-- Task: Show a list of customer's first names together with their country in one column.
SELECT 
	first_name,
	country,
	CONCAT(first_name, '-' ,country) AS name_country
FROM customers 

-- 2. UPPER() and LOWER() - Case Transformation

-- Task: Transform the customer's first name to lowercase
SELECT 
	first_name,
	LOWER(first_name) AS low_name
FROM customers

-- Task: Transform the customer's first name to uppercase
SELECT
	first_name,
	UPPER(first_name) AS upp_name
FROM customers

-- 3. TRIM() - Remove leading and trailing spaces (Whitespace)

-- Task: Find customers whose first name contains leading and trailing spaces
SELECT 
	first_name,
	LEN(first_name) AS len_name,
	LEN(TRIM(first_name)) AS len_trim_name,
	LEN(first_name) - LEN(TRIM(first_name)) AS diff
FROM customers
WHERE LEN(first_name) != LEN(TRIM(first_name)) 

-- 4. Replace 
SELECT
'123-456-7890' AS phone,
REPLACE('123-456-7890', '-', '/') AS new_phone

SELECT
'image.txt' AS file_name,
REPLACE ('image.txt', '.txt', '.png') AS new_filename

/* -----------------------------------------------------------------------
1. Length - Counts how many characters
-------------------------------------------------------------------------- */

-- Task: Calculate the length of each customer's first name
SELECT 
	first_name,
	LEN(first_name) AS len_name
FROM customers


-- 1. LEFT() AND RIGHT() - Extract specific no of char from the Start/End

-- Task: Retireve first two characters of each first name
SELECT 
	first_name,
	LEFT(TRIM(first_name), 2) AS last_2_char
FROM customers

-- Task: Retrive last two characters of each first name
SELECT
	first_name,
	RIGHT(TRIM(first_name), 2) AS last_2_char
FROM customers

-- 2. Substring - Extract part of a string at a specified position.

-- Task: Retrieve a list of customer's first name after removing first character 
SELECT 
	first_name,
	SUBSTRING(TRIM(first_name), 2, LEN(first_name))
FROM customers