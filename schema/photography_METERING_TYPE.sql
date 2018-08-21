/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `METERING_TYPE` (
  `metering_type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of the metering type',
  `metering` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`metering_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog different metering technologies and cell types';
/*!40101 SET character_set_client = @saved_cs_client */;
