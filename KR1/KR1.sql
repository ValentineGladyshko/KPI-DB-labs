-- Gladyshko Valentine
-- IP-51
-- Variant 4
-- Клієнти стоматологічної поліклініки

----------------------------------------

-- Task 1:
-- Create Database

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
       ('2016-12-12', 1, 2, 2),
       ('2014-08-09', 4, 4, 3),
       ('2017-04-30', 2, 1, 4),
       ('2016-02-01', 3, 5, 1)
GO

----------------------------------------

-- Task 2:
-- Write general queries

-- 1: з використанням агрегуючих функцій та конструкції HAVING.
-- Виводить всіх лікарів які лікували пацієнтів більше 1-го разу

SELECT [LastName],
	   COUNT([T].[DoctorID]) AS 'TreatmentCount'
FROM [Treatment] AS [T]
RIGHT JOIN [Doctors] AS [D]
	ON [D].[DoctorID] = [T].[DoctorID] 
GROUP BY [LastName]
HAVING COUNT([T].[DoctorID]) > 1

-- 2: з перетворенням типу даних результату запиту або формату дати
-- Вивести всі лікування зі зміною формату дати

SELECT [D].[LastName],
	   [D].[FirstName],
	   [C].[LastName],
	   [C].[FirstName],
       CONVERT(VARCHAR(10),[Date],3) AS 'Date',
	   [TP].[Name]
FROM [Treatment] AS [T]
JOIN [Doctors] AS [D]
	ON [D].[DoctorID] = [T].[DoctorID]
JOIN [Clients] AS [C]
	ON [C].[ClientID] = [T].[ClientID] 
JOIN [TreatmentType] AS [TP]
	ON [TP].[TreatmentTypeID] = [T].[TreatmentTypeID]

-- 3: з пошуком по фрагменту текстового поля. 
-- знайти всіх докторів чиї прізвища закінчуються на «ко»

SELECT * FROM [Doctors]
WHERE [LastName] LIKE '%[k][o]'

-- 4: зі вставкою будь-якого значення в поле результату запиту, що набуло
-- значення NULL в результаті запиту

SELECT [FirstName],
	   [LastName],
	   ISNULL([ComplaintTypeID], '-1') AS 'ComplaintTypeID' 
FROM [Doctors] AS [D]
LEFT JOIN [Complaints] AS [С]
	ON [D].[DoctorID] = [С].[DoctorID]

----------------------------------------

-- Task 3:
-- Write queries from topic

-- 1: До якого лікаря була найбільша кількість скарг

;WITH [WorstDoctor] ([DoctorID], [ComplaintCount])  
AS  
(  
    SELECT TOP(1) [D].[DoctorID],
				  COUNT([C].[DoctorID]) AS 'Count'
	FROM [Complaints] AS [C]
	RIGHT JOIN [Doctors] AS [D]
		ON [D].[DoctorID] = [C].[DoctorID] 
	GROUP BY [D].[DoctorID]
	ORDER BY 'Count' DESC
)

SELECT [FirstName],
	   [LastName],
	   [ComplaintCount]
FROM [Doctors] AS [D]
JOIN [WorstDoctor] AS [W]
		ON [D].[DoctorID] = [W].[DoctorID]
GO

-- 2: Визначити кількість клієнтів, що проходили лікування
-- “Вид лікування” у лікаря “Прізвище”

CREATE PROCEDURE CountClientsFromTreatmentDoctor
    @TreatmentType NVARCHAR(255),
    @DoctorLastName NVARCHAR(255)
AS 
    SELECT COUNT([T].[DoctorID]) AS 'Count of Clients'
	FROM [Treatment] AS [T]
	LEFT JOIN [Doctors] AS [D]
		ON [D].[DoctorID] = [T].[DoctorID] 
	LEFT JOIN [TreatmentType] AS [TP]
		ON [TP].[TreatmentTypeID] = [T].[TreatmentTypeID]
	WHERE [LastName] = @DoctorLastName AND
		  [Name] = @TreatmentType
GO

EXEC CountClientsFromTreatmentDoctor 'TreatmentType1', 'Poroshenko'
GO

-- 3: Надати список лікарів, що не мали скарг (у алфавітному порядку)

;WITH [BestDoctors] ([DoctorID])  
AS  
(  
    SELECT [D].[DoctorID]
	FROM [Treatment] AS [T]
	RIGHT JOIN [Doctors] AS [D]
		ON [D].[DoctorID] = [T].[DoctorID] 
	GROUP BY [D].[DoctorID]
	HAVING COUNT([T].[DoctorID]) = 0
)

SELECT [FirstName],
       [LastName],
       [Work]
FROM [Doctors] AS [D]
JOIN [BestDoctors] AS [B]
	ON [D].[DoctorID] = [B].[DoctorID]
ORDER BY [FirstName]
GO

-- 4: Чи зверталися пацієнти по лікування “Назва” на дату “Дата”

CREATE PROCEDURE ClientsFromTreatmentTypeDate
    @TreatmentType NVARCHAR(255),
    @Date DATE
AS 
	SELECT CASE COUNT([T].[DoctorID])
				WHEN 0 THEN 'False'
				ELSE 'True'
		   END AS 'Clients'
	FROM [Treatment] AS [T]
	LEFT JOIN [TreatmentType] AS [TP]
		ON [TP].[TreatmentTypeID] = [T].[TreatmentTypeID]
	WHERE [Date] = @Date AND
		  [Name] = @TreatmentType
GO

EXEC ClientsFromTreatmentTypeDate 'TreatmentType4', '2017-09-23'
GO

-- 5: Визначити вид лікування (чи декілька),
-- який найчастіше потребували хворі,
-- та надати список прізвищ клієнтів

;WITH [NeededTreatment] ([TreatmentTypeID], [Count])  
AS  
(  
    SELECT [TreatmentTypeID],
		   COUNT([T].[TreatmentTypeID]) AS 'Count'
	FROM [Treatment] AS [T]
	GROUP BY [TreatmentTypeID]
	HAVING COUNT([T].[TreatmentTypeID]) = (SELECT TOP(1) COUNT([T].[TreatmentTypeID]) AS 'Count'
										   FROM [Treatment] AS [T]
										   GROUP BY [TreatmentTypeID]
										   ORDER BY 'Count' DESC)
)

SELECT [Name],
	   [Date],
	   [FirstName],
       [LastName]
FROM [Treatment] AS [T]
JOIN [Clients] AS [C]
	ON [C].[ClientID] = [T].[ClientID]
JOIN [NeededTreatment] AS [N]
	ON [N].[TreatmentTypeID] = [T].[TreatmentTypeID]
JOIN [TreatmentType] AS [TP]
	ON [T].[TreatmentTypeID] = [TP].[TreatmentTypeID]
GO
