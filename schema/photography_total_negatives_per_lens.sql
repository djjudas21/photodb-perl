SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `total_negatives_per_lens` (
  `manufacturer` tinyint NOT NULL,
  `model` tinyint NOT NULL,
  `count(negative_id)` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `total_negatives_per_lens`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `total_negatives_per_lens` AS select `MANUFACTURER`.`manufacturer` AS `manufacturer`,`LENS`.`model` AS `model`,count(`NEGATIVE`.`negative_id`) AS `count(negative_id)` from ((`LENS` join `NEGATIVE`) join `MANUFACTURER`) where ((`LENS`.`lens_id` = `NEGATIVE`.`lens_id`) and (`LENS`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`)) group by `LENS`.`lens_id` order by count(`NEGATIVE`.`negative_id`) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
