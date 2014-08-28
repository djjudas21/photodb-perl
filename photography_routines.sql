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
-- Temporary table structure for view `FILM_WITH_FS`
--

DROP TABLE IF EXISTS `FILM_WITH_FS`;
/*!50001 DROP VIEW IF EXISTS `FILM_WITH_FS`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `FILM_WITH_FS` (
  `film_id` tinyint NOT NULL,
  `cameramodel` tinyint NOT NULL,
  `ISO` tinyint NOT NULL,
  `date` tinyint NOT NULL,
  `notes` tinyint NOT NULL,
  `filmstockname` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `NEGATIVE_WITH_LM`
--

DROP TABLE IF EXISTS `NEGATIVE_WITH_LM`;
/*!50001 DROP VIEW IF EXISTS `NEGATIVE_WITH_LM`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `NEGATIVE_WITH_LM` (
  `LensType` tinyint NOT NULL,
  `shutter_speed` tinyint NOT NULL,
  `aperture` tinyint NOT NULL,
  `frame` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `negative_id` tinyint NOT NULL,
  `film_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `negatives`
--

DROP TABLE IF EXISTS `negatives`;
/*!50001 DROP VIEW IF EXISTS `negatives`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `negatives` (
  `film_id` tinyint NOT NULL,
  `negative_id` tinyint NOT NULL,
  `date` tinyint NOT NULL,
  `notes` tinyint NOT NULL,
  `frame` tinyint NOT NULL,
  `description` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `FILM_WITH_FS`
--

/*!50001 DROP TABLE IF EXISTS `FILM_WITH_FS`*/;
/*!50001 DROP VIEW IF EXISTS `FILM_WITH_FS`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `FILM_WITH_FS` AS select `f`.`film_id` AS `film_id`,concat(`cm`.`manufacturer`,' ',`c`.`model`) AS `cameramodel`,`fs`.`iso` AS `ISO`,`f`.`date` AS `date`,`f`.`notes` AS `notes`,concat(`fsm`.`manufacturer`,' ',`fs`.`name`) AS `filmstockname` from ((((`FILMSTOCK` `fs` join `FILM` `f` on((`fs`.`filmstock_id` = `f`.`filmstock_id`))) join `MANUFACTURER` `fsm` on((`fs`.`manufacturer_id` = `fsm`.`manufacturer_id`))) join `CAMERA` `c` on((`f`.`camera_id` = `c`.`camera_id`))) join `MANUFACTURER` `cm` on((`c`.`manufacturer_id` = `cm`.`manufacturer_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `NEGATIVE_WITH_LM`
--

/*!50001 DROP TABLE IF EXISTS `NEGATIVE_WITH_LM`*/;
/*!50001 DROP VIEW IF EXISTS `NEGATIVE_WITH_LM`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `NEGATIVE_WITH_LM` AS select concat(`lm`.`manufacturer`,' ',`l`.`model`) AS `LensType`,`n`.`shutter_speed` AS `shutter_speed`,`n`.`aperture` AS `aperture`,`n`.`frame` AS `frame`,`n`.`description` AS `description`,`n`.`negative_id` AS `negative_id`,`n`.`film_id` AS `film_id` from (((`NEGATIVE` `n` join `FILM` `f` on((`n`.`film_id` = `f`.`film_id`))) left join `LENS` `l` on((`n`.`lens_id` = `l`.`lens_id`))) left join `MANUFACTURER` `lm` on((`l`.`manufacturer_id` = `lm`.`manufacturer_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `negatives`
--

/*!50001 DROP TABLE IF EXISTS `negatives`*/;
/*!50001 DROP VIEW IF EXISTS `negatives`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `negatives` AS select `FILM`.`film_id` AS `film_id`,`NEGATIVE`.`negative_id` AS `negative_id`,`FILM`.`date` AS `date`,`FILM`.`notes` AS `notes`,`NEGATIVE`.`frame` AS `frame`,`NEGATIVE`.`description` AS `description` from (`NEGATIVE` join `FILM`) where (`NEGATIVE`.`film_id` = `FILM`.`film_id`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping routines for database 'photography'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-08-28 23:32:26
