SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `camera_summary` (
  `Camera ID` tinyint NOT NULL,
  `Camera` tinyint NOT NULL,
  `Negative size` tinyint NOT NULL,
  `Body type` tinyint NOT NULL,
  `Mount` tinyint NOT NULL,
  `Film format` tinyint NOT NULL,
  `Focus type` tinyint NOT NULL,
  `Metering` tinyint NOT NULL,
  `Coupled metering` tinyint NOT NULL,
  `Metering type` tinyint NOT NULL,
  `Weight` tinyint NOT NULL,
  `Date acquired` tinyint NOT NULL,
  `Cost` tinyint NOT NULL,
  `Manufactured between` tinyint NOT NULL,
  `Serial number` tinyint NOT NULL,
  `Datecode` tinyint NOT NULL,
  `Year of manufacture` tinyint NOT NULL,
  `Shutter type` tinyint NOT NULL,
  `Shutter model` tinyint NOT NULL,
  `Cable release` tinyint NOT NULL,
  `Viewfinder coverage` tinyint NOT NULL,
  `Power drive` tinyint NOT NULL,
  `continuous_fps` tinyint NOT NULL,
  `Video` tinyint NOT NULL,
  `Digital` tinyint NOT NULL,
  `Fixed mount` tinyint NOT NULL,
  `Lens` tinyint NOT NULL,
  `Battery` tinyint NOT NULL,
  `Notes` tinyint NOT NULL,
  `Lost` tinyint NOT NULL,
  `Lost price` tinyint NOT NULL,
  `Source` tinyint NOT NULL,
  `Bulb` tinyint NOT NULL,
  `Time` tinyint NOT NULL,
  `ISO range` tinyint NOT NULL,
  `Autofocus points` tinyint NOT NULL,
  `Internal flash` tinyint NOT NULL,
  `Internal flash guide number` tinyint NOT NULL,
  `External flash` tinyint NOT NULL,
  `Flash metering` tinyint NOT NULL,
  `PC sync socket` tinyint NOT NULL,
  `Hotshoe` tinyint NOT NULL,
  `Coldshoe` tinyint NOT NULL,
  `X-sync speed` tinyint NOT NULL,
  `Meter range` tinyint NOT NULL,
  `Condition` tinyint NOT NULL,
  `Original case` tinyint NOT NULL,
  `Depth of field preview` tinyint NOT NULL,
  `Exposure programs` tinyint NOT NULL,
  `Metering modes` tinyint NOT NULL,
  `Shutter speeds` tinyint NOT NULL,
  `Focal length` tinyint NOT NULL,
  `Maximum aperture` tinyint NOT NULL,
  `Films loaded` tinyint NOT NULL,
  `Frames shot` tinyint NOT NULL
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
/*!50001 VIEW `camera_summary` AS select `CAMERA`.`camera_id` AS `Camera ID`,concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERA`.`model`) AS `Camera`,`NEGATIVE_SIZE`.`negative_size` AS `Negative size`,`BODY_TYPE`.`body_type` AS `Body type`,`MOUNT`.`mount` AS `Mount`,`FORMAT`.`format` AS `Film format`,`FOCUS_TYPE`.`focus_type` AS `Focus type`,`CAMERA`.`metering` AS `Metering`,`CAMERA`.`coupled_metering` AS `Coupled metering`,`METERING_TYPE`.`metering` AS `Metering type`,concat(`CAMERA`.`weight`,'g') AS `Weight`,`CAMERA`.`acquired` AS `Date acquired`,concat('£',`CAMERA`.`cost`) AS `Cost`,concat(`CAMERA`.`introduced`,'-',ifnull(`CAMERA`.`discontinued`,'?')) AS `Manufactured between`,`CAMERA`.`serial` AS `Serial number`,`CAMERA`.`datecode` AS `Datecode`,`CAMERA`.`manufactured` AS `Year of manufacture`,`SHUTTER_TYPE`.`shutter_type` AS `Shutter type`,`CAMERA`.`shutter_model` AS `Shutter model`,`CAMERA`.`cable_release` AS `Cable release`,concat(`CAMERA`.`viewfinder_coverage`,'%') AS `Viewfinder coverage`,if(`CAMERA`.`power_drive`,'Yes','No') AS `Power drive`,`CAMERA`.`continuous_fps` AS `continuous_fps`,if(`CAMERA`.`video`,'Yes','No') AS `Video`,if(`CAMERA`.`digital`,'Yes','No') AS `Digital`,`CAMERA`.`fixed_mount` AS `Fixed mount`,`LENS`.`model` AS `Lens`,concat(`CAMERA`.`battery_qty`,' x ',`BATTERY`.`battery_name`) AS `Battery`,`CAMERA`.`notes` AS `Notes`,`CAMERA`.`lost` AS `Lost`,`CAMERA`.`lost_price` AS `Lost price`,`CAMERA`.`source` AS `Source`,`CAMERA`.`bulb` AS `Bulb`,`CAMERA`.`time` AS `Time`,concat(`CAMERA`.`min_iso`,'-',`CAMERA`.`max_iso`) AS `ISO range`,`CAMERA`.`af_points` AS `Autofocus points`,`CAMERA`.`int_flash` AS `Internal flash`,`CAMERA`.`int_flash_gn` AS `Internal flash guide number`,`CAMERA`.`ext_flash` AS `External flash`,`CAMERA`.`flash_metering` AS `Flash metering`,if(`CAMERA`.`pc_sync`,'Yes','No') AS `PC sync socket`,if(`CAMERA`.`hotshoe`,'Yes','No') AS `Hotshoe`,if(`CAMERA`.`coldshoe`,'Yes','No') AS `Coldshoe`,`CAMERA`.`x_sync` AS `X-sync speed`,concat(`CAMERA`.`meter_min_ev`,'-',`CAMERA`.`meter_max_ev`) AS `Meter range`,`CONDITION`.`name` AS `Condition`,if(`CAMERA`.`oem_case`,'Yes','No') AS `Original case`,`CAMERA`.`dof_preview` AS `Depth of field preview`,group_concat(distinct `EXPOSURE_PROGRAM`.`exposure_program` separator ', ') AS `Exposure programs`,group_concat(distinct `METERING_MODE`.`metering_mode` separator ', ') AS `Metering modes`,group_concat(distinct `SHUTTER_SPEED_AVAILABLE`.`shutter_speed` separator ', ') AS `Shutter speeds`,if(`LENS`.`zoom`,concat(`LENS`.`min_focal_length`,'-',`LENS`.`max_focal_length`,'mm'),concat(`LENS`.`min_focal_length`,'mm')) AS `Focal length`,concat('f/',`LENS`.`max_aperture`) AS `Maximum aperture`,count(distinct `FILM`.`film_id`) AS `Films loaded`,count(distinct `NEGATIVE`.`negative_id`) AS `Frames shot` from ((((((((((((((((((`CAMERA` left join `MANUFACTURER` on((`CAMERA`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`))) left join `NEGATIVE_SIZE` on((`CAMERA`.`negative_size_id` = `NEGATIVE_SIZE`.`negative_size_id`))) left join `BODY_TYPE` on((`CAMERA`.`body_type_id` = `BODY_TYPE`.`body_type_id`))) left join `BATTERY` on((`CAMERA`.`battery_type` = `BATTERY`.`battery_type`))) left join `METERING_TYPE` on((`CAMERA`.`metering_type_id` = `METERING_TYPE`.`metering_type_id`))) left join `SHUTTER_TYPE` on((`CAMERA`.`shutter_type_id` = `SHUTTER_TYPE`.`shutter_type_id`))) left join `CONDITION` on((`CAMERA`.`condition_id` = `CONDITION`.`condition_id`))) left join `FOCUS_TYPE` on((`CAMERA`.`focus_type_id` = `FOCUS_TYPE`.`focus_type_id`))) left join `EXPOSURE_PROGRAM_AVAILABLE` on((`CAMERA`.`camera_id` = `EXPOSURE_PROGRAM_AVAILABLE`.`camera_id`))) left join `EXPOSURE_PROGRAM` on((`EXPOSURE_PROGRAM_AVAILABLE`.`exposure_program_id` = `EXPOSURE_PROGRAM`.`exposure_program_id`))) left join `METERING_MODE_AVAILABLE` on((`CAMERA`.`camera_id` = `METERING_MODE_AVAILABLE`.`camera_id`))) left join `METERING_MODE` on((`METERING_MODE_AVAILABLE`.`metering_mode_id` = `METERING_MODE`.`metering_mode_id`))) left join `SHUTTER_SPEED_AVAILABLE` on((`CAMERA`.`camera_id` = `SHUTTER_SPEED_AVAILABLE`.`camera_id`))) left join `FORMAT` on((`CAMERA`.`format_id` = `FORMAT`.`format_id`))) left join `MOUNT` on((`CAMERA`.`mount_id` = `MOUNT`.`mount_id`))) left join `LENS` on((`CAMERA`.`lens_id` = `LENS`.`lens_id`))) left join `FILM` on((`CAMERA`.`camera_id` = `FILM`.`camera_id`))) left join `NEGATIVE` on((`FILM`.`film_id` = `NEGATIVE`.`film_id`))) where (`CAMERA`.`own` = 1) group by `CAMERA`.`camera_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
