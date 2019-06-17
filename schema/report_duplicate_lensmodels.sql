SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `report_duplicate_lensmodels` (
  `Lens Model ID` tinyint NOT NULL,
  `Lens` tinyint NOT NULL,
  `Mount` tinyint NOT NULL,
  `Introduced` tinyint NOT NULL,
  `Notes` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `report_duplicate_lensmodels`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `report_duplicate_lensmodels` AS select `LENSMODEL`.`lensmodel_id` AS `Lens Model ID`,concat(`MANUFACTURER`.`manufacturer`,' ',`LENSMODEL`.`model`) AS `Lens`,`MOUNT`.`mount` AS `Mount`,`LENSMODEL`.`introduced` AS `Introduced`,`LENSMODEL`.`notes` AS `Notes` from ((`LENSMODEL` join `MANUFACTURER` on(`LENSMODEL`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`)) left join `MOUNT` on(`LENSMODEL`.`mount_id` = `MOUNT`.`mount_id`)) where `LENSMODEL`.`model` in (select `LENSMODEL`.`model` from `LENSMODEL` group by `LENSMODEL`.`model` having count(`LENSMODEL`.`model`) > 1) order by `LENSMODEL`.`model` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
