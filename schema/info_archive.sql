SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `info_archive` (
  `Archive ID` tinyint NOT NULL,
  `Archive name` tinyint NOT NULL,
  `Maximum size` tinyint NOT NULL,
  `Location` tinyint NOT NULL,
  `Storage type` tinyint NOT NULL,
  `Sealed` tinyint NOT NULL,
  `Archive type` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `info_archive`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `info_archive` AS select `ARCHIVE`.`archive_id` AS `Archive ID`,`ARCHIVE`.`name` AS `Archive name`,concat(`ARCHIVE`.`max_width`,'x',`ARCHIVE`.`max_height`) AS `Maximum size`,`ARCHIVE`.`location` AS `Location`,`ARCHIVE`.`storage` AS `Storage type`,`printbool`(`ARCHIVE`.`sealed`) AS `Sealed`,`ARCHIVE_TYPE`.`archive_type` AS `Archive type` from (`ARCHIVE` join `ARCHIVE_TYPE` on(`ARCHIVE`.`archive_type_id` = `ARCHIVE_TYPE`.`archive_type_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
