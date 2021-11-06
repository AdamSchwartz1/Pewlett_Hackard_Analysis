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

SELECT * FROM current_emp;

-- Employee count by department number
SELECT ce.emp_no, de.dept_no
INTO count_by_dept
FROM current_emp as ce
LEFT JOIN dept_employees as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- A list of employees containing their unique employee number, their last name, first name, gender, and salary
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees AS e
INNER JOIN salaries AS s
	ON e.emp_no = s.emp_no
INNER JOIN dept_employees as de
	ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);

-- An updated current_emp list that includes everything it currently has, 
-- but also the employee's departments
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_employees AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);


-- All employees in the sales department that will be retiring soon
SELECT ri.emp_no, ri.first_name, ri.last_name, d.dept_name
FROM retirement_info AS ri
INNER JOIN dept_employees AS de
	ON de.emp_no = ri.emp_no
INNER JOIN departments AS d
	ON de.dept_no = d.dept_no
WHERE (d.dept_no = 'd007')
AND (to_date = '9999-01-01');

-- All employees in the sales and development departments that will be retiring soon
SELECT ri.emp_no, ri.first_name, ri.last_name, d.dept_name
FROM dept_employees AS de
INNER JOIN retirement_info AS ri
	ON de.emp_no = ri.emp_no
INNER JOIN departments AS d
	ON de.dept_no = d.dept_no
WHERE (d.dept_no IN ('d007', 'd005'))
AND (to_date = '9999-01-01')
;