SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `enlarger_info` (
  `Enlarger ID` tinyint NOT NULL,
  `Manufacturer` tinyint NOT NULL,
  `Model` tinyint NOT NULL,
  `Negative size` tinyint NOT NULL,
  `Acquired` tinyint NOT NULL,
  `Lost` tinyint NOT NULL,
  `Introduced` tinyint NOT NULL,
  `Discontinued` tinyint NOT NULL,
  `Cost` tinyint NOT NULL,
  `Lost price` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `enlarger_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `enlarger_info` AS select `ENLARGER`.`enlarger_id` AS `Enlarger ID`,`MANUFACTURER`.`manufacturer` AS `Manufacturer`,`ENLARGER`.`enlarger` AS `Model`,`NEGATIVE_SIZE`.`negative_size` AS `Negative size`,`ENLARGER`.`acquired` AS `Acquired`,`ENLARGER`.`lost` AS `Lost`,`ENLARGER`.`introduced` AS `Introduced`,`ENLARGER`.`discontinued` AS `Discontinued`,`ENLARGER`.`cost` AS `Cost`,`ENLARGER`.`lost_price` AS `Lost price` from ((`ENLARGER` left join `NEGATIVE_SIZE` on((`ENLARGER`.`negative_size_id` = `NEGATIVE_SIZE`.`negative_size_id`))) left join `MANUFACTURER` on((`ENLARGER`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
