SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `scans_negs` (
  `scan_id` tinyint NOT NULL,
  `directory` tinyint NOT NULL,
  `filename` tinyint NOT NULL,
  `negative_id` tinyint NOT NULL,
  `film_id` tinyint NOT NULL,
  `frame` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `date` tinyint NOT NULL,
  `lens_id` tinyint NOT NULL,
  `shutter_speed` tinyint NOT NULL,
  `aperture` tinyint NOT NULL,
  `filter_id` tinyint NOT NULL,
  `teleconverter_id` tinyint NOT NULL,
  `notes` tinyint NOT NULL,
  `mount_adapter_id` tinyint NOT NULL,
  `focal_length` tinyint NOT NULL,
  `latitude` tinyint NOT NULL,
  `longitude` tinyint NOT NULL,
  `flash` tinyint NOT NULL,
  `metering_mode` tinyint NOT NULL,
  `exposure_program` tinyint NOT NULL,
  `photographer_id` tinyint NOT NULL,
  `copy_of` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `scans_negs`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `scans_negs` AS select `SCAN`.`scan_id` AS `scan_id`,`FILM`.`directory` AS `directory`,`SCAN`.`filename` AS `filename`,`NEGATIVE`.`negative_id` AS `negative_id`,`NEGATIVE`.`film_id` AS `film_id`,`NEGATIVE`.`frame` AS `frame`,`NEGATIVE`.`description` AS `description`,`NEGATIVE`.`date` AS `date`,`NEGATIVE`.`lens_id` AS `lens_id`,`NEGATIVE`.`shutter_speed` AS `shutter_speed`,`NEGATIVE`.`aperture` AS `aperture`,`NEGATIVE`.`filter_id` AS `filter_id`,`NEGATIVE`.`teleconverter_id` AS `teleconverter_id`,`NEGATIVE`.`notes` AS `notes`,`NEGATIVE`.`mount_adapter_id` AS `mount_adapter_id`,`NEGATIVE`.`focal_length` AS `focal_length`,`NEGATIVE`.`latitude` AS `latitude`,`NEGATIVE`.`longitude` AS `longitude`,`NEGATIVE`.`flash` AS `flash`,`NEGATIVE`.`metering_mode` AS `metering_mode`,`NEGATIVE`.`exposure_program` AS `exposure_program`,`NEGATIVE`.`photographer_id` AS `photographer_id`,`NEGATIVE`.`copy_of` AS `copy_of` from (((`SCAN` join `PRINT` on(`SCAN`.`print_id` = `PRINT`.`print_id`)) join `NEGATIVE` on(`PRINT`.`negative_id` = `NEGATIVE`.`negative_id`)) join `FILM` on(`NEGATIVE`.`film_id` = `FILM`.`film_id`)) union all select `SCAN`.`scan_id` AS `scan_id`,`FILM`.`directory` AS `directory`,`SCAN`.`filename` AS `filename`,`NEGATIVE`.`negative_id` AS `negative_id`,`NEGATIVE`.`film_id` AS `film_id`,`NEGATIVE`.`frame` AS `frame`,`NEGATIVE`.`description` AS `description`,`NEGATIVE`.`date` AS `date`,`NEGATIVE`.`lens_id` AS `lens_id`,`NEGATIVE`.`shutter_speed` AS `shutter_speed`,`NEGATIVE`.`aperture` AS `aperture`,`NEGATIVE`.`filter_id` AS `filter_id`,`NEGATIVE`.`teleconverter_id` AS `teleconverter_id`,`NEGATIVE`.`notes` AS `notes`,`NEGATIVE`.`mount_adapter_id` AS `mount_adapter_id`,`NEGATIVE`.`focal_length` AS `focal_length`,`NEGATIVE`.`latitude` AS `latitude`,`NEGATIVE`.`longitude` AS `longitude`,`NEGATIVE`.`flash` AS `flash`,`NEGATIVE`.`metering_mode` AS `metering_mode`,`NEGATIVE`.`exposure_program` AS `exposure_program`,`NEGATIVE`.`photographer_id` AS `photographer_id`,`NEGATIVE`.`copy_of` AS `copy_of` from ((`SCAN` join `NEGATIVE` on(`SCAN`.`negative_id` = `NEGATIVE`.`negative_id`)) join `FILM` on(`NEGATIVE`.`film_id` = `FILM`.`film_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
