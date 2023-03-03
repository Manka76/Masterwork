USE Borderless;
GO

CREATE OR ALTER FUNCTION Aid.CalcDistance(
		@Origin_BOK GEOGRAPHY,
		@Origin_ZAHONY GEOGRAPHY,
		@Origin_BEREGSZASZ GEOGRAPHY
)
RETURNS TABLE
AS
RETURN 
	  (SELECT CONCAT(V.VolLastName,' ',V.VolMidName,' ',V.VolFirstName) AS [Aktív önkéntesek],
	   APL.MobilePhone1 AS [Elérhetősége], 
	   C.CityName AS [Lakóhelye],
	   ROUND(Geolocation.STDistance(@Origin_BOK)*0.001, 1) AS [Távolság a BOK csarnoktól km-ben],
	   ROUND(Geolocation.STDistance(@Origin_ZAHONY)*0.001, 1) AS [Távolság Záhonytól km-ben],
	   ROUND(Geolocation.STDistance(@Origin_BEREGSZASZ)*0.001, 1) AS [Távolság a Beregszászi raktártól]
	   FROM Aid.APL
    	INNER JOIN Aid.Volunters V ON APL.AddressID=V.VolAddressID
		INNER JOIN Aid.Cities C ON APL.CityID=C.CityID
		WHERE VolStatus=1);
GO

--test

SELECT * FROM Aid.CalcDistance (0xE6100000010C11AB3FC230C04740E7525C55F6193340, 0xE6100000010C8258367348B647409CC58B85210A3340, 0xE6100000010C0A4966F50E1B4840C11F7EFE7BA43640);
GO
