/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EXPOSURE_PROGRAM_AVAILABLE` (
  `camera_id` int(11) NOT NULL COMMENT 'ID of camera',
  `exposure_program_id` int(11) NOT NULL COMMENT 'ID of exposure program',
  PRIMARY KEY (`camera_id`,`exposure_program_id`),
  KEY `fk_EXPOSURE_PROGRAM_AVAILABLE_1_idx` (`camera_id`),
  KEY `fk_EXPOSURE_PROGRAM_AVAILABLE_2_idx` (`exposure_program_id`),
  CONSTRAINT `fk_EXPOSURE_PROGRAM_AVAILABLE_1` FOREIGN KEY (`camera_id`) REFERENCES `CAMERA` (`camera_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_EXPOSURE_PROGRAM_AVAILABLE_2` FOREIGN KEY (`exposure_program_id`) REFERENCES `EXPOSURE_PROGRAM` (`exposure_program_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table to associate cameras with available exposure programs';
/*!40101 SET character_set_client = @saved_cs_client */;
