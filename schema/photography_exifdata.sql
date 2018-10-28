SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `exifdata` (
  `film_id` tinyint NOT NULL,
  `Make` tinyint NOT NULL,
  `Model` tinyint NOT NULL,
  `Author` tinyint NOT NULL,
  `LensModel` tinyint NOT NULL,
  `Lens` tinyint NOT NULL,
  `path` tinyint NOT NULL,
  `MaxApertureValue` tinyint NOT NULL,
  `directory` tinyint NOT NULL,
  `filename` tinyint NOT NULL,
  `ExposureTime` tinyint NOT NULL,
  `FNumber` tinyint NOT NULL,
  `ApertureValue` tinyint NOT NULL,
  `FocalLength` tinyint NOT NULL,
  `ISO` tinyint NOT NULL,
  `ImageDescription` tinyint NOT NULL,
  `DateTimeOriginal` tinyint NOT NULL,
  `GPSLatitude` tinyint NOT NULL,
  `GPSLongitude` tinyint NOT NULL,
  `ExposureProgram` tinyint NOT NULL,
  `MeteringMode` tinyint NOT NULL,
  `Flash#` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `exifdata`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `exifdata` AS select `f`.`film_id` AS `film_id`,`cm`.`manufacturer` AS `Make`,concat(`cm`.`manufacturer`,' ',`c`.`model`) AS `Model`,`p`.`name` AS `Author`,concat(`lm`.`manufacturer`,' ',`l`.`model`) AS `LensModel`,concat(`lm`.`manufacturer`,' ',`l`.`model`) AS `Lens`,concat(`f`.`directory`,'/',`n`.`filename`) AS `path`,`l`.`max_aperture` AS `MaxApertureValue`,`f`.`directory` AS `directory`,`n`.`filename` AS `filename`,`n`.`shutter_speed` AS `ExposureTime`,`n`.`aperture` AS `FNumber`,`n`.`aperture` AS `ApertureValue`,if((`l`.`min_focal_length` = `l`.`max_focal_length`),concat(`l`.`min_focal_length`,'.0 mm'),concat(`n`.`focal_length`,'.0mm')) AS `FocalLength`,if((`f`.`exposed_at` is not null),`f`.`exposed_at`,`fs`.`iso`) AS `ISO`,`n`.`description` AS `ImageDescription`,date_format(`n`.`date`,'%Y:%m:%d %H:%i:%s') AS `DateTimeOriginal`,`n`.`latitude` AS `GPSLatitude`,`n`.`longitude` AS `GPSLongitude`,if((`ep`.`exposure_program` > 0),`ep`.`exposure_program`,NULL) AS `ExposureProgram`,if((`mm`.`metering_mode` > 0),`mm`.`metering_mode`,NULL) AS `MeteringMode`,`n`.`flash` AS `Flash#` from ((`FILMSTOCK` `fs` join `PERSON` `p`) join (((((((`NEGATIVE` `n` join `FILM` `f` on((`n`.`film_id` = `f`.`film_id`))) join `CAMERA` `c` on((`f`.`camera_id` = `c`.`camera_id`))) join `MANUFACTURER` `cm` on((`c`.`manufacturer_id` = `cm`.`manufacturer_id`))) left join `LENS` `l` on((`n`.`lens_id` = `l`.`lens_id`))) left join `MANUFACTURER` `lm` on((`l`.`manufacturer_id` = `lm`.`manufacturer_id`))) left join `EXPOSURE_PROGRAM` `ep` on((`n`.`exposure_program` = `ep`.`exposure_program_id`))) left join `METERING_MODE` `mm` on((`n`.`metering_mode` = `mm`.`metering_mode_id`)))) where ((`f`.`photographer_id` = `p`.`person_id`) and (`n`.`filename` is not null) and (`f`.`filmstock_id` = `fs`.`filmstock_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
