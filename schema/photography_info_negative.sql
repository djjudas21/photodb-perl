SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `info_negative` (
  `Negative ID` tinyint NOT NULL,
  `Film ID` tinyint NOT NULL,
  `Frame` tinyint NOT NULL,
  `Metering mode` tinyint NOT NULL,
  `Date` tinyint NOT NULL,
  `Location` tinyint NOT NULL,
  `Filename` tinyint NOT NULL,
  `Shutter speed` tinyint NOT NULL,
  `Lens` tinyint NOT NULL,
  `Photographer` tinyint NOT NULL,
  `Aperture` tinyint NOT NULL,
  `Caption` tinyint NOT NULL,
  `Focal length` tinyint NOT NULL,
  `Exposure program` tinyint NOT NULL,
  `Prints made` tinyint NOT NULL,
  `Camera` tinyint NOT NULL,
  `Filmstock` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `info_negative`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`photography`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `info_negative` AS select `n`.`negative_id` AS `Negative ID`,`n`.`film_id` AS `Film ID`,`n`.`frame` AS `Frame`,`mm`.`metering_mode` AS `Metering mode`,date_format(`n`.`date`,'%Y-%m-%d %H:%i:%s') AS `Date`,concat(`n`.`latitude`,', ',`n`.`longitude`) AS `Location`,`s`.`filename` AS `Filename`,`n`.`shutter_speed` AS `Shutter speed`,concat(`lm`.`manufacturer`,' ',`lmod`.`model`) AS `Lens`,`p`.`name` AS `Photographer`,concat('f/',`n`.`aperture`) AS `Aperture`,`n`.`description` AS `Caption`,if(`lmod`.`min_focal_length` = `lmod`.`max_focal_length`,concat(`lmod`.`min_focal_length`,'mm'),concat(`n`.`focal_length`,'mm')) AS `Focal length`,`ep`.`exposure_program` AS `Exposure program`,count(`PRINT`.`print_id`) AS `Prints made`,concat(`cm`.`manufacturer`,' ',`CAMERAMODEL`.`model`) AS `Camera`,concat(`fsm`.`manufacturer`,' ',`fs`.`name`) AS `Filmstock` from ((((((((((((((`NEGATIVE` `n` join `FILM` `f` on(`n`.`film_id` = `f`.`film_id`)) join `FILMSTOCK` `fs` on(`f`.`filmstock_id` = `fs`.`filmstock_id`)) join `CAMERA` `c` on(`f`.`camera_id` = `c`.`camera_id`)) join `CAMERAMODEL` on(`c`.`cameramodel_id` = `CAMERAMODEL`.`cameramodel_id`)) join `MANUFACTURER` `cm` on(`CAMERAMODEL`.`manufacturer_id` = `cm`.`manufacturer_id`)) left join `PERSON` `p` on(`n`.`photographer_id` = `p`.`person_id`)) left join `MANUFACTURER` `fsm` on(`fs`.`manufacturer_id` = `fsm`.`manufacturer_id`)) left join `LENS` `l` on(`n`.`lens_id` = `l`.`lens_id`)) left join `LENSMODEL` `lmod` on(`l`.`lensmodel_id` = `lmod`.`lensmodel_id`)) left join `MANUFACTURER` `lm` on(`lmod`.`manufacturer_id` = `lm`.`manufacturer_id`)) left join `EXPOSURE_PROGRAM` `ep` on(`n`.`exposure_program` = `ep`.`exposure_program_id`)) left join `METERING_MODE` `mm` on(`n`.`metering_mode` = `mm`.`metering_mode_id`)) left join `PRINT` on(`n`.`negative_id` = `PRINT`.`negative_id`)) left join `SCAN` `s` on(`n`.`negative_id` = `s`.`negative_id`)) where `s`.`filename` is not null group by `n`.`negative_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
