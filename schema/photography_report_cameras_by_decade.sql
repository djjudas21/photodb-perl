SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `report_cameras_by_decade` (
  `Decade` tinyint NOT NULL,
  `Cameras` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `report_cameras_by_decade`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`photography`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `report_cameras_by_decade` AS select (floor((`CAMERAMODEL`.`introduced` / 10)) * 10) AS `Decade`,count(`CAMERA`.`camera_id`) AS `Cameras` from (`CAMERA` join `CAMERAMODEL` on((`CAMERA`.`cameramodel_id` = `CAMERAMODEL`.`cameramodel_id`))) where (`CAMERAMODEL`.`introduced` is not null) group by (floor((`CAMERAMODEL`.`introduced` / 10)) * 10) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
