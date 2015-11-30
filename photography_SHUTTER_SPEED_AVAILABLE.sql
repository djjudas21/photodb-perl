/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SHUTTER_SPEED_AVAILABLE` (
  `shutter_speed_available_id` int(11) NOT NULL AUTO_INCREMENT,
  `camera_id` int(11) NOT NULL,
  `shutter_speed` varchar(10) NOT NULL,
  PRIMARY KEY (`shutter_speed_available_id`),
  KEY `fk_SHUTTER_SPEED_AVAILABLE_1_idx` (`shutter_speed`),
  KEY `fk_SHUTTER_SPEED_AVAILABLE_2_idx` (`camera_id`),
  CONSTRAINT `fk_SHUTTER_SPEED_AVAILABLE_1` FOREIGN KEY (`shutter_speed`) REFERENCES `SHUTTER_SPEED` (`shutter_speed`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
