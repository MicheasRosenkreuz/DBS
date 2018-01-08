-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 06, 2018 at 11:37 PM
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

-- --------------------------------------------------------

--
-- Table structure for table `karta`
--

CREATE TABLE `karta` (
  `pacient_rc` int(11) NOT NULL,
  `lekar_id` int(11) NOT NULL,
  `diagnoza` varchar(200) NOT NULL,
  `datum` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lekar`
--

CREATE TABLE `lekar` (
  `lekar_id` int(11) NOT NULL,
  `heslo` varchar(50) CHARACTER SET utf8 COLLATE utf8_czech_ci NOT NULL,
  `specializace` varchar(100) CHARACTER SET utf8 COLLATE utf8_czech_ci NOT NULL,
  `jmeno` varchar(50) CHARACTER SET utf8 COLLATE utf8_czech_ci NOT NULL,
  `prijmeni` varchar(50) CHARACTER SET utf8 COLLATE utf8_czech_ci NOT NULL,
  `telefon` varchar(13) CHARACTER SET utf8 COLLATE utf8_czech_ci NOT NULL,
  `adresa` varchar(100) CHARACTER SET utf8 COLLATE utf8_czech_ci NOT NULL,
  `nemocnice` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lekar`
--

INSERT INTO `lekar` (`lekar_id`, `heslo`, `specializace`, `jmeno`, `prijmeni`, `telefon`, `adresa`, `nemocnice`) VALUES
(1, 'salam', 'Kokot přes všecko', 'Salam', 'Obecny', '123456789', 'V prdeli na hovnech', 1);

-- --------------------------------------------------------

--
-- Table structure for table `leky`
--

CREATE TABLE `leky` (
  `lek_id` int(11) NOT NULL,
  `jmeno` varchar(50) NOT NULL,
  `ucel` varchar(100) NOT NULL,
  `vedlejsi_ucinky` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `nemocnice`
--

CREATE TABLE `nemocnice` (
  `nemocnice_id` int(11) NOT NULL,
  `adresa` varchar(100) NOT NULL,
  `telefon` varchar(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `nemocnice`
--

INSERT INTO `nemocnice` (`nemocnice_id`, `adresa`, `telefon`) VALUES
(1, 'Pod mostem 669', '654879522');

-- --------------------------------------------------------

--
-- Table structure for table `pacient`
--

CREATE TABLE `pacient` (
  `pacient_rc` int(11) NOT NULL,
  `jmeno` varchar(50) NOT NULL,
  `prijmeni` varchar(50) NOT NULL,
  `adresa` varchar(100) NOT NULL,
  `telefon` varchar(13) NOT NULL,
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pojistovna`
--

CREATE TABLE `pojistovna` (
  `pojistovna_id` int(11) NOT NULL,
  `nazev` varchar(100) NOT NULL,
  `c_pojistence` int(11) NOT NULL,
  `pojistenec` int(11) NOT NULL,
  `super_pojistenec` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `recept`
--

CREATE TABLE `recept` (
  `recept_id` int(11) NOT NULL,
  `lek_id` int(11) NOT NULL,
  `lekar_id` int(11) NOT NULL,
  `pacient_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `karta`
--
ALTER TABLE `karta`
  ADD KEY `fk_lekar_karta` (`lekar_id`),
  ADD KEY `fk_pacient_karta` (`pacient_rc`);

--
-- Indexes for table `lekar`
--
ALTER TABLE `lekar`
  ADD PRIMARY KEY (`lekar_id`),
  ADD UNIQUE KEY `lekar_id` (`lekar_id`),
  ADD KEY `fk_nemocnice` (`nemocnice`);

--
-- Indexes for table `leky`
--
ALTER TABLE `leky`
  ADD PRIMARY KEY (`lek_id`),
  ADD UNIQUE KEY `lek_id` (`lek_id`),
  ADD UNIQUE KEY `jmeno` (`jmeno`);

--
-- Indexes for table `nemocnice`
--
ALTER TABLE `nemocnice`
  ADD PRIMARY KEY (`nemocnice_id`),
  ADD UNIQUE KEY `nemocnice_id` (`nemocnice_id`);

--
-- Indexes for table `pacient`
--
ALTER TABLE `pacient`
  ADD PRIMARY KEY (`pacient_rc`),
  ADD UNIQUE KEY `pacient_rc` (`pacient_rc`);

--
-- Indexes for table `pojistovna`
--
ALTER TABLE `pojistovna`
  ADD PRIMARY KEY (`pojistovna_id`),
  ADD UNIQUE KEY `pojistovna_id` (`pojistovna_id`),
  ADD UNIQUE KEY `c_pojistence` (`c_pojistence`),
  ADD UNIQUE KEY `nazev` (`nazev`),
  ADD KEY `fk_pojistenec` (`pojistenec`),
  ADD KEY `fk_super_pojistenec` (`super_pojistenec`);

--
-- Indexes for table `recept`
--
ALTER TABLE `recept`
  ADD PRIMARY KEY (`recept_id`),
  ADD UNIQUE KEY `recept_id` (`recept_id`),
  ADD KEY `fk_lek` (`lek_id`),
  ADD KEY `fk_lekar` (`lekar_id`),
  ADD KEY `fk_pacient` (`pacient_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `lekar`
--
ALTER TABLE `lekar`
  MODIFY `lekar_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `leky`
--
ALTER TABLE `leky`
  MODIFY `lek_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nemocnice`
--
ALTER TABLE `nemocnice`
  MODIFY `nemocnice_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pojistovna`
--
ALTER TABLE `pojistovna`
  MODIFY `pojistovna_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `recept`
--
ALTER TABLE `recept`
  MODIFY `recept_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `karta`
--
ALTER TABLE `karta`
  ADD CONSTRAINT `fk_lekar_karta` FOREIGN KEY (`lekar_id`) REFERENCES `lekar` (`lekar_id`),
  ADD CONSTRAINT `fk_pacient_karta` FOREIGN KEY (`pacient_rc`) REFERENCES `pacient` (`pacient_rc`);

--
-- Constraints for table `lekar`
--
ALTER TABLE `lekar`
  ADD CONSTRAINT `fk_nemocnice` FOREIGN KEY (`nemocnice`) REFERENCES `nemocnice` (`nemocnice_id`);

--
-- Constraints for table `pojistovna`
--
ALTER TABLE `pojistovna`
  ADD CONSTRAINT `fk_pojistenec` FOREIGN KEY (`pojistenec`) REFERENCES `pacient` (`pacient_rc`),
  ADD CONSTRAINT `fk_super_pojistenec` FOREIGN KEY (`super_pojistenec`) REFERENCES `pacient` (`pacient_rc`);

--
-- Constraints for table `recept`
--
ALTER TABLE `recept`
  ADD CONSTRAINT `fk_lek` FOREIGN KEY (`lek_id`) REFERENCES `leky` (`lek_id`),
  ADD CONSTRAINT `fk_lekar` FOREIGN KEY (`lekar_id`) REFERENCES `lekar` (`lekar_id`),
  ADD CONSTRAINT `fk_pacient` FOREIGN KEY (`pacient_id`) REFERENCES `pacient` (`pacient_rc`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
