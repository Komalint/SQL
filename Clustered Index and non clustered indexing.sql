CREATE TABLE Orders
(
    OrderID INT,
    CustomerID INT,
    ProductID INT,
    OrderDate DATE,
    Quantity INT,
    Amount DECIMAL(10,2),
    Status VARCHAR(20)
);

INSERT INTO Orders VALUES
(101,1,11,'2024-01-10',2,500,'Completed'),
(102,1,12,'2024-01-12',1,1000,'Completed'),
(103,2,11,'2024-01-15',3,750,'Pending'),
(104,3,14,'2024-01-18',5,1500,'Completed'),
(105,2,13,'2024-01-20',2,1200,'Cancelled'),
(106,1,11,'2024-01-25',4,1000,'Completed'),
(107,4,15,'2024-02-01',1,800,'Pending'),
(108,5,16,'2024-02-03',2,900,'Completed');


CREATE CLUSTERED INDEX IX_OrderID
ON Orders(OrderID);

SELECT *
FROM Orders
WHERE OrderID = 105;

DROP INDEX IX_OrderID ON Orders;


-- =================== Composite cluster ==============================


CREATE CLUSTERED INDEX IX_Customer_OrderDate
ON Orders(CustomerID, OrderDate);

SELECT *
FROM Orders
WHERE CustomerID = 1;

SELECT *
FROM Orders
WHERE CustomerID = 1
AND OrderDate = '2024-01-12'; -- seek

SELECT *
FROM Orders
WHERE CustomerID = 2
AND OrderDate > '2024-01-01'; -- seek 

SELECT *
FROM Orders
WHERE OrderDate = '2024-01-12'; -- index scan

SELECT *
FROM Orders
WHERE ProductID = 11;


-- =============================== Non Clustered Indexing ===============================================


CREATE NONCLUSTERED INDEX IX_ProductID
ON Orders(ProductID);

SELECT *
FROM Orders
WHERE ProductID = 11;

CREATE NONCLUSTERED INDEX IX_Status_Date
ON Orders(Status, OrderDate);

SELECT *
FROM Orders
WHERE Status = 'Completed';

SELECT *
FROM Orders
WHERE Status = 'Completed'
AND OrderDate = '2024-01-18';

SELECT *
FROM Orders
WHERE OrderDate = '2024-01-18';

SELECT ProductID,
       Amount,
       Quantity
FROM Orders
WHERE ProductID = 11;



-- =============================== Non Clustered Indexing with Include ===============================================



CREATE NONCLUSTERED INDEX IX_ProductID_Include
ON Orders(ProductID)
INCLUDE(Amount, Quantity);


CREATE NONCLUSTERED INDEX IX_Customer_Date_Include
ON Orders(CustomerID, OrderDate)
INCLUDE(Amount, Status);

SELECT CustomerID,
       OrderDate,
       Amount,
       Status
FROM Orders
WHERE CustomerID = 1
AND OrderDate = '2024-01-12';