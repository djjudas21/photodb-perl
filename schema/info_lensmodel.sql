SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `info_lensmodel` (
  `Lens Model ID` tinyint NOT NULL,
  `Mount` tinyint NOT NULL,
  `Focal length` tinyint NOT NULL,
  `Lens` tinyint NOT NULL,
  `Closest focus` tinyint NOT NULL,
  `Maximum aperture` tinyint NOT NULL,
  `Minimum aperture` tinyint NOT NULL,
  `Elements/Groups` tinyint NOT NULL,
  `Weight` tinyint NOT NULL,
  `Angle of view` tinyint NOT NULL,
  `Aperture blades` tinyint NOT NULL,
  `Autofocus` tinyint NOT NULL,
  `Filter thread` tinyint NOT NULL,
  `Maximum magnification` tinyint NOT NULL,
  `URL` tinyint NOT NULL,
  `Manufactured between` tinyint NOT NULL,
  `Negative size` tinyint NOT NULL,
  `Coating` tinyint NOT NULL,
  `Hood` tinyint NOT NULL,
  `EXIF LensType` tinyint NOT NULL,
  `Rectilinear` tinyint NOT NULL,
  `Dimensions (l×w)` tinyint NOT NULL,
  `Image circle` tinyint NOT NULL,
  `Optical formula` tinyint NOT NULL,
  `Shutter model` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `info_lensmodel`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`photography`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `info_lensmodel` AS select `LENSMODEL`.`lensmodel_id` AS `Lens Model ID`,`MOUNT`.`mount` AS `Mount`,if(`LENSMODEL`.`zoom`,concat(`LENSMODEL`.`min_focal_length`,'-',`LENSMODEL`.`max_focal_length`,'mm'),concat(`LENSMODEL`.`min_focal_length`,'mm')) AS `Focal length`,concat(`MANUFACTURER`.`manufacturer`,' ',`LENSMODEL`.`model`) AS `Lens`,concat(`LENSMODEL`.`closest_focus`,'cm') AS `Closest focus`,concat('f/',`LENSMODEL`.`max_aperture`) AS `Maximum aperture`,concat('f/',`LENSMODEL`.`min_aperture`) AS `Minimum aperture`,concat(`LENSMODEL`.`elements`,'/',`LENSMODEL`.`groups`) AS `Elements/Groups`,concat(`LENSMODEL`.`weight`,'g') AS `Weight`,if(`LENSMODEL`.`zoom`,concat(`LENSMODEL`.`nominal_max_angle_diag`,'°-',`LENSMODEL`.`nominal_min_angle_diag`,'°'),concat(`LENSMODEL`.`nominal_max_angle_diag`,'°')) AS `Angle of view`,`LENSMODEL`.`aperture_blades` AS `Aperture blades`,`PRINTBOOL`(`LENSMODEL`.`autofocus`) AS `Autofocus`,concat(`LENSMODEL`.`filter_thread`,'mm') AS `Filter thread`,concat(`LENSMODEL`.`magnification`,'×') AS `Maximum magnification`,`LENSMODEL`.`url` AS `URL`,concat(ifnull(`LENSMODEL`.`introduced`,'?'),'-',ifnull(`LENSMODEL`.`discontinued`,'?')) AS `Manufactured between`,`NEGATIVE_SIZE`.`negative_size` AS `Negative size`,`LENSMODEL`.`coating` AS `Coating`,`LENSMODEL`.`hood` AS `Hood`,`LENSMODEL`.`exif_lenstype` AS `EXIF LensType`,`PRINTBOOL`(`LENSMODEL`.`rectilinear`) AS `Rectilinear`,concat(`LENSMODEL`.`length`,'×',`LENSMODEL`.`diameter`,'mm') AS `Dimensions (l×w)`,concat(`LENSMODEL`.`image_circle`,'mm') AS `Image circle`,`LENSMODEL`.`formula` AS `Optical formula`,`LENSMODEL`.`shutter_model` AS `Shutter model` from (((`LENSMODEL` left join `MOUNT` on(`LENSMODEL`.`mount_id` = `MOUNT`.`mount_id`)) left join `MANUFACTURER` on(`LENSMODEL`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`)) left join `NEGATIVE_SIZE` on(`LENSMODEL`.`negative_size_id` = `NEGATIVE_SIZE`.`negative_size_id`)) where `LENSMODEL`.`fixed_mount` = 0 group by `LENSMODEL`.`lensmodel_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
