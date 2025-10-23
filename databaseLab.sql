CREATE DATABASE Store;
USE Store;

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Address VARCHAR(100),
    DOB DATE
);

CREATE TABLE Product (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(50),
    Description VARCHAR(100),
    Quantity INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Order_Details (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);


INSERT INTO Customer (FirstName, LastName, Address, DOB) VALUES
('Mark', 'Johnson', 'Cairo, Egypt', '1990-05-14'),
('Sara', 'Ali', 'Alexandria, Egypt', '1995-09-23'),
('Omar', 'Nabil', 'Giza, Egypt', '1989-11-10');

INSERT INTO Product (ProductName, Description, Quantity, Price) VALUES
('Shampoo', 'Soft hair care', 40, 45.00),
('Soap', 'Scented body soap', 60, 25.00),
('Sneakers', 'Sport shoes', 15, 350.00);

INSERT INTO Orders (CustomerID, OrderDate, Status) VALUES
(1, '2025-10-01', 'Delivered'),
(2, '2025-10-05', 'Pending'),
(3, '2025-10-07', 'Delivered');

INSERT INTO Order_Details (OrderID, ProductID, Quantity) VALUES
(1, 1, 2),
(1, 2, 3),
(2, 3, 1);


SELECT * FROM Customer;
SELECT ProductID, ProductName, Quantity FROM Product;

SELECT DISTINCT c.CustomerID, c.FirstName
FROM Customer c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.Status = 'Delivered';


CREATE VIEW VCustomerDOB AS
SELECT CONCAT(FirstName, ' ', LastName) AS CustomerName, Address
FROM Customer
WHERE DOB = '1990-05-14';

CREATE VIEW VDeliveredOrders AS
SELECT CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, o.OrderID
FROM Customer c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.Status = 'Delivered';

CREATE VIEW VCustomerOrderProduct AS
SELECT c.CustomerID, o.OrderDate, o.Status, p.ProductName, p.Description
FROM Customer c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Order_Details od ON o.OrderID = od.OrderID
JOIN Product p ON od.ProductID = p.ProductID;

DROP VIEW VCustomerOrderProduct;

CREATE VIEW VCustomerAllData AS
SELECT * FROM Customer
WHERE FirstName = 'Mark';

ALTER VIEW VCustomerAllData RENAME TO CustomerView;

CREATE VIEW VProductDetails AS
SELECT ProductName, Description
FROM Product
WHERE Description LIKE 'S%'
WITH CHECK OPTION;

INSERT INTO VProductDetails (ProductName, Description)
VALUES ('Soda', 'Sparkling drink');

SELECT * FROM VProductDetails;

CREATE VIEW VCustomerOrderDate AS
SELECT c.CustomerID, c.FirstName AS CustomerFirstName, o.OrderDate AS DateOfOrder
FROM Customer c
JOIN Orders o ON c.CustomerID = o.CustomerID;


CREATE INDEX IDX_CustOrderDate ON Orders(CustomerID, OrderDate);
