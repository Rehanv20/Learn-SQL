/* DML Commands
DML - Data Manipulation Language
Use to manipulate data / work with actual data inside table - 
1. INSERT - Add
2. UPDATE - Modify 
3. DELETE - Remove
*/

USE MyDatabase
SELECT * FROM customers

-- 1. INSERT 
INSERT INTO customers (id, first_name, country, score)
VALUES
	(6, 'Ana', 'USA', NULL),
	(7, 'Sam', NULL, 100),
	(8, 'USA', 'Max', NULL),
	(9, 'Andrew', 'Germany', NULL),
	(10, 'Sahra', NULL, NULL)


-- Insert using Select
-- Insert data form 'customers' to 'persons' table
-- Fisrt create a table persons and put the data of customer inside it

CREATE TABLE persons(
	id INT NOT NULL,
	person_name VARCHAR(50),
	birth_date DATE,
	phone VARCHAR(15) NOT NULL,
	CONSTRAINT pk_persons PRIMARY KEY(id)
);

INSERT INTO persons (id, person_name, birth_date, phone)
SELECT 
id,
first_name,
NULL,
'Unknown'
FROM customers

