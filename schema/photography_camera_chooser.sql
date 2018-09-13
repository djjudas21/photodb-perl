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
  `min_shutter` tinyint NOT NULL,
  `max_shutter` tinyint NOT NULL,
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
  `tripod` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `camera_chooser`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `camera_chooser` AS select `CAMERA`.`camera_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERA`.`model`) AS `opt`,`CAMERA`.`manufacturer_id` AS `manufacturer_id`,`CAMERA`.`mount_id` AS `mount_id`,`CAMERA`.`format_id` AS `format_id`,`CAMERA`.`focus_type_id` AS `focus_type_id`,`CAMERA`.`metering` AS `metering`,`CAMERA`.`coupled_metering` AS `coupled_metering`,`CAMERA`.`metering_type_id` AS `metering_type_id`,`CAMERA`.`body_type_id` AS `body_type_id`,`CAMERA`.`weight` AS `weight`,`CAMERA`.`manufactured` AS `manufactured`,`CAMERA`.`negative_size_id` AS `negative_size_id`,`CAMERA`.`shutter_type_id` AS `shutter_type_id`,`CAMERA`.`shutter_model` AS `shutter_model`,`CAMERA`.`cable_release` AS `cable_release`,`CAMERA`.`power_drive` AS `power_drive`,`CAMERA`.`continuous_fps` AS `continuous_fps`,`CAMERA`.`video` AS `video`,`CAMERA`.`digital` AS `digital`,`CAMERA`.`fixed_mount` AS `fixed_mount`,`CAMERA`.`lens_id` AS `lens_id`,`CAMERA`.`battery_qty` AS `battery_qty`,`CAMERA`.`battery_type` AS `battery_type`,`CAMERA`.`min_shutter` AS `min_shutter`,`CAMERA`.`max_shutter` AS `max_shutter`,`CAMERA`.`bulb` AS `bulb`,`CAMERA`.`time` AS `time`,`CAMERA`.`min_iso` AS `min_iso`,`CAMERA`.`max_iso` AS `max_iso`,`CAMERA`.`af_points` AS `af_points`,`CAMERA`.`int_flash` AS `int_flash`,`CAMERA`.`int_flash_gn` AS `int_flash_gn`,`CAMERA`.`ext_flash` AS `ext_flash`,`CAMERA`.`flash_metering` AS `flash_metering`,`CAMERA`.`pc_sync` AS `pc_sync`,`CAMERA`.`hotshoe` AS `hotshoe`,`CAMERA`.`coldshoe` AS `coldshoe`,`CAMERA`.`x_sync` AS `x_sync`,`CAMERA`.`meter_min_ev` AS `meter_min_ev`,`CAMERA`.`meter_max_ev` AS `meter_max_ev`,`CAMERA`.`dof_preview` AS `dof_preview`,`CAMERA`.`tripod` AS `tripod` from ((((`CAMERA` left join `MANUFACTURER` on((`CAMERA`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`))) left join `EXPOSURE_PROGRAM_AVAILABLE` on((`CAMERA`.`camera_id` = `EXPOSURE_PROGRAM_AVAILABLE`.`camera_id`))) left join `METERING_MODE_AVAILABLE` on((`CAMERA`.`camera_id` = `METERING_MODE_AVAILABLE`.`camera_id`))) left join `SHUTTER_SPEED_AVAILABLE` on((`CAMERA`.`camera_id` = `SHUTTER_SPEED_AVAILABLE`.`camera_id`))) where (`CAMERA`.`own` = 1) group by `CAMERA`.`camera_id` order by concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERA`.`model`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
