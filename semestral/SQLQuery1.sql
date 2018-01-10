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
(1, 1, 'salam', 'Kokot přes všecko', 'Salam', 'Obecny', '123456789', 'V prdeli na hovnech');

--
-- Vypisuji data pro tabulku `leky`
--

INSERT INTO `leky` (`lek_id`, `jmeno`, `ucel`, `vedlejsi_ucinky`) VALUES
(1, 'MicheasuvPrd', 'Vonavy', 'Slzeni oci'),
(2, 'Paralen', 'Zabiják bolesti', 'Nic neléčí'),
(3, 'Brufen', 'Zabiják bolesti', 'Bolest hlavy')
;

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
(15, 'The Original House of Pies', 'Osvobození 1126', '552589495');

--
-- Vypisuji data pro tabulku `pacient`
--

INSERT INTO `pacient` (`pacient_rc`, `superpojistenec_rc`, `lekar_id`, `kod_pojistovny`, `jmeno`, `prijmeni`, `adresa`, `telefon`, `email`) VALUES
(1, NULL, 1, 666, 'Micheas', 'Rosenkreuz', 'Pod mostem', '66666666', 'smrdimipenis@moc.fakt'),
(2, NULL, 1, 400, 'Adam', 'Raw', 'Dopln Adresu', '236547852', NULL);

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
(1, 1, 1, '2018-01-08 22:14:58'),
(2, 2, 1, '2018-01-08 22:14:58'),
(3, 1, 1, '2018-01-08 22:14:58'),
(4, 15, 1, '2018-01-08 22:14:58'),
(5, 6, 1, '2018-01-08 22:14:58'),
(6, 12, 1, '2018-01-08 22:14:58'),
(7, 14, 1, '2018-01-08 22:14:58'),
(8, 13, 1, '2018-01-08 22:14:58'),
(9, 8, 1, '2018-01-08 22:14:58'),
(10, 5, 1, '2018-01-08 22:14:58'),
(11, 4, 1, '2018-01-08 22:14:58'),
(12, 7, 1, '2018-01-08 22:14:58'),
(13, 11, 1, '2018-01-08 22:14:58'),
(14, 4, 1, '2018-01-08 22:14:58'),
(15, 8, 1, '2018-01-08 22:14:58');

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
(1, 1, 'Smrad', '2018-01-07 22:14:00', NULL),
(2, 2, 'Fajnovej biceps kámo', '2018-01-07 22:14:01', NULL),
(2, 3, 'Nechci fuj', '2018-01-07 22:14:02', NULL),
(4, 1, 'Salamek', '2018-01-07 22:14:03', NULL),
(1, 4, 'Nechtooo', '2018-01-07 22:14:04', NULL),
(1, 1, 'svrab', '2018-01-07 22:14:05', 1),
(1, 8, 'asdasdasf', '2018-01-07 22:14:06', 1),
(12, 7, 'Suchý uši', '2018-01-07 22:14:07', 5),
(8, 8, 'Bolavá noha', '2018-01-07 22:14:00', 12),
(2, 6, 'Začínající demence', '2018-01-07 22:14:01', 4),
(4, 4, 'Otok mozku', '2018-01-07 22:14:02', 2),
(13, 6, 'Svrbějící nehet', '2018-01-07 22:14:03', 7),
(15, 5, 'Kleptomanie', '2018-01-07 22:14:04', NULL),
(14, 12, 'Otrava serinem', '2018-01-07 22:14:05', 1),
(7, 11, 'Zlomená hlava', '2018-01-09 20:54:21', 1);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;