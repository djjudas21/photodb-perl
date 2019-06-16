SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `report_never_used_lenses` (
  `Lens` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `report_never_used_lenses`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`photography`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `report_never_used_lenses` AS select concat('#',`LENS`.`lens_id`,' ',`MANUFACTURER`.`manufacturer`,' ',`LENSMODEL`.`model`) AS `Lens` from ((((`LENS` join `LENSMODEL` on(`LENS`.`lensmodel_id` = `LENSMODEL`.`lensmodel_id`)) join `MANUFACTURER` on(`LENSMODEL`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`)) join `MOUNT` on(`LENSMODEL`.`mount_id` = `MOUNT`.`mount_id`)) left join `NEGATIVE` on(`NEGATIVE`.`lens_id` = `LENS`.`lens_id`)) where `LENSMODEL`.`fixed_mount` = 0 and `MOUNT`.`purpose` = 'Camera' and `MOUNT`.`digital_only` = 0 and `LENS`.`own` = 1 and `NEGATIVE`.`negative_id` is null order by `LENS`.`lens_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
