SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `NEGATIVE_WITH_LM` (
  `LensType` tinyint NOT NULL,
  `shutter_speed` tinyint NOT NULL,
  `aperture` tinyint NOT NULL,
  `frame` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `negative_id` tinyint NOT NULL,
  `film_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `NEGATIVE_WITH_LM`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `NEGATIVE_WITH_LM` AS select concat(`lm`.`manufacturer`,' ',`l`.`model`) AS `LensType`,`n`.`shutter_speed` AS `shutter_speed`,`n`.`aperture` AS `aperture`,`n`.`frame` AS `frame`,`n`.`description` AS `description`,`n`.`negative_id` AS `negative_id`,`n`.`film_id` AS `film_id` from (((`NEGATIVE` `n` join `FILM` `f` on((`n`.`film_id` = `f`.`film_id`))) left join `LENS` `l` on((`n`.`lens_id` = `l`.`lens_id`))) left join `MANUFACTURER` `lm` on((`l`.`manufacturer_id` = `lm`.`manufacturer_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
