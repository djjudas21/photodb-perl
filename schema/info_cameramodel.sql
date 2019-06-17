SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `info_cameramodel` (
  `Camera Model ID` tinyint NOT NULL,
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
  `Manufactured between` tinyint NOT NULL,
  `Shutter type` tinyint NOT NULL,
  `Shutter model` tinyint NOT NULL,
  `Cable release` tinyint NOT NULL,
  `Viewfinder coverage` tinyint NOT NULL,
  `Power drive` tinyint NOT NULL,
  `Continuous framerate` tinyint NOT NULL,
  `Video` tinyint NOT NULL,
  `Digital` tinyint NOT NULL,
  `Fixed mount` tinyint NOT NULL,
  `Lens` tinyint NOT NULL,
  `Battery` tinyint NOT NULL,
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
  `Depth of field preview` tinyint NOT NULL,
  `Exposure programs` tinyint NOT NULL,
  `Metering modes` tinyint NOT NULL,
  `Shutter speeds` tinyint NOT NULL,
  `Focal length` tinyint NOT NULL,
  `Maximum aperture` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `info_cameramodel`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `info_cameramodel` AS select `CAMERAMODEL`.`cameramodel_id` AS `Camera Model ID`,concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERAMODEL`.`model`) AS `Camera`,`NEGATIVE_SIZE`.`negative_size` AS `Negative size`,`BODY_TYPE`.`body_type` AS `Body type`,`MOUNT`.`mount` AS `Mount`,`FORMAT`.`format` AS `Film format`,`FOCUS_TYPE`.`focus_type` AS `Focus type`,`PRINTBOOL`(`CAMERAMODEL`.`metering`) AS `Metering`,`CAMERAMODEL`.`coupled_metering` AS `Coupled metering`,`METERING_TYPE`.`metering` AS `Metering type`,concat(`CAMERAMODEL`.`weight`,'g') AS `Weight`,concat(`CAMERAMODEL`.`introduced`,'-',ifnull(`CAMERAMODEL`.`discontinued`,'?')) AS `Manufactured between`,`SHUTTER_TYPE`.`shutter_type` AS `Shutter type`,`CAMERAMODEL`.`shutter_model` AS `Shutter model`,`PRINTBOOL`(`CAMERAMODEL`.`cable_release`) AS `Cable release`,concat(`CAMERAMODEL`.`viewfinder_coverage`,'%') AS `Viewfinder coverage`,`PRINTBOOL`(`CAMERAMODEL`.`power_drive`) AS `Power drive`,`CAMERAMODEL`.`continuous_fps` AS `Continuous framerate`,`PRINTBOOL`(`CAMERAMODEL`.`video`) AS `Video`,`PRINTBOOL`(`CAMERAMODEL`.`digital`) AS `Digital`,`PRINTBOOL`(`CAMERAMODEL`.`fixed_mount`) AS `Fixed mount`,`LENSMODEL`.`model` AS `Lens`,concat(`CAMERAMODEL`.`battery_qty`,' x ',`BATTERY`.`battery_name`) AS `Battery`,`PRINTBOOL`(`CAMERAMODEL`.`bulb`) AS `Bulb`,`PRINTBOOL`(`CAMERAMODEL`.`time`) AS `Time`,concat(`CAMERAMODEL`.`min_iso`,'-',`CAMERAMODEL`.`max_iso`) AS `ISO range`,`CAMERAMODEL`.`af_points` AS `Autofocus points`,`PRINTBOOL`(`CAMERAMODEL`.`int_flash`) AS `Internal flash`,`CAMERAMODEL`.`int_flash_gn` AS `Internal flash guide number`,`PRINTBOOL`(`CAMERAMODEL`.`ext_flash`) AS `External flash`,`CAMERAMODEL`.`flash_metering` AS `Flash metering`,`PRINTBOOL`(`CAMERAMODEL`.`pc_sync`) AS `PC sync socket`,`PRINTBOOL`(`CAMERAMODEL`.`hotshoe`) AS `Hotshoe`,`PRINTBOOL`(`CAMERAMODEL`.`coldshoe`) AS `Coldshoe`,`CAMERAMODEL`.`x_sync` AS `X-sync speed`,concat(`CAMERAMODEL`.`meter_min_ev`,'-',`CAMERAMODEL`.`meter_max_ev`) AS `Meter range`,`PRINTBOOL`(`CAMERAMODEL`.`dof_preview`) AS `Depth of field preview`,group_concat(distinct `EXPOSURE_PROGRAM`.`exposure_program` separator ', ') AS `Exposure programs`,group_concat(distinct `METERING_MODE`.`metering_mode` separator ', ') AS `Metering modes`,group_concat(distinct `SHUTTER_SPEED_AVAILABLE`.`shutter_speed` separator ', ') AS `Shutter speeds`,if(`LENSMODEL`.`zoom`,concat(`LENSMODEL`.`min_focal_length`,'-',`LENSMODEL`.`max_focal_length`,'mm'),concat(`LENSMODEL`.`min_focal_length`,'mm')) AS `Focal length`,concat('f/',`LENSMODEL`.`max_aperture`) AS `Maximum aperture` from (((((((((((((((`CAMERAMODEL` left join `MANUFACTURER` on(`CAMERAMODEL`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`)) left join `NEGATIVE_SIZE` on(`CAMERAMODEL`.`negative_size_id` = `NEGATIVE_SIZE`.`negative_size_id`)) left join `BODY_TYPE` on(`CAMERAMODEL`.`body_type_id` = `BODY_TYPE`.`body_type_id`)) left join `BATTERY` on(`CAMERAMODEL`.`battery_type` = `BATTERY`.`battery_type`)) left join `METERING_TYPE` on(`CAMERAMODEL`.`metering_type_id` = `METERING_TYPE`.`metering_type_id`)) left join `SHUTTER_TYPE` on(`CAMERAMODEL`.`shutter_type_id` = `SHUTTER_TYPE`.`shutter_type_id`)) left join `FOCUS_TYPE` on(`CAMERAMODEL`.`focus_type_id` = `FOCUS_TYPE`.`focus_type_id`)) left join `EXPOSURE_PROGRAM_AVAILABLE` on(`CAMERAMODEL`.`cameramodel_id` = `EXPOSURE_PROGRAM_AVAILABLE`.`cameramodel_id`)) left join `EXPOSURE_PROGRAM` on(`EXPOSURE_PROGRAM_AVAILABLE`.`exposure_program_id` = `EXPOSURE_PROGRAM`.`exposure_program_id`)) left join `METERING_MODE_AVAILABLE` on(`CAMERAMODEL`.`cameramodel_id` = `METERING_MODE_AVAILABLE`.`cameramodel_id`)) left join `METERING_MODE` on(`METERING_MODE_AVAILABLE`.`metering_mode_id` = `METERING_MODE`.`metering_mode_id`)) left join `SHUTTER_SPEED_AVAILABLE` on(`CAMERAMODEL`.`cameramodel_id` = `SHUTTER_SPEED_AVAILABLE`.`cameramodel_id`)) left join `FORMAT` on(`CAMERAMODEL`.`format_id` = `FORMAT`.`format_id`)) left join `MOUNT` on(`CAMERAMODEL`.`mount_id` = `MOUNT`.`mount_id`)) left join `LENSMODEL` on(`LENSMODEL`.`lensmodel_id` = `CAMERAMODEL`.`lensmodel_id`)) where `SHUTTER_SPEED_AVAILABLE`.`bulb` = 0 group by `CAMERAMODEL`.`cameramodel_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
