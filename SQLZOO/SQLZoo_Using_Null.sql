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
