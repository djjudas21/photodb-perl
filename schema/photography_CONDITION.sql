/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CONDITION` (
  `condition_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique condition ID',
  `code` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Condition shortcode (e.g. EXC)',
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Full name of condition (e.g. Excellent)',
  `min_rating` int(11) DEFAULT NULL COMMENT 'The lowest percentage rating that encompasses this condition',
  `max_rating` int(11) DEFAULT NULL COMMENT 'The highest percentage rating that encompasses this condition',
  `description` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Longer description of condition',
  PRIMARY KEY (`condition_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to list of physical condition descriptions that can be used to evaluate equipment';
/*!40101 SET character_set_client = @saved_cs_client */;
