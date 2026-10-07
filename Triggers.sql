-- Triggers


CREATE TRIGGER trUpdateEmployee ON Employee
FOR UPDATE
AS
BEGIn
PRINT 'YOU CANNOT PERFORM UPDATE OPERATION'
ROLLBACK TRANSACTION
END

drop table storedTransaction
create table storedTransaction(
trancid int primary key identity,
 tranAmt int not null,
 tranType varchar(20) not null check(tranType in ('Debit','credit','failed')),
 tranDate date)
 INSERT INTO StoredTransaction
VALUES
(5000, 'Debit', '2026-10-01'),
(2500, 'Credit', '2026-10-02'),
(1000, 'Failed', '2026-10-03'),
(7500, 'Debit', '2026-10-04'),
(3000, 'Credit', '2026-10-05');


drop trigger trNoUpdateDelete
create trigger 
trNoUpdateDelete on StoredTransaction
for update, delete
as
begin
print 'YOU CANNOT PERFORM UPDATE OR DELETE OPERATION'
rollback transaction
end

UPDATE StoredTransaction
SET tranAmt =
CASE trancid
WHEN 1 THEN 40000
WHEN 2 THEN 90000
ELSE tranAmt
END;

update StoredTransaction set tranAmt = 1000000 where trancid =1

drop  trigger tr_updatedTransactions
create trigger tr_updatedTransactions on StoredTransaction
for update
as 
begin
select * from inserted
end


select * from StoredTransaction


-- we are storing logs if any changes are made in the table by inserting


CREATE TABLE EmployeeAudit
(
ID INT IDENTITY(1,1) PRIMARY KEY,
AuditData VARCHAR(MAX),
AuditDate DATETIME
)
CREATE TRIGGER tr_Employee_For_Insert ON Employee
FOR INSERT
AS
BEGIN
-- Declare a variable to hold the ID Value
DECLARE @ID INT
-- Declare a variable to hold the Name value
DECLARE @Name VARCHAR(100)
-- Declare a variable to hold the Audit data
DECLARE @AuditData VARCHAR(100)
-- Get the ID and Name from the INSERTED Magic table
SELECT @ID = EmployeeId, @Name = EmployeeName FROM INSERTED
-- Set the AuditData to be stored in the EmployeeAudit table
SET @AuditData = 'New employee Added with ID = ' + Cast(@ID AS VARCHAR(10)) + ' and Name ' + @Name
-- Insert the data into the EmployeeAudit table
INSERT INTO EmployeeAudit (AuditData, AuditDate) VALUES(@AuditData, GETDATE())
END

insert into Employee values ( 'Komal Gupta', 47730)

select * from EmployeeAudit