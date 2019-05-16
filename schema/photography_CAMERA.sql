/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CAMERA` (
  `camera_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Auto-incremented camera ID',
  `cameramodel_id` int(11) DEFAULT NULL COMMENT 'ID which specifies the model of camera',
  `acquired` date DEFAULT NULL COMMENT 'Date on which the camera was acquired',
  `cost` decimal(6,2) DEFAULT NULL COMMENT 'Price paid for the camera, in local currency units',
  `serial` varchar(45) DEFAULT NULL COMMENT 'Serial number of the camera',
  `datecode` varchar(12) DEFAULT NULL COMMENT 'Date code of the camera, if different from the serial number',
  `manufactured` smallint(6) DEFAULT NULL COMMENT 'Year of manufacture of the camera',
  `own` tinyint(1) DEFAULT NULL COMMENT 'Whether the camera is currently owned',
  `lens_id` int(11) DEFAULT NULL COMMENT 'If fixed_mount is true, specify the lens_id',
  `notes` text COMMENT 'Freeform text field for extra notes',
  `lost` date DEFAULT NULL COMMENT 'Date on which the camera was lost/sold/etc',
  `lost_price` decimal(6,2) DEFAULT NULL COMMENT 'Price at which the camera was sold',
  `source` varchar(150) DEFAULT NULL COMMENT 'Where the camera was acquired from',
  `condition_id` int(11) DEFAULT NULL COMMENT 'Denotes the cosmetic condition of the camera',
  `display_lens` int(11) DEFAULT NULL COMMENT 'Lens ID of the lens that this camera should normally be displayed with',
  PRIMARY KEY (`camera_id`),
  UNIQUE KEY `display_lens_UNIQUE` (`display_lens`),
  KEY `fk_CAMERA_3_idx` (`condition_id`),
  KEY `fk_CAMERA_3_idx1` (`display_lens`),
  KEY `fk_CAMERA_6_idx` (`cameramodel_id`),
  CONSTRAINT `fk_CAMERA_3` FOREIGN KEY (`display_lens`) REFERENCES `LENS` (`lens_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CAMERA_5` FOREIGN KEY (`display_lens`) REFERENCES `LENS` (`lens_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CAMERA_6` FOREIGN KEY (`cameramodel_id`) REFERENCES `CAMERAMODEL` (`cameramodel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_condition` FOREIGN KEY (`condition_id`) REFERENCES `CONDITION` (`condition_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Table to catalog cameras - both cameras with fixed lenses and cameras with interchangeable lenses';
/*!40101 SET character_set_client = @saved_cs_client */;
