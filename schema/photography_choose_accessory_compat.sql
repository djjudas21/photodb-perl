SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_accessory_compat` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL,
  `camera_id` tinyint NOT NULL,
  `lens_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `choose_accessory_compat`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_accessory_compat` AS select `ACCESSORY`.`accessory_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`ACCESSORY`.`model`,' (',`ACCESSORY_TYPE`.`accessory_type`,')') AS `opt`,`ACCESSORY_COMPAT`.`camera_id` AS `camera_id`,`ACCESSORY_COMPAT`.`lens_id` AS `lens_id` from (((`ACCESSORY` join `ACCESSORY_COMPAT` on((`ACCESSORY_COMPAT`.`accessory_id` = `ACCESSORY`.`accessory_id`))) join `ACCESSORY_TYPE` on((`ACCESSORY`.`accessory_type_id` = `ACCESSORY_TYPE`.`accessory_type_id`))) left join `MANUFACTURER` on((`ACCESSORY`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
