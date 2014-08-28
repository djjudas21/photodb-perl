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
-- Table structure for table `CONDITION`
--

DROP TABLE IF EXISTS `CONDITION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CONDITION` (
  `condition_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(6) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `min_rating` int(11) DEFAULT NULL,
  `max_rating` int(11) DEFAULT NULL,
  `description` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`condition_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONDITION`
--

LOCK TABLES `CONDITION` WRITE;
/*!40000 ALTER TABLE `CONDITION` DISABLE KEYS */;
INSERT INTO `CONDITION` VALUES (1,'NEW','Brand new',100,100,'Never Used and sealed – All original packaging, manuals and accessories included.'),(2,'MINT','Like new',97,99,'97-99% of original condition –Basically new with very little use.  All boxes and original packaging'),(3,'EXC+','Excellent Plus',90,96,'90-96% of original condition – Lens Glass very clean – cosmetically may show very slight wear and/or signs of use but only under very close inspection.'),(4,'EXC','Excellent',84,89,'84-89% of original condition – Shows slight signs of use – Lens Glass is very clean but may have some dust which will not affect picture quality.'),(5,'GOOD','Good',75,83,'75-83% of original condition – Appears well used and may include dings, brassing, scrapes and bruises but is in fully functional condition. Glass may have cleaning marks or small scratches which won’t affect picture quality.'),(6,'FAIR','Fair',60,74,'60-74% of original condition – Appears to have been used very heavily with multiple dings, scrapes, scratches and heavy brassing. Lens Glass may have slight fungus, excessive dust and/or scratches that will likely affect picture quality.'),(7,'POOR','Poor',50,59,'Very rough looking. Multiple impressions metal, extreme finish loss and excessive brassing. Glass will have marks, fungus and/or haze which will affect picture quality'),(8,'BROKEN','Broken',0,49,'Has one or more faults');
/*!40000 ALTER TABLE `CONDITION` ENABLE KEYS */;
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
