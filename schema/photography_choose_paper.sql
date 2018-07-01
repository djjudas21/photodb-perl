SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_paper` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `choose_paper`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_paper` AS select `PAPER_STOCK`.`paper_stock_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`PAPER_STOCK`.`name`,ifnull(concat(' (',`PAPER_STOCK`.`finish`,')'),'')) AS `opt` from (`PAPER_STOCK` join `MANUFACTURER`) where (`PAPER_STOCK`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`) order by concat(`MANUFACTURER`.`manufacturer`,' ',`PAPER_STOCK`.`name`,ifnull(concat(' (',`PAPER_STOCK`.`finish`,')'),'')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
