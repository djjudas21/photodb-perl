SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `info_movie` (
  `Movie ID` tinyint NOT NULL,
  `Title` tinyint NOT NULL,
  `Camera` tinyint NOT NULL,
  `Lens` tinyint NOT NULL,
  `Format` tinyint NOT NULL,
  `Sound` tinyint NOT NULL,
  `Frame rate` tinyint NOT NULL,
  `Filmstock` tinyint NOT NULL,
  `Length (feet)` tinyint NOT NULL,
  `Date loaded` tinyint NOT NULL,
  `Date shot` tinyint NOT NULL,
  `Date processed` tinyint NOT NULL,
  `Process` tinyint NOT NULL,
  `Description` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `info_movie`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`photography`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `info_movie` AS select `MOVIE`.`movie_id` AS `Movie ID`,`MOVIE`.`title` AS `Title`,concat(`CM`.`manufacturer`,' ',`CAMERAMODEL`.`model`) AS `Camera`,concat(`LM`.`manufacturer`,' ',`LENSMODEL`.`model`) AS `Lens`,`FORMAT`.`format` AS `Format`,`PRINTBOOL`(`MOVIE`.`sound`) AS `Sound`,`MOVIE`.`fps` AS `Frame rate`,concat(`FM`.`manufacturer`,' ',`FILMSTOCK`.`name`) AS `Filmstock`,`MOVIE`.`feet` AS `Length (feet)`,`MOVIE`.`date_loaded` AS `Date loaded`,`MOVIE`.`date_shot` AS `Date shot`,`MOVIE`.`date_processed` AS `Date processed`,`PROCESS`.`name` AS `Process`,`MOVIE`.`description` AS `Description` from ((((((((((`MOVIE` left join `CAMERA` on(`MOVIE`.`camera_id` = `CAMERA`.`camera_id`)) left join `CAMERAMODEL` on(`CAMERA`.`cameramodel_id` = `CAMERAMODEL`.`cameramodel_id`)) left join `FILMSTOCK` on(`MOVIE`.`filmstock_id` = `FILMSTOCK`.`filmstock_id`)) left join `LENS` on(`MOVIE`.`lens_id` = `LENS`.`lens_id`)) left join `LENSMODEL` on(`LENS`.`lensmodel_id` = `LENSMODEL`.`lensmodel_id`)) left join `MANUFACTURER` `CM` on(`CM`.`manufacturer_id` = `CAMERAMODEL`.`manufacturer_id`)) left join `MANUFACTURER` `FM` on(`FM`.`manufacturer_id` = `FILMSTOCK`.`manufacturer_id`)) left join `MANUFACTURER` `LM` on(`LM`.`manufacturer_id` = `LENSMODEL`.`manufacturer_id`)) left join `FORMAT` on(`MOVIE`.`format_id` = `FORMAT`.`format_id`)) left join `PROCESS` on(`MOVIE`.`process_id` = `PROCESS`.`process_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
