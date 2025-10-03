-- 2. UPDATE 
-- Used to update the existing data 
/* Syntax: 
UPDATE table_name
SET column1 = value1
	column2 = value2
WHERE <condition> 
*/
-- Task : Change the score of customer 6 to 0

UPDATE customers
SET score = 0
WHERE id = 6

-- Task : Change score of customer 10 to 0 and country to UK
UPDATE customers
SET score = 0,
	country = 'UK'
WHERE id = 10

/* Task : Update all customers with NULL score 
by setting their score to 0 */

UPDATE customers
SET score = 0
WHERE score IS NULL

SELECT * 
FROM customers
WHERE score IS NULL

-- 3. DELETE 
/* Syntax: 
DELETE FROM table_name
WHERE <condition> */

-- Delete all customers with an ID greater than 5
DELETE FROM customers
WHERE id > 5

-- DELETE all data from table persons
/* For deleting whole data from table we use TRUNCATE 
it is way faster than DELETE command*/

TRUNCATE TABLE persons
