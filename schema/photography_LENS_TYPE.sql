/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LENS_TYPE` (
  `lens_type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for the type of lens',
  `diagonal_angle_min` int(11) DEFAULT NULL COMMENT 'Minimum diagonal angle of view to quality for this lens type',
  `diagonal_angle_max` int(11) DEFAULT NULL COMMENT 'Maximum diagonal angle of view to quality for this lens type',
  `lens_type` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of the lens type (e.g. Wide Angle, Telephoto, etc)',
  PRIMARY KEY (`lens_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to categorise lenses by type based on angle of view';
/*!40101 SET character_set_client = @saved_cs_client */;
