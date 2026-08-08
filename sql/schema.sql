-- E-Commerce Practice Database: Schema
-- Run in this order due to foreign key dependencies:
-- Users -> Admin/Customers -> Orders -> Inventory -> OrderDetails

CREATE TABLE USERS (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Email NVARCHAR(100) NOT NULL,
    HashedPassword NVARCHAR(150) NOT NULL
);

CREATE TABLE ADMIN (
    UserID INT PRIMARY KEY,
    PermissionLevel NVARCHAR(50),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE CUSTOMERS (
    UserID INT PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    ShippingAddress NVARCHAR(150) NOT NULL,
    ContactNumber NVARCHAR(20),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE ORDERS (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    OrderDate DATE,
    UserID INT,
    FOREIGN KEY (UserID) REFERENCES Customers(UserID)
);

CREATE TABLE INVENTORY (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    Description NVARCHAR(150),
    CurrentPrice DECIMAL(18,2) NOT NULL
);

CREATE TABLE ORDERDETAILS (
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT,
    PriceAtTimeOfOrder DECIMAL(18,2),
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES ORDERS(OrderID),
    FOREIGN KEY (ProductID) REFERENCES INVENTORY(ProductID)
);
