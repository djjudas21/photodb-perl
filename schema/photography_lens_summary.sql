SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `lens_summary` (
  `Lens ID` tinyint NOT NULL,
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
  `Serial number` tinyint NOT NULL,
  `Date code` tinyint NOT NULL,
  `Manufactured between` tinyint NOT NULL,
  `Year of manufacture` tinyint NOT NULL,
  `Negative size` tinyint NOT NULL,
  `Date acquired` tinyint NOT NULL,
  `Cost` tinyint NOT NULL,
  `Notes` tinyint NOT NULL,
  `Date lost` tinyint NOT NULL,
  `Price sold` tinyint NOT NULL,
  `Source` tinyint NOT NULL,
  `Coating` tinyint NOT NULL,
  `Hood` tinyint NOT NULL,
  `EXIF LensType` tinyint NOT NULL,
  `Rectilinear` tinyint NOT NULL,
  `Dimensions (l×w)` tinyint NOT NULL,
  `Condition` tinyint NOT NULL,
  `Image circle` tinyint NOT NULL,
  `Optical formula` tinyint NOT NULL,
  `Shutter model` tinyint NOT NULL,
  `Frames shot` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `lens_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `lens_summary` AS select `LENS`.`lens_id` AS `Lens ID`,`MOUNT`.`mount` AS `Mount`,if(`LENS`.`zoom`,concat(`LENS`.`min_focal_length`,'-',`LENS`.`max_focal_length`,'mm'),concat(`LENS`.`min_focal_length`,'mm')) AS `Focal length`,concat(`MANUFACTURER`.`manufacturer`,' ',`LENS`.`model`) AS `Lens`,concat(`LENS`.`closest_focus`,'cm') AS `Closest focus`,concat('f/',`LENS`.`max_aperture`) AS `Maximum aperture`,concat('f/',`LENS`.`min_aperture`) AS `Minimum aperture`,concat(`LENS`.`elements`,'/',`LENS`.`groups`) AS `Elements/Groups`,concat(`LENS`.`weight`,'g') AS `Weight`,if(`LENS`.`zoom`,concat(`LENS`.`nominal_max_angle_diag`,'°-',`LENS`.`nominal_min_angle_diag`,'°'),concat(`LENS`.`nominal_max_angle_diag`,'°')) AS `Angle of view`,`LENS`.`aperture_blades` AS `Aperture blades`,if(`LENS`.`autofocus`,'Yes','No') AS `Autofocus`,concat(`LENS`.`filter_thread`,'mm') AS `Filter thread`,concat(`LENS`.`magnification`,'×') AS `Maximum magnification`,`LENS`.`url` AS `URL`,`LENS`.`serial` AS `Serial number`,`LENS`.`date_code` AS `Date code`,concat(ifnull(`LENS`.`introduced`,'?'),'-',ifnull(`LENS`.`discontinued`,'?')) AS `Manufactured between`,`LENS`.`manufactured` AS `Year of manufacture`,`NEGATIVE_SIZE`.`negative_size` AS `Negative size`,`LENS`.`acquired` AS `Date acquired`,concat('£',`LENS`.`cost`) AS `Cost`,`LENS`.`notes` AS `Notes`,`LENS`.`lost` AS `Date lost`,concat('£',`LENS`.`lost_price`) AS `Price sold`,`LENS`.`source` AS `Source`,`LENS`.`coating` AS `Coating`,`LENS`.`hood` AS `Hood`,`LENS`.`exif_lenstype` AS `EXIF LensType`,if(`LENS`.`rectilinear`,'Yes','No') AS `Rectilinear`,concat(`LENS`.`length`,'×',`LENS`.`diameter`,'mm') AS `Dimensions (l×w)`,`CONDITION`.`name` AS `Condition`,concat(`LENS`.`image_circle`,'mm') AS `Image circle`,`LENS`.`formula` AS `Optical formula`,`LENS`.`shutter_model` AS `Shutter model`,count(`NEGATIVE`.`negative_id`) AS `Frames shot` from (((((`LENS` left join `MOUNT` on((`LENS`.`mount_id` = `MOUNT`.`mount_id`))) left join `MANUFACTURER` on((`LENS`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`))) left join `CONDITION` on((`LENS`.`condition_id` = `CONDITION`.`condition_id`))) left join `NEGATIVE_SIZE` on((`LENS`.`negative_size_id` = `NEGATIVE_SIZE`.`negative_size_id`))) left join `NEGATIVE` on((`NEGATIVE`.`lens_id` = `LENS`.`lens_id`))) where ((`LENS`.`own` = 1) and (`LENS`.`fixed_mount` = 0)) group by `LENS`.`lens_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
