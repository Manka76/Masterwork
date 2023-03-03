/**
      "Borderless help"
   DBASpecialist masterwork
**/

--Create database
USE [master]
GO
CREATE DATABASE [Borderless]
GO

--Create schema
USE [Borderless]
GO
CREATE SCHEMA [Aid]
GO

--Create table

--Countries

CREATE TABLE [Aid].[Countries] 
(
	 CountryID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	,CountryName NVARCHAR(50) NOT NULL
	,EUStatus BIT
	CONSTRAINT UC_CountryName UNIQUE (CountryName)
);

CREATE INDEX IX_EUStatus
ON Aid.Countries(EUStatus);

--Counties

CREATE TABLE [Aid].[Counties] 
(
	 CountyID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	,CountryID INT NOT NULL
	 CONSTRAINT FK_CountryID FOREIGN KEY (CountryID) REFERENCES Aid.Countries(CountryID)
	,CountyName NVARCHAR(50) NOT NULL
	CONSTRAINT UC_CountyName UNIQUE (CountyName)
);

CREATE INDEX IX_CountyName
ON Aid.Counties(CountyName);

--Cities

CREATE TABLE [Aid].[Cities] 
(
	 CityID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	,CountyID INT NOT NULL
	 CONSTRAINT FK_CountyID FOREIGN KEY (CountyID) REFERENCES Aid.Counties(CountyID)
	,CityName NVARCHAR(50) NOT NULL
   	CONSTRAINT UC_CityName UNIQUE (CityName)
);

CREATE INDEX IX_CityName
ON Aid.Cities(CityName);

--APL (Address&Phone&Location)

CREATE TABLE [Aid].[APL] 
(
	 AddressID INT IDENTITY(1,1) PRIMARY KEY
	,MobilePhone1 VARCHAR (12) NOT NULL
	,MobilePhone2 VARCHAR (12)
	,PrivatPhone VARCHAR (12)
	,Email VARCHAR(50) NOT NULL
	,CityID INT NULL
	 CONSTRAINT FK_CityID FOREIGN KEY (CityID) REFERENCES Aid.Cities(CityID)
	,Street NVARCHAR(50) NULL
	,HouseNr SMALLINT NULL 
	,Geolocation GEOGRAPHY NULL
	,CONSTRAINT UQ_MobilePhone1 UNIQUE(MobilePhone1)
	,CONSTRAINT UQ_Email UNIQUE(Email)
);


CREATE INDEX IX_CityID
ON Aid.APL(CityID);


--Departments

CREATE TABLE [Aid].[Departments]
(
     DepartmentID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
    ,DepartmentName NVARCHAR(50) NOT NULL
	,Description NVARCHAR (500) NULL
	,CONSTRAINT UQ_DepartmentName UNIQUE(DepartmentName)
);

CREATE INDEX IX_DepartmentName
ON Aid.Departments(DepartmentName);

--Jobtitles

CREATE TABLE [Aid].[Jobtitles]
(
     JobTitleID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
    ,JobTitleName NVARCHAR(50) NOT NULL
	,Description NVARCHAR (500) NULL
	,CONSTRAINT UQ_JobTitleName UNIQUE(JobTitleName)
);

CREATE INDEX IX_JobTitleName
ON Aid.Jobtitles(JobTitleName);

--Specialization

CREATE TABLE [Aid].[Specialization]
(
	 SpecializationID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	,SpecializationName NVARCHAR (100) NOT NULL UNIQUE
	,Description NVARCHAR(500) 
);

CREATE INDEX IX_SpecializationName
ON Aid.Specialization(SpecializationName);


--Employees

CREATE TABLE [Aid].[Employees]
(
     EmployeeID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	,EmpFirstName NVARCHAR(50) NOT NULL
	,EmpMidName NVARCHAR (25)
	,EmpLastName NVARCHAR(25) NOT NULL
    ,EmpSSN VARCHAR(9) NOT NULL
	,EmpTaxNumber VARCHAR(9) NOT NULL
    ,EmpBirthdate DATE NOT NULL
	,EmpDateOfEntry DATE NOT NULL
	,EmpDateOfExit DATE NULL
	,EmpWorkStatus BIT
	,EmpOfficePhone VARCHAR (20) NOT NULL DEFAULT '3615554555'
	,EmpDepartmentID INT NOT NULL
	 CONSTRAINT FK_EmpDepartmentID FOREIGN KEY (EmpDepartmentID) REFERENCES Aid.Departments(DepartmentID)
	,EmpJobTitleID INT NOT NULL
	 CONSTRAINT FK_EmpJobTitleID FOREIGN KEY (EmpJobTitleID) REFERENCES Aid.Jobtitles(JobTitleID)
	,EmpAddressID INT NOT NULL
	 CONSTRAINT FK_EmpAddressId FOREIGN KEY (EmpAddressID) REFERENCES Aid.APL(AddressID)
	,CONSTRAINT UQ_SSN UNIQUE(EmpSSN)
	,CONSTRAINT UQ_TaxNumber UNIQUE(EmpTaxNumber)	
);

CREATE INDEX IX_EmpWorkStatus
ON Aid.Employees(EmpWorkStatus);

CREATE INDEX IX_EmpLastName
ON Aid.Employees(EmpLastName);

--Volunters

CREATE TABLE [Aid].[Volunters]
(
     VolunterID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	,VolFirstName NVARCHAR(50) NOT NULL
	,VolMidName NVARCHAR(25)
	,VolLastName NVARCHAR(25) NOT NULL
    ,VolBirthdate DATE NOT NULL
	,VolDateOfEntry DATE NOT NULL 
	,VolDateOfExit DATE NULL
	,VolStatus BIT
	,VolAddressID INT NOT NULL
	 CONSTRAINT FK_VolAddressID FOREIGN KEY (VolAddressID) REFERENCES Aid.APL(AddressID)
	 ON DELETE CASCADE
);

CREATE INDEX IX_VolStatus
ON Aid.Volunters(VolStatus)
WHERE VolStatus=1;

CREATE INDEX IX_LastName
ON Aid.Volunters(VolLastName)


--Connection

CREATE TABLE [Aid].[Connection]
(
	 ID INT IDENTITY (1,1) NOT NULL PRIMARY KEY
	,SpecID INT NULL
	 CONSTRAINT FK_SpecID FOREIGN KEY (SpecID) REFERENCES Aid.Specialization(SpecializationID)
	,EmpID INT  NULL
	 CONSTRAINT FK_EmpID FOREIGN KEY (EmpID) REFERENCES Aid.Employees(EmployeeID)
	,VolID INT  NULL
	 CONSTRAINT FK_VolID FOREIGN KEY (VolID) REFERENCES Aid.Volunters(VolunterID)
	 ON DELETE CASCADE
);


CREATE INDEX IX_SpecID
ON Aid.Connection(SpecID);

CREATE INDEX IX_EmpID
ON Aid.Connection(EmpID)

--Donators

CREATE TABLE [Aid].[Donators] 
(
	 DonatorID INT IDENTITY (1,1) NOT NULL PRIMARY KEY
	,DonatorName NVARCHAR (75)
	,DonatorCompanyName NVARCHAR (100)
	,DonatorAddressID INT NOT NULL
	 CONSTRAINT FK_DonatorAddresstID FOREIGN KEY (DonatorAddressID) REFERENCES Aid.APL(AddressID)
	,CONSTRAINT ChkDonatorName CHECK((DonatorName is not null) OR (DonatorCompanyName is not null))
);

CREATE INDEX IX_DonatorCompanyName
ON Aid.Donators(DonatorCompanyName);

CREATE INDEX IX_DonatorName
ON Aid.Donators(DonatorName);

--DonationType

CREATE TABLE [Aid].[DonationType]
(
	 DonationTypeID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	,DonationTypeName NVARCHAR (50) NOT NULL
	,Description NVARCHAR (500) NOT NULL
);

CREATE INDEX IX_DonationTypeName
ON Aid.DonationType(DonationTypeName)

CREATE INDEX IX_DonationTypeID
ON Aid.DonationType(DonationTypeID)


--Donations

CREATE TABLE [Aid].[Donations]
(
	 DonationID INT IDENTITY(1,1) PRIMARY KEY
	,DonationGUID UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID()
	,DonatorID INT NOT NULL
	 CONSTRAINT FK_DonatorID FOREIGN KEY (DonatorID) REFERENCES Aid.Donators(DonatorID)
	,DonationTypeID INT NOT NULL
	 CONSTRAINT FK_DonationTypeID FOREIGN KEY (DonationTypeID) REFERENCES Aid.DonationType(DonationTypeID)
	,DonationDate DATE NOT NULL CONSTRAINT CHK_DonationDate CHECK(DonationDate <= GETDATE())
	,DonationStatus BIT NOT NULL
	,DonationValue MONEY NOT NULL
 	 CONSTRAINT ChkDonationValue CHECK(DonationValue >= 0)
	,Description NVARCHAR(500) NULL
	,DonationAddressID INT
	 CONSTRAINT FK_DonationAddressID FOREIGN KEY (DonationAddressID) REFERENCES Aid.APL(AddressID) 
);

CREATE INDEX IX_DonationValue
ON Aid.Donations(DonationValue)

CREATE INDEX IX_DonationStatus
ON Aid.Donations(DonationStatus)


--PlaceType


CREATE TABLE [Aid].[PlaceType] 
(
	 TypeID INT IDENTITY(1,1) PRIMARY KEY
	,PlaceTypeName NVARCHAR(50) NOT NULL UNIQUE
	,Description NVARCHAR(500)
);

CREATE INDEX IX_PlaceTypeName
ON Aid.PlaceType(PlaceTypeName);

--SupplyPlace


CREATE TABLE [Aid].[SupplyPlace]
(
	 SupplyPlaceID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	 ,PlaceTypeID INT NOT NULL
	  CONSTRAINT FK_PlaceTypeID FOREIGN KEY (PlaceTypeID) REFERENCES Aid.PlaceType(TypeID)
	 ,SupplyPlaceName NVARCHAR(100) NOT NULL UNIQUE
	 ,Status BIT
	 ,SupplyPlaceAddressID INT NOT NULL
	  CONSTRAINT FK_SupplyPlaceAddressID FOREIGN KEY (SupplyPlaceAddressID) REFERENCES Aid.APL(AddressID)
	 ,Latitude VARCHAR(20) NOT NULL
	 ,Longitude VARCHAR(20) NOT NULL
);

CREATE INDEX IX_Status
ON Aid.SupplyPlace(Status);