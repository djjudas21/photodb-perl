/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REPAIR` (
  `repair_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for the repair job',
  `camera_id` int(11) DEFAULT NULL COMMENT 'ID of camera that was repaired',
  `lens_id` int(11) DEFAULT NULL COMMENT 'ID of lens that was repaired',
  `date` date DEFAULT NULL COMMENT 'The date of the repair',
  `summary` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Brief summary of the repair',
  `description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Longer description of the repair',
  PRIMARY KEY (`repair_id`),
  KEY `fk_REPAIR_1_idx` (`camera_id`),
  KEY `fk_REPAIR_2_idx` (`lens_id`),
  CONSTRAINT `fk_REPAIR_1` FOREIGN KEY (`camera_id`) REFERENCES `CAMERA` (`camera_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_REPAIR_2` FOREIGN KEY (`lens_id`) REFERENCES `LENS` (`lens_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabe to catalog all repairs and servicing undertaken on cameras and lenses in the collection';
/*!40101 SET character_set_client = @saved_cs_client */;
