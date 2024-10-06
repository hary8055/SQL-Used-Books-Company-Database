-- List books for sale with seller details
SELECT B.Title, A.AuthorName, C.CategoryName, S.SellerName, B.Book_Condition, B.Price, I.StockQuantity
FROM Books B
JOIN Authors A ON B.AuthorID = A.AuthorID
JOIN Categories C ON B.CategoryID = C.CategoryID
JOIN Sellers S ON B.SellerID = S.SellerID
JOIN Inventory I ON B.BookID = I.BookID;

-- Book by author
SELECT B.Title, B.Book_Condition, B.Price, S.SellerName
FROM Books B
JOIN Authors A ON B.AuthorID = A.AuthorID
JOIN Sellers S ON B.SellerID = S.SellerID
WHERE A.AuthorName = 'J.K. Rowling';

-- All orders of a customer
SELECT O.OrderID, O.OrderDate, O.TotalAmount
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE C.CustomerName = 'David Green';

-- check inventory
SELECT B.Title, S.SellerName, I.StockQuantity
FROM Inventory I
JOIN Books B ON I.BookID = B.BookID
JOIN Sellers S ON I.SellerID = S.SellerID
WHERE B.Title = 'The Great Gatsby';

-- calculating total sales of a seller
SELECT S.SellerName, SUM(OD.Quantity * OD.Price) AS TotalSales
FROM OrderDetails OD
JOIN Orders O ON OD.OrderID = O.OrderID
JOIN Books B ON OD.BookID = B.BookID
JOIN Sellers S ON B.SellerID = S.SellerID
WHERE S.SellerID = 1;

-- Top selling books
SELECT B.Title, SUM(OD.Quantity) AS TotalSold
FROM OrderDetails OD
JOIN Books B ON OD.BookID = B.BookID
GROUP BY B.Title
ORDER BY TotalSold DESC
LIMIT 5;

-- all orders which include a specific category
SELECT O.OrderID, C.CustomerName, O.OrderDate
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID 
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Books B ON OD.BookID = B.BookID
JOIN Categories CA ON B.CategoryID = CA.CategoryID
WHERE CA.CategoryName = 'Science Fiction';

-- track low stock
SELECT B.Title, S.SellerName, I.StockQuantity
FROM Inventory I
JOIN Books B ON I.BookID = B.BookID
JOIN Sellers S ON I.SellerID = S.SellerID
WHERE I.StockQuantity < 5;

-- Creating triggers
-- Trigger to automatically reduce inventory after an order

DELIMITER //
CREATE TRIGGER ReduceStockAfterOrder
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
  UPDATE Inventory
  SET StockQuantity = StockQuantity - NEW.Quantity
  WHERE BookID = NEW.BookID;
END; 
//
DELIMITER ;

-- trigger to prevent overselling

DELIMITER //

CREATE TRIGGER CheckStockBeforeOrder
BEFORE INSERT ON OrderDetails
FOR EACH ROW
BEGIN
  DECLARE current_stock INT;
  SELECT StockQuantity INTO current_stock
  FROM Inventory
  WHERE BookID = NEW.BookID;
  
  IF current_stock < NEW.Quantity THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Not enough stock available for this book';
  END IF;
END;
//
DELIMITER ;

-- creating stored procedures
-- add a new book listing

DELIMITER //
CREATE PROCEDURE AddNewBookListing(
    IN p_Title VARCHAR(255),
    IN p_AuthorID INT,
    IN p_CategoryID INT,
    IN p_Book_Condition ENUM('New', 'Like New', 'Good', 'Acceptable'),
    IN p_Price DECIMAL,
    IN p_SellerID INT,
    IN p_StockQuantity INT
)
BEGIN
    -- Insert into Books
    INSERT INTO Books (Title, AuthorID, CategoryID, Book_Condition, Price, SellerID)
    VALUES (p_Title, p_AuthorID, p_CategoryID, p_Book_Condition, p_Price, p_SellerID);
    
    -- Insert into Inventory
    INSERT INTO Inventory (BookID, SellerID, StockQuantity)
    VALUES (LAST_INSERT_ID(), p_SellerID, p_StockQuantity);
END;
//
DELIMITER ;

-- creating views
-- view to show all details about available books

DELIMITER //
CREATE VIEW AvailableBooks AS
SELECT B.Title, A.AuthorName, C.CategoryName, S.SellerName, B.Book_Condition, B.Price, I.StockQuantity
FROM Books B
JOIN Authors A ON B.AuthorID = A.AuthorID
JOIN Categories C ON B.CategoryID = C.CategoryID
JOIN Sellers S ON B.SellerID = S.SellerID
JOIN Inventory I ON B.BookID = I.BookID
WHERE I.StockQuantity > 0;
//
DELIMITER ;

-- indexing for common queried fields
CREATE INDEX idx_books_title ON Books (Title);
CREATE INDEX idx_sellers_name ON Sellers (SellerName);
CREATE INDEX idx_customers_email ON Customers (Email);