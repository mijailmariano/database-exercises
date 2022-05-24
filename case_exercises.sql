-- Exercise Goals
-- Use CASE statements or IF() function to explore information in the employees database
-- Create a file named case_exercises.sql and craft queries to return the results for the following criteria:

-- 1. Write a query that returns all employees, their department number, their start date, their end date, 
-- and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not

use employees;
select employees.first_name as "first name", 
employees.last_name as "last name",
departments.dept_no as "department number",
employees.hire_date as "start date",
salaries.to_date as "end date",
if(salaries.to_date > curdate(), True, False) as "is_current_employee"
from employees
join dept_emp using (emp_no)
join departments using (dept_no)
join salaries using (emp_no)
order by is_current_employee desc;



-- 2. Write a query that returns all employee names (previous and current), 
-- and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name

select employees.first_name as "first_name",
employees.last_name as "last_name",
case 
when employees.last_name between "A%" and "H%" then "A-H"
when employees.last_name between "I%" and "Q%" then "I-Q"
when employees.last_name between "R%" and "Z%" then "R-Z"
else last_name
end as "alpha_group"
from employees;

#why is this query not registering the first letter of certain last names?

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
	