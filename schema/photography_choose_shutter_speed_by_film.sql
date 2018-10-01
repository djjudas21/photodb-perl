SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_shutter_speed_by_film` (
  `shutter_speed` tinyint NOT NULL,
  `film_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `choose_shutter_speed_by_film`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_shutter_speed_by_film` AS select `SHUTTER_SPEED`.`shutter_speed` AS `shutter_speed`,`FILM`.`film_id` AS `film_id` from (((`FILM` join `CAMERA` on((`FILM`.`camera_id` = `CAMERA`.`camera_id`))) join `SHUTTER_SPEED_AVAILABLE` on((`CAMERA`.`camera_id` = `SHUTTER_SPEED_AVAILABLE`.`camera_id`))) join `SHUTTER_SPEED` on((`SHUTTER_SPEED_AVAILABLE`.`shutter_speed` = `SHUTTER_SPEED`.`shutter_speed`))) order by `SHUTTER_SPEED`.`duration` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
