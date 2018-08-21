/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FILTER` (
  `filter_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique filter ID',
  `thread` decimal(4,1) DEFAULT NULL COMMENT 'Diameter of screw thread in mm',
  `type` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attenuation` decimal(2,1) DEFAULT NULL COMMENT 'Attenuation of this filter in decimal stops',
  `qty` int(11) DEFAULT NULL COMMENT 'Quantity of these filters available',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'Denotes the manufacturer of the filter.',
  PRIMARY KEY (`filter_id`),
  KEY `fk_FILTER_1_idx` (`manufacturer_id`),
  CONSTRAINT `fk_FILTER_1` FOREIGN KEY (`manufacturer_id`) REFERENCES `MANUFACTURER` (`manufacturer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog filters';
/*!40101 SET character_set_client = @saved_cs_client */;
