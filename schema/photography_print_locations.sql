SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `print_locations` (
  `id` tinyint NOT NULL,
  `negative_id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `print_locations`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `print_locations` AS select `PRINT`.`print_id` AS `id`,`PRINT`.`negative_id` AS `negative_id`,concat(ifnull(`PRINT`.`date`,'????-??-??'),' ',ifnull((trim(`PRINT`.`height`) + 0),'?'),'x',ifnull((trim(`PRINT`.`width`) + 0),'?'),'"',' - ',(case `PRINT`.`own` when 1 then ifnull(`ARCHIVE`.`name`,'Owned; location unknown') when 0 then ifnull(`PRINT`.`location`,'Not owned; location unknown') else 'No location information' end)) AS `opt` from (`PRINT` left join `ARCHIVE` on((`PRINT`.`archive_id` = `ARCHIVE`.`archive_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
