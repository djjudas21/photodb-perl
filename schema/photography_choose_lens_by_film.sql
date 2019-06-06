SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_lens_by_film` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL,
  `film_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `choose_lens_by_film`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`photography`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_lens_by_film` AS select `LENS`.`lens_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`LENSMODEL`.`model`,if(`LENS`.`serial`,concat(' (#',`LENS`.`serial`,')'),'')) AS `opt`,`FILM`.`film_id` AS `film_id` from (((((`FILM` join `CAMERA` on(`FILM`.`camera_id` = `CAMERA`.`camera_id`)) join `CAMERAMODEL` on(`CAMERA`.`cameramodel_id` = `CAMERAMODEL`.`cameramodel_id`)) join `LENSMODEL` on(`CAMERAMODEL`.`mount_id` = `LENSMODEL`.`mount_id`)) join `MANUFACTURER` on(`LENSMODEL`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`)) join `LENS` on(`LENSMODEL`.`lensmodel_id` = `LENS`.`lensmodel_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
