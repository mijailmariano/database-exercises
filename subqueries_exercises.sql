-- Create a file named subqueries_exercises.sql and craft queries to return the results for the following criteria:

-- 1. Find all the current employees with the same hire date as employee 101010 using a sub-query.
SELECT 
    first_name, last_name
FROM
    employees
WHERE
    hire_date = (SELECT 
            hire_date
        FROM
            employees
        WHERE
            emp_no LIKE '101010')
and (select emp_no from titles where to_date > now());


SELECT 
    first_name, last_name
FROM
    employees
        JOIN
    dept_emp AS de USING (emp_no)
WHERE
    de.to_date > NOW()
        AND hire_date = (SELECT 
            hire_date
        FROM
            employees
        WHERE
            emp_no LIKE '101010');


-- 2. Find all the titles ever held by all current employees with the first name Aamod.

SELECT DISTINCT
    (title) AS 'titles_held'
FROM
    titles
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            employees
        WHERE
            first_name LIKE 'aamod')
        AND to_date > NOW();

-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.

#if an employee number "emp_no" is not tied to either "title" or "salary" it therefore implies they are not longer working with the company
#the question is asking for a total/aggregrate number of those no longer working with the company

#my approach
SELECT 
    count(emp_no) 
FROM
    employees
WHERE
    emp_no not IN (SELECT 
            emp_no
        FROM
            titles
        WHERE
            to_date > NOW());

SELECT 
    COUNT(*)
FROM
    employees
WHERE
    emp_no NOT IN (SELECT 
            emp_no
        FROM
            dept_emp
        WHERE
            to_date > NOW()); 



-- 4. Find all the current department managers that are female. List their names in a comment in your code.

SELECT 
    first_name, last_name
FROM
    employees
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            dept_manager
        WHERE
            to_date > NOW())
        AND gender LIKE 'f'
ORDER BY last_name ASC;

/*
'Leon','DasSarma'
'Hilary','Kambil'
'Isamu','Legleitner'
'Karsten','Sigstam'
*/

-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.

#historical average salary =

select avg(salary)
from salaries;

select count(distinct(emp_no))
from salaries
where salary > (select avg(salary)
from salaries)
and to_date > now();

-- 154543


SELECT 
    first_name, last_name
FROM
    employees
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            titles
        WHERE
            to_date > NOW())
        AND emp_no > (SELECT 
            AVG(salary)
        FROM
            salaries)
ORDER BY last_name , first_name ASC;

-- 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
-- Hint You will likely use multiple subqueries in a variety of ways
-- Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. You will use this number (or the query that produced it) in other, larger queries.

select count(emp_no)
from salaries
where to_date > now() 
and salary > 
((select max(salary) from salaries where to_date > now()) - ((select std(salary) from salaries where to_date > now())));

# there are 83 salaries that fall within one (1) standard deviation of the current highest salary

#total number of current salaries =
select count(*) from salaries 
where to_date > now();

select (select count(emp_no)
from salaries
where to_date > now() 
and salary > ((select max(salary) from salaries where to_date > now())) - ((select std(salary) from salaries where to_date > now()))) / (select count(*) from salaries 
where to_date > now()) * 100 as "percentage_of_total_salaries"

# current salaries within one (1) standard deviation of the highest salary make-up ~0.04% of total salaries 



-- BONUS
-- Find all the department names that currently have female managers
-- Find the first and last name of the employee with the highest salary
-- Find the department name that the employee with the highest salary works in.