/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DISPLAYLENS` (
  `display_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for this display combination',
  `camera_id` int(11) DEFAULT NULL COMMENT 'Camera ID',
  `lens_id` int(11) DEFAULT NULL COMMENT 'Lens ID',
  PRIMARY KEY (`display_id`),
  UNIQUE KEY `camera_id_UNIQUE` (`camera_id`),
  UNIQUE KEY `lens_id_UNIQUE` (`lens_id`),
  KEY `fk_DISPLAYLENS_1_idx` (`camera_id`),
  KEY `fk_DISPLAYLENS_2_idx` (`lens_id`),
  CONSTRAINT `fk_DISPLAYLENS_1` FOREIGN KEY (`camera_id`) REFERENCES `CAMERA` (`camera_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_DISPLAYLENS_2` FOREIGN KEY (`lens_id`) REFERENCES `LENS` (`lens_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to record which cameras should be displayed with which lens';
/*!40101 SET character_set_client = @saved_cs_client */;
