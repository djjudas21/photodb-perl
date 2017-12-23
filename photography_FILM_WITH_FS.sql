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
/*!50001 DROP TABLE IF EXISTS `FILM_WITH_FS`*/;
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
