-- 1. Use the join_example_db. Select all the records from both the users and roles tables.
use join_example_db;
describe users; # 4 columns id(primary/name/email/role_id(mul?) "mul" meaning that it will allow for rows to have the same value
describe roles; # 2 columns id(primary)/name

select * 
from users, roles; # 24 total rows returned

-- 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results

# JOIN function
SELECT 
    users.name AS user_name, roles.name AS role_name
FROM
    users
        JOIN
    roles ON users.role_id = roles.id; # match 1-for-1 values in user.role_id with roles.id and only join these values

-- query should return 4 rows

# LEFT JOIN function
SELECT 
    users.name as user_name, roles.name as role_name
FROM
    users
        LEFT JOIN # will return back all "user name" records on left regardless if a 1-for-1 match on the right/joined table
    roles on users.role_id = roles.id;

# will return 6 rows including 'JANE' and 'MIKE'

# RIGHT JOIN function
SELECT 
    users.name AS user_name, roles.id AS role_id
FROM
    users
        RIGHT JOIN
    roles ON users.role_id = roles.id;

-- will return back five (5) rows matching all roles.id to user.role_id (duplicate 3 pair) regardless if there is a matching left value 1-4 unique roles.id + 1 duplicate

-- 3. Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries
-- Use count and the appropriate join type to get a list of roles along with the number of users that has the role
-- Hint: You will also need to use group by in the query.

# i need to return a list of roles (1-4?)
# count total number of users that match these roles
# you want to also return only* unique values using "group by" function
# since the roles are expressed from "roles table", i will run a 'right join' function
SELECT 
    roles.id AS role_id, COUNT(roles.id) AS role_count
FROM
    users
        RIGHT JOIN
    roles ON users.role_id = roles.id
GROUP BY roles.id;

-- ---------- --
# Employees Database
-- 1. Use the employees database
use employees;

-- 2a. Using the example in the Associative Table Joins section as a guide, 
-- 2b. write a query that shows each department along with the name of the current manager for that department

-- example output:
 /* 
 Department Name    | Department Manager
 --------------------+--------------------
  Customer Service   | Yuchang Weedman
  Development        | Leon DasSarma
  Finance            | Isamu Legleitner
  Human Resources    | Karsten Sigstam
  Marketing          | Vishwani Minakawa
  Production         | Oscar Ghazalie
  Quality Management | Dung Pesch
  Research           | Hilary Kambil
  Sales              | Hauke Zhang 
  */

describe dept_manager;
describe departments;
describe dept_emp;

select *
from dept_emp; #this is a table showing respective department employees and the tenure in the department (also current employees); (emp_no / dept_no / from_date / to_date)

select * 
from departments; #this is a table that has each departments respective "key" (dept_no) matching key to department; (dept_no / dept_name)

select * 
from dept_manager; #this is a table showing respetive deptment managers (emp_no) and their tenure as department manager; (emp_no / dept_no / from_date / to_date)

select *
from employees; #this is a table showing employees' admin. information and tenure at the company; (emp_no / birth_date / first_name / last_name / gender / hire_date)

#steps
-- identify all current department managers
-- consider left and right joins; here's why
-- i want to tie department managers to respective employees and their name
-- i also want to tie deparment managers to their respective department name 
-- keep in mind that you only want to look for current* department managers given their to_date code denoted as (9999-01-01)


SELECT 
    dept_name AS 'Department Name',
    CONCAT(first_name, ' ', last_name) AS 'Department Manager'
FROM
    dept_manager AS manager
        JOIN
    departments ON manager.dept_no = departments.dept_no
        JOIN
    employees ON manager.emp_no = employees.emp_no
WHERE
    manager.to_date = '9999-01-01'
ORDER BY dept_name ASC;


-- 3. Find the name of all departments currently managed by women
-- example output:
/*
Department Name | Manager Name
----------------+-----------------
Development     | Leon DasSarma
Finance         | Isamu Legleitner
Human Resources | Karsetn Sigstam
Research        | Hilary Kambil
*/

SELECT 
    dept_name AS 'Department Name',
    CONCAT(first_name, ' ', last_name) AS 'Department Manager'
FROM
    dept_manager AS manager
        JOIN
    departments ON manager.dept_no = departments.dept_no
        JOIN
    employees ON manager.emp_no = employees.emp_no
WHERE
    manager.to_date = '9999-01-01'
        AND gender = 'f'
ORDER BY dept_name ASC;

/* 
my output

'Development','Leon DasSarma'
'Finance','Isamu Legleitner'
'Human Resources','Karsten Sigstam'
'Research','Hilary Kambil'
*/


-- 4. Find the current titles of employees currently working in the Customer Service department
-- example output:
/*
Title              | Count
-------------------+------
Assistant Engineer |    68
Engineer           |   627
Manager            |     1
Senior Engineer    |  1790
Senior Staff       | 11268
Staff              |  3574
Technique Leader   |   241
*/

-- steps
-- 1. start by looking in the "titles" table
-- 2. in titles <title> isolate the "customer service" department 
-- 3. in titles <to_date> isolate all active/current* roles 
-- 4. from titles <emp_no> COUNT total number of employee id

-- select title as "Title",
-- count(emp_no) as "Count"

titles.tile as "Title",
count(dept_emp.emp_no) as "Count"
    titles
        join
   dept_emp using (emp_no)
       join
    departments using (dept_no)
WHERE
    titles.to_date > now()
    and
    dept_emp.to_date > now()
    group by titles.tile;


select titles.tile as "Title",
count(
from departments;
SELECT 
    COUNT(DISTINCT (title))
FROM
    titles;

SELECT DISTINCT
    (title), to_date
FROM
    titles
WHERE
    to_date = '9999-01-01';

-- i want to to see which department contains all seven (7) unique employee roles

SELECT 
    COUNT(DISTINCT (titles.title)) AS 'number of dept titles',
    dept_emp.dept_no AS 'department'
FROM
    dept_emp
        NATURAL JOIN
    titles
        NATURAL JOIN
    departments
WHERE
    to_date = '9999-01-01'
GROUP BY dept_no;


-- select titles.title as "Title", 
-- count(titles.emp_no) as "Count"
-- from dept_emp
-- join departments on dept_emp.dept_no = departments.dept_no
-- join employees on dept_emp.emp_no = employees.emp_no
-- where dept_emp.to_date = "9999-01-01"
-- group by departments.dept_name, dept_emp.dept_no;


select *
from titles;

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

SELECT 
    departments.dept_name AS 'Department Name',
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
    departments.dept_name AS 'dept_name',
    AVG(salaries.salary) AS 'average_salary'
FROM
    departments
        JOIN
    dept_emp ON departments.dept_no = dept_emp.dept_no
        JOIN
    salaries ON dept_emp.emp_no = salaries.emp_no
WHERE
    salaries.to_date > NOW()
        AND dept_emp.to_date > NOW()
GROUP BY departments.dept_name
ORDER BY AVG(salaries.salary) DESC
LIMIT 1;


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
    titles.title = 'manager'
        AND titles.to_date > NOW()
        AND salaries.to_date > NOW()
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

SELECT 
    departments.dept_name AS 'dept_name',
    ROUND(AVG(salaries.salary)) AS 'average_salary'
FROM
    dept_emp
        JOIN
    salaries ON dept_emp.emp_no = salaries.emp_no
        JOIN
    departments ON dept_emp.dept_no = departments.dept_no
GROUP BY departments.dept_name
ORDER BY ROUND(AVG(salaries.salary)) DESC;


-- 11. Bonus Find the names of all current employees, their department name, and their current manager's name
/* example output:
240,124 Rows

Employee Name | Department Name  |  Manager Name
--------------|------------------|-----------------
 Huan Lortz   | Customer Service | Yuchang Weedman
*/




-- 12. Bonus Who is the highest paid employee within each department.




