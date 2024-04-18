CREATE VIEW LocationWiseSale AS
SELECT C.LOCATION AS Location, SUM(T.AMOUNT) AS TotalRevenue, 
COUNT(T.Amount) AS Count, AVG(T.Amount) AS AverageTransaction 
FROM Customer C INNER JOIN Purchase P ON
C.CustomerID = P.CustomerID INNER JOIN Transactions T ON
P.TransactionID = T.TransactionID
WHERE T.Status = 'Success'
GROUP BY C.Location
ORDER BY TotalRevenue DESC  OFFSET 0 ROWS;

SELECT * FROM LocationWiseSale;

delete from Customer where CustomerID = 'C1600'

CREATE VIEW DestinationWiseSale AS
SELECT Pk.Location AS Destinations, SUM(T.AMOUNT) AS Revenue FROM
Purchase P INNER JOIN Transactions T ON
P.TransactionID = T.TransactionID INNER JOIN Package Pk ON
P.PackageID = Pk.PackageID
WHERE T.Status = 'Success'
GROUP BY Pk.Location
ORDER BY Revenue DESC  OFFSET 0 ROWS;

SELECT * FROM DestinationWiseSale


CREATE VIEW FailedTransactions AS
SELECT Status, SUM(Amount) AS Amount , 
	AVG(Amount) AS Average, 
	COUNT(Amount) AS Count FROM Transactions
GROUP BY Status
ORDER BY Amount DESC OFFSET 0 ROWS

--DROP VIEW FailedTransactions
SELECT * FROM FailedTransactions

CREATE VIEW YearWiseFinanceStatement AS
SELECT YEAR(P.Date) AS Year, SUM(F.Revenue) AS YearlyRevenue, 
	SUM(F.Spendings) AS YearlySpendings, 
	SUM(F.Profit) AS YearlyProfit FROM Finance F 
INNER JOIN Purchase P ON 
F.PurchaseID = P.PurchaseID
GROUP BY YEAR(P.Date)
ORDER BY YEAR(P.Date) DESC OFFSET 0 ROWS;

SELECT * FROM YearWiseFinanceStatement;

CREATE VIEW MonthWiseFinanceStatement AS
SELECT MONTH(P.Date) AS MONTH, SUM(F.Revenue) AS MonthlyRevenue, 
		SUM(F.Spendings) AS MonthlySpendings, 
		SUM(F.Profit) AS MonthlyProfit FROM Finance F 
INNER JOIN Purchase P ON 
F.PurchaseID = P.PurchaseID
GROUP BY MONTH(P.Date)
ORDER BY MONTH(P.Date) OFFSET 0 ROWS;
-- DROP VIEW MonthWiseFinanceStatement
SELECT * FROM MonthWiseFinanceStatement;


INSERT INTO Sales(SalesID, Name) VALUES ('S1051', 'Anuradha');
SELECT * FROM SALES ORDER BY SalesID DESC
BEGIN TRANSACTION;
UPDATE Sales SET Location='Delhi' WHERE SalesID='S1051';
Commit;
SELECT * FROM SALES ORDER BY SalesID DESC
BEGIN TRANSACTION;
UPDATE Sales SET Designation='Sales Manager' WHERE SalesID='S1051';
SAVE TRANSACTION S1;
SELECT * FROM SALES ORDER BY SalesID DESC
BEGIN TRANSACTION;
DELETE FROM Sales WHERE SalesID = 'S1051';
Rollback;
SELECT * FROM SALES ORDER BY SalesID DESC

CREATE VIEW ServiceCount AS
SELECT P.PackageID, COUNT(H.HotelID) AS HotelCount 
,	COUNT(R.RestaurantID) AS RestCount
, COUNT(T.TravelsID) AS TravelsCount
FROM Package P INNER JOIN Hotels H ON
P.PackageID = H.PackageID INNER JOIN Travels T ON
P.PackageID = T.PackageID INNER JOIN Restaurants R ON
P.PackageID = R.PackageID
GROUP BY P.PackageID
ORDER BY P.PackageID OFFSET 0 ROWS;

SELECT * FROM ServiceCount;


CREATE VIEW LocationWiseServiceCount AS
SELECT P.Location, COUNT(H.HotelID) AS HotelCount 
,	COUNT(R.RestaurantID) AS RestCount
, COUNT(T.TravelsID) AS TravelsCount
FROM Package P INNER JOIN Hotels H ON
P.PackageID = H.PackageID INNER JOIN Travels T ON
P.PackageID = T.PackageID INNER JOIN Restaurants R ON
P.PackageID = R.PackageID
GROUP BY P.Location;

SELECT * FROM LocationWiseServiceCount;

CREATE VIEW CustomerAnalysis AS
SELECT Locatiom, AVG(HotelRating) AS HotelRating, 
	SUM(ReviewsCount) AS ReviewCount, AVG(Commision) AS Commision
FROM Hotels H
GROUP BY Locatiom

SELECT * FROM CustomerAnalysis


CREATE TABLE [Customer] (
  [CustomerID] varchar(10),
  [Full Name] varchar(50),
  [Gender] varchar(1),
  [Age] int,
  [Location] varchar(20),
  [ContactNumber] bigint,
  [Email] varchar(200),
  [Spendings] int,
  PRIMARY KEY ([CustomerID])
);

CREATE INDEX [Key] ON  [Customer] ([Full Name], [Gender], [Age], [Location], [ContactNumber], [Email], [Spendings]);

SELECT * FROM Customer

SELECT * FROM Hotels
SELECT * FROM Package
SELECT * FROM Travels
SELECT * FROM Restaurants


