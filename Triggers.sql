--	Welcome message
CREATE TRIGGER trgCustomerAcquired  
ON Customer  
AFTER INSERT   
AS print 'Congratulations!! A New Customer is Acquired';
-- DROP TRIGGER trgCustomerAcquired

-- Trigger to maintain log
CREATE TABLE CustLog(
	LogID int IDENTITY(1,1) NOT NULL,
	CustomerID varchar(10) NOT NULL,
	Operation nvarchar(10) NOT NULL,
	UpdatedDate Datetime NOT NULL	
)

CREATE TRIGGER dbo.trgCustomerInsert
ON Customer
FOR INSERT	
AS
    INSERT INTO CustLog(CustomerID, Operation, UpdatedDate)
    SELECT CustomerID ,'INSERT',GETDATE() FROM INSERTED;
CREATE TRIGGER trgCustomerUpdate
ON Customer
AFTER UPDATE
AS
    INSERT INTO CustLog(CustomerID, Operation, UpdatedDate)
    SELECT CustomerID,'UPDATE', GETDATE() FROM DELETED;

CREATE TRIGGER trgCustomerDelete 
ON Customer
INSTEAD OF DELETE
AS
    INSERT INTO CustLog(CustomerID, Operation, UpdatedDate)
    SELECT CustomerID,'DELETE', GETDATE() FROM DELETED;
-- DROP TRIGGER trgCustomerDelete

---- To Test
insert into Customer(CustomerID) values ('C1600')
delete from Customer where CustomerID = 'C1600'
update Customer set Age = 25 where CustomerID='C1600'
select * from Customer where CustomerID = 'C1600'



SELECT * FROM CustLog
-- TRUNCATE TABLE CustLog

select * from Events

CREATE TABLE [Purchase] (
  PurchaseID varchar(10),
  [Date] datetime,
  CustomerID varchar(10),
  TransactionID varchar(10),
  PackageID varchar(10),
  BookingStatus varchar(10),
  DateOfTravel datetime,
  SalesID varchar(10),
  PRIMARY KEY (PurchaseID)
);
INSERT INTO Purchase(PurchaseID, [Date], CustomerID, TransactionID, PackageID, BookingStatus, 
DateOfTravel, SalesID)
VALUES ('PUR2141204', '2020-04-23', 'C1051', 'TXN4537347', 'Success', '2020-10-22', 'S1009');

CREATE TABLE [Transactions] (
  [TransactionID] varchar(10),
  [Date] datetime,
  [Amount] int,
  [Status] varchar(10),
  PRIMARY KEY ([TransactionID])
);

INSERT INTO Transactions([TransactionID], [Date], [Amount], [Status])
VALUES ('TXN4537398', '2020-04-23', 48544,'pending');

CREATE TABLE [Package] (
  [PackageID] varchar(10),
  [PackageType] varchar(10),
  [Location] varchar(10),
  [NumberOfDays] int,
  [Cost] int,
  [Destinations] varchar(100),
  PRIMARY KEY ([PackageID])
);

INSERT INTO Package([PackageID], [PackageType], [Location], [NumberOfDays], [Cost],
  [Destinations])
VALUES ('PKG7631019', 'Silver', 'Kolkata', 6 ,40000, 'Entertainment');


CREATE TABLE [Events] (
  [EventID] varchar(10),
  [Date] datetime,
  [Location] varchar(10),
  [Events] varchar(10),
  PRIMARY KEY ([EventID])
);
INSERT INTO Events(EventID, [Date], [Location], Events)
VALUES ('E146947109', '2019-05-23', 'Kolkata', 'Exhibitions');


CREATE TABLE [Sales] (
  [SalesID] varchar(10),
  [Name] varchar(50),
  [Designation] varchar(50),
  [Location] varchar(20),
  PRIMARY KEY ([SalesID])
);
INSERT INTO Sales(SalesID, Name, Designation, Location)
VALUES ('S1007', 'Adavan', 'Sales manager','Indore');

select * from Sales

CREATE TABLE [Finance] (
  [PurchaseID] varchar(10),
  [Spendings] int,
  [Revenue] int,
  [Profit] int,
  [Date] datetime
);
INSERT INTO Finance(PurchaseID, Spendings, Revenue, Profit, Date)
VALUES ('PUR2141002',38246,48546,10300, '2020-04-14 00:00:00.000');

select * from Finance

CREATE TABLE [Hotels] (
  [HotelID] varchar(10),
  [HotelName] varchar(100),
  [Location] varchar(20),
  [Address] varchar(100),
  [Commision] double precision,
  [PackageID] varchar(10),
  [Total] int,
  [HotelRating] double precision,
  [RoomType] varchar(100),
  [Description] varchar(100),
  [ReviewsCount] int,
  PRIMARY KEY ([HotelID])
);
INSERT INTO Hotels(HotelID, HotelName, Locatiom, Address, Commision, PackageID, Total, HotelRating, RoomType, Description, ReviewsCount)
VALUES ('H0001','Vivanta by Taj','Kolkata','90 Cuffe Parade', 0.26, 'PKG7631015', 7887, 8.4,'Bunk Pod for 2','Luxury hotel with spa',778);

select * from Hotels

CREATE TABLE [Travels] (
  [TravelsID] varchar(10),
  [Name] varchar(100),
  [Location] varchar(20),
  [Commision] double precision,
  [ModeOfTransport] varchar(100),
  [PackageID] varchar(10),
  [Total] int,
  PRIMARY KEY ([TravelsID])
);
INSERT INTO Travels(TravelsID, Name, Location, Commision, ModeOfTransport, PackageID, Total)
VALUES ('T001','Mathew','Nainital', 0.29, 'Flight', 'PKG7631002',4641);

select * from Sales


create view v as
select p.PurchaseID, p.Date, p.TransactionID, p.CustomerID, p.PackageID, p.BookingStatus, p.DateOfTravel, pk.PackageType, c.[Full Name], c.Gender,
c.Age, c.Location, c.Spendings
from Purchase p
left join Customer c on p.CustomerID=c.CustomerID
left join Transactions t on p.TransactionID=t.TransactionID
left join Package pk on p.PackageID=pk.PackageID
left join Sales s on p.SalesID=s.SalesID
left join Finance f on p.PurchaseID=f.PurchaseID

select * from v
drop view v


Select [Full Name], Gender, Age, Location, PackageType from v where Spendings>70000 and PackageID<>'Platinum' order by PackageType



