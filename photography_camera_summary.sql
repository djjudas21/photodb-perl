SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `camera_summary` (
  `manufacturer` tinyint NOT NULL,
  `model` tinyint NOT NULL,
  `negative_size` tinyint NOT NULL,
  `body_type` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `camera_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `camera_summary` AS select `MANUFACTURER`.`manufacturer` AS `manufacturer`,`CAMERA`.`model` AS `model`,`NEGATIVE_SIZE`.`negative_size` AS `negative_size`,`BODY_TYPE`.`body_type` AS `body_type` from (((`CAMERA` join `MANUFACTURER`) join `NEGATIVE_SIZE`) join `BODY_TYPE`) where ((`CAMERA`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`) and (`CAMERA`.`negative_size_id` = `NEGATIVE_SIZE`.`negative_size_id`) and (`CAMERA`.`body_type_id` = `BODY_TYPE`.`body_type_id`) and (`CAMERA`.`own` = 1)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
