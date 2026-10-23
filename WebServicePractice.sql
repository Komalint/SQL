CREATE TABLE tblEmployee
(
    EmployeeId INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    Salary INT NOT NULL,
    Country VARCHAR(50) NOT NULL
);

INSERT INTO tblEmployee (FirstName, Salary, Country) VALUES
('John', 25000, 'USA'),
('David', 32000, 'Canada'),
('Sarah', 28000, 'UK'),
('Michael', 45000, 'Australia'),
('Emma', 38000, 'India'),
('Daniel', 41000, 'Germany'),
('Sophia', 29000, 'France'),
('James', 50000, 'USA'),
('Olivia', 34000, 'Canada'),
('William', 36000, 'UK'),

('Ava', 27000, 'India'),
('Benjamin', 43000, 'Australia'),
('Mia', 39000, 'Germany'),
('Lucas', 31000, 'France'),
('Charlotte', 48000, 'USA'),
('Henry', 35000, 'Canada'),
('Amelia', 26000, 'UK'),
('Alexander', 52000, 'India'),
('Harper', 37000, 'Australia'),
('Ethan', 29500, 'Germany'),

('Evelyn', 40500, 'France'),
('Mason', 44000, 'USA'),
('Abigail', 33000, 'Canada'),
('Logan', 47000, 'UK'),
('Ella', 28500, 'India'),
('Jacob', 39500, 'Australia'),
('Scarlett', 42500, 'Germany'),
('Jackson', 31500, 'France'),
('Grace', 46000, 'USA'),
('Sebastian', 34000, 'Canada'),

('Chloe', 30000, 'UK'),
('Jack', 55000, 'India'),
('Victoria', 41000, 'Australia'),
('Owen', 36500, 'Germany'),
('Lily', 27500, 'France'),
('Samuel', 49000, 'USA'),
('Zoe', 32500, 'Canada'),
('Matthew', 38500, 'UK'),
('Hannah', 27000, 'India'),
('Joseph', 44500, 'Australia'),

('Aria', 33500, 'Germany'),
('Levi', 51000, 'France'),
('Nora', 29000, 'USA'),
('Gabriel', 43000, 'Canada'),
('Layla', 35500, 'UK'),
('Julian', 47000, 'India'),
('Riley', 30500, 'Australia'),
('Aiden', 40000, 'Germany'),
('Penelope', 37500, 'France'),
('Luke', 53000, 'USA');



drop table tblEmployee
CREATE TABLE [tblEmployee]
(
    [Employeeld] [int] IDENTITY(1,1) PRIMARY KEY,
    [FirstName] [nvarchar](50),
    [LastName] [nvarchar](50),
    [DateOfBirth] [datetime],
    [Salary] [int],
    [Gender] [nvarchar](50),
    [DepartmentName] [nvarchar](50),
    [Country] [nvarchar](50)
);
INSERT INTO tblEmployee (FirstName, LastName, DateOfBirth, Salary, Gender, DepartmentName, Country) VALUES 
('John', 'Johnson', '08/10/1982', 55000, 'Male', 'IT', 'US'),
('Pam', 'Roberts', '11/11/1979', 62000, 'Female', 'HR', 'India'),
('David', 'John', '01/15/1980', 45000, 'Male', 'IT', 'UK'),
('Rose', 'Mary', '08/18/1967', 78000, 'Female', 'Payroll', 'South Africa'),
('Mark', 'Mell', '12/10/1974', 69000, 'Male', 'HR', 'Malaysia'),
('Sarah', 'Connor', '05/12/1985', 52000, 'Female', 'IT', 'US'),
('Michael', 'Smith', '03/22/1978', 81000, 'Male', 'Finance', 'UK'),
('Emily', 'Davis', '07/14/1990', 48000, 'Female', 'Marketing', 'India'),
('James', 'Wilson', '11/05/1972', 95000, 'Male', 'Executive', 'US'),
('Jessica', 'Brown', '09/30/1988', 61000, 'Female', 'HR', 'South Africa'),
('Robert', 'Taylor', '02/19/1981', 73000, 'Male', 'Finance', 'Malaysia'),
('Linda', 'Anderson', '06/25/1983', 54000, 'Female', 'IT', 'US'),
('William', 'Thomas', '10/08/1976', 88000, 'Male', 'Operations', 'UK'),
('Elizabeth', 'Jackson', '12/03/1992', 42000, 'Female', 'Customer Support', 'India'),
('Daniel', 'White', '04/17/1987', 67000, 'Male', 'Marketing', 'US'),
('Karen', 'Harris', '01/29/1975', 79000, 'Female', 'Payroll', 'South Africa'),
('Matthew', 'Martin', '08/04/1989', 53000, 'Male', 'IT', 'Malaysia'),
('Nancy', 'Thompson', '03/11/1984', 64000, 'Female', 'Finance', 'US'),
('Anthony', 'Garcia', '07/21/1973', 92000, 'Male', 'Executive', 'UK'),
('Lisa', 'Martinez', '11/16/1991', 46000, 'Female', 'Customer Support', 'India'),
('Kevin', 'Robinson', '05/09/1980', 71000, 'Male', 'Operations', 'US'),
('Betty', 'Clark', '09/14/1986', 58000, 'Female', 'HR', 'South Africa'),
('Brian', 'Rodriguez', '02/27/1977', 83000, 'Male', 'Finance', 'Malaysia'),
('Dorothy', 'Lewis', '06/18/1993', 39000, 'Female', 'Marketing', 'US'),
('George', 'Lee', '10/22/1982', 66000, 'Male', 'IT', 'UK'),
('Sandra', 'Walker', '12/15/1979', 75000, 'Female', 'Payroll', 'India'),
('Kenneth', 'Hall', '04/01/1988', 51000, 'Male', 'Customer Support', 'US'),
('Ashley', 'Allen', '01/07/1984', 63000, 'Female', 'HR', 'South Africa'),
('Steven', 'Young', '08/19/1971', 98000, 'Male', 'Executive', 'Malaysia'),
('Kimberly', 'King', '03/26/1990', 47000, 'Female', 'Marketing', 'US'),
('Edward', 'Wright', '07/12/1976', 82000, 'Male', 'Operations', 'UK'),
('Donna', 'Lopez', '11/30/1985', 56000, 'Female', 'IT', 'India'),
('Ronald', 'Hill', '02/14/1983', 69000, 'Male', 'Finance', 'US'),
('Carol', 'Scott', '06/05/1978', 77000, 'Female', 'Payroll', 'South Africa'),
('Jason', 'Green', '10/11/1989', 50000, 'Male', 'Customer Support', 'Malaysia'),
('Michelle', 'Adams', '12/28/1981', 72000, 'Female', 'HR', 'US'),
('Jeffrey', 'Baker', '04/20/1974', 86000, 'Male', 'Executive', 'UK'),
('Amanda', 'Gonzalez', '09/02/1991', 44000, 'Female', 'Marketing', 'India'),
('Ryan', 'Nelson', '01/18/1987', 68000, 'Male', 'IT', 'US'),
('Melissa', 'Carter', '05/24/1980', 74000, 'Female', 'Finance', 'South Africa'),
('Gary', 'Mitchell', '08/31/1972', 91000, 'Male', 'Operations', 'Malaysia'),
('Deborah', 'Perez', '03/07/1994', 41000, 'Female', 'Customer Support', 'US'),
('Nicholas', 'Roberts', '07/19/1986', 60000, 'Male', 'HR', 'UK'),
('Stephanie', 'Turner', '11/25/1975', 80000, 'Female', 'Payroll', 'India'),
('Eric', 'Phillips', '02/11/1982', 65000, 'Male', 'IT', 'US'),
('Rebecca', 'Campbell', '06/13/1988', 55000, 'Female', 'Marketing', 'South Africa'),
('Stephen', 'Parker', '10/04/1977', 84000, 'Male', 'Executive', 'Malaysia'),
('Sharon', 'Evans', '12/21/1990', 49000, 'Female', 'Customer Support', 'US'),
('Larry', 'Edwards', '04/15/1983', 67000, 'Male', 'Operations', 'UK'),
('Cynthia', 'Collins', '09/08/1979', 76000, 'Female', 'Finance', 'India');

EXEC sp_rename 'tblEmployee.Employeeld', 'EmployeeId', 'COLUMN';

-- procedure insert
create proc udp_InsertEmployeeDetails(
@FirstName nvarchar(50), 
@LastName nvarchar(50), 
@DateOfBirth datetime, 
@Salary int, 
@Gender nvarchar(50), 
@DepartmentName nvarchar(50), 
@Country nvarchar(50)
)as
begin

-- conditions can be applied
	insert into tblEmployee(
	[FirstName], 
	[LastName], 
	[DateOfBirth], 
	[Salary], 
	[Gender], 
	[DepartmentName], 
	[Country]) 
	values(
	@FirstName, 
	@LastName, 
	@DateOfBirth, 
	@Salary, 
	@Gender, 
	@DepartmentName, 
	@Country)
end;

--procedure get all user
alter proc udp_GetallUsers
as
begin
	select
		[EmployeeId],
		[FirstName], 
		[LastName], 
		[DateOfBirth], 
		[Salary], 
		[Gender], 
		[DepartmentName], 
		[Country]
	from tblEmployee
end

exec udp_GetallUsers



--procedure get user by id
alter proc udp_GetUserById(
@id int
)
as
begin
	select
		[FirstName], 
		[LastName], 
		[DateOfBirth], 
		[Salary], 
		[Gender], 
		[DepartmentName], 
		[Country]
	from tblEmployee
	where [EmployeeId]= @id
end



--procedure delete user by id
alter proc udp_DeleteUserById(
@id int
)
as
begin
	delete 
	from tblEmployee 
	where [EmployeeId]= @id
end

--procedure  update employee details via id
alter PROC udp_UpdateEmployeeDetails
(
    @EmployeeId INT,
    @FirstName VARCHAR(50) = NULL,
    @LastName VARCHAR(50) = NULL,
    @DateOfBirth DATE = NULL,
    @Salary DECIMAL(10,2) = NULL,
    @Gender VARCHAR(10) = NULL,
    @DepartmentName VARCHAR(50) = NULL,
    @Country VARCHAR(50) = NULL
)
AS
BEGIN
    UPDATE tblEmployee
    SET
        FirstName = ISNULL(@FirstName, FirstName),
        LastName = ISNULL(@LastName, LastName),
        DateOfBirth = ISNULL(@DateOfBirth, DateOfBirth),
        Salary = ISNULL(@Salary, Salary),
        Gender = ISNULL(@Gender, Gender),
        DepartmentName = ISNULL(@DepartmentName, DepartmentName),
        Country = ISNULL(@Country, Country)
    WHERE EmployeeId = @EmployeeId;
END

select * from tblEmployee


-- dynamic paging procedure

create proc udp_GetEmployees_by_PageIndex_and_PageSize(
@PageIndex int ,
@PageSize int,
@TotalRows int output)
as 
begin
	declare @StartRowIndex int
	declare @EndRowIndex int
	set @StartRowIndex = (@PageIndex * @PageSize)+1;
	set @EndRowIndex = (@PageIndex + 1)*@PageSize;
	select * 
	from
	(select ROW_NUMBER() over(order by EmployeeId) as RowNumber,*
	from tblEmployee) Employees
	where RowNumber >= @StartRowIndex and RowNumber <= @EndRowIndex


	select @TotalRows = COUNT(*) from tblEmployee
end;

declare @totalrow int
exec udp_GetEmployees_by_PageIndex_and_PageSize 0, 20, @totalrow out

print @totalrow

