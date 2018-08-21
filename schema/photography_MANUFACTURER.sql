/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MANUFACTURER` (
  `manufacturer_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of the manufacturer',
  `manufacturer` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `founded` smallint(6) DEFAULT NULL COMMENT 'Year in which the manufacturer was founded',
  `dissolved` smallint(6) DEFAULT NULL COMMENT 'Year in which the manufacturer was dissolved',
  PRIMARY KEY (`manufacturer_id`),
  UNIQUE KEY `manufacturer_UNIQUE` (`manufacturer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog manufacturers of equipment and consumables';
/*!40101 SET character_set_client = @saved_cs_client */;
