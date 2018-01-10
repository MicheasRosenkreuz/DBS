-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Počítač: 127.0.0.1
-- Vytvořeno: Úte 09. led 2018, 22:11
-- Verze serveru: 10.1.29-MariaDB
-- Verze PHP: 7.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáze: `dbs_patients`
--

--
-- delete tables
--

DELETE FROM recept_leky;
DELETE FROM recept;
DELETE FROM pojistovna;
DELETE FROM leky;
DELETE FROM nemocnice;
DELETE FROM lekar;
DELETE FROM zaznam;
DELETE FROM pacient;

--
-- Vypisuji data pro tabulku `lekar`
--

INSERT INTO `lekar` (`lekar_id`, `nemocnice_id`, `heslo`, `specializace`, `jmeno`, `prijmeni`, `telefon`, `adresa`) VALUES
(1, 5, 'aeBohcase4qu', 'chirurg', 'Josef', 'Peřina', '602181850', 'Pivovarská 1984, 411 42 Ploskovice'),
(2, 5, 'Yeechoh1oo', 'psycholog', 'Roman', 'Řídký', '777704357', 'Erbenova 1412, 517 61 Rokytnice v Orlických horách'),
(3, 1, 'laiT7Ephei', 'praktický lékař', 'Libuše', 'Kovářová', '730732471', 'Mlýnská 332, 588 42 Vetrný Jeníkov'),
(4, 8, 'Feahoh3ae', 'chirurg', 'Petr', 'Linhart', '551682616', 'Za učilištěm 1121, 741 01 Nový Jicín 1'),
(5, 15, 'ien0eek3Eu', 'praktický lékař', 'Anna', 'Ďurišová', '732144587', 'Bavorovská 510, 384 81 Ckyne'),
(6, 14, 'eaF9gi1oob', 'chiropraktik', 'Ludmila', 'Havelková', '374798591', 'Vrchlického 577, 344 01 Domažlice 1'),
(7, 12, 'ohP4iekaifa', 'chiropraktik', 'Jaroslav', 'Toráč', '601112961', 'Žerotínova 137, 580 01 Havlíckuv Brod 1'),
(8, 3, 'AhFaejo4ies', 'praktický lékař', 'Vladimír', 'Stejskal', '480326264', 'V Trávníkách 483, 468 21 Bratríkov'),
(9, 7, 'ja4ioX6phei', 'praktický lékař', 'Lenka', 'Matušková', '379647638', 'Polní 418, 330 38 Únešov'),
(10, 1, 'EDaide9Agh', 'alergologie a imunoterapie', 'Marie', 'Štefková', '734272692', 'Bártova 1999, 679 61 Letovice'),
(11, 14, 'shooX6ooshe', 'praktický lékař', 'Jana', 'Dudová', '475403855', 'Masarykova 954, 438 01 Žatec 1'),
(12, 9, 'Eoy8ahv8aipao', 'kardiolog', 'Stanislav', 'Stráník', '777592490', 'Poštovní 1974, 294 15 Klášter Hradište nad Jizerou'),
(13, 10, 'ruochee3R', 'dermatolog', 'Dominik', 'Zelený', '727374511', 'Dělnická 332, 753 54 Sobechleby'),
(14, 2, 'ieshah7Ies', 'Dětská chirurgie', 'Petr', 'Šafařík', '736870717', 'Bratří Čapků 894, 549 01 Nové Mesto nad Metují 1'),
(15, 11, 'mee1fex3Ae', 'Reprodukční medicína ', 'Jiří', 'Nahodil', '462639817', 'Jiráskova 1540, 538 04 Prachovice');

--
-- Vypisuji data pro tabulku `leky`
--

INSERT INTO `leky` (`lek_id`, `jmeno`, `ucel`, `vedlejsi_ucinky`) VALUES
(1, 'WOBENZYM 800 dražé', 'Lék Wobenzym - proti zánětům, otokům a poruchám imunity', 'Wobenzym je obvykle dobře snášen, ani při dlouhodobém podávání vysokých dávek nebyly  pozorovány nežádoucí účinky. Ojediněle se může objevit nevýrazná změna konzistence, barvy a zápachu stolice. Při užívání vyšších jednorázových dávek byly pozorovány pocity nadýmání, ojediněle nevolnost. Těmto pocitům se dá zamezit rozdělením dávky v průběhu dne. Zřídka se objevující alergické reakce (kožní vyrážka) odeznívají po vysazení léku.'),
(2, 'Olynth® HA 0,1 % nosní sprej, roztok 10 ml', 'RYCHLÁ ÚLEVA OD RÝMY. Uvolní ucpaný nos a vedlejších nosní dutiny. Zvlhčení a regenerace nosní sliznice.', '
Dýchací systém
U citlivých nemocných může přípravek Olynth HA 0,1% způsobit příznaky dráždění sliznice přechodného a mírného charakteru, které se projeví jako pálení v nose nebo suchost nosní sliznice.
V ojedinělých případech může dojít ke zvýšenému otoku nosní sliznice po odeznění účinku léku.

Nervový systém
Ve velmi vzácných případech se mohou vyskytnout bolesti hlavy, nespavost nebo únava.

Oběhový systém
Ojediněle až vzácně se mohou dostavit účinky přípravku na srdce a krevní oběh, jako např. bušení srdce, zrychlený tep a zvýšení krevního tlaku. '),
(3, 'PHARMATON GERIAVIT 100 měkkých tobolek', 'Působí proti únavě, posiluje tělesné a duševní funkce a vitalitu.', '
    Poruchy nervového systému - Časté (u více než 1 ze 100 pacientů, ale méně než 1 z 10 pacientů) bolest hlavy. Není známo (z dostupných údajů nelze určit) - závratě.
    Gastrointestinální poruchy - Časté (u více než 1 ze 100 pacientů, ale méně než 1 z 10 pacientů): pocit na zvracení, zvracení. Méně časté (u více než 1 z 1000 pacientů, ale méně než 1 ze 100 pacientů) - průjem. Není známo (z dostupných údajů nelze určit) - bolesti žaludku.
    Poruchy kůže a podkožní tkáně - Není známo (z dostupných údajů nelze určit) - vyrážka, svědění.
    Poruchy imunitního systému - Není známo (z dostupných údajů nelze určit) - reakce přecitlivělosti.
'),
(4, 'EXCIPIAL U Lipolotio emulze 200 ml', 'zlepšuje a normalizuje stav pokožky. Vyhlazuje její drsný povrch.', 'Poruchy kůže a podkožní tkáně             - Vzácné (≥1/10 000 až <1/1 000) - přecitlivělost (zarudnutí, pálení a svědění)'),
(5, 'PARALEN 500 mg 24 tablet', 'působí proti bolesti různého původu a snižuje zvýšenou tělesnou teplotu.', '
    otok různých částí těla, nejčastěji v obličeji nebo v oblasti krku,
    závažná alergická reakce způsobující dechové potíže nebo závrať, která může vést až k šokovému stavu,
    závažné kožní reakce, kterým často předchází horečka, bolesti hlavy, bolest v krku, bolest těla (příznaky podobné chřipce). Kožní projevy bývají doprovázeny postižením sliznic v podobě vředů v ústech, krku, nosu, na genitáliích a zánětu spojivek (červené a oteklé oči). Kožní vyrážka se může rozvinout v rozsáhlé plochy puchýřů a olupující se kůže.
'),
(6, 'BOIRON Oscillococcinum 1 g x30 dávek', 'Preventivně a od prvních příznaků, bez věkového omezení.', 'Podobně jako všechny léky může mít i OSCILLOCOCCINUM nežádoucí účinky, které se ale nemusí vyskytnout u každého. Žádné nežádoucí účinky nebyly dosud zaznamenány. Pokud se kterýkoli z nežádoucích účinků vyskytne v závažné míře nebo pokud si všimnete jakýchkoli nežádoucích účinků, které nejsou uvedeny v této příbalové informaci, sdělte to prosím svému lékaři nebo lékárníkovi.'),
(7, 'ES BIO Chlorella 750 tablet ', 'Chlorella je přírodní prostředek, pro k šetrnou a přirozenou detoxikaci.', ''),
(8, 'IBALGIN 400 mg 100 potahovaných tablet', 'Tablety Ibalgin zmírňují bolest a zánět různého původu, rovněž tlumí horečku', 'Velmi časté (mohou postihnout více než 1 pacienta z 10) - pocit na zvracení, zvracení, pálení žáhy, průjem, zácpa, nadýmání.
Časté (mohou postihnout až 1 pacienta z 10): bolest v nadbřišku.
Méně časté (mohou postihnout až 1 pacienta ze 100) - bolest hlavy, závrať.
Vzácné (mohou postihnout až 1 pacienta z 1 000) - zánět sliznice žaludku, žaludeční nebo dvanáctníkový vřed, krvácení z trávicího traktu (projevuje se jako černá stolice v důsledku natrávené krve nebo krev ve stolici) 1, proděravění sliznice trávicího traktu, alergické reakce jako horečka, vyrážka, poškození jater, srdeční selhávání, otoky, sterilní zánět mozkových plen2, zúžení průdušek3, zánět slinivky břišní, poruchy vidění a vnímaní barev, tupozrakost, poškození jaterních funkcí4.'),
(9, 'REVALID 270 tobolek ', 'Chcete krásný účes? Uzdravte své vlasy s lékem Revalid tobolky. ', ' Podobně jako všechny přípravky, může mít i Revalid nežádoucí účinky, které se ale nemusí vyskytnout u každého. Pokud užijete tobolky Revalid mezi dvěma jídly nebo nalačno, může se objevit nausea nebo lehké gastrointestinální obtíže. V tomto případě musíte dodržovat doporučený postup pro užívání Revalidu. Výjimečně, při dávkování 6 tobolek denně, se mohou vyskytnout lehké zažívací potíže. V těchto případech je vhodné přejít na dávkování 3x denně 1 tobolku. Obvykle je ale Revalid velmi dobře snášen.Pokud se kterýkoli z nežádoucích účinků vyskytne v závažné míře nebo pokud si všimnete jakýchkoli nežádoucích účinků, které nejsou uvedeny v této příbalové informaci, prosím, sdělte to svému lékaři nebo lékárníkovi.'),
(10, 'BIOGAIA ProTectis kapky – sklenička 10 ml ', 'Napomáhá normálnímu fungování dětského zažívání.', ''),
(11, 'ACC LONG 20x600 mg šumivých tablet', 'Rychlé řešení na kašel. Rozpouští hustý hlen, usnadňuje tak vykašlávání a pomáhá zbavit se kašle', 'Hodnocení výskytu nežádoucích účinků vychází z tého klasifikace jejich frekvence:

Velmi časté: mohou postihnout až 1 z 10 pacientů
Časté: mohou postihnout až 1 z 10 pacientů
Méně časté: mohou postihnout až 1 ze 100 pacientů
Vzácné: mohou postihnout až 1 z 1000 pacientů
Velmi vzácné: mohou postihnout až 1 z 10000 pacientů
Neznámá četnost: z dostupných údajů nelze určit
'),
(12, 'VISINE Classic Oční kapky, roztok 15 ml ', 'Visine odstraňuje zarudnutí očí a ulevuje od jejich podráždění. Léčivý přípravek k očnímu podání. ', 'Při použití očních kapek Visine Classic se může velmi vzácně (mohou postihnout méně než 1 pacienta
z 10 000) objevit rozšíření zornic, pálení očí a v oblasti očí, zarudnutí, podráždění, otok, bolest
a svědění očí.
V tomto případě ukončete podávání přípravku a poraďte se s lékařem. '),
(13, 'PANADOL Novum 500 mg x 24 potahovaných tablet', 'Nově proti horečce a bolesti, nový Panadol Novum.', 'Přípravek používaný v doporučených dávkách je obvykle dobře snášen, ale mohou se vyskytnout kožní vyrážky, dušnost nebo poruchy krvetvorby. Vzácně se mohou vyskytnout žaludeční potíže typu tlaku a bolesti žaludku. Jestliže se u Vás objeví následující obtíže, přestaňte tento léčivý přípravek užívat a okamžitě informujte svého lékaře:
Alergické reakce, které mohou být závažné, včetně kožní vyrážky, svědění, někdy s otokem úst nebo tváře, nebo dušnost
Kožní vyrážka nebo odlupování kůže nebo vřídky v ústech
Problémy s dýcháním. Pravděpodobnost výskytu tohoto nežádoucího účinku je vyšší, jestliže jste problémy s dýcháním měl/a již dříve po užití jiných léků na bolest (např. ibuprofen nebo aspirin)
Neobvyklá tvorba modřin nebo krvácení. '),
(14, 'INFADOLAN mast 30 g ', 'INFADOLAN® je léčivý přípravek na popáleniny, suchou kůži i opruzeniny pro novorozence i dospělé.', 'Pro hodnocení nežádoucích účinků je jejich frekvence definována takto:
Velmi časté: více než 1 z 10 léčených nemocných
Časté: méně než 1 z 10, ale více než 1 ze 100 léčených nemocných
Méně časté: méně než 1 ze 100, ale více než 1 z 1000 léčených nemocných
Vzácné: méně než 1 z 1000, ale více než 1 z 10000 léčených nemocných
Velmi vzácné: méně než 1 z 10000 léčených nemocných, není známo (nelze stanovit z dostupných údajů)
Méně časté: Během léčby může velmi ojediněle dojít k přecitlivělosti na některou složku přípravku. Příznaky přecitlivělosti zahrnují svědění, zčervenání, pocity pálení.
Vzácné: zduření kůže, někdy i výsevy drobných pupínků.
'),
(15, 'OBEZIN 90 tobolek', 'Snažíte se zhubnout? Netrapte se hladem a drastickými dietami. S Obezinem budete dříve sytí a budete mít menší chuť k jídlu. ', '');

--
-- Vypisuji data pro tabulku `nemocnice`
--

INSERT INTO `nemocnice` (`nemocnice_id`, `nazev`, `adresa`, `telefon`) VALUES
(1, 'Nemocnice sv. Františka', 'Pod mostem 669', '654879522'),
(2, 'Benesome', 'Stožická 1128', '724875103'),
(3, 'Joshua Doore', 'Malá Strana 923', '735177085'),
(4, 'Body Toning', 'Školní 1831', '738358919'),
(5, 'Gamma Grays', 'Americká 1205', '378618922'),
(6, 'World of Fun', 'Truhlářská 1556', '604583780'),
(7, 'Weatherill', 'Lidická 1214', '773546329'),
(8, 'Thrift Auto Parts', 'Obránců míru 1412', '490924453'),
(9, 'Infinite Wealth Planners', 'Úzká 933', '512046541'),
(10, 'A.J. August Fashion Wear', 'Mládežnická 444', '350826027'),
(11, 'Sam Goody', 'U medvídků 677', '325554743'),
(12, 'Simply Appraisals', 'Hradní 1773', '602848498'),
(13, 'I. Magnin', 'Erbenova 578', '729447502'),
(14, 'MacMarr Stores', 'Komenského 849', '726 714 096'),
(15, 'The Original House of Peace', 'Osvobození 1126', '552589495');

--
-- Vypisuji data pro tabulku `pacient`
--

INSERT INTO `pacient` (`pacient_rc`, `superpojistenec_rc`, `lekar_id`, `kod_pojistovny`, `jmeno`, `prijmeni`, `adresa`, `telefon`, `email`) VALUES
(8601035212, 6501292413, 3, 500, 'Zdeňka', 'Drábková', 'Tyršova 1034, 379 01 Trebon', '727668554', 'JiriVasko@armyspy.com'),
(9407276417, 8601035212, 1, 500, 'Tomáš', 'Drábek', 'Tyršova 1922, 378 81 Slavonice', '394025700', 'TomasDoan@armyspy.com'),
(7602173920, NULL, 11, 500, 'Marie', 'Šibravová', 'Pod Malsičkou 1934, 387 16 Volenice', '604528690', 'MarieSibravova@rhyta.com'),
(6310062319, NULL, 5, 555, 'Jana', 'Hartmanová', 'Köhlerova 805, 698 01 Veselí nad Moravou', '510681285', 'JanaHartmanova@dayrep.com'),
(8907095714, NULL, 8, 555, 'Filip', 'Pleva', 'Karafiátova 36, 798 41 Kostelec na Hané', '605792783', NULL),
(7009213211, 6501292413, 15, 555, 'Ondřej', 'Mraček', 'Dvořákova 1312, 250 84 Sibrina', '726413173', 'OndrejMracek@dayrep.com'),
(5706141419, 8810265618, 14, 555, 'Ladislav', 'Tůma', 'Mládežnická 100, 357 51 Kynšperk nad Ohrí', '771060571', 'LadislavTuma@jourrapide.com'),
(6206212111, 8601035212, 13, 555, 'Alena', 'Voláková', 'Jindřichova 367, 378 06 Suchdol nad Lužnicí', '770208334', 'AlenaPenickova@armyspy.com'),
(7312253619, 8601035212, 4, 888, 'Marie', 'Voláková', 'V Aleji 1519, 351 37 Luby u Chebu', '731537684', 'MarieVolakova@jourrapide.com'),
(1406229110, NULL, 2, 888, 'Simona', 'Grossová', 'Polní 383, 330 33 Mesto Touškov', '370663900', 'SimonaGrossova@rhyta.com'),
(7408053719, 6501292413, 7, 888, 'Josef', 'Kocman', 'Louny 1041, 440 01 Louny 1', '721743858', NULL),
(8810265618, NULL, 9, 888, 'Radim', 'Kořínek', 'Obránců míru 1894, 516 01 Rychnov nad Knežnou', '734373405', 'RadimKorinek@dayrep.com'),
(6501292413, NULL, 10, 888, 'Alena', 'Šabatová', 'Matiegkova 1792, 257 44 Netvorice', '326934867', 'AlenaSabatova@jourrapide.com'),
(7301113512, 8810265618, 3, 444, 'Veronika', 'Jelínková', 'Školní 1336, 339 01 Klatovy 1', '371551001', 'VeronikaJelinkova@rhyta.com'),
(9303136216, 8810265618, 5, 444, 'František', 'Štefka', 'Švermova 1164, 460 15 Liberec 15', '488780652', NULL);

--
-- Vypisuji data pro tabulku `pojistovna`
--

INSERT INTO `pojistovna` (`kod_pojistovny`, `nazev`) VALUES
(666, 'Pojišťovna podle Danteho'),
(400, 'Taková ta pojišťovna'),
(500, 'Nemecka'),
(444, 'Pojištovka3000'),
(333, 'Dvacet let pod drnem'),
(222, 'Nic nepojišťovna'),
(111, 'Oškubáci'),
(555, 'VZP'),
(777, 'Papíráci'),
(888, 'Dolar pro každého'),
(999, 'Jídlo zdarma'),
(700, 'Tabulka malá'),
(258, 'Kečupová lahev'),
(159, 'Neperlivá voda'),
(23, '\"To číslo je všude\" pojišťovna');

--
-- Vypisuji data pro tabulku `recept`
--

INSERT INTO `recept` (`recept_id`, `pacient_rc`, `lekar_id`, `datum_vydani`) VALUES
(1, 8601035212, 1, '2018-01-08 22:14:58'),
(2, 9407276417, 13, '2018-01-08 22:14:58'),
(3, 8601035212, 11, '2018-01-08 22:14:58'),
(4, 9303136216, 1, '2018-01-08 22:14:58'),
(5, 7009213211, 15, '2018-01-08 22:14:58'),
(6, 8810265618, 8, '2018-01-08 22:14:58'),
(7, 7301113512, 2, '2018-01-08 22:14:58'),
(8, 6501292413, 7, '2018-01-08 22:14:58'),
(9, 5706141419, 6, '2018-01-08 22:14:58'),
(10, 8907095714, 7, '2018-01-08 22:14:58'),
(11, 6310062319, 7, '2018-01-08 22:14:58'),
(12, 5706141419, 1, '2018-01-08 22:14:58'),
(13, 7408053719, 5, '2018-01-08 22:14:58'),
(14, 6310062319, 10, '2018-01-08 22:14:58'),
(15, 6206212111, 1, '2018-01-08 22:14:58');

--
-- Vypisuji data pro tabulku `recept_leky`
--

INSERT INTO `recept_leky` (`recept_id`, `lek_id`, `davkovani`) VALUES
(1, 1, 'Jednou vecer'),
(2, 2, 'Po každém jídle'),
(3, 8, 'Před každým jídlem'),
(4, 6, 'Když začne bolet noha'),
(5, 1, 'Před spánkem'),
(6, 11, 'Po probuzení'),
(7, 10, 'Před toaletou'),
(8, 2, 'Ve sprše'),
(9, 14, 'Při čištění zubů'),
(10, 1, 'Před běháním'),
(11, 12, 'V posteli'),
(12, 3, '2x denně, jedno kdy'),
(13, 4, '6 hodin odstup maximálně 4 denně'),
(14, 5, 'Platíčko denně'),
(15, 3, '1x denně');

--
-- Vypisuji data pro tabulku `zaznam`
--

INSERT INTO `zaznam` (`pacient_rc`, `lekar_id`, `diagnoza`, `datum`, `recept_id`) VALUES
(8601035212, 1, 'Smrad', '2017-01-07 22:14:00', NULL),
(9407276417, 2, 'Fajnovej biceps kámo', '2018-01-07 22:14:01', NULL),
(9407276417, 3, 'Nechci fuj', '2018-01-07 22:14:02', NULL),
(6310062319, 1, 'Salamek', '2018-01-07 22:14:03', NULL),
(8601035212, 4, 'Nechtooo', '2018-01-07 22:14:04', NULL),
(8601035212, 1, 'svrab', '2018-01-07 22:14:05', 1),
(8601035212, 8, 'asdasdasf', '2018-01-07 22:14:06', 1),
(8810265618, 7, 'Suchý uši', '2018-01-07 22:14:07', 5),
(6206212111, 8, 'Bolavá noha', '2018-01-07 22:14:08', 12),
(9407276417, 6, 'Začínající demence', '2018-01-07 22:14:09', 4),
(6310062319, 4, 'Otok mozku', '2018-01-07 22:14:10', 2),
(6501292413, 6, 'Svrbějící nehet', '2018-01-07 22:14:11', 7),
(9303136216, 5, 'Kleptomanie', '2018-01-07 22:14:12', NULL),
(7301113512, 12, 'Otrava serinem', '2018-01-07 22:14:13', 1),
(5706141419, 11, 'Zlomená hlava', '2018-01-09 20:54:14', 1);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
