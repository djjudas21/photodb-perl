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
/*!50001 DROP TABLE IF EXISTS `negatives`*/;
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
