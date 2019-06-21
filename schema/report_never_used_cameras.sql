SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `report_never_used_cameras` (
  `Camera` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `report_never_used_cameras`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `report_never_used_cameras` AS select concat('#',`CAMERA`.`camera_id`,' ',`MANUFACTURER`.`manufacturer`,' ',`CAMERAMODEL`.`model`) AS `Camera` from (((`CAMERA` left join `CAMERAMODEL` on(`CAMERA`.`cameramodel_id` = `CAMERAMODEL`.`cameramodel_id`)) left join `FILM` on(`CAMERA`.`camera_id` = `FILM`.`camera_id`)) left join `MANUFACTURER` on(`CAMERAMODEL`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`)) where `FILM`.`camera_id` is null and `CAMERA`.`own` <> 0 and `CAMERAMODEL`.`digital` = 0 and `CAMERAMODEL`.`video` = 0 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
