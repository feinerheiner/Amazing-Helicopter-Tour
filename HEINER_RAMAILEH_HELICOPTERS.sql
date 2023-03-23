--Creation Script for HEINER_RAMAILEH_HELICOPTERS
--Richard Heiner, Rashad Ramaileh
--3/14/2023

USE master

IF EXISTS (SELECT * FROM sysdatabases WHERE name='HEINER_RAMAILEH_HELICOPTERS')
DROP DATABASE HEINER_RAMAILEH_HELICOPTERS

GO

CREATE DATABASE HEINER_RAMAILEH_HELICOPTERS

ON PRIMARY
(
NAME = 'HEINER_RAMAILEH_HELICOPTERS',
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\HEINER_RAMAILEH_HELICOPTERS.mdf',
--FILENAME LOCAL
SIZE = 12MB,
MAXSIZE = 50MB,
FILEGROWTH = 10%
)

LOG ON
(
NAME = 'HEINER_RAMAILEH_HELICOPTERS_LOG',
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\HEINER_RAMAILEH_HELICOPTERS.ldf',
--FILENAME LOCAL
SIZE = 1200kb,
MAXSIZE = 5MB,
FILEGROWTH = 25%
)
GO

USE HEINER_RAMAILEH_HELICOPTERS

CREATE TABLE [HOTEL] (
  [HotelID]					smallint		NOT NULL,
  [HotelName]				varchar(30)		NOT NULL,
  [HotelAddress]			varchar(30)		NOT NULL,
  [HotelCity]				varchar(20)		NOT NULL,
  [HotelState]				char(2)			NULL,
  [HotelCountry]			varchar(20)		NOT NULL,
  [HotelPostalCode]			char(10)		NOT NULL,
  [HotelStarRating]			char(1)			NULL,
  [HotelPictureLink]		varchar(100)	NULL,
  [TaxLocationID]			smallint		NOT NULL,
  PRIMARY KEY ([HotelID])
);

CREATE TABLE [BILLING] (
  [CharterBillingID]		smallint		NOT NULL		IDENTITY,
  [BillingDescription]		char(30)		NOT NULL,
  [BillingAmount]			smallmoney		NOT NULL,
  [BillingItemQty]			tinyint			NOT NULL,
  [BillingItemDate]			date			NOT NULL,
  [FlightCharterID]			smallint		NOT NULL,
  [BillingCategoryID]		smallint		NOT NULL,
  PRIMARY KEY ([CharterBillingID])
);

CREATE TABLE [TOURTIME] (
  [TourTimeID]				smallint		NOT NULL		IDENTITY,
  [TourTimeStart]			smalldatetime	NOT NULL,
  [TourTimeDescription]		varchar(30)		NULL,
  PRIMARY KEY ([TourTimeID])
);

CREATE TABLE [ROUTE] (
  [RouteID]					smallint		NOT NULL		IDENTITY,
  [Distance]				smallint		NOT NULL,
  [RouteRate]				smallmoney		NOT NULL,
  [RouteName]				varchar(30)		NOT NULL,
  [RouteDescription]		varchar(200)	NOT NULL,
  [HotelID]					smallint		NOT NULL,
  PRIMARY KEY ([RouteID])
);

CREATE TABLE [TOUR] (
  [TourID]					smallint		NOT NULL		IDENTITY,
  [CapacityStatus]			char(1)			NOT NULL,
  [SeatRate]				smallmoney		NOT NULL,
  [HelicopterID]			smallint		NOT NULL,
  [RouteID]					smallint		NOT NULL,
  [TourTimeID]				smallint		NOT NULL,
  PRIMARY KEY ([TourID]),

);

CREATE TABLE [FLIGHTCHARTER] (
  [FlightCharterID]			smallint		NOT NULL		IDENTITY,
  [Status]					char(1)			NOT NULL,
  [CustomerArrivalTime]		smalldatetime	NOT NULL,
  [GuestCount]				tinyint			NOT NULL,
  [TourID]					smallint		NOT NULL,
  [DiscountID]				smallint		NOT NULL,
  [ReservationID]			smallint		NOT NULL,
  PRIMARY KEY ([FlightCharterID]),
);

CREATE TABLE [BILLINGCATEGORY] (
  [BillingCategoryID]		smallint		NOT NULL		IDENTITY,
  [BillingCatDescription]	varchar(30)		NOT NULL,
  [BillingCatTaxable]		bit				NOT NULL,
  PRIMARY KEY ([BillingCategoryID])
);

CREATE TABLE [DISCOUNT] (
  [DiscountID]				smallint		NOT NULL		IDENTITY,
  [DiscountDescription]		varchar(50)		NOT NULL,
  [DiscountExpiration]		date			NOT NULL,
  [DiscountRules]			varchar(100)	NULL,
  [DiscountPercent]			decimal(4,2)	NULL,
  [DiscountAmount]			smallmoney		NULL,
  PRIMARY KEY ([DiscountID])
);

CREATE TABLE [CUSTOMER] (
  [CustomerID]				smallint		NOT NULL		IDENTITY(3000,1),
  [CustFirst]				varchar(20)		NOT NULL,
  [CustLast]				varchar(20)		NOT NULL,
  [CustAddress1]			varchar(30)		NOT NULL,
  [CustAddress2]			varchar(30)		NULL,
  [CustCity]				varchar(30)		NOT NULL,
  [CustState]				char(2)			NULL,
  [CustPostalCode]			char(10)		NOT NULL,
  [CustCountry]				varchar(10)		NOT NULL,
  [CustPhone]				varchar(20)		NOT NULL,
  [CustEmail]				varchar(30)		NULL,
  [IsHotelGuest]			bit				NOT NULL,
  [GuestID]					smallint		NULL,
  PRIMARY KEY ([CustomerID])
);

CREATE TABLE [HELICOPTER] (
  [HelicopterID]			smallint		NOT NULL		IDENTITY,
  [HelicopterName]			varchar(20)		NOT NULL,
  [Capacity]				tinyint			NOT NULL,
  [Range]					smallint		NOT NULL,
  [HelicopterRate]			smallmoney		NOT NULL,
  PRIMARY KEY ([HelicopterID])
);

CREATE TABLE [GUEST] (
  [GuestID]					smallint		NOT NULL		IDENTITY(1500,1),
  [GuestFirst]				varchar(20)		NOT NULL,
  [GuestLast]				varchar(20)		NOT NULL,
  [GuestAddress1]			varchar(30)		NOT NULL,
  [GuestAddress2]			varchar(30)		NULL,
  [GuestCity]				varchar(30)		NOT NULL,
  [GuestState]				char(2)			NULL,
  [GuestPostalCode]			char(10)		NOT NULL,
  [GuestCountry]			varchar(10)		NOT NULL,
  [GuestPhone]				varchar(20)		NOT NULL,
  [GuestEmail]				varchar(30)		NULL,
  [GuestComments]			varchar(200)	NULL,
  PRIMARY KEY ([GuestID])
);

CREATE TABLE [RESERVATION] (
  [ReservationID]			smallint		NOT NULL		IDENTITY(6000,1),
  [ReservationDate]			date			NOT NULL,
  [ReservationStatus]		char(1)			NOT NULL,
  [ReservationComments]		varchar(200)	NULL,
  [CustomerID]				smallint		NOT NULL,
  PRIMARY KEY ([ReservationID])
);

CREATE TABLE [TAXRATE] (
  [TaxLocationID]			smallint		NOT NULL		IDENTITY,
  [TaxDescription]			varchar(30)		NOT NULL,
  [RoomTaxRate]				decimal(6,4)	NOT NULL,
  [SalesTaxRate]			decimal(6,4)	NOT NULL,
  PRIMARY KEY ([TaxLocationID])
);

--Now creating foreign keys
ALTER TABLE [HOTEL]
	ADD

	CONSTRAINT FK_TaxLocationID
	FOREIGN KEY ([TaxLocationID]) REFERENCES  [TAXRATE] ([TaxLocationID])
	ON UPDATE CASCADE
	ON DELETE CASCADE

ALTER TABLE [ROUTE]
	ADD

	CONSTRAINT FK_HotelID
	FOREIGN KEY ([HotelID]) REFERENCES  [HOTEL] ([HotelID])
	ON UPDATE CASCADE
	ON DELETE CASCADE

ALTER TABLE [TOUR]
	ADD

	CONSTRAINT FK_HelicopterID
	FOREIGN KEY ([HelicopterID]) REFERENCES  [HELICOPTER] ([HelicopterID])
	ON UPDATE CASCADE
	ON DELETE CASCADE,

	CONSTRAINT FK_RouteID
	FOREIGN KEY ([RouteID]) REFERENCES  [ROUTE] ([RouteID])
	ON UPDATE CASCADE
	ON DELETE CASCADE,

	CONSTRAINT FK_TourTimeID
	FOREIGN KEY ([TourTimeID]) REFERENCES  [TOURTIME] ([TourTimeID])
	ON UPDATE CASCADE
	ON DELETE CASCADE

ALTER TABLE [FLIGHTCHARTER]
	ADD

	CONSTRAINT FK_TourID
	FOREIGN KEY ([TourID]) REFERENCES  [TOUR] ([TourID])
	ON UPDATE CASCADE
	ON DELETE CASCADE,

	CONSTRAINT FK_DiscountID
	FOREIGN KEY ([DiscountID]) REFERENCES  [DISCOUNT] ([DiscountID])
	ON UPDATE CASCADE
	ON DELETE CASCADE,

	CONSTRAINT FK_ReservationID
	FOREIGN KEY ([ReservationID]) REFERENCES  [RESERVATION] ([ReservationID])
	ON UPDATE CASCADE
	ON DELETE CASCADE

ALTER TABLE [RESERVATION]
	ADD

	CONSTRAINT FK_CustomerID
	FOREIGN KEY ([CustomerID]) REFERENCES  [CUSTOMER] ([CustomerID])
	ON UPDATE CASCADE
	ON DELETE CASCADE

ALTER TABLE [CUSTOMER]
	ADD

	CONSTRAINT FK_GuestID
	FOREIGN KEY ([GuestID]) REFERENCES  [GUEST] ([GuestID])
	ON UPDATE CASCADE
	ON DELETE CASCADE

ALTER TABLE [BILLING]
	ADD

	CONSTRAINT FK_FlightCharterID
	FOREIGN KEY ([FlightCharterID]) REFERENCES  [FLIGHTCHARTER] ([FlightCharterID])
	ON UPDATE CASCADE
	ON DELETE CASCADE,

	CONSTRAINT FK_BillingCategoryID
	FOREIGN KEY ([BillingCategoryID]) REFERENCES  [BILLINGCATEGORY] ([BillingCategoryID])
	ON UPDATE CASCADE
	ON DELETE CASCADE
GO

ALTER TABLE [RESERVATION]
	ADD CONSTRAINT CK_ResStatusMustMatch
	CHECK (ReservationStatus IN ('R', 'A', 'C', 'X'))

ALTER TABLE [FLIGHTCHARTER]
	ADD CONSTRAINT CK_CharterStatusMustMatch
	CHECK (Status IN ('R', 'A', 'C', 'X'))

ALTER TABLE [TOUR]
	ADD CONSTRAINT CK_CapacityStatusMustMatch
	CHECK (CapacityStatus IN ('F', 'P', 'E'))
GO

--Insert Statements for CUSTOMER table
PRINT 'Inserting data into CUSTOMER Table'
INSERT INTO CUSTOMER
VALUES	('Joe', 'Bob', '333 W 3000 S', NULL, 'Salt Lake City', 'UT', '84111', 'USA', '801-999-9999', NULL, 0, NULL),
		('Sammy', 'Sosa', '200 North Main Street', 'Apt 10', 'Chicago', 'IL', '60007', 'USA', '801-132-3113', NULL, 0, NULL),
		('Jill', 'Thompson', '444 E 5000 S', NULL, 'Bountiful', 'UT', '84010', 'USA', '801-232-2323', NULL, 0, NULL),
		('Kieth', 'Cozart', '3000 E 2212 S', NULL, 'Layton', 'UT', '84041', 'USA', '801-634-4244', NULL, 0, NULL),
		('Anita', 'Proul', '4462 Maybeck Place', 'Unit A', 'Provo', 'UT', '84601', 'USA', '801-957-4769',' Anita@cougarlife.com', 1, 1500); 

--Insert Statements for RESERVATION table
PRINT 'Inserting data into RESERVATION Table'
INSERT INTO RESERVATION
VALUES	('3/2/2023', 'R', '1st Time Customer', 3000),
		('3/11/2023', 'R', 'Regular Customer. 10th tour booked', 3001),
		('4/13/2023', 'A', '', 3002),
		('2/23/2023', 'C', '', 3003); 

--Insert Statements for BILLINGCATEGORY
PRINT 'Inserting data into BILLINGCATEGORY Table'
INSERT INTO BILLINGCATEGORY
VALUES	('SeatRate', 1),
		('Drinks', 1),
		('Food', 1),
		('Souvenir', 1),
		('Parking', 0),
		('Photos', 1),
		('County Sales Tax', 0);

--Insert Statements for BILLING
PRINT 'Inserting data into BILLING Table'
INSERT INTO BILLING
VALUES	('Seat Rate', 60.00, 3, '2/23/2023', 1, 1),
		('Pepsi 20 oz', 4.00, 5, '2/23/2023', 1, 2),
		('Cheeseburger', 6.50, 3, '2/23/2023', 1, 3),
		('Souvenir Pin', 3.00, 1, '2/23/2023', 1, 4),
		('Parking', 20.00, 1, '2/23/2023', 1, 5),
		('County Tax', 26.19, 1, '2/23/2023', 1, 7)

--Insert Statements for DISCOUNT
PRINT 'Inserting data into DISCOUNT Table'
INSERT INTO DISCOUNT
VALUES	('No Discount (Default)', '2039-12-31', 'Default Discount', 0, 0),
		('Internet Discount', '2023-12-31', 'Discount for anyone who books tour online', 10, 0),
		('Hotel Guest Discount', '2023-12-31', 'Discount for anyone who is currently a guest at the hotel', 10, 0),
		('Multiple Passenger Discount', '2023-12-31', 'Discount for anyone who books more than 4 seats', 0, 50),
		('TV Commercial Discount', '2023-12-31', 'Discount found on TV, Take $20 off your tour price', 0, 20)

--Insert statement for FLIGHTCHARTER
PRINT 'Inserting data into FLIGHTCHARTER Table'
INSERT INTO FLIGHTCHARTER
VALUES	('R', 3, NULL, 1, 1, 1),
		('R', 2, NULL, 2, 2, 2),
		('A', 2, '2023/04/29 6:00:00 PM', 3, 3, 3),
		('C', 4, '2023/04/29 7:00:00 AM', 4, 4,4),
		('R', 3, NULL, 3, 5, 2)

--Insert Statements for HELICOPTER
PRINT 'Inserting data into HELICOPTER Table'
INSERT INTO HELICOPTER
	VALUES
		('Bumblebee',	6,  350, 1000),
		('Thor',		5,  300, 900),
		('The Bus',		10, 400, 1500)

--Insert Statements for ROUTE
PRINT 'Inserting data into ROUTE Table'
INSERT INTO ROUTE --Ogden is 2300
	VALUES
		(230,	5.5, 'Bear Lake',		'Flight over Logan and to bear lake',				2300), --1265
		(90,	2.5, 'Great Salt Lake', 'Flight over the Spiral Jetty and Antelope Island', 2300), --225
		(300,	5.5, 'Uinta Mountains', 'Flight over Wasatch to Uinta',						2300), --1650
		(180,	4.5, 'Provo',			'Flight over the city skyline to Provo',			2300), --810
		(50,	2.5, 'Salt Lake City',	'Flight over Salt Lake City',						2300), --125
		(130,	4.5, 'Park City',		'Flight over the mountains to Park City',			2300)  --585

--Insert Statements for TOURTIME
PRINT 'Inserting data into TOURTIME Table'
INSERT INTO TOURTIME
	VALUES
		('2023/04/28 8:30:00 AM', NULL),
		('2023/04/28 9:00:00 AM', NULL),
		('2023/04/28 9:30:00 AM', NULL),
		('2023/04/28 10:30:00 AM', NULL),
		('2023/04/28 6:30:00 PM', NULL),
		('2023/04/28 7:00:00 PM', NULL),
		('2023/04/28 7:30:00 PM', NULL),
		('2023/04/29 8:30:00 AM', NULL),
		('2023/04/29 9:00:00 AM', NULL),
		('2023/04/29 9:30:00 AM', NULL),
		('2023/04/29 10:30:00 AM', NULL),
		('2023/04/29 6:30:00 PM', NULL),
		('2023/04/29 7:00:00 PM', NULL),
		('2023/04/29 7:30:00 PM', NULL)


--Insert Statements for TOUR
PRINT 'Inserting data into TOUR Table'
INSERT INTO TOUR
	VALUES
		('F', 377.5, 1, 1, 1),
		('P', 225, 2, 2, 2),
		('E', 315, 3, 3, 7),
		('E', 204, 1, 2, 14)


SELECT * FROM CUSTOMER
SELECT * FROM RESERVATION
SELECT * FROM BILLINGCATEGORY
SELECT * FROM BILLING
SELECT * FROM HELICOPTER
SELECT * FROM ROUTE
SELECT * FROM TOURTIME
