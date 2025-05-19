CREATE DATABASE BookStoreDB;

USE BookStoreDB;

CREATE TABLE Book (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Price INT,
    PublishedYear INT,
    Stock INT
);

INSERT INTO Book (BookID, Title, Author, Genre, Price, PublishedYear, Stock) VALUES
(1, 'The Alchemist', 'Paulo Coelho', 'Fiction', 300, 1988, 50),
(2, 'Sapiens', 'Yuval Noah Harari', 'Non-Fiction', 500, 2011, 30),
(3, 'Atomic Habits', 'James Clear', 'Self-Help', 400, 2018, 25),
(4, 'Rich Dad Poor Dad', 'Robert Kiyosaki', 'Personal Finance', 350, 1997, 20),
(5, 'The Lean Startup', 'Eric Ries', 'Business', 450, 2011, 15);

--1. Add a New Book
INSERT INTO Book (BookID, Title, Author, Genre, Price, PublishedYear, Stock)
VALUES (6, 'Deep Work', 'Cal Newport', 'Self-Help', 420, 2016, 35);

--2. Update Book Price
UPDATE Book
SET Price = Price + 50
WHERE Genre = 'Self-Help';

--3. Delete a Book
DELETE FROM Book
WHERE BookID = 4;

--4. Read All Books
SELECT * FROM Book
ORDER BY Title ASC;

--5. Sort by Price (Descending Order)
SELECT * FROM Book
ORDER BY Price DESC;

--6. Filter by Genre (Fiction)
SELECT * FROM Book
WHERE Genre = 'Fiction';

--7. Filter with AND Condition
SELECT * FROM Book
WHERE Genre = 'Self-Help' AND Price > 400;

--8. Filter with OR Condition
SELECT * FROM Book
WHERE Genre = 'Fiction' OR PublishedYear > 2000;

--9. Total Stock Value
SELECT SUM(Price * Stock) AS TotalStockValue
FROM Book;

--10. Average Price by Genre
SELECT Genre, AVG(Price) AS AveragePrice
FROM Book
GROUP BY Genre;

--11. Total Books by Author
SELECT COUNT(*) AS TotalBooksByAuthor
FROM Book
WHERE Author = 'Paulo Coelho';

--12. Find Books with a Keyword in Title
SELECT * FROM Book
WHERE Title LIKE '%The%';

--13. Filter by Multiple Conditions
SELECT * FROM Book
WHERE Author = 'Yuval Noah Harari' AND Price < 600;

--14. Find Books Within a Price Range
SELECT * FROM Book
WHERE Price BETWEEN 300 AND 500;

--15. Top 3 Most Expensive Books
SELECT TOP 3 * FROM Book
ORDER BY Price DESC;

--16. Books Published Before a Specific Year (2000)
SELECT * FROM Book
WHERE PublishedYear < 2000;

--17. Group by Genre: Total Number of Books in Each Genre
SELECT Genre, COUNT(*) AS TotalBooks
FROM Book
GROUP BY Genre;

--18. Find Duplicate Titles
SELECT Title, COUNT(*) AS Occurrences
FROM Book
GROUP BY Title
HAVING COUNT(*) > 1;

--19. Author with the Most Books
SELECT Author, COUNT(*) AS BookCount
FROM Book
GROUP BY Author
ORDER BY BookCount DESC
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;

SELECT Author
FROM Book
GROUP BY Author
HAVING COUNT(*) = (
    SELECT MAX(BookCount)
    FROM (
        SELECT COUNT(*) AS BookCount
        FROM Book
        GROUP BY Author
    ) AS AuthorCounts
);

--20. Oldest Book by Genre
SELECT Genre, MIN(PublishedYear) AS EarliestYear
FROM Book
GROUP BY Genre;

SELECT * FROM Book B
WHERE PublishedYear = (
    SELECT MIN(PublishedYear)
    FROM Book B2
    WHERE B2.Genre = B.Genre
);
