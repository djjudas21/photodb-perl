/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EXHIBITION` (
  `exhibition_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for this exhibition',
  `title` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Title of the exhibition',
  `location` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Location of the exhibition',
  `start_date` date DEFAULT NULL COMMENT 'Start date of the exhibition',
  `end_date` date DEFAULT NULL COMMENT 'End date of the exhibition',
  PRIMARY KEY (`exhibition_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to record exhibition events';
/*!40101 SET character_set_client = @saved_cs_client */;
