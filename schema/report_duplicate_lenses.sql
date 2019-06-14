SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `report_duplicate_lenses` (
  `Qty` tinyint NOT NULL,
  `Lens model` tinyint NOT NULL,
  `Lens IDs` tinyint NOT NULL,
  `Serial numbers` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `report_duplicate_lenses`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `report_duplicate_lenses` AS select count(`LENS`.`lens_id`) AS `Qty`,concat(`MANUFACTURER`.`manufacturer`,' ',`LENSMODEL`.`model`) AS `Lens model`,group_concat(distinct `LENS`.`lens_id` separator ', ') AS `Lens IDs`,group_concat(distinct `LENS`.`serial` separator ', ') AS `Serial numbers` from ((`LENS` join `LENSMODEL` on(`LENS`.`lensmodel_id` = `LENSMODEL`.`lensmodel_id`)) join `MANUFACTURER` on(`LENSMODEL`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`)) where `LENS`.`own` = 1 group by `LENS`.`lensmodel_id` having count(`LENS`.`lens_id`) > 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
