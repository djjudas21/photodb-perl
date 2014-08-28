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
-- Table structure for table `MOUNT`
--

DROP TABLE IF EXISTS `MOUNT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MOUNT` (
  `mount_id` int(11) NOT NULL AUTO_INCREMENT,
  `mount` varchar(45) DEFAULT NULL,
  `fixed` tinyint(1) DEFAULT NULL,
  `shutter_in_lens` tinyint(1) DEFAULT NULL,
  `type` varchar(25) DEFAULT NULL,
  `purpose` varchar(25) DEFAULT NULL,
  `notes` varchar(45) DEFAULT NULL,
  `digital_only` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`mount_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MOUNT`
--

LOCK TABLES `MOUNT` WRITE;
/*!40000 ALTER TABLE `MOUNT` DISABLE KEYS */;
INSERT INTO `MOUNT` VALUES (1,'EF',0,0,'Bayonet','Camera','EF cameras can not take EF-S lenses',0),(2,'EF-S',0,0,'Bayonet','Camera','EF cameras can not take EF-S lenses',1),(3,'M39 Rangefinder',0,0,'Screw','Camera','Has focus flange',0),(4,'OM',0,0,'Bayonet','Camera',NULL,0),(5,'Mamiya RB',0,1,'Bayonet','Camera',NULL,0),(6,'FD',0,0,'Bayonet','Camera',NULL,0),(17,'lensboard',0,1,'Lens board','Camera',NULL,0),(19,'M42',0,0,'Screw','Camera',NULL,0),(22,'T',0,0,'Screw','Camera',NULL,0),(23,'Mamiya C',0,1,'Lens board','Camera',NULL,0),(24,'M39 Enlarger',0,0,'Screw','Enlarger','No focus flange',0),(25,'P',0,0,'Screw','Projector','~62mm diameter',0),(26,'P2',0,0,'Screw','Projector','~46mm diameter',0),(27,NULL,0,0,'Screw','Projector','~42.5mm diameter',0),(28,'1.25\"',0,0,'Friction fit','Telescope',NULL,0),(29,'Hole-On EX',0,1,'Bayonet','Camera',NULL,0),(30,'64mm Enlarger',0,0,'Screw','Enlarger',NULL,0),(31,'M25 Enlarger',0,0,'Screw','Enlarger',NULL,0),(32,'FL',0,0,'Bayonet','Camera','Semi-compatible with FD',0),(33,'EX',0,0,'Screw','Camera','Fixed rear group',0),(34,'M41',0,0,'Screw','Camera','Scientific',0);
/*!40000 ALTER TABLE `MOUNT` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-08-28 23:24:12
