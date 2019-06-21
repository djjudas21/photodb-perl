/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SCAN` (
  `scan_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for this scan',
  `negative_id` int(11) DEFAULT NULL COMMENT 'ID of the negative that was scanned',
  `print_id` int(11) DEFAULT NULL COMMENT 'ID of the print  that was scanned',
  `filename` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Filename of the scan',
  `date` date DEFAULT NULL COMMENT 'Date that this scan was made',
  `colour` tinyint(1) DEFAULT NULL COMMENT 'Whether this is a colour image',
  `width` int(11) DEFAULT NULL COMMENT 'Width of the scanned image in pixels',
  `height` int(11) DEFAULT NULL COMMENT 'Height of the scanned image in pixels',
  PRIMARY KEY (`scan_id`),
  KEY `fk_SCAN_1_idx` (`negative_id`),
  KEY `fk_SCAN_2_idx` (`print_id`),
  CONSTRAINT `fk_SCAN_1` FOREIGN KEY (`negative_id`) REFERENCES `NEGATIVE` (`negative_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_SCAN_2` FOREIGN KEY (`print_id`) REFERENCES `PRINT` (`print_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to record all the images that have been scanned digitally';
/*!40101 SET character_set_client = @saved_cs_client */;
