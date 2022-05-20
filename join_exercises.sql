-- 1. Use the join_example_db. Select all the records from both the users and roles tables.
use join_example_db;
describe users; # 4 columns id(primary/name/email/role_id(mul?) "mul" meaning that it will allow for rows to have the same value
describe roles; # 2 columns id(primary)/name

select * 
from users, roles; # 24 total rows returned

-- 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results

# JOIN function

select users.name as user_name, # iam selecting 'name' column from users table - renaming it as alias...
roles.name as role_name # iam selecting 'name' column from role table - renaming it as alias
from users # look specifically at the users table (where join will be initiated from? / inner join so may be done simultaneously...does table selection here matter?)
join roles on users.role_id = roles.id; # match 1-for-1 values in user.role_id with roles.id and only join these values

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

select users.name as user_name,
roles.id as role_id
from users
right join roles on users.role_id = roles.id;

-- will return back five (5) rows matching all roles.id to user.role_id (duplicate 3 pair) regardless if there is a matching left value 1-4 unique roles.id + 1 duplicate


-- 3. Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries
-- Use count and the appropriate join type to get a list of roles along with the number of users that has the role
-- Hint: You will also need to use group by in the query.


# i need to return a list of roles (1-4?)
# count total number of users that match these roles
# you want to also return only* unique values using "group by" function
# since the roles are expressed from "roles table", i will run a 'right join' function

select roles.id as role_id,
count(roles.id) as role_count
from users
right join roles on users.role_id = roles.id
group by roles.id;

-- Employees Database
-- 1. Use the employees database
use employees;

-- 2a. Using the example in the Associative Table Joins section as a guide, 
-- 2b. write a query that shows each department along with the name of the current manager for that department

-- sample query below:
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de
  ON de.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01' AND e.emp_no = 10001;

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



-- 7. Which department has the highest average salary? Hint: Use current not historic information.
-- sample output:
/*
+-----------+----------------+
| dept_name | average_salary |
+-----------+----------------+
| Sales     | 88852.9695     |
+-----------+----------------+
*/


-- 8. Who is the highest paid employee in the Marketing department?
-- example output:
/*
+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Akemi      | Warwick   |
+------------+-----------+
*/


-- 9. Which current department manager has the highest salary?
/*example output:
+------------+-----------+--------+-----------+
| first_name | last_name | salary | dept_name |
+------------+-----------+--------+-----------+
| Vishwani   | Minakawa  | 106491 | Marketing |
+------------+-----------+--------+-----------+
*/


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




-- 11. Bonus Find the names of all current employees, their department name, and their current manager's name
/* example output:
240,124 Rows

Employee Name | Department Name  |  Manager Name
--------------|------------------|-----------------
 Huan Lortz   | Customer Service | Yuchang Weedman
*/




-- 12. Bonus Who is the highest paid employee within each department.




