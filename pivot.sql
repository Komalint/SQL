-- 1. Departments Table

create schema pvt
CREATE TABLE pvt.Departments (
    department_id INT PRIMARY KEY IDENTITY,
    department_name VARCHAR(100) NOT NULL,
    head_of_department VARCHAR(100),
    phone_extension VARCHAR(10)
);

-- 2. Doctors Table
CREATE TABLE pvt.Doctors (
    doctor_id INT PRIMARY KEY IDENTITY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    department_id INT,
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(20),
    FOREIGN KEY (department_id) REFERENCES pvt.Departments(department_id)
);

-- 3. Patients Table
CREATE TABLE pvt.Patients (
    patient_id INT PRIMARY KEY IDENTITY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10)  CONSTRAINT CHK_Gender
		CHECK (Gender IN ('Male', 'Female', 'Other')) NOT NULL,
    phone_number VARCHAR(20),
    blood_group VARCHAR(5)
);

-- 4. Appointments Table
CREATE TABLE pvt.Appointments (
    appointment_id INT PRIMARY KEY IDENTITY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status VARCHAR(10) CHECK(status IN('Scheduled', 'Completed', 'Cancelled', 'No-Show')) DEFAULT 'Scheduled',
    reason_for_visit TEXT,
    diagnosis TEXT,
    FOREIGN KEY (patient_id) REFERENCES pvt.Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES pvt.Doctors(doctor_id)
);

SET IDENTITY_INSERT pvt.Departments ON
INSERT INTO pvt.Departments (department_id, department_name, head_of_department, phone_extension) VALUES
(1, 'Cardiology', 'Dr. Robert Smith', '1001'),
(2, 'Neurology', 'Dr. Sarah Connor', '1002'),
(3, 'Orthopedics', 'Dr. James Wilson', '1003'),
(4, 'Pediatrics', 'Dr. Emily Watson', '1004'),
(5, 'Oncology', 'Dr. Michael Chang', '1005'),
(6, 'Gastroenterology', 'Dr. Laura Vance', '1006'),
(7, 'Dermatology', 'Dr. Alan Grant', '1007'),
(8, 'Urology', 'Dr. Susan Calvin', '1008'),
(9, 'Pulmonology', 'Dr. David Bowman', '1009'),
(10, 'Endocrinology', 'Dr. Grace Augustine', '1010'),
(11, 'Ophthalmology', 'Dr. Thomas Kane', '1011'),
(12, 'Otolaryngology (ENT)', 'Dr. Rachel Tyrell', '1012'),
(13, 'Psychiatry', 'Dr. Bruce Banner', '1013'),
(14, 'Nephrology', 'Dr. Eleanor Arroway', '1014'),
(15, 'Rheumatology', 'Dr. Henry Wu', '1015'),
(16, 'General Surgery', 'Dr. Stephen Strange', '1016'),
(17, 'Emergency Medicine', 'Dr. Leonard McCoy', '1017'),
(18, 'Obstetrics & Gynecology', 'Dr. Beverly Crusher', '1018'),
(19, 'Hematology', 'Dr. John Watson', '1019'),
(20, 'Radiology', 'Dr. Dana Scully', '1020');
SET IDENTITY_INSERT pvt.Departments OFF

SET IDENTITY_INSERT pvt.Doctors ON
INSERT INTO pvt.Doctors (doctor_id, first_name, last_name, specialization, department_id, email, phone_number) VALUES
(1, 'Robert', 'Smith', 'Cardiologist', 1, 'r.smith@hospital.org', '555-0101'),
(2, 'Sarah', 'Connor', 'Neurologist', 2, 's.connor@hospital.org', '555-0102'),
(3, 'James', 'Wilson', 'Orthopedic Surgeon', 3, 'j.wilson@hospital.org', '555-0103'),
(4, 'Emily', 'Watson', 'Pediatrician', 4, 'e.watson@hospital.org', '555-0104'),
(5, 'Michael', 'Chang', 'Oncologist', 5, 'm.chang@hospital.org', '555-0105'),
(6, 'Laura', 'Vance', 'Gastroenterologist', 6, 'l.vance@hospital.org', '555-0106'),
(7, 'Alan', 'Grant', 'Dermatologist', 7, 'a.grant@hospital.org', '555-0107'),
(8, 'Susan', 'Calvin', 'Urologist', 8, 's.calvin@hospital.org', '555-0108'),
(9, 'David', 'Bowman', 'Pulmonologist', 9, 'd.bowman@hospital.org', '555-0109'),
(10, 'Grace', 'Augustine', 'Endocrinologist', 10, 'g.augustine@hospital.org', '555-0110'),
(11, 'Thomas', 'Kane', 'Ophthalmologist', 11, 't.kane@hospital.org', '555-0111'),
(12, 'Rachel', 'Tyrell', 'ENT Specialist', 12, 'r.tyrell@hospital.org', '555-0112'),
(13, 'Bruce', 'Banner', 'Psychiatrist', 13, 'b.banner@hospital.org', '555-0113'),
(14, 'Eleanor', 'Arroway', 'Nephrologist', 14, 'e.arroway@hospital.org', '555-0114'),
(15, 'Henry', 'Wu', 'Rheumatologist', 15, 'h.wu@hospital.org', '555-0115'),
(16, 'Stephen', 'Strange', 'General Surgeon', 16, 's.strange@hospital.org', '555-0116'),
(17, 'Leonard', 'McCoy', 'Emergency Physician', 17, 'l.mccoy@hospital.org', '555-0117'),
(18, 'Beverly', 'Crusher', 'Obstetrician', 18, 'b.crusher@hospital.org', '555-0118'),
(19, 'John', 'Watson', 'Hematologist', 19, 'j.watson@hospital.org', '555-0119'),
(20, 'Dana', 'Scully', 'Radiologist', 20, 'd.scully@hospital.org', '555-0120');
SET IDENTITY_INSERT pvt.Doctors OFF

SET IDENTITY_INSERT pvt.Patients ON
INSERT INTO pvt.Patients (patient_id, first_name, last_name, date_of_birth, gender, phone_number, blood_group) VALUES
(1, 'Alice', 'Johnson', '1985-04-12', 'Female', '555-0201', 'A+'),
(2, 'Bob', 'Williams', '1972-09-25', 'Male', '555-0202', 'O-'),
(3, 'Charlie', 'Brown', '1990-11-03', 'Male', '555-0203', 'B+'),
(4, 'Diana', 'Prince', '1988-03-22', 'Female', '555-0204', 'AB+'),
(5, 'Ethan', 'Hunt', '1980-07-18', 'Male', '555-0205', 'O+'),
(6, 'Fiona', 'Gallagher', '1995-01-30', 'Female', '555-0206', 'A-'),
(7, 'George', 'Clark', '1965-06-14', 'Male', '555-0207', 'B-'),
(8, 'Hannah', 'Abbott', '2001-12-05', 'Female', '555-0208', 'AB-'),
(9, 'Ian', 'Malcolm', '1978-08-09', 'Male', '555-0209', 'O+'),
(10, 'Julia', 'Roberts', '1992-05-17', 'Female', '555-0210', 'A+'),
(11, 'Kevin', 'Flynn', '1983-02-28', 'Male', '555-0211', 'B+'),
(12, 'Laura', 'Palmer', '1998-10-10', 'Female', '555-0212', 'O-'),
(13, 'Michael', 'Scott', '1964-03-15', 'Male', '555-0213', 'A+'),
(14, 'Nina', 'Sayers', '1993-07-04', 'Female', '555-0214', 'B-'),
(15, 'Oscar', 'Martinez', '1975-11-20', 'Male', '555-0215', 'O+'),
(16, 'Pam', 'Beesly', '1984-03-25', 'Female', '555-0216', 'AB+'),
(17, 'Quinn', 'Fabray', '1996-09-08', 'Female', '555-0217', 'A-'),
(18, 'Ron', 'Swanson', '1961-05-06', 'Male', '555-0218', 'O+'),
(19, 'Samantha', 'Jones', '1979-04-28', 'Female', '555-0219', 'B+'),
(20, 'Tim', 'Drake', '2003-01-12', 'Male', '555-0220', 'AB-');
SET IDENTITY_INSERT pvt.Patients OFF

SET IDENTITY_INSERT pvt.Appointments ON
INSERT INTO pvt.Appointments (appointment_id, patient_id, doctor_id, appointment_date, status, reason_for_visit, diagnosis) VALUES
(1, 1, 1, '2026-10-01 09:00:00', 'Scheduled', 'Chest tightness during exercise', NULL),
(2, 2, 2, '2026-10-01 10:30:00', 'Scheduled', 'Chronic migraines', NULL),
(3, 3, 3, '2026-09-28 14:00:00', 'Completed', 'Right knee pain after running', 'Mild ligament strain'),
(4, 4, 4, '2026-09-29 11:15:00', 'Completed', 'Annual pediatric checkup', 'Healthy growth metrics'),
(5, 5, 5, '2026-10-02 13:00:00', 'Scheduled', 'Follow-up post-chemotherapy', NULL),
(6, 6, 6, '2026-09-27 15:30:00', 'Completed', 'Acid reflux and abdominal bloating', 'GERD'),
(7, 7, 7, '2026-09-25 09:45:00', 'Cancelled', 'Skin rash on forearms', NULL),
(8, 8, 8, '2026-10-03 10:00:00', 'Scheduled', 'Routine kidney ultrasound review', NULL),
(9, 9, 9, '2026-09-26 16:00:00', 'Completed', 'Persistent cough and shortness of breath', 'Mild asthma exacerbation'),
(10, 10, 10, '2026-10-04 08:30:00', 'Scheduled', 'Thyroid panel consultation', NULL),
(11, 11, 11, '2026-09-24 11:00:00', 'Completed', 'Blurry vision in left eye', 'Early-stage cataract'),
(12, 12, 12, '2026-09-23 14:30:00', 'No-Show', 'Sore throat and earache', NULL),
(13, 13, 13, '2026-10-05 15:00:00', 'Scheduled', 'Anxiety and insomnia consultation', NULL),
(14, 14, 14, '2026-09-22 10:00:00', 'Completed', 'Elevated creatinine levels', 'Stage 2 CKD management'),
(15, 15, 15, '2026-10-06 09:15:00', 'Scheduled', 'Joint stiffness in hands', NULL),
(16, 16, 16, '2026-09-21 13:30:00', 'Completed', 'Gallbladder consultation', 'Gallstones recommended for surgery'),
(17, 17, 17, '2026-09-20 22:00:00', 'Completed', 'Acute abdominal pain', 'Appendicitis, referred to surgery'),
(18, 18, 18, '2026-10-07 11:30:00', 'Scheduled', 'Prenatal checkup week 24', NULL),
(19, 19, 19, '2026-09-19 14:00:00', 'Completed', 'Low hemoglobin levels', 'Iron deficiency anemia'),
(20, 20, 20, '2026-09-18 16:30:00', 'Completed', 'Wrist X-ray review', 'Hairline fracture of distal radius');

SET IDENTITY_INSERT pvt.Appointments OFF

select * from pvt.Appointments
select * from pvt.Departments
select * from pvt.Doctors
select * from pvt.Patients

select department_name , Scheduled , Completed , Cancelled , No_Show from (
			select dp.department_id, dp.department_name,ap.appointment_id, ap.status 
			from pvt.Doctors d inner join pvt.Departments dp
				on  d.department_id =dp.department_id
			inner join pvt.Appointments ap 
			on d.doctor_id = ap.doctor_id) as pvtd

pivot (count(appointment_id) for status in ( Scheduled , Completed , Cancelled , No_Show)) as pvtTable

-- Q2

select blood_group , Male , female , Other from (
				select blood_group , gender from pvt.Patients ) as pvtd

pivot ( count(gender) for gender in (Male , female , Other)) as pvtTable


-- Q3
select  first_name+' '+last_name as FullName, Scheduled , Completed , Cancelled , No_Show from (
			select d.doctor_id, d.first_name, d.last_name,ap.appointment_id,ap.status from pvt.Doctors d inner join pvt.Appointments ap
			on ap.doctor_id = d.department_id) as pvtd

pivot (count(appointment_id) for status in ( Scheduled , Completed , Cancelled , No_Show)) as pvtTable 

-- Q4
select department_name , 
	ISNULL([January], 0)   AS January,
    ISNULL([February], 0)  AS February,
    ISNULL([March], 0)     AS March,
    ISNULL([April], 0)     AS April,
    ISNULL([May], 0)       AS May,
    ISNULL([June], 0)      AS June,
    ISNULL([July], 0)      AS July,
    ISNULL([August], 0)    AS August,
    ISNULL([September], 0) AS September,
    ISNULL([October], 0)   AS October,
    ISNULL([November], 0)  AS November,
    ISNULL([December], 0)  AS December

from (
			select dp.department_id, dp.department_name,ap.appointment_id, ap.status,
				datename(month, ap.appointment_date) as MonthName
			from pvt.Doctors d inner join pvt.Departments dp
				on  d.department_id =dp.department_id
			inner join pvt.Appointments ap 
			on d.doctor_id = ap.doctor_id where year(ap.appointment_date) ='2026') as pvtd

pivot (count(appointment_id) for MonthName in ( January, February, March, April, May, June, July, August, September, October, November, December)) as pvtTable


-- Q5
select department_name , 
ISNULL([A+], 0)  AS [A+],
ISNULL([A-], 0)  AS [A-],
ISNULL([B+], 0)  AS [B+],
ISNULL([B-], 0)  AS [B-],
ISNULL([AB+], 0) AS [AB+],
ISNULL([AB-], 0) AS [AB-],
ISNULL([O+], 0)  AS [O+],
ISNULL([O-], 0)  AS [O-]
	  from     (
			select distinct dp.department_id, dp.department_name,ap.appointment_id, p.blood_group 
			from pvt.Doctors d inner join pvt.Departments dp
				on  d.department_id =dp.department_id
			inner join pvt.Appointments ap 
				on d.doctor_id = ap.doctor_id
			inner join pvt.Patients p on p.patient_id =ap.patient_id) as pvtD

pivot(count(blood_group) for blood_group in ([A+], [A-], [B+], [B-], [AB+], [AB-], [O+], [O-])) as pivottable
