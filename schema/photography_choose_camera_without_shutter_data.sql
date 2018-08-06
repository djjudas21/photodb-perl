SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_camera_without_shutter_data` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `choose_camera_without_shutter_data`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_camera_without_shutter_data` AS select `CAMERA`.`camera_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERA`.`model`) AS `opt` from (`CAMERA` join `MANUFACTURER`) where ((not(`CAMERA`.`camera_id` in (select `SHUTTER_SPEED_AVAILABLE`.`camera_id` from `SHUTTER_SPEED_AVAILABLE`))) and (`CAMERA`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`) and (`CAMERA`.`own` = 1) and (`MANUFACTURER`.`manufacturer_id` <> 20)) order by concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERA`.`model`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
