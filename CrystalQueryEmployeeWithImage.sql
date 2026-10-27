drop table AllEmployee
CREATE TABLE AllEmployee
(
EmployeeId INT PRIMARY KEY,
FirstName VARCHAR(100),
AnnualSalary DECIMAL(18,2),
Country VARCHAR(100),
Photo VARCHAR(MAX)
);

INSERT INTO AllEmployee
(EmployeeId, FirstName, AnnualSalary, Country, Photo)
VALUES
(1,
'Amit',
50000,
'India',
'C:\Users\komalgupta\Desktop\Images_of_employeee\img1.jpg'),

(2,
'Rahul',
60000,
'India',
'C:\Users\komalgupta\Desktop\Images_of_employeee\img2.jpg'),

(3,
'John',
70000,
'USA',
'C:\Users\komalgupta\Desktop\Images_of_employeee\img3.jpg'),

(4,
'David',
80000,
'South Africa',
'C:\Users\komalgupta\Desktop\Images_of_employeee\img4.jpg'),

(5,
'Sam',
90000,
'Malaysia',
'C:\Users\komalgupta\Desktop\Images_of_employeee\img5.jpg');


CREATE TABLE AllEmployeeWithImage
(
EmployeeId INT PRIMARY KEY,
FirstName VARCHAR(100),
AnnualSalary DECIMAL(18,2),
Country VARCHAR(100),
Photo VARCHAR(MAX)
);

INSERT INTO AllEmployeeWithImage
(EmployeeId, FirstName, AnnualSalary, Country, Photo)
VALUES
(1,
'Amit',
50000,
'India',
'C:\Users\komalgupta\Desktop\Images_of_employeee\img1.jpg'),

(2,
'Rahul',
60000,
'India',
'C:\Users\komalgupta\Desktop\Images_of_employeee\img2.jpg'),

(3,
'John',
70000,
'USA',
'C:\Users\komalgupta\Desktop\Images_of_employeee\img3.jpg'),

(4,
'David',
80000,
'South Africa',
'C:\Users\komalgupta\Desktop\Images_of_employeee\img4.jpg'),

(5,
'Sam',
90000,
'Malaysia',
'C:\Users\komalgupta\Desktop\Images_of_employeee\img5.jpg');