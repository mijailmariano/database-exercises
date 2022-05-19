-- 1. Create a file named where_exercises.sql. Make sure to use the employees database.
	-- completed
-- the following sql code is being done to quickly familiarize myself with the data I will be working with
use employees; # schema acclimation
show tables; # table/total-data acclimation
describe employees; # (distinct table acclimation) in the 'employees' we have four (4) distinct column headers (emp_no, birth_date, first_name, last_name, gender, hire_date)

-- 2. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned.

select count(distinct(emp_no)) from employees; # there are ~300,024 unique employees/emp_no
select count(distinct(emp_no)) from employees where first_name in ("Irena", "Vidya", "Maya"); # 709 records returned
select count(distinct(last_name)) from employees where first_name in ("Irena", "Vidya", "Maya"); # 576 records returned (there's a possibility that there are multiple employees ~133 who share both same first and last name)
select count(first_name) from employees where first_name in ("Irena", "Vidya", "Maya"); 
	-- 709 records of employees whose first name are either "Irena", "Vidya", or "Maya"

-- 3. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of records returned. Does it match number of rows from Q2?
select count(distinct(emp_no)) from employees where (first_name = "Irena" and month(hire_date) between "1" and "3") or (first_name = "Vidya" and month(hire_date) between "1" and "3") or (first_name = "Maya" and month(hire_date) between "1" and "3");
	-- 188 employees with either names "Irena", "Vidya", or "Maya" were hire in Q2 months (Jan-Mar)
select count(distinct(emp_no)) from employees where month(hire_date) between "1" and "3"; # this is the total number of entries/employees hired in Q2 

-- 4. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned.
select count(distinct(emp_no)) from employees;
select count(distinct(emp_no)) from employees where first_name = "Vidya" and gender = "M"; #151
select count(distinct(emp_no)) from employees where first_name = "Irena" and gender = "M"; #144
select count(distinct(emp_no)) from employees where first_name = "Maya" and gender = "M"; #146
select count(distinct(emp_no)) from employees where first_name = "Irena" and gender = "m" or first_name = "Vidya" and gender = "m" or first_name = "Maya" and gender = "m";
	-- 441 unique records of employees whose name is either "Irena", "Vidya", or "Maya" and who identify as gender "Male"
    
-- 5. Find all current or previous employees whose last name starts with 'E'. Enter a comment with the number of employees whose last name starts with E.
select count(distinct(emp_no)) from employees where last_name like "e%";
	-- there are 7,330 employees whose last name starts with the letter "E"
    
-- 6. Find all current or previous employees whose last name starts or ends with 'E'. 
	-- a. Enter a comment with the number of employees whose last name starts or ends with E. 
    select count(distinct(emp_no)) from employees where last_name like "e%" or last_name like "%e";
			-- there are 30,723 employees whose last name eiher starts or ends with the letter "E"
	-- b. How many employees have a last name that ends with E, but does not start with E?
select count(distinct(emp_no)) 
from employees 
where last_name like "%e" 
and last_name not like "e%";
			-- there are 23,393 employees whose last name ends with the letter "E" and does NOT begin with the letter "E"

-- 7. Find all current or previous employees employees whose last name starts and ends with 'E'. 
	-- a. Enter a comment with the number of employees whose last name starts and ends with E. 
    select count(distinct(emp_no)) from employees where last_name like "e%" and last_name like "%e";
			-- there are 899 employees whose last name begin and end with the letter "E"
	-- b. How many employees' last names end with E, regardless of whether they start with E?
    select count(distinct(emp_no)) from employees where last_name like "%e";
			-- there are 24,292 employees whose last name end with the letter "E", regardless of first letter in their last name

-- 8. Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned.
select count(distinct(emp_no)) from employees where year(hire_date) between "1990" and "1999";
	-- 135,214 employees had hire dates between 1990-1999 

# can also write as
select count(*)
from employees
where hire_date 
like "199%";

-- 9. Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.
select count(distinct(emp_no)) from employees where month(hire_date) = "12" and day(hire_date) = "25";
	-- 789 employees have birthdays on December 25th (what we know to be known as "Christmas" in the US)

-- 10. Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned.
select count(distinct(emp_no)) from employees where year(hire_date) between "1990" and "1999" and month(hire_date) = "12" and day(hire_date) = "25"; # there has to be a better, more efficient way to code this query
	-- 346 employees had hire dates in the 90's and have a birthday that fall on Christmas day (december 25th)

-- 11. Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.
select count(distinct(emp_no)) from employees where last_name like "%q%";
	-- 1873 employees contain a letter "q" in their last name

-- 12. Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found?
select count(distinct(emp_no)) from employees where last_name like "%qu%"; # I am quering/guaging how many employees have a last name that contain the letters "qu" in this order (1326)
select count(distinct(emp_no)) from employees where last_name like "%q%" and last_name not like "%qu%";
	-- 547 employees have a letter "q" in there name but do NOT have a "qu" letter pattern in their last name

