SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_accessory` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `choose_accessory`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_accessory` AS select `ACCESSORY`.`accessory_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`ACCESSORY`.`model`,' (',`ACCESSORY_TYPE`.`accessory_type`,')') AS `opt` from ((`ACCESSORY` join `MANUFACTURER`) join `ACCESSORY_TYPE`) where ((`ACCESSORY`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`) and (`ACCESSORY`.`accessory_type_id` = `ACCESSORY_TYPE`.`accessory_type_id`) and isnull(`ACCESSORY`.`lost`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
