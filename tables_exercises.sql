-- 3. use employees;
-- 4. show tables;
-- 5.  describle employees;
        -- intergers, varchar, enum, date
-- 6. from the description of the employees schema, I believe employee_ID will contain a 'pure' numeric value
-- 7. from the description of the employees schema, I believe first_name & last_name will contain a string values
-- 8. from the description of the employees schema, I birth_date & hire_date will contain a date values
-- 9. joined by 'dept_emp' table
-- 10. show create Table dept_manager;

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