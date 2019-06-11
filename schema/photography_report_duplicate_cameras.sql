SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `report_duplicate_cameras` (
  `Qty` tinyint NOT NULL,
  `Camera model` tinyint NOT NULL,
  `Camera IDs` tinyint NOT NULL,
  `Serial numbers` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `report_duplicate_cameras`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `report_duplicate_cameras` AS select count(`CAMERA`.`camera_id`) AS `Qty`,concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERAMODEL`.`model`) AS `Camera model`,group_concat(distinct `CAMERA`.`camera_id` separator ', ') AS `Camera IDs`,group_concat(distinct `CAMERA`.`serial` separator ', ') AS `Serial numbers` from ((`CAMERA` join `CAMERAMODEL` on(`CAMERA`.`cameramodel_id` = `CAMERAMODEL`.`cameramodel_id`)) join `MANUFACTURER` on(`CAMERAMODEL`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`)) where `CAMERA`.`own` = 1 group by `CAMERA`.`cameramodel_id` having count(`CAMERA`.`camera_id`) > 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
