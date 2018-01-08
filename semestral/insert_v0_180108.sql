-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 08, 2018 at 07:54 PM
-- Server version: 10.1.29-MariaDB
-- PHP Version: 7.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbs_patients`
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
-- Dumping data for table `karta`
--

INSERT INTO `zaznam` (`pacient_rc`, `lekar_id`, `recept_id`, `diagnoza`, `datum`) VALUES
(1, 1, NULL, 'Smrad', '2018-01-07 22:14:00'),
(1, 1, NULL, 'Fajnovej biceps kámo', '2018-01-07 22:14:01'),
(1, 1, NULL, 'Nechci fuj', '2018-01-07 22:14:02'),
(1, 1, NULL, 'Salamek', '2018-01-07 22:14:03'),
(1, 1, NULL, 'Nechtooo', '2018-01-07 22:14:04'),
(1, 1, 1, 'svrab', '2018-01-07 22:14:05'),
(1, 1, 1, 'asdasdasf', '2018-01-07 22:14:06'),
(1, 1, 5, 'Suchý uši', '2018-01-07 22:14:07');

--
-- Dumping data for table `lekar`
--

INSERT INTO `lekar` (`lekar_id`, `heslo`, `specializace`, `jmeno`, `prijmeni`, `telefon`, `adresa`, `nemocnice_id`) VALUES
(1, 'salam', 'Kokot přes všecko', 'Salam', 'Obecny', '123456789', 'V prdeli na hovnech', 1);

--
-- Dumping data for table `leky`
--

INSERT INTO `leky` (`lek_id`, `jmeno`, `ucel`, `vedlejsi_ucinky`) VALUES
(1, 'MicheasuvPrd', 'Vonavy', 'Slzeni oci');

--
-- Dumping data for table `nemocnice`
--

INSERT INTO `nemocnice` (`nemocnice_id`, `nazev`, `adresa`, `telefon`) VALUES
(1, 'Nemocnice sv. Františka', 'Pod mostem 669', '654879522');

--
-- Dumping data for table `pacient`
--

INSERT INTO `pacient` (`pacient_rc`, `superpojistenec_rc`, `lekar_id`, `kod_pojistovny`, `jmeno`, `prijmeni`, `adresa`, `telefon`, `email`) VALUES
(1, NULL, 1, 666, 'Micheas', 'Rosenkreuz', 'Pod mostem', '66666666', 'smrdimipenis@moc.fakt');

--
-- Dumping data for table `recept`
--

INSERT INTO `recept` (`recept_id`, `pacient_rc`, `lekar_id`, `datum_vydani`) VALUES
(1, 1, 1, '2018-01-08 22:14:58'),
(2, 1, 1, '2018-01-08 22:14:58'),
(3, 1, 1, '2018-01-08 22:14:58'),
(4, 1, 1, '2018-01-08 22:14:58'),
(5, 1, 1, '2018-01-08 22:14:58');


INSERT INTO `recept_leky` (`recept_id`,`lek_id`, `davkovani`) VALUES
(1, 1, 'Jednou vecer'),
(2, 1, 'asdasd'),
(3, 1, 'asdasd'),
(4, 1, 'asdasd'),
(5, 1, 'Hodně vody, furt');


INSERT INTO `pojistovna` (`kod_pojistovny`,`nazev`) VALUES
(666, 'Pojišťovna podle Danteho'),
(400, 'Taková ta pojišťovna'),
(23, '\"To číslo je všude\" pojišťovna');

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
