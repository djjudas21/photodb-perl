/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EXHIBIT` (
  `exhibit_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for this exhibit',
  `exhibition_id` int(11) DEFAULT NULL COMMENT 'ID of the exhibition',
  `print_id` int(11) DEFAULT NULL COMMENT 'ID of the print',
  PRIMARY KEY (`exhibit_id`),
  KEY `fk_EXHIBIT_1_idx` (`exhibition_id`),
  KEY `fk_EXHIBIT_2_idx` (`print_id`),
  CONSTRAINT `fk_EXHIBIT_1` FOREIGN KEY (`exhibition_id`) REFERENCES `EXHIBITION` (`exhibition_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_EXHIBIT_2` FOREIGN KEY (`print_id`) REFERENCES `PRINT` (`print_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to record which prints were displayed in which exhibitions';
/*!40101 SET character_set_client = @saved_cs_client */;
