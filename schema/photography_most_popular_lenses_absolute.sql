SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `most_popular_lenses_absolute` (
  `manufacturer` tinyint NOT NULL,
  `model` tinyint NOT NULL,
  `qty` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `most_popular_lenses_absolute`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `most_popular_lenses_absolute` AS select `MANUFACTURER`.`manufacturer` AS `manufacturer`,`LENS`.`model` AS `model`,count(`LENS`.`lens_id`) AS `qty` from (((`NEGATIVE` join `LENS`) join `MOUNT`) join `MANUFACTURER`) where ((`NEGATIVE`.`lens_id` = `LENS`.`lens_id`) and (`LENS`.`mount_id` = `MOUNT`.`mount_id`) and (`MOUNT`.`fixed` = 0) and (`LENS`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`)) group by `LENS`.`lens_id` order by count(`LENS`.`lens_id`) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
