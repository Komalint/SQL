CREATE TABLE Users
(
    EmailId VARCHAR(255) PRIMARY KEY
        CHECK (EmailId LIKE '%@gmail.com'),

    UserName VARCHAR(50) NOT NULL,

    PhoneNumber VARCHAR(15) NULL,

    Gender VARCHAR(10)
        CHECK (Gender IN ('Male','Female','Other')),

    City VARCHAR(50) NULL,

    StateName VARCHAR(50) NULL,

    DateOfBirth DATE NULL,

    CreatedDate DATETIME NOT NULL
        DEFAULT GETDATE()
);



INSERT INTO Users
(
    EmailId,
    UserName,
    PhoneNumber,
    Gender,
    City,
    StateName,
    DateOfBirth
)
VALUES
('komal@gmail.com',      'Komal',     '9876543210', 'Female', 'Delhi',      'Delhi',            '2002-05-20'),
('rahul@gmail.com',      'Rahul',     '9876543211', 'Male',   'Mumbai',     'Maharashtra',      '2001-08-15'),
('priya@gmail.com',      'Priya',     '9876543212', 'Female', 'Lucknow',    'Uttar Pradesh',    '2000-11-10'),
('amit@gmail.com',       'Amit',      '9876543213', 'Male',   'Jaipur',     'Rajasthan',        '1999-03-25'),
('neha@gmail.com',       'Neha',      '9876543214', 'Female', 'Bhopal',     'Madhya Pradesh',   '2003-07-18'),
('rohit@gmail.com',      'Rohit',     '9876543215', 'Male',   'Chandigarh', 'Punjab',           '2001-12-30'),
('simran@gmail.com',     'Simran',    '9876543216', 'Female', 'Amritsar',   'Punjab',           '2002-09-05'),
('vikas@gmail.com',      'Vikas',     '9876543217', 'Male',   'Patna',      'Bihar',            '1998-04-12'),
('pooja@gmail.com',      'Pooja',     '9876543218', 'Female', 'Ahmedabad',  'Gujarat',          '2001-06-28'),
('arjun@gmail.com',      'Arjun',     '9876543219', 'Male',   'Bengaluru',  'Karnataka',        '2000-02-14');