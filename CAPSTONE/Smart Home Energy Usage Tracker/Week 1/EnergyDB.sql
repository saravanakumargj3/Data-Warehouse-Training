CREATE DATABASE EnergyDB;

USE EnergyDB;

-- MSSQL Schema for Devices, Energy Logs, and Rooms
CREATE TABLE Rooms (
    RoomID INT PRIMARY KEY IDENTITY(1,1),
    RoomName NVARCHAR(50) NOT NULL,
    Floor INT NOT NULL --floor number
);

CREATE TABLE Devices (
    DeviceID INT PRIMARY KEY IDENTITY(1,1),
    DeviceName NVARCHAR(50) NOT NULL,
    RoomID INT NOT NULL,
    DeviceType NVARCHAR(50),
    Status BIT NOT NULL DEFAULT 0, -- 0 = off, 1 = on
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);

CREATE TABLE EnergyLogs (
    LogID BIGINT PRIMARY KEY IDENTITY(1,1),
    DeviceID INT NOT NULL,
    Timestamp DATETIME NOT NULL,
    Energy_kWh DECIMAL(10,4) NOT NULL,
    FOREIGN KEY (DeviceID) REFERENCES Devices(DeviceID)
);

--CRUD Operations

INSERT INTO Rooms (RoomName, Floor) VALUES ('Living Room', 1);
INSERT INTO Devices (DeviceName, RoomID, DeviceType, Status) VALUES ('Smart TV', 1, 'Entertainment', 0);
INSERT INTO EnergyLogs (DeviceID, Timestamp, Energy_kWh) VALUES (1, '2025-06-02 10:00:00', 0.15);

--Read
SELECT d.DeviceID, d.DeviceName, r.RoomName, d.Status
FROM Devices d
JOIN Rooms r ON d.RoomID = r.RoomID
WHERE d.Status = 0;

--Update
UPDATE Devices
SET Status = 1, DeviceName = 'Updated Smart TV'
WHERE DeviceID = 1;

-- Delete
DELETE FROM EnergyLogs
WHERE DeviceID = 1 AND Timestamp < '2025-06-01'; 

--Total Energy Usage per Room per Day
CREATE PROCEDURE CalculateDailyRoomEnergy
    @Date DATE
AS
BEGIN
    SELECT 
        r.RoomID,
        r.RoomName,
        CAST(el.Timestamp AS DATE) AS UsageDate,
        SUM(el.Energy_kWh) AS TotalEnergy_kWh
    FROM Rooms r
    JOIN Devices d ON r.RoomID = d.RoomID
    JOIN EnergyLogs el ON d.DeviceID = el.DeviceID
    WHERE CAST(el.Timestamp AS DATE) = @Date
    GROUP BY r.RoomID, r.RoomName, CAST(el.Timestamp AS DATE);
END;

-- Insert additional records
INSERT INTO Rooms (RoomName, Floor) VALUES 
('Kitchen', 1),
('Bedroom', 2),
('Office', 1);

INSERT INTO Devices (DeviceName, RoomID, DeviceType, Status) VALUES 
('Refrigerator', 2, 'Appliance', 1),
('Laptop', 3, 'Electronics', 1),
('Desk Lamp', 4, 'Lighting', 0),
('Air Conditioner', 3, 'Appliance', 1);

INSERT INTO EnergyLogs (DeviceID, Timestamp, Energy_kWh) VALUES 
(1, '2025-06-02 12:00:00', 0.20),
(1, '2025-06-02 14:00:00', 0.18),
(2, '2025-06-02 08:00:00', 0.50),
(2, '2025-06-02 16:00:00', 0.45),
(3, '2025-06-02 10:00:00', 0.10),
(3, '2025-06-02 18:00:00', 0.12), 
(4, '2025-06-02 09:00:00', 0.05), 
(5, '2025-06-02 11:00:00', 1.20), 
(5, '2025-06-02 15:00:00', 1.30);


-- Example
EXEC CalculateDailyRoomEnergy @Date = '2025-06-02';