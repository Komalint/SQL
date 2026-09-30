create schema pvt

CREATE TABLE pvt.Customers
(
CustomerName VARCHAR(50),
ProductName VARCHAR(50),
Amount INT
)
INSERT INTO pvt.Customers (CustomerName, ProductName, Amount)
VALUES
('James', 'Laptop', 30000),
('James', 'Desktop', 25000),
('David', 'Laptop', 25000),
('Smith', 'Desktop', 30000),
('Pam', 'Laptop', 45000),
('Pam', 'Laptop', 30000),
('John', 'Desktop', 30000),
('John', 'Desktop', 30000),
('John', 'Laptop', 30000);


select CustomerName , Laptop, Desktop 
from (select CustomerName, ProductName, Amount from pvt.Customers) as pivotD

pivot( sum(Amount) for ProductName in (Laptop,Desktop)
) as pivot_table



-- GPT Question solving

CREATE TABLE pvt.StudentMarks
(
    StudentName VARCHAR(50),
    SubjectName VARCHAR(50),
    Marks INT
);

INSERT INTO pvt.StudentMarks
VALUES
('John', 'Math', 85),
('John', 'Science', 90),
('John', 'English', 78),

('Mary', 'Math', 92),
('Mary', 'Science', 88),
('Mary', 'English', 95),

('David', 'Math', 75),
('David', 'Science', 80),
('David', 'English', 70),

('Sarah', 'Math', 89),
('Sarah', 'Science', 95),
('Sarah', 'English', 91),
('John', 'Math', 89);

select StudentName , Math , Science, English , (ISNULL(Math,0) + ISNULL(Science,0) + ISNULL(English,0))/3 AS TotalMarks
from (
		select StudentName , SubjectName , Marks from pvt.StudentMarks) 
	as pvtD

pivot( max(Marks) for SubjectName in (Math, Science, English) ) as pivotTable

