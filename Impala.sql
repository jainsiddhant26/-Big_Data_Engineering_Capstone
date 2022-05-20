-- 1. A list showing employee number, last name, first name, sex, and salary for each employee

SELECT EM.emp_no, EM.last_name, EM.first_name, EM.sex, SAL.salary 
FROM employees EM 
LEFT JOIN salaries SAL
    ON EM.emp_no = SAL.emp_no
    
-- 2. A list showing first name, last name, and hire date for employees who were hired in 1986.

SELECT first_name,last_name,hire_date 
FROM employees WHERE  substr(hire_date,1,4) = '1986'

-- 3. A list showing the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

SELECT DPT.dept_no,DM.emp_no,EMP.last_name,EMP.first_name FROM departments DPT
INNER JOIN dept_manager  DM 
    ON DPT.dept_no = DM.dept_no
INNER JOIN employees EMP
    ON DM.emp_no = EMP.emp_no;

-- 4. A list showing the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT DE.emp_no, EMP.last_name,EMP.first_name,DPT.dept_name FROM departments DPT 
INNER JOIN dept_emp DE
    ON DPT.dept_no = DE.dept_no
INNER JOIN employees EMP
    ON DE.emp_no = EMP.emp_no ;

-- 5. A list showing first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B.“

SELECT first_name,last_name ,sex FROM employees WHERE first_name = 'Hercules' AND last_name LIKE('B%');

-- 6. A list showing all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT EMP.emp_no,EMP.last_name,EMP.first_name,DPT.dept_name FROM employees EMP
LEFT JOIN dept_emp DE 
    ON EMP.emp_no = DE.emp_no 
LEFT JOIN departments DPT
    ON DE.dept_no = DPT.dept_no 
WHERE DPT.dept_name like'%Sales%'

-- 7. A list showing all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.


SELECT EMP.emp_no,EMP.last_name,EMP.first_name,DPT.dept_name FROM employees EMP
LEFT JOIN dept_emp DE 
    ON EMP.emp_no = DE.emp_no 
LEFT JOIN departments DPT
    ON DE.dept_no = DPT.dept_no 
WHERE DPT.dept_name IN('"Sales"','"Development"');

-- 8. A list showing the frequency count of employee last names, in descending order. ( i.e., how many employees share each last name)

SELECT last_name , count(emp_no) FROM employees 
GROUP BY last_name
ORDER BY last_name DESC;

-- 9. Histogram to show the salary distribution among the employees

SELECT T1.Salary_bins , count(T1.emp_no) FROM (SELECT 
CASE 
when SAL.salary <= 40000 then 'Less than 40k '
when SAL.salary > 40000 and SAL.salary < 50000 then '40-50k'
when SAL.salary > 50000 and SAL.salary < 60000 then '50 -60k' 
when SAL.salary > 60000 and SAL.salary < 70000 then '60 -70k'
when SAL.salary > 70000 and SAL.salary < 80000 then '70 -80k'
when SAL.salary > 80000 and SAL.salary < 90000 then '80 -90k'
when SAL.salary > 90000 and SAL.salary < 100000 then '90 -100k'
when SAL.salary > 100000 then '10k+'
END AS Salary_bins, EMP.emp_no
FROM employees EMP
INNER JOIN salaries SAL ON EMP.emp_no = SAL.emp_no ) T1
GROUP BY T1.Salary_bins;

--10. Bar graph to show the Average salary per title (designation)


SELECT T.title, avg(SAL.salary) FROM employees EMP
inner join titles T 
    on EMP.emp_title_id = T.title_id 
inner join salaries SAL 
    on EMP.emp_no = SAL.emp_no
group by T.title

-- 11.Calculate employee tenure & show the tenure distribution among the employees


create view emp_tenure as 
select *, cast(substr(last_date ,1,4) as int) last_year , cast(substr(hire_date, 1,4) as int) hire_year from employees;

SELECT COUNT(emp_no), CASE WHEN last_year IS NULL THEN (2013-hire_year)  ELSE (last_year - hire_year) 
END AS tenure FROM emp_tenure 
GROUP BY CASE  WHEN last_year IS NULL THEN (2013-hire_year) ELSE (last_year - hire_year) END;

-- 12. Count of employee gender distribution.
  SELECT sex , COUNT(emp_no) FROM employees
  GROUP BY sex;
  
-- 13. Count of employees based on rating.
SELECT Last_performance_rating , COUNT(emp_no) FROM employees
  GROUP BY last_performance_rating
  
-- 14. count of employees according to desingnation. 
 SELECT T.title,COUNT(EMP.emp_no)  FROM titles T
 INNER JOIN employees EMP
    ON T.title_id = EMP.emp_title_id
GROUP BY(T.title);

--  15. Employees who are registered in more than one department

SELECT emp_no, count(emp_no) as frequency
FROM dept_emp
GROUP BY emp_no having count(emp_no) > 1
	 ORDER BY frequency DESC;
  
 --16. most paid employees.
 
SELECT t1.first_name,t1.last_name, SUM(t2.salary) FROM employees t1 
LEFT JOIN salaries t2 
    ON t1.emp_no = t2.emp_no
GROUP BY t1.first_name,t1.last_name
ORDER BY sum(t2.salary) DESC;
