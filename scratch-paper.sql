# sql assessmen May 25th

use employees;
select concat(first_name, emp_no) as something
from employees
where last_name like "ma%";

select now();

SELECT * FROM employees 
ORDER BY last_name DESC, n;

describe employees;

select first_name, count(*)
from employees
group by birth_date;
SELECT SUBSTR("Data Scienterrific", 10, LENGTH("Data Scienterrific"));


select *
from employees
left join dept_emp on dept_emp.emp_no = employees.emp_no;

select concat(first_name, " ", last_name) as fullname
from employees;

select first_name, 
last_name, 
dept_no
from employees
join 
dept_emp
on employees.emp_no =
dept_emp.emp_no;

select *
from departments
order by dept_no;

select dept_no,
dept_name
from departments
order by dept_no;


select avg(n),
min(n),
max(n),
std(n)
from numbers;

select avg(salary),
min(salary),
max(salary),
sum(salary),
std(salary)
from salaries;

select distinct(last_name)
from employees;

select count(distinct(last_name))
from employees;

select dept_no,
from_date,
employees.emp_no
from employees
join
dept_emp on employees.emp_no = dept_emp.emp_no;


select
distinct(make),
count(make)
from cars


select distinct(last_name)
from employees;

select distinct(last_name),
count(last_name)
from employees
group by last_name
order by count(last_name) desc;

-- 5. Find the current salary of all current managers
-- example output:
/*
Department Name    | Name              | Salary
-------------------+-------------------+-------
Customer Service   | Yuchang Weedman   |  58745
Development        | Leon DasSarma     |  74510
Finance            | Isamu Legleitner  |  83457
Human Resources    | Karsten Sigstam   |  65400
Marketing          | Vishwani Minakawa | 106491
Production         | Oscar Ghazalie    |  56654
Quality Management | Dung Pesch        |  72876
Research           | Hilary Kambil     |  79393
Sales              | Hauke Zhang       | 101987
*/

use employees;
-- steps
-- identify a bridging table 
-- join with employee, title, salary, and department

SELECT 
    departments.dept_name AS 'Department',
    CONCAT(employees.first_name,
            ' ',
            employees.last_name) AS 'Name',
    salaries.salary AS 'Salary'
FROM
    dept_emp
        JOIN
    employees ON dept_emp.emp_no = employees.emp_no
        JOIN
    departments ON dept_emp.dept_no = departments.dept_no
        JOIN
    titles ON dept_emp.emp_no = titles.emp_no
        JOIN
    salaries ON dept_emp.emp_no = salaries.emp_no
WHERE
    title = 'manager'
        AND titles.to_date = '9999-01-01'
        AND salaries.to_date = '9999-01-01'
ORDER BY departments.dept_name ASC;

-- 09:55:18	select departments.dept_name as Department, concat(employees.first_name, " ", employees.last_name), salaries.salary as Salary from dept_emp  join employees on dept_emp.emp_no = employees.emp_no join departments on dept_emp.dept_no = departments.dept_no join titles on dept_emp.emp_no = titles.emp_no join salaries on dept_emp.emp_no = salaries.emp_no where title = "manager" and titles.to_date = "9999-01-01" group by departments.dept_name	Error Code: 1055. Expression #2 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'employees.employees.first_name' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by	0.0087 sec


select count(*)
from titles
where to_date = "9999-01-01"
and title = "manager";

-- strategy B 

select *
from titles join salaries on titles.emp_no = salaries.emp_no;
-- where to_date = "9999-01-01" and title = "manager";


-- 6. Find the number of current employees in each department
-- example output:
/*
+---------+--------------------+---------------+
| dept_no | dept_name          | num_employees |
+---------+--------------------+---------------+
| d001    | Marketing          | 14842         |
| d002    | Finance            | 12437         |
| d003    | Human Resources    | 12898         |
| d004    | Production         | 53304         |
| d005    | Development        | 61386         |
| d006    | Quality Management | 14546         |
| d007    | Sales              | 37701         |
| d008    | Research           | 15441         |
| d009    | Customer Service   | 17569         |
+---------+--------------------+---------------+
*/


-- steps
-- i will need the total number of current* employees
-- i will need the specific department number/id and the deparment name

SELECT 
    departments.dept_no AS 'dept_no',
    departments.dept_name AS 'dept_name',
    COUNT(employees.emp_no) AS 'num_employees'
FROM
    dept_emp
        NATURAL JOIN
    employees
        NATURAL JOIN
    departments
WHERE
    dept_emp.to_date = '9999-01-01'
GROUP BY departments.dept_no
ORDER BY departments.dept_no ASC;

-- 10:32:53	select departments.dept_no as "dept_no", departments.dept_name as "dept_name", count(employees.emp_no) as "num_employees" from dept_emp natural join employees natural join departments where dept_emp.to_date = "9999-01-01" group by departments.dept_no order by employees.emp_no asc	Error Code: 1055. Expression #1 of ORDER BY clause is not in GROUP BY clause and contains nonaggregated column 'employees.employees.emp_no' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by	0.0060 sec

-- my output
/*
'd001','Marketing','14842'
'd002','Finance','12437'
'd003','Human Resources','12898'
'd004','Production','53304'
'd005','Development','61386'
'd006','Quality Management','14546'
'd007','Sales','37701'
'd008','Research','15441'
'd009','Customer Service','17569'
*/

-- 7. Which department has the highest average salary? Hint: Use current not historic information.
-- sample output:
/*
+-----------+----------------+
| dept_name | average_salary |
+-----------+----------------+
| Sales     | 88852.9695     |
+-----------+----------------+
*/

SELECT 
    departments.dept_name AS 'Department',
    CONCAT(employees.first_name,
            ' ',
            employees.last_name) AS 'Name',
    salaries.salary AS 'Salary'
FROM
    dept_emp JOIN employees ON dept_emp.emp_no = employees.emp_no JOIN departments ON dept_emp.dept_no = departments.dept_no JOIN titles ON dept_emp.emp_no = titles.emp_no JOIN salaries ON dept_emp.emp_no = salaries.emp_no
WHERE
    title = 'manager'
        AND titles.to_date = '9999-01-01'
        AND salaries.to_date = '9999-01-01'
ORDER BY departments.dept_name ASC;


SELECT 
    departments.dept_name AS 'dept_name',
    AVG(salaries.salary) AS 'average_salary'
FROM
    dept_emp
        JOIN
    salaries ON dept_emp.emp_no = salaries.emp_no
        JOIN
    departments ON dept_emp.dept_no = departments.dept_no
WHERE
    salaries.to_date > now()
GROUP BY departments.dept_name
ORDER BY AVG(salaries.salary) DESC
LIMIT 1;
    
-- 11:15:58	SELECT departments.dept_name as "dept_name", avg(salaries.salary) as "average_salary" FROM     dept_emp      JOIN salaries ON dept_emp.emp_no = salaries.emp_no      JOIN departments ON dept_emp.dept_no = departments.dept_no      where salaries.to_date = "9999-01-01"     group by deparments.dept_name     order by avg(salaries.salary) desc     limit 1	Error Code: 1054. Unknown column 'deparments.dept_name' in 'group statement'	0.0064 sec
-- 11:16:27	SELECT departments.dept_name as "dept_name", avg(salaries.salary) as "average_salary" FROM     dept_emp      JOIN salaries ON dept_emp.emp_no = salaries.emp_no      JOIN departments ON dept_emp.dept_no = departments.dept_no      where salaries.to_date = "9999-01-01"     order by avg(salaries.salary) desc     limit 1	Error Code: 1140. In aggregated query without GROUP BY, expression #1 of SELECT list contains nonaggregated column 'employees.departments.dept_name'; this is incompatible with sql_mode=only_full_group_by	0.0071 sec
-- 10:48:22	select departments.dept_name as "dept_name", ave(salaries.salary) as "average_salary" from dept_emp join salaries on dept_emp.emp_no = salaries.emp_no join departments on dept_emp.dept_no = departments.dept_no where salaries.to_date = "9999-01-01"	Error Code: 1370. execute command denied to user 'kalpana_1823'@'%' for routine 'employees.ave'	0.0063 sec


-- 8. Who is the highest paid employee in the Marketing department?
-- example output:
/*
+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Akemi      | Warwick   |
+------------+-----------+
*/

SELECT 
    employees.first_name AS 'first_name',
    employees.last_name AS 'last_name'
FROM
    dept_emp
        JOIN
    employees ON dept_emp.emp_no = employees.emp_no
        JOIN
    departments ON dept_emp.dept_no = departments.dept_no
        JOIN
    salaries ON dept_emp.emp_no = salaries.emp_no
WHERE
    departments.dept_name = 'marketing'
        AND salaries.to_date > NOW()
ORDER BY salaries.salary DESC
LIMIT 1;

-- 11:26:24	select * from dept_emp join employees on dept_emp.emp_no = employees.emp_no join salaries on demp_emp.emp_no = salaries.emp_no join department on demp_emp.dept_no = deparments.dept_no where salaries.to_date > now()	Error Code: 1146. Table 'employees.department' doesn't exist	0.0064 sec
-- 11:29:51	SELECT      * FROM     dept_emp         JOIN     employees ON dept_emp.emp_no = employees.emp_no         JOIN     salaries ON demp_emp.emp_no = salaries.emp_no WHERE     salaries.to_date > NOW()	Error Code: 1054. Unknown column 'demp_emp.emp_no' in 'on clause'	0.0065 sec

-- 9. Which current department manager has the highest salary?
/*example output:
+------------+-----------+--------+-----------+
| first_name | last_name | salary | dept_name |
+------------+-----------+--------+-----------+
| Vishwani   | Minakawa  | 106491 | Marketing |
+------------+-----------+--------+-----------+
*/

SELECT 
    employees.first_name AS 'first_name',
    employees.last_name AS 'last_name',
    salaries.salary AS 'salary',
    departments.dept_name AS 'dept_name'
FROM
    dept_emp
        JOIN
    employees ON dept_emp.emp_no = employees.emp_no
        JOIN
    departments ON dept_emp.dept_no = departments.dept_no
        JOIN
    titles ON dept_emp.emp_no = titles.emp_no
        JOIN
    salaries ON dept_emp.emp_no = salaries.emp_no
WHERE
    salaries.to_date > NOW()
        AND titles.title = 'manager'
        AND titles.to_date > NOW()
ORDER BY salaries.salary DESC
LIMIT 1;

-- 10. Determine the average salary for each department. Use all salary information and round your results
/* example output:
+--------------------+----------------+
| dept_name          | average_salary | 
+--------------------+----------------+
| Sales              | 80668          | 
+--------------------+----------------+
| Marketing          | 71913          |
+--------------------+----------------+
| Finance            | 70489          |
+--------------------+----------------+
| Research           | 59665          |
+--------------------+----------------+
| Production         | 59605          |
+--------------------+----------------+
| Development        | 59479          |
+--------------------+----------------+
| Customer Service   | 58770          |
+--------------------+----------------+
| Quality Management | 57251          |
+--------------------+----------------+
| Human Resources    | 55575          |
+--------------------+----------------+
*/

select departments.dept_name as "dept_name",
round(avg(salaries.salary)) as "average_salary"
from dept_emp
join 
salaries on dept_emp.emp_no = salaries.emp_no
join 
departments on dept_emp.dept_no = departments.dept_no
group by departments.dept_name
order by round(avg(salaries.salary)) desc;


-- Find all the current employees with the same hire date as employee 101010 using a sub-query

use employees;

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
            emp_no LIKE '101010');
            
            
 -- Find all the titles ever held by all current employees with the first name Aamod.
 
 select distinct(title) as "titles_held"
 from titles
 where emp_no in (select emp_no from employees where first_name like "aamod")
 and to_date > now();
 
 -- How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.

SELECT 
    COUNT(emp_no) AS 'number_of_previous_employees'
FROM
    employees
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            dept_emp
        WHERE
            to_date < NOW());

-- 188132



select disctinct(employees.emp_no)
from employees
join 
titles on employees.emp_no = titles.emp_no
where titles.to_date > now();

select count(employees.emp_no)
from employees
join 
dept_emp on employees.emp_no = dept_emp.emp_no
where dept_emp.to_date < now();
 
 
 SELECT 
    departments.dept_name AS 'department_name',
    COUNT(employees.emp_no) AS 'total_employees'
FROM
    dept_emp
        JOIN employees ON dept_emp.emp_no = employees.emp_no
        JOIN departments ON dept_emp.dept_no = departments.dept_no
        JOIN titles ON dept_emp.emp_no = titles.emp_no
WHERE
    dept_emp.to_date > NOW()
GROUP BY departments.dept_name
order by total_employees desc;


-- Find all the current department managers that are female. List their names in a comment in your code.

select first_name, last_name
from employees
where emp_no in (select emp_no from dept_manager where to_date > now())
and gender like "f"
order by last_name asc;

/*
'Leon','DasSarma'
'Hilary','Kambil'
'Isamu','Legleitner'
'Karsten','Sigstam'
*/

-- Find all the employees who currently have a higher salary than the companies overall, historical average salary.

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


-- How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

SELECT 
    COUNT(emp_no)
FROM
    salaries
WHERE
    salary >= (SELECT 
            MAX(salary) 
        FROM
            salaries) - 
            (select std(salary) from salaries)
            and to_date > now();
            
            
select max(salary) 
from salaries;

select count(salary)
from salaries
where to_date > now()
and salary >= "150000";



-- approach
-- isolate the current** highest salary (can use max() function, but salary must also be > now())
-- from current highest salary, identify 1 standard deviation bands
-- count number of salaries that are <= 1 standard deviation from highest salary
-- calculate percentage of 1STD of highest salary (total_1_standard-deviation / total number of salaries)




-- Hint You will likely use multiple subqueries in a variety of ways
-- Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. You will use this number (or the query that produced it) in other, larger queries.
-- BONUS

-- Find all the department names that currently have female managers.

-- i need to find all female managers
-- i need to find all department names with female managers



select *
from departments
where dept_no like
(select *
from dept_manager 
where to_date > now()
and emp_no in
(select *
from employees
where
emp_no in (select * from employees where gender = "f")));


select departments.dept_name as "department_name"
from dept_manager join departments using (dept_no) join employees using (emp_no)
where dept_manager.to_date > now()
and employees.gender = "f";


SELECT 
    dept_name
FROM
    departments
WHERE
    dept_no IN (SELECT 
            dept_no
        FROM
            dept_manager
        WHERE
            emp_no IN (SELECT 
                    emp_no
                FROM
                    employees
                WHERE
                    gender = 'f')
                AND to_date > NOW());


-- Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '' at line 11

-- Find the first and last name of the employee with the highest salary.

SELECT 
    first_name, last_name
FROM
    employees
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            salaries
        WHERE
            salary = (SELECT 
                    MAX(salary)
                FROM
                    salaries)
                AND to_date > NOW());


-- Find the department name that the employee with the highest salary works in.

SELECT 
    departments.dept_name, employees.last_name
FROM
    dept_emp
        JOIN
    employees USING (emp_no)
        JOIN
    departments USING (dept_no)
        JOIN
    salaries USING (emp_no)
WHERE
    salaries.salary = (SELECT 
            MAX(salary)
        FROM
            salaries)
        AND dept_emp.to_date > NOW();

use employees;

-- BOOLEAN MATCH / CAST
select dept_name,
dept_name = "research" as is_research
from departments;
