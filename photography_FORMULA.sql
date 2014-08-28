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
-- Table structure for table `FORMULA`
--

DROP TABLE IF EXISTS `FORMULA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FORMULA` (
  `formula_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `elements` int(11) DEFAULT NULL,
  `groups` int(11) DEFAULT NULL,
  `application` varchar(45) DEFAULT NULL,
  `anastigmatic` tinyint(1) DEFAULT NULL,
  `achromatic` tinyint(1) DEFAULT NULL,
  `apochromatic` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`formula_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FORMULA`
--

LOCK TABLES `FORMULA` WRITE;
/*!40000 ALTER TABLE `FORMULA` DISABLE KEYS */;
INSERT INTO `FORMULA` VALUES (1,'Tessar',4,3,'Normal',1,NULL,NULL),(2,'Biogon',6,4,'Wide angle',NULL,NULL,NULL),(3,'Plasmat',NULL,NULL,NULL,NULL,NULL,NULL),(4,'Sonnar',6,4,'Telephoto',NULL,NULL,NULL),(5,'Planar',6,4,'Normal',NULL,NULL,NULL),(6,'Meniscus',1,1,NULL,0,0,0),(7,'Petzval',4,3,'Portrait',NULL,NULL,0),(8,'Protar',NULL,NULL,NULL,1,NULL,NULL),(9,'Cooke triplet',3,3,NULL,1,NULL,0);
/*!40000 ALTER TABLE `FORMULA` ENABLE KEYS */;
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
