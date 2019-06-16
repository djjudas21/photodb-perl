SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `camera_chooser` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL,
  `manufacturer_id` tinyint NOT NULL,
  `mount_id` tinyint NOT NULL,
  `format_id` tinyint NOT NULL,
  `focus_type_id` tinyint NOT NULL,
  `metering` tinyint NOT NULL,
  `coupled_metering` tinyint NOT NULL,
  `metering_type_id` tinyint NOT NULL,
  `body_type_id` tinyint NOT NULL,
  `weight` tinyint NOT NULL,
  `manufactured` tinyint NOT NULL,
  `negative_size_id` tinyint NOT NULL,
  `shutter_type_id` tinyint NOT NULL,
  `shutter_model` tinyint NOT NULL,
  `cable_release` tinyint NOT NULL,
  `power_drive` tinyint NOT NULL,
  `continuous_fps` tinyint NOT NULL,
  `video` tinyint NOT NULL,
  `digital` tinyint NOT NULL,
  `fixed_mount` tinyint NOT NULL,
  `lens_id` tinyint NOT NULL,
  `battery_qty` tinyint NOT NULL,
  `battery_type` tinyint NOT NULL,
  `bulb` tinyint NOT NULL,
  `time` tinyint NOT NULL,
  `min_iso` tinyint NOT NULL,
  `max_iso` tinyint NOT NULL,
  `af_points` tinyint NOT NULL,
  `int_flash` tinyint NOT NULL,
  `int_flash_gn` tinyint NOT NULL,
  `ext_flash` tinyint NOT NULL,
  `flash_metering` tinyint NOT NULL,
  `pc_sync` tinyint NOT NULL,
  `hotshoe` tinyint NOT NULL,
  `coldshoe` tinyint NOT NULL,
  `x_sync` tinyint NOT NULL,
  `meter_min_ev` tinyint NOT NULL,
  `meter_max_ev` tinyint NOT NULL,
  `dof_preview` tinyint NOT NULL,
  `tripod` tinyint NOT NULL,
  `display_lens` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `camera_chooser`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`photography`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `camera_chooser` AS select `CAMERA`.`camera_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERAMODEL`.`model`) AS `opt`,`CAMERAMODEL`.`manufacturer_id` AS `manufacturer_id`,`CAMERAMODEL`.`mount_id` AS `mount_id`,`CAMERAMODEL`.`format_id` AS `format_id`,`CAMERAMODEL`.`focus_type_id` AS `focus_type_id`,`CAMERAMODEL`.`metering` AS `metering`,`CAMERAMODEL`.`coupled_metering` AS `coupled_metering`,`CAMERAMODEL`.`metering_type_id` AS `metering_type_id`,`CAMERAMODEL`.`body_type_id` AS `body_type_id`,`CAMERAMODEL`.`weight` AS `weight`,`CAMERA`.`manufactured` AS `manufactured`,`CAMERAMODEL`.`negative_size_id` AS `negative_size_id`,`CAMERAMODEL`.`shutter_type_id` AS `shutter_type_id`,`CAMERAMODEL`.`shutter_model` AS `shutter_model`,`CAMERAMODEL`.`cable_release` AS `cable_release`,`CAMERAMODEL`.`power_drive` AS `power_drive`,`CAMERAMODEL`.`continuous_fps` AS `continuous_fps`,`CAMERAMODEL`.`video` AS `video`,`CAMERAMODEL`.`digital` AS `digital`,`CAMERAMODEL`.`fixed_mount` AS `fixed_mount`,`CAMERA`.`lens_id` AS `lens_id`,`CAMERAMODEL`.`battery_qty` AS `battery_qty`,`CAMERAMODEL`.`battery_type` AS `battery_type`,`CAMERAMODEL`.`bulb` AS `bulb`,`CAMERAMODEL`.`time` AS `time`,`CAMERAMODEL`.`min_iso` AS `min_iso`,`CAMERAMODEL`.`max_iso` AS `max_iso`,`CAMERAMODEL`.`af_points` AS `af_points`,`CAMERAMODEL`.`int_flash` AS `int_flash`,`CAMERAMODEL`.`int_flash_gn` AS `int_flash_gn`,`CAMERAMODEL`.`ext_flash` AS `ext_flash`,`CAMERAMODEL`.`flash_metering` AS `flash_metering`,`CAMERAMODEL`.`pc_sync` AS `pc_sync`,`CAMERAMODEL`.`hotshoe` AS `hotshoe`,`CAMERAMODEL`.`coldshoe` AS `coldshoe`,`CAMERAMODEL`.`x_sync` AS `x_sync`,`CAMERAMODEL`.`meter_min_ev` AS `meter_min_ev`,`CAMERAMODEL`.`meter_max_ev` AS `meter_max_ev`,`CAMERAMODEL`.`dof_preview` AS `dof_preview`,`CAMERAMODEL`.`tripod` AS `tripod`,`CAMERA`.`display_lens` AS `display_lens` from (((((`CAMERA` join `CAMERAMODEL` on(`CAMERA`.`cameramodel_id` = `CAMERAMODEL`.`cameramodel_id`)) left join `MANUFACTURER` on(`CAMERAMODEL`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`)) left join `EXPOSURE_PROGRAM_AVAILABLE` on(`CAMERAMODEL`.`cameramodel_id` = `EXPOSURE_PROGRAM_AVAILABLE`.`cameramodel_id`)) left join `METERING_MODE_AVAILABLE` on(`CAMERAMODEL`.`cameramodel_id` = `METERING_MODE_AVAILABLE`.`cameramodel_id`)) left join `SHUTTER_SPEED_AVAILABLE` on(`CAMERAMODEL`.`cameramodel_id` = `SHUTTER_SPEED_AVAILABLE`.`cameramodel_id`)) where `CAMERA`.`own` = 1 group by `CAMERA`.`camera_id` order by concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERAMODEL`.`model`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
