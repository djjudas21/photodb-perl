SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `report_unscanned_negs` (
  `negative_id` tinyint NOT NULL,
  `film_id` tinyint NOT NULL,
  `frame` tinyint NOT NULL,
  `description` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `report_unscanned_negs`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `report_unscanned_negs` AS select `NEGATIVE`.`negative_id` AS `negative_id`,`NEGATIVE`.`film_id` AS `film_id`,`NEGATIVE`.`frame` AS `frame`,`NEGATIVE`.`description` AS `description` from ((`NEGATIVE` left join `SCAN` on(`NEGATIVE`.`negative_id` = `SCAN`.`negative_id`)) left join `FILM` on(`NEGATIVE`.`film_id` = `FILM`.`film_id`)) where `SCAN`.`negative_id` is null and `FILM`.`date` is not null */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
