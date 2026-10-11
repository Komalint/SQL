-- Trigger

CREATE TABLE Emp
(
    EmpId INT IDENTITY PRIMARY KEY,
    EmpName VARCHAR(50),
    Salary DECIMAL(10,2),
    Department VARCHAR(50)
);

INSERT INTO Emp
VALUES
('John',50000,'IT'),
('David',60000,'HR'),
('Smith',70000,'Finance');


CREATE TABLE EmployeeAudit
(
    AuditId INT IDENTITY PRIMARY KEY,
    EmpId INT,
    ActionType VARCHAR(20),
    OldSalary DECIMAL(10,2),
    NewSalary DECIMAL(10,2),
    ActionDate DATETIME DEFAULT GETDATE()
);



CREATE TRIGGER trg_AfterInsert
ON Emp
AFTER INSERT
AS
BEGIN
    PRINT 'New Employee Added';
END;

INSERT INTO Emp
VALUES ('James',80000,'IT');


CREATE TRIGGER trg_AfterUpdate
ON Emp
AFTER UPDATE
AS
BEGIN
    INSERT INTO EmployeeAudit
    (
        EmpId,
        ActionType,
        OldSalary,
        NewSalary
    )
    SELECT
        d.EmpId,
        'UPDATE',
        d.Salary,
        i.Salary
    FROM deleted d
    JOIN inserted i
        ON d.EmpId = i.EmpId;
END;

UPDATE Emp
SET Salary = 105000
WHERE EmpId = 1;

SELECT * FROM EmployeeAudit;

CREATE TRIGGER trg_AfterDelete
ON Emp
AFTER DELETE
AS
BEGIN
    INSERT INTO EmployeeAudit
    (
        EmpId,
        ActionType,
        OldSalary
    )
    SELECT
        EmpId,
        'DELETE',
        Salary
    FROM deleted;
END;


DELETE FROM Emp
WHERE EmpId = 3;



CREATE TRIGGER trg_AllOperations
ON Employees
AFTER INSERT, UPDATE, DELETE
AS
BEGIN

    IF EXISTS(SELECT * FROM inserted)
       AND EXISTS(SELECT * FROM deleted)
    BEGIN
        PRINT 'UPDATE OCCURRED';
    END

    ELSE IF EXISTS(SELECT * FROM inserted)
    BEGIN
        PRINT 'INSERT OCCURRED';
    END

    ELSE IF EXISTS(SELECT * FROM deleted)
    BEGIN
        PRINT 'DELETE OCCURRED';
    END

END;

INSERT INTO Emp
VALUES ('Tom',40000,'IT');