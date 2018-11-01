/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACCESSORY_COMPAT` (
  `compat_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for this compatibility',
  `accessory_id` int(11) NOT NULL COMMENT 'ID of the accessory',
  `camera_id` int(11) DEFAULT NULL COMMENT 'ID of the compatible camera',
  `lens_id` int(11) DEFAULT NULL COMMENT 'ID of the compatible lens',
  PRIMARY KEY (`compat_id`),
  KEY `fk_ACCESSORY_COMPAT_1_idx` (`accessory_id`),
  KEY `fk_ACCESSORY_COMPAT_2_idx` (`camera_id`),
  KEY `fk_ACCESSORY_COMPAT_3_idx` (`lens_id`),
  CONSTRAINT `fk_ACCESSORY_COMPAT_1` FOREIGN KEY (`accessory_id`) REFERENCES `ACCESSORY` (`accessory_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ACCESSORY_COMPAT_2` FOREIGN KEY (`camera_id`) REFERENCES `CAMERA` (`camera_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ACCESSORY_COMPAT_3` FOREIGN KEY (`lens_id`) REFERENCES `LENS` (`lens_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to define compatibility between accessories and cameras or lenses';
/*!40101 SET character_set_client = @saved_cs_client */;
