/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MOUNT_ADAPTER` (
  `mount_adapter_id` int(11) NOT NULL AUTO_INCREMENT,
  `lens_mount` int(11) DEFAULT NULL,
  `camera_mount` int(11) DEFAULT NULL,
  `has_optics` tinyint(1) DEFAULT NULL,
  `infinity_focus` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`mount_adapter_id`),
  KEY `fk_MOUNT_ADAPTER_1` (`lens_mount`),
  KEY `fk_MOUNT_ADAPTER_2` (`camera_mount`),
  CONSTRAINT `fk_MOUNT_ADAPTER_1` FOREIGN KEY (`lens_mount`) REFERENCES `MOUNT` (`mount_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_MOUNT_ADAPTER_2` FOREIGN KEY (`camera_mount`) REFERENCES `MOUNT` (`mount_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
