USE [Borderless]
GO

CREATE OR ALTER PROCEDURE Aid.stpChangeVolunterAddress(
	@AddressID INT,
    @MobilePhone1 VARCHAR(12)
)
AS
BEGIN TRY
SET NOCOUNT ON
	IF NOT EXISTS
		(SELECT AddressID
		FROM Aid.APL
		JOIN Aid.Volunters V ON APL.AddressID=V.VolAddressID
		WHERE VolAddressID = @AddressID)
	BEGIN
		RAISERROR ('Ilyen cím azonosítószámú önkéntes nem található az adatbázisban!', 16, 1);
	END
	IF  @MobilePhone1 = ''
	BEGIN
		RAISERROR ('A mobilszám megadása kötelező!', 16, 1);
	END
	IF LEFT(@MobilePhone1, 1)='-' OR  LEFT(@MobilePhone1, 1)='+'
	BEGIN
		RAISERROR ('A mobilszám nem kezdődhet +/- előjellel!', 16, 1);
	END
	IF LEN(@MobilePhone1) <= 10 OR LEN(@MobilePhone1) >= 13
	BEGIN
		RAISERROR ('A mobilszám túl rövid vagy túl hosszú!', 16, 1);
	END
	UPDATE Aid.APL
	SET MobilePhone1 = @MobilePhone1
	WHERE AddressID = @AddressID
END TRY
BEGIN CATCH
		PRINT 'Hiba!';
        PRINT 'Error number: ' + CAST(ERROR_NUMBER() AS nvarchar(10));
        PRINT 'Severity: ' + CAST(ERROR_SEVERITY() AS nvarchar(10));
        PRINT 'State: ' + CAST(ERROR_STATE() AS nvarchar(10));
        PRINT 'Error message: ' + ERROR_MESSAGE();
        PRINT 'Line: ' + CAST(ERROR_LINE() AS nvarchar(10));
        PRINT 'Module: ' + COALESCE(ERROR_PROCEDURE(), '');
END CATCH

--test cases 1-5
--Test1 A mobilszám nem kezdődhet +/- előjellel!
EXEC Aid.stpChangeVolunterAddress 18, '+36207775550';
--Test2 A mobilszám nem kezdődhet +/- előjellel!
EXEC Aid.stpChangeVolunterAddress 18, '-36207775550';
--Test3 A mobilszám megadása kötelező!
EXEC Aid.stpChangeVolunterAddress 18, ''; 
--Test4 A mobilszám túl rövid vagy túl hosszú!
EXEC Aid.stpChangeVolunterAddress 18, '36207770';
--Test5 Ilyen címazonosítószámú önkéntes nem található az adatbázisban!
EXEC Aid.stpChangeVolunterAddress 30, '36207775550';

--Felülíródik!
EXEC Aid.stpChangeVolunterAddress 18, '36207775557';