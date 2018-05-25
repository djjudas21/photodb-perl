/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `METERING_MODE_AVAILABLE` (
  `metering_mode_available_id` int(11) NOT NULL AUTO_INCREMENT,
  `camera_id` int(11) DEFAULT NULL,
  `metering_mode_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`metering_mode_available_id`),
  KEY `fk_METERING_MODE_AVAILABLE_1_idx` (`metering_mode_id`),
  KEY `fk_METERING_MODE_AVAILABLE_2_idx` (`camera_id`),
  CONSTRAINT `fk_METERING_MODE_AVAILABLE_1` FOREIGN KEY (`metering_mode_id`) REFERENCES `METERING_MODE` (`metering_mode_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_METERING_MODE_AVAILABLE_2` FOREIGN KEY (`camera_id`) REFERENCES `CAMERA` (`camera_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
