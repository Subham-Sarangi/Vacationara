CREATE VIEW LocationWiseSale AS
SELECT C.LOCATION AS Location, SUM(T.AMOUNT) AS Revenue FROM
Customer C INNER JOIN Purchase P ON
C.CustomerID = P.CustomerID INNER JOIN Transactions T ON
P.TransactionID = T.TransactionID
WHERE T.Status = 'Success'
GROUP BY C.Location
ORDER BY Revenue DESC  OFFSET 0 ROWS;

SELECT * FROM LocationWiseSale;

delete from Customer where CustomerID = 'C1600'

CREATE VIEW DestinationWiseSale AS
SELECT Pk.Location AS Destinations, SUM(T.AMOUNT) AS Revenue FROM
Purchase P INNER JOIN Transactions T ON
P.TransactionID = T.TransactionID INNER JOIN Package Pk ON
P.PackageID = Pk.PackageID
WHERE T.Status = 'Success'
GROUP BY Pk.Location
ORDER BY Revenue DESC  OFFSET 0 ROWS

SELECT * FROM DestinationWiseSale


CREATE VIEW FailedTransactions AS
SELECT Status, SUM(Amount) AS Amount , COUNT(Amount) AS Count FROM Transactions
GROUP BY Status
ORDER BY Amount DESC OFFSET 0 ROWS

SELECT * FROM FailedTransactions

CREATE VIEW YearWiseFinanceStatement AS
SELECT YEAR(P.Date) AS Year, SUM(F.Revenue) AS YearlyRevenue, SUM(F.Spendings) AS YearlySpendings, SUM(F.Profit) AS YearlyProfit FROM Finance F 
INNER JOIN Purchase P ON 
F.PurchaseID = P.PurchaseID
GROUP BY YEAR(P.Date)
ORDER BY YEAR(P.Date) DESC OFFSET 0 ROWS;

SELECT * FROM YearWiseFinanceStatement;

CREATE VIEW MonthWiseFinanceStatement AS
SELECT MONTH(P.Date) AS MONTH, SUM(F.Revenue) AS MonthlyRevenue, SUM(F.Spendings) AS MonthlySpendings, SUM(F.Profit) AS MonthlyProfit FROM Finance F 
INNER JOIN Purchase P ON 
F.PurchaseID = P.PurchaseID
GROUP BY MONTH(P.Date)
ORDER BY MONTH(P.Date) OFFSET 0 ROWS;

SELECT * FROM MonthWiseFinanceStatement
