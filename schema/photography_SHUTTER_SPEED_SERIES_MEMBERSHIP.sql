/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SHUTTER_SPEED_SERIES_MEMBERSHIP` (
  `shutter_speed` varchar(10) CHARACTER SET latin1 NOT NULL COMMENT 'The shutter speed',
  `shutter_speed_series` int(11) NOT NULL COMMENT 'The series the shutter speed belongs to',
  PRIMARY KEY (`shutter_speed`,`shutter_speed_series`),
  KEY `fk_SHUTTER_SPEED_SERIES_MEMBERSHIP_1_idx` (`shutter_speed_series`),
  CONSTRAINT `fk_SHUTTER_SPEED_SERIES_MEMBERSHIP_1` FOREIGN KEY (`shutter_speed_series`) REFERENCES `SHUTTER_SPEED_SERIES` (`shutter_speed_series_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_SHUTTER_SPEED_SERIES_MEMBERSHIP_2` FOREIGN KEY (`shutter_speed`) REFERENCES `SHUTTER_SPEED` (`shutter_speed`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to record which shutter speeds belong to which series';
/*!40101 SET character_set_client = @saved_cs_client */;
