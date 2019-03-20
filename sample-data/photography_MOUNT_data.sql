
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

LOCK TABLES `MOUNT` WRITE;
/*!40000 ALTER TABLE `MOUNT` DISABLE KEYS */;
INSERT INTO `MOUNT` VALUES (1,'EF',0,0,'Bayonet','Camera','EF cameras can not take EF-S lenses',0,3),(2,'EF-S',0,0,'Bayonet','Camera','EF cameras can not take EF-S lenses',1,3),(3,'M39 Rangefinder',0,0,'Screw','Camera','Has focus flange',0,NULL),(4,'OM',0,0,'Bayonet','Camera',NULL,0,16),(5,'RB',0,1,'Bayonet','Camera',NULL,0,15),(6,'FD',0,0,'Bayonet','Camera',NULL,0,3),(17,'lensboard',0,1,'Lens board','Camera',NULL,0,NULL),(19,'M42',0,0,'Screw','Camera',NULL,0,NULL),(22,'T',0,0,'Screw','Camera',NULL,0,NULL),(23,'Mamiya C',0,1,'Lens board','Camera',NULL,0,NULL),(24,'M39 Enlarger',0,0,'Screw','Enlarger','No focus flange',0,NULL),(25,'P',0,0,'Screw','Projector','~62mm diameter',0,NULL),(26,'P2',0,0,'Screw','Projector','~46mm diameter',0,NULL),(27,'Projector',0,0,'Screw','Projector','~42.5mm diameter',0,NULL),(28,'1.25\"',0,0,'Friction fit','Telescope',NULL,0,NULL),(29,'Hole-On EX',0,1,'Bayonet','Camera',NULL,0,NULL),(30,'64mm Enlarger',0,0,'Screw','Enlarger',NULL,0,NULL),(31,'M25 Enlarger',0,0,'Screw','Enlarger',NULL,0,NULL),(32,'FL',0,0,'Bayonet','Camera','Semi-compatible with FD',0,3),(33,'EX',0,0,'Screw','Camera','Fixed rear group',0,3),(34,'M41',0,0,'Screw','Camera','Scientific',0,NULL),(35,'EF-M',0,0,'Bayonet','Camera','Electronically compatible with EF',1,3),(36,'M645',0,0,'Bayonet','Camera',NULL,0,15),(37,'C',0,0,'Screw','Camera',NULL,0,NULL),(38,'R',0,0,'Bayonet','Camera','Semi-compatible with FL',0,3),(39,'M39 Paxette',0,0,'Screw','Camera','Longer register than M39 LTM',0,NULL);
/*!40000 ALTER TABLE `MOUNT` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

