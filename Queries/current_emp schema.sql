DROP TABLE retirement_info;

SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952_01_01' AND '1955_12_31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--New retirement table
SELECT * FROM retirement_info
SELECT * FROM dept_employees

SELECT rf.emp_no, rf.first_name, rf.last_name, de.to_date
FROM retirement_info AS rf
LEFT JOIN dept_employees AS de
ON  rf.emp_no = de.emp_no;


SELECT d.dept_name, dm.emp_no, dm.from_date, dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

--Create new table with current employees that will retire soon
SELECT rf.emp_no, rf.first_name, rf.last_name, de.to_date
INTO current_emp
FROM retirement_info AS rf
LEFT JOIN dept_employees AS de
ON  rf.emp_no = de.emp_no
WHERE to_date = '9999-01-01';

SELECT COUNT(*) FROM current_emp;