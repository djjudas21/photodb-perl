/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SHUTTER_SPEED_SERIES` (
  `shutter_speed_series_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID',
  `series` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of the series of shutter speeds',
  PRIMARY KEY (`shutter_speed_series_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to list the different series of shutter speeds, e.g. whole stops, half stops, etc';
/*!40101 SET character_set_client = @saved_cs_client */;
