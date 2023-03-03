USE [Borderless]
GO

CREATE OR ALTER PROCEDURE Aid.stpDeleteVolunter(
	@VolunterID INT NULL
)
AS
BEGIN TRY
SET NOCOUNT ON;

   DECLARE @VolDateOfExit DATE;
    SELECT @VolDateOfExit=VolDateOfExit FROM Aid.Volunters
	 WHERE @VolunterID = VolunterID;
	IF NOT EXISTS
		(SELECT VolunterID FROM Aid.Volunters
		WHERE @VolunterID = VolunterID)
		BEGIN
		RAISERROR ('Nincs ilyen azonosítószámú önkéntes!', 16, 1);
		END
	IF @VolDateOfExit IS NULL
	   BEGIN
       RAISERROR (N'Aktív önkéntés, nem törölhető!', 16, 1);
       END
    IF YEAR(GETDATE()) - YEAR(@VolDateOfExit)
    - IIF(FORMAT(GETDATE(), 'MM-dd') < FORMAT(@VolDateOfExit, 'MM-dd'), 1, 0) < 1
            BEGIN
                RAISERROR (N'A kilépés dátumától még nem telt el egy év!', 16, 1);
            END
			DELETE FROM Aid.Volunters WHERE VolunterID =@VolunterID;
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
GO

--Test1-4
--nincs ilyen azonosítószámú önkéntes
EXEC Aid.stpDeleteVolunter 20;
--aktív önkéntes
EXEC Aid.stpDeleteVolunter 2;
--kevesebb, mint egy éve lépett ki
EXEC Aid.stpDeleteVolunter 1;
--TÖRÖL! Itt éS a Connection táblán is!
EXEC Aid.stpDeleteVolunter 6;

