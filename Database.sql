CREATE DATABASE UsedBooksCompanydb;

USE UsedBooksCompanydb;
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    AuthorName VARCHAR(255) NOT NULL
);


CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(255) NOT NULL
);

CREATE TABLE Sellers (
    SellerID INT AUTO_INCREMENT PRIMARY KEY,
    SellerName VARCHAR(255) NOT NULL,
    Address VARCHAR(255),
    Phone VARCHAR(50),
    Email VARCHAR(255)
);

CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(255) NOT NULL,
    Address VARCHAR(255),
    Phone VARCHAR(50),
    Email VARCHAR(255)
);

CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    AuthorID INT,
    CategoryID INT,
    Book_Condition ENUM('New', 'Like New', 'Good', 'Fair') NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    SellerID INT,
    CopiesAvailable INT NOT NULL,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (SellerID) REFERENCES Sellers(SellerID)
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    BookID INT,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentMethod ENUM('Credit Card', 'Debit Card', 'PayPal', 'Cash') NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE Shipping (
    ShippingID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ShippingAddress VARCHAR(255) NOT NULL,
    ShippingDate DATE,
    DeliveryDate DATE,
    TrackingNumber VARCHAR(100),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE Inventory (
    InventoryID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    SellerID INT,
    StockQuantity INT NOT NULL,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (SellerID) REFERENCES Sellers(SellerID)
);

CREATE TABLE Reviews (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    CustomerID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    ReviewDate DATE NOT NULL,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Discounts (
    DiscountID INT AUTO_INCREMENT PRIMARY KEY,
    Code VARCHAR(50) NOT NULL,
    Percentage DECIMAL(5, 2) CHECK (Percentage >= 0 AND Percentage <= 100),
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL
);

CREATE TABLE BookDiscounts (
    BookDiscountID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    DiscountID INT,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (DiscountID) REFERENCES Discounts(DiscountID)
);

CREATE TABLE Returns (
    ReturnID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ReturnDate DATE NOT NULL,
    Reason VARCHAR(255),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE Wishlists (
    WishlistID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    BookID INT,
    DateAdded DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

/*populating*/

INSERT INTO Authors (AuthorName) VALUES
('George Orwell'),
('Harper Lee'),
('J.K. Rowling'),
('J.R.R. Tolkien'),
('F. Scott Fitzgerald'),
('Agatha Christie'),
('Mark Twain'),
('Ernest Hemingway'),
('Jane Austen'),
('C.S. Lewis'),
('Stephen King'),
('Isaac Asimov'),
('Charles Dickens'),
('Toni Morrison'),
('Ray Bradbury'),
('J.D. Salinger'),
('Virginia Woolf'),
('Leo Tolstoy'),
('Gabriel García Márquez'),
('Haruki Murakami');

INSERT INTO Categories (CategoryName) VALUES
('Fiction'),
('Non-Fiction'),
('Fantasy'),
('Science Fiction'),
('Classics'),
('Mystery'),
('Thriller'),
('Romance'),
('Biography'),
('Self-Help'),
('Historical Fiction'),
('Young Adult'),
('Children\'s'),
('Poetry'),
('Graphic Novels'),
('Travel'),
('Cookbooks'),
('Science'),
('Health'),
('Business');

INSERT INTO Sellers (SellerName, Address, Phone, Email) VALUES
('Alice Smith', '123 Book St, Booktown', '555-0123', 'alice@gmail.com'),
('Bob Johnson', '456 Read Ave, Readsville', '555-0456', 'bob@yahoo.com'),
('Charlie Brown', '789 Novel Blvd, Novelcity', '555-0789', 'charlie@gmail.com'),
('Diana Prince', '234 Hero Rd, Supercity', '555-0987', 'diana@yahoo.com'),
('Elon Musk', '777 SpaceX St, Starland', '555-7654', 'elon@gmail.com'),
('Bruce Wayne', '1 Gotham Way, Gotham City', '555-1234', 'bruce@yahoo.com'),
('Clark Kent', '12 Metropolis Ave, Metropolis', '555-5678', 'clark@gmail.com'),
('Peter Parker', '45 Web St, New York', '555-8765', 'peter@yahoo.com'),
('Wade Wilson', '21 Merc Lane, Deadpool City', '555-4321', 'wade@gmail.com'),
('Natasha Romanoff', '77 Spy St, Avengers HQ', '555-2468', 'natasha@yahoo.com'),
('Tony Stark', '88 Stark Tower, Tech City', '555-6543', 'tony@gmail.com'),
('Lara Croft', '10 Tomb Raider Rd, Adventure City', '555-3690', 'lara@yahoo.com'),
('Frodo Baggins', '1 Shire Ln, Hobbiton', '555-2460', 'frodo@gmail.com'),
('Hermione Granger', '9 Hogwarts St, Wizarding World', '555-9630', 'hermione@yahoo.com'),
('Darth Vader', '2 Sith Ave, Galaxy Far Away', '555-7410', 'vader@gmail.com'),
('Gandalf the Grey', '4 Middle-Earth Rd, Rivendell', '555-8520', 'gandalf@yahoo.com'),
('Sherlock Holmes', '221B Baker St, London', '555-1590', 'sherlock@gmail.com'),
('Albus Dumbledore', '12 Hogwarts Way, Wizarding World', '555-7530', 'dumbledore@yahoo.com'),
('Dr. Who', 'TARDIS St, Time City', '555-9510', 'doctor@gmail.com'),
('Katniss Everdeen', '3 District Ln, Panem', '555-2580', 'katniss@yahoo.com');


INSERT INTO Customers (CustomerName, Address, Phone, Email) VALUES
('David Green', '111 Reader Rd, Readerville', '555-0101', 'david@gmail.com'),
('Emma White', '222 Author Ln, Authorland', '555-0202', 'emma@yahoo.com'),
('Frank Black', '333 Publisher Pl, Publisher Town', '555-0303', 'frank@gmail.com'),
('Grace Blue', '444 Page St, Page City', '555-0404', 'grace@yahoo.com'),
('Henry Gold', '555 Text Ave, Textopolis', '555-0505', 'henry@gmail.com'),
('Isla Silver', '666 Cover Rd, Cover Town', '555-0606', 'isla@yahoo.com'),
('Jack Red', '777 Print Blvd, Print City', '555-0707', 'jack@gmail.com'),
('Kira Orange', '888 Spine St, Spine Town', '555-0808', 'kira@yahoo.com'),
('Liam Purple', '999 Print St, Print City', '555-0909', 'liam@gmail.com'),
('Mia Cyan', '101 Color St, Color Town', '555-1111', 'mia@yahoo.com'),
('Noah Magenta', '202 Bright St, Bright City', '555-2222', 'noah@gmail.com'),
('Olivia Violet', '303 Rainbow Ave, Rainbow City', '555-3333', 'olivia@yahoo.com'),
('Parker Indigo', '404 Spectrum St, Spectrum City', '555-4444', 'parker@gmail.com'),
('Quinn Black', '505 Ink St, Ink Town', '555-5555', 'quinn@yahoo.com'),
('Riley Grey', '606 Shade St, Shade City', '555-6666', 'riley@gmail.com'),
('Sophie White', '707 Canvas Ave, Canvas City', '555-7777', 'sophie@yahoo.com'),
('Tyler Brown', '808 Art St, Art Town', '555-8888', 'tyler@gmail.com'),
('Uma Jade', '909 Green St, Green City', '555-9999', 'uma@yahoo.com'),
('Victor Bronze', '1001 Colorful Ln, Colorful City', '555-0011', 'victor@gmail.com'),
('Willow Peach', '1002 Rainbow Blvd, Rainbow City', '555-0022', 'willow@yahoo.com');


INSERT INTO Books (Title, AuthorID, CategoryID, Book_Condition, Price, SellerID, CopiesAvailable) VALUES
('1984', 1, 1, 'Good', 9.99, 1, 5),
('To Kill a Mockingbird', 2, 1, 'Like New', 12.99, 2, 3),
('Harry Potter and the Philosopher\'s Stone', 3, 3, 'New', 15.99, 3, 10),
('The Hobbit', 4, 3, 'Fair', 8.99, 1, 2),
('The Great Gatsby', 5, 5, 'Good', 10.99, 2, 4),
('Murder on the Orient Express', 6, 6, 'New', 14.99, 1, 7),
('The Catcher in the Rye', 15, 1, 'Good', 11.99, 2, 5),
('Pride and Prejudice', 9, 1, 'Like New', 9.99, 1, 8),
('Brave New World', 1, 3, 'New', 13.99, 3, 6),
('The Picture of Dorian Gray', 13, 1, 'Fair', 7.99, 2, 4),
('The Da Vinci Code', 12, 6, 'Good', 18.99, 3, 9),
('The Alchemist', 10, 1, 'New', 16.99, 1, 8),
('The Shining', 11, 1, 'Good', 10.99, 2, 7),
('Little Women', 8, 5, 'Like New', 8.99, 3, 4),
('Dune', 12, 3, 'Fair', 12.99, 1, 5),
('Wuthering Heights', 10, 5, 'Good', 11.99, 2, 6),
('Fahrenheit 451', 12, 3, 'New', 15.99, 3, 5),
('The Hitchhiker\'s Guide to the Galaxy', 11, 3, 'Like New', 14.99, 1, 3),
('The Handmaid\'s Tale', 10, 1, 'Good', 13.99, 2, 2),
('The Fault in Our Stars', 15, 1, 'New', 17.99, 3, 8),
('The Chronicles of Narnia', 11, 3, 'Like New', 19.99, 1, 6);

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, '2024-10-01', 28.98),
(2, '2024-10-02', 12.99),
(1, '2024-10-03', 19.98),
(3, '2024-10-04', 23.99),
(4, '2024-10-05', 45.99),
(5, '2024-10-06', 29.99),
(6, '2024-10-07', 34.99),
(7, '2024-10-08', 50.99),
(8, '2024-10-09', 14.99),
(9, '2024-10-10', 39.99),
(10, '2024-10-11', 9.99),
(11, '2024-10-12', 20.99),
(12, '2024-10-13', 31.99),
(13, '2024-10-14', 44.99),
(14, '2024-10-15', 17.99),
(15, '2024-10-16', 22.99),
(16, '2024-10-17', 18.99),
(17, '2024-10-18', 29.99),
(18, '2024-10-19', 10.99),
(19, '2024-10-20', 23.99),
(20, '2024-10-21', 27.99);

INSERT INTO OrderDetails (OrderID, BookID, Quantity, Price) VALUES
(1, 1, 2, 9.99),
(2, 2, 1, 12.99),
(3, 3, 1, 15.99),
(4, 4, 2, 11.99),
(5, 5, 1, 19.99),
(6, 6, 1, 14.99),
(7, 7, 2, 5.99),
(8, 8, 1, 8.99),
(9, 9, 1, 15.99),
(10, 10, 1, 10.99),
(11, 11, 2, 8.99),
(12, 12, 1, 18.99),
(13, 13, 1, 12.99),
(14, 14, 2, 5.99),
(15, 15, 1, 20.99),
(16, 16, 2, 17.99),
(17, 17, 1, 10.99),
(18, 18, 1, 22.99),
(19, 19, 1, 9.99),
(20, 20, 1, 23.99);

INSERT INTO Payments (OrderID, PaymentDate, Amount, PaymentMethod) VALUES
(1, '2024-10-01', 28.98, 'Credit Card'),
(2, '2024-10-02', 12.99, 'PayPal'),
(3, '2024-10-03', 19.98, 'Debit Card'),
(4, '2024-10-04', 23.99, 'Credit Card'),
(5, '2024-10-05', 45.99, 'Cash'),
(6, '2024-10-06', 29.99, 'PayPal'),
(7, '2024-10-07', 34.99, 'Credit Card'),
(8, '2024-10-08', 50.99, 'Debit Card'),
(9, '2024-10-09', 14.99, 'Cash'),
(10, '2024-10-10', 39.99, 'Credit Card'),
(11, '2024-10-11', 9.99, 'PayPal'),
(12, '2024-10-12', 20.99, 'Debit Card'),
(13, '2024-10-13', 31.99, 'Cash'),
(14, '2024-10-14', 44.99, 'Credit Card'),
(15, '2024-10-15', 17.99, 'Debit Card'),
(16, '2024-10-16', 22.99, 'PayPal'),
(17, '2024-10-17', 18.99, 'Cash'),
(18, '2024-10-18', 29.99, 'Credit Card'),
(19, '2024-10-19', 10.99, 'Debit Card'),
(20, '2024-10-20', 23.99, 'Credit Card');

INSERT INTO Shipping (OrderID, ShippingAddress, ShippingDate, DeliveryDate, TrackingNumber) VALUES
(1, '111 Reader Rd, Readerville', '2024-10-02', '2024-10-05', 'TRACK1234'),
(2, '222 Author Ln, Authorland', '2024-10-03', '2024-10-06', 'TRACK5678'),
(3, '111 Reader Rd, Readerville', '2024-10-03', '2024-10-06', 'TRACK91011'),
(4, '444 Page St, Page City', '2024-10-04', '2024-10-07', 'TRACK1213'),
(5, '555 Text Ave, Textopolis', '2024-10-05', '2024-10-08', 'TRACK1415'),
(6, '666 Cover Rd, Cover Town', '2024-10-06', '2024-10-09', 'TRACK1617'),
(7, '777 Print Blvd, Print City', '2024-10-07', '2024-10-10', 'TRACK1819'),
(8, '888 Spine St, Spine Town', '2024-10-08', '2024-10-11', 'TRACK2021'),
(9, '999 Print St, Print City', '2024-10-09', '2024-10-12', 'TRACK2223'),
(10, '101 Color St, Color Town', '2024-10-10', '2024-10-13', 'TRACK2425'),
(11, '202 Bright St, Bright City', '2024-10-11', '2024-10-14', 'TRACK2627'),
(12, '303 Rainbow Ave, Rainbow City', '2024-10-12', '2024-10-15', 'TRACK2829'),
(13, '404 Spectrum St, Spectrum City', '2024-10-13', '2024-10-16', 'TRACK3031'),
(14, '505 Ink St, Ink Town', '2024-10-14', '2024-10-17', 'TRACK3233'),
(15, '606 Shade St, Shade City', '2024-10-15', '2024-10-18', 'TRACK3435'),
(16, '707 Canvas Ave, Canvas City', '2024-10-16', '2024-10-19', 'TRACK3637'),
(17, '808 Art St, Art Town', '2024-10-17', '2024-10-20', 'TRACK3839'),
(18, '909 Green St, Green City', '2024-10-18', '2024-10-21', 'TRACK4041'),
(19, '1001 Colorful Ln, Colorful City', '2024-10-19', '2024-10-22', 'TRACK4243'),
(20, '1002 Rainbow Blvd, Rainbow City', '2024-10-20', '2024-10-23', 'TRACK4445');

INSERT INTO Inventory (BookID, SellerID, StockQuantity) VALUES
(1, 1, 5),
(2, 2, 3),
(3, 3, 10),
(4, 4, 2),
(5, 5, 4),
(6, 6, 7),
(7, 7, 6),
(8, 8, 5),
(9, 9, 3),
(10, 10, 4),
(11, 11, 6),
(12, 12, 5),
(13, 13, 3),
(14, 14, 4),
(15, 15, 5),
(16, 16, 2),
(17, 17, 3),
(18, 18, 4),
(19, 19, 5),
(20, 20, 6);

INSERT INTO Reviews (BookID, CustomerID, Rating, Comment, ReviewDate) VALUES
(1, 1, 5, 'A chilling depiction of a dystopian society.', '2024-10-01'),
(2, 2, 4, 'A classic that everyone should read.', '2024-10-02'),
(3, 1, 5, 'Magical and captivating!', '2024-10-03'),
(4, 3, 3, 'An interesting take on adventure.', '2024-10-04'),
(5, 2, 4, 'Timeless classic, beautifully written.', '2024-10-05'),
(6, 5, 4, 'Couldn’t put it down!', '2024-10-06'),
(7, 6, 5, 'A real page-turner.', '2024-10-07'),
(8, 7, 4, 'Interesting characters and plot.', '2024-10-08'),
(9, 8, 5, 'A beautiful story of love and loss.', '2024-10-09'),
(10, 9, 4, 'Thought-provoking and well-written.', '2024-10-10'),
(11, 10, 5, 'A thrilling ride from start to finish!', '2024-10-11'),
(12, 11, 3, 'Good, but not my favorite.', '2024-10-12'),
(13, 12, 4, 'Powerful and emotional.', '2024-10-13'),
(14, 13, 5, 'A must-read for everyone!', '2024-10-14'),
(15, 14, 5, 'I loved every minute of it.', '2024-10-15'),
(16, 15, 4, 'A solid read, but a bit predictable.', '2024-10-16'),
(17, 16, 4, 'Enjoyed the twists and turns.', '2024-10-17'),
(18, 17, 5, 'Simply amazing!', '2024-10-18'),
(19, 18, 4, 'Well-written and engaging.', '2024-10-19'),
(20, 19, 5, 'One of the best books I’ve ever read.', '2024-10-20');

INSERT INTO WishLists (CustomerID, BookID, DateAdded) VALUES
(1, 1, '2024-09-30'),
(1, 2, '2024-09-29'),
(2, 3, '2024-09-28'),
(2, 4, '2024-09-27'),
(3, 5, '2024-09-26'),
(3, 6, '2024-09-25'),
(4, 7, '2024-09-24'),
(4, 8, '2024-09-23'),
(5, 9, '2024-09-22'),
(5, 10, '2024-09-21'),
(6, 11, '2024-09-20'),
(6, 12, '2024-09-19'),
(7, 13, '2024-09-18'),
(7, 14, '2024-09-17'),
(8, 15, '2024-09-16'),
(8, 16, '2024-09-15'),
(9, 17, '2024-09-14'),
(9, 18, '2024-09-13'),
(10, 19, '2024-09-12'),
(10, 20, '2024-09-11'),
(11, 1, '2024-09-10');

INSERT INTO Discounts (Code, Percentage, StartDate, EndDate) VALUES
('SUMMER2024', 15.0, '2024-06-01', '2024-08-31'),
('FALL2024', 10.0, '2024-09-01', '2024-11-30'),
('WINTER2024', 20.0, '2024-12-01', '2024-12-31'),
('SPRING2025', 5.0, '2025-03-01', '2025-05-31'),
('BLACKFRIDAY', 30.0, '2024-11-01', '2024-11-30'),
('CYBERMONDAY', 25.0, '2024-11-25', '2024-11-30'),
('NEWYEAR', 10.0, '2024-12-30', '2025-01-05'),
('CLEARANCE', 50.0, '2024-01-01', '2024-01-31');

INSERT INTO BookDiscounts (BookID, DiscountID) VALUES
(1, 1), 
(2, 2), 
(3, 5), 
(4, 3), 
(5, 6), 
(6, 4), 
(7, 1),
(8, 2), 
(9, 3), 
(10, 4), 
(11, 1), 
(12, 2),
(13, 6), 
(14, 5), 
(15, 2), 
(16, 3), 
(17, 1), 
(18, 4), 
(19, 2),
(20, 5);

INSERT INTO Returns (OrderID, ReturnDate, Reason) VALUES
(1, '2024-10-04', 'Damaged item'),
(2, '2024-10-03', 'Changed my mind'),
(3, '2024-10-05', 'Wrong item sent'),
(4, '2024-10-06', 'Damaged item'),
(5, '2024-10-07', 'No longer needed'),
(6, '2024-10-08', 'Defective'),
(7, '2024-10-09', 'Changed my mind'),
(8, '2024-10-10', 'Damaged item'),
(9, '2024-10-11', 'Wrong item sent'),
(10, '2024-10-12', 'No longer needed');


