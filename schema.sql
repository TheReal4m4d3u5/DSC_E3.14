DROP TABLE IF EXISTS Participated CASCADE;
DROP TABLE IF EXISTS Owns CASCADE;
DROP TABLE IF EXISTS Accident CASCADE;
DROP TABLE IF EXISTS Car CASCADE;
DROP TABLE IF EXISTS Person CASCADE;


CREATE TABLE Person (
    driver_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50),
    address VARCHAR(100)
);


CREATE TABLE Car (
    license VARCHAR(15) PRIMARY KEY,
    model VARCHAR(50),
    year INT
);


CREATE TABLE Accident (
    report_number VARCHAR(15) PRIMARY KEY,
    date DATE,
    location VARCHAR(100)
);


CREATE TABLE Owns (
    driver_id VARCHAR(10),
    license VARCHAR(15),
    PRIMARY KEY (driver_id, license),
    FOREIGN KEY (driver_id) REFERENCES Person(driver_id),
    FOREIGN KEY (license) REFERENCES Car(license)
);


CREATE TABLE Participated (
    license VARCHAR(15),
    report_number VARCHAR(15),
    damage_amount DECIMAL(10, 2),
    PRIMARY KEY (license, report_number),
    FOREIGN KEY (license) REFERENCES Car(license),
    FOREIGN KEY (report_number) REFERENCES Accident(report_number)
);


INSERT INTO Person (driver_id, name, address) VALUES
('D001', 'John Smith', '123 Main St'),
('D002', 'Jane Doe', '456 Oak Ave'),
('D003', 'Mike Johnson', '789 Pine Rd');


INSERT INTO Car (license, model, year) VALUES
('AAB2000', 'Toyota Camry', 2015),
('XYZ1234', 'Honda Accord', 2018),
('LMN5678', 'Ford Focus', 2017);


INSERT INTO Accident (report_number, date, location) VALUES
('AR2197', '2023-01-15', 'Downtown'),
('AR3456', '2023-02-20', 'Uptown'),
('AR5678', '2023-03-10', 'Midtown');


INSERT INTO Owns (driver_id, license) VALUES
('D001', 'AAB2000'),  
('D002', 'XYZ1234'),  
('D001', 'LMN5678');   


INSERT INTO Participated (license, report_number, damage_amount) VALUES
('AAB2000', 'AR2197', 2500.00),   
('XYZ1234', 'AR3456', 1500.00),   
('LMN5678', 'AR5678', 2000.00);  


-- a. Find the number of accidents in which the cars belonging to “John Smith” were involved.
SELECT COUNT(DISTINCT P.report_number) AS accident_count
FROM Person Pe
JOIN Owns O ON Pe.driver_id = O.driver_id
JOIN Participated P ON O.license = P.license
WHERE Pe.name = 'John Smith';


-- b. Update the damage amount for the car with the license number “AAB2000” in the 
--    accident with report number “AR2197” to $3000.
UPDATE Participated
SET damage_amount = 3000.00
WHERE license = 'AAB2000' AND report_number = 'AR2197';