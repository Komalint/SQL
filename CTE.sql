-- Recursive CTE


/*
------------------------------------------------------------------------
EXERCISE 7: Flight Route Pathfinding (DEL to LHR)
Task: Find all flight routes from 'DEL' to 'LHR', number of hops/stops,
      and total ticket price. Order by cheapest first.
------------------------------------------------------------------------
*/
DROP TABLE IF EXISTS Flights;
CREATE TABLE Flights (
    FlightID INT PRIMARY KEY,
    DepartureCity VARCHAR(3) NOT NULL,
    ArrivalCity VARCHAR(3) NOT NULL,
    Price DECIMAL(10,2) NOT NULL
);

INSERT INTO Flights (FlightID, DepartureCity, ArrivalCity, Price) VALUES
(101, 'DEL', 'DXB', 18000.00),
(102, 'DXB', 'LHR', 32000.00),
(103, 'DEL', 'DOH', 17000.00),
(104, 'DOH', 'LHR', 31000.00),
(105, 'DEL', 'BOM',  5000.00),
(106, 'BOM', 'DXB', 16000.00),
(107, 'DEL', 'LHR', 58000.00);


WITH FlightRoutes AS
(
    -- Anchor
    SELECT
        DepartureCity,
        ArrivalCity,
        CAST(DepartureCity + '->' + ArrivalCity AS VARCHAR(200)) AS RoutePath,
        Price AS TotalPrice,
        1 AS Hops
    FROM Flights
    WHERE DepartureCity = 'DEL'

    UNION ALL

    -- Recursive
    SELECT
        R.DepartureCity,
        F.ArrivalCity,
        CAST(R.RoutePath + '->' + F.ArrivalCity AS VARCHAR(200)),
        R.TotalPrice + F.Price,
        R.Hops + 1
    FROM FlightRoutes R
    JOIN Flights F
        ON R.ArrivalCity = F.DepartureCity
)
SELECT
    RoutePath,
    Hops,
    TotalPrice
FROM FlightRoutes
WHERE ArrivalCity = 'LHR'
ORDER BY TotalPrice;

--=======================================================================

DECLARE @Year INT = 2026;
DECLARE @Month INT = 10;

WITH cte_Dates(DateValue)
AS
(
    SELECT DATEFROMPARTS(@Year, @Month, 1)

    UNION ALL

    SELECT DATEADD(DAY, 1, DateValue)
    FROM cte_Dates
    WHERE DateValue < EOMONTH(DATEFROMPARTS(@Year, @Month, 1))
)
SELECT DateValue
FROM cte_Dates
OPTION (MAXRECURSION 31);


-- ==========================================================================


CREATE TABLE EmployeeHierarchy
(
    EmployeeId INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    ManagerId INT NULL,
    Department VARCHAR(50),
    Salary DECIMAL(10,2),

    FOREIGN KEY (ManagerId)
    REFERENCES EmployeeHierarchy(EmployeeId)
);


INSERT INTO EmployeeHierarchy
VALUES
(1,'CEO',NULL,'Management',200000),

(2,'CTO',1,'Technology',150000),
(3,'CFO',1,'Finance',145000),

(4,'Tech Lead',2,'Technology',120000),
(5,'Senior Developer',4,'Technology',90000),
(6,'Junior Developer',5,'Technology',60000),

(7,'Finance Manager',3,'Finance',100000),
(8,'Accountant',7,'Finance',70000),

(9,'HR Manager',1,'HR',90000),
(10,'HR Executive',9,'HR',50000);


-- *******************************************************************
-- === Display complete hierarchy of employees


WITH EmployeeCTE
AS
(
    SELECT
        EmployeeId,
        EmployeeName,
        ManagerId,
        0 AS Level
    FROM EmployeeHierarchy
    WHERE ManagerId IS NULL

    UNION ALL

    SELECT
        e.EmployeeId,
        e.EmployeeName,
        e.ManagerId,
        c.Level + 1
    FROM EmployeeHierarchy e
    JOIN EmployeeCTE c
        ON e.ManagerId = c.EmployeeId
)
SELECT *
FROM EmployeeCTE;

