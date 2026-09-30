


-- Q2 pattern Printing
USE workDB;


DECLARE @i INT = 1;
DECLARE @str VARCHAR(10);

WHILE @i <= 5
BEGIN
    SET @str = '';

    DECLARE @j INT = 1;

    WHILE @j <= @i
    BEGIN
        SET @str = @str + CHAR(64 + @j);
        SET @j = @j + 1;
    END;

    PRINT @str;

    SET @i = @i + 1;
END;


--Q3 prime no



DECLARE @num INT = 17;
DECLARE @i INT = 2;
DECLARE @isPrime BIT = 1;

IF @num <= 1
BEGIN
    SET @isPrime = 0;
END
ELSE
BEGIN
    WHILE @i <= SQRT(@num)
    BEGIN
        IF @num % @i = 0
        BEGIN
            SET @isPrime = 0;
            BREAK;
        END;

        SET @i = @i + 1;
    END;
END;

IF @isPrime = 1
    PRINT 'Prime Number';
ELSE
    PRINT 'Not a Prime Number';


-- Q4
CREATE TABLE Students
(
    StudentName VARCHAR(100),
    FatherName VARCHAR(100)
);

INSERT INTO Students(StudentName, FatherName)
VALUES
('Rajiv Kumar', 'Arvind Kumar'),
('Asish Roy', 'Ashim Roy'),
('Bipin Gupta', 'Rajiv Gupta'),
('Rajiv Kumar', 'Arvind Kumar'),
('Sourav Patra', 'Asish Patra'),
('Asish Roy', 'Ashim Roy');


SELECT StudentName, FatherName, COUNT(*) AS TotalCount
FROM Students
GROUP BY StudentName, FatherName
HAVING COUNT(*) > 1;

-- Q5 

SELECT s.*
FROM Students s
INNER JOIN
(
    SELECT StudentName, FatherName
    FROM Students
    GROUP BY StudentName, FatherName
    HAVING COUNT(*) > 1
) d
ON s.StudentName = d.StudentName
AND s.FatherName = d.FatherName;


-- Q6 employees hired in last month
CREATE TABLE Employees_Hire
(
    EmployeeID INT,
    EmployeeName VARCHAR(100),
    HireDate DATE,
    Salary DECIMAL(10,2)
);

INSERT INTO Employees_Hire
VALUES
(1, 'Rahul', '2026-09-01', 50000),
(2, 'Amit', '2026-06-10', 45000),
(3, 'Priya', '2026-03-15', 60000),
(4, 'Riya', '2025-01-20', 55000);


SELECT *
FROM Employees_Hire
WHERE HireDate >= DATEADD(MONTH, -3, GETDATE());-- for last three months


DECLARE @N INT = 6;

SELECT *
FROM Employees_Hire
WHERE HireDate >= DATEADD(MONTH, -@N, GETDATE());


-- Q7

CREATE TABLE employees
(
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50) NOT NULL,
    job_title VARCHAR(50) NOT NULL,
    manager_id INT NULL,

    FOREIGN KEY (manager_id)
    REFERENCES employees(employee_id)
);

INSERT INTO employees
VALUES
(1, 'Raj', 'CEO', NULL),
(2, 'Amit', 'Manager', 1),
(3, 'Priya', 'Manager', 1),
(4, 'Rahul', 'Developer', 2),
(5, 'Sneha', 'Developer', 2),
(6, 'Ankit', 'Developer', 3);

SELECT
    e.employee_name AS Employee,
    e.job_title AS EmployeeJob,
    m.employee_name AS Manager,
    m.job_title AS ManagerJob
FROM employees e
LEFT JOIN employees m
    ON e.manager_id = m.employee_id;



    -- EXtra practice part not in sir question just random from gpt 

    -- *****************  Find employees under each manager  ****************
    WITH EmployeeHierarchy AS
(
    -- Top-level employee
    SELECT
        employee_id,
        employee_name,
        job_title,
        manager_id,
        0 AS Level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT
        e.employee_id,
        e.employee_name,
        e.job_title,
        e.manager_id,
        h.Level + 1
    FROM employees e
    INNER JOIN EmployeeHierarchy h
        ON e.manager_id = h.employee_id
)
SELECT
    employee_id,
    employee_name,
    job_title,
    manager_id,
    Level
FROM EmployeeHierarchy
ORDER BY Level, employee_id;


/* =========================================================
   7. FIND NAMES STARTING WITH 'M'
      WITHOUT USING LIKE
   ========================================================= */

SELECT EmployeeName
FROM Employees_Hire
WHERE LEFT(EmployeeName, 1) = 'M';
GO


/* =========================================================
   8. FIND 6TH HIGHEST SALARY
   ========================================================= */

SELECT EmployeeName, Salary
FROM
(
    SELECT
        EmployeeName,
        Salary,
        DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees_Hire
) AS X
WHERE SalaryRank = 6;
