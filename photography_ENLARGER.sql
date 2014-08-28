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
-- Table structure for table `ENLARGER`
--

DROP TABLE IF EXISTS `ENLARGER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ENLARGER` (
  `enlarger_id` int(11) NOT NULL AUTO_INCREMENT,
  `manufacturer_id` int(11) DEFAULT NULL,
  `enlarger` varchar(45) DEFAULT NULL,
  `negative_size_id` int(11) DEFAULT NULL,
  `acquired` date DEFAULT NULL,
  `lost` date DEFAULT NULL,
  `introduced` year(4) DEFAULT NULL,
  `discontinued` year(4) DEFAULT NULL,
  `cost` decimal(6,2) DEFAULT NULL,
  `lost_price` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`enlarger_id`),
  KEY `fk_ENLARGER_1` (`manufacturer_id`),
  KEY `fk_ENLARGER_2` (`negative_size_id`),
  CONSTRAINT `fk_ENLARGER_1` FOREIGN KEY (`manufacturer_id`) REFERENCES `MANUFACTURER` (`manufacturer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ENLARGER_2` FOREIGN KEY (`negative_size_id`) REFERENCES `NEGATIVE_SIZE` (`negative_size_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-08-28 23:32:26
