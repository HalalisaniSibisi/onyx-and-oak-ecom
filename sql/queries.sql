-- E-Commerce Practice Database: Reporting Queries

-- 1. Total spend per customer (lifetime, across all orders)
-- Grain: one row per customer. Grouping by UserID (the true identity),
-- not by name, since names aren't guaranteed unique.
SELECT
    c.FirstName,
    c.LastName,
    SUM(od.Quantity * od.PriceAtTimeOfOrder) AS Total_Spent
FROM CUSTOMERS c
JOIN ORDERS o ON c.UserID = o.UserID
JOIN ORDERDETAILS od ON o.OrderID = od.OrderID
GROUP BY
    c.UserID,
    c.FirstName,
    c.LastName
ORDER BY Total_Spent DESC;


-- 2. Top-selling products by total units sold
-- Grouping by ProductID (true identity), Description carried along for readability.
-- ORDER BY is required for TOP to mean anything — without it, results are arbitrary.
SELECT TOP 3
    p.Description,
    SUM(od.Quantity) AS Total_Units
FROM INVENTORY p
JOIN ORDERDETAILS od ON p.ProductID = od.ProductID
GROUP BY
    p.ProductID,
    p.Description
ORDER BY Total_Units DESC;
