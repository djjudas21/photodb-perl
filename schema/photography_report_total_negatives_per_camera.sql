SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `report_total_negatives_per_camera` (
  `Camera` tinyint NOT NULL,
  `Frames shot` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `report_total_negatives_per_camera`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `report_total_negatives_per_camera` AS select concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERA`.`model`) AS `Camera`,count(`NEGATIVE`.`negative_id`) AS `Frames shot` from (((`CAMERA` join `FILM` on((`CAMERA`.`camera_id` = `FILM`.`camera_id`))) join `NEGATIVE` on((`FILM`.`film_id` = `NEGATIVE`.`film_id`))) join `MANUFACTURER` on((`CAMERA`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`))) group by `CAMERA`.`camera_id` order by count(`NEGATIVE`.`negative_id`) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
