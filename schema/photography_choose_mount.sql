SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_mount` (
  `mount_id` tinyint NOT NULL,
  `mount` tinyint NOT NULL,
  `purpose` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `choose_mount`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_mount` AS select `MOUNT`.`mount_id` AS `mount_id`,ifnull(concat(`MANUFACTURER`.`manufacturer`,' ',`MOUNT`.`mount`),`MOUNT`.`mount`) AS `mount`,`MOUNT`.`purpose` AS `purpose` from (`MOUNT` left join `MANUFACTURER` on((`MOUNT`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`))) order by ifnull(concat(`MANUFACTURER`.`manufacturer`,' ',`MOUNT`.`mount`),`MOUNT`.`mount`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
