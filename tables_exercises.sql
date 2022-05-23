-- 1. Open MySQL Workbench and login to the database server
-- 2. Save your work in a file named tables_exercises.sql
-- 3. Use the employees database. Write the SQL code necessary to do this.
use employee;

-- 4. List all the tables in the database. Write the SQL code necessary to accomplish this.
 show tables;
 /*
'departments'
'dept_emp'
'dept_manager'
'employees'
'salaries'
'titles'
*/

-- 5. Explore the employees table. What different data types are present on this table?
 describe employees;
/*
"intergers, varchar, enum, date"
*/

-- 6. Which table(s) do you think contain a numeric type column? (Write this question and your answer in a comment)
-- from the schema description, I think "salaries" will contain a 'pure' numeric type columns

-- 7. Which table(s) do you think contain a string type column? (Write this question and your answer in a comment)
-- I think departments, titles, and employees will contain string type columns

-- 8. Which table(s) do you think contain a date type column? (Write this question and your answer in a comment)
-- I think employees, titles, salaries, and dept_emp tables wil contain date type columns

-- 9. What is the relationship between the employees and the departments tables? (Write this question and your answer in a comment)
-- they are both joined by the 'dept_emp' table

-- 10. Show the SQL that created the dept_manager table. Write the SQL it takes to show this as your exercise solution.
show create Table dept_manager;

/*CREATE TABLE `dept_manager` (
`emp_no` int NOT NULL,
`dept_no` char(4) NOT NULL,
`from_date` date NOT NULL,
`to_date` date NOT NULL,
PRIMARY KEY (`emp_no`,`dept_no`),
KEY `dept_no` (`dept_no`),
CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
ENGINE=InnoDB DEFAULT CHARSET=latin1 
*/




-- ---- --

use employees;

show tables;

describe employees;

show create Table dept_manager;
-- CREATE TABLE `dept_manager` (
--   `emp_no` int NOT NULL,
--   `dept_no` char(4) NOT NULL,
--   `from_date` date NOT NULL,
--   `to_date` date NOT NULL,
--   PRIMARY KEY (`emp_no`,`dept_no`),
--   KEY `dept_no` (`dept_no`),
--   CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
--   CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1

describe departments;
-- CREATE TABLE `departments` (
--   `dept_no` char(4) NOT NULL,
--   `dept_name` varchar(40) NOT NULL,
--   PRIMARY KEY (`dept_no`),
--   UNIQUE KEY `dept_name` (`dept_name`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1

describe employees;
-- CREATE TABLE `employees` (
--   `emp_no` int NOT NULL,
--   `birth_date` date NOT NULL,
--   `first_name` varchar(14) NOT NULL,
--   `last_name` varchar(16) NOT NULL,
--   `gender` enum('M','F') NOT NULL,
--   `hire_date` date NOT NULL,
--   PRIMARY KEY (`emp_no`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1

select	* from employees.departments;