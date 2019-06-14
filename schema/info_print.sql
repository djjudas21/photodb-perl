SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `info_print` (
  `Negative` tinyint NOT NULL,
  `Negative ID` tinyint NOT NULL,
  `Print` tinyint NOT NULL,
  `Description` tinyint NOT NULL,
  `Size` tinyint NOT NULL,
  `Exposure time` tinyint NOT NULL,
  `Aperture` tinyint NOT NULL,
  `Filtration grade` tinyint NOT NULL,
  `Paper` tinyint NOT NULL,
  `Enlarger` tinyint NOT NULL,
  `Enlarger lens` tinyint NOT NULL,
  `First toner` tinyint NOT NULL,
  `Second toner` tinyint NOT NULL,
  `Print date` tinyint NOT NULL,
  `Photo date` tinyint NOT NULL,
  `Photographer` tinyint NOT NULL,
  `Location` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `info_print`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `info_print` AS select concat(`NEGATIVE`.`film_id`,'/',`NEGATIVE`.`frame`) AS `Negative`,`NEGATIVE`.`negative_id` AS `Negative ID`,`PRINT`.`print_id` AS `Print`,`NEGATIVE`.`description` AS `Description`,`DISPLAYSIZE`(`PRINT`.`width`,`PRINT`.`height`) AS `Size`,concat(`PRINT`.`exposure_time`,'s') AS `Exposure time`,concat('f/',`PRINT`.`aperture`) AS `Aperture`,`PRINT`.`filtration_grade` AS `Filtration grade`,concat(`PAPER_STOCK_MANUFACTURER`.`manufacturer`,' ',`PAPER_STOCK`.`name`) AS `Paper`,concat(`ENLARGER_MANUFACTURER`.`manufacturer`,' ',`ENLARGER`.`enlarger`) AS `Enlarger`,concat(`LENS_MANUFACTURER`.`manufacturer`,' ',`LENSMODEL`.`model`) AS `Enlarger lens`,concat(`FIRSTTONER_MANUFACTURER`.`manufacturer`,' ',`FIRSTTONER`.`toner`,if(`PRINT`.`toner_dilution` is not null,concat(' (',`PRINT`.`toner_dilution`,')'),''),if(`PRINT`.`toner_time` is not null,concat(' for ',`PRINT`.`toner_time`),'')) AS `First toner`,concat(`SECONDTONER_MANUFACTURER`.`manufacturer`,' ',`SECONDTONER`.`toner`,if(`PRINT`.`2nd_toner_dilution` is not null,concat(' (',`PRINT`.`2nd_toner_dilution`,')'),''),if(`PRINT`.`2nd_toner_time` is not null,concat(' for ',`PRINT`.`2nd_toner_time`),'')) AS `Second toner`,date_format(`PRINT`.`date`,'%M %Y') AS `Print date`,date_format(`NEGATIVE`.`date`,'%M %Y') AS `Photo date`,`PERSON`.`name` AS `Photographer`,case `PRINT`.`own` when 1 then ifnull(`ARCHIVE`.`name`,'Owned; location unknown') when 0 then ifnull(`PRINT`.`location`,'Not owned; location unknown') else 'No location information' end AS `Location` from ((((((((((((((`PRINT` join `PAPER_STOCK` on(`PRINT`.`paper_stock_id` = `PAPER_STOCK`.`paper_stock_id`)) join `MANUFACTURER` `PAPER_STOCK_MANUFACTURER` on(`PAPER_STOCK`.`manufacturer_id` = `PAPER_STOCK_MANUFACTURER`.`manufacturer_id`)) left join `ENLARGER` on(`PRINT`.`enlarger_id` = `ENLARGER`.`enlarger_id`)) join `MANUFACTURER` `ENLARGER_MANUFACTURER` on(`ENLARGER`.`manufacturer_id` = `ENLARGER_MANUFACTURER`.`manufacturer_id`)) left join `LENS` on(`PRINT`.`lens_id` = `LENS`.`lens_id`)) join `LENSMODEL` on(`LENS`.`lensmodel_id` = `LENSMODEL`.`lensmodel_id`)) join `MANUFACTURER` `LENS_MANUFACTURER` on(`LENSMODEL`.`manufacturer_id` = `LENS_MANUFACTURER`.`manufacturer_id`)) left join `TONER` `FIRSTTONER` on(`PRINT`.`toner_id` = `FIRSTTONER`.`toner_id`)) left join `MANUFACTURER` `FIRSTTONER_MANUFACTURER` on(`FIRSTTONER`.`manufacturer_id` = `FIRSTTONER_MANUFACTURER`.`manufacturer_id`)) left join `TONER` `SECONDTONER` on(`PRINT`.`2nd_toner_id` = `SECONDTONER`.`toner_id`)) left join `MANUFACTURER` `SECONDTONER_MANUFACTURER` on(`SECONDTONER`.`manufacturer_id` = `SECONDTONER_MANUFACTURER`.`manufacturer_id`)) left join `NEGATIVE` on(`PRINT`.`negative_id` = `NEGATIVE`.`negative_id`)) left join `PERSON` on(`NEGATIVE`.`photographer_id` = `PERSON`.`person_id`)) left join `ARCHIVE` on(`PRINT`.`archive_id` = `ARCHIVE`.`archive_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
