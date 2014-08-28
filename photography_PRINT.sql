CREATE DATABASE  IF NOT EXISTS `photography` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `photography`;
-- MySQL dump 10.14  Distrib 5.5.38-MariaDB, for Linux (x86_64)
--
-- Host: zeus.jonathangazeley.com    Database: photography
-- ------------------------------------------------------
-- Server version	5.1.73

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `PRINT`
--

DROP TABLE IF EXISTS `PRINT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PRINT` (
  `print_id` int(11) NOT NULL AUTO_INCREMENT,
  `negative_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `paper_stock_id` int(11) DEFAULT NULL,
  `height` decimal(4,1) DEFAULT NULL,
  `width` decimal(4,1) DEFAULT NULL,
  `toner_id` int(11) DEFAULT NULL,
  `toner_dilution` varchar(6) DEFAULT NULL,
  `toner_time` time DEFAULT NULL,
  `own` tinyint(1) DEFAULT NULL,
  `location` varchar(45) DEFAULT NULL,
  `enlarger_id` int(11) DEFAULT NULL,
  `lens_id` int(11) DEFAULT NULL,
  `developer_id` int(11) DEFAULT NULL,
  `aperture` decimal(3,1) DEFAULT NULL,
  `exposure_time` decimal(4,1) DEFAULT NULL,
  `development_time` int(11) DEFAULT NULL,
  `filtration_grade` decimal(2,1) DEFAULT NULL,
  `fine` tinyint(1) DEFAULT NULL,
  `notes` text,
  `filename` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`print_id`),
  KEY `fk_PRINT_1` (`paper_stock_id`),
  KEY `fk_PRINT_2` (`negative_id`),
  KEY `fk_PRINT_3` (`toner_id`),
  KEY `fk_PRINT_4` (`enlarger_id`),
  KEY `fk_PRINT_6` (`developer_id`),
  KEY `fk_PRINT_5_idx` (`lens_id`),
  CONSTRAINT `fk_PRINT_1` FOREIGN KEY (`paper_stock_id`) REFERENCES `PAPER_STOCK` (`paper_stock_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_PRINT_2` FOREIGN KEY (`negative_id`) REFERENCES `NEGATIVE` (`negative_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_PRINT_3` FOREIGN KEY (`toner_id`) REFERENCES `TONER` (`toner_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_PRINT_4` FOREIGN KEY (`enlarger_id`) REFERENCES `ENLARGER` (`enlarger_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_PRINT_5` FOREIGN KEY (`lens_id`) REFERENCES `LENS` (`lens_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_PRINT_6` FOREIGN KEY (`developer_id`) REFERENCES `DEVELOPER` (`developer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=414 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-08-28 23:32:25
