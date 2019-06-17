SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `archive_contents` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL,
  `archive_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `archive_contents`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `archive_contents` AS select concat('Film #',`FILM`.`film_id`) AS `id`,`FILM`.`notes` collate utf8mb4_unicode_ci AS `opt`,`FILM`.`archive_id` AS `archive_id` from `FILM` union select concat('Print #',`PRINT`.`print_id`) AS `id`,`NEGATIVE`.`description` AS `opt`,`PRINT`.`archive_id` AS `archive_id` from (`PRINT` join `NEGATIVE`) where `PRINT`.`negative_id` = `NEGATIVE`.`negative_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
