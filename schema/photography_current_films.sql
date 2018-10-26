SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `current_films` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `current_films`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `current_films` AS select `FILM`.`film_id` AS `id`,concat(`FM`.`manufacturer`,' ',`FILMSTOCK`.`name`,ifnull(concat(' loaded into ',`CM`.`manufacturer`,' ',`CAMERA`.`model`),''),ifnull(concat(' on ',`FILM`.`date_loaded`),''),', ',count(`NEGATIVE`.`film_id`),ifnull(concat('/',`FILM`.`frames`),''),' frames registered') AS `opt` from (((((`FILM` join `CAMERA` on((`FILM`.`camera_id` = `CAMERA`.`camera_id`))) join `MANUFACTURER` `CM` on((`CAMERA`.`manufacturer_id` = `CM`.`manufacturer_id`))) join `FILMSTOCK` on((`FILM`.`filmstock_id` = `FILMSTOCK`.`filmstock_id`))) join `MANUFACTURER` `FM` on((`FILMSTOCK`.`manufacturer_id` = `FM`.`manufacturer_id`))) left join `NEGATIVE` on((`FILM`.`film_id` = `NEGATIVE`.`film_id`))) where isnull(`FILM`.`date`) group by `FILM`.`film_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
