-- phpMyAdmin SQL Dump
-- version 3.3.3
-- http://www.phpmyadmin.net
--
-- Počítač: localhost
-- Vygenerováno: Středa 02. října 2013, 22:01
-- Verze MySQL: 5.1.46
-- Verze PHP: 5.3.2

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Databáze: `db_eshop`
--
CREATE DATABASE `db_eshop` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `db_eshop`;

-- --------------------------------------------------------

--
-- Struktura tabulky `tbl_kat`
--

CREATE TABLE IF NOT EXISTS `tbl_kat` (
  `kat` varchar(5) NOT NULL COMMENT 'Kategorie zbozi - kod',
  `nazk` varchar(30) NOT NULL COMMENT 'nazev kategorie',
  `popk` varchar(200) DEFAULT NULL COMMENT 'popis kategorie',
  `nadk` varchar(5) DEFAULT NULL COMMENT 'nadrizena kategorie (pokud nejaka je tak odkazuje do tbl_kat.kat)',
  PRIMARY KEY (`kat`),
  KEY `nadk` (`nadk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tabulka kategorii zbozi';

--
-- Vypisuji data pro tabulku `tbl_kat`
--

INSERT INTO `tbl_kat` (`kat`, `nazk`, `popk`, `nadk`) VALUES
('dest', 'destilaty', 'tvrdy alkohol', 'napAl'),
('limo', 'limonady', 'nealkoholicke limonady nejruznejsich prichuti', 'napNa'),
('minVo', 'mineralni vody', 'pramenite mineralni a stolni vody', 'napNa'),
('nap', 'napoje', 'zbozi, ktere lze pit', NULL),
('napAl', 'napoje alkoholicke', 'alkohol', 'nap'),
('napNa', 'napoje nealkoholicke', 'napoje, ktere neobsahuji alkohol', 'nap'),
('ovze', 'ovoce, zelenina', 'neco dobreho pro zdravi', NULL),
('pec', 'pecivo', 'chleb, housky, rohliky, sladke pecivo atd...', NULL),
('pivo', 'pivo', 'piva ruznych druhu', 'napAl'),
('vino', 'vino', 'nejruznejsi druhy vina', 'napAl');

-- --------------------------------------------------------

--
-- Struktura tabulky `tbl_obj`
--

CREATE TABLE IF NOT EXISTS `tbl_obj` (
  `ciso` int(11) NOT NULL AUTO_INCREMENT COMMENT 'cislo objednavky',
  `zak` varchar(20) NOT NULL COMMENT 'login zakaznika (odkazuje do tbl_zak.login)',
  `dat` date NOT NULL COMMENT 'datum prijeti',
  `datod` date DEFAULT NULL COMMENT 'datum odeslani',
  `stav` enum('prijata','vyrizuje se','odeslana') NOT NULL COMMENT 'stav objednavky (prijata, vyrizuje se, odeslana)',
  `plat` enum('prevodem','hotove','dobirka') NOT NULL COMMENT 'zpusob platby (prevodem, hotove, dobirkou)',
  `dopr` enum('osobne','rozvoz','cp','ppl') NOT NULL COMMENT 'zpusob dopravy (osobni odber, rozvoz, ceska posta, ppl)',
  `pozn` varchar(200) DEFAULT NULL COMMENT 'poznamky zakaznika',
  PRIMARY KEY (`ciso`),
  KEY `zak` (`zak`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='tabulka objednavek' AUTO_INCREMENT=31 ;

--
-- Vypisuji data pro tabulku `tbl_obj`
--

INSERT INTO `tbl_obj` (`ciso`, `zak`, `dat`, `datod`, `stav`, `plat`, `dopr`, `pozn`) VALUES
(1, 'krec', '2006-12-04', '2006-01-11', 'odeslana', 'prevodem', 'rozvoz', NULL),
(2, 'krec', '2006-10-12', '2006-12-12', 'odeslana', 'prevodem', 'osobne', NULL),
(3, 'krec', '2006-11-23', '2006-11-25', 'odeslana', 'hotove', 'cp', NULL),
(4, 'strakova', '2007-01-10', '2007-01-11', 'odeslana', 'prevodem', 'rozvoz', NULL),
(5, 'krec', '2007-01-30', '2007-02-02', 'odeslana', 'hotove', 'cp', NULL),
(6, 'krec', '2007-01-30', '2007-04-02', 'odeslana', 'prevodem', 'rozvoz', 'zasilku mi prosim dodejte v dopolednich hodinach'),
(7, 'krec', '2007-04-15', '2007-04-15', 'odeslana', 'prevodem', 'osobne', NULL),
(8, 'bohus', '2007-05-15', '2007-05-17', 'odeslana', 'hotove', 'osobne', NULL),
(9, 'krec', '2007-05-16', '2007-05-16', 'odeslana', 'prevodem', 'osobne', NULL),
(10, 'novota', '2007-08-23', '2007-08-25', 'odeslana', 'dobirka', 'ppl', NULL),
(11, 'krec', '2007-10-02', '2007-12-02', 'odeslana', 'hotove', 'cp', NULL),
(12, 'bohus', '2007-10-10', '2007-10-10', 'odeslana', 'dobirka', 'cp', NULL),
(13, 'bohus', '2007-12-02', '2008-02-13', 'odeslana', 'hotove', 'rozvoz', NULL),
(14, 'masin', '2008-01-06', '2008-01-07', 'odeslana', 'prevodem', 'ppl', NULL),
(15, 'novota', '2008-02-02', '2008-02-13', 'odeslana', 'prevodem', 'rozvoz', 'Prosim o dodani ve vecernich hodinach'),
(16, 'bohus', '2008-02-03', '2008-02-04', 'odeslana', 'hotove', 'rozvoz', NULL),
(17, 'masin', '2008-02-13', '2008-02-15', 'odeslana', 'dobirka', 'cp', NULL),
(18, 'masin', '2008-04-17', '2008-04-19', 'odeslana', 'dobirka', 'ppl', NULL),
(19, 'vencka', '2008-05-13', '2008-05-16', 'odeslana', 'dobirka', 'cp', NULL),
(20, 'novotny', '2008-09-24', '2009-01-26', 'odeslana', 'hotove', 'osobne', NULL),
(21, 'masin', '2008-10-10', '2008-11-10', 'odeslana', 'prevodem', 'osobne', NULL),
(22, 'novota', '2008-10-15', '2008-10-16', 'odeslana', 'prevodem', 'ppl', NULL),
(23, 'novota', '2008-11-17', '2008-11-21', 'odeslana', 'hotove', 'rozvoz', NULL),
(24, 'novota', '2008-12-01', '2009-01-14', 'odeslana', 'prevodem', 'ppl', NULL),
(25, 'janouskova', '2008-12-12', '2009-01-15', 'odeslana', 'hotove', 'osobne', NULL),
(26, 'abraham', '2008-12-23', '2009-01-29', 'odeslana', 'dobirka', 'cp', NULL),
(27, 'rubek', '2009-01-02', NULL, 'vyrizuje se', 'prevodem', 'rozvoz', NULL),
(28, 'skocka', '2009-06-10', '2009-06-01', 'odeslana', 'prevodem', 'ppl', NULL),
(29, 'strakova', '2009-06-01', NULL, 'prijata', 'dobirka', 'cp', NULL),
(30, 'bohus', '2009-06-30', NULL, 'vyrizuje se', 'hotove', 'rozvoz', NULL);

-- --------------------------------------------------------

--
-- Struktura tabulky `tbl_pol`
--

CREATE TABLE IF NOT EXISTS `tbl_pol` (
  `ciso` int(11) NOT NULL COMMENT 'cislo objednavky (odkazuje do tbl_obj.ciso)',
  `kod` int(11) NOT NULL COMMENT 'kod zbozi (odkazuje do tbl_zbo.kod)',
  `mnoz` float NOT NULL COMMENT 'mnozstvi daneho zbozi v objednavce',
  KEY `kod` (`kod`),
  KEY `ciso` (`ciso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tabulka polozek v jednotlivych objednavkach';

--
-- Vypisuji data pro tabulku `tbl_pol`
--

INSERT INTO `tbl_pol` (`ciso`, `kod`, `mnoz`) VALUES
(1, 1000, 4),
(1, 1007, 10),
(1, 1010, 5),
(1, 1014, 3),
(1, 1019, 3),
(1, 1020, 1),
(1, 1021, 2),
(1, 1023, 0.5),
(1, 1024, 10),
(1, 1025, 5),
(1, 1026, 5),
(2, 1009, 6),
(2, 1015, 10),
(2, 1017, 1),
(2, 1022, 1),
(2, 1024, 2),
(3, 1000, 5),
(3, 1008, 2),
(3, 1015, 20),
(3, 1017, 1),
(4, 1009, 2),
(4, 1019, 1),
(6, 1004, 2),
(6, 1005, 1),
(6, 1006, 4),
(7, 1016, 50),
(8, 1017, 1),
(9, 1009, 1),
(10, 1009, 6),
(10, 1016, 1),
(11, 1000, 10),
(11, 1001, 10),
(11, 1002, 5),
(11, 1003, 10),
(12, 1011, 1),
(12, 1021, 0.5),
(12, 1026, 1),
(13, 1011, 2),
(13, 1017, 2),
(13, 1021, 2),
(14, 1000, 20),
(14, 1004, 2),
(15, 1007, 1),
(15, 1016, 2),
(15, 1018, 10),
(15, 1021, 1),
(15, 1025, 4),
(16, 1010, 5),
(16, 1022, 2),
(17, 1002, 4),
(18, 1005, 2),
(18, 1006, 2),
(19, 1008, 20),
(20, 1015, 10),
(20, 1017, 1),
(20, 1018, 6),
(20, 1024, 1),
(21, 1003, 2),
(21, 1013, 6),
(21, 1019, 1),
(21, 1025, 2),
(22, 1000, 10),
(22, 1024, 2),
(22, 1026, 1),
(23, 1013, 1),
(23, 1020, 1),
(24, 1005, 1),
(25, 1002, 30),
(26, 1006, 1),
(27, 1008, 3),
(27, 1018, 10),
(27, 1026, 1),
(28, 1003, 6),
(28, 1015, 20),
(28, 1017, 1),
(28, 1025, 4),
(29, 1016, 2),
(29, 1017, 1),
(29, 1024, 2),
(30, 1016, 2),
(30, 1017, 1),
(30, 1020, 20);

-- --------------------------------------------------------

--
-- Struktura tabulky `tbl_zak`
--

CREATE TABLE IF NOT EXISTS `tbl_zak` (
  `login` varchar(20) NOT NULL COMMENT 'login zakaznika',
  `jmeno` varchar(30) NOT NULL COMMENT 'jmeno zakaznika',
  `prijmeni` varchar(50) NOT NULL COMMENT 'prijmeni zakaznika',
  `ulice` varchar(100) NOT NULL COMMENT 'kontaktni adresa - ulice',
  `psc` int(11) NOT NULL COMMENT 'kontaktni adresa - postovni smerovaci cislo',
  `mesto` varchar(30) NOT NULL COMMENT 'kontaktni adresa - mesto',
  `email` varchar(100) NOT NULL COMMENT 'kontaktni email zakaznika',
  PRIMARY KEY (`login`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tabulka zakazniku';

--
-- Vypisuji data pro tabulku `tbl_zak`
--

INSERT INTO `tbl_zak` (`login`, `jmeno`, `prijmeni`, `ulice`, `psc`, `mesto`, `email`) VALUES
('abraham', 'Karel', 'Abrahamek', 'Smetanova 70', 27351, 'Unhost', 'abraham@centrum.cz'),
('bohus', 'Bohuslav', 'Rejholec', 'Laudova 1014', 16300, 'Praha 6 - Repy', 'rejholec@gmail.com'),
('ilja', 'Ilja', 'Novak', 'Vokrojova 3384', 14300, 'Praha', 'ilja-novak@seznam.cz'),
('janouskova', 'Denisa', 'Janouskova', 'Dvorakova 645', 60200, 'Brno', 'xjand05@vse.cz'),
('krec', 'Tomas', 'Krec', 'M. Pujmannove 286', 54101, 'Trutnov', 'krecek@seznam.cz'),
('masin', 'Frantisek', 'Masin', 'Puskinova 591', 68201, 'Vyskov', 'franta.masin@seznam.cz'),
('novota', 'Blanka', 'Novotna', 'Mirove namesti 55', 55001, 'Broumov', 'novota@atlas.cz'),
('novotny', 'Antonin', 'Novotny', 'Havlickova 139', 35103, 'Velka Hledsebe', 'nov.ant@seznam.cz'),
('rubek', 'Jiri', 'Rubek', 'Janosikova 709', 64300, 'Brno - Chrlice', 'rubi@seznam.cz'),
('skocka', 'Zdena', 'Skocdopolova', 'Vokrojova 3378', 14300, 'Praha 4 - Modrany', 'skocdopolova@centrum.cz'),
('strakova', 'Miluse', 'Strakova', 'Zehunska 843', 19800, 'Praha 9 - Kyje', 'strakova.miluse@seznam.cz'),
('vencka', 'Tatana', 'Vencova', 'Ovenecka 953', 17000, 'Praha 7 - Bubenec', 'vencova@centrum.cz');

-- --------------------------------------------------------

--
-- Struktura tabulky `tbl_zbo`
--

CREATE TABLE IF NOT EXISTS `tbl_zbo` (
  `kod` int(11) NOT NULL AUTO_INCREMENT COMMENT 'kod zbozi',
  `kat` varchar(5) NOT NULL COMMENT 'kod kategorie (odkazuje do tbl_kat.kat)',
  `naz` varchar(30) NOT NULL COMMENT 'nazev zbozi',
  `pop` varchar(50) DEFAULT NULL COMMENT 'popis zbozi',
  `jcen` float NOT NULL COMMENT 'jednotkova cena',
  `jedn` enum('lahev 0.5l','lahev 0.75l','lahev 1.5l','lahev 2l','ks','kg') NOT NULL COMMENT 'merna jednotka',
  `sklad` int(11) NOT NULL COMMENT 'jednotky na sklade',
  `dost` int(11) NOT NULL COMMENT 'dostupnost dnu',
  PRIMARY KEY (`kod`),
  KEY `kat` (`kat`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1027 ;

--
-- Vypisuji data pro tabulku `tbl_zbo`
--

INSERT INTO `tbl_zbo` (`kod`, `kat`, `naz`, `pop`, `jcen`, `jedn`, `sklad`, `dost`) VALUES
(1000, 'pivo', 'Branik', 'svetle pivo ve skle', 11, 'lahev 0.5l', 100, 0),
(1001, 'pivo', 'Budejovicky Budvar', 'svetly lezak ve skle', 20, 'lahev 0.5l', 250, 0),
(1002, 'pivo', 'Gambrinus svetly', 'svetle pivo ve skle', 15, 'lahev 0.5l', 200, 0),
(1003, 'pivo', 'Staropramen', 'svetle pivo ve skle', 12.5, 'lahev 0.5l', 0, 1),
(1004, 'vino', 'Frankovka', 'suche vino', 65, 'lahev 0.75l', 10, 0),
(1005, 'vino', 'Modry Portugal', NULL, 86.5, 'lahev 0.75l', 1, 0),
(1006, 'vino', 'Svatovavrinecke', 'suche vino', 56, 'lahev 0.75l', 0, 3),
(1007, 'minVo', 'Mattoni broskev', 'mineralni voda s prichuti broskve', 15, 'lahev 1.5l', 20, 0),
(1008, 'minVo', 'Mattoni', 'mineralni voda bez prichuti', 13, 'lahev 1.5l', 120, 0),
(1009, 'minVo', 'Podebradka', 'mineralni voda bez prichuti', 10, 'lahev 1.5l', 82, 0),
(1010, 'limo', '7UP', NULL, 33, 'lahev 2l', 30, 0),
(1011, 'limo', 'Coca-cola', NULL, 36, 'lahev 2l', 80, 0),
(1012, 'limo', 'Fanta divoka malina', 'limonada s prichuti divoke maliny', 33, 'lahev 2l', 20, 0),
(1013, 'limo', 'Fanta pomeranc', 'limonada s prichuti pomerance', 33, 'lahev 2l', 42, 0),
(1014, 'limo', 'Fanta lemonic', 'limonada s prichuti lemonic', 33, 'lahev 2l', 0, 0),
(1015, 'pec', 'rohlik', NULL, 3, 'ks', 150, 0),
(1016, 'pec', 'toustovy chleb', NULL, 34, 'kg', 20, 0),
(1017, 'pec', 'chleb', NULL, 25, 'kg', 15, 0),
(1018, 'pec', 'houska', NULL, 3.5, 'ks', 110, 0),
(1019, 'ovze', 'banan', NULL, 43.5, 'kg', 20, 0),
(1020, 'ovze', 'citron', NULL, 28, 'kg', 2, 0),
(1021, 'ovze', 'jablko cervene', 'cervene jablko', 30, 'kg', 10, 0),
(1022, 'ovze', 'jablko zelene', 'zelene jablko', 32, 'kg', 5, 0),
(1023, 'ovze', 'mango', NULL, 75, 'kg', 0, 0),
(1024, 'ovze', 'brambory', NULL, 13, 'kg', 25, 0),
(1025, 'ovze', 'okurka', 'salatova okurka', 17.5, 'ks', 0, 1),
(1026, 'ovze', 'rajska jablka', NULL, 44.5, 'kg', 2, 0);

--
-- Omezení pro exportované tabulky
--

--
-- Omezení pro tabulku `tbl_kat`
--
ALTER TABLE `tbl_kat`
  ADD CONSTRAINT `tbl_kat_ibfk_1` FOREIGN KEY (`nadk`) REFERENCES `tbl_kat` (`kat`) ON UPDATE CASCADE;

--
-- Omezení pro tabulku `tbl_obj`
--
ALTER TABLE `tbl_obj`
  ADD CONSTRAINT `tbl_obj_ibfk_1` FOREIGN KEY (`zak`) REFERENCES `tbl_zak` (`login`) ON UPDATE CASCADE;

--
-- Omezení pro tabulku `tbl_pol`
--
ALTER TABLE `tbl_pol`
  ADD CONSTRAINT `tbl_pol_ibfk_1` FOREIGN KEY (`ciso`) REFERENCES `tbl_obj` (`ciso`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tbl_pol_ibfk_2` FOREIGN KEY (`kod`) REFERENCES `tbl_zbo` (`kod`) ON UPDATE CASCADE;

--
-- Omezení pro tabulku `tbl_zbo`
--
ALTER TABLE `tbl_zbo`
  ADD CONSTRAINT `tbl_zbo_ibfk_1` FOREIGN KEY (`kat`) REFERENCES `tbl_kat` (`kat`) ON UPDATE CASCADE;