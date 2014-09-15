/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TELECONVERTER` (
  `teleconverter_id` int(11) NOT NULL AUTO_INCREMENT,
  `mount_id` int(11) DEFAULT NULL,
  `factor` decimal(4,2) DEFAULT NULL,
  `manufacturer_id` int(11) DEFAULT NULL,
  `model` varchar(45) DEFAULT NULL,
  `elements` tinyint(4) DEFAULT NULL,
  `groups` tinyint(4) DEFAULT NULL,
  `multicoated` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`teleconverter_id`),
  KEY `fk_TELECONVERTER_1` (`manufacturer_id`),
  KEY `fk_TELECONVERTER_2` (`mount_id`),
  CONSTRAINT `fk_TELECONVERTER_1` FOREIGN KEY (`manufacturer_id`) REFERENCES `MANUFACTURER` (`manufacturer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_TELECONVERTER_2` FOREIGN KEY (`mount_id`) REFERENCES `MOUNT` (`mount_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
