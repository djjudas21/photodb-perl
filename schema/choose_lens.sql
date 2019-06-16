SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_lens` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `choose_lens`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`photography`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_lens` AS select `LENS`.`lens_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`LENSMODEL`.`model`,if(`LENS`.`serial`,concat(' (#',`LENS`.`serial`,')'),'')) AS `opt` from ((`LENS` join `LENSMODEL` on(`LENS`.`lensmodel_id` = `LENSMODEL`.`lensmodel_id`)) join `MANUFACTURER` on(`LENSMODEL`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`)) where `LENS`.`own` = 1 and `LENSMODEL`.`fixed_mount` = 0 order by concat(`MANUFACTURER`.`manufacturer`,' ',`LENSMODEL`.`model`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
