-- E-Commerce Practice Database: Seed Data
-- Run after schema.sql. Insert order matters: Users first (to generate IDs),
-- then Customers/Admin (which reuse those same IDs), then Orders, Inventory, OrderDetails.

-- USERS (15 total: UserID 1-12 become Customers, 13-15 become Admin)
INSERT INTO USERS (Email, HashedPassword) VALUES
('thabo.m@example.com', 'hash001'),
('lindiwe.k@example.com', 'hash002'),
('sipho.d@example.com', 'hash003'),
('nomvula.z@example.com', 'hash004'),
('kagiso.p@example.com', 'hash005'),
('ayanda.n@example.com', 'hash006'),
('bongani.s@example.com', 'hash007'),
('precious.m@example.com', 'hash008'),
('tumelo.r@example.com', 'hash009'),
('zanele.v@example.com', 'hash010'),
('lucky.t@example.com', 'hash011'),
('nokuthula.b@example.com', 'hash012'),
('admin.jane@example.com', 'hash013'),
('admin.peter@example.com', 'hash014'),
('admin.sarah@example.com', 'hash015');

-- CUSTOMERS (UserID 1-12, matching the Users rows above)
INSERT INTO CUSTOMERS (UserID, FirstName, LastName, ShippingAddress, ContactNumber) VALUES
(1, 'Thabo', 'Mokoena', '12 Long St, Durban', '0731234567'),
(2, 'Lindiwe', 'Khumalo', '45 Berea Rd, Durban', '0732345678'),
(3, 'Sipho', 'Dlamini', '8 Umbilo Rd, Durban', '0733456789'),
(4, 'Nomvula', 'Zulu', '22 Musgrave Rd, Durban', '0734567890'),
(5, 'Kagiso', 'Pillay', '3 Florida Rd, Durban', '0735678901'),
(6, 'Ayanda', 'Ngcobo', '17 Windermere Rd, Durban', '0736789012'),
(7, 'Bongani', 'Shabalala', '9 Chelsea Rd, Durban', '0737890123'),
(8, 'Precious', 'Mahlangu', '55 Ridge Rd, Durban', '0738901234'),
(9, 'Tumelo', 'Radebe', '31 Overport Dr, Durban', '0739012345'),
(10, 'Zanele', 'Vilakazi', '14 Manor Gdns, Durban', '0730123456'),
(11, 'Lucky', 'Themba', '6 Sydenham Rd, Durban', '0731122334'),
(12, 'Nokuthula', 'Buthelezi', '28 Glenwood Ave, Durban', '0732233445');

-- ADMIN (UserID 13-15, matching the last 3 Users rows above)
INSERT INTO ADMIN (UserID, PermissionLevel) VALUES
(13, 'SuperAdmin'),
(14, 'InventoryManager'),
(15, 'OrderManager');

-- INVENTORY (10 products)
INSERT INTO INVENTORY (Description, CurrentPrice) VALUES
('Wireless Mouse', 249.99),
('Mechanical Keyboard', 899.00),
('USB-C Hub', 349.50),
('27" Monitor', 3499.00),
('Laptop Stand', 599.00),
('Webcam 1080p', 749.99),
('Noise-Cancelling Headphones', 1899.00),
('Bluetooth Speaker', 649.00),
('External SSD 1TB', 1299.00),
('Ergonomic Chair', 2999.00);

-- ORDERS (15 orders spread across customers)
INSERT INTO ORDERS (OrderDate, UserID) VALUES
('2026-06-01', 1),('2026-06-03', 2),('2026-06-05', 3),
('2026-06-07', 4),('2026-06-09', 5),('2026-06-11', 6),
('2026-06-13', 7),('2026-06-15', 8),('2026-06-17', 9),
('2026-06-19', 10),('2026-06-21', 11),('2026-06-23', 12),
('2026-07-01', 1),('2026-07-05', 3),('2026-07-10', 6);

-- ORDERDETAILS (line items — some orders have multiple products)
INSERT INTO ORDERDETAILS (OrderID, ProductID, Quantity, PriceAtTimeOfOrder) VALUES
(1, 1, 1, 249.99),(1, 3, 1, 349.50),
(2, 2, 1, 899.00),
(3, 4, 1, 3499.00),(3, 5, 1, 599.00),
(4, 6, 2, 749.99),
(5, 7, 1, 1899.00),
(6, 8, 1, 649.00),(6, 9, 1, 1299.00),
(7, 10, 1, 2999.00),
(8, 1, 2, 249.99),
(9, 2, 1, 899.00),
(10, 3, 3, 349.50),
(11, 4, 1, 3499.00),
(12, 5, 2, 599.00),
(13, 6, 1, 749.99),
(14, 7, 1, 1899.00),
(15, 8, 2, 649.00);
