-- 1. Copy the order by exercise and save it as functions_exercises.sql.
		-- completed
        
-- 2. Write a query to to find all employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together as a single column named full_name.
use employees;

select concat(first_name, " ", last_name) 
as full_name 
from employees 
where last_name
like "e%e" 
order by full_name asc;

-- 3. Convert the names produced in your last query to all uppercase.

select upper(concat(first_name, " ", last_name))
as full_name 
from employees 
where last_name
like "e%e" 
order by full_name asc;

-- 4. Find all employees hired in the 90s and born on Christmas. Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()),

select round(datediff(curdate(), hire_date)) #here i am calculating and rounding the difference in days from today and employees' hire date
as total_tenure_in_days #here i am creating this new 'table' or column as something more descriptive of the result which in this case is total tenure in days
from employees #i am telling my quary to select/work from the "employees" table 
where hire_date #now in the precise table, i am telling the query to give me back employees' whose hire date was in the 1990s
like "199%"
and month(birth_date) = "12" #from this 90s hire list, i only want to look for/pull-down employees who have birthdays on Christmas or 12-25
and day(birth_date) = "25" #continued from above comment
order by total_tenure_in_days asc; #not needed, yet i want to organize the results by least to most tenured 

-- 5. Find the smallest and largest current salary from the salaries table.

select min(salary), max(salary) 
from salaries;
		-- min salary = 38623
        -- max salary = 158220

-- 6. Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like:

	/* A username should be all lowercase, 
	and consist of the first character of the employees first name, 
	the first 4 characters of the employees last name, 
	an underscore, the month the employee was born, 
	and the last two digits of the year that they were born. */

SELECT 
    LOWER(CONCAT(SUBSTR(first_name, 1, 1),
                    SUBSTR(last_name, 1, 4),
                    '_',
                    DATE_FORMAT(birth_date, '%m'),
                    DATE_FORMAT(birth_date, '%y'))) AS username,
    first_name,
    last_name,
    birth_date
FROM
    employees
LIMIT 10;

-- reg: "date_format" function...conditions are <date> <format> : where "%m" refers to "two-digit" month and "%y" refers to "two-digit" year

		-- my results...

	/*
	'gface_0953','Georgi','Facello','1953-09-02'
	'bsimm_0664','Bezalel','Simmel','1964-06-02'
	'pbamf_1259','Parto','Bamford','1959-12-03'
	'ckobl_0554','Chirstian','Koblick','1954-05-01'
	'kmali_0155','Kyoichi','Maliniak','1955-01-21'
	'apreu_0453','Anneke','Preusig','1953-04-20'
	'tziel_0557','Tzvetan','Zielinski','1957-05-23'
	'skall_0258','Saniya','Kalloufi','1958-02-19'
	'speac_0452','Sumant','Peac','1952-04-19'
	'dpive_0663','Duangkaew','Piveteau','1963-06-01' 
	*/


/*
+------------+------------+-----------+------------+
| username   | first_name | last_name | birth_date |
+------------+------------+-----------+------------+
| gface_0953 | Georgi     | Facello   | 1953-09-02 |
| bsimm_0664 | Bezalel    | Simmel    | 1964-06-02 |
| pbamf_1259 | Parto      | Bamford   | 1959-12-03 |
| ckobl_0554 | Chirstian  | Koblick   | 1954-05-01 |
| kmali_0155 | Kyoichi    | Maliniak  | 1955-01-21 |
| apreu_0453 | Anneke     | Preusig   | 1953-04-20 |
| tziel_0557 | Tzvetan    | Zielinski | 1957-05-23 |
| skall_0258 | Saniya     | Kalloufi  | 1958-02-19 |
| speac_0452 | Sumant     | Peac      | 1952-04-19 |
| dpive_0663 | Duangkaew  | Piveteau  | 1963-06-01 |
+------------+------------+-----------+------------+
10 rows in set (0.05 sec)
*/
