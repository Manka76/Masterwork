/**Az alábbi nézetek olyan lekérdezéseket tartalmaznak, 
amelyek a segélyszervezet napi munkájának megszervezéséhez szükséges.**/

-- 1.view Működő ellátási helyek Magyarországon és külföldön, koordinátákkal
USE Borderless;
GO

CREATE OR ALTER VIEW Aid.OrganisationOfSupply
    WITH SCHEMABINDING
AS
SELECT SP.SupplyPlaceID AS [Helyazonosító], 
	   SP.SupplyPlaceName AS [Ellátási hely],
	   PT.PlaceTypeName AS [Típusa],
	   Countries.CountryName AS [Ország],
	   C.CityName AS [Város],
	CONCAT(APL.Street, ' ', APL.HouseNr,'.') AS [Közterület],
	   SP.Latitude + '  ' + SP.Longitude AS [Koordináták]
FROM Aid.SupplyPlace SP
INNER JOIN Aid.PlaceType PT ON SP.PlaceTypeID=PT.TypeID
INNER JOIN Aid.APL ON SP.SupplyPlaceAddressID=APL.AddressID
INNER JOIN Aid.Cities C ON APL.CityID=C.CityID
INNER JOIN Aid.Counties ON C.CountyID=Counties.CountyID
INNER JOIN Aid.Countries ON Counties.CountryID=Countries.CountryID
WHERE SP.Status=1;
GO


--2. view  Felajánlott adományok listája és azok fellelhetősége
CREATE OR ALTER VIEW Aid.OrganistionOfDonation
    WITH SCHEMABINDING
AS
SELECT D.DonationID AS [Azonosítószám],
	   DT.DonationTypeName AS [Adomány megnevezése],
	   D.Description [Leírás az adományról],
	   D.DonationDate AS [Felajánlás ideje],
      CONCAT(Countries.CountryName,', ',C.CityName, '  ',Street, ' ',HouseNr,'.') AS [Adomány helye],
      CONCAT(DO.DonatorName,' ',DO.DonatorCompanyName) AS [Felajánló személy v. szervezet],
	  CONCAT(APL.MobilePhone1,'  ',APL.Email) AS [Kontakt személy elérhtőségei]
FROM Aid.Donations D
INNER JOIN Aid.DonationType DT ON D.DonationTypeID=DT.DonationTypeID
INNER JOIN Aid.Donators DO ON D.DonatorID=DO.DonatorID
INNER JOIN Aid.APL ON APL.AddressID=D.DonationAddressID
INNER JOIN Aid.Cities C ON APL.CityID=C.CityID
INNER JOIN Aid.Counties ON C.CountyID=Counties.CountyID
INNER JOIN Aid.Countries ON Counties.CountryID=Countries.CountryID
WHERE D.DonationStatus=1;
GO

--3. view Aktív önkéntesek és dolgozók + elérhetőségeik
CREATE OR ALTER VIEW Aid.ActiveVolEmp
    WITH SCHEMABINDING
AS
SELECT 
CONCAT(V.VolLastName,' ',V.VolFirstName) AS [Önkéntes / Dolgozó neve],
CONCAT(APL.MobilePhone1, '  ', Email) AS [Elérhetőségei],
CONCAT(Cities.CityName, ', ', APL.Street, ' ' ,APL.HouseNr,'.') AS [Címe]
FROM Aid.Volunters V
INNER JOIN Aid.Connection C ON V.VolunterID=C.VolID
INNER JOIN Aid.APL ON V.VolAddressID=APL.AddressID
INNER JOIN Aid.Cities ON APL.CityID=Cities.CityID
WHERE V.VolStatus=1

UNION

SELECT 
CONCAT(E.EmpLastName,' ',E.EmpFirstName) AS [Dolgozó neve],
CONCAT(APL.MobilePhone1, '  ', Email) AS [Elérhetőségei],
CONCAT(Cities.CityName, ', ', APL.Street, ' ' ,APL.HouseNr,'.') AS [Címe]
FROM Aid.Employees E
INNER JOIN Aid.Connection C ON E.EmployeeID=C.EmpID
INNER JOIN Aid.APL ON E.EmpAddressID=APL.AddressID
INNER JOIN Aid.Cities ON APL.CityID=Cities.CityID
WHERE E.EmpWorkStatus=1
GO


--4. view Egyszerű pivoting, önkéntesek száma szakterületenként
CREATE OR ALTER VIEW Aid.NumberPerSpecialization
WITH SCHEMABINDING
AS 
SELECT S.SpecializationName, COUNT(VolID) AS 'Önkéntesek száma'   
FROM Aid.Specialization S
INNER JOIN Aid.Connection C ON C.SpecID=S.SpecializationID
INNER JOIN Aid.Volunters V ON C.VolID=V.VolunterID
GROUP BY SpecializationName;
GO

