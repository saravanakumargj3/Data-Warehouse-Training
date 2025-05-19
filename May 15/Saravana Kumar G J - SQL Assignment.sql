CREATE DATABASE productdb;
USE productdb;
-- Creation of Table
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(30),
    Price INT,
    StockQuantity INT,
    Supplier VARCHAR(50)
);

--Insert Sample Data into Product Table
INSERT INTO Product (ProductID, ProductName, Category, Price, StockQuantity, Supplier) VALUES
(1, 'Laptop', 'Electronics', 70000, 50, 'TechMart'),
(2, 'Office Chair', 'Furniture', 5000, 100, 'HomeComfort'),
(3, 'Smartwatch', 'Electronics', 15000, 200, 'GadgetHub'),
(4, 'Desk Lamp', 'Lighting', 1200, 300, 'BrightLife'),
(5, 'Wireless Mouse', 'Electronics', 1500, 250, 'GadgetHub');

SELECT * FROM Product;

--1. Create – Add a New Product
INSERT INTO Product (ProductID, ProductName, Category, Price, StockQuantity, Supplier)
VALUES (6, 'Gaming Keyboard', 'Electronics', 3500, 150, 'TechMart');

--2. Update – Increase Price of All Electronics Products by 10%
UPDATE Product
SET Price = Price * 1.10
WHERE Category = 'Electronics';

-- 3. Delete – Remove Product with ProductID = 4
DELETE FROM Product
WHERE ProductID = 4;

--4. Read – Display All Products Sorted by Price in Descending Order
SELECT * FROM Product
ORDER BY Price DESC;

--5. Sort Products by Stock Quantity (Ascending)
SELECT * FROM Product
ORDER BY StockQuantity ASC;

--6. Filter Products by Category – Electronics
SELECT * FROM Product
WHERE Category = 'Electronics';

--7. Filter with AND Condition – Electronics Priced Above 5000
SELECT * FROM Product
WHERE Category = 'Electronics' AND Price > 5000;

--8.  Filter with OR Condition – Electronics or Price Below 2000
SELECT * FROM Product
WHERE Category = 'Electronics' OR Price < 2000;

--9. Total Stock Value (SUM(Price * StockQuantity))
SELECT SUM(Price * StockQuantity) AS TotalStockValue
FROM Product;

--10. Average Price of Each Category
SELECT Category, AVG(Price) AS AveragePrice
FROM Product
GROUP BY Category;

--11. Total Number of Products Supplied by GadgetHub
SELECT COUNT(*) AS TotalProductsByGadgetHub
FROM Product
WHERE Supplier = 'GadgetHub';

--12. Find Products Whose Name Contains "Wireless"
SELECT * FROM Product
WHERE ProductName LIKE '%Wireless%';

--13. Search for Products from Multiple Suppliers (TechMart or GadgetHub)
SELECT * FROM Product
WHERE Supplier IN ('TechMart', 'GadgetHub');

--14. Filter Using BETWEEN – Price Between 1000 and 20000
SELECT * FROM Product
WHERE Price BETWEEN 1000 AND 20000;

--15. Products with Stock Greater Than the Average Stock Quantity
SELECT * FROM Product
WHERE StockQuantity > (
    SELECT AVG(StockQuantity) FROM Product
);

--16. Top 3 Most Expensive Products
SELECT TOP 3 * FROM Product
ORDER BY Price DESC;

--17. Find Duplicate Supplier Names
SELECT Supplier, COUNT(*) AS ProductCount
FROM Product
GROUP BY Supplier
HAVING COUNT(*) > 1;

--18. Product Summary by Category (Count & Total Stock Value)
SELECT 
    Category,
    COUNT(*) AS NumberOfProducts,
    SUM(Price * StockQuantity) AS TotalStockValue
FROM Product
GROUP BY Category;

--19.Supplier with Most Products
SELECT TOP 1 Supplier, COUNT(*) AS ProductCount
FROM Product
GROUP BY Supplier
ORDER BY ProductCount DESC;

--20.  Most Expensive Product Per Category
SELECT Category, ProductName, Price
FROM Product p
WHERE Price = (
    SELECT MAX(Price)
    FROM Product
    WHERE Category = p.Category
);
