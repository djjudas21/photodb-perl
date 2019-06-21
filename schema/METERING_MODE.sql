/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `METERING_MODE` (
  `metering_mode_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID of metering mode as defined by EXIF tag MeteringMode',
  `metering_mode` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of metering mode as defined by EXIF tag MeteringMode',
  PRIMARY KEY (`metering_mode_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Metering modes as defined by EXIF tag MeteringMode';
/*!40101 SET character_set_client = @saved_cs_client */;
