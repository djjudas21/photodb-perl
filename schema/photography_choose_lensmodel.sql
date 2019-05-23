SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_lensmodel` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL,
  `mount_id` tinyint NOT NULL,
  `manufacturer_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `choose_lensmodel`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`photography`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_lensmodel` AS select `LENSMODEL`.`lensmodel_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`LENSMODEL`.`model`) AS `opt`,`LENSMODEL`.`mount_id` AS `mount_id`,`MANUFACTURER`.`manufacturer_id` AS `manufacturer_id` from (`LENSMODEL` join `MANUFACTURER` on(`LENSMODEL`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`)) order by concat(`MANUFACTURER`.`manufacturer`,' ',`LENSMODEL`.`model`) collate utf8mb4_general_ci */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
