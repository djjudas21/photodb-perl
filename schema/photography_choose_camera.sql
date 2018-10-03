SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_camera` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL,
  `mount_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `choose_camera`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_camera` AS select `CAMERA`.`camera_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERA`.`model`) AS `opt`,`CAMERA`.`mount_id` AS `mount_id` from (`CAMERA` join `MANUFACTURER`) where ((`CAMERA`.`own` = 1) and (`CAMERA`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`)) order by concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERA`.`model`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
