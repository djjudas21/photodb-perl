/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FORMAT` (
  `format_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for this format',
  `format` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The name of this film/sensor format',
  `digital` tinyint(1) DEFAULT NULL COMMENT 'Whether this is a digital format',
  PRIMARY KEY (`format_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalogue different film formats. These are distinct from negative sizes.';
/*!40101 SET character_set_client = @saved_cs_client */;
