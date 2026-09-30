USE workDB;


/* =========================================================
   SQL SERVER - WINDOW FUNCTIONS PRACTICE
   ROW_NUMBER(), RANK(), DENSE_RANK()
   ========================================================= */

/* 1. CREATE TABLE */

DROP TABLE IF EXISTS EmployeeSalary;
GO

CREATE TABLE EmployeeSalary
(
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    Salary INT
);
GO


/* 2. INSERT SAMPLE DATA */

INSERT INTO EmployeeSalary
(EmployeeID, EmployeeName, Department, Salary)
VALUES
(1, 'Amit',   'IT',        80000),
(2, 'Rahul',  'IT',        70000),
(3, 'Priya',  'IT',        70000),
(4, 'Sneha',  'HR',        60000),
(5, 'Riya',   'HR',        60000),
(6, 'Ankit',  'Finance',   90000),
(7, 'Raj',    'Finance',   80000),
(8, 'Neha',   'Finance',   70000),
(9, 'Sumit',  'IT',        60000),
(10,'Pooja',  'HR',        50000);
GO


/* =========================================================
   3. ROW_NUMBER()
   Gives a UNIQUE sequential number to every row.
   Even if salary is same, row numbers are different.
   ========================================================= */

SELECT
    EmployeeName,
    Department,
    Salary,
    ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNum
FROM EmployeeSalary;
GO


/* =========================================================
   4. RANK()
   Same salary gets the same rank.
   After a tie, ranks are SKIPPED.
   ========================================================= */

SELECT
    EmployeeName,
    Department,
    Salary,
    RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM EmployeeSalary;
GO


/* =========================================================
   5. DENSE_RANK()
   Same salary gets the same rank.
   But ranks are NOT skipped after a tie.
   ========================================================= */

SELECT
    EmployeeName,
    Department,
    Salary,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM EmployeeSalary;
GO


/* =========================================================
   6. 2ND HIGHEST SALARY
   Using DENSE_RANK()
   ========================================================= */

SELECT EmployeeName, Salary
FROM
(
    SELECT
        EmployeeName,
        Salary,
        DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM EmployeeSalary
) AS X
WHERE SalaryRank = 2;
GO


/* =========================================================
   7. 3RD HIGHEST SALARY
   Using DENSE_RANK()
   ========================================================= */

SELECT EmployeeName, Salary
FROM
(
    SELECT
        EmployeeName,
        Salary,
        DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM EmployeeSalary
) AS X
WHERE SalaryRank = 3;
GO


/* =========================================================
   8. ROW_NUMBER() BY DEPARTMENT
   Ranking starts again for each department.
   ========================================================= */

SELECT
    EmployeeName,
    Department,
    Salary,
    ROW_NUMBER() OVER
    (
        PARTITION BY Department
        ORDER BY Salary DESC
    ) AS RowNum
FROM EmployeeSalary;
GO


/* =========================================================
   9. RANK() BY DEPARTMENT
   ========================================================= */

SELECT
    EmployeeName,
    Department,
    Salary,
    RANK() OVER
    (
        PARTITION BY Department
        ORDER BY Salary DESC
    ) AS DeptRank
FROM EmployeeSalary;
GO


/* =========================================================
   10. DENSE_RANK() BY DEPARTMENT
   ========================================================= */

SELECT
    EmployeeName,
    Department,
    Salary,
    DENSE_RANK() OVER
    (
        PARTITION BY Department
        ORDER BY Salary DESC
    ) AS DeptRank
FROM EmployeeSalary;
GO


/* =========================================================
   11. HIGHEST PAID EMPLOYEE FROM EACH DEPARTMENT
   ========================================================= */

SELECT EmployeeName, Department, Salary
FROM
(
    SELECT
        EmployeeName,
        Department,
        Salary,
        DENSE_RANK() OVER
        (
            PARTITION BY Department
            ORDER BY Salary DESC
        ) AS DeptRank
    FROM EmployeeSalary
) AS X
WHERE DeptRank = 1;
GO


/* =========================================================
   12. TOP 2 SALARY RANKS FROM EACH DEPARTMENT
   ========================================================= */

SELECT EmployeeName, Department, Salary
FROM
(
    SELECT
        EmployeeName,
        Department,
        Salary,
        DENSE_RANK() OVER
        (
            PARTITION BY Department
            ORDER BY Salary DESC
        ) AS DeptRank
    FROM EmployeeSalary
) AS X
WHERE DeptRank <= 2;
GO