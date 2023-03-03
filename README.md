# SDG07_masterwork


## "HATÁRTALAN SEGÍTSÉG" (Borderless Aid)

Az adatbázis célja egy menekültek ellátásával foglalkozó segélyszervezt mindennapos munkájának a támogatása. Ennek a sokrétű munkának a megszervezésében kulcsfontosságú a koordináció. Nevezetesen az, hogy a megfelelő személyek, a megfelelő helyen, kellő tárgyi felszereltséggel tudják a munkájukat végezni.

Elsősorban ennek a karítatív munkának a megszervezéséhez szükséges adatok kerültek letárolásra az adatbázisban:
- a segélyszervezet dolgozóinak legfontosabb személyes adatai, elérhetősége, szakterületük,
- a segélyszervezet munkáját segítő önkéntesek adatai, elérhetőségei, szakterületük,
- az adományozók legfontosabb adatai, elérhetőségei,
- a felajánlott adományok típusa, leírása, fellelhetősége,
- az ellátási helyek, azok típusai, pontos helyük, elérhetőségük.

A masterwork nevében szereplő 'határtalan' szó arra utal, hogy a segélyszervezet munkatársai, önkéntesei, ellátási pontjai és adományozói között is szép számban akadnak határontúliak.

# Az adatbázis rendszerkörnyezete

- Microsoft SQL Server 2019 futtatására alkalmas operációs rendszer. Javasolt: Windows 10 Pro 10.0 <X64> (Build 19044:) 
- Microsoft SQL Server 2019 Javasolt verzió: Microsoft SQL Server 2019 (RTM-GDR) (KB5014356) - 15.0.2095.3 (X64)) 
- SQL Server Management Studio 15.0.18410.0

# Telepítése

Két módon lehetséges.
1. A csatolt Borderless_DbBackup.bak fájlból. (Ez az adatbázis már tartalmazza a mintaadatokat.)
2. A csatolt sql fájlok sorrendben történő futtatásával. Ebben az esetben a felhasználó dönti el, hogy telepíti-e a mintaadatokat tartalmazó Datainsert.sql fájlt.
 
# Adatbázis beállítások
  
  - Collation: SQL_Latin1_General_CP1_CI_AS
  - Recovery model: Full
  - Kompatibilitás szint: SQL 2019 (150)

# Adatmodell és tervezés
  
Az adatbázis a dolgozók, önkéntesek, adományozók, adományok és ellátási helyek tulajdonságait leíró entitásokat tartalmazza.

Az adatbázist alkotó táblákat és a köztük lévő kapcsolatokat a dokumentum végén lévő diagram mutatja be. A táblák harmadik normálformában (3NF) kerültek megtervezésre.

A  01_Create_DB_Schema_tables.sql szkript futása során jön létre a Borderless adatbázis, az Aid séma és a 15 tábla. Mindegyik tábla legalább három indexet tartalmaz.

# Az elkészült adatbázis objektumok

## Táblák
  
## 1. Aid.Employees adattábla tartalma:

 A segélyszervezet dolgozóinak adatait tartalmazza.	
| Attribútum neve | Attribútum típusa | Attribútum szerepe | Kapcsolat típusa | Attribútum leírása |
| :--- | :---: | :---: | :---: | :--- |
| EmployeeID | INT | Elsődleges kulcs, Clustered index | | A dolgozó egyedi azonosítója |
| EmpFirstName  | VARCHAR(50) |  | | A dolgozó I. keresztneve |
| EmpMidName  | VARCHAR(25) | | | A dolgozó II. keresztneve |
| EmpLastName  | VARCHAR(25) | Non-Unique,  Non-Clustered index| | A dolgozó családneve |
| EmpSSN | VARCHAR(9) | Egyedi kulcs,   Non-Clustered index | | A dolgozó társadalomazonosító száma|
| EmpTaxNumber |Varchar(9)| Egyedi kulcs,  Non-Clustered index| | A dolgozó adószáma |
| EmpBirthDate | DATE | | | A dolgozó születési dátum |
| EmpDateOfEntry| DATE | | | A munkakezdés dátuma |
| EmpUserOfExit  | DATE |  | | A munka befejezésének dátuma |
| EmpWorkStatus | BIT | Non-Unique,  Non-Clustered index| |A dolgozó státusza (aktív vagy passzív) |
| EmpOfficePhone | VARCHAR(20) | Check constraint* | |A dolgozó hivatali telefonszáma |
| EmpDepartmentID| INT |Idegen kulcs|  1:N | A dolgozó osztályájának azonosítója |
| EmpJobTitleID| INT |  Idegen kulcs | 1:N | A munkakör azonosítója |
| EmpAddressID | INT | Idegen kulcs  | 1:N | A dolgozó elérhetőségének azonosítója  |

*Constraint: EmpOfficePhone VARCHAR (20) NOT NULL DEFAULT '3615554555' (DF__Employees__EmpOf__3E52440B)
	
## 2. Aid.Departments adattábla tartalma:

 A segélyszervezet belső részlegeit, osztályainak a megnevezését tartalmazza.
| Attribútum neve | Attribútum típusa | Attribútum szerepe | Kapcsolat típusa | Attribútum leírása |
| :--- | :---: | :---: | :---: | :--- |
| DepartmentID | INT | Elsődleges kulcs, Clustered index  | | Az osztály egyedi azonosítója |
| DepartmentName | NVARCHAR(50) | Egyedi kulcs,  Non-Unique Non-Clustered index  | | Az osztály megnevezése 
| Description | NVARCHAR(500) | | | Az osztály feladatkörének leírása|


## 3. Aid.JobTitle adattábla tartalma:

 A segélyszervezetnél dolgozók munkakörei.	
| Attribútum neve | Attribútum típusa | Attribútum szerepe | Kapcsolat típusa | Attribútum leírása |
| :--- | :---: | :---: | :---: | :--- |
| JobTitleID | INT | Elsődleges kulcs, Clustered index | | A munkakör egyedi azonosítója |
| JobTitleName  | NVARCHAR(50) | Egyedi kulcs,  Non-Unique Non-Clustered index | | A munkakör megnevezése |
| Description  | NVARCHAR(500) | | | A munkakör leírása |


## 4. Aid.Volunters adattábla tartalma:

A segélyszervezetnél tevénykedő önkéntesek adatai.
| Attribútum neve | Attribútum típusa | Attribútum szerepe | Kapcsolat típusa | Attribútum leírása |
| :--- | :---: | :---: | :---: | :--- |
| VolunterID | INT | Elsődleges kulcs, Clustered | | Az önkéntes egyedi azonosítója |
| VolFirstName  | VARCHAR(50) |  | | Az önkéntes I. keresztneve|
| VolMidName  | VARCHAR(25) | | | Az önkéntes II. keresztneve|
| VolLastName  | VARCHAR(25) |Non-Unique, Non-Clustered index  | | Az önkéntes családneve|
| VolBirthDate  | DATE | | | Az önkéntes születési dátuma|
| VolDateOfEntry | DATE | | | Az önkéntes belépési dátuma|
| VolDateOfExit | DATE | | | Az önkéntes kilépésének dátuma|
| VolStatus |BIT| Filtered, Non-Unique, Non-Clustered index | |  Az önkéntesség státusza: aktív vagy passzív|
| VolAddressID |INT| Idegen kulcs | 1:N |  Az önkéntes elérhetőségeinek azonosítója| 
	
## 5. Aid.Specialization adattábla tartalma:

Szakterületek, speciális ismeretek, minden olyan szaktudás, amely a segélyszervezet munkáját segíti.
| Attribútum neve | Attribútum típusa | Attribútum szerepe | Kapcsolat típusa | Attribútum leírása |
| :--- | :---: | :---: | :---: | :--- |
| SpecializationID | INT | Elsődleges kulcs, Clustered | | Egyedi szakterület azonosító |
| SpecializationName  | VARCHAR(100) | Egyedi kulcs, Non-Unique, Non-Clustered index  | A szakterület egyedi azonosítója |
| Description  | VARCHAR(500) | | | A szakterület leírása |

	
## 6. Aid.SupplyPlace adattábla tartalma:

Ellátási helyek, ahol menekülteket fogadank, és ott hosszabb-rövidebb időt tölthetnek el.
| Attribútum neve | Attribútum típusa | Attribútum szerepe | Kapcsolat típusa | Attribútum leírása |
| :--- | :---: | :---: | :---: | :--- |
| SupplyPlaceID | INT | Elsődleges kulcs, Clustered | | Egyedi dolgozóazonosító |
| PlaceTypeID  | INT |  Idegen kulcs, Clustered | 1:N | Az ellátási hely azonosítója |
| SupplyPlaceName |NVARCHAR(100) |Egyedi kulcs, Non-Unique, Non-Clustered index  | | Az ellátási hely neve |
| Status | BIT |  | |  Az ellátási hely státsza (működik/nem működik) |
| SupplyPlaceAddressID | INT | Idegen kulcs, index |1:N| Az ellátási hely címének azonosítója |
| Latitude | VARCHAR(20) | | | A hely szélességi koordinátája |
| Longitude| VARCHAR(20) | | |  A hely hosszúsági koordinátája |
	
Megjegyzés: ézen a táblán a szélesség (Latitude) és a hosszúság (Longitude) adatok string-ként történő letárolása a későbbi felhasználásuk érdekében történt. Ugyanis az ellátási helyekre beosztott önkéntéseknek így akár e-mail-ben is átküldhető a szolgálatteljesítés helye, annak címe és koordinátái, amit akár a Google Maps szolgáltatásba, akár egy GPS-be bemásolva térképen is megjeleníthető válik a konkrét hely.

## 7. Aid.PlaceType adattábla tartalma:

Az ellátási helyek típusai.
| Attribútum neve | Attribútum típusa | Attribútum szerepe | Kapcsolat típusa | Attribútum leírása |
| :--- | :---: | :---: | :---: | :--- |
| TypeID | INT | Elsődleges kulcs, Clustered | | az ellátási típushely egyedi azonosítója |
| PlaceTypeName  | NVARCHAR(50) | Egyedi kulcs, Non-Unique, Non-Clustered index  | | az ellátási típushely neve |
| Description  | NVARCHAR(500) | | |  az ellátási hely leírása |

	
## 8. Aid.Donators adattábla tartalma:

Az adományozó magánszemélyek és szervezetek neve.
| Attribútum neve | Attribútum típusa | Attribútum szerepe | Kapcsolat típusa | Attribútum leírása |
| :--- | :---: | :---: | :---: | :--- |
| DonatorID | INT | Elsődleges kulcs, ClusteredClustered | |Az adományozó egyedi azonosítója |
| DonatorName  | NVARCHAR(75) | Check Constraint*, Non-Unique Non-Clustered | | Az adományozó neve |
| DonatorCompanyName  | VARCHAR(100) |Check Constraint*, Non-Unique Non-Clustered | | Az adományozó szervezet neve |
| DonatorAddressID | INT| Idegen kulcs, index |1:N| Az adományozó címének azonosítója |

*Constraint:CONSTRAINT ChkDonatorName CHECK((DonatorName is not null) OR (DonatorCompanyName is not null))
	
## 9. Aid.Donations adattábla tartalma:

A felajánlott adományok legfontosabb tulajdonságai.
	
| Attribútum neve | Attribútum típusa | Attribútum szerepe | Kapcsolat típusa | Attribútum leírása |
| :--- | :---: | :---: | :---: | :--- |
| DonationID | INT | Elsődleges kulcs, Clustered |  | Az adomány egyedi azonosítója |
| DonationGUID  |uniqueidentifier| Check constraint* | | Az adományok GUID azonosítója |
| DonatorID | INT | Idegen kulcs, index | 1:N | Az adományozó egyedi azonosítója |
| DonationTypeID | INT | Idegen kulcs, index | 1:1 | Az adomány típusának azonosítója|
| DonationDate|DATE|  Check constraint**| | A felajánlás ideje |
| DonationStatus  | BIT| Non-Unique,   Non-Clustered  | | Az adományok státusza: folyamatban(1) vagy teljesült(0) |
| DonatorValue | MONEY | Check constraint***,   Non-Unique, Non-Clustered | | Az adományozó egyedi azonosítója |
| Description | NVARCHAR(500)|| | Az adomány leírása|
| DonationAddressID|INT|  Idegen kulcs, index  | 1:N | Az adomány helyének egyedi azonosítója |

*Constraint: DonationGUID DEFAULT NEWID() : DF__Donations__Donat__5165187F
**Constraint: CHK_DonationDate CHECK(DonationDate <= GETDAY
***Constraint: Chk_DonationValue CHECK(DonationValue >= 0)
	
## 10. Aid.DonationType adattábla tartalma:

Az adományok típusai.
| Attribútum neve | Attribútum típusa | Attribútum szerepe | Kapcsolat típusa | Attribútum leírása |
| :--- | :---: | :---: | :---: | :--- |
| DonationTypeID | INT | Elsődleges kulcs, Clustered, Non-Unique, Non-Clustered | |Az adománytípus egyedi azonosítója |
| DonationTypeName  | NVARCHAR(50) | Non-Unique, Non-Clustered  | | Az adománytípus neve |
| Description | NVARCHAR(500) | | | Az adománytípus leírása |
	
## 11. Aid.APL adattábla tartalma:

A telefon, mobil, e-mail, cím és földrajzi koordináták összefogaló, központi táblája.
| Attribútum neve | Attribútum típusa | Attribútum szerepe | Kapcsolat típusa | Attribútum leírása |
| :--- | :---: | :---: | :---: | :--- |
| AddressID | INT | Elsődleges kulcs, Clustered | | A cím egyedi azonosítója |
| MobilePhone1  | VARCHAR(12) | Egyedi kulcs, Unique, Non-Clustered  | | A címhez tartozó mobilszám(1) |
| MobilePhone2  | VARCHAR(12) | | | A címhez tartozó mobilszám(2) |
| PrivatPhone | VARCHAR(12) | | | A címhez tartozó vezetékes telefonszám|
| Email | VARCHAR(50)| Egyedi kulcs, Unique, Non-Clustered | | A címhez tartozó e-mail-cím |
| CityID  | INT | Idegen kulcs, Non-Unique, Non-Clustered | 1:N | A város egyedi azonosítója |
| Street | NVARCHAR(50) | | | A címhez tartozó közterület neve|
| HouseNr | SMALLINT | | |  A címhez tartozó házszám|
| Geolocation| GEOGRAPHY| | | A címhez tartozó koordináták |
	
## 12. Aid.Countries adattábla tartalma:

Az európai országok nevei, EU státuszuk.
| Attribútum neve | Attribútum típusa | Attribútum szerepe | Kapcsolat típusa | Attribútum leírása |
| :--- | :---: | :---: | :---: | :--- |
| CountyID | INT | Elsődleges kulcs, Clustered | |A város egyedi azonosítója |
| CountryID  |INT | | | | Az ország egyedi azonosítója |
| CountryName  | NVARCHAR(50) | Egyedi kulcs, Non-Unique, Non-Clustered | | Az ország neve |
| EuStatus  | BIT |Non-Unique, Non-Clustered | | EU tagállam-e az adott ország |

	
## 13. Aid.Counties adattábla tartalma:

A megyék/kerületek/járások nevét tartalmazza.
| Attribútum neve | Attribútum típusa | Attribútum szerepe | Kapcsolat típusa | Attribútum leírása |
| :--- | :---: | :---: | :---: | :--- |
| CountyID| INT | Elsődleges kulcs, Clustered | |A megye egyedi azonosítója |
| CountryID  |INT | Idegen kulcs | 1:N | | Az ország egyedi azonosítója |
| CountyName  | NVARCHAR(50) | Egyedi kulcs, Non-Unique, Non-Clustered| | A megye, kerület, járás neve |

	
## 14. Aid.Cities adattábla tartalma:

A városok neveinek táblája.
| Attribútum neve | Attribútum típusa | Attribútum szerepe | Kapcsolat típusa | Attribútum leírása |
| :--- | :---: | :---: | :---: | :--- |
| CityID| INT | Elsődleges kulcs, Clustered | |A város egyedi azonosítója |
| CountyID  |INT |Idegen kulcs| 1:N |  | A megye egyedi azonosítója |
| CityName  | NVARCHAR(50) |Egyedi kulcs, Non-Unique, Non-Clustered | | A város neve |

	
## 15. Aid.Connection adattábla tartalma:

Kapcsolótábla az Employees és a Specialization, valamint a Volunter és a Specialization táblát kapcsolja össze úgy, hogy egy személyhez több szakterületet is lehessen rendelni. 
| Attribútum neve | Attribútum típusa | Attribútum szerepe | Kapcsolat típusa | Attribútum leírása |
| :--- | :---: | :---: | :---: | :--- |
| ID| INT | Elsődleges kulcs, Clustered,  | | A kapcsolótábla egyedi azonosítója |
| SpecID  | INT | Idegen kulcs, Non-Unique, Non-Clustered  | 1:N | A szakterület tábla azonosítója|
| EmpID  | INT | Idegen kulcs, Non-Unique, Non-Clustered  | 1:N | A dolgozó azonosítója |
| VolID | INT | Idegen kulcs  | 1:N | Az önkéntes azonosítója |

	
# Felhasználók

## Felhasználók - Users
Készül egy "HELPERS" nevű login, melynek alapértelmezett adatbázisa a "Borderless". A HELPERS loginhoz készül egy felhasználó: JoakarJoe.
További felhasználók login nélkül: DolgosPaul és BeszedesTeca

## Szerepkörök - Roles
PROJET MANAGER
Joga van az Aid sémában SELECT-hez, UPDATE-hez, DELETE-hez és INSERT-hez. Ebbe a szerepkörbe tartozó felhasználó JoakaroJoe.

PROJECT TEAM LEADER
Joga van az Aid sémában SELECT-hez. Ebbe a szerepkörbe tartozó felhasználó: DolgosPaul

PROJECT ASSISTANT
SELECT joga van a Aid.APL táblához. Ebbe a szerepkörbe tartozó felhasználó: BeszedesTeca

	
# Stored Procedure

Egy segélyszervezet munkáját nagyon sok önkéntes segíti. A folyamatos és zavartalan működéshez elengedhetetlen, hogy az adatbázisban naprakész legyen a tagi nyilvántartás.

## 1. Tárolt eljárás (INSERT) 
### Aid.stpAddNewVolunter (07-Stored_procedures1.sql)
Ez a tárolt eljárás bekéri az új önkéntes adatait és 'ellenőrzi'. Például azt, hogy a belépés a rögzítés időpontjánál régebbi vagy azzal azonos-e, vagy azt, hogy az önkéntes betöltötte-e a 18- életévét? Amennyiben jövőbeli időpontot adtak meg, akkor  hibaüzenettel tér vissza: "A belépés időpontja nem lehet a mai dátumnál későbbi!". Ha 18 alatti a jelentkező, akkor a hibaüzenet a következő: 'Jelentkezzen később, ha betöltötte a 18. életévét."

![SP1_result](https://user-images.githubusercontent.com/89306078/176011706-358a9942-9a20-4787-bddb-044ec5be628c.png)
![SP1_teszt1](https://user-images.githubusercontent.com/89306078/176011732-a5c3406a-cc70-47bf-8940-b3e1f28c8d23.png)
![SP1_teszt2](https://user-images.githubusercontent.com/89306078/176011743-b08a41f1-c221-4e3e-ba71-fdd517e0545d.png)

## 2. Tárolt eljárás (UPDATE) 
### Aid.stpChangeVolunterAddress (07-Stored_procedures2.sql)
A második tárolt eljárás egy már az adatbázisban szereplő önkéntes elérhetőségét módosítja. A példa tárolt eljárásban a mobiltelefonszám ellenőrzésérekerül sor.
![SP2_szkript](https://user-images.githubusercontent.com/89306078/176685243-e5a134e9-87e0-4811-92a0-4e4a6d9bcf17.png)
![SP2_result](https://user-images.githubusercontent.com/89306078/176685276-951a9295-3db3-4628-b642-680fcd6547e7.png)

## 3. Tárolt eljárás (DELETE) 
### Aid.stpDeleteVolunter (07-Stored_procedures3.sql)
A harmadik tárolt eljárás törli azokat az önkénteseket a nyilvántartásből, akiknek a kilépési dátuma (VolDateOfExit) és a mai dátum között legalább egy év eltelt.
![SP3_szkript](https://user-images.githubusercontent.com/89306078/176827028-72e6a4e8-fd7b-4e5f-8051-7115d93e9abd.png)
![SP3_result](https://user-images.githubusercontent.com/89306078/176827036-071a4090-9641-4990-a2b8-10da8e76d51d.png)

# Views

A fájl négy, view-ként lementett összetett lekérdezést, illetve egy pivoting táblát tartalmaz. Mindegyik a szervezet napi munkájának megszervezését segíti.

## 1. view 
### Aid.OrganisationOfSupply (03_Views.sql)
Az első nézetben készült lekérdezés az összes aktív státuszú, azaz jelenleg üzemelő hazai és külföldi ellátási hely listáját adja vissza, azok típusával, elérhetőségével és koordinátáival.
	
![View01_szkript](https://user-images.githubusercontent.com/89306078/175986953-32232925-e845-4278-ad0a-f0f44867ff2d.png)
![View01_result](https://user-images.githubusercontent.com/89306078/175987036-c60d3e13-83a1-4166-b950-795fa0e1d3cd.png)

## 2. view
### Aid.OrganistionOfDonation (03_Views.sql)	
A másodikban azok az adományok kerültek lekérdezésre, amelyek szintén 'aktív' státuszúak, azaz a célbajuttatásuk még nem történt meg.

![View02_szkript](https://user-images.githubusercontent.com/89306078/175991031-039ec746-d0bc-4d3a-9701-3d10d53f5c56.png)
![View02_result](https://user-images.githubusercontent.com/89306078/175991094-2c8f2550-6e89-47a1-bbd5-3f80cda1ef80.png)

## 3. view 
### Aid.ActiveVolEmp (03_Views.sql)
A harmadik nézetben az aktív önkéntesek és dolgozók elérhetőségei kerültek a lekérdezésbe. 

![View03_szkript](https://user-images.githubusercontent.com/89306078/175991205-bc3fff10-a630-4bb2-812e-692b1a7bcb67.png)
![View03_result](https://user-images.githubusercontent.com/89306078/175991237-5405bb0e-c761-4aa1-8dac-5f2dcf9a5e3e.png)

## 4. view 
### Aid.NumberPerSpecialization (03_Views.sql)
A negyedik nézetben egy egyszerű pivoting tábla található az aktív önkéntesek szakterületenkénti számával.

![View04_szkript](https://user-images.githubusercontent.com/89306078/175992357-fc9446e2-cd9f-459d-9447-7e31ca57960e.png)
![View04_result](https://user-images.githubusercontent.com/89306078/175992378-8e2a7f96-4a36-46f8-9cf3-3c435db91ffc.png)

# Trigger		
## "AFTER DELETE" típusú DML trigger a Aid.Donations táblán. 
### Aid.trg_ArchivedDonation (06-Trigger.sql)

A felajánlott adományok - típusuknak megfelelően - kerülnek felhasználásra. A pénzösszegek lekönyvelésre kerülnek, a tárgyi adományok egyrésze azonnal felhasználásra kerül (például készételek, zöldség-gyümölcs, ruházat, stb.), másik része pedig raktárba. A felhasznált, elszállított, lekönyvelt adományok státuszát nullára módosítják, majd törlik  a táblából az érintett rekordokat. Ez a trigger akkor aktiválódik, amikor kiadnak egy törlés (DELETE) parancsot egy 0 státuszú adományra vonatkozóan az Aid.Donations táblán, függetlenül annak eredményességétől.

![Trigger_result](https://user-images.githubusercontent.com/89306078/176089019-193eed1a-3d26-4097-8faa-e267e1998376.png)
![Trigger_result2](https://user-images.githubusercontent.com/89306078/176111526-fc8a64fc-bd93-4018-8800-1d720ff8edda.png)

	
# Functions		
## Scalar UDF
### Aid.TransformGeoPoint_I (05-UDF.sql)

A földrajzi koordináták általában több forrásból, különböző adattípusban (float, varchar) állnak rendelkezésre. Ez a felhasználó által definiált scalar függvény egy metódus segítségével a bemeneti koordinátákat Geography, azaz földrajzi (pont) adattípussá/objektummá alakítja. Ezenkívül több tér-adattípus (line, poligon) létezik, ebben az adatbázisban csak pontok kerültek letárolásra az APL tábla, Geolocation mezőjében.

Paraméterek:

* @Longitudine
  * Típusa: FLOAT
  * Használata: bemeneti
* @Latitudine
  * Típusa: FLOAT
  * Használata: bemeneti

A visszatérési érték típusa: GEOGRAPHY

## Inline Table-valueed Function
### Aid.DepStat (04-iTVF1.sql)

A segélyszervezet azonfelül, hogy adományokat fogad és állami támogatás kap, számos pályázatot is ír. Minden pályázat fontos része a statisztika. Az alábbi, felhasználó által definiált tábla-érték függvény a segélyszervezet osztályainak dolgozóiról szolgáltat statisztikai adatokat táblázatos formában.

Paraméterek:

  * @departm
  * Típusa: VARCHAR
  * Használata: bemeneti

A visszatérési érték típusa: TABLE

  *  DepartmentName AS 'Osztály neve'
  * 'Dolgozók száma' (számított oszlop)
  * 'Átlagéletkor' (számított oszlop)
	
![iTVF_szkript](https://user-images.githubusercontent.com/89306078/175994606-baedcbba-13f0-4e5b-b8bd-7a160c7f50fb.png)
![iTVF_result](https://user-images.githubusercontent.com/89306078/175994551-2774e52e-ded5-4980-82d9-f9ce06effaed.png)

## Inline Table-valueed Function 
### Aid.CalcDistance (04-iTVF2.sql)

Ez a függvény olyan, felhasználó által definiált függvény, amely egy táblázatban foglalva adja vissza az aktív önkéntesek lakóhelyének távolságát a bemeneti paraméterként megadott legfontosabb ellátási pontoktól.

Paraméterek:
  * @Origin_BOK GEOGRAPHY,
    @Origin_ZAHONY GEOGRAPHY,
    @Origin_BEREGSZASZ GEOGRAPHY
  * Típusa: GEOGRAPHY
  * Használata: bemeneti

A visszatérési érték típusa: TABLE

  *  Aktív önkéntesek neve
  *  Elérhetősége
  *  Lakóhelye
  *  Távolság km-ben

![iTVF2_szkript](https://user-images.githubusercontent.com/89306078/176086276-fc3331b0-0809-4828-b2cb-a124f381c012.png)
![iTVF2_result](https://user-images.githubusercontent.com/89306078/176086295-54211b5a-7452-49c4-9663-cef5d339e23b.png)

# Az adatbázis diagramja
![Diagram_DB](https://user-images.githubusercontent.com/89306078/174710870-c6bb4176-c25b-4faa-a4be-dc6245ac7e42.jpg)

 

 


 
