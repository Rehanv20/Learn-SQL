/* DDL Commands
DDL - Data defination language. 
It dosen't give any output it create a new table in our database
In DDL we create table structure not adding any values
*/

-- 1. Create

USE MyDatabase
CREATE TABLE persons(
	id INT NOT NULL,
	person_name VARCHAR(50),
	birth_date DATE,
	phone VARCHAR(15) NOT NULL,
	CONSTRAINT pk_persons PRIMARY KEY(id)
);

-- 2. ALTER
ALTER TABLE persons
ADD email VARCHAR(50) NOT NULL
SELECT * FROM persons

-- 3. DROP
DROP TABLE persons