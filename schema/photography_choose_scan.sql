SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_scan` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `choose_scan`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_scan` AS select `SCAN`.`scan_id` AS `id`,ifnull(concat('Negative ',`NEGATIVE`.`film_id`,'/',`NEGATIVE`.`frame`,ifnull(concat(' ',`NEGATIVE`.`description`),'')),concat('Print #',`PRINT`.`print_id`,' ',`PRINTNEG`.`description`)) AS `opt` from (((`SCAN` left join `NEGATIVE` on((`SCAN`.`negative_id` = `NEGATIVE`.`negative_id`))) left join `PRINT` on((`SCAN`.`print_id` = `PRINT`.`print_id`))) left join `NEGATIVE` `PRINTNEG` on((`PRINT`.`negative_id` = `PRINTNEG`.`negative_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
