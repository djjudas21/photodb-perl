/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ENLARGER` (
  `enlarger_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique enlarger ID',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'Manufacturer ID of the enlarger',
  `enlarger` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `negative_size_id` int(11) DEFAULT NULL COMMENT 'ID of the largest negative size that the enlarger can handle',
  `acquired` date DEFAULT NULL COMMENT 'Date on which the enlarger was acquired',
  `lost` date DEFAULT NULL COMMENT 'Date on which the enlarger was lost/sold',
  `introduced` year(4) DEFAULT NULL COMMENT 'Year in which the enlarger was introduced',
  `discontinued` year(4) DEFAULT NULL COMMENT 'Year in which the enlarger was discontinued',
  `cost` decimal(6,2) DEFAULT NULL COMMENT 'Purchase cost of the enlarger',
  `lost_price` decimal(6,2) DEFAULT NULL COMMENT 'Sale price of the enlarger',
  PRIMARY KEY (`enlarger_id`),
  KEY `fk_ENLARGER_1` (`manufacturer_id`),
  KEY `fk_ENLARGER_2` (`negative_size_id`),
  CONSTRAINT `fk_ENLARGER_1` FOREIGN KEY (`manufacturer_id`) REFERENCES `MANUFACTURER` (`manufacturer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ENLARGER_2` FOREIGN KEY (`negative_size_id`) REFERENCES `NEGATIVE_SIZE` (`negative_size_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to list enlargers';
/*!40101 SET character_set_client = @saved_cs_client */;
