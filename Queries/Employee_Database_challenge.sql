--Retrieve Retirement Titles born between January 1, 1952 and December 31, 1955

Select e.emp_no,
		e.first_name, 
		e.last_name,	
		ti.title,
		ti.from_date,
		ti.to_date
		   
INTO retirements_titles 
FROM employees as e
INNER JOIN titles as ti ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;

-- SELECT * FROM retirements_titles;


-- Use Dictinct with Orderby to remove duplicate rows

SELECT DISTINCT ON (rt.emp_no) rt.emp_no,  
rt.first_name,
rt.last_name,
rt.title

INTO unique_titles
FROM retirements_titles AS rt
ORDER BY rt.emp_no, rt.to_date DESC;

-- SELECT * From unique_titles


-- Retrieve employees by their most recent job title who are about to retire.

SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY COUNT DESC;

-- SELECT * From retiring_titles


-- Creating a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program

SELECT DISTINCT ON (e.emp_no) 
		e.emp_no,
		e.first_name, 
		e.last_name,
		e.birth_date,
		de.from_date,
		de.to_date,
		ti.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no, ti.from_date DESC;

SELECT * FROM mentorship_eligibilty


		


