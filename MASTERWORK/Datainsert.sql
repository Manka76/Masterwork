USE Borderless;
GO

SET IDENTITY_INSERT Aid.Countries ON;
INSERT INTO Aid.Countries(CountryID, CountryName, EUStatus)
VALUES
    (1, N'Magyarország', '1'),
    (2, N'Ukrajna', '0'),
    (3, N'Ausztria', '1'),
    (4, N'Románia', '1'),
    (5, N'Németország', '1'),
	(6, N'Szlovákia', '1'),
	(7, N'Hollandia', '1');
SET IDENTITY_INSERT Aid.Countries OFF;


SET IDENTITY_INSERT Aid.Counties ON;
INSERT INTO Aid.Counties(CountyID, CountryID, CountyName)
VALUES
    (1, 1, N'Szabolcs-Szatmár-Bereg'),
    (2, 1, N'Pest'),
	(3, 1, N'Hajdú-Bihar'),
	(4, 1, N'Jász-Nagykun-Szolnok'),
	(5, 2, N'Kárpátalja'),
	(6, 3, N'Bécs'),
	(7, 3, N'Alsó-Ausztria'),
	(8, 6, N'Kassai kerület');
SET IDENTITY_INSERT Aid.Counties OFF;


SET IDENTITY_INSERT Aid.Cities ON;
INSERT INTO Aid.Cities(CityID, CountyID, CityName)
VALUES
    (1, 1, N'Beregsurány'),
    (2, 2, N'Budapest'),
    (3, 1, N'Záhony'),
    (4, 6, N'Bécs'),
    (5, 5, N'Beregszász'),
	(6, 1, N'Nyíregyháza'),
	(7, 2, N'Monor'),
	(8, 4, N'Szolnok');
SET IDENTITY_INSERT Aid.Cities OFF;


SET IDENTITY_INSERT Aid.APL ON;
INSERT INTO Aid.APL(AddressID, MobilePhone1, MobilePhone2, PrivatPhone, Email, CityID, Street, HouseNr, Geolocation)
VALUES
--Employees
   (1, '36205485501', NULL, NULL, 'mintajoe@gmail.com', 2, N'Kerepesi', 47, GEOGRAPHY::Point(47.500142, 19.108911, 4326)),
   (2, '36706485520', '43605554899', NULL, 'jobanrosszban@citromail.hu', 2, N'Istenhegyi', 54, GEOGRAPHY::Point(47.503109, 19.005472, 4326)),
   (3, '36204974594', NULL, NULL, 'beszedes.erzsok@gmail.com', 7, N'Ady Endre', 42, GEOGRAPHY::Point(47.347480, 19.431111, 4326)),
   (4, '36705254567', NULL, '0676554455', 'paul.dolgos@segelyszervezet.hu', 8, N'Tisza', 1, GEOGRAPHY::Point(47.172089, 20.194447, 4326)),
   (5, '36304535658', NULL, NULL, 'janos.kocsis@segelyszervezet.hu', 2, N'Baross', 77, GEOGRAPHY::Point(47.489442, 19.077476, 4326)),
--Donators
  (6, '36706547891', NULL, NULL, 'NNmester77@gmail.com', NULL, NULL, NULL, NULL),
  (7, '36304231234', NULL, NULL, 'Mokamiki1977@yahoo.com', 2, N'Baross', 77, GEOGRAPHY::Point(47.489442, 19.077476, 4326)),
  (8, '36205679896', NULL, '3680180144', 'kozonsegkapcsolatok@unilever.com', 2, N'Váci', 121, GEOGRAPHY::Point(47.592995, 19.0879341, 4326)),
  (9, '36205487965', NULL, '0614511301', 'kapcsolat@procterandgamble.hu', 2, N'Kisfaludy Sándor', 38, GEOGRAPHY::Point(47.485996, 19.072058, 4326)),
  (10, '36205679897', NULL, NULL, 'szenthubertusvt@axelero.hu', 6, N'Vadász', 5, GEOGRAPHY::Point(48.002707, 21.739892, 4326)),
  (11, '36304885889', NULL, NULL, 'joabigel.@freemail.hu', 6, N'Jázmin', 15, GEOGRAPHY::Point(48.005945, 21.743102, 4326)),
--SupplyPlace
 (12, '36205485502', NULL, '0645702104', 'beregsurany4@gmail.com', 1, N'Kastélypark', 1, GEOGRAPHY::Point(48.161213, 22.552010, 4326)),
 (13, '36205485503', NULL, '0614601100', 'boktitkarsag@mnsk.hu', 2, N'Dózsa György', 1, GEOGRAPHY::Point(47.501488, 19.101415, 4326)),
 (14, '36205485504', NULL, '0612085584', 'segelyszervezet@segelyszervezet.hu',  2, N'Kossuth Lajos utca', 64, GEOGRAPHY::Point(42.408603, 19.039574, 4326)),
 (15, '36205485505', NULL, '0645415047', 'zahony.mavforgalmi@mavinfo.hu', 3, N'Európa', 7, GEOGRAPHY::Point(47.424086, 19.039574, 4326)),
 (16, '36205485506', NULL, '0656512620', 'krizisszallo@nyilasmisikoli.hu', 8,  N'Baross Gábor', 68, GEOGRAPHY::Point(47.424086, 19.039574, 4326)),
 (17, '36205485507', NULL, '380969021179', 'raktarbazis.bsz@segelyszervezet.hu', 5, 'Rozhoskert', 93, GEOGRAPHY::Point(48.211394, 22.642517, 4326)),
--Volunters
 (18, '3630457855', NULL, NULL, 'szabojoe007@gmail.com', 2, N'Nap', 12, GEOGRAPHY::Point(47.489659, 19.071812, 4326)),
 (19, '36705742655', '36205792135', NULL, 'szabo.janos05@t-online.hu', 7, 'Káptalanszőlő', 11, GEOGRAPHY::Point(47.324117, 19.483296, 4326)),
 (20, '36303334445', NULL, '0614567890', 'hibiszkusz85@citromail.hu', 1, 'Kossuth Lajos', 25, GEOGRAPHY::Point(48.164314, 22.544843, 4326)),
 (21, '36704563219', NULL, NULL,'szucsmara02@gmail.com', 3, N'Kárpát', 15, GEOGRAPHY::Point(48.408013, 22.176284, 4326)),
 (22, '36704563217', NULL, NULL,'nagypisti2000@t-online.hu', 3, N'Kárpát', 15, GEOGRAPHY::Point(48.408013, 22.176284, 4326)),
 (23, '36202424502', NULL, NULL, 'kiss.nati.95@gmail.com', 2, N'Futó', 3, GEOGRAPHY::Point(47.488972, 19.074246, 4326)),
 (24, '36306567879', NULL, NULL, 'kiss.gabi.67@gmail.com', 2, N'Futó', 3, GEOGRAPHY::Point(47.488972, 19.074246, 4326)),
 (25, '36207868989', NULL, NULL, 'gyalogkakukk05@gmail.com', 8, N'Szivárvány', 60, GEOGRAPHY::Point(47.157415, 20.205901, 4326)),
 (26, '36708585847', NULL, NULL, 'hajdu.csalad2002@digitel.hu', 8, N'Gőzhajó', 13, GEOGRAPHY::Point(47.169373, 20.178712, 4326)),
 (27, '36206842468', NULL, NULL, 'hajdu.csalad2000@digitel.hu', 8, N'Gőzhajó', 13, GEOGRAPHY::Point(47.169373, 20.178712, 4326)),
 (28, '36305465768', NULL, NULL, 'novak.peter@wien.at', 4, N'Akademistrasse', 4, GEOGRAPHY::Point(48.203371, 16.372145, 4326));
SET IDENTITY_INSERT Aid.APL OFF;



SET IDENTITY_INSERT Aid.Departments ON;
INSERT INTO Aid.Departments(DepartmentID, DepartmentName, Description)
VALUES
    (1, N'Projekt Menedzsment', N'Leírás...'),
    (2, N'Pénzügyi és Adománykezelő Osztály', N'Leírás...'),
    (3, N'Humánpolitikai Osztály', N'Leírás...'),
    (4, N'Kommunikációs Osztály', N'Leírás...'),
	(5, N'Üzemeltetési Osztály', N'Leírás...');
SET IDENTITY_INSERT Aid.Departments OFF;


SET IDENTITY_INSERT Aid.Jobtitles ON;
INSERT INTO Aid.Jobtitles(JobTitleID, JobTitleName, Description)
VALUES
    (1, N'Projektmenedzser', N'Leírás...'),
    (2, N'HR asszisztens', N'Leírás...'),
    (3, N'Rendszergazda', N'Leírás...'),
    (4, N'Projekt asszisztens', N'Leírás...'),
    (5, N'Projekt munkacsoport-vezető', N'Leírás...'),
    (6, N'Pénzügyi asszisztens', N'Leírás...'),
	(7, N'Önkéntes toborzó', N'Leírás...'),
	(8, N'Sofőr', N'Leírás...'),
	(9, N'Adomány koordinátor', N'Leírás'),
	(10, N'Szállítmányozási koordinátor', N'Leírás...');
SET IDENTITY_INSERT Aid.Jobtitles OFF;

SET IDENTITY_INSERT Aid.Specialization ON;
INSERT INTO Aid.Specialization(SpecializationID, SpecializationName, Description)
VALUES
	(1, N'orvos', N'Leírás...'),
	(2, N'ápoló', N'Leírás...'),
    (3, N'ukrán-magyar tolmács', N'Leírás...'),
    (4, N'szakács', N'Leírás...'),
    (5, N'angol-magyar tolmács', N'Leírás...'),
    (6, N'pszcihológus', N'Leírás...'),
	(7, N'tanár', N'Leírás...'),
	(8, N'mentálhigiénés szakember', N'Leírás...'),
	(9, N'állatorvos', N'Leírás...'),
	(10, N'szociális munkás', N'Leírás...'),
	(11, N'buszsofőr', N'Leírás...'),
	(12, N'animátor', N'Leírás...'),
	(13, N'kamionsofőr', N'Leírás...'),
	(14, N'konyhai kisegítő', N'Leírás...'),
	(15, N'gyermekorvos', N'Leírás...');
SET IDENTITY_INSERT Aid.Specialization OFF;

SET IDENTITY_INSERT Aid.Employees ON;
INSERT INTO Aid.Employees(EmployeeID, EmpFirstName, EmpMidName, EmpLastName, EmpSSN, EmpTaxNumber, EmpBirthdate, EmpDateOfEntry, EmpDateOfExit, EmpWorkStatus, EmpOfficePhone, EmpDepartmentID, EmpJobTitleID, EmpAddressID)
VALUES
   (1, N'József', NULL, N'Jóakaró', '123456789', '987654321', '1965-02-02', '2015-01-02', NULL, 1, DEFAULT, 1, 1, 1),
   (2, N'Jolánka', N'Amália', N'Kedves', '234567891', '876543219', '1995-02-02', '2015-01-02', NULL, 1, '3615554557', 3, 2, 2),
   (3, N'Erzsébet', NULL, N'Beszédes', '345678912', '789123456', '1985-12-12', '2000-01-02', NULL, 1, '3615554550', 4, 7, 3),
   (4, N'Pál', NULL, N'Dolgos', '456789123', '678912345', '1975-05-25', '2002-02-02', NULL, 1, DEFAULT, 2, 5,  4 ),
   (5, N'János', N'István', N'Kocsis', '567891234', '567891234', '1980-03-08', '2004-03-02', NULL, 1, '3615554559', 5, 10, 5);
SET IDENTITY_INSERT Aid.Employees OFF;

SET IDENTITY_INSERT Aid.Volunters ON;
INSERT INTO Aid.Volunters(VolunterID, VolFirstName, VolMidName, VolLastName, VolBirthdate, VolDateOfEntry, VolDateOfExit, VolStatus, VolAddressID)
VALUES
  (1, N'János', NULL, N'Szabó', '1986-09-12', '2020-02-22', '2022-02-22', 0, 18),
  (2, N'János', N'Miklós', N'Szabó', '1970-03-13', '2015-01-01', NULL, 1, 19),
  (3, N'Éva', NULL, N'Kovács', '1985-03-08', '2017-10-11', NULL, 1, 20),
  (4, N'Júlia', N'Mária', N'Szűcs', '2002-12-24', '2022-12-25', NULL, 1, 21),
  (5, N'István', NULL, N'Nagy', '2000-05-05', '2022-03-01', NULL, 1, 22),
  (6, N'Ivett', N'Natália', N'Kiss', '1995-06-01', '2010-10-10', '2017-09-15', NULL, 23),
  (7, N'Gábor', NULL, N'Kiss', '1967-07-21', '2022-02-24', NULL, 1, 24),
  (8, N'Péter', N'Gábor', N'Horváth', '1976-04-28', '2021-04-28', NULL, 0, 25),
  (9, N'Ferenc', NULL, N'Hajdú', '1988-02-10', '2022-05-04', NULL, 1, 26),
  (10, N'Katalin', NULL, N'Németh', '1992-07-12', '2019-08-17', NULL, 0, 27),
  (11, N'Zoltán', N'Péter', N'Novák', '1977-11-11', '2018-12-10', NULL, 1, 28);
SET IDENTITY_INSERT Aid.Volunters OFF;

SET IDENTITY_INSERT Aid.Connection ON;
INSERT INTO Aid.Connection(ID, SpecID, EmpID, VolID)
VALUES
	(1, 1, 1, 5),
	(2, 2, NULL, 1),
	(3, 3, NULL, 2),
	(4, 3, NULL, 5),
	(5, 4, 4, 8),
	(6, 4, NULL, 4),
	(7, 5, 1, 8),
	(8, 5, NULL, 9),
	(9, 6, 2, NULL),
	(10, 7, 3, 4),
	(11, 8, NULL, 3),
	(12, 9, NULL, 6),
	(13, 10, 2, 3),
	(14, 10, NULL, 10),
	(15, 11, 5, 7),
	(16, 12, 2, 4),
	(17, 12, 3, NULL),
	(18, 13, 5, NULL),
	(19, 14, NULL, 2),
	(20, 15, NULL, 9);
SET IDENTITY_INSERT Aid.Connection OFF;

SET IDENTITY_INSERT Aid.PlaceType ON;
INSERT INTO Aid.PlaceType(TypeId, PlaceTypeName, Description)
VALUES
    (1, N'Segítőpont', 'Leírás...'),
	(2, N'Sportcsarnok', 'Leírás...'),
    (3, N'Orvosi szoba', 'Leírás...'),
	(4, N'Állatorvosi rendelő', 'Leírás...'),
	(5, N'Étkezőhely konyhával', 'Leírás...'),
	(6, N'Területi iroda', 'Leírás...'),
	(7, N'Átmeneti váróhely', 'Leírás...'),
	(8, N'Kollégiumi szállás', 'Leírás...'),
	(9, N'Központi iroda', 'Leírás...'),
	(10, N'Raktárhelyiség', 'Leírás...');
SET IDENTITY_INSERT Aid.PlaceType OFF;


SET IDENTITY_INSERT Aid.SupplyPlace ON;
INSERT INTO Aid.SupplyPlace(SupplyPlaceID, PlaceTypeID, SupplyPlaceName, Status, SupplyPlaceAddressID, Latitude, Longitude)
VALUES
    (1, 1, N'Beregsurányi Segítőpont', 1, 12, 48.161213, 22.552010),
    (2, 2, N'BOK Rendezvényközpont', 1, 13, 47.501488, 19.101415),
	(3, 3, N'Határtalan Segítség Központi Irodája', 1, 14, 42.408603, 19.039574),
	(4, 7, N'MÁV Záhonyi vasútállomás váróterme', 0, 15, 47.424086, 19.039574),
	(5, 8, N'Nyilas Misi Kollégium', 1, 16, 47.424086, 19.039574),
	(6, 10, N'Beregszászi Raktárbázis', 1, 17, 48.211394, 22.642517);
SET IDENTITY_INSERT Aid.SupplyPlace OFF;


SET IDENTITY_INSERT Aid.Donators ON;
INSERT INTO Aid.Donators(DonatorID, DonatorName, DonatorCompanyName, DonatorAddressID)
VALUES
    (1, N'Anoním', NULL, 6),
    (2, N'Jótevő Miklós', NULL, 7),
    (3, N'Kapcsolat Béla', N'Unilever Magyarország', 8),
	(4, NULL, N'Procter&Gamble', 9),
	(5, NULL, N'Mátészalkai Vadásztarsaság', 10),
	(6, N'Jó Abigél', NULL, 11);
SET IDENTITY_INSERT Aid.Donators OFF;


SET IDENTITY_INSERT Aid.DonationType ON;
INSERT INTO Aid.DonationType(DonationTypeID, DonationTypeName, Description)
VALUES
(1, N'Használati tárgy', N'Leírás...'),
(2, N'Készétel', N'Leírás...'),
(3, N'Ruházat', N'Leírás...'),
(4, N'Tartós élelmiszer', N'Leírás...'),
(5, N'Pénzbeli felajánlás', N'Leírás...'),
(6, N'Higiéniai termékek', N'Leírás...'),
(7, N'Bébi ételek', N'Leírás...'),
(8, N'Bútor', N'Leírás...'),
(9, N'Lakóingatlan', N'Leírás...'),
(10, N'Zöldség, gyümölcs', N'Leírás...');
SET IDENTITY_INSERT Aid.DonationType OFF;


SET IDENTITY_INSERT Aid.Donations ON;
INSERT INTO Aid.Donations(DonationID, DonationGUID, DonatorID, DonationTypeID, DonationDate, DonationStatus, DonationValue, Description, DonationAddressID)
VALUES
(1, NEWID(), 1, 5, '2022-06-12', 1, 5000, N'Leírás...', NULL),
(2, NEWID(), 2, 3, '2022-05-31', 0, 0, N'Leírás...', 12),
(3, NEWID(), 3, 7, '2022-06-14', 1, 1000000, N'Leírás...', 8),
(4, NEWID(), 4, 6, '2022-06-10', 1, 2000000, N'Leírás...', 9),
(5, NEWID(), 5, 2, '2022-06-05', 1, 0, N'Leírás...', 10),
(6, NEWID(), 6, 10,'2022-06-18',  0, 100000, N'Leírás...', 11);
SET IDENTITY_INSERT Aid.Donations OFF;