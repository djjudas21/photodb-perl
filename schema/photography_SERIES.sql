/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SERIES` (
  `series_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of this series',
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of this collection, e.g. Canon FD SLRs',
  PRIMARY KEY (`series_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to list all series of cameras and lenses';
/*!40101 SET character_set_client = @saved_cs_client */;
