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
-- Table structure for table `MANUFACTURER`
--

DROP TABLE IF EXISTS `MANUFACTURER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MANUFACTURER` (
  `manufacturer_id` int(11) NOT NULL AUTO_INCREMENT,
  `manufacturer` varchar(45) DEFAULT NULL,
  ` city` varchar(45) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  `url` varchar(45) DEFAULT NULL,
  `founded` smallint(6) DEFAULT NULL,
  `dissolved` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`manufacturer_id`),
  UNIQUE KEY `manufacturer_UNIQUE` (`manufacturer`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MANUFACTURER`
--

LOCK TABLES `MANUFACTURER` WRITE;
/*!40000 ALTER TABLE `MANUFACTURER` DISABLE KEYS */;
INSERT INTO `MANUFACTURER` VALUES (1,'Boots','Nottingham','England','http://www.boots.com/',1849,NULL),(2,'Braun','Nuremberg','Germany','http://www.braun-phototechnik.de/',1915,NULL),(3,'Canon','Tokyo','Japan','http://www.canon.com/',1937,NULL),(4,'Standard Cameras',NULL,'England',NULL,1931,NULL),(5,'Efke','Samobor','Croatia',NULL,1947,2012),(6,'Fuji','Tokyo','Japan','http://www.fujifilm.com/',1934,NULL),(7,'Halina',NULL,'China',NULL,1906,NULL),(8,'Homemade',NULL,'England',NULL,NULL,NULL),(9,'Ilford','Ilford','England','http://www.ilfordphoto.com/',1879,NULL),(10,'KMZ','Krasnogorsk','Russia','http://www.zenit-foto.ru/',1942,NULL),(11,'Kodak','Rochester','USA','http://www.kodak.com/',1892,NULL),(12,'LOMO','St. Petersburg','Russia','http://www.lomoplc.com/',1932,1914),(13,'Maco',NULL,'Germany','http://www.maco-photo.de/',NULL,NULL),(14,'Makinon','Tokyo','Japan',NULL,1967,1985),(15,'Mamiya','Tokyo','Japan','http://www.mamiyaleaf.com/',1940,NULL),(16,'Olympus','Tokyo','Japan','http://www.olympus.co.uk/',1919,NULL),(17,'Opteka',NULL,'Japan',NULL,2002,NULL),(18,'Samyang','Masan','South Korea','http://www.syopt.co.kr/',1972,NULL),(19,'Tamron','Saitama','Japan','http://www.tamron.co.jp/en/',1950,NULL),(20,'Unknown',NULL,NULL,NULL,NULL,NULL),(21,'Voigtlander','Vienna','Austria','http://www.voigtlaender.de/',1756,NULL),(23,'Tokina',NULL,'Japan','http://www.tokinalens.com/',1970,NULL),(24,'Kenko','Tokyo','Japan','http://www.kenko-tokina.co.jp/e/index.html',1928,NULL),(25,'Paragon',NULL,'Japan',NULL,NULL,NULL),(26,'Agfa','Berlin','Germany',NULL,1867,NULL),(27,'LPL',NULL,'Japan','http://www.lpl-web.co.jp/',1953,NULL),(28,'Durst',NULL,'Italy',NULL,1936,NULL),(29,'Toshikato',NULL,'Japan',NULL,NULL,NULL),(30,'Vivitar',NULL,'USA','http://www.vivitar.com/',1938,NULL),(31,'Tudor',NULL,'Japan',NULL,NULL,NULL),(32,'Rollei','Braunschweig','Germany','http://www.rollei.com/',1920,NULL),(33,'Komamura',NULL,'Japan',NULL,1933,NULL),(34,'Ensign','London','England',NULL,1903,NULL),(35,'Ross','London','England',NULL,1830,NULL),(36,'Kentmere','Kentmere','England','http://www.kentmere.co.uk/',NULL,NULL),(37,'Jessops','Leicester','England','http://www.jessops.com/',1935,NULL),(38,'Cosina','Nakano','Japan','http://www.cosina.co.jp/seihin/voigt/english/',1959,NULL),(40,'Manfrotto','Cassola','Italy','http://www.manfrotto.co.uk/',1974,NULL),(41,'Pentax','Tokyo','Japan','http://www.pentax.co.uk/',1919,NULL),(42,'Blazzeo',NULL,'China',NULL,NULL,NULL),(43,'Cobra',NULL,NULL,NULL,NULL,NULL),(44,'Sunpak',NULL,'Japan','http://www.sunpak.jp/english/',1963,NULL),(45,'Miranda',NULL,'Japan',NULL,1955,NULL),(46,'Hanimex',NULL,'Australia',NULL,1947,NULL),(47,'Ohnar',NULL,'Japan',NULL,NULL,NULL),(48,'Celestron',NULL,'USA','http://www.celestron.com/',1964,NULL),(49,'Sigma',NULL,'Japan','https://www.google.co.uk/url?sa=t&rct=j&q=&es',1961,NULL),(50,'Lancaster',NULL,'England',NULL,1835,NULL),(51,'Schneider-Kreuznach',NULL,'Germany','http://www.schneiderkreuznach.com/foto_e/foto',1913,NULL),(52,'Leitz',NULL,'Germany','http://uk.leica-camera.com/home/',1913,NULL),(53,'Aldis',NULL,'England',NULL,1901,NULL),(54,'Revelation',NULL,'Taiwan',NULL,NULL,NULL),(55,'Pentacon','Dresden','Germany','http://www.pentacon-dresden.de/',1959,NULL),(57,'Chinon','Nagano','Japan','http://www.chinon.co.jp/',1948,2004),(58,'Dollond & Newcombe',NULL,'England',NULL,NULL,NULL),(59,'Loonar Goupe',NULL,'China',NULL,NULL,NULL),(60,'Polaroid',NULL,'USA','http://www.polaroid.com/',1937,NULL),(61,'The Impossible Project','Enschede','Netherlands','https://www.the-impossible-project.com/',2008,NULL),(62,'Lomography',NULL,'Austria','http://www.lomography.com/',1992,NULL),(63,'Yongnuo',NULL,'China','http://en.yongnuo.com.cn/',NULL,NULL),(64,'Graflex',NULL,'USA','http://graflex.org/',1898,NULL),(65,'Tokyo Kogaku',NULL,'Japan','http://www.topcon.co.jp/en/index.html',1932,NULL),(66,'Linhof',NULL,'Germany','http://www.linhof.com/index-e.html',1887,NULL),(67,'De Vere',NULL,'England',NULL,NULL,NULL),(68,'Nikon','Tokyo','Japan','http://www.nikkor.com/',1932,NULL),(69,'Konica','Tokyo','Japan',NULL,1873,2003),(70,'Feinwerk Technik',NULL,'Germany',NULL,NULL,NULL),(71,'Meopta','Bratislava','Slovakia',NULL,1933,NULL),(72,'ORWO','Wolfen','Germany','http://www.filmotec.de/',NULL,NULL),(73,'Fotospeed','Corsham','England','http://www.fotospeed.com/',NULL,NULL),(74,'Shackman','London','England',NULL,NULL,NULL),(75,'Dallmeyer',NULL,'England',NULL,1860,NULL);
/*!40000 ALTER TABLE `MANUFACTURER` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-08-28 23:24:13
