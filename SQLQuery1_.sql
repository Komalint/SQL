-- ------------------------------------------------------
-- Day 1 
-- -------------------------------------------------------

create schema hra;


create table hra.jobs(
	[job_id] int primary key identity,
	[customer_id] int not null, 
	[description] varchar(200),
	[created_at] datetime2 not null ); 

create table [hra].[t1](
	[id] int primary key identity,
	[name] nchar(18) );

insert into  hra.t1 values(N'कोमल') , (N'अभिजीत');
select * from hra.t1;


create table [hra].[child1](
[visit_id] int identity(1,2) primary key ,
[firstName] varchar(50) not null ,
[lastName] varchar(50) not null,
[visited_at] date,
[phone] char(10),
[store_id] int not null,
foreign key ([store_id]) references [sales].[stores] ([store_id]) 
);

insert into [hra].[child1] values('Komal' , 'Gupta' , '2026-11-1' , '7645397468', 2 );
select * from [sales].[stores]

select * from [hra].[child1]


create table [hra].[products2](
	[product_id] int primary key identity,
	[product_name] varchar(100) not null ,
	[category] varchar(15) not null check ([category] in ('Exterior' , 'Interior', 'Dual')) ,
	[finish_type] varchar(15) not null,
	[binder_type] varchar(15) not null,
	[voc_level_g] decimal(5,2) not null,
	[created_at] date default current_timestamp
);

insert into [hra].[products2] values( ' Apex Shield ' , 'Dual' , 'Gloss', 'Pure  Acrylic', 5.2, '2026-11-22') ,
									( 'velvet_interior pure' ,'Interior' ,'Eggshell','Vinyl Acetate', 4.4, '2025-7-25');

select * from [hra].[products2];

-- drop table [hra].[productVarient];
create table [hra].[productVarient](
	[varient_id] int primary key identity,
	[product_id] int foreign key ([product_id]) references [hra].[products2] ([product_id]),
	[baseType] varchar(20) not null,
	[packSize] decimal(5,2) not null,
	[sku_code] varchar(30) unique not null,
	[unit_cost] decimal(10,2) not null,
	[mrp] decimal(10,2) not null
);

insert into [hra].[productVarient] values (2,'Deep Base',4.00, 'AS-INT-W-4', 1000 ,4200),
										(1,'White Base',6.00, 'AS-DU-W-6', 1000 ,6200);

select * from [hra].[productVarient];

select * from [hra].[products2] a left JOIN [hra].[productVarient] pv on a.[product_id]=pv.[product_id] 


-- ----------------------------------------------------------------------------
--                             DAY 2
-- ----------------------------------------------------------------------------

create table [hra].[demo2](
	[id] int identity(101,1) primary key,
	[name] varchar(18) not null
);

alter table [hra].[demo2] add [address] varchar(50) not null ;

insert into [hra].[demo2] values('Komal','11 baleghata'), ('Avijit' , 'Belgharia');
select * from [hra].[demo2];

alter table [hra].[demo2] alter column name nvarchar(15);

insert into [hra].[demo2] values(N'कोमल','Technopolice'), (N'अभिजीत' , 'Dhapa bypass');
select * from [hra].[demo2];


alter table [hra].[demo2] drop column [address];

truncate table hra.demo2

delete from [hra].[demo2]

sp_help 'hra.demo2'

-- for maual initialization of the identity column & then after this we need to off the identity insert part to auto increment part 
set identity_insert [hra].[demo2] on 
insert into [hra].[demo2](id,name,address) values(121,N'कोमल','Technopolice'), (122,N'अभिजीत' , 'Dhapa bypass');

set identity_insert [hra].[demo2] on 

select * from [sales].[customers]

select * into [#pemp_ny] from [sales].[customers] where state ='NY'collate sql_latin1_general_cp1_cs_as                                                                                   ;

select * from [#pemp_ny]


-- tempdb or the db in whihch the coresponding table lies , needs to be kept active for executing this command successfully , otherwise it will throw an error , so if you don't want the error use the command and the db properly , it's really very important to keep this one in mind!!!
sp_help 'tempdb.#pemp_ny'


create table [hra].[department](
 [dp_id] int identity primary key,
 [name] varchar(20) not null ,
 [location] varchar (20) not null
 );

 drop table [hra].[employee];
 create table [hra].[employee](
 [emp_id] int identity(101,1) primary key,
 [ename] varchar(20) not null ,
 [dpt_id] int not null foreign key ([dpt_id]) references [hra].[department] ([dp_id]) on update cascade on delete cascade,
 [join_d] date not null,
 [salary] int not null
 );


 -- Insert values into the department table
INSERT INTO [hra].[department] ([name], [location])
VALUES 
('Human Resources', '1st floor'),
('Engineering', '2nd floor'),
('Finance', '3rd floor'),
('Marketing', '1st floor')


-- Insert values into the employee table
-- Note: dpt_id values must match the dp_id values generated in the department table (1, 2, 3, 4)
INSERT INTO [hra].[employee] ([ename], [dpt_id], [join_d], [salary])
VALUES 
('Alice Smith', 1, '2024-01-15', 75000),
('Bob Jones', 2, '2023-05-10', 105000),
('Charlie Brown', 2, '2024-03-01', 95000),
('Diana Prince', 3, '2022-11-20', 88000),
('Evan Wright', 4, '2025-02-18', 67000),
('Amit Srivastav', 1, '2024-01-15', 75000),
('Komal Gupta', 2, '2023-05-10', 105000),
('Mark Brown', 2, '2024-03-01', 95000),
('Avijit Prince', 3, '2022-11-20', 88000),
('Anubhaw Gupta', 4, '2025-02-18', 67000);


select * from [hra].[department];
select *  from [hra].[employee];


delete from [hra].[department] where dp_id=4;



-- ------------------------------------------------------------
--                    DAY 3
-- ------------------------------------------------------------

create table [hra].[books](
	[book_id] int primary key identity(001,1),
	[b_name] varchar(20) not null,
	[price] int not null constraint [check_book_price] check ([price] >0) 
	);


create table [hra].[student](
	[st_id] int primary key not null,
	[st_name] varchar(20) not null ,
	[class] nchar(2) not null
	);


create table [hra].[library](
	[bk_id] int not null,
	[std_id] int not null,
	[issue_date] date not null,
	 CONSTRAINT PK_library PRIMARY KEY ([bk_id], [std_id])
	);

INSERT INTO [hra].[books] ([b_name], [price]) VALUES 
(N'The Hobbit', 500),
(N'Harry Potter', 750),
(N'1984', 420),
(N'The Great Gatsby', 450),
(N'Moby Dick', 550);

INSERT INTO [hra].[student] ([st_id], [st_name], [class]) VALUES 
(101, N'John Doe', N'Ⅰ'),
(102, N'Jane Smith', N'Ⅴ'),
(103, N'Alex Jones', N'Ⅹ'),
(104, N'Emma Watson', N'Ⅻ'),
(105, N'Liam Neeson', N'Ⅺ');

INSERT INTO [hra].[library] ([bk_id], [std_id], [issue_date]) VALUES 
(1, 101, '2026-09-10'),
(2, 102, '2026-09-12'),
(3, 103, '2026-09-15'),
(4, 104, '2026-09-16'),
(5, 105, '2026-09-17');


INSERT INTO [hra].[library] ([bk_id], [std_id], [issue_date]) VALUES (3, 102, '2026-09-15'),(5, 104, '2026-09-17');

select * from [hra].[books]
select * from [hra].[student]
select * from [hra].[library]


-- unique kwy constraint---------------------------------------------*********************************************
drop table hra.books1 ;
create table [hra].[books1](
	[book_id] int primary key identity(001,1),
	[b_name] varchar(20) not null,
	[price] int not null constraint [check_book_price_notneg] check ([price] >0) 
	);

	drop table hra.student1;
create table [hra].[student1](
	[st_id] int primary key not null,
	[st_name] varchar(20) not null ,
	[class] nchar(2) not null,
	[phone] char(10) constraint Check_student1_unique_phone unique([phone]),
	[email] varchar(15) constraint check_student1_unique_email unique([email])
	);

drop table hra.library1;
create table [hra].[library1](
	[bk_id] int not null,
	[std_id] int not null,
	[issue_date] date not null,
	 CONSTRAINT PKy_library PRIMARY KEY ([bk_id], [std_id])
	);

INSERT INTO [hra].[books1] ([b_name], [price]) VALUES 
(N'The Hobbit', 500),
(N'Harry Potter', 750),
(N'1984', 420),
(N'The Great Gatsby', 450),
(N'Moby Dick', 550);

INSERT INTO [hra].[student1]  VALUES 
(101, N'John Doe', N'Ⅰ', '9876543210', 'john@gmail.com'),
(102, N'Jane Smith', N'Ⅴ', '9876543211', 'jane@gmail.com'),
(103, N'Alex Jones', N'Ⅹ', '9876543212', 'alex@gmail.com'),
(104, N'Emma Watson', N'Ⅻ', '9876543213', 'emma@gmail.com'),
(105, N'Liam Neeson', N'Ⅺ', '9876543214',null);


INSERT INTO [hra].[library1] ([bk_id], [std_id], [issue_date]) VALUES 
(1, 101, '2026-09-10'),
(2, 102, '2026-09-12'),
(3, 103, '2026-09-15'),
(4, 104, '2026-09-16'),
(5, 105, '2026-09-17'),
(3, 102, '2026-09-15'),
(5, 104, '2026-09-17');




select * from [hra].[books1]
select * from [hra].[student1]
select * from [hra].[library1]

-- to check new
INSERT INTO [hra].[student1]  VALUES 
(106, N'John Doe', N'Ⅰ', '9876543210', 'john@gmail.co'),
(107, N'Liam Neeson', N'Ⅺ', '9876543214',null);


alter table [hra].[books1] add  [purchase_date] date default getdate();

-- bulk import 
CREATE TABLE hra.Demo (
    [CustomerID] VARCHAR(20) PRIMARY KEY,
    [FirstName] VARCHAR(100),
    [LastName] VARCHAR(100),
    [Company] VARCHAR(200),
    [Email] VARCHAR(255),
    [Phone] VARCHAR(50),
    [Address1] VARCHAR(255),
    [Address2] VARCHAR(255),
    [City] VARCHAR(100),
    [State] VARCHAR(100),
    [PostalCode] VARCHAR(20),
    [Country] VARCHAR(100)
);
bulk insert [hra].[Demo] from 'D:\Komal\customer_import_template_100_rows.csv'
with
(
firstrow=2,
lastrow=50,
fieldterminator = ',',
rowterminator='\n'
);
-- -----------------------------------------manually i imported the dataset define the schema ahead---------
select * from hra.Customer_Detail;


-- -------------------------------------------------------
--                  DAY 4
-- -------------------------------------------------------


SELECT DISTINCT [std_id]
FROM [hra].[library1]
ORDER BY [std_id];


SELECT *
FROM [hra].[books1]
WHERE price IN (420, 450, 500)
ORDER BY price DESC;


SELECT *
FROM [hra].[books1]
ORDER BY price 
OFFSET 1 row
FETCH NEXT 3 ROWS ONLY;

SELECT *
FROM [hra].[books1]
WHERE [book_id] =4 or [book_id] = 1 and [price] >470





SELECT SUM( CASE WHEN order_status = 1 THEN 1 ELSE 0 END) AS 'Pending',
SUM( CASE WHEN order_status = 2 THEN 1 ELSE 0 END) AS 'Processing',
SUM( CASE WHEN order_status = 3 THEN 1 ELSE 0 END) AS 'Rejected',
SUM( CASE WHEN order_status = 4 THEN 1 ELSE 0 END) AS 'Completed',
COUNT(*) AS Total
FROM sales.orders
WHERE YEAR(order_date) = 2018;


SELECT o.order_id, SUM(quantity * list_price) order_value,
CASE WHEN SUM(quantity * list_price) <= 500
THEN 'Very Low'
WHEN SUM(quantity * list_price) > 500 AND
SUM(quantity * list_price) <= 1000
THEN 'Low'
WHEN SUM(quantity * list_price) > 1000 AND
SUM(quantity * list_price) <= 5000
THEN 'Medium'
WHEN SUM(quantity * list_price) > 5000 AND
SUM(quantity * list_price) <= 10000
THEN 'High'
WHEN SUM(quantity * list_price) > 10000
THEN 'Very High'
END order_priority
FROM sales.orders o INNER JOIN sales.order_items i ON i.order_id = o.order_id
WHERE YEAR(order_date) = 2018
GROUP BY o.order_id;



-- Merge stable

create table hra.studentT (
[studentId] INT PRIMARY KEY IDENTITY,
[name] VARCHAR(50) NOT NULL,
[email] VARCHAR(30) NOT NULL CONSTRAINT check_email_uniqueness UNIQUE(email),
[phone] VARCHAR(15) NOT NULL CONSTRAINT check_phone_uniqueness UNIQUE(phone),
[age] INT NOT NULL CONSTRAINT check_juniorStudents CHECK(20<=[age] and [age] >=10),

)

alter table hra.student add [fees] DECIMAL(6,2) CONSTRAINT default_value DEFAULT(900.50)

INSERT INTO hra.studentT ([name], [email], [phone], [age])
VALUES
('Rohit gupta',   'rohit2.gupta@gmail.com',   '9876503219', 24),
('Rahul Sharma',  'rahul.sharma@gmail.com',  '9876543210', 20),
('Priya Singh',   'priya.singh@gmail.com',   '9876543211', 21),
('Amit Kumar',    'amit.kumar@gmail.com',    '9876543212', 22),
('Neha Verma',    'neha.verma@gmail.com',    '9876543213', 23),
('Rohit Gupta',   'rohit.gupta@gmail.com',   '9876543214', 24),
('Sneha Jain',    'sneha.jain@gmail.com',    '9876543215', 25),
('Vikas Yadav',   'vikas.yadav@gmail.com',   '9876543216', 26),
('Pooja Mishra',  'pooja.mishra@gmail.com',  '9876543217', 27),
('Karan Mehta',   'karan.mehta@gmail.com',   '9876543218', 28),
('Anjali Patel',  'anjali.patel@gmail.com',  '9876543219', 29);
select * from hra.studentT;
select * from hra.student_source;


create table hra.student_source (
[studentId] INT PRIMARY KEY IDENTITY,
[name] VARCHAR(50) NOT NULL,
[email] VARCHAR(30) NOT NULL ,
[phone] VARCHAR(15) NOT NULL ,
[age] INT NOT NULL

)

INSERT INTO hra.student_source ([name], [email], [phone], [age])
VALUES
-- Existing emails, changed data (UPDATE cases)
('Rohit Gupta',    'rohit2.gupta@gmail.com',   '9999999991', 25),
('Rahul Sharma',   'rahul.sharma@gmail.com',   '9999999992', 21),
('Priya Singh',    'priya.singh@gmail.com',    '9999999993', 22),
('Amit Kumar',     'amit.kum4r@gmail.com',     '9999999994', 23),
('Neha Verma',     'neha.verma@gmail.com',     '9999999995', 24),

-- Existing emails, unchanged data (MATCHED but no actual changes)
('Sneha Jain',     'sneha.jain@gmail.com',     '9876543215', 25),
('Vikas Yadav',    'vikas.yadav11@gmail.com',  '9876543216', 26),

-- New rows (INSERT cases)
('Arjun Kapoor',   'arjun.kapoor@gmail.com',   '9999999996', 30),
('Meera Joshi',    'meera.joshi@gmail.com',    '9999999997', 27),
('Riya Malhotra',  'riya.malhotra@gmail.com',  '9999999998', 22);

INSERT INTO hra.studentT ([name], [email], [phone], [age])
VALUES
('Deleted User 1', 'deleted1@gmail.com', '9000000001', 30),
('Deleted User 2', 'deleted2@gmail.com', '9000000002', 31),
('Deleted User 3', 'deleted3@gmail.com', '9000000003', 32);



MERGE hra.studentT AS T
USING hra.student_source AS S
ON T.email = S.email

WHEN MATCHED THEN
    UPDATE SET
        T.name  = S.name,
        T.phone = S.phone,
        T.age   = S.age

WHEN NOT MATCHED BY TARGET THEN
    INSERT (name, email, phone, age)
    VALUES (S.name, S.email, S.phone, S.age)

WHEN NOT MATCHED BY SOURCE THEN
    DELETE;



