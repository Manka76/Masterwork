USE [Borderless];
GO

CREATE TABLE Aid.ArchivedDonation(
ArcDID INT NOT NULL PRIMARY KEY,
ArcDTypeId INT,
ArcDDate DATE,
ArcDValue MONEY,
ArcDDescription NVARCHAR
);

CREATE NONCLUSTERED INDEX IX_ArcDDate ON Aid.ArchivedDonation(ArcDDate);
CREATE NONCLUSTERED INDEX IX_ArcDValue ON Aid.ArchivedDonation(ArcDValue);
GO

CREATE OR ALTER TRIGGER Aid.trg_ArchivedDonation
ON [Aid].[Donations]
AFTER DELETE
AS
SET NOCOUNT ON
BEGIN TRY
    DECLARE @DonationStatus INT; --If 0, the donation has reached its destination
    INSERT INTO Aid.ArchivedDonation
    (ArcDID, ArcDTypeId, ArcDDate, ArcDValue)
    SELECT DonationID, DonationTypeID, DonationDate, DonationValue FROM deleted;
    SET @DonationStatus=@@ROWCOUNT;
    IF @DonationStatus=0
    BEGIN
        RAISERROR ('Az adomány célba ért! A tétel archiválásra került.', 16, 1);
    END;
    SELECT *
    FROM Aid.ArchivedDonation;
END TRY
BEGIN CATCH
    PRINT 'Error message: ' + ERROR_MESSAGE();
END CATCH
GO


--teszt

UPDATE Aid.Donations
SET DonationStatus=0
WHERE DonationID=4;

DELETE
FROM Aid.Donations
WHERE DonationID=4;

SELECT * FROM sys.triggers; 