SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_flash_protocol` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `choose_flash_protocol`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_flash_protocol` AS select `FLASH_PROTOCOL`.`flash_protocol_id` AS `id`,if((isnull(`MANUFACTURER`.`manufacturer_id`) or (`MANUFACTURER`.`manufacturer` = 'Unknown')),`FLASH_PROTOCOL`.`name`,concat(`MANUFACTURER`.`manufacturer`,' ',`FLASH_PROTOCOL`.`name`)) AS `opt` from (`FLASH_PROTOCOL` left join `MANUFACTURER` on((`MANUFACTURER`.`manufacturer_id` = `FLASH_PROTOCOL`.`manufacturer_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
