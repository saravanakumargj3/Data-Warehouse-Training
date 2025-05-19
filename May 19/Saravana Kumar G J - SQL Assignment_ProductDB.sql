CREATE DATABASE InventoryDB;
USE InventoryDB;

CREATE TABLE ProductInventory (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Quantity INT,
    UnitPrice INT,
    Supplier VARCHAR(100),
    LastRestocked DATE
);

INSERT INTO ProductInventory (ProductName, Category, Quantity, UnitPrice, Supplier, LastRestocked)
VALUES
('Laptop', 'Electronics', 20, 70000, 'TechMart', '2025-04-20'),
('Office Chair', 'Furniture', 50, 5000, 'HomeComfort', '2025-04-18'),
('Smartwatch', 'Electronics', 30, 15000, 'GadgetHub', '2025-04-22'),
('Desk Lamp', 'Lighting', 80, 1200, 'BrightLife', '2025-04-25'),
('Wireless Mouse', 'Electronics', 100, 1500, 'GadgetHub', '2025-04-30');

--1. Add a new product
INSERT INTO ProductInventory (ProductName, Category, Quantity, UnitPrice, Supplier, LastRestocked)
VALUES ('Gaming Keyboard', 'Electronics', 40, 3500, 'TechMart', '2025-05-01');

--2. Update stock quantity (Desk Lamp): Increase Quantity by 20
UPDATE ProductInventory
SET Quantity = Quantity + 20
WHERE ProductName = 'Desk Lamp';

--3. Delete a discontinued product (Office Chair)
DELETE FROM ProductInventory
WHERE ProductID = 2;

--4. Read all products sorted by ProductName
SELECT * FROM ProductInventory
ORDER BY ProductName ASC;

--5. Sort by Quantity (Descending)
SELECT * FROM ProductInventory
ORDER BY Quantity DESC;

--6. Filter by Category: Electronics
SELECT * FROM ProductInventory
WHERE Category = 'Electronics';

--7. AND Condition: Electronics with Quantity > 20
SELECT * FROM ProductInventory
WHERE Category = 'Electronics' AND Quantity > 20;

--8. OR Condition: Electronics OR UnitPrice < 2000
SELECT * FROM ProductInventory
WHERE Category = 'Electronics' OR UnitPrice < 2000;

--9. Total stock value: Quantity * UnitPrice
SELECT SUM(Quantity * UnitPrice) AS TotalStockValue
FROM ProductInventory;

--10. Average price grouped by Category
SELECT Category, AVG(UnitPrice) AS AveragePrice
FROM ProductInventory
GROUP BY Category;

--11. Count products supplied by GadgetHub
SELECT COUNT(*) AS GadgetHubProductCount
FROM ProductInventory
WHERE Supplier = 'GadgetHub';

--12. ProductName starts with 'W'
SELECT * FROM ProductInventory
WHERE ProductName LIKE 'W%';

--13. GadgetHub + UnitPrice > 10000
SELECT * FROM ProductInventory
WHERE Supplier = 'GadgetHub' AND UnitPrice > 10000;

--14. UnitPrice BETWEEN 1000 AND 20000
SELECT * FROM ProductInventory
WHERE UnitPrice BETWEEN 1000 AND 20000;

--15. Top 3 most expensive products
SELECT TOP 3 * FROM ProductInventory
ORDER BY UnitPrice DESC;

--16. Products restocked in last 10 days from today (Assuming today is 2025-05-01)
SELECT * FROM ProductInventory
WHERE LastRestocked >= DATEADD(DAY, -10, '2025-05-01');

--17. Total quantity grouped by Supplier
SELECT Supplier, SUM(Quantity) AS TotalQuantity
FROM ProductInventory
GROUP BY Supplier;

--18. Products with Quantity < 30
SELECT * FROM ProductInventory
WHERE Quantity < 30;

--19. Supplier with most products
SELECT TOP 1 Supplier, COUNT(*) AS ProductCount
FROM ProductInventory
GROUP BY Supplier
ORDER BY ProductCount DESC;

--20. Product with highest stock value
SELECT TOP 1 *, (Quantity * UnitPrice) AS StockValue
FROM ProductInventory
ORDER BY StockValue DESC;