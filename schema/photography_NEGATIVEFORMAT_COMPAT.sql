/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NEGATIVEFORMAT_COMPAT` (
  `format_id` int(11) NOT NULL COMMENT 'ID of the film format',
  `negative_size_id` int(11) NOT NULL COMMENT 'ID of the negative size',
  PRIMARY KEY (`format_id`,`negative_size_id`),
  KEY `negative_size_id_idx` (`negative_size_id`),
  CONSTRAINT `format_id` FOREIGN KEY (`format_id`) REFERENCES `FORMAT` (`format_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `negative_size_id` FOREIGN KEY (`negative_size_id`) REFERENCES `NEGATIVE_SIZE` (`negative_size_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to record compatibility between film formats and negative sizes';
/*!40101 SET character_set_client = @saved_cs_client */;
