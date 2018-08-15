SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_todo` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `choose_todo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_todo` AS select `TO_PRINT`.`id` AS `id`,concat(`NEGATIVE`.`film_id`,'/',`NEGATIVE`.`frame`,' ',`NEGATIVE`.`description`,' as ',ifnull(`TO_PRINT`.`width`,'?'),'x',ifnull(`TO_PRINT`.`height`,'?'),'"',if((`TO_PRINT`.`recipient` <> ''),concat(' for ',`TO_PRINT`.`recipient`),'')) AS `opt` from (`TO_PRINT` join `NEGATIVE`) where ((`TO_PRINT`.`negative_id` = `NEGATIVE`.`negative_id`) and (`TO_PRINT`.`printed` = 0)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
