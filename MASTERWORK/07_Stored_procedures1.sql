USE Borderless;
GO

CREATE OR ALTER PROCEDURE Aid.sptAddNewVolunter(
     @VolFirstName NVARCHAR(50)
    ,@VolMidName NVARCHAR(25)
    ,@VolLastName NVARCHAR(25)
    ,@VolBirthdate DATE
    ,@VolDateOfEntry DATE
    ,@VolDateOfExit DATE
    ,@VolStatus BIT
    ,@VolAddressID INT
)
AS
    SET NOCOUNT ON;
    BEGIN TRY

    DECLARE @Datemin DATE;
    SELECT  @Datemin=VolDateOfEntry FROM Aid.Volunters;
	    IF YEAR(GETDATE()) - YEAR(@VolDateOfEntry)
            - IIF(FORMAT(GETDATE(), 'MM-dd') < FORMAT(@VolDateOfEntry, 'MM-dd'), 1, 0) < 1
            BEGIN
                RAISERROR (N'A belépés dátuma nem lehet a mai napnál későbbi!', 16, 1);
            END
        IF  year(GETDATE())-year(@Volbirthdate) < 18
			BEGIN
               RAISERROR (N'Még nem töltötte be a 18. életévét, jelentkezzen később', 16, 1);
			END
 
        INSERT INTO Aid.Volunters(VolFirstName, VolMidName, VolLastName, VolBirthdate,
    VolDateOfEntry, VolDateOfExit, VolStatus, VolAddressID)
     VALUES (@VolFirstName,@VolMidName,@VolLastName,@VolBirthdate,
 @VolDateOfEntry, @VolDateOfExit, @VolStatus,  @VolAddressID);
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
GO

--test1
--Későbbi belépési dátum!
EXEC Aid.sptAddNewVolunter 'Nyilas', NULL, 'Misi', '2003-07-17','2022-08-21', NULL, 1, 28; 

--test2
--Fiatalabb, mint 18 éves jelentkező
EXEC Aid.sptAddNewVolunter 'Nyilas', NULL, 'Misi', '2005-07-17','2020-08-28', NULL, 1, 28;

--test3
--Megfelel a feltételeknek, rögzítésre kerül
EXEC Aid.sptAddNewVolunter 'Nyilas', NULL, 'Misi', '2004-06-17','2021-06-29', NULL, 1, 28; 

