SELECT DATE_FORMAT(InvoiceDate, '%Y%-%M') AS MonthlyRevenue, 
SUM(Quantity * UnitPrice) AS TotalRevenue
FROM online_retail.`online retail` 
WHERE InvoiceDate BETWEEN 2010/12/23 AND 2010/01/01
GROUP BY DATE_FORMAT(InvoiceDate, '%Y%-%M')
ORDER BY DATE_FORMAT (InvoiceDate, '%Y%-%M');


SELECT StockCode, Description, SUM(Quantity) AS TotalQuantitySold
FROM online_retail.`online retail`
GROUP BY StockCode, Description
ORDER BY SUM(Quantity) desc 
LIMIT 10; 


SELECT Country, SUM(Quantity * UnitPrice) AS Revenue, 
ROUND((SUM(Quantity * UnitPrice)/ 
(SELECT SUM(Quantity * UnitPrice) FROM online_retail.`online retail`)) * 100, 2) AS PercentCont
FROM online_retail.`online retail`
GROUP BY Country 
ORDER BY Revenue DESC;

WITH FirstPurchase AS(
SELECT CustomerID, MIN(InvoiceDate) AS FirstPurchaseDate 
FROM online_retail.`online retail` 
GROUP BY CustomerID 
), 
RepeatCustomers AS (
SELECT fp.CustomerID
FROM online_retail.`online retail` r 
INNER JOIN FirstPurchase FP 
ON r.CustomerID = fp.CustomerID
WHERE r.InvoiceDate > fp.FirstPurchaseDate
)
SELECT
(SELECT COUNT(DISTINCT CustomerID) FROM RepeatCustomers) / 
(SELECT COUNT(DISTINCT CustomerID) FROM online_retail.`online retail`) * 100 AS RetentionRate;



SELECT ROUND(SUM(Quantity * UnitPrice)/ COUNT(DISTINCT InvoiceNo), 2) AS AverageOrderValue
FROM online_retail.`online retail`;

























