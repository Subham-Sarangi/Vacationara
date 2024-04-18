SELECT * FROM CUSTOMER ORDER BY CustomerID
SELECT * FROM Transactions
SELECT * FROM Package
SELECT * FROM Events
SELECT * FROM Purchase
SELECT * FROM Sales
SELECT * FROM Restaurants
SELECT * FROM Finance
SELECT * FROM Hotels
SELECT * FROM Travels

CREATE VIEW v as
Select p.PurchaseID, p.CustomerID, p.TransactionID, p.PackageID, p.Date, p.BookingStatus, p.DateOfTravel,
c.[Full Name], c.Gender, c.Age, c.Location, t.Status, pk.Destinations,s.Designation, f.Spendings, f.Revenue, f.Profit
from Purchase p 
left join CUSTOMER c ON p.CustomerID = c.CustomerID
left join Transactions t ON p.TransactionID = t.TransactionID
left join Package pk ON p.PackageID = pk.PackageID
left join Sales s ON p.PurchaseID = s.PurchaseID
left join Finance f ON p.PurchaseID = f.PurchaseID

Select * from v



drop view v


