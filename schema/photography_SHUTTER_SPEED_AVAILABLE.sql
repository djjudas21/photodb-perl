/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SHUTTER_SPEED_AVAILABLE` (
  `cameramodel_id` int(11) NOT NULL COMMENT 'ID of the camera model',
  `shutter_speed` varchar(10) CHARACTER SET latin1 NOT NULL COMMENT 'Shutter speed that this camera has',
  KEY `fk_SHUTTER_SPEED_AVAILABLE_1_idx` (`shutter_speed`),
  KEY `fk_SHUTTER_SPEED_AVAILABLE_2_idx` (`cameramodel_id`),
  CONSTRAINT `fk_SHUTTER_SPEED_AVAILABLE_1` FOREIGN KEY (`shutter_speed`) REFERENCES `SHUTTER_SPEED` (`shutter_speed`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_SHUTTER_SPEED_AVAILABLE_2` FOREIGN KEY (`cameramodel_id`) REFERENCES `CAMERAMODEL` (`cameramodel_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Table to associate cameras with shutter speeds';
/*!40101 SET character_set_client = @saved_cs_client */;
