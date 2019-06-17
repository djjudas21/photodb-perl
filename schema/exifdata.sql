SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `exifdata` (
  `film_id` tinyint NOT NULL,
  `negative_id` tinyint NOT NULL,
  `print_id` tinyint NOT NULL,
  `Make` tinyint NOT NULL,
  `Model` tinyint NOT NULL,
  `Author` tinyint NOT NULL,
  `LensMake` tinyint NOT NULL,
  `LensModel` tinyint NOT NULL,
  `Lens` tinyint NOT NULL,
  `LensSerialNumber` tinyint NOT NULL,
  `SerialNumber` tinyint NOT NULL,
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
  `Flash` tinyint NOT NULL,
  `FocalLengthIn35mmFormat` tinyint NOT NULL,
  `Copyright` tinyint NOT NULL,
  `UserComment` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `exifdata`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `exifdata` AS select `f`.`film_id` AS `film_id`,`n`.`negative_id` AS `negative_id`,`PRINT`.`print_id` AS `print_id`,`cm`.`manufacturer` AS `Make`,concat(`cm`.`manufacturer`,' ',`cmod`.`model`) AS `Model`,`p`.`name` AS `Author`,`lm`.`manufacturer` AS `LensMake`,concat(`lm`.`manufacturer`,' ',`lmod`.`model`) AS `LensModel`,concat(`lm`.`manufacturer`,' ',`lmod`.`model`) AS `Lens`,`l`.`serial` AS `LensSerialNumber`,`c`.`serial` AS `SerialNumber`,concat(`f`.`directory`,'/',`s`.`filename`) AS `path`,`lmod`.`max_aperture` AS `MaxApertureValue`,`f`.`directory` AS `directory`,`s`.`filename` AS `filename`,`n`.`shutter_speed` AS `ExposureTime`,`n`.`aperture` AS `FNumber`,`n`.`aperture` AS `ApertureValue`,if(`lmod`.`min_focal_length` = `lmod`.`max_focal_length`,concat(`lmod`.`min_focal_length`,'.0 mm'),concat(`n`.`focal_length`,'.0 mm')) AS `FocalLength`,if(`f`.`exposed_at` is not null,`f`.`exposed_at`,`fs`.`iso`) AS `ISO`,`n`.`description` AS `ImageDescription`,date_format(`n`.`date`,'%Y:%m:%d %H:%i:%s') AS `DateTimeOriginal`,if(`n`.`latitude` >= 0,concat('+',format(`n`.`latitude`,6)),format(`n`.`latitude`,6)) AS `GPSLatitude`,if(`n`.`longitude` >= 0,concat('+',format(`n`.`longitude`,6)),format(`n`.`longitude`,6)) AS `GPSLongitude`,if(`ep`.`exposure_program` > 0,`ep`.`exposure_program`,NULL) AS `ExposureProgram`,if(`mm`.`metering_mode` > 0,`mm`.`metering_mode`,NULL) AS `MeteringMode`,case when `n`.`flash` is null then NULL when `n`.`flash` = 0 then 'No Flash' when `n`.`flash` > 0 then 'Fired' end AS `Flash`,if(`lmod`.`min_focal_length` = `lmod`.`max_focal_length`,concat(round(`lmod`.`min_focal_length` * `NEGATIVE_SIZE`.`crop_factor`,0),' mm'),concat(round(`n`.`focal_length` * `NEGATIVE_SIZE`.`crop_factor`,0),' mm')) AS `FocalLengthIn35mmFormat`,concat('Copyright ',`p`.`name`,' ',year(`n`.`date`)) AS `Copyright`,concat(`n`.`description`,'\n                                                                                                                Film: ',`fsm`.`manufacturer`,' ',`fs`.`name`,ifnull(concat('\n                                                                                                                                                                                                                                                                Paper: ',`psm`.`manufacturer`,' ',`ps`.`name`),'')) AS `UserComment` from (((((((((((((((((`scans_negs` `n` join `FILM` `f` on(`n`.`film_id` = `f`.`film_id`)) join `FILMSTOCK` `fs` on(`f`.`filmstock_id` = `fs`.`filmstock_id`)) join `PERSON` `p` on(`n`.`photographer_id` = `p`.`person_id`)) join `CAMERA` `c` on(`f`.`camera_id` = `c`.`camera_id`)) join `CAMERAMODEL` `cmod` on(`c`.`cameramodel_id` = `cmod`.`cameramodel_id`)) left join `MANUFACTURER` `cm` on(`cmod`.`manufacturer_id` = `cm`.`manufacturer_id`)) left join `LENS` `l` on(`n`.`lens_id` = `l`.`lens_id`)) join `LENSMODEL` `lmod` on(`l`.`lensmodel_id` = `lmod`.`lensmodel_id`)) left join `MANUFACTURER` `lm` on(`lmod`.`manufacturer_id` = `lm`.`manufacturer_id`)) left join `EXPOSURE_PROGRAM` `ep` on(`n`.`exposure_program` = `ep`.`exposure_program_id`)) left join `METERING_MODE` `mm` on(`n`.`metering_mode` = `mm`.`metering_mode_id`)) join `SCAN` `s` on(`n`.`scan_id` = `s`.`scan_id`)) left join `PRINT` on(`s`.`print_id` = `PRINT`.`print_id`)) left join `NEGATIVE_SIZE` on(`cmod`.`negative_size_id` = `NEGATIVE_SIZE`.`negative_size_id`)) left join `MANUFACTURER` `fsm` on(`fs`.`manufacturer_id` = `fsm`.`manufacturer_id`)) left join `PAPER_STOCK` `ps` on(`PRINT`.`paper_stock_id` = `ps`.`paper_stock_id`)) left join `MANUFACTURER` `psm` on(`ps`.`manufacturer_id` = `psm`.`manufacturer_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
