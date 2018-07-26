SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `LENS_VIEW` (
  `lens_id` tinyint NOT NULL,
  `mount_id` tinyint NOT NULL,
  `zoom` tinyint NOT NULL,
  `min_focal_length` tinyint NOT NULL,
  `max_focal_length` tinyint NOT NULL,
  `manufacturer_id` tinyint NOT NULL,
  `model` tinyint NOT NULL,
  `closest_focus` tinyint NOT NULL,
  `max_aperture` tinyint NOT NULL,
  `min_aperture` tinyint NOT NULL,
  `elements` tinyint NOT NULL,
  `groups` tinyint NOT NULL,
  `weight` tinyint NOT NULL,
  `nominal_min_angle_diag` tinyint NOT NULL,
  `nominal_max_angle_diag` tinyint NOT NULL,
  `calc_min_angle_diag` tinyint NOT NULL,
  `calc_max_angle_diag` tinyint NOT NULL,
  `calc_min_angle_horiz` tinyint NOT NULL,
  `calc_max_angle_horiz` tinyint NOT NULL,
  `calc_min_angle_vert` tinyint NOT NULL,
  `calc_max_angle_vert` tinyint NOT NULL,
  `aperture_blades` tinyint NOT NULL,
  `autofocus` tinyint NOT NULL,
  `filter_thread` tinyint NOT NULL,
  `magnification` tinyint NOT NULL,
  `url` tinyint NOT NULL,
  `serial` tinyint NOT NULL,
  `date_code` tinyint NOT NULL,
  `introduced` tinyint NOT NULL,
  `discontinued` tinyint NOT NULL,
  `manufactured` tinyint NOT NULL,
  `negative_size_id` tinyint NOT NULL,
  `acquired` tinyint NOT NULL,
  `cost` tinyint NOT NULL,
  `fixed_mount` tinyint NOT NULL,
  `notes` tinyint NOT NULL,
  `own` tinyint NOT NULL,
  `lost` tinyint NOT NULL,
  `lost_price` tinyint NOT NULL,
  `source` tinyint NOT NULL,
  `coating` tinyint NOT NULL,
  `hood` tinyint NOT NULL,
  `exif_lenstype` tinyint NOT NULL,
  `rectilinear` tinyint NOT NULL,
  `length` tinyint NOT NULL,
  `diameter` tinyint NOT NULL,
  `condition_id` tinyint NOT NULL,
  `image_circle` tinyint NOT NULL,
  `formula` tinyint NOT NULL,
  `shutter_model` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `LENS_VIEW`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `LENS_VIEW` AS select `LENS`.`lens_id` AS `lens_id`,`LENS`.`mount_id` AS `mount_id`,`LENS`.`zoom` AS `zoom`,`LENS`.`min_focal_length` AS `min_focal_length`,`LENS`.`max_focal_length` AS `max_focal_length`,`LENS`.`manufacturer_id` AS `manufacturer_id`,`LENS`.`model` AS `model`,`LENS`.`closest_focus` AS `closest_focus`,`LENS`.`max_aperture` AS `max_aperture`,`LENS`.`min_aperture` AS `min_aperture`,`LENS`.`elements` AS `elements`,`LENS`.`groups` AS `groups`,`LENS`.`weight` AS `weight`,`LENS`.`nominal_min_angle_diag` AS `nominal_min_angle_diag`,`LENS`.`nominal_max_angle_diag` AS `nominal_max_angle_diag`,round(((360 * atan(sqrt((pow(`NEGATIVE_SIZE`.`width`,2) + pow(`NEGATIVE_SIZE`.`height`,2))),(2 * `LENS`.`max_focal_length`))) / pi()),0) AS `calc_min_angle_diag`,round(((360 * atan(sqrt((pow(`NEGATIVE_SIZE`.`width`,2) + pow(`NEGATIVE_SIZE`.`height`,2))),(2 * `LENS`.`min_focal_length`))) / pi()),0) AS `calc_max_angle_diag`,round(((360 * atan(`NEGATIVE_SIZE`.`width`,(2 * `LENS`.`max_focal_length`))) / pi()),0) AS `calc_min_angle_horiz`,round(((360 * atan(`NEGATIVE_SIZE`.`width`,(2 * `LENS`.`min_focal_length`))) / pi()),0) AS `calc_max_angle_horiz`,round(((360 * atan(`NEGATIVE_SIZE`.`height`,(2 * `LENS`.`max_focal_length`))) / pi()),0) AS `calc_min_angle_vert`,round(((360 * atan(`NEGATIVE_SIZE`.`height`,(2 * `LENS`.`min_focal_length`))) / pi()),0) AS `calc_max_angle_vert`,`LENS`.`aperture_blades` AS `aperture_blades`,`LENS`.`autofocus` AS `autofocus`,`LENS`.`filter_thread` AS `filter_thread`,`LENS`.`magnification` AS `magnification`,`LENS`.`url` AS `url`,`LENS`.`serial` AS `serial`,`LENS`.`date_code` AS `date_code`,`LENS`.`introduced` AS `introduced`,`LENS`.`discontinued` AS `discontinued`,`LENS`.`manufactured` AS `manufactured`,`LENS`.`negative_size_id` AS `negative_size_id`,`LENS`.`acquired` AS `acquired`,`LENS`.`cost` AS `cost`,`LENS`.`fixed_mount` AS `fixed_mount`,`LENS`.`notes` AS `notes`,`LENS`.`own` AS `own`,`LENS`.`lost` AS `lost`,`LENS`.`lost_price` AS `lost_price`,`LENS`.`source` AS `source`,`LENS`.`coating` AS `coating`,`LENS`.`hood` AS `hood`,`LENS`.`exif_lenstype` AS `exif_lenstype`,`LENS`.`rectilinear` AS `rectilinear`,`LENS`.`length` AS `length`,`LENS`.`diameter` AS `diameter`,`LENS`.`condition_id` AS `condition_id`,`LENS`.`image_circle` AS `image_circle`,`LENS`.`formula` AS `formula`,`LENS`.`shutter_model` AS `shutter_model` from (`LENS` join `NEGATIVE_SIZE`) where ((`LENS`.`negative_size_id` = `NEGATIVE_SIZE`.`negative_size_id`) and (`LENS`.`min_focal_length` is not null) and (`LENS`.`max_focal_length` is not null)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
