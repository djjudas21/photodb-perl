SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_movie_camera` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `choose_movie_camera`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`photography`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_movie_camera` AS select `C`.`camera_id` AS `id`,concat(`M`.`manufacturer`,' ',`CM`.`model`) AS `opt` from ((`CAMERA` `C` join `CAMERAMODEL` `CM` on(`C`.`cameramodel_id` = `CM`.`cameramodel_id`)) join `MANUFACTURER` `M` on(`CM`.`manufacturer_id` = `M`.`manufacturer_id`)) where `C`.`own` = 1 and `CM`.`video` = 1 and `CM`.`digital` = 0 order by concat(`M`.`manufacturer`,' ',`CM`.`model`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
