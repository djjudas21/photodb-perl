SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `camera_summary` (
  `camera_id` tinyint NOT NULL,
  `Camera` tinyint NOT NULL,
  `Negative size` tinyint NOT NULL,
  `Body type` tinyint NOT NULL,
  `mount_id` tinyint NOT NULL,
  `format_id` tinyint NOT NULL,
  `Focus type` tinyint NOT NULL,
  `metering` tinyint NOT NULL,
  `coupled_metering` tinyint NOT NULL,
  `Metering type` tinyint NOT NULL,
  `Weight` tinyint NOT NULL,
  `Date acquired` tinyint NOT NULL,
  `Cost` tinyint NOT NULL,
  `Manufactured between` tinyint NOT NULL,
  `Serial number` tinyint NOT NULL,
  `Datecode` tinyint NOT NULL,
  `Year of manufacture` tinyint NOT NULL,
  `Shutter type` tinyint NOT NULL,
  `shutter_model` tinyint NOT NULL,
  `cable_release` tinyint NOT NULL,
  `Viewfinder coverage` tinyint NOT NULL,
  `power_drive` tinyint NOT NULL,
  `continuous_fps` tinyint NOT NULL,
  `video` tinyint NOT NULL,
  `digital` tinyint NOT NULL,
  `fixed_mount` tinyint NOT NULL,
  `lens_id` tinyint NOT NULL,
  `Battery` tinyint NOT NULL,
  `notes` tinyint NOT NULL,
  `lost` tinyint NOT NULL,
  `lost_price` tinyint NOT NULL,
  `source` tinyint NOT NULL,
  `bulb` tinyint NOT NULL,
  `time` tinyint NOT NULL,
  `ISO range` tinyint NOT NULL,
  `Autofocus points` tinyint NOT NULL,
  `int_flash` tinyint NOT NULL,
  `int_flash_gn` tinyint NOT NULL,
  `ext_flash` tinyint NOT NULL,
  `flash_metering` tinyint NOT NULL,
  `pc_sync` tinyint NOT NULL,
  `hotshoe` tinyint NOT NULL,
  `coldshoe` tinyint NOT NULL,
  `X-sync speed` tinyint NOT NULL,
  `Meter range` tinyint NOT NULL,
  `Condition` tinyint NOT NULL,
  `Original case` tinyint NOT NULL,
  `dof_preview` tinyint NOT NULL,
  `Exposure programs` tinyint NOT NULL,
  `Metering modes` tinyint NOT NULL,
  `Shutter speeds` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `camera_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `camera_summary` AS select `CAMERA`.`camera_id` AS `camera_id`,concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERA`.`model`) AS `Camera`,`NEGATIVE_SIZE`.`negative_size` AS `Negative size`,`BODY_TYPE`.`body_type` AS `Body type`,`CAMERA`.`mount_id` AS `mount_id`,`CAMERA`.`format_id` AS `format_id`,`FOCUS_TYPE`.`focus_type` AS `Focus type`,`CAMERA`.`metering` AS `metering`,`CAMERA`.`coupled_metering` AS `coupled_metering`,`METERING_TYPE`.`metering_type_id` AS `Metering type`,concat(`CAMERA`.`weight`,'g') AS `Weight`,`CAMERA`.`acquired` AS `Date acquired`,concat('£',`CAMERA`.`cost`) AS `Cost`,concat(`CAMERA`.`introduced`,'-',`CAMERA`.`discontinued`) AS `Manufactured between`,`CAMERA`.`serial` AS `Serial number`,`CAMERA`.`datecode` AS `Datecode`,`CAMERA`.`manufactured` AS `Year of manufacture`,`SHUTTER_TYPE`.`shutter_type` AS `Shutter type`,`CAMERA`.`shutter_model` AS `shutter_model`,`CAMERA`.`cable_release` AS `cable_release`,concat(`CAMERA`.`viewfinder_coverage`,'%') AS `Viewfinder coverage`,`CAMERA`.`power_drive` AS `power_drive`,`CAMERA`.`continuous_fps` AS `continuous_fps`,`CAMERA`.`video` AS `video`,`CAMERA`.`digital` AS `digital`,`CAMERA`.`fixed_mount` AS `fixed_mount`,`CAMERA`.`lens_id` AS `lens_id`,concat(`CAMERA`.`battery_qty`,' x ',`BATTERY`.`battery_name`) AS `Battery`,`CAMERA`.`notes` AS `notes`,`CAMERA`.`lost` AS `lost`,`CAMERA`.`lost_price` AS `lost_price`,`CAMERA`.`source` AS `source`,`CAMERA`.`bulb` AS `bulb`,`CAMERA`.`time` AS `time`,concat(`CAMERA`.`min_iso`,'-',`CAMERA`.`max_iso`) AS `ISO range`,`CAMERA`.`af_points` AS `Autofocus points`,`CAMERA`.`int_flash` AS `int_flash`,`CAMERA`.`int_flash_gn` AS `int_flash_gn`,`CAMERA`.`ext_flash` AS `ext_flash`,`CAMERA`.`flash_metering` AS `flash_metering`,`CAMERA`.`pc_sync` AS `pc_sync`,`CAMERA`.`hotshoe` AS `hotshoe`,`CAMERA`.`coldshoe` AS `coldshoe`,`CAMERA`.`x_sync` AS `X-sync speed`,concat(`CAMERA`.`meter_min_ev`,'-',`CAMERA`.`meter_max_ev`) AS `Meter range`,`CONDITION`.`name` AS `Condition`,if(`CAMERA`.`oem_case`,'Yes','No') AS `Original case`,`CAMERA`.`dof_preview` AS `dof_preview`,group_concat(distinct `EXPOSURE_PROGRAM`.`exposure_program` separator ', ') AS `Exposure programs`,group_concat(distinct `METERING_MODE`.`metering_mode` separator ', ') AS `Metering modes`,group_concat(distinct `SHUTTER_SPEED_AVAILABLE`.`shutter_speed` separator ', ') AS `Shutter speeds` from (((((((((((((`CAMERA` join `MANUFACTURER`) join `NEGATIVE_SIZE`) join `BODY_TYPE`) join `BATTERY`) join `METERING_TYPE`) join `SHUTTER_TYPE`) join `CONDITION`) join `FOCUS_TYPE`) join `EXPOSURE_PROGRAM`) join `EXPOSURE_PROGRAM_AVAILABLE`) join `METERING_MODE_AVAILABLE`) join `METERING_MODE`) join `SHUTTER_SPEED_AVAILABLE`) where ((`CAMERA`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`) and (`CAMERA`.`negative_size_id` = `NEGATIVE_SIZE`.`negative_size_id`) and (`CAMERA`.`body_type_id` = `BODY_TYPE`.`body_type_id`) and (`CAMERA`.`own` = 1) and (`CAMERA`.`battery_type` = `BATTERY`.`battery_type`) and (`CAMERA`.`metering_type_id` = `METERING_TYPE`.`metering_type_id`) and (`CAMERA`.`shutter_type_id` = `SHUTTER_TYPE`.`shutter_type_id`) and (`CAMERA`.`condition_id` = `CONDITION`.`condition_id`) and (`CAMERA`.`focus_type_id` = `FOCUS_TYPE`.`focus_type_id`) and (`CAMERA`.`camera_id` = `EXPOSURE_PROGRAM_AVAILABLE`.`camera_id`) and (`EXPOSURE_PROGRAM`.`exposure_program_id` = `EXPOSURE_PROGRAM_AVAILABLE`.`exposure_program_id`) and (`CAMERA`.`camera_id` = `METERING_MODE_AVAILABLE`.`camera_id`) and (`METERING_MODE_AVAILABLE`.`metering_mode_id` = `METERING_MODE`.`metering_mode_id`) and (`CAMERA`.`camera_id` = `SHUTTER_SPEED_AVAILABLE`.`camera_id`)) group by `CAMERA`.`camera_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
