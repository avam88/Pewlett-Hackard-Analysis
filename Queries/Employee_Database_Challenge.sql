SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees as e
LEFT JOIN titles as T
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no
-- RETIREMENT TITLES every employee born between blank and blank

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) 
emp_no,
first_name,
last_name,
title
to_date
INTO unique_titles
FROM retirement_titles
WHERE to_date = ('9999-01-01')
ORDER BY emp_no, to_date DESC; 
-- UNIQUE TITLES - every retirement eligible employee that is currently working and their title
-- COUNT = 72458

SELECT COUNT (emp_no) as count, title
INTO retiring_titles
FROM unique_titles
GROUP BY title 
ORDER BY count DESC;

SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, d.from_date, d.to_date, t.title
INTO mentorship_eligibility
FROM employees AS e
JOIN dept_employee AS d
ON (e.emp_no = d.emp_no)
JOIN titles as t
ON (t.emp_no = e.emp_no)
WHERE (d.to_date = ('9999-01-01')) 
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31');



-- new table to show current employees, less retiring employees who could be used to fill upper roles
SELECT COUNT(DISTINCT(emp_no)) AS count, title
FROM current_employee_titles
WHERE (to_date = ('9999-01-01'))
GROUP BY title
ORDER BY count DESC;

-- need to figure out how to exclude retiring people to get people ready for upward mobility


Select COUNT(DISTINCT(emp_no)) AS count, title
INTO current_titles_no_retire
FROM titles
WHERE ((emp_no) NOT IN (SELECT emp_no FROM unique_titles))
AND (to_date = ('9999-01-01'))
GROUP BY title
ORCER BY count DESC;

