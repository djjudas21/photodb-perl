/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NEGATIVE` (
  `negative_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of this negative',
  `film_id` int(11) DEFAULT NULL COMMENT 'ID of the film that this negative belongs to',
  `frame` varchar(5) DEFAULT NULL COMMENT 'Frame number or code of this negative',
  `description` varchar(145) DEFAULT NULL COMMENT 'Caption of this picture',
  `date` date DEFAULT NULL COMMENT 'Date on which this picture was taken',
  `lens_id` int(11) DEFAULT NULL COMMENT 'ID of lens used to take this picture',
  `shutter_speed` varchar(45) DEFAULT NULL COMMENT 'Shutter speed used to take this picture',
  `aperture` decimal(4,1) DEFAULT NULL COMMENT 'Aperture used to take this picture (numerical part only)',
  `filter_id` int(11) DEFAULT NULL COMMENT 'ID of filter used to take this picture',
  `teleconverter_id` int(11) DEFAULT NULL COMMENT 'ID of teleconverter used to take this picture',
  `notes` text COMMENT 'Extra freeform notes about this exposure',
  `mount_adapter_id` int(11) DEFAULT NULL COMMENT 'ID of lens mount adapter used to take this pciture',
  `focal_length` int(11) DEFAULT NULL COMMENT 'If a zoom lens was used, specify the focal length of the lens',
  `latitude` decimal(9,6) DEFAULT NULL COMMENT 'Latitude of the location where the picture was taken',
  `longitude` decimal(9,6) DEFAULT NULL COMMENT 'Longitude of the location where the picture was taken',
  `filename` varchar(100) DEFAULT NULL COMMENT 'Filename of the scanned image file from this negative',
  PRIMARY KEY (`negative_id`),
  KEY `fk_NEGATIVE_1` (`film_id`),
  KEY `fk_NEGATIVE_2` (`lens_id`),
  KEY `fk_NEGATIVE_3` (`filter_id`),
  KEY `fk_NEGATIVE_4` (`teleconverter_id`),
  KEY `fk_NEGATIVE_5` (`mount_adapter_id`),
  CONSTRAINT `fk_NEGATIVE_1` FOREIGN KEY (`film_id`) REFERENCES `FILM` (`film_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_NEGATIVE_2` FOREIGN KEY (`lens_id`) REFERENCES `LENS` (`lens_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_NEGATIVE_3` FOREIGN KEY (`filter_id`) REFERENCES `FILTER` (`filter_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_NEGATIVE_4` FOREIGN KEY (`teleconverter_id`) REFERENCES `TELECONVERTER` (`teleconverter_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_NEGATIVE_5` FOREIGN KEY (`mount_adapter_id`) REFERENCES `MOUNT_ADAPTER` (`mount_adapter_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4966 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
