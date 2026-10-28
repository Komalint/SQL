CREATE TABLE [hra].[Orders]
(
    [OrderId] INT IDENTITY(1,1) PRIMARY KEY,
    [StoreId] INT,
    [StoreName] NVARCHAR(100),
    [CustomerName] NVARCHAR(100),
    [ProductName] NVARCHAR(100),
    [OrderDate] DATETIME,
    [Quantity] INT,
    [TotalAmount] INT,
    [PaymentMethod] NVARCHAR(50),
    [DeliveryCity] NVARCHAR(100)
);
GO

INSERT INTO hra.Orders
(StoreId,StoreName,CustomerName,ProductName,OrderDate,Quantity,TotalAmount,PaymentMethod,DeliveryCity)
VALUES
(1,'TechZone','Komal Gupta','Wireless Mouse','2026-01-10',2,1200,'UPI','Delhi'),
(1,'TechZone','Rahul Sharma','Keyboard','2026-01-11',1,1500,'Card','Mumbai'),
(1,'TechZone','Priya Singh','Monitor','2026-01-12',1,12000,'NetBanking','Pune'),
(1,'TechZone','Aman Verma','Pendrive','2026-01-13',3,1800,'Cash','Jaipur'),
(1,'TechZone','Neha Gupta','Laptop Stand','2026-01-14',2,2000,'UPI','Lucknow'),

(2,'FashionHub','Rohit Jain','T-Shirt','2026-01-15',2,1000,'Card','Delhi'),
(2,'FashionHub','Anjali Mehta','Jeans','2026-01-16',1,1800,'UPI','Mumbai'),
(2,'FashionHub','Vikas Kumar','Jacket','2026-01-17',1,3500,'Cash','Pune'),
(2,'FashionHub','Pooja Sharma','Dress','2026-01-18',2,4000,'Card','Jaipur'),
(2,'FashionHub','Mohit Gupta','Shoes','2026-01-19',1,2500,'UPI','Noida'),

(3,'HomeMart','Karan Singh','Mixer Grinder','2026-01-20',1,3500,'Card','Delhi'),
(3,'HomeMart','Ritu Jain','Cookware Set','2026-01-21',1,5000,'UPI','Agra'),
(3,'HomeMart','Aakash Singh','Table Lamp','2026-01-22',2,1800,'Cash','Kanpur'),
(3,'HomeMart','Sneha Verma','Wall Clock','2026-01-23',1,1200,'Card','Chandigarh'),
(3,'HomeMart','Arjun Kapoor','Vacuum Cleaner','2026-01-24',1,8500,'UPI','Mumbai'),

(4,'BookWorld','Nidhi Gupta','SQL Server Guide','2026-01-25',1,700,'UPI','Delhi'),
(4,'BookWorld','Harsh Jain','C# Programming','2026-01-26',1,900,'Card','Lucknow'),
(4,'BookWorld','Rakesh Singh','ASP.NET Book','2026-01-27',2,1600,'Cash','Bhopal'),
(4,'BookWorld','Kriti Sharma','Data Structures','2026-01-28',1,800,'UPI','Pune'),
(4,'BookWorld','Saurabh Verma','Algorithms','2026-01-29',1,950,'Card','Indore'),

(5,'SportsArena','Yash Gupta','Cricket Bat','2026-02-01',1,2500,'UPI','Delhi'),
(5,'SportsArena','Ayushi Jain','Football','2026-02-02',2,1800,'Card','Mumbai'),
(5,'SportsArena','Vivek Sharma','Tennis Racket','2026-02-03',1,3500,'Cash','Jaipur'),
(5,'SportsArena','Rohan Singh','Gym Gloves','2026-02-04',3,900,'UPI','Pune'),
(5,'SportsArena','Payal Verma','Yoga Mat','2026-02-05',2,1400,'Card','Noida'),

(6,'BeautyStore','Shreya Jain','Face Wash','2026-02-06',2,600,'UPI','Delhi'),
(6,'BeautyStore','Simran Gupta','Lipstick','2026-02-07',3,1200,'Card','Mumbai'),
(6,'BeautyStore','Megha Sharma','Perfume','2026-02-08',1,2500,'Cash','Pune'),
(6,'BeautyStore','Ritika Singh','Shampoo','2026-02-09',2,900,'UPI','Jaipur'),
(6,'BeautyStore','Divya Verma','Skin Care Kit','2026-02-10',1,3200,'Card','Lucknow'),

(7,'ToyLand','Aarav Gupta','Toy Car','2026-02-11',2,800,'UPI','Delhi'),
(7,'ToyLand','Kabir Sharma','Lego Set','2026-02-12',1,2500,'Card','Mumbai'),
(7,'ToyLand','Myra Jain','Puzzle Game','2026-02-13',2,600,'Cash','Pune'),
(7,'ToyLand','Ishita Singh','Doll House','2026-02-14',1,1800,'UPI','Jaipur'),
(7,'ToyLand','Vivaan Gupta','Remote Car','2026-02-15',1,2200,'Card','Noida'),

(8,'MobileGalaxy','Aditya Sharma','iPhone 15','2026-02-16',1,75000,'UPI','Delhi'),
(8,'MobileGalaxy','Manav Jain','Samsung S25','2026-02-17',1,68000,'Card','Mumbai'),
(8,'MobileGalaxy','Tanya Gupta','OnePlus 14','2026-02-18',1,45000,'NetBanking','Pune'),
(8,'MobileGalaxy','Naman Verma','Realme GT','2026-02-19',1,32000,'Cash','Jaipur'),
(8,'MobileGalaxy','Khushi Singh','Redmi Note','2026-02-20',2,36000,'UPI','Lucknow'),

(1,'TechZone','Deepak Sharma','Webcam','2026-02-21',1,2500,'Card','Delhi'),
(2,'FashionHub','Pankaj Gupta','Cap','2026-02-22',2,800,'UPI','Agra'),
(3,'HomeMart','Sonia Jain','Curtains','2026-02-23',1,2200,'Card','Kanpur'),
(4,'BookWorld','Gaurav Sharma','Design Patterns','2026-02-24',1,1100,'UPI','Noida'),
(5,'SportsArena','Nitin Verma','Basketball','2026-02-25',1,1400,'Cash','Delhi'),
(6,'BeautyStore','Pallavi Singh','Body Lotion','2026-02-26',2,1000,'UPI','Mumbai'),
(7,'ToyLand','Riya Gupta','Building Blocks','2026-02-27',1,900,'Card','Pune'),
(8,'MobileGalaxy','Amit Jain','Smart Watch','2026-02-28',1,5500,'UPI','Jaipur'),
(1,'TechZone','Kunal Sharma','External HDD','2026-03-01',1,6000,'Card','Lucknow'),
(2,'FashionHub','Meena Verma','Handbag','2026-03-02',1,1800,'UPI','Delhi');
go

select * from hra.Orders;


CREATE PROC hra.usp_GetAllOrders
AS
BEGIN
    SELECT * FROM hra.Orders
END
GO


CREATE PROC hra.usp_GetOrderById
(
    @OrderId INT
)
AS
BEGIN
    SELECT *
    FROM hra.Orders
    WHERE OrderId = @OrderId
END
GO

CREATE PROC hra.usp_GetOrdersByStoreId
(
    @StoreId INT
)
AS
BEGIN
    SELECT *
    FROM hra.Orders
    WHERE StoreId = @StoreId
END
GO

CREATE PROC hra.usp_AddOrder
(
    @StoreId INT,
    @StoreName NVARCHAR(100),
    @CustomerName NVARCHAR(100),
    @ProductName NVARCHAR(100),
    @OrderDate DATETIME,
    @Quantity INT,
    @TotalAmount INT,
    @PaymentMethod NVARCHAR(50),
    @DeliveryCity NVARCHAR(100)
)
AS
BEGIN
    INSERT INTO hra.Orders
    (
        StoreId,
        StoreName,
        CustomerName,
        ProductName,
        OrderDate,
        Quantity,
        TotalAmount,
        PaymentMethod,
        DeliveryCity
    )
    VALUES
    (
        @StoreId,
        @StoreName,
        @CustomerName,
        @ProductName,
        @OrderDate,
        @Quantity,
        @TotalAmount,
        @PaymentMethod,
        @DeliveryCity
    )
END
GO

CREATE PROC hra.usp_UpdateOrder
(
    @OrderId INT,
    @StoreId INT,
    @StoreName NVARCHAR(100),
    @CustomerName NVARCHAR(100),
    @ProductName NVARCHAR(100),
    @OrderDate DATETIME,
    @Quantity INT,
    @TotalAmount INT,
    @PaymentMethod NVARCHAR(50),
    @DeliveryCity NVARCHAR(100)
)
AS
BEGIN
    UPDATE hra.Orders
    SET
        StoreId = @StoreId,
        StoreName = @StoreName,
        CustomerName = @CustomerName,
        ProductName = @ProductName,
        OrderDate = @OrderDate,
        Quantity = @Quantity,
        TotalAmount = @TotalAmount,
        PaymentMethod = @PaymentMethod,
        DeliveryCity = @DeliveryCity
    WHERE OrderId = @OrderId
END
GO


CREATE PROC hra.usp_DeleteOrder
(
    @OrderId INT
)
AS
BEGIN
    DELETE FROM hra.Orders
    WHERE OrderId = @OrderId
END
GO
