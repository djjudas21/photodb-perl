SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `report_duplicate_cameramodels` (
  `Camera Model ID` tinyint NOT NULL,
  `Camera` tinyint NOT NULL,
  `Mount` tinyint NOT NULL,
  `Lens` tinyint NOT NULL,
  `Format` tinyint NOT NULL,
  `Introduced` tinyint NOT NULL,
  `Notes` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `report_duplicate_cameramodels`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`photography`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `report_duplicate_cameramodels` AS select `CAMERAMODEL`.`cameramodel_id` AS `Camera Model ID`,concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERAMODEL`.`model`) AS `Camera`,`MOUNT`.`mount` AS `Mount`,`LENS`.`model` AS `Lens`,`FORMAT`.`format` AS `Format`,`CAMERAMODEL`.`introduced` AS `Introduced`,`CAMERAMODEL`.`notes` AS `Notes` from ((((`CAMERAMODEL` join `MANUFACTURER` on((`CAMERAMODEL`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`))) left join `MOUNT` on((`CAMERAMODEL`.`mount_id` = `MOUNT`.`mount_id`))) left join `FORMAT` on((`CAMERAMODEL`.`format_id` = `FORMAT`.`format_id`))) left join `LENS` on((`CAMERAMODEL`.`lens_id` = `LENS`.`lens_id`))) where `CAMERAMODEL`.`model` in (select `CAMERAMODEL`.`model` from `CAMERAMODEL` group by `CAMERAMODEL`.`model` having (count(`CAMERAMODEL`.`model`) > 1)) order by `CAMERAMODEL`.`model` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
