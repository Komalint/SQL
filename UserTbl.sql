USE AssignmentDB;
GO

-- 1. Create UserTbl Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'UserTbl' AND type = 'U')
BEGIN
    CREATE TABLE dbo.UserTbl
    (
        UserId INT IDENTITY(1,1) PRIMARY KEY,
        UserName NVARCHAR(100) NOT NULL,
        Email NVARCHAR(100) NOT NULL UNIQUE,
        Password NVARCHAR(255) NOT NULL,
        PhoneNumber VARCHAR(15) NULL,
        Gender VARCHAR(10) NULL CHECK (Gender IN ('Male', 'Female', 'Other')),
        City NVARCHAR(50) NULL,
        State NVARCHAR(50) NULL,
        Role NVARCHAR(20) NOT NULL DEFAULT 'User',
        IsActive BIT NOT NULL DEFAULT 1,
        CreatedDate DATETIME NOT NULL DEFAULT GETDATE()
    );
    PRINT 'UserTbl table created successfully.';
END
ELSE
BEGIN
    PRINT 'UserTbl table already exists.';
END
GO

-- 2. Stored Procedure: usp_RegisterUser
IF OBJECT_ID('dbo.usp_RegisterUser', 'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_RegisterUser;
GO

CREATE PROCEDURE dbo.usp_RegisterUser
(
    @UserName NVARCHAR(100),
    @Email NVARCHAR(100),
    @Password NVARCHAR(255),
    @PhoneNumber VARCHAR(15) = NULL,
    @Gender VARCHAR(10) = NULL,
    @City NVARCHAR(50) = NULL,
    @State NVARCHAR(50) = NULL,
    @Role NVARCHAR(20) = 'User',
    @Result INT OUTPUT,
    @Message NVARCHAR(255) OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM dbo.UserTbl WHERE Email = @Email)
    BEGIN
        SET @Result = -1;
        SET @Message = 'Email is already registered. Please login or use a different email.';
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM dbo.UserTbl WHERE UserName = @UserName)
    BEGIN
        SET @Result = -2;
        SET @Message = 'Username is already taken. Please choose another username.';
        RETURN;
    END

    INSERT INTO dbo.UserTbl
    (
        UserName,
        Email,
        Password,
        PhoneNumber,
        Gender,
        City,
        State,
        Role,
        IsActive,
        CreatedDate
    )
    VALUES
    (
        @UserName,
        @Email,
        @Password,
        @PhoneNumber,
        @Gender,
        @City,
        @State,
        ISNULL(@Role, 'User'),
        1,
        GETDATE()
    );

    SET @Result = SCOPE_IDENTITY();
    SET @Message = 'User registered successfully!';
END
GO

-- 3. Stored Procedure: usp_LoginUser
IF OBJECT_ID('dbo.usp_LoginUser', 'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_LoginUser;
GO

CREATE PROCEDURE dbo.usp_LoginUser
(
    @EmailOrUsername NVARCHAR(100),
    @Password NVARCHAR(255)
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        UserId,
        UserName,
        Email,
        PhoneNumber,
        Gender,
        City,
        State,
        Role,
        IsActive,
        CreatedDate
    FROM dbo.UserTbl
    WHERE (Email = @EmailOrUsername OR UserName = @EmailOrUsername)
      AND Password = @Password
      AND IsActive = 1;
END
GO

-- 4. Stored Procedure: usp_GetUserById
IF OBJECT_ID('dbo.usp_GetUserById', 'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_GetUserById;
GO

CREATE PROCEDURE dbo.usp_GetUserById
(
    @UserId INT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        UserId,
        UserName,
        Email,
        PhoneNumber,
        Gender,
        City,
        State,
        Role,
        IsActive,
        CreatedDate
    FROM dbo.UserTbl
    WHERE UserId = @UserId;
END
GO

-- 5. Stored Procedure: usp_GetUserByEmail
IF OBJECT_ID('dbo.usp_GetUserByEmail', 'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_GetUserByEmail;
GO

CREATE PROCEDURE dbo.usp_GetUserByEmail
(
    @Email NVARCHAR(100)
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        UserId,
        UserName,
        Email,
        PhoneNumber,
        Gender,
        City,
        State,
        Role,
        IsActive,
        CreatedDate
    FROM dbo.UserTbl
    WHERE Email = @Email;
END
GO

-- 6. Stored Procedure: usp_CheckEmailExists
IF OBJECT_ID('dbo.usp_CheckEmailExists', 'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_CheckEmailExists;
GO

CREATE PROCEDURE dbo.usp_CheckEmailExists
(
    @Email NVARCHAR(100),
    @IsExists BIT OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM dbo.UserTbl WHERE Email = @Email)
        SET @IsExists = 1;
    ELSE
        SET @IsExists = 0;
END
GO

-- 7. Stored Procedure: usp_UpdateUserProfile
IF OBJECT_ID('dbo.usp_UpdateUserProfile', 'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_UpdateUserProfile;
GO

CREATE PROCEDURE dbo.usp_UpdateUserProfile
(
    @UserId INT,
    @UserName NVARCHAR(100),
    @PhoneNumber VARCHAR(15) = NULL,
    @Gender VARCHAR(10) = NULL,
    @City NVARCHAR(50) = NULL,
    @State NVARCHAR(50) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.UserTbl
    SET 
        UserName = @UserName,
        PhoneNumber = @PhoneNumber,
        Gender = @Gender,
        City = @City,
        State = @State
    WHERE UserId = @UserId;
END
GO

-- 8. Seed sample records
IF NOT EXISTS (SELECT 1 FROM dbo.UserTbl WHERE Email = 'komal@gmail.com')
BEGIN
    INSERT INTO dbo.UserTbl (UserName, Email, Password, PhoneNumber, Gender, City, State, Role, IsActive)
    VALUES ('Komal', 'komal@gmail.com', 'Password@123', '9876543210', 'Female', 'Delhi', 'Delhi', 'Admin', 1);
END

IF NOT EXISTS (SELECT 1 FROM dbo.UserTbl WHERE Email = 'rahul@gmail.com')
BEGIN
    INSERT INTO dbo.UserTbl (UserName, Email, Password, PhoneNumber, Gender, City, State, Role, IsActive)
    VALUES ('Rahul', 'rahul@gmail.com', 'Password@123', '9876543211', 'Male', 'Mumbai', 'Maharashtra', 'User', 1);
END
GO

SELECT UserId, UserName, Email, Role, CreatedDate FROM dbo.UserTbl;
GO

-- 9. Stored Procedure: usp_GetDashboardStats
IF OBJECT_ID('dbo.usp_GetDashboardStats', 'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_GetDashboardStats;
GO

CREATE PROCEDURE dbo.usp_GetDashboardStats
AS
BEGIN
    SET NOCOUNT ON;

    -- Query 1: Dashboard KPI Summary
    SELECT 
        (SELECT COUNT(*) FROM hra.Stores WHERE IsActive = 1) AS TotalStores,
        (SELECT COUNT(*) FROM hra.Orders) AS TotalOrders,
        (SELECT ISNULL(SUM(TotalAmount), 0) FROM hra.Orders) AS TotalRevenue,
        (SELECT COUNT(*) FROM dbo.UserTbl WHERE IsActive = 1) AS TotalUsers;

    -- Query 2: Top 5 Recent Orders
    SELECT TOP 5
        OrderId,
        StoreId,
        StoreName,
        CustomerName,
        ProductName,
        OrderDate,
        Quantity,
        TotalAmount,
        PaymentMethod,
        DeliveryCity
    FROM hra.Orders
    ORDER BY OrderId DESC;
END
GO
