SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_teleconverter_by_film` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL,
  `film_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `choose_teleconverter_by_film`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`photography`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_teleconverter_by_film` AS select `T`.`teleconverter_id` AS `id`,concat(`M`.`manufacturer`,' ',`T`.`model`,' (',`T`.`factor`,'x)') AS `opt`,`F`.`film_id` AS `film_id` from ((((`TELECONVERTER` `T` join `CAMERAMODEL` `CM` on((`CM`.`mount_id` = `T`.`mount_id`))) join `CAMERA` `C` on((`C`.`cameramodel_id` = `CM`.`cameramodel_id`))) join `FILM` `F` on((`F`.`camera_id` = `C`.`camera_id`))) join `MANUFACTURER` `M` on((`M`.`manufacturer_id` = `T`.`manufacturer_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
