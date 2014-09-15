/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PROJECTOR` (
  `projector_id` int(11) NOT NULL AUTO_INCREMENT,
  `manufacturer_id` int(11) DEFAULT NULL,
  `model` varchar(45) DEFAULT NULL,
  `mount_id` int(11) DEFAULT NULL,
  `negative_size_id` int(11) DEFAULT NULL,
  `own` tinyint(1) DEFAULT NULL,
  `cine` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`projector_id`),
  KEY `fk_PROJECTOR_1_idx` (`manufacturer_id`),
  KEY `fk_PROJECTOR_2_idx` (`mount_id`),
  KEY `fk_PROJECTOR_3_idx` (`negative_size_id`),
  CONSTRAINT `fk_PROJECTOR_1` FOREIGN KEY (`manufacturer_id`) REFERENCES `MANUFACTURER` (`manufacturer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PROJECTOR_2` FOREIGN KEY (`mount_id`) REFERENCES `MOUNT` (`mount_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PROJECTOR_3` FOREIGN KEY (`negative_size_id`) REFERENCES `NEGATIVE_SIZE` (`negative_size_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
