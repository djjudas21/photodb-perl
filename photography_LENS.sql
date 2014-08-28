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
-- Table structure for table `LENS`
--

DROP TABLE IF EXISTS `LENS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LENS` (
  `lens_id` int(11) NOT NULL AUTO_INCREMENT,
  `mount_id` int(11) DEFAULT NULL,
  `zoom` tinyint(1) DEFAULT NULL,
  `min_focal_length` int(11) DEFAULT NULL,
  `max_focal_length` int(11) DEFAULT NULL,
  `manufacturer_id` int(11) DEFAULT NULL,
  `model` varchar(45) DEFAULT NULL,
  `closest_focus` int(11) DEFAULT NULL,
  `max_aperture` decimal(4,1) DEFAULT NULL,
  `min_aperture` decimal(4,1) DEFAULT NULL,
  `elements` int(11) DEFAULT NULL,
  `groups` int(11) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `nominal_min_angle_diag` int(11) DEFAULT NULL COMMENT 'Nominal minimum diagonal field of view from manufacturer''s specs',
  `nominal_max_angle_diag` int(11) DEFAULT NULL COMMENT 'Nominal maximum diagonal field of view from manufacturer''s specs',
  `calc_min_angle_diag` smallint(6) DEFAULT NULL COMMENT 'Maximum horizontal field of view, calculated from focal length and film format',
  `calc_max_angle_diag` smallint(6) DEFAULT NULL COMMENT 'Minimum horizontal field of view, calculated from focal length and film format',
  `calc_min_angle_horiz` smallint(6) DEFAULT NULL,
  `calc_min_angle_vert` smallint(6) DEFAULT NULL,
  `calc_max_angle_horiz` smallint(6) DEFAULT NULL,
  `calc_max_angle_vert` smallint(6) DEFAULT NULL,
  `aperture_blades` int(11) DEFAULT NULL,
  `autofocus` tinyint(1) DEFAULT NULL,
  `filter_thread` decimal(4,1) DEFAULT NULL,
  `magnification` decimal(5,3) DEFAULT NULL,
  `url` varchar(145) DEFAULT NULL,
  `serial` varchar(45) DEFAULT NULL,
  `date_code` varchar(45) DEFAULT NULL,
  `introduced` year(4) DEFAULT NULL,
  `discontinued` year(4) DEFAULT NULL,
  `manufactured` year(4) DEFAULT NULL,
  `negative_size_id` int(11) DEFAULT NULL,
  `acquired` date DEFAULT NULL,
  `cost` decimal(6,2) DEFAULT NULL,
  `fixed_mount` tinyint(1) DEFAULT NULL,
  `notes` text,
  `own` tinyint(1) DEFAULT NULL,
  `lost` date DEFAULT NULL,
  `lost_price` decimal(6,2) DEFAULT NULL,
  `source` varchar(150) DEFAULT NULL,
  `coating` varchar(45) DEFAULT NULL,
  `hood` varchar(45) DEFAULT NULL,
  `exif_lenstype` varchar(45) DEFAULT NULL,
  `rectilinear` tinyint(1) DEFAULT NULL,
  `length` int(11) DEFAULT NULL,
  `diameter` int(11) DEFAULT NULL,
  `condition_id` int(11) DEFAULT NULL,
  `image_circle` int(11) DEFAULT NULL COMMENT 'Diameter of image circle projected by lens, in mm',
  `formula` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`lens_id`),
  KEY `fk_LENS_2` (`manufacturer_id`),
  KEY `fk_LENS_3` (`mount_id`),
  KEY `fk_LENS_4` (`negative_size_id`),
  KEY `fk_LENS_1_idx` (`condition_id`),
  CONSTRAINT `fk_LENS_1` FOREIGN KEY (`condition_id`) REFERENCES `CONDITION` (`condition_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_LENS_2` FOREIGN KEY (`manufacturer_id`) REFERENCES `MANUFACTURER` (`manufacturer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_LENS_3` FOREIGN KEY (`mount_id`) REFERENCES `MOUNT` (`mount_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_LENS_4` FOREIGN KEY (`negative_size_id`) REFERENCES `NEGATIVE_SIZE` (`negative_size_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=latin1;
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
