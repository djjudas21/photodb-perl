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
-- Table structure for table `FILM`
--

DROP TABLE IF EXISTS `FILM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FILM` (
  `film_id` int(11) NOT NULL AUTO_INCREMENT,
  `filmstock_id` int(11) DEFAULT NULL,
  `exposed_at` int(11) DEFAULT NULL COMMENT 'ISO at which the film was exposed',
  `format_id` int(11) DEFAULT NULL,
  `date_loaded` date DEFAULT NULL,
  `date` date DEFAULT NULL COMMENT 'Date added to the database',
  `camera_id` int(11) DEFAULT NULL,
  `notes` varchar(145) DEFAULT NULL,
  `frames` int(11) DEFAULT NULL COMMENT 'Expected (not actual) number of frames from the film',
  `developer_id` int(11) DEFAULT NULL,
  `directory` varchar(100) DEFAULT NULL,
  `photographer_id` int(11) DEFAULT NULL,
  `dev_uses` int(11) DEFAULT NULL COMMENT 'Previous uses of developer',
  `dev_time` time DEFAULT NULL COMMENT 'Duration of development',
  `dev_temp` decimal(3,1) DEFAULT NULL COMMENT 'Temperature of development',
  `dev_n` int(11) DEFAULT NULL,
  `development_notes` varchar(200) DEFAULT NULL,
  `film_batch` varchar(45) DEFAULT NULL,
  `film_expiry` date DEFAULT NULL,
  PRIMARY KEY (`film_id`),
  KEY `fk_filmstock_id` (`filmstock_id`),
  KEY `fk_camera_id` (`camera_id`),
  KEY `fk_format_id` (`format_id`),
  KEY `fk_FILM_1` (`developer_id`),
  KEY `fk_FILM_2_idx` (`photographer_id`),
  CONSTRAINT `fk_camera_id` FOREIGN KEY (`camera_id`) REFERENCES `CAMERA` (`camera_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_filmstock_id` FOREIGN KEY (`filmstock_id`) REFERENCES `FILMSTOCK` (`filmstock_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_FILM_1` FOREIGN KEY (`developer_id`) REFERENCES `DEVELOPER` (`developer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_FILM_2` FOREIGN KEY (`photographer_id`) REFERENCES `PHOTOGRAPHER` (`photographer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_format_id` FOREIGN KEY (`format_id`) REFERENCES `FORMAT` (`format_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=225 DEFAULT CHARSET=latin1;
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
