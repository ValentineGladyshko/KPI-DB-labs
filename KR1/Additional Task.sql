-- Захист Контрольної Роботи

-- Завдання 1: Зробити Завдання 5 без використання Common Table Expresion

USE [Kpi]
GO

SELECT [Name],
	   [Date],
	   [FirstName],
       [LastName]
FROM [Treatment] AS [T]
JOIN [Clients] AS [C]
	ON [C].[ClientID] = [T].[ClientID]
JOIN [TreatmentType] AS [TP]
	ON [T].[TreatmentTypeID] = [TP].[TreatmentTypeID]
WHERE [T].[TreatmentTypeID] IN (SELECT [TreatmentTypeID]
	FROM [Treatment] AS [T]
	GROUP BY [TreatmentTypeID]
	HAVING COUNT([T].[TreatmentTypeID]) = (SELECT TOP(1) COUNT([T].[TreatmentTypeID]) AS 'Count'
										   FROM [Treatment] AS [T]
										   GROUP BY [TreatmentTypeID]
										   ORDER BY 'Count' DESC))
GO

-- Завдання 2: Визначити лікарів які є найпопулярнішими(кількість лікувань - кількість скарг)

;WITH [TreatmentCount] ([DoctorID], [Count])  
AS  
(   
	SELECT [D].[DoctorID],
		   COUNT([T].[DoctorID])
	FROM [Treatment] AS [T]
	RIGHT JOIN [Doctors] AS [D]
		ON [D].[DoctorID] = [T].[DoctorID] 
	GROUP BY [D].[DoctorID]
),

[ComplaintCount] ([DoctorID], [Count])
AS  
(   
	SELECT [D].[DoctorID],
		   COUNT([C].[DoctorID])
	FROM [Complaints] AS [C]
	RIGHT JOIN [Doctors] AS [D]
		ON [D].[DoctorID] = [C].[DoctorID] 
	GROUP BY [D].[DoctorID]
),

[DoctorPopularity] ([Popularity])
AS
(
SELECT TOP(1) ([TC].[Count] - [CC].[Count]) AS 'Popularity'
FROM [Doctors] AS [D]
LEFT JOIN [TreatmentCount] AS [TC]
	ON [D].[DoctorID] = [TC].[DoctorID]
LEFT JOIN [ComplaintCount] AS [CC]
	ON [D].[DoctorID] = [CC].[DoctorID]
ORDER BY 'Popularity' DESC
)

SELECT [D].[FirstName],
	   [D].[LastName],
	   ([TC].[Count] - [CC].[Count]) AS 'Popularity'
FROM [Doctors] AS [D]
LEFT JOIN [TreatmentCount] AS [TC]
	ON [D].[DoctorID] = [TC].[DoctorID]
LEFT JOIN [ComplaintCount] AS [CC]
	ON [D].[DoctorID] = [CC].[DoctorID]
WHERE ([TC].[Count] - [CC].[Count]) = (SELECT [Popularity] FROM [DoctorPopularity])

-- Завдання 2 без використання CTE

SELECT [D].[FirstName],
	   [D].[LastName],
	   ([TC].[Count] - [CC].[Count]) AS 'Popularity'
FROM [Doctors] AS [D]
LEFT JOIN (SELECT [D].[DoctorID] AS [DoctorID],
				  COUNT([T].[DoctorID]) AS [Count]
		   FROM [Treatment] AS [T]
		   RIGHT JOIN [Doctors] AS [D]
			   ON [D].[DoctorID] = [T].[DoctorID] 
		   GROUP BY [D].[DoctorID]) AS [TC]
	ON [D].[DoctorID] = [TC].[DoctorID]
LEFT JOIN (SELECT [D].[DoctorID] AS [DoctorID],
				  COUNT([C].[DoctorID]) AS [Count]
		   FROM [Complaints] AS [C]
		   RIGHT JOIN [Doctors] AS [D]
			   ON [D].[DoctorID] = [C].[DoctorID] 
		   GROUP BY [D].[DoctorID]) AS [CC]
	ON [D].[DoctorID] = [CC].[DoctorID]
WHERE ([TC].[Count] - [CC].[Count]) = (SELECT TOP(1) ([TC].[Count] - [CC].[Count]) AS 'Popularity'
									   FROM [Doctors] AS [D]
									   LEFT JOIN (SELECT [D].[DoctorID] AS [DoctorID],
														 COUNT([T].[DoctorID]) AS [Count]
												  FROM [Treatment] AS [T]
												  RIGHT JOIN [Doctors] AS [D]
													  ON [D].[DoctorID] = [T].[DoctorID]
												  GROUP BY [D].[DoctorID]) AS [TC]
										   ON [D].[DoctorID] = [TC].[DoctorID]
									   LEFT JOIN (SELECT [D].[DoctorID] AS [DoctorID],
													     COUNT([C].[DoctorID]) AS [Count]
											      FROM [Complaints] AS [C]
											      RIGHT JOIN [Doctors] AS [D]
												      ON [D].[DoctorID] = [C].[DoctorID] 
											      GROUP BY [D].[DoctorID]) AS [CC]
									   ON [D].[DoctorID] = [CC].[DoctorID]
									   ORDER BY 'Popularity' DESC)