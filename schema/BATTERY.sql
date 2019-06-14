/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BATTERY` (
  `battery_type` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique battery ID',
  `battery_name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Common name of the battery',
  `voltage` decimal(4,2) DEFAULT NULL COMMENT 'Nominal voltage of the battery',
  `chemistry` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Battery chemistry (e.g. Alkaline, Lithium, etc)',
  `other_names` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Alternative names for this kind of battery',
  PRIMARY KEY (`battery_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog of types of battery';
/*!40101 SET character_set_client = @saved_cs_client */;
