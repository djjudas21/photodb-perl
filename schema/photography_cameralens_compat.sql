SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `cameralens_compat` (
  `camera_id` tinyint NOT NULL,
  `camera` tinyint NOT NULL,
  `lens_id` tinyint NOT NULL,
  `lens` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `cameralens_compat`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`photography`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `cameralens_compat` AS select `CAMERA`.`camera_id` AS `camera_id`,concat(`CM`.`manufacturer`,' ',`CAMERAMODEL`.`model`) AS `camera`,`LENS`.`lens_id` AS `lens_id`,concat(`LM`.`manufacturer`,' ',`LENSMODEL`.`model`) AS `lens` from ((((((`CAMERA` join `CAMERAMODEL` on((`CAMERA`.`cameramodel_id` = `CAMERAMODEL`.`cameramodel_id`))) join `MOUNT` on((`CAMERAMODEL`.`mount_id` = `MOUNT`.`mount_id`))) join `LENSMODEL` on((`MOUNT`.`mount_id` = `LENSMODEL`.`mount_id`))) join `LENS` on((`LENSMODEL`.`lensmodel_id` = `LENS`.`lensmodel_id`))) join `MANUFACTURER` `CM` on((`CAMERAMODEL`.`manufacturer_id` = `CM`.`manufacturer_id`))) join `MANUFACTURER` `LM` on((`LENSMODEL`.`manufacturer_id` = `LM`.`manufacturer_id`))) where ((`CAMERA`.`own` = 1) and (`LENS`.`own` = 1)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
