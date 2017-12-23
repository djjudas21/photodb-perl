SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `never_used_lenses` (
  `lens_id` tinyint NOT NULL,
  `manufacturer` tinyint NOT NULL,
  `model` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `never_used_lenses`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `never_used_lenses` AS select `LENS`.`lens_id` AS `lens_id`,`MANUFACTURER`.`manufacturer` AS `manufacturer`,`LENS`.`model` AS `model` from ((`MANUFACTURER` join `MOUNT`) join (`LENS` left join `NEGATIVE` on((`NEGATIVE`.`lens_id` = `LENS`.`lens_id`)))) where (isnull(`NEGATIVE`.`lens_id`) and (`LENS`.`fixed_mount` = 0) and (`MOUNT`.`purpose` = 'Camera') and (`LENS`.`mount_id` = `MOUNT`.`mount_id`) and (`MOUNT`.`digital_only` = 0) and (`LENS`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`) and (`LENS`.`own` = 1)) order by `LENS`.`lens_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
