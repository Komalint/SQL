CREATE TABLE EmployeeMaster
(
    EmployeeId INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DepartmentName NVARCHAR(50)
);


CREATE TABLE EmployeeDetails
(
    DetailId INT IDENTITY(1,1) PRIMARY KEY,

    EmployeeId INT UNIQUE,

    DateOfBirth DATETIME,
    Salary INT,
    Gender NVARCHAR(50),
    Country NVARCHAR(50),

    FOREIGN KEY(EmployeeId)
    REFERENCES EmployeeMaster(EmployeeId)
);


CREATE PROC udp_GetBasicEmployeeDetails
AS
BEGIN
    SELECT
        EmployeeId,
        FirstName + ' ' + LastName AS FullName,
        DepartmentName
    FROM EmployeeMaster;
END;

CREATE PROC spGetEmployeeDetailsByID
    @EmployeeId INT
AS
BEGIN
    SELECT
        m.EmployeeId,
        m.FirstName,
        m.LastName,
        m.FirstName + ' ' + m.LastName AS FullName,
        m.DepartmentName,
        d.DateOfBirth,
        d.Salary,
        d.Gender,
        d.Country
    FROM EmployeeMaster m
    INNER JOIN EmployeeDetails d
        ON m.EmployeeId = d.EmployeeId
    WHERE m.EmployeeId = @EmployeeId;
END;

INSERT INTO EmployeeMaster
(FirstName, LastName, DepartmentName)
VALUES
('John', 'Johnson', 'IT'),
('Pam', 'Roberts', 'HR'),
('David', 'John', 'Finance'),
('Rose', 'Mary', 'Payroll'),
('Mark', 'Mell', 'HR'),
('Sarah', 'Connor', 'IT'),
('Michael', 'Smith', 'Finance'),
('Emily', 'Davis', 'Marketing'),
('James', 'Wilson', 'Executive'),
('Jessica', 'Brown', 'Operations');

INSERT INTO EmployeeDetails
(
    EmployeeId,
    DateOfBirth,
    Salary,
    Gender,
    Country
)
VALUES
(1, '1982-08-10', 55000, 'Male', 'US'),
(2, '1979-11-11', 62000, 'Female', 'India'),
(3, '1980-01-15', 45000, 'Male', 'UK'),
(4, '1967-08-18', 78000, 'Female', 'South Africa'),
(5, '1974-12-10', 69000, 'Male', 'Malaysia'),
(6, '1985-05-12', 52000, 'Female', 'US'),
(7, '1978-03-22', 81000, 'Male', 'UK'),
(8, '1990-07-14', 48000, 'Female', 'India'),
(9, '1972-11-05', 95000, 'Male', 'US'),
(10, '1988-09-30', 61000, 'Female', 'South Africa');

CREATE PROC udp_GetEmployeesMaster_ByPage
(
    @PageIndex INT,
    @PageSize INT,
    @TotalRows INT OUTPUT
)
AS
BEGIN

    SELECT @TotalRows = COUNT(*)
    FROM EmployeeMaster;

    SELECT
        EmployeeId,
        FirstName + ' ' + LastName AS FullName,
        DepartmentName
    FROM EmployeeMaster
    ORDER BY EmployeeId
    OFFSET (@PageIndex - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;

END