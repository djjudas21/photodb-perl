/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PROJECTOR` (
  `projector_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of this projector',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'ID of the manufacturer of this projector',
  `model` varchar(45) DEFAULT NULL COMMENT 'Model name of this projector',
  `mount_id` int(11) DEFAULT NULL COMMENT 'ID of the lens mount of this projector, if it has interchangeable lenses',
  `negative_size_id` int(11) DEFAULT NULL COMMENT 'ID of the largest negative size that this projector can handle',
  `own` tinyint(1) DEFAULT NULL COMMENT 'Whether we currently own this projector',
  `cine` tinyint(1) DEFAULT NULL COMMENT 'Whether this is a cine (movie) projector',
  PRIMARY KEY (`projector_id`),
  KEY `fk_PROJECTOR_1_idx` (`manufacturer_id`),
  KEY `fk_PROJECTOR_2_idx` (`mount_id`),
  KEY `fk_PROJECTOR_3_idx` (`negative_size_id`),
  CONSTRAINT `fk_PROJECTOR_1` FOREIGN KEY (`manufacturer_id`) REFERENCES `MANUFACTURER` (`manufacturer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PROJECTOR_2` FOREIGN KEY (`mount_id`) REFERENCES `MOUNT` (`mount_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PROJECTOR_3` FOREIGN KEY (`negative_size_id`) REFERENCES `NEGATIVE_SIZE` (`negative_size_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table to catalog projectors (still and movie)';
/*!40101 SET character_set_client = @saved_cs_client */;
