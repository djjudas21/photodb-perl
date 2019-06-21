SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_display_lens` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL,
  `camera_id` tinyint NOT NULL,
  `mount_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `choose_display_lens`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `choose_display_lens` AS select `LENS`.`lens_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`LENSMODEL`.`model`,if(`LENS`.`serial`,concat(' (#',`LENS`.`serial`,')'),'')) AS `opt`,`CAMERA`.`camera_id` AS `camera_id`,`LENSMODEL`.`mount_id` AS `mount_id` from (((`LENS` join `LENSMODEL` on(`LENS`.`lensmodel_id` = `LENSMODEL`.`lensmodel_id`)) left join `CAMERA` on(`LENS`.`lens_id` = `CAMERA`.`display_lens`)) join `MANUFACTURER` on(`LENSMODEL`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`)) where `LENSMODEL`.`mount_id` is not null and `LENS`.`own` = 1 order by concat(`MANUFACTURER`.`manufacturer`,' ',`LENSMODEL`.`model`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
