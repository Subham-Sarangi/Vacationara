CREATE TABLE [Transactions] (
  [TransactionID] varchar(10),
  [Date] datetime,
  [Amount] int,
  [Status] varchar(10),
  PRIMARY KEY ([TransactionID])
);

CREATE INDEX [Key] ON  [Transactions] ([Date], [Amount], [Status]);

CREATE TABLE [Package] (
  [PackageID] varchar(10),
  [PackageType] varchar(10),
  [Location] varchar(10),
  [NumberOfDays] int,
  [Cost] int,
  [Destinations] varchar(100),
  PRIMARY KEY ([PackageID])
);

CREATE INDEX [Key] ON  [Package] ([PackageType], [Location], [NumberOfDays], [Cost], [Destinations]);

CREATE TABLE [Restaurants] (
  [RestaurantID] varchar(10),
  [RestaurantName] varchar(100),
  [Location] varchar(20),
  [Commision] double precision,
  [PackageID] varchar(10),
  [Total] int,
  PRIMARY KEY ([RestaurantID]),
  CONSTRAINT [FK_Restaurants.PackageID]
    FOREIGN KEY ([PackageID])
      REFERENCES [Package]([PackageID])
);

CREATE INDEX [Key] ON  [Restaurants] ([RestaurantName], [Location], [Commision], [Total]);

CREATE TABLE [Finance] (
  [PurchaseID] varchar(10),
  [Spendings] int,
  [Revenue] int,
  [Profit] int,
  [Date] datetime
);

CREATE INDEX [Key] ON  [Finance] ([Spendings], [Revenue], [Profit], [Date]);

CREATE TABLE [Sales] (
  [SalesID] varchar(10),
  [Name] varchar(50),
  [Designation] varchar(50),
  [Location] varchar(20),
  PRIMARY KEY ([SalesID])
);

CREATE INDEX [Key] ON  [Sales] ([Name], [Designation], [Location]);

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

CREATE TABLE [Purchase] (
  [PurchaseID] varchar(10),
  [Date] datetime,
  [CustomerID] varchar(10),
  [TransactionID] varchar(10),
  [PackageID] varchar(10),
  [BookingStatus] varchar(10),
  [DateOfTravel] datetime,
  [SalesID] varchar(10),
  PRIMARY KEY ([PurchaseID]),
  CONSTRAINT [FK_Purchase.PackageID]
    FOREIGN KEY ([PackageID])
      REFERENCES [Package]([PackageID]),
  CONSTRAINT [FK_Purchase.CustomerID]
    FOREIGN KEY ([CustomerID])
      REFERENCES [Customer]([CustomerID]),
  CONSTRAINT [FK_Purchase.SalesID]
    FOREIGN KEY ([SalesID])
      REFERENCES [Sales]([SalesID])
);

CREATE INDEX [Key] ON  [Purchase] ([Date], [BookingStatus], [DateOfTravel]);

CREATE TABLE [Events] (
  [EventID] varchar(10),
  [Date] datetime,
  [Location] varchar(10),
  [Events] varchar(10),
  PRIMARY KEY ([EventID])
);

CREATE INDEX [Key] ON  [Events] ([Date], [Location], [Events]);

CREATE TABLE [Travels] (
  [TravelsID] varchar(10),
  [Name] varchar(100),
  [Locatiom] varchar(20),
  [Commision] double precision,
  [ModeOfTransport] varchar(100),
  [PackageID] varchar(10),
  [Total] int,
  PRIMARY KEY ([TravelsID]),
  CONSTRAINT [FK_Travels.PackageID]
    FOREIGN KEY ([PackageID])
      REFERENCES [Package]([PackageID])
);

CREATE INDEX [Key] ON  [Travels] ([Name], [Locatiom], [Commision], [ModeOfTransport], [Total]);

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
  PRIMARY KEY ([HotelID]),
  CONSTRAINT [FK_Hotels.PackageID]
    FOREIGN KEY ([PackageID])
      REFERENCES [Package]([PackageID])
);

CREATE INDEX [Key] ON  [Hotels] ([HotelName], [Location], [Address], [Commision], [Total], [HotelRating], [RoomType], [Description], [ReviewsCount]);

