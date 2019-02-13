SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `info_accessory` (
  `Accessory ID` tinyint NOT NULL,
  `Accessory type` tinyint NOT NULL,
  `Model` tinyint NOT NULL,
  `Acquired` tinyint NOT NULL,
  `Cost` tinyint NOT NULL,
  `Lost` tinyint NOT NULL,
  `Lost price` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `info_accessory`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `info_accessory` AS select `ACCESSORY`.`accessory_id` AS `Accessory ID`,`ACCESSORY_TYPE`.`accessory_type` AS `Accessory type`,if(`ACCESSORY`.`manufacturer_id`,concat(`MANUFACTURER`.`manufacturer`,' ',`ACCESSORY`.`model`),`ACCESSORY`.`model`) AS `Model`,`ACCESSORY`.`acquired` AS `Acquired`,`ACCESSORY`.`cost` AS `Cost`,`ACCESSORY`.`lost` AS `Lost`,`ACCESSORY`.`lost_price` AS `Lost price` from ((`ACCESSORY` left join `MANUFACTURER` on((`ACCESSORY`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`))) join `ACCESSORY_TYPE` on((`ACCESSORY_TYPE`.`accessory_type_id` = `ACCESSORY`.`accessory_type_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
