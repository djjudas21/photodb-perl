SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `print_info` (
  `print_id` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `print_date` tinyint NOT NULL,
  `photo_date` tinyint NOT NULL,
  `name` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `print_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `print_info` AS select `PRINT`.`print_id` AS `print_id`,`NEGATIVE`.`description` AS `description`,date_format(`PRINT`.`date`,'%M %Y') AS `print_date`,date_format(`NEGATIVE`.`date`,'%M %Y') AS `photo_date`,`PERSON`.`name` AS `name` from ((`PRINT` join `NEGATIVE` on((`PRINT`.`negative_id` = `NEGATIVE`.`negative_id`))) left join `PERSON` on((`NEGATIVE`.`photographer_id` = `PERSON`.`person_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
