CREATE DATABASE EmployeeDB;
 USE EmployeeDB;

CREATE TABLE EmployeeAttendance(
 AttendanceID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    Date DATE,
    Status VARCHAR(20),
    HoursWorked INT
);

INSERT INTO EmployeeAttendance (AttendanceID, EmployeeName, Department, Date, Status, HoursWorked) VALUES
(1, 'John Doe', 'IT', '2025-05-01', 'Present', 8),
(2, 'Priya Singh', 'HR', '2025-05-01', 'Absent', 0),
(3, 'Ali Khan', 'IT', '2025-05-01', 'Present', 7),
(4, 'Riya Patel', 'Sales', '2025-05-01', 'Late', 6),
(5, 'David Brown', 'Marketing', '2025-05-01', 'Present', 8);


--Tasks:

--1. Create – Insert a new attendance record
INSERT INTO EmployeeAttendance (AttendanceID, EmployeeName, Department, Date, Status, HoursWorked)
VALUES (6, 'Neha Sharma', 'Finance', '2025-05-01', 'Present', 8);

--2. Update – Change Riya Patel’s status to Present
UPDATE EmployeeAttendance
SET Status = 'Present'
WHERE EmployeeName = 'Riya Patel' AND Date = '2025-05-01';

--3. Delete – Remove Priya Singh's attendance entry
DELETE FROM EmployeeAttendance
WHERE EmployeeName = 'Priya Singh' AND Date = '2025-05-01';

--4. Read – Display all records sorted by EmployeeName (A–Z)
SELECT * FROM EmployeeAttendance
ORDER BY EmployeeName ASC;

--5. Sort by Hours Worked (Descending)
SELECT * FROM EmployeeAttendance
ORDER BY HoursWorked DESC;

--6. Filter by Department = 'IT'
SELECT * FROM EmployeeAttendance
WHERE Department = 'IT';

--7. Present Employees from IT Department (AND Condition)
SELECT * FROM EmployeeAttendance
WHERE Department = 'IT' AND Status = 'Present';

--8. OR Condition – Absent or Late
SELECT * FROM EmployeeAttendance
WHERE Status = 'Absent' OR Status = 'Late';

--9. Total Hours Worked by Department
SELECT Department, SUM(HoursWorked) AS TotalHours
FROM EmployeeAttendance
GROUP BY Department;

--10.  Average Hours Worked Across All Departments
SELECT AVG(HoursWorked) AS AvgHoursWorked
FROM EmployeeAttendance;

--11. Attendance Count by Status
SELECT Status, COUNT(*) AS Count
FROM EmployeeAttendance
GROUP BY Status;

--12. EmployeeName Starts with 'R'
SELECT * FROM EmployeeAttendance
WHERE EmployeeName LIKE 'R%';

--13. Present and Worked More Than 6 Hours
SELECT * FROM EmployeeAttendance
WHERE HoursWorked > 6 AND Status = 'Present';

--14.  HoursWorked Between 6 and 8
SELECT * FROM EmployeeAttendance
WHERE HoursWorked BETWEEN 6 AND 8;

--15. Top 2 Employees with Most Hours Worked
SELECT TOP 2 * FROM EmployeeAttendance
ORDER BY HoursWorked DESC;

--16. Employees Below Average Hours Worked
SELECT * FROM EmployeeAttendance
WHERE HoursWorked < (
    SELECT AVG(HoursWorked) FROM EmployeeAttendance
);

--17. Group by Status – Average Hours
SELECT Status, AVG(HoursWorked) AS AvgHours
FROM EmployeeAttendance
GROUP BY Status;

--18. Find Duplicate Entries (same employee, same date)
SELECT EmployeeName, Date, COUNT(*) AS Occurrences
FROM EmployeeAttendance
GROUP BY EmployeeName, Date
HAVING COUNT(*) > 1;

--19. Department with Most Present Employees
SELECT TOP 1 Department, COUNT(*) AS PresentCount
FROM EmployeeAttendance
WHERE Status = 'Present'
GROUP BY Department
ORDER BY PresentCount DESC;

--20. Employee with Max Hours per Department
SELECT ea.*
FROM EmployeeAttendance ea
WHERE HoursWorked = (
    SELECT MAX(HoursWorked)
    FROM EmployeeAttendance
    WHERE Department = ea.Department
);
