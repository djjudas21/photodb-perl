SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `summary_series` (
  `Series ID` tinyint NOT NULL,
  `Series` tinyint NOT NULL,
  `Cameras` tinyint NOT NULL,
  `Lenses` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `summary_series`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `summary_series` AS select `SERIES`.`series_id` AS `Series ID`,`SERIES`.`name` AS `Series`,concat(count(`CAMERA`.`camera_id`),'/',count(`SERIES_MEMBER`.`cameramodel_id`)) AS `Cameras`,concat(count(`LENS`.`lens_id`),'/',count(`SERIES_MEMBER`.`lensmodel_id`)) AS `Lenses` from (((`SERIES` left join `SERIES_MEMBER` on(`SERIES`.`series_id` = `SERIES_MEMBER`.`series_id`)) left join `CAMERA` on(`CAMERA`.`cameramodel_id` = `SERIES_MEMBER`.`cameramodel_id`)) left join `LENS` on(`LENS`.`lensmodel_id` = `SERIES_MEMBER`.`lensmodel_id`)) group by `SERIES`.`series_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
