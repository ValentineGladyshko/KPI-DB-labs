-- Gladyshko Valentine
-- IP-51
-- Variant 4
-- Клієнти стоматологічної поліклініки

----------------------------------------

-- Create Database

USE [master]
DROP DATABASE [Kpi]
GO


USE [master]
CREATE DATABASE [Kpi]
GO

USE [Kpi]
GO

CREATE TABLE [Clients] (
	[ClientID] INT IDENTITY(1,1) NOT NULL,
    [FirstName] NVARCHAR(255) NOT NULL,
    [LastName] NVARCHAR(255) NOT NULL,
    [Address] NVARCHAR(255),
    [Phone] NVARCHAR(255), 
    CONSTRAINT PK_ClientID PRIMARY KEY CLUSTERED (ClientID))

CREATE TABLE [Doctors] (
	[DoctorID] INT IDENTITY(1,1) NOT NULL,
    [FirstName] NVARCHAR(255) NOT NULL,
    [LastName] NVARCHAR(255) NOT NULL,
    [Work] DATE,
    CONSTRAINT PK_DoctorID PRIMARY KEY CLUSTERED (DoctorID))

CREATE TABLE [TreatmentType] (
    [TreatmentTypeID] INT IDENTITY(1,1) NOT NULL,
	[Name] NVARCHAR(255) NOT NULL,
	CONSTRAINT PK_TreatmentTypeID PRIMARY KEY CLUSTERED (TreatmentTypeID))

CREATE TABLE [ComplaintType] (
    [ComplaintTypeID] INT IDENTITY(1,1) NOT NULL,
	[Name] NVARCHAR(255) NOT NULL,
	CONSTRAINT PK_ComplaintTypeID PRIMARY KEY CLUSTERED (ComplaintTypeID))

CREATE TABLE [Treatment] (
    [TreatmentID] INT IDENTITY(1,1) NOT NULL,
	[Date] DATE NOT NULL,
	[TreatmentTypeID] INT NOT NULL FOREIGN KEY REFERENCES [TreatmentType]([TreatmentTypeID]),
	[DoctorID] INT NOT NULL FOREIGN KEY REFERENCES [Doctors]([DoctorID]),
    [ClientID] INT NOT NULL FOREIGN KEY REFERENCES [Clients]([ClientID]),
	CONSTRAINT PK_TreatmentID PRIMARY KEY CLUSTERED (TreatmentID))

CREATE TABLE [Complaints] (
	[ComplaintID] INT IDENTITY(1,1) NOT NULL,
	[Date] DATE NOT NULL,
	[ComplaintTypeID] INT NOT NULL FOREIGN KEY REFERENCES [ComplaintType]([ComplaintTypeID]),
	[DoctorID] INT NOT NULL FOREIGN KEY REFERENCES [Doctors]([DoctorID]),
    [ClientID] INT NOT NULL FOREIGN KEY REFERENCES [Clients]([ClientID]),
	CONSTRAINT PK_ComplaintID PRIMARY KEY CLUSTERED (ComplaintID))
GO

----------------------------------------

-- Adding data to tables

INSERT INTO [Clients] ([FirstName], [LastName], [Address], [Phone])
VALUES ('Valentine', 'Gladyshko', 'Vyhurivskyi Blvd, Kyiv, Ukraine', '099-545-14-33'),
       ('Svetlana', 'Reutskaya', 'Volodymyra Mayakovskoho Ave, Kyiv, Ukraine', '062-529-36-35'),
       ('Anna', 'Khuda', 'Borshchahivska St, Kyiv, Ukraine', '093-413-63-88'),
       ('Alexander', 'Zarichkovyi', 'Somewhere, Kyiv, Ukraine', '099-999-99-99')
GO

INSERT INTO [Doctors] ([FirstName], [LastName], [Work])
VALUES ('Peter', 'Poroshenko', '2016-09-12'),
	   ('Dima', 'Bulatov', '2014-07-12'),
	   ('Illya', 'Volkov', '2011-05-23'),
	   ('Nastya', 'Starchenko', '2015-09-15'),
	   ('Victor', 'Frankenstein', '2012-01-14'),
	   ('Charles', 'Darwin', '2016-02-12')
GO

INSERT INTO [ComplaintType] ([Name])
VALUES ('ComplaintType1'),
	   ('ComplaintType2'),
	   ('ComplaintType3'),
	   ('ComplaintType4')
GO

INSERT INTO [TreatmentType] ([Name])
VALUES ('TreatmentType1'),
	   ('TreatmentType2'),
	   ('TreatmentType3'),
	   ('TreatmentType4')
GO

INSERT INTO [Treatment] ([Date], [TreatmentTypeID], [DoctorID], [ClientID])
VALUES ('2017-09-23', 4, 1, 1),
       ('2016-12-12', 1, 1, 2),
	   ('2016-11-12', 1, 1, 3),
       ('2014-08-09', 4, 1, 3),
       ('2017-04-30', 2, 1, 4),
       ('2016-02-01', 3, 2, 3),
       ('2011-05-05', 3, 2, 4),
       ('2014-03-08', 2, 4, 1),
       ('2016-04-11', 4, 5, 2)
GO

INSERT INTO [Complaints] ([Date], [ComplaintTypeID], [DoctorID], [ClientID])
VALUES ('2017-09-23', 4, 1, 1),
       ('2017-09-23', 3, 1, 1),
	   ('2017-09-23', 2, 1, 1),
       ('2016-12-12', 1, 2, 2),
       ('2014-08-09', 4, 4, 3),
       ('2017-04-30', 2, 1, 4),
       ('2016-02-01', 3, 5, 1)
GO

----------------------------------------

-- По кожному лікарю визначити кількість скарг і в межах лікаря ранжирувати кліентів по кількості скарг

;WITH [CTE] ([DoctorID], [ClientID], [CountClient]) AS
(SELECT [DoctorID],
       [ClientID],
	   COUNT([ClientID]) AS [CountClient]
FROM [Complaints] AS [C]
GROUP BY [DoctorID],[ClientID])

SELECT [D].[FirstName] AS [DoctorFirstName],
	   [D].[LastName]  AS [DoctorLastName],  
       [C].[FirstName] AS [ClientFirstName],
	   [C].[LastName] AS [ClientLastName],
	   [CountClient],
	   SUM([CountClient]) OVER(PARTITION BY [CTE].[DoctorID]) AS [DoctorComplaintCount],
	   DENSE_RANK() OVER(PARTITION BY [CTE].[DoctorID]
						 ORDER BY [CountClient] DESC) AS [ClientRank] 
FROM [CTE]
JOIN [Doctors] AS [D]
	ON [D].[DoctorID] = [CTE].[DoctorID]
JOIN [Clients] AS [C]
	ON [CTE].[ClientID] = [C].[ClientID]