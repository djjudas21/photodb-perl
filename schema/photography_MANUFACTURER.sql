/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MANUFACTURER` (
  `manufacturer_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of the manufacturer',
  `manufacturer` varchar(45) DEFAULT NULL COMMENT 'Name of the manufacturer',
  `city` varchar(45) DEFAULT NULL COMMENT 'City in which the manufacturer is based',
  `country` varchar(45) DEFAULT NULL COMMENT 'Country in which the manufacturer is based',
  `url` varchar(45) DEFAULT NULL COMMENT 'URL to the manufacturer''s main website',
  `founded` smallint(6) DEFAULT NULL COMMENT 'Year in which the manufacturer was founded',
  `dissolved` smallint(6) DEFAULT NULL COMMENT 'Year in which the manufacturer was dissolved',
  PRIMARY KEY (`manufacturer_id`),
  UNIQUE KEY `manufacturer_UNIQUE` (`manufacturer`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table to catalog manufacturers of equipment and consumables';
/*!40101 SET character_set_client = @saved_cs_client */;
