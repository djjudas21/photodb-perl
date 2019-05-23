/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ARCHIVE` (
  `archive_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of this archive',
  `archive_type_id` int(11) DEFAULT NULL COMMENT 'ID of this type of archive',
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of this archive',
  `max_width` int(11) DEFAULT NULL COMMENT 'Maximum width of media that this archive can store',
  `max_height` int(11) DEFAULT NULL COMMENT 'Maximum height of media that this archive can store',
  `location` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Location of this archive',
  `storage` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The type of storage used for this archive, e.g. box, folder, ringbinder, etc',
  `sealed` tinyint(1) DEFAULT 0 COMMENT 'Whether or not this archive is sealed (closed to new additions)',
  PRIMARY KEY (`archive_id`),
  KEY `fk_ARCHIVE_3_idx` (`archive_type_id`),
  CONSTRAINT `fk_ARCHIVE_3` FOREIGN KEY (`archive_type_id`) REFERENCES `ARCHIVE_TYPE` (`archive_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to list all archives that exist for storing physical media';
/*!40101 SET character_set_client = @saved_cs_client */;
