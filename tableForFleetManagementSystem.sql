CREATE TABLE Vehicle
(
    Id INT IDENTITY(1,1) PRIMARY KEY,

    VIN VARCHAR(50) NOT NULL,

    Manufacturer VARCHAR(100) NOT NULL,

    Model VARCHAR(100) NOT NULL,

    OdometerReading DECIMAL(18,2) NOT NULL,

    IsActive VARCHAR(10) NOT NULL,

    CreatedDate DATETIME NOT NULL DEFAULT GETDATE()
);
INSERT INTO Vehicle
(
    VIN,
    Manufacturer,
    Model,
    OdometerReading,
    IsActive,
    CreatedDate
)
VALUES
('VIN001','Toyota','Innova',25000,'Yes',GETDATE()),
('VIN002','Honda','City',18000,'Yes',GETDATE()),
('VIN003','Hyundai','Creta',32000,'No',GETDATE());