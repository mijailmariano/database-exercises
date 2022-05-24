-- Create a file named temporary_tables.sql to do your work for this exercise.
--  completed
-- 1. Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. 
-- Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.
use kalpana_1823;
drop table employees_with_departments;

use employees;
create temporary table kalpana_1823.employees_with_departments as (
select first_name,
last_name,
dept_name 
from employees 
join dept_emp using (emp_no)
join departments using (dept_no)
where dept_emp.to_date > now());

use kalpana_1823;
select *
from employees_with_departments;


-- a. Add a column named full_name to this table. 
-- It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns

describe employees_with_departments;
alter table employees_with_departments add full_name varchar(30);
select *
from employees_with_departments;

-- b. Update the table so that full name column contains the correct data

update employees_with_departments set full_name = concat(first_name, " ", last_name);
select *
from employees_with_departments;

-- c. Remove the first_name and last_name columns from the table.

alter table employees_with_departments drop column first_name;
alter table employees_with_departments drop column last_name;
select *
from employees_with_departments;

-- d. What is another way you could have ended up with this same table?

/*
When initially defining my temporary table and carrying data over from the 'employees' schema, I could have <SELECT> 'concat' function first_name, last_name as 'full_name.' 
This would have eliminated 2-3 steps e.g., adding a 'new column' and dropping the first & last name columns from my temp. table.
*/

-- 2. Create a temporary table based on the payment table from the sakila database.
drop table payment_copy;
use sakila;
describe payment;
create temporary table kalpana_1823.payment_copy as (
select *
from payment);

-- a. Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.

use kalpana_1823;
select *
from payment_copy;

alter table payment_copy modify amount INTEGER;

select *
from payment_copy;

update payment_copy set amount = amount * 100; 
alter table payment_copy change column amount amount_in_cents INT not null;

select *
from payment_copy;

-- 3. Find out how the current average pay in each department compares to the overall current pay for everyone at the company. 
-- In order to make the comparison easier, you should use the Z-score for salaries. 
-- In terms of salary, what is the best department right now to work for? The worst?

use employees;

SELECT salary, 
(salary - ((SELECT AVG(salary) FROM salaries)) / (SELECT stddev(salary) FROM salaries)) AS zscore 
FROM salaries;


-- 4. Hint Consider that the following code will produce the z score for current salaries.
-- Returns the historic z-scores for each salary
-- Notice that there are 2 separate scalar subqueries involved
-- SELECT salary,
--     (salary - (SELECT AVG(salary) FROM salaries))
--     /
--     (SELECT stddev(salary) FROM salaries) AS zscore
-- FROM salaries;

-- BONUS To your work with current salary zscores, determine the overall historic average departement average salary, the historic overall average, and the historic zscores for salary. 
-- Do the zscores for current department average salaries tell a similar or a different story than the historic department salary zscores?
-- */