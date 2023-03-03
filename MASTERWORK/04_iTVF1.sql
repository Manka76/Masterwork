USE Borderless;
GO

CREATE OR ALTER FUNCTION Aid.DepStat(@departm varchar(50))
RETURNS TABLE
AS
RETURN 
	(SELECT dep.DepartmentName AS 'Osztály neve',
	COUNT(*) AS 'Dolgozók száma',
	CEILING(AVG(0.0+YEAR(GETDATE())-YEAR(emp.EmpBirthDate)))  AS 'Átlagéletkor'
	FROM Aid.Employees emp 
	INNER JOIN Aid.Departments dep ON emp.EmpDepartmentID = dep.DepartmentID
	WHERE dep.DepartmentName = @departm
	GROUP BY dep.DepartmentName);
GO

-- teszt

SELECT * FROM Aid.DepStat ('Projekt Menedzsment');
SELECT * FROM Aid.DepStat ('Pénzügyi és Adománykezelő Osztály');
SELECT * FROM Aid.DepStat ('Humánpolitikai Osztály');
SELECT * FROM Aid.DepStat ('Üzemeltetési Osztály');
SELECT * FROM Aid.DepStat ('Kommunikációs Osztály');
GO