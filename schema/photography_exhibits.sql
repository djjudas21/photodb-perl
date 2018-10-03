SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `exhibits` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL,
  `exhibition_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `exhibits`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `exhibits` AS select `PRINT`.`print_id` AS `id`,concat(`NEGATIVE`.`description`,' (',`DISPLAYSIZE`(`PRINT`.`width`,`PRINT`.`height`),')') AS `opt`,`EXHIBIT`.`exhibition_id` AS `exhibition_id` from (((`NEGATIVE` join `PRINT` on((`PRINT`.`negative_id` = `NEGATIVE`.`negative_id`))) join `EXHIBIT` on((`EXHIBIT`.`print_id` = `PRINT`.`print_id`))) join `EXHIBITION` on((`EXHIBITION`.`exhibition_id` = `EXHIBIT`.`exhibition_id`))) order by `PRINT`.`print_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
