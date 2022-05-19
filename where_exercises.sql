-- 1. Create a file named where_exercises.sql. Make sure to use the employees database.
	-- completed
use employees; # schema acclimation
show tables; # table/total-data acclimation
describe employees; # (specific table acclimation) in the 'employees' we have four (4) distinct column headers (emp_no, birth_date, first_name, last_name, gender, hire_date)

-- 2. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned.

select count(distinct(emp_no)) from employees; # there are ~300,024 unique employees/emp_no
select count(distinct(emp_no)) from employees where first_name in ("Irena", "Vidya", "Maya"); # 709 records returned
select count(distinct(last_name)) from employees where first_name in ("Irena", "Vidya", "Maya"); # 576 records returned (there's a possibility that there are multiple employees ~133 who share both same first and last name)
select count(first_name) from employees where first_name in ("Irena", "Vidya", "Maya"); 
	-- 709 records of employees whose first name are either "Irena", "Vidya", or "Maya"

-- 3. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of records returned. Does it match number of rows from Q2?
select hire_date from employees;
select extract(month from hire_date) from employees where first_name = "Irena" or first_name = "Vidya" or first_name = "Maya";

-- 4. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned.
select count(distinct(emp_no)) from employees;
select count(distinct(emp_no)) from employees where first_name = "Vidya" and gender = "M"; #151
select count(distinct(emp_no)) from employees where first_name = "Irena" and gender = "M"; #144
select count(distinct(emp_no)) from employees where first_name = "Maya" and gender = "M"; #146
select count(distinct(emp_no)) from employees where first_name = "Irena" and gender = "m" or first_name = "Vidya" and gender = "m" or first_name = "Maya" and gender = "m";
	-- 441 unique records of employees whose name is either "Irena", "Vidya", or "Maya" and who also identify gender as "Male"
    
-- 5. Find all current or previous employees whose last name starts with 'E'. Enter a comment with the number of employees whose last name starts with E.
select count(distinct(emp_no)) from employees where last_name like "e%";
	-- there are 7,330 employees whose last name starts with the letter "E"
    
-- 6. Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. How many employees have a last name that ends with E, but does not start with E?
select count(distinct(emp_no)) from employees where last_name like "e%" or last_name like "%e";
select count(distinct(emp_no)) from employees where last_name like "%e" and last_name not like "e%";
	-- a. there are 30,723 employees whose last name eiher starts or ends with the letter "E"
    -- b. there are 23,393 employees whose last name ends with the letter "E" and does NOT begin with the letter "E"


-- 7. Find all current or previous employees employees whose last name starts and ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E. How many employees' last names end with E, regardless of whether they start with E?

-- 8. Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned.

-- 9. Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.

-- 10. Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned.

-- 11. Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.

-- 12. Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found?