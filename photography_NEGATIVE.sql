/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NEGATIVE` (
  `negative_id` int(11) NOT NULL AUTO_INCREMENT,
  `film_id` int(11) DEFAULT NULL,
  `frame` varchar(5) DEFAULT NULL,
  `description` varchar(145) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `lens_id` int(11) DEFAULT NULL,
  `shutter_speed` varchar(45) DEFAULT NULL,
  `aperture` decimal(4,1) DEFAULT NULL,
  `filter_id` int(11) DEFAULT NULL,
  `teleconverter_id` int(11) DEFAULT NULL,
  `notes` text,
  `mount_adapter_id` int(11) DEFAULT NULL,
  `focal_length` int(11) DEFAULT NULL,
  `latitude` decimal(9,6) DEFAULT NULL,
  `longitude` decimal(9,6) DEFAULT NULL,
  `filename` varchar(100) DEFAULT NULL,
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
