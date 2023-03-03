## **Menekültek ellátását segítő adatbázis** 
### **Problémafelvetés**
Az ukrán-orosz konfliktus hatására milliók számára vált valósággá, hogy mindenüket hátrahagyva kelljen Ukrajnán belül, vagy a szomszédos országok valamelyikében menedéket keresniük. Az ukrán-magyar határt naponta tízezres számban átlépő menekültek – zömében nők, gyerekek, idősek – fogadása és ellátása soha nem tapasztalt méretű feladat elé állította a magyar állami, egyházi és civil szervezeteket, és az már szinte az első perctől látszott, hogy ennek a problémának a kezelése nem egyszereplős feladat lesz. Talán szerencsének tekinthető a szerencsétlenségben, az a történelmi tény, hogy a legtöbb magyar történelmi egyháznak már kiépített segítőhálózata van Kárpátalján, amely mind a belső menekültek, mind pedig a háború miatt nehéz helyzetbe került kárpátaljai lakosság megsegítésében is nagy szerepet játszik, tehermentesítve ezzel az itthoni szervezeteket, de újabb feladatot róva az adott segélyszervezetre.

**A probléma tehát adott, azonban a sikeres kezelése – vélemény szerint – a koordinációban rejlik.**

Abban, hogy milyen hatékonyan sikerül az állami szervek, az egyházi és egyéb segélyszervezetek, valamint az önkéntesek munkáját összehangolni. És abban is, hogy milyen gyorsan sikerül a lakosság és a cégek adományait a kellő időben, a megfelelő helyre eljuttatni, vagy a különböző szolgáltatásokat (tolmács, étkezés, orvos, állatorvos, utazás, szálláshely, stb.) megszervezni, vagy éppen a meglévő kapacitásokat (személyzet, járművek, raktárhelyek, segítségpontok, szálláshelyek) a legoptimálisabban felhasználni.

Természetesen tisztában vagyok azzal, hogy a téma komplexitása messze meghaladja ennek a vizsgaremeknek a kereteit, azonban egy-egy segélyszervezet mindennapi munkáját nagyban segítené egy olyan adatbázis, amelyből naprakész információk nyerhetőek a rendelkezésre álló felajánlásokról, humánerőforrásról, ellátási helyekről.

Az általam tervezett relációs adatbázisban külön táblán kapott helyett a hivatalos személyzet, az önkéntesek, azok szakterületei a felajánló szervezetek és magánszemélyek, a felajánlott adományok és típusai, valamint az ellátási helyek és azok típusai. Az adatbázisban kiemelten, külön táblán szerepelnek a személyek, a felajánlások, az ellátási helyek címei, elérhetőségei és földrajzi koordinátái, mivel ezen adatok a megfelelő célszemélyek értesítése, helyszínre utaztatása, valamint az optimális útvonalak megtervezése érdekében elengedhetetlen. 

Az adatbázis a következő feladatok megoldásához kíván segítséget nyújtani.

*  1.) Segíti a szervezésben résztvevő személyek munkáját azáltal, hogy naprakész információkat szolgáltat a már elkészített nézetek futtatásával.
*  2.) Lehetővé teszi, hogy az adatbázisban hazai és más európai ellátási helyek, adományok, önkéntesek címei, földrajzi koordinátái is letárolhatóak legyenek, így a határokon túl végzett munka  a hazaihoz hasonló keretek között, vagy azzal együtt szervezhető.
*  3.) A földrajzi koordináták olyan adattípusokban kerülnek letárolásra, amelyeken - vagy közvetlenül, vagy adatkonverzió után - távolságmérést lehet végezni, de egyben importálhatóak is más rendszerekbe (GPS, GIS).
*  4.) Védelmet nyújt az adatbázisban letárolt adatoknak az ahhoz való hozzáférés szabályozásával.
*  5.) Lehetővé teszi az adatok felvitelét, módosítását és törlését a rendszer konzisztenciájának megőrzése mellett.
*  6.) A tárolt adatok egyrésze nem törlésre, hanem archiválsára kerül, ezáltal nyomonkövethetővé és dokumentálhatóvá válik a segélyszervezet munkája.
*  7.) Mivel egy segélyszervezetre háruló feladat nagysága messze meghaladja ennek az adatbázisnak a kereteit, illetve ahhoz valószínűleg más nyilvántartási rendszerek (személyügyi, raktár, pénzügyi, szállítmányozási) is kapcsolódnak, ezért olyan adatokat és adattípusokat (SSN, money, GUID, stb.) is letárolásra kerültek, amelyek megkönnyítik az adatok későbbi felhasználását ezekben az adatbázisokban.
