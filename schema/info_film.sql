SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `info_film` (
  `Film ID` tinyint NOT NULL,
  `ISO` tinyint NOT NULL,
  `Date` tinyint NOT NULL,
  `Title` tinyint NOT NULL,
  `Frames` tinyint NOT NULL,
  `dev_time` tinyint NOT NULL,
  `dev_temp` tinyint NOT NULL,
  `Development notes` tinyint NOT NULL,
  `Processed by` tinyint NOT NULL,
  `Filmstock` tinyint NOT NULL,
  `Camera` tinyint NOT NULL,
  `Developer` tinyint NOT NULL,
  `Archive` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `info_film`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `info_film` AS select `FILM`.`film_id` AS `Film ID`,concat('Box speed ',`FILMSTOCK`.`iso`,' exposed at EI ',`FILM`.`exposed_at`,if(`FILM`.`dev_n`,concat(' (',if(sign(`FILM`.`dev_n`),concat('N+',`FILM`.`dev_n`),concat('N-',`FILM`.`dev_n`)),')'),'')) AS `ISO`,`FILM`.`date` AS `Date`,`FILM`.`notes` AS `Title`,`FILM`.`frames` AS `Frames`,`FILM`.`dev_time` AS `dev_time`,`FILM`.`dev_temp` AS `dev_temp`,`FILM`.`development_notes` AS `Development notes`,`FILM`.`processed_by` AS `Processed by`,concat(`fm`.`manufacturer`,' ',`FILMSTOCK`.`name`) AS `Filmstock`,concat(`cm`.`manufacturer`,' ',`CAMERAMODEL`.`model`) AS `Camera`,concat(`dm`.`manufacturer`,' ',`DEVELOPER`.`name`) AS `Developer`,`ARCHIVE`.`name` AS `Archive` from (((((((((`FILM` left join `FILMSTOCK` on(`FILM`.`filmstock_id` = `FILMSTOCK`.`filmstock_id`)) left join `MANUFACTURER` `fm` on(`FILMSTOCK`.`manufacturer_id` = `fm`.`manufacturer_id`)) left join `FORMAT` on(`FILM`.`format_id` = `FORMAT`.`format_id`)) left join `DEVELOPER` on(`FILM`.`developer_id` = `DEVELOPER`.`developer_id`)) left join `CAMERA` `c` on(`FILM`.`camera_id` = `c`.`camera_id`)) left join `CAMERAMODEL` on(`c`.`cameramodel_id` = `CAMERAMODEL`.`cameramodel_id`)) left join `MANUFACTURER` `cm` on(`CAMERAMODEL`.`manufacturer_id` = `cm`.`manufacturer_id`)) left join `MANUFACTURER` `dm` on(`DEVELOPER`.`manufacturer_id` = `dm`.`manufacturer_id`)) left join `ARCHIVE` on(`FILM`.`archive_id` = `ARCHIVE`.`archive_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
