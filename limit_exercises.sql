-- 1. Create a new SQL script named limit_exercises.sql.
	-- completed
-- 2. MySQL provides a way to return only unique results from our queries with the keyword DISTINCT. For example, to find all the unique titles within the company, we could run the following query:
-- SELECT DISTINCT title FROM titles
-- List the first 10 distinct last name sorted in descending order
select distinct(last_name) from employees order by last_name desc limit 10;
-- 1 'Zykh'
-- 2 'Zyda'
-- 3 'Zwicker'
-- 4 'Zweizig'
-- 5 'Zumaque'
-- 6 'Zultner'
-- 7'Zucker'
-- 8 'Zuberek'
-- 9 'Zschoche'
-- 10 'Zongker'

-- 3. Find all previous or current employees hired in the 90s and born on Christmas. Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. Write a comment in your code that lists the five names of the employees returned.
select hire_date, first_name, last_name from employees where year(hire_date) between "1990" and "1999" and month(birth_date) = "12" and day(birth_date) = "25" order by hire_date asc limit 5;
-- '1990-01-01','Alselm','Cappello'
-- '1990-01-03','Utz','Mandell'
-- '1990-01-04','Bouchung','Schreiter'
-- '1990-01-05','Baocai','Kushner'
-- '1990-01-10','Petter','Stroustrup'


-- 4. Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results.
-- LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?
select hire_date, first_name, last_name from employees where year(hire_date) between "1990" and "1999" and month(birth_date) = "12" and day(birth_date) = "25" order by hire_date asc limit 5 offset 45;
# formula can be thought of 
# n page = limit 5 offset (n - 1)*5

	-- '1990-07-18','Pranay','Narwekar'
	-- '1990-07-18','Marjo','Farrow'
	-- '1990-08-05','Ennio','Karcich'
	-- '1990-08-06','Dines','Lubachevsky'
	-- '1990-08-06','Ipke','Fontan'
    
  


