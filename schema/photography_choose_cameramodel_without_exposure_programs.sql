SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_cameramodel_without_exposure_programs` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `choose_cameramodel_without_exposure_programs`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`photography`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_cameramodel_without_exposure_programs` AS select `CAMERAMODEL`.`cameramodel_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERAMODEL`.`model`) AS `opt` from (`CAMERAMODEL` join `MANUFACTURER` on(`CAMERAMODEL`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`)) where !(`CAMERAMODEL`.`cameramodel_id` in (select `EXPOSURE_PROGRAM_AVAILABLE`.`cameramodel_id` from `EXPOSURE_PROGRAM_AVAILABLE`)) and `MANUFACTURER`.`manufacturer_id` <> 20 order by concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERAMODEL`.`model`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
