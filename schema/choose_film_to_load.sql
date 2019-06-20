SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_film_to_load` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `choose_film_to_load`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_film_to_load` AS select `FILM`.`film_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`FILMSTOCK`.`name`,' (',`FORMAT`.`format`,' format, ',if(`FILMSTOCK`.`colour`,'colour','B&W'),')') AS `opt` from (((`FILM` join `FILMSTOCK`) join `FORMAT`) join `MANUFACTURER`) where `FILM`.`camera_id` is null and `FILM`.`date` is null and `FILM`.`filmstock_id` = `FILMSTOCK`.`filmstock_id` and `FILM`.`format_id` = `FORMAT`.`format_id` and `FILMSTOCK`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
