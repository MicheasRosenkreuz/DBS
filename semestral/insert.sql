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
(1, 'Nemocnice sv. Františka', 'Pod mostem 669', '654879522');

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
(23, '\"To číslo je všude\" pojišťovna');

--
-- Vypisuji data pro tabulku `recept`
--

INSERT INTO `recept` (`recept_id`, `pacient_rc`, `lekar_id`, `datum_vydani`) VALUES
(1, 1, 1, '2018-01-08 22:14:58'),
(2, 1, 1, '2018-01-08 22:14:58'),
(3, 1, 1, '2018-01-08 22:14:58'),
(4, 1, 1, '2018-01-08 22:14:58'),
(5, 1, 1, '2018-01-08 22:14:58');

--
-- Vypisuji data pro tabulku `recept_leky`
--

INSERT INTO `recept_leky` (`recept_id`, `lek_id`, `davkovani`) VALUES
(1, 1, 'Jednou vecer'),
(2, 1, 'asdasd'),
(3, 1, 'asdasd'),
(4, 1, 'asdasd'),
(5, 1, 'Hodně vody, furt'),
(5, 3, '1x denně');

--
-- Vypisuji data pro tabulku `zaznam`
--

INSERT INTO `zaznam` (`pacient_rc`, `lekar_id`, `diagnoza`, `datum`, `recept_id`) VALUES
(1, 1, 'Smrad', '2018-01-07 22:14:00', NULL),
(1, 1, 'Fajnovej biceps kámo', '2018-01-07 22:14:01', NULL),
(1, 1, 'Nechci fuj', '2018-01-07 22:14:02', NULL),
(1, 1, 'Salamek', '2018-01-07 22:14:03', NULL),
(1, 1, 'Nechtooo', '2018-01-07 22:14:04', NULL),
(1, 1, 'svrab', '2018-01-07 22:14:05', 1),
(1, 1, 'asdasdasf', '2018-01-07 22:14:06', 1),
(1, 1, 'Suchý uši', '2018-01-07 22:14:07', 5),
(2, 1, 'Bolavá noha. Asi je zlomená.', '2018-01-09 20:54:21', 1);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
