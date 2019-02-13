SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `report_most_popular_lenses_relative` (
  `manufacturer` tinyint NOT NULL,
  `model` tinyint NOT NULL,
  `age_in_days` tinyint NOT NULL,
  `frames_shot` tinyint NOT NULL,
  `frames_per_day` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `report_most_popular_lenses_relative`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `report_most_popular_lenses_relative` AS select `MANUFACTURER`.`manufacturer` AS `manufacturer`,`LENS`.`model` AS `model`,(to_days(curdate()) - to_days(`LENS`.`acquired`)) AS `age_in_days`,count(`NEGATIVE`.`negative_id`) AS `frames_shot`,(count(`NEGATIVE`.`negative_id`) / (to_days(curdate()) - to_days(`LENS`.`acquired`))) AS `frames_per_day` from (((`LENS` join `MANUFACTURER`) join `NEGATIVE`) join `MOUNT`) where ((`LENS`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`) and (`LENS`.`acquired` is not null) and (`NEGATIVE`.`lens_id` = `LENS`.`lens_id`) and (`LENS`.`mount_id` = `MOUNT`.`mount_id`) and (`MOUNT`.`fixed` = 0)) group by `LENS`.`lens_id` order by (count(`NEGATIVE`.`negative_id`) / (to_days(curdate()) - to_days(`LENS`.`acquired`))) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
