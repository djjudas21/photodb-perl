/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `METERING_MODE_AVAILABLE` (
  `cameramodel_id` int(11) NOT NULL COMMENT 'ID of camera model',
  `metering_mode_id` int(11) NOT NULL COMMENT 'ID of metering mode',
  PRIMARY KEY (`cameramodel_id`,`metering_mode_id`),
  KEY `fk_METERING_MODE_AVAILABLE_2_idx` (`metering_mode_id`),
  KEY `fk_METERING_MODE_AVAILABLE_1_idx` (`cameramodel_id`),
  CONSTRAINT `fk_METERING_MODE_AVAILABLE_1` FOREIGN KEY (`cameramodel_id`) REFERENCES `CAMERAMODEL` (`cameramodel_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_METERING_MODE_AVAILABLE_2` FOREIGN KEY (`metering_mode_id`) REFERENCES `METERING_MODE` (`metering_mode_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to associate cameras with available metering modes';
/*!40101 SET character_set_client = @saved_cs_client */;
