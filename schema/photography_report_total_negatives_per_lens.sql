SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `report_total_negatives_per_lens` (
  `Lens` tinyint NOT NULL,
  `Frames shot` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `report_total_negatives_per_lens`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `report_total_negatives_per_lens` AS select concat(`MANUFACTURER`.`manufacturer`,' ',`LENS`.`model`) AS `Lens`,count(`NEGATIVE`.`negative_id`) AS `Frames shot` from (((`LENS` join `NEGATIVE` on((`LENS`.`lens_id` = `NEGATIVE`.`lens_id`))) join `MANUFACTURER` on((`LENS`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`))) join `MOUNT` on((`LENS`.`mount_id` = `MOUNT`.`mount_id`))) where ((`LENS`.`fixed_mount` = 0) and (`MOUNT`.`purpose` = 'Camera')) group by `LENS`.`lens_id` order by count(`NEGATIVE`.`negative_id`) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
