-- Exercise Goals
-- Use CASE statements or IF() function to explore information in the employees database
-- Create a file named case_exercises.sql and craft queries to return the results for the following criteria:

-- 1. Write a query that returns all employees, their department number, their start date, their end date, 
-- and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not

use employees;
SELECT 
    employees.first_name AS 'first name',
    employees.last_name AS 'last name',
    departments.dept_no AS 'department number',
    employees.hire_date AS 'start date',
    salaries.to_date AS 'end date',
    IF(salaries.to_date > CURDATE(),
        TRUE,
        FALSE) AS 'is_current_employee'
FROM
    employees
        JOIN
    dept_emp USING (emp_no)
        JOIN
    departments USING (dept_no)
        JOIN
    salaries USING (emp_no)
ORDER BY is_current_employee DESC;


select distinct(emp_no)
from employees;


-- 2. Write a query that returns all employee names (previous and current), 
-- and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name

use employees;
select First_name,
last_name,
case 
when left(last_name, 1) <= "H" then "A-H"
when substr(last_name, 1, 1) <= "Q" then "I-Q"
when left(last_name, 1) <= "Z" then "R-Z"
else last_name
end as "alpha_group"
from employees;

-- -------------- 
#difficulties with the following example query line registering "max bin characters" (e.g., H, Q, Z) 
/*
CASE WHEN last_name between "A%" and "H%" THEN "A-H"
*/

SELECT 
    employees.first_name AS 'first_name',
    employees.last_name AS 'last_name',
    CASE
        WHEN SUBSTR(employees.last_name, 1, 1) BETWEEN 'A' AND 'H' THEN 'A-H'
        WHEN SUBSTR(employees.last_name, 1, 1) BETWEEN 'I' AND 'Q' THEN 'I-Q'
        WHEN SUBSTR(employees.last_name, 1, 1) BETWEEN 'R' AND 'Z' THEN 'R-Z'
        ELSE last_name
    END AS 'Alpha_Group'
FROM
    employees;


-- 3. How many employees (current or previous) were born in each decade?

select min(year(birth_date)) as "oldest_birth_year",
max(year(birth_date)) as "youngest_birth_year"
from employees; # from this query, I understand the oldest birth year is 1952 and the younest birth year is in 1965 which can be classified as two decades 

select
count(case when year(birth_date) between "1950" and "1959" then birth_date else NULL end) as "Born Between 1950-1959",
count(case when year(birth_date) between "1960" and "1969" then birth_date else NULL end) as "Born Between 1960-1969"
from employees;

# what I don't capture but would like to in this query are potential future employees that may fall outside of the 1950-1960s birth years
# here we go...

-- select count(year(birth_date)) as "Count",
-- CASE 
-- when year(birth_date) between "1950" and "1959" then "Born Between 1950-1959"
-- when year(birth_date) between "1960" and "1969" then "Born Between 1960-1969"
-- ELSE "OUTSIDE_RANGE"
-- END AS "Birth_Year_Decade"
-- from employees
-- group by "birth_year_decade";


-- 4. What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

SELECT 
    CASE
        WHEN dept_name IN ('research' , 'development') THEN 'R&D'
        WHEN dept_name IN ('sales' , 'marketing') THEN 'Sales & Marketing'
        WHEN dept_name IN ('Production' , 'Quality Management') THEN 'Prod & QM'
        WHEN dept_name IN ('finance' , 'human resources') THEN 'Finance & HR'
        WHEN dept_name IN ('customer service') THEN 'Customer Service'
        ELSE NULL
    END AS 'DEPT_GROUP',
    AVG(SALARY) AS 'AVG_Group_Salary'
FROM
    departments
        JOIN
    dept_emp USING (dept_no)
        JOIN
    salaries USING (emp_no)
WHERE
    dept_emp.to_date > NOW()
        AND salaries.to_date > NOW()
GROUP BY DEPT_GROUP
ORDER BY AVG_GROUP_SALARY DESC;
	