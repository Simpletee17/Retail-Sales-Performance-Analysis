USE RetailSalesDB

SELECT * FROM dbo.SalesData

SELECT Product,TotalSales FROM dbo.SalesData

ALTER TABLE dbo.SalesData
ALTER COLUMN Quantity INT;

ALTER TABLE dbo.SalesData
ALTER COLUMN UnitPrice DECIMAL(10,2);

--QUERY 1 — TOTAL SALES FOR EACH PRODUCT
SELECT Product, SUM(Quantity*Unitprice) AS TotalSales FROM dbo.SalesData
GROUP BY Product
ORDER BY TotalSales DESC

--QUERY 2 — NUMBER OF SALES TRANSACTIONS IN EACH REGION
SELECT Region, COUNT(Customer_id) AS TotalTransactions FROM dbo.SalesData
GROUP BY Region
ORDER BY TotalTransactions DESC

--QUERY 3 — HIGHEST-SELLING PRODUCT
SELECT TOP 1
	Product, SUM(Quantity*Unitprice) AS TotalSales FROM dbo.SalesData
GROUP BY Product
ORDER BY TotalSales DESC

--QUERY 4 — TOTAL REVENUE PER PRODUCT
SELECT Product, SUM(Quantity*Unitprice) AS TotalRevenue FROM dbo.SalesData
GROUP BY Product
ORDER BY TotalRevenue DESC

--QUERY 5 — MONTHLY SALES TOTAL
SELECT Month, SUM(Quantity*Unitprice) AS MonthlySales FROM dbo.SalesData
GROUP BY Month
ORDER BY MonthlySales DESC

 OR

SELECT 
    DATENAME(MONTH, OrderDate) AS MonthName,
    SUM(Quantity * UnitPrice) AS MonthlySales
FROM SalesData
GROUP BY DATENAME(MONTH, OrderDate)
ORDER BY MonthlySales DESC;

OR

SELECT 
    FORMAT(OrderDate, 'MMMM') AS MonthName,
    SUM(Quantity * UnitPrice) AS MonthlySales
FROM SalesData
GROUP BY FORMAT(OrderDate, 'MMMM')
ORDER BY MonthlySales DESC;

--QUERY 6 — TOP 5 CUSTOMERS
SELECT TOP 5
	Customer_Id, SUM(Quantity*Unitprice) AS TotalPurchaseAmount FROM dbo.SalesData
GROUP BY Customer_Id
ORDER BY TotalPurchaseAmount DESC

--QUERY 7 — PERCENTAGE SALES BY REGION
SELECT Region, SUM(Quantity*Unitprice) AS TotalSales FROM dbo.SalesData
GROUP BY Region
ORDER BY TotalSales DESC

--% Percentage
SELECT 
    Region,
    SUM(Quantity * UnitPrice) * 100.0 /
    (SELECT SUM(Quantity * UnitPrice) FROM SalesData)
    AS SalesPercentage
FROM SalesData
GROUP BY Region
ORDER BY SalesPercentage DESC;



--QUERY 8 — PRODUCTS WITH NO SALES IN LAST QUARTER
SELECT DISTINCT Product
FROM SalesData
WHERE OrderDate < DATEADD(MONTH, -3, GETDATE());





