USE Northwind;
-- 1.
WITH product_list AS (
	SELECT 
		ProductName,
		Unit
	FROM Products
	WHERE Price > 50
    )
SELECT *
FROM product_list
;

-- 2.
WITH SELECT 
	p.ProductID,
    p.ProductName,
    SUM(Price*Quantity) AS TotalRevenue
FROM Products p
LEFT JOIN OrderDetails od
	ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY SUM(Price*Quantity) DESC
LIMIT 5
;

-- 3.
SELECT 
	CategoryName,
    COUNT(p.ProductID) AS ProProductCount
FROM Categories ca
JOIN Products p ON (ca.CategoryID = p.CategoryID)
GROUP BY CategoryName
ORDER BY COUNT(p.ProductID) DESC
;

-- 4. 
WITH ProductCount AS (
	SELECT 
		ca.CategoryName,
		AVG(od.Quantity) AS AvgOrderQuantity
    FROM Categories ca
	JOIN Products p ON (ca.CategoryID = p.CategoryID)
	JOIN OrderDetails od ON (p.ProductID = od.ProductID)
    GROUP BY ca.CategoryName
)
SELECT
	*
FROM ProductCount pc
ORDER BY pc.CategoryName
;

-- 5. 
WITH New_table AS (
    SELECT
        cs.CustomerID,
        cs.CustomerName,
        AVG(od.Quantity * p.Price) AS AvgOrderAmount
    FROM Customers cs
    JOIN Orders o ON cs.CustomerID = o.CustomerID
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    GROUP BY cs.CustomerID, cs.CustomerName
)
SELECT
    t.CustomerID,
    t.CustomerName,
    t.AvgOrderAmount
FROM New_table t
ORDER BY t.AvgOrderAmount DESC;

-- 6.
WITH order_count AS (
	SELECT 
		p.ProductName,
        SUM(od.Quantity) AS TotalSales
	FROM Customers cs
    JOIN Orders o ON cs.CustomerID = o.CustomerID
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    WHERE o.OrderDate BETWEEN '1997-01-01 00:00:00' AND '1998-01-01 00:00:00'
    GROUP BY p.ProductName
	)
SELECT 
	oc.ProductName,
    oc.TotalSales
FROM order_count oc
ORDER BY oc.TotalSales DESC
;