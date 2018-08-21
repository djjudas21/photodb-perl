/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MOUNT` (
  `mount_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of this lens mount',
  `mount` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of this lens mount (e.g. Canon FD)',
  `fixed` tinyint(1) DEFAULT NULL COMMENT 'Whether this is a fixed (non-interchangable) lens mount',
  `shutter_in_lens` tinyint(1) DEFAULT NULL COMMENT 'Whether this lens mount system incorporates the shutter into the lens',
  `type` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The physical mount type of this lens mount (e.g. Screw, Bayonet, etc)',
  `purpose` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The intended purpose of this lens mount (e.g. camera, enlarger, projector)',
  `notes` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Freeform notes field',
  `digital_only` tinyint(1) DEFAULT NULL COMMENT 'Whether this mount is intended only for digital cameras',
  PRIMARY KEY (`mount_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog different lens mount standards. This is mostly used for camera lens mounts, but can also be used for enlarger and projector lenses.';
/*!40101 SET character_set_client = @saved_cs_client */;
