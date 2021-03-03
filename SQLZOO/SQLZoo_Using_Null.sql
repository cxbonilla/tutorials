# List the teachers who have NULL for the department.
SELECT teacher.name
FROM teacher
WHERE dept IS NULL;

# Note the INNER JOIN misses the teachers with no department and the departments with no teacher.
SELECT teacher.name, dept.name
FROM teacher
INNER JOIN dept ON (teacher.dept=dept.id)

# Use a different JOIN so that all teachers are listed.
SELECT teacher.name, dept.name
FROM teacher
LEFT JOIN dept ON (teacher.dept=dept.id);

# Use a different JOIN so that all departments are listed.
SELECT teacher.name, dept.name
FROM teacher
RIGHT JOIN dept ON (teacher.dept=dept.id);

# Use COALESCE to print the mobile number. Use the number '07986 444 2266' if there is no number given. Show teacher name and mobile number or '07986 444 2266'
SELECT teacher.name, COALESCE(teacher.mobile, '07986 444 2266') AS mobile
FROM teacher;

# Use the COALESCE function and a LEFT JOIN to print the teacher name and department name. Use the string 'None' where there is no department.
SELECT teacher.name, COALESCE(dept.name, 'None') AS name
FROM teacher LEFT JOIN dept ON (teacher.dept=dept.id);

# Use COUNT to show the number of teachers and the number of mobile phones.
SELECT COUNT(teacher.id) AS name, COUNT(teacher.mobile) AS mobile
FROM teacher;

# Use COUNT and GROUP BY dept.name to show each department and the number of staff. Use a RIGHT JOIN to ensure that the Engineering department is listed.
SELECT dept.name, COUNT(teacher.name) AS name
FROM teacher RIGHT JOIN dept ON (teacher.dept = dept.id)
GROUP BY dept.name;

# Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise.
SELECT name,
CASE WHEN dept <= 2 THEN 'Sci'
ELSE 'Art'
END AS field
FROM teacher;

# Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2, show 'Art' if the teachers dept is 3 and 'None' otherwise.
SELECT teacher.name,
CASE WHEN teacher.dept <= 2 THEN 'Sci'
WHEN teacher.dept = 3 THEN 'Art'
ELSE 'None'
END AS field
FROM teacher;