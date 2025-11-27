select * from employee_rec;

# Identify employees with frequent absences.
SELECT 
    EmployeeID,
    Name,
    COUNT(*) AS total_absences
FROM employee_rec
WHERE status = 'Absent'
GROUP BY EmployeeID, Name
HAVING COUNT(*) > 3
ORDER BY total_absences DESC;

# Calculate average hours worked per employee.
SELECT 
    EmployeeID,
    Name,
    ROUND(AVG(HoursWorked), 2) AS AvgHoursWorked
FROM employee_rec
WHERE Status = 'Present'
GROUP BY EmployeeID, Name
ORDER BY AvgHoursWorked DESC;

# Find departments with highest absenteeism rate.
SELECT 
    department,
    SUM(CASE WHEN status = 'Absent' THEN 1 ELSE 0 END) AS total_absences,
    COUNT(*) AS total_days,
    ROUND(
        (SUM(CASE WHEN status = 'Absent' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2
    ) AS absenteeism_rate
FROM employee_rec
GROUP BY department
ORDER BY absenteeism_rate DESC;

# Determine attendance trends by day of the week.
SELECT 
    DAYNAME(Date) AS day_of_week,
    SUM(CASE WHEN Status = 'Present' THEN 1 ELSE 0 END) AS total_present,
    SUM(CASE WHEN Status = 'Absent' THEN 1 ELSE 0 END) AS total_absent
FROM employee_rec
GROUP BY day_of_week
ORDER BY FIELD(day_of_week, 
    'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday');

# Identify employees with consistent overtime or undertime.
SELECT 
    EmployeeID,
    Name,
    ROUND(AVG(HoursWorked), 2) AS AvgHours
FROM employee_rec
GROUP BY EmployeeID, Name
HAVING AVG(HoursWorked) > 8
ORDER BY AvgHours DESC;

# Compare average productivity by job role or department.
SELECT 
    EmployeeID,
    Name,
    ROUND(AVG(HoursWorked), 2) AS avg_hours
FROM employee_rec
GROUP BY EmployeeID, Name
HAVING AVG(HoursWorked) < 8
ORDER BY Avg_Hours ASC;

SELECT 
    JobRole,
    ROUND(AVG(ProductivityScore), 2) AS avg_productivity
FROM employee_rec
GROUP BY JobRole
ORDER BY avg_productivity DESC;

SELECT 
    Department,
    ROUND(AVG(ProductivityScore), 2) AS avg_productivity
FROM employee_rec
GROUP BY Department
ORDER BY avg_productivity DESC;

# List employees with perfect attendance records.
SELECT 
    EmployeeID,
    Name
FROM employee_rec
GROUP BY EmployeeID, Name
HAVING SUM(CASE WHEN Status = 'Absent' THEN 1 END) = 0;








