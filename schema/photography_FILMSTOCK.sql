/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FILMSTOCK` (
  `filmstock_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of the filmstock',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'ID of the manufacturer of the film',
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of the film',
  `iso` int(11) DEFAULT NULL COMMENT 'Nominal ISO speed of the film',
  `colour` tinyint(1) DEFAULT NULL COMMENT 'Whether the film is colour',
  `process_id` int(11) DEFAULT NULL COMMENT 'ID of the normal process for this film',
  `panchromatic` tinyint(1) DEFAULT NULL COMMENT 'Whether this film is panchromatic',
  PRIMARY KEY (`filmstock_id`),
  KEY `fk_manufacturer_id` (`manufacturer_id`),
  CONSTRAINT `fk_manufacturer_id` FOREIGN KEY (`manufacturer_id`) REFERENCES `MANUFACTURER` (`manufacturer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to list different brands of film stock';
/*!40101 SET character_set_client = @saved_cs_client */;
