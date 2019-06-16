/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EXPOSURE_PROGRAM_AVAILABLE` (
  `cameramodel_id` int(11) NOT NULL COMMENT 'ID of camera model',
  `exposure_program_id` int(11) NOT NULL COMMENT 'ID of exposure program',
  KEY `fk_EXPOSURE_PROGRAM_AVAILABLE_1_idx` (`cameramodel_id`),
  KEY `fk_EXPOSURE_PROGRAM_AVAILABLE_2_idx` (`exposure_program_id`),
  CONSTRAINT `fk_EXPOSURE_PROGRAM_AVAILABLE_1` FOREIGN KEY (`cameramodel_id`) REFERENCES `CAMERAMODEL` (`cameramodel_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_EXPOSURE_PROGRAM_AVAILABLE_2` FOREIGN KEY (`exposure_program_id`) REFERENCES `EXPOSURE_PROGRAM` (`exposure_program_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to associate cameras with available exposure programs';
/*!40101 SET character_set_client = @saved_cs_client */;
