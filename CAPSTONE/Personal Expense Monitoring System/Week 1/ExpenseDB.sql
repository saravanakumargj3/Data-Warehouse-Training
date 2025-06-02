CREATE DATABASE ExpenseDB;

USE ExpenseDB;

-- 1: Create MSSQL Tables for users, categories, expenses
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    UserName NVARCHAR(100),
    Email NVARCHAR(100),
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(100),
    Description NVARCHAR(255)
);

CREATE TABLE Expenses (
    ExpenseID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID),--connecting tables
    Amount DECIMAL(10, 2),
    ExpenseDate DATE,
    Description NVARCHAR(255)
);

-- 2: Basic CRUD Operations
-- Insert into Users
INSERT INTO Users (UserName, Email) VALUES --foreign key restriction so user must me present
('SK', 'SK@example.com'),
('SH', 'SH@example.com');

-- Insert into Categories
INSERT INTO Categories (CategoryName, Description) VALUES
('Groceries', 'Daily food and supplies'),
('Utilities', 'Electricity, Water, etc.');

-- View IDs
SELECT * FROM Users;
SELECT * FROM Categories;

-- Now insert into Expenses
-- Suppose SK (UserID = 1), Groceries (CategoryID = 1)
INSERT INTO Expenses (UserID, CategoryID, Amount, ExpenseDate, Description) 
VALUES (1, 1, 500.00, '2025-06-01', 'Groceries at Supermarket');

SELECT * FROM Expenses;

--3. CRUD Operations
-- Update Expense
UPDATE Expenses
SET Amount = 550.00, Description = 'Updated groceries'
WHERE ExpenseID = 2; --id = 2 since i checked once

-- Delete Expense
DELETE FROM Expenses
WHERE ExpenseID = 2; -- removing the record

--4. Stored Procedure: Monthly Total per Category
CREATE PROCEDURE GetMonthlyTotalExpenses
    @UserID INT,
    @Month INT,
    @Year INT
AS
BEGIN
    SELECT 
        C.CategoryName,
        SUM(E.Amount) AS TotalAmount
    FROM Expenses E
    JOIN Categories C ON E.CategoryID = C.CategoryID
    WHERE 
        E.UserID = @UserID AND 
        MONTH(E.ExpenseDate) = @Month AND 
        YEAR(E.ExpenseDate) = @Year
    GROUP BY C.CategoryName
END;


--Adding records so that stored procedure can retrieve results
-- Categories
INSERT INTO Categories (CategoryName, Description) VALUES
('Entertainment', 'Movies, subscriptions'),
('Transport', 'Fuel, bus, train fares');

-- Expenses for June 2025 (SK)
INSERT INTO Expenses (UserID, CategoryID, Amount, ExpenseDate, Description) VALUES
(1, 1, 500.00, '2025-06-01', 'Groceries at SuperMart'),
(1, 2, 1200.00, '2025-06-05', 'Electricity bill'),
(1, 3, 300.00, '2025-06-10', 'Netflix subscription'),
(1, 1, 650.00, '2025-06-20', 'Monthly ration'),
(1, 4, 200.00, '2025-06-25', 'Fuel expense');

-- Execute the procedure (for SK in June 2025)
EXEC GetMonthlyTotalExpenses @UserID = 1, @Month = 6, @Year = 2025;