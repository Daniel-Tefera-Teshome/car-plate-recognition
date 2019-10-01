-- phpMyAdmin SQL Dump
-- version 3.3.9
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 20, 2013 at 07:55 AM
-- Server version: 5.5.8
-- PHP Version: 5.3.5

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `ethiocarplate`
--

-- --------------------------------------------------------

--
-- Table structure for table `plate_features`
--

CREATE TABLE IF NOT EXISTS `plate_features` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `cf1` double NOT NULL,
  `cf2` double NOT NULL,
  `cf3` double NOT NULL,
  `cf4` double NOT NULL,
  `cf5` double NOT NULL,
  `cf6` double NOT NULL,
  `tf1` double NOT NULL,
  `tf2` double NOT NULL,
  `tf3` double NOT NULL,
  `tf4` double NOT NULL,
  `tf5` double NOT NULL,
  `tf6` double NOT NULL,
  `gf1` double NOT NULL,
  `gf2` double NOT NULL,
  `gf3` double NOT NULL,
  `gf4` double NOT NULL,
  `gf5` double NOT NULL,
  `gf6` double NOT NULL,
  `gf7` double NOT NULL,
  `class` varchar(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `plate_features`
--

INSERT INTO `plate_features` (`id`, `cf1`, `cf2`, `cf3`, `cf4`, `cf5`, `cf6`, `tf1`, `tf2`, `tf3`, `tf4`, `tf5`, `tf6`, `gf1`, `gf2`, `gf3`, `gf4`, `gf5`, `gf6`, `gf7`, `class`) VALUES
(1, 86.42115229800937, 97.21104041642272, 105.12919670301523, 0.3171901724194074, 0.22656376693984245, 0.45455701363525963, 94.88094628220136, 92.28474536123464, 0.11580505172048983, 3.433365126214235, 0.18491166373733234, 5.126951155149709, 1, 1.1547005383792517, 1.1547005383792517, 0, 0, 0, 1, 'AM'),
(2, 78.12037862135884, 84.0410701202004, 89.49060377433217, 0.4618634725119506, 0.1662269986669219, 0.3642540776385119, 82.91019624150981, 83.54096722337512, 0.0969263397954927, 7.5602062746728045, 0.04409031039202404, 6.608598418986989, 1, 1.1547005383792517, 1.1547005383792517, 0, 0, 0, 1, 'UN');
