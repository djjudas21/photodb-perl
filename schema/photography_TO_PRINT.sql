/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TO_PRINT` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of this table',
  `negative_id` int(11) DEFAULT NULL COMMENT 'Negative ID to be printed',
  `width` int(11) DEFAULT NULL COMMENT 'Width of print to be made',
  `height` int(11) DEFAULT NULL COMMENT 'Height of print to be made',
  `printed` tinyint(1) DEFAULT '0' COMMENT 'Whether the print has been made',
  `print_id` int(11) DEFAULT NULL COMMENT 'ID of print made',
  `recipient` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `added` date DEFAULT NULL COMMENT 'Date that record was added',
  PRIMARY KEY (`id`),
  KEY `fk_TO_PRINT_1_idx` (`negative_id`),
  CONSTRAINT `fk_TO_PRINT_1` FOREIGN KEY (`negative_id`) REFERENCES `NEGATIVE` (`negative_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalogue negatives that should be printed';
/*!40101 SET character_set_client = @saved_cs_client */;
