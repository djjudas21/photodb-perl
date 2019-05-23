/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LENS` (
  `lens_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for this lens',
  `lensmodel_id` int(11) DEFAULT NULL,
  `serial` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Serial number of this lens',
  `date_code` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Date code of this lens, if different from the serial number',
  `manufactured` smallint(6) DEFAULT NULL COMMENT 'Year in which this specific lens was manufactured',
  `acquired` date DEFAULT NULL COMMENT 'Date on which this lens was acquired',
  `cost` decimal(6,2) DEFAULT NULL COMMENT 'Price paid for this lens in local currency units',
  `notes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Freeform notes field',
  `own` tinyint(1) DEFAULT NULL COMMENT 'Whether we currently own this lens',
  `lost` date DEFAULT NULL COMMENT 'Date on which lens was lost/sold/disposed',
  `lost_price` decimal(6,2) DEFAULT NULL COMMENT 'Price for which the lens was sold',
  `source` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Place where the lens was acquired from',
  `condition_id` int(11) DEFAULT NULL COMMENT 'Denotes the cosmetic condition of the camera',
  PRIMARY KEY (`lens_id`),
  KEY `fk_LENS_1_idx` (`condition_id`),
  KEY `fk_LENS_5_idx` (`lensmodel_id`),
  CONSTRAINT `fk_LENS_1` FOREIGN KEY (`condition_id`) REFERENCES `CONDITION` (`condition_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_LENS_5` FOREIGN KEY (`lensmodel_id`) REFERENCES `LENSMODEL` (`lensmodel_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog lenses';
/*!40101 SET character_set_client = @saved_cs_client */;
