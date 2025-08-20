-- Smart Data Transformer Project

USE rw7;

DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;

-- Create Tables
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    City VARCHAR(50),
    Email VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Amount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10,2)
);

CREATE TABLE OrderDetails (
    DetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert Sample Data (Customers)
INSERT INTO Customers VALUES
(1, 'Alice', 'Delhi', 'alice@example.com'),
(2, 'Bob', 'Mumbai', 'bob@example.com'),
(3, 'Charlie', 'Chennai', 'charlie@example.com'),
(4, 'David', 'Kolkata', 'david@example.com'),
(5, 'Eva', 'Bangalore', 'eva@example.com'),
(6, 'Frank', 'Pune', 'frank@example.com'),
(7, 'Grace', 'Hyderabad', 'grace@example.com'),
(8, 'Hannah', 'Ahmedabad', 'hannah@example.com');

-- Insert Sample Data (Products)
INSERT INTO Products VALUES
(101, 'Keyboard', 800.00),
(102, 'Mouse', 500.00),
(103, 'Monitor', 7000.00),
(104, 'Printer', 6000.00),
(105, 'Headphones', 1500.00),
(106, 'Webcam', 1200.00),
(107, 'USB Drive', 600.00),
(108, 'Charger', 700.00);

-- Insert Sample Data (Orders)
INSERT INTO Orders VALUES
(1001, 1, '2025-08-01', 1600.00),
(1002, 2, '2025-08-02', 1200.00),
(1003, 3, '2025-08-03', 7000.00),
(1004, 4, '2025-08-04', 13500.00),
(1005, 5, '2025-08-05', 1500.00),
(1006, 6, '2025-08-06', 600.00),
(1007, 7, '2025-08-07', 7500.00),
(1008, 8, '2025-08-08', 700.00);

-- Insert Sample Data (OrderDetails)
INSERT INTO OrderDetails VALUES
(1, 1001, 101, 1),
(2, 1001, 102, 1),
(3, 1003, 103, 1),
(4, 1004, 104, 2),
(5, 1005, 105, 1),
(6, 1006, 107, 1),
(7, 1007, 103, 1),
(8, 1007, 105, 1),
(9, 1008, 108, 1);

-- Q1: Display all customers
SELECT * FROM Customers;

-- Q2: Show all orders with customer name
SELECT Orders.OrderID, Customers.Name, Orders.OrderDate, Orders.Amount
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

-- Q3: Show all products with price > 1000
SELECT * FROM Products WHERE Price > 1000;

-- Q4: Show order details with product name
SELECT OrderDetails.DetailID, Orders.OrderID, Products.ProductName, OrderDetails.Quantity
FROM OrderDetails
JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID;

-- Q5: Count total number of orders
SELECT COUNT(*) AS TotalOrders FROM Orders;

-- Q6: Display the highest priced product
SELECT * FROM Products ORDER BY Price DESC LIMIT 1;

-- Q7: Display customers from city 'Delhi'
SELECT * FROM Customers WHERE City = 'Delhi';

-- Q8: Show all orders with amount between 1000 and 8000
SELECT * FROM Orders WHERE Amount BETWEEN 1000 AND 8000;

-- Q9: Display product names starting with 'H'
SELECT * FROM Products WHERE ProductName LIKE 'H%';

-- Q10: Display total amount per customer
SELECT Customers.Name, SUM(Orders.Amount) AS TotalSpent
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Customers.Name;

-- Q11: Display customers who haven't placed orders
SELECT * FROM Customers
WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Orders);

-- Q12: Update product price of 'Mouse' to 550
UPDATE Products SET Price = 550 WHERE ProductName = 'Mouse';

-- Q13: Delete order detail with DetailID = 9
DELETE FROM OrderDetails WHERE DetailID = 9;

-- Q14: Show all order details after deleting a record
SELECT * FROM OrderDetails;

-- Q15: Show average amount of all orders
SELECT AVG(Amount) AS AvgAmount FROM Orders;

-- Q16: Add a new column 'Phone' to Customers table
ALTER TABLE Customers ADD Phone VARCHAR(15);

-- Q17: Drop column 'Phone' from Customers table
ALTER TABLE Customers DROP COLUMN Phone;
