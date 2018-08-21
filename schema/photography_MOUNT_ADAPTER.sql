/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MOUNT_ADAPTER` (
  `mount_adapter_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of lens mount adapter',
  `lens_mount` int(11) DEFAULT NULL COMMENT 'ID of the mount used between the adapter and the lens',
  `camera_mount` int(11) DEFAULT NULL COMMENT 'ID of the mount used between the adapter and the camera',
  `has_optics` tinyint(1) DEFAULT NULL COMMENT 'Whether this adapter includes optical elements',
  `infinity_focus` tinyint(1) DEFAULT NULL COMMENT 'Whether this adapter allows infinity focus',
  `notes` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`mount_adapter_id`),
  KEY `fk_MOUNT_ADAPTER_1` (`lens_mount`),
  KEY `fk_MOUNT_ADAPTER_2` (`camera_mount`),
  CONSTRAINT `fk_MOUNT_ADAPTER_1` FOREIGN KEY (`lens_mount`) REFERENCES `MOUNT` (`mount_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_MOUNT_ADAPTER_2` FOREIGN KEY (`camera_mount`) REFERENCES `MOUNT` (`mount_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog adapters to mount lenses on other cameras';
/*!40101 SET character_set_client = @saved_cs_client */;
