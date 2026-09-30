-- ==========================ASSIGNMENT DAY 2 ====================================

-- ======================1============================
declare @i int=1;
declare @end int = 5;
declare @pattern varchar(100)
while @i < @end
begin 
 set @pattern = replicate('*' , @i);
 print @pattern;
 set @i += 1;
end

-- ======================2============================
declare @i int=1;
declare @endd int = 5;
declare @patternn varchar(100);
declare @ch char = 'A';
declare @j int =0;
while @i < @endd
begin
set @j=0;
set @patternn ='';
while @j < @i
   begin
   set @patternn += char( ascii(@ch)+@j);
   set @j +=1;
end

 print @patternn;
 set @i += 1;
end


-- ======================3============================
declare @i int =2;
declare @num int = 27;
declare @prime bit = 0;

while @i < @num
begin 
	if @num %  @i =0
	set @prime =1
	else
	set @prime = 0
	break;
end
 
 if @prime = 1
  print ('The number '+cast(@num as varchar(5))+' is prime');
 else
  print ('The number '+cast(@num as varchar(5))+' is prime');


-- ======================4============================
CREATE TABLE tempStudent (
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL,
    FatherName VARCHAR(100) NOT NULL
);

-- 2. Insert 12 sample values
INSERT INTO tempStudent (StudentName, FatherName) VALUES
('Aarav Sharma', 'Rajesh Sharma'),
('Diya Patel', 'Amit Patel'),
('Vivaan Gupta', 'Sanjay Gupta'),
('Ananya Iyer', 'Raman Iyer'),
('Kabir Singh', 'Harpreet Singh'),
('Ishaan Reddy', 'Venkat Reddy'),
('Meera Nair', 'Gopal Nair'),
('Arjun Verma', 'Anil Verma'),
('Sai Joshi', 'Pradeep Joshi'),
('Rohan Das', 'Subhash Das'),
('Kriti Mishra', 'Manoj Mishra'),
('Aditya Rao', 'Srinivas Rao');


select concat(StudentName,' -Father-->  ',FatherName) from tempStudent;

select FatherName, COUNT(*) as TotalChildren
from tempStudent
group by FatherName
having count(*) >= 2;





-- ======================5============================
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    employee_id INT IDENTITY(1,1) PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    job_title VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2),
    hire_date DATE NOT NULL,
    manager_id INT,
    CONSTRAINT FK_Employee_Manager FOREIGN KEY (manager_id) 
        REFERENCES employees(employee_id)
);

INSERT INTO employees (employee_name, job_title, salary, hire_date, manager_id) VALUES 
('John Smith', 'Executive', 160000.00, '2023-01-15', NULL),  
('Alice Walton', 'Executive', 175000.00, '2023-03-22', NULL),
('David Chen', 'Manager', 115000.00, '2024-06-01', 1),     
('Sarah Jenkins', 'Manager', 85000.00, '2024-08-12', 2),    
('Michael Brown', 'Developer', 90000.00, '2025-02-10', 3),          
('Elena Rostova', 'Manager', 105000.00, '2025-05-19', 1),
('Emily Davis', 'Developer', 72000.00, DATEADD(month, -1, GETDATE()), 3),     
('Robert Taylor', 'Executive', 60000.00, '2025-11-04', 6),
('William Thomas', 'HR', 55000.00, DATEADD(month, -1, GETDATE()), 4), 
('Linda Martinez', 'Executive', 62000.00, '2026-01-15', 6),
('James Wilson', 'Developer', 95000.00, '2026-03-20', 3),
('Sophia Specialist', 'HR', 58000.00, '2026-04-11', 4),
('Ryan Cooper', 'Developer', 68000.00, DATEADD(month, -1, GETDATE()), 3),
('Oliver Twist', 'HR', 52000.00, '2026-06-02', 4),
('Emma Watson', 'Executive', 61000.00, DATEADD(month, -1, GETDATE()), 6);

SELECT employee_id, employee_name, job_title, hire_date
FROM employees
WHERE hire_date >= '2026-08-01' AND hire_date <= '2026-08-31';


-- ======================7============================
with tem as (
select * , dense_rank() over(order by salary desc) as rank
from employees )
select * from tem
where rank =6

select * 
from (select * , dense_rank() over(order by salary desc) as rank
from employees) t
where t.rank =6



-- ======================8============================
select * from employees where substring(employee_name,1,1) ='E';



-- ======================6============================
select *, row_number() over(partition by manager_id order by manager_id asc) as rank 
from employees 


select  COUNT(e.employee_id) empCount, e.manager_id 
from employees as e group by e.manager_id having e.manager_id is not null--order by e.employee_id