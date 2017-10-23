-- Завдання 2: Визначити лікарів які є найпопулярнішими(кількість лікувань - кількість скарг)

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