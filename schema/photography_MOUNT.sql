/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MOUNT` (
  `mount_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of this lens mount',
  `mount` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fixed` tinyint(1) DEFAULT NULL COMMENT 'Whether this is a fixed (non-interchangable) lens mount',
  `shutter_in_lens` tinyint(1) DEFAULT NULL COMMENT 'Whether this lens mount system incorporates the shutter into the lens',
  `type` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purpose` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `digital_only` tinyint(1) DEFAULT NULL COMMENT 'Whether this mount is intended only for digital cameras',
  PRIMARY KEY (`mount_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog different lens mount standards. This is mostly used for camera lens mounts, but can also be used for enlarger and projector lenses.';
/*!40101 SET character_set_client = @saved_cs_client */;
