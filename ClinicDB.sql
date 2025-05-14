-- Step 1 Create a database  
CREATE DATABASE ClinicDB;
USE ClinicDB;

-- Step 2 Create Patients Table
CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender ENUM('Male', 'Female', 'Other'),
    DateOfBirth DATE,
    Phone VARCHAR(15) UNIQUE,
    Email VARCHAR(100)
);

-- Step 3 Create Doctors Table
CREATE TABLE Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Phone VARCHAR(15) UNIQUE,
    Email VARCHAR(100)
);

-- Step 4 Create Specializations Table
CREATE TABLE Specializations (
    SpecializationID INT AUTO_INCREMENT PRIMARY KEY,
    SpecializationName VARCHAR(100) NOT NULL UNIQUE
);

-- Step 5 Create Junction Table: Doctor_Specialization (M:M)
CREATE TABLE Doctor_Specialization (
    DoctorID INT,
    SpecializationID INT,
    PRIMARY KEY (DoctorID, SpecializationID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (SpecializationID) REFERENCES Specializations(SpecializationID)
);

-- Step 6 Create Appointments Table
CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATETIME NOT NULL,
    Reason TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Step 7 Create Treatments Table
CREATE TABLE Treatments (
    TreatmentID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT NOT NULL,
    Description TEXT,
    Cost DECIMAL(10,2),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

-- Step 8 Create Billing Table
CREATE TABLE Billing (
    BillingID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT NOT NULL,
    TotalAmount DECIMAL(10,2),
    PaymentStatus ENUM('Paid', 'Unpaid', 'Pending') DEFAULT 'Unpaid',
    PaymentDate DATE,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

-- Step 9 Inserting Patients data
INSERT INTO Patients (FirstName, LastName, Gender, DateOfBirth, Phone, Email)
VALUES 
      ('Aamal', 'Adam', 'Female', '2004-05-10', '0712345678', 'aamal@example.com'),
      ('Fadhila', 'Amour', 'Female', '1997-10-22', '0774671994', 'fadhila@example.com'),  
      ('Khatib', 'Kassim', 'Male', '1975-03-22', '0723456789', 'khatib@example.com');
      
-- Step 10 Inserting Doctors data
INSERT INTO Doctors (FirstName, LastName, Phone, Email)
VALUES 
     ('Dr. Mansoura', 'Mosi', '0734567890', 'mansoura.mosi@example.com'),
     ('Dr. Zuhura', 'Balozi', '0745630106', 'zuhura.balozi@example.com'),
     ('Dr. Janabi', 'William', '0745678901', 'janabi.william@example.com');
     
-- Step 11 Inserting Specializations data
INSERT INTO Specializations (SpecializationName)
VALUES 
      ('General Medicine'),
      ('Pediatrics'),
      ('OBY-GIN'),
      ('Cardiology');
      
-- Step 12 Link Doctors and Specializations
INSERT INTO Doctor_Specialization (DoctorID, SpecializationID)
VALUES (1, 1), 
       (2, 2), 
       (2, 3),
       (3, 4);
   
-- Step 13 Inserting Appointments data
INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Reason)
VALUES 
      (4, 1, '2025-06-01 09:00:00', 'Physical examination'),
      (5, 2, '2025-06-02 10:30:00', 'Child Clinic day'),
      (6, 3, '2025-06-03 12:45:00', 'Heart check-up');

-- Step 14 Inserting Treatments data
INSERT INTO Treatments (AppointmentID, Description, Cost)
VALUES 
	  (16, 'General health screening', 50.00),
      (17, 'Receiving vaccination', 80.00),
      (18, 'Getting hypertension medication', 95.00); 
      
-- Step 15 Inserting Billing data
INSERT INTO Billing (AppointmentID, TotalAmount, PaymentStatus, PaymentDate)
VALUES 
	  (16, 50.00, 'Paid', '2025-06-01'),
      (17, 80.00, 'Paid', '2025-06-02'),
      (18, 95.00, 'Pending', NULL);


-- Step 16 Sample of Sql Queries 
-- a) List all patients with their appointments:
SELECT FirstName, LastName, AppointmentDate, Reason
FROM Patients 
JOIN Appointments ON Appointments.PatientID = Patients.PatientID;

-- b) List doctors and their specializations:
SELECT FirstName, LastName, SpecializationName
FROM Doctors 
JOIN Doctor_Specialization  ON Doctors.DoctorID = Doctor_Specialization.DoctorID
JOIN Specializations  ON Doctor_Specialization.SpecializationID = Specializations.SpecializationID;

-- c) Show total treatment cost per patient:
SELECT FirstName, LastName, SUM(Cost) AS TotalAmount
FROM Patients 
JOIN Appointments ON Patients.PatientID = Appointments.PatientID
JOIN Treatments ON Appointments.AppointmentID = Treatments.AppointmentID
GROUP BY Patients.PatientID;

-- d) Show billing status Overviewt:
SELECT FirstName, LastName, TotalAmount, PaymentStatus
FROM Patients 
JOIN Appointments ON Patients.PatientID = Appointments.PatientID
JOIN Billing  ON Appointments.AppointmentID = Billing.AppointmentID;