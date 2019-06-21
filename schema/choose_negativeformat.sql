SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_negativeformat` (
  `format_id` tinyint NOT NULL,
  `format` tinyint NOT NULL,
  `negative_size_id` tinyint NOT NULL,
  `negative_size` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `choose_negativeformat`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `choose_negativeformat` AS select `FORMAT`.`format_id` AS `format_id`,`FORMAT`.`format` AS `format`,`NEGATIVE_SIZE`.`negative_size_id` AS `negative_size_id`,`NEGATIVE_SIZE`.`negative_size` AS `negative_size` from ((`NEGATIVEFORMAT_COMPAT` join `FORMAT` on(`NEGATIVEFORMAT_COMPAT`.`format_id` = `FORMAT`.`format_id`)) join `NEGATIVE_SIZE` on(`NEGATIVEFORMAT_COMPAT`.`negative_size_id` = `NEGATIVE_SIZE`.`negative_size_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
