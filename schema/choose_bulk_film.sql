SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_bulk_film` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `choose_bulk_film`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_bulk_film` AS select `FILM_BULK`.`film_bulk_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`FILMSTOCK`.`name`,if(`FILM_BULK`.`batch`,concat(' (',`FILM_BULK`.`batch`,')'),'')) AS `opt` from ((`FILM_BULK` join `FILMSTOCK` on(`FILM_BULK`.`filmstock_id` = `FILMSTOCK`.`filmstock_id`)) join `MANUFACTURER` on(`FILMSTOCK`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
