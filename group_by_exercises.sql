-- 1. Create a new file named group_by_exercises.sql
		# complete

-- 2. In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.
use titles;
describe titles;

SELECT 
    COUNT(DISTINCT (title))
FROM
    titles;

		SELECT 
    last_name
FROM
    employees
WHERE
    last_name LIKE 'e%e'
GROUP BY last_name;

		SELECT 
    COUNT(DISTINCT (last_name))
FROM
    employees
WHERE
    last_name LIKE 'e%e';SELECT 
    first_name, last_name
FROM
    employees
WHERE
    last_name LIKE 'e%e'
GROUP BY first_name , last_name;

SELECT 
    COUNT(DISTINCT (first_name))
FROM
    employees
WHERE
    last_name LIKE 'e%e';


-- 5. Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.

SELECT 
    first_name, last_name
FROM
    employees
WHERE
    last_name LIKE '%q%'
        AND last_name NOT LIKE '%qu%';SELECT 
    COUNT(last_name), last_name
FROM
    employees
WHERE
    last_name LIKE '%q%'
        AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

/*
		'189','Chleq'
		'190','Lindqvist'
		'168','Qiwen'
*/



SELECT 
    first_name, gender, COUNT(*)
FROM
    employees
WHERE
    first_name IN ('Irena' , 'Vidya', 'Maya')
GROUP BY first_name , gender
ORDER BY first_name ASC;

/*
		'Irena','M','144'
		'Irena','F','97'
		'Maya','M','146'
		'Maya','F','90'
		'Vidya','M','151'
		'Vidya','F','81'
*/

SELECT 
    LOWER(CONCAT(SUBSTR(first_name, 1, 1),
                    SUBSTR(last_name, 1, 4),
                    '_',
                    DATE_FORMAT(birth_date, '%m'),
                    DATE_FORMAT(birth_date, '%y'))) AS username,
    COUNT(*) AS number_of_username
FROM
    employees
GROUP BY username
ORDER BY number_of_username DESC;


-- b. Are there any duplicate usernames?

	SELECT 
    LOWER(CONCAT(SUBSTR(first_name, 1, 1),
                    SUBSTR(last_name, 1, 4),
                    '_',
                    DATE_FORMAT(birth_date, '%m'),
                    DATE_FORMAT(birth_date, '%y'))) AS username,
    COUNT(*) AS number_of_same_username
FROM
    employees
GROUP BY username
HAVING number_of_same_username > 1;
		

        
/* 
'sghal_1263','2','Sarita','Ghalwash','1963-12-08'
'hnego_0763','2','Holgard','Negoita','1963-07-19'
'pacto_0558','2','Pragnesh','Acton','1958-05-12'
'sgide_0763','2','Shim','Gide','1963-07-10'
'tcrom_0563','2','Tonny','Cromarty','1963-05-07'
'pgran_1156','2','Pintsang','Granlund','1956-11-25' 
*/

        

-- 9. More practice with aggregate functions:

-- a. Determine the historic average salary for each employee. 
	-- When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.
    describe salaries;
SELECT 
    COUNT(*)
FROM
    salaries
WHERE
    YEAR(to_date) = '9999';SELECT 
    emp_no, AVG(salary)
FROM
    salaries
GROUP BY emp_no; #this "GROUP BY" is returning unique values for non-aggregated columns/arrays; in this case - there would not be the same number of "avg(salary) for employee number"; there would be less salaries than there are employee numbers at potentially different salary grades
    
    -- steps:
		-- select ea./all employees (can be with company or not?)
        -- select and average their historic salary (sum every salary ever earned and devide by total number of unique salary grades)
        -- from 'salaries' database
        -- return this by emp number, historic average
        

-- b. Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count.

use employees;
describe dept_emp;

SELECT 
    COUNT(*)
FROM
    dept_emp;

-- c. Determine how many different salaries each employee has had. This includes both historic and current.
-- d. Find the maximum salary for each employee.
-- e. Find the minimum salary for each employee.
-- f. Find the standard deviation of salaries for each employee.
-- g. Now find the max salary for each employee where that max salary is greater than $150,000.
-- h. Find the average salary for each employee where that average salary is between $80k and $90k.


describe departments;
show create table
departments;

/* 
		CREATE TABLE `departments` (
		  `dept_no` char(4) NOT NULL,
		  `dept_name` varchar(40) NOT NULL,
		  PRIMARY KEY (`dept_no`),
		  UNIQUE KEY `dept_name` (`dept_name`)
		) ENGINE=InnoDB DEFAULT CHARSET=latin1 
*/