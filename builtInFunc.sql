/*=========================================================
CREATE TABLE
=========================================================*/
CREATE TABLE labTest.employee
(
emp_id INT IDENTITY PRIMARY KEY,
emp_name VARCHAR(20),
nickname VARCHAR(5),
email VARCHAR(50),
phone VARCHAR(15),
salary DECIMAL(10,2)
);

/*=========================================================
INSERT DATA
=========================================================*/
INSERT INTO labTest.employee
(emp_name, nickname, email, phone, salary)
VALUES
('Anubhaw', NULL, 'anubhaw@gmail.com', NULL, 50000),
('Rahul', 'Rocky', NULL, '9876543210', 45000),
('Priya', NULL, NULL, NULL, NULL),
('Amit', 'Amit', 'amit@gmail.com', '9999999999', 60000);

/*=========================================================
EXAMPLE 1 : SIMPLE NULL REPLACEMENT
=========================================================*/

SELECT
*
FROM labTest.employee;

SELECT
emp_name,
salary,
ISNULL(salary, 0) AS salary_using_isnull,
COALESCE(salary, 0) AS salary_using_coalesce
FROM labTest.employee;

For Priya:
salary = NULL
ISNULL -> 0
COALESCE -> 0
Both give same result.


/*=========================================================
EXAMPLE 2 : MULTIPLE FALLBACK VALUES
=========================================================*/
SELECT
*
FROM labTest.employee;
SELECT
emp_name,
email,
phone,
COALESCE(email, phone, 'Contact Not Available')
AS preferred_contact,
ISNULL(email,'Contact Not Available done by isNUll') as isnullCol -- Works for only a single column , means we'l;l have ot use two columns for emaila nd phone while Coalesce usese a single one for both
FROM labTest.employee;
/*
Anubhaw -> email available
Rahul -> email NULL, phone returned
Priya -> both NULL, default text returned
ISNULL cannot do this in one function call.
*/

/*=========================================================
EXAMPLE 3 : DATA TYPE DIFFERENCE
=========================================================*/
DECLARE @nickName VARCHAR(5);
SET @nickName = NULL;
/* ISNULL takes datatype of FIRST argument */
SELECT
ISNULL(@nickName, 'ABCDEFGHIJ') AS isnull_result;
/*
Result:
ABCDE
Why?
@nickName is VARCHAR(5)
Therefore ISNULL returns VARCHAR(5)
String gets truncated.
*/

/*=========================================================
EXAMPLE 4 : COALESCE DATA TYPE BEHAVIOUR
=========================================================*/
DECLARE @nickName2 VARCHAR(5);
SET @nickName2 = NULL;
SELECT
COALESCE(@nickName2,
CAST('ABCDEFGHIJ' AS VARCHAR(10)))
AS coalesce_result;
/*
Result:
ABCDEFGHIJ
No truncation.
COALESCE determines datatype differently.
*/

/=========================================================
EXAMPLE 5 : REAL-LIFE CONTACT SEARCH
=========================================================/
SELECT
*
FROM labTest.employee;
SELECT
emp_id,
emp_name,
COALESCE(
email,
phone,
nickname,
'NO CONTACT DETAILS'
) AS first_available_contact
FROM labTest.employee;
/*
Checks in order:
email
phone
nickname
default text
Returns first non-NULL value.
*/


-- ==================================Scope Identity  -> scope_identity / @@identity ===================================

select scope_identity()
CREATE TABLE labTest.Employees
(
    EmployeeId INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100)
);

INSERT INTO labTest.Employees(Name)
VALUES ('Komal');

select scope_identity()

SELECT @@IDENTITY;

INSERT INTO labTest.Employees(Name)
VALUES ('Rita' ),( 'Gita');



-- ================================== IIF 
CREATE TABLE Employee
(
    EmployeeId INT IDENTITY(1,1),
    EmployeeName VARCHAR(100),
    Salary DECIMAL(10,2)
);

INSERT INTO Employee(EmployeeName, Salary)
VALUES
('Komal', 60000),
('Rahul', 30000),
('Priya', 75000);


SELECT
    EmployeeName,
    Salary,
    IIF(Salary >= 50000, 'High Salary', 'Low Salary') AS SalaryStatus
FROM Employee;


SELECT
    EmployeeName,
    Salary,
    IIF(
        Salary >= 100000,
        'Grade A',
        IIF(
            Salary >= 70000,
            'Grade B',
            IIF(
                Salary >= 50000,
                'Grade C',
                'Grade D'
            )
        )
    ) AS EmployeeGrade
FROM Employee;



