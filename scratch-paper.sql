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

select departments.dept_name as "Department",
concat(employees.first_name, " ", employees.last_name) as "Name",
salaries.salary as "Salary"
from dept_emp 
join employees on dept_emp.emp_no = employees.emp_no
join departments on dept_emp.dept_no = departments.dept_no
join titles on dept_emp.emp_no = titles.emp_no
join salaries on dept_emp.emp_no = salaries.emp_no
where title = "manager" and titles.to_date = "9999-01-01" and salaries.to_date = "9999-01-01"


-- 09:55:18	select departments.dept_name as Department, concat(employees.first_name, " ", employees.last_name), salaries.salary as Salary from dept_emp  join employees on dept_emp.emp_no = employees.emp_no join departments on dept_emp.dept_no = departments.dept_no join titles on dept_emp.emp_no = titles.emp_no join salaries on dept_emp.emp_no = salaries.emp_no where title = "manager" and titles.to_date = "9999-01-01" group by departments.dept_name	Error Code: 1055. Expression #2 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'employees.employees.first_name' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by	0.0087 sec


select count(*)
from titles
where to_date = "9999-01-01"
and title = "manager";

-- strategy B 

select *
from titles join salaries on titles.emp_no = salaries.emp_no;
-- where to_date = "9999-01-01" and title = "manager";
