CREATE TABLE hra.Stores
(
    StoreId INT IDENTITY(1,1) PRIMARY KEY,

    StoreName NVARCHAR(100) NOT NULL,
    OwnerName NVARCHAR(100) NOT NULL,

    StoreType NVARCHAR(50) NOT NULL,

    ContactNumber VARCHAR(10) NOT NULL,

    Email NVARCHAR(100) NOT NULL,

    City NVARCHAR(100) NOT NULL,

    State NVARCHAR(100) NOT NULL,

    OpeningDate DATE NOT NULL,

    IsActive BIT NOT NULL DEFAULT 1
);
GO

INSERT INTO hra.Stores
(
    StoreName,
    OwnerName,
    StoreType,
    ContactNumber,
    Email,
    City,
    State,
    OpeningDate,
    IsActive
)
VALUES
('TechZone','Rajesh Gupta','Electronics','9876543210','techzone@gmail.com','Delhi','Delhi','2020-01-10',1),

('FashionHub','Amit Sharma','Clothing','9876543211','fashionhub@gmail.com','Mumbai','Maharashtra','2019-05-15',1),

('HomeMart','Priya Verma','Home Decor','9876543212','homemart@gmail.com','Pune','Maharashtra','2021-02-20',1),

('BookWorld','Suresh Jain','Books','9876543213','bookworld@gmail.com','Jaipur','Rajasthan','2018-07-12',1),

('SportsArena','Karan Singh','Sports','9876543214','sportsarena@gmail.com','Noida','UP','2022-03-18',1),

('BeautyStore','Neha Gupta','Beauty','9876543215','beautystore@gmail.com','Lucknow','UP','2021-06-25',1),

('ToyLand','Pooja Sharma','Toys','9876543216','toyland@gmail.com','Indore','MP','2020-11-05',1),

('MobileGalaxy','Rahul Verma','Mobiles','9876543217','mobilegalaxy@gmail.com','Chandigarh','Punjab','2023-01-01',1);
GO



CREATE PROC hra.usp_GetAllStores
AS
BEGIN
    SELECT * FROM hra.Stores
END
GO


CREATE PROC hra.usp_GetStoreById
(
    @StoreId INT
)
AS
BEGIN
    SELECT *
    FROM hra.Stores
    WHERE StoreId = @StoreId
END
GO


CREATE PROC hra.usp_AddStore
(
    @StoreName NVARCHAR(100),
    @OwnerName NVARCHAR(100),
    @StoreType NVARCHAR(50),
    @ContactNumber VARCHAR(10),
    @Email NVARCHAR(100),
    @City NVARCHAR(100),
    @State NVARCHAR(100),
    @OpeningDate DATE,
    @IsActive BIT
)
AS
BEGIN
    INSERT INTO hra.Stores
    (
        StoreName,
        OwnerName,
        StoreType,
        ContactNumber,
        Email,
        City,
        State,
        OpeningDate,
        IsActive
    )
    VALUES
    (
        @StoreName,
        @OwnerName,
        @StoreType,
        @ContactNumber,
        @Email,
        @City,
        @State,
        @OpeningDate,
        @IsActive
    )
END
GO

CREATE PROC hra.usp_UpdateStore
(
    @StoreId INT,
    @StoreName NVARCHAR(100),
    @OwnerName NVARCHAR(100),
    @StoreType NVARCHAR(50),
    @ContactNumber VARCHAR(10),
    @Email NVARCHAR(100),
    @City NVARCHAR(100),
    @State NVARCHAR(100),
    @OpeningDate DATE,
    @IsActive BIT
)
AS
BEGIN
    UPDATE hra.Stores
    SET
        StoreName = @StoreName,
        OwnerName = @OwnerName,
        StoreType = @StoreType,
        ContactNumber = @ContactNumber,
        Email = @Email,
        City = @City,
        State = @State,
        OpeningDate = @OpeningDate,
        IsActive = @IsActive
    WHERE StoreId = @StoreId
END
GO

CREATE PROC hra.usp_DeleteStore
(
    @StoreId INT
)
AS
BEGIN
    DELETE FROM hra.Stores
    WHERE StoreId = @StoreId
END
GO

SELECT DISTINCT StoreId
FROM hra.Orders
ORDER BY StoreId;