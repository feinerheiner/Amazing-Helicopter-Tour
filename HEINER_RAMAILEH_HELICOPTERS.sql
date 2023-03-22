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
  [TourTimeDescription]		varchar(30)		NOT NULL,
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
INSERT INTO CUSTOMER
VALUES ('Joe', 'Bob', '333 W 3000 S', NULL, 'Salt Lake City', 'UT', '84111', 'USA', '801-999-9999', NULL, 0, NULL); 

INSERT INTO CUSTOMER
VALUES ('Sammy', 'Sosa', '200 North Main Street', 'Apt 10', 'Chicago', 'IL', '60007', 'USA', '801-132-3113', NULL, 0, NULL); 

INSERT INTO CUSTOMER
VALUES ('Jill', 'Thompson', '444 E 5000 S', NULL, 'Bountiful', 'UT', '84010', 'USA', '801-232-2323', NULL, 0, NULL); 

INSERT INTO CUSTOMER
VALUES ('Kieth', 'Cozart', '3000 E 2212 S', NULL, 'Layton', 'UT', '84041', 'USA', '801-634-4244', NULL, 0, NULL); 

INSERT INTO GUEST
VALUES ('Anita', 'Proul', '4462 Maybeck Place', 'Unit A', 'Provo', 'UT', '84601', 'USA', '801-957-4769',' Anita@cougarlife.com', ''); 

INSERT INTO CUSTOMER
VALUES ('Anita', 'Proul', '4462 Maybeck Place', 'Unit A', 'Provo', 'UT', '84601', 'USA', '801-957-4769',' Anita@cougarlife.com', 1, 1500); 


--Insert Statements for RESERVATION table
INSERT INTO RESERVATION
VALUES ('3/2/2023', 'R', '1st Time Customer', 3000); 

INSERT INTO RESERVATION
VALUES ('3/11/2023', 'R', 'Regular Customer. 10th tour booked', 3001); 

INSERT INTO RESERVATION
VALUES ('4/13/2023', 'A', '', 3002); 

INSERT INTO RESERVATION
VALUES ('2/23/2023', 'C', '', 3003); 

--Insert Statements for BILLINGCATEGORY
INSERT INTO BILLINGCATEGORY
VALUES ('SeatRate', 1);

INSERT INTO BILLINGCATEGORY
VALUES ('Drinks', 1);

INSERT INTO BILLINGCATEGORY
VALUES ('Food', 1);

INSERT INTO BILLINGCATEGORY
VALUES ('Souvenir', 1);

INSERT INTO BILLINGCATEGORY
VALUES ('Parking', 0);

INSERT INTO BILLINGCATEGORY
VALUES ('Photos', 1);

INSERT INTO BILLINGCATEGORY
VALUES ('County Sales Tax', 0);

--Insert Statements for BILLING
INSERT INTO BILLING
VALUES ('Seat Rate', 60.00, 3, '2/23/2023', 1, 1);

INSERT INTO BILLING
VALUES ('Pepsi 20 oz', 4.00, 5, '2/23/2023', 1, 2);

INSERT INTO BILLING
VALUES ('Cheeseburger', 6.50, 3, '2/23/2023', 1, 3);

INSERT INTO BILLING
VALUES ('Souvenir Pin', 3.00, 1, '2/23/2023', 1, 4);

INSERT INTO BILLING
VALUES ('Parking', 20.00, 1, '2/23/2023', 1, 5);

INSERT INTO BILLING
VALUES ('County Tax', 26.19, 1, '2/23/2023', 1, 7);


--Insert statement for FLIGHTCHARTER
--INSERT INTO FLIGHTCHARTER('C', '2/23/2023', 


SELECT * FROM CUSTOMER
SELECT * FROM RESERVATION
SELECT * FROM BILLINGCATEGORY
SELECT * FROM BILLING