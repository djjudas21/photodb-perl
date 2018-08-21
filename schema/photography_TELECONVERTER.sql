/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TELECONVERTER` (
  `teleconverter_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of this teleconverter',
  `mount_id` int(11) DEFAULT NULL COMMENT 'ID of the lens mount used by this teleconverter',
  `factor` decimal(4,2) DEFAULT NULL COMMENT 'Magnification factor of this teleconverter (numerical part only, e.g. 1.4)',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'ID of the manufacturer of this teleconverter',
  `model` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `elements` tinyint(4) DEFAULT NULL COMMENT 'Number of optical elements used in this teleconverter',
  `groups` tinyint(4) DEFAULT NULL COMMENT 'Number of optical groups used in this teleconverter',
  `multicoated` tinyint(1) DEFAULT NULL COMMENT 'Whether this teleconverter is multi-coated',
  PRIMARY KEY (`teleconverter_id`),
  KEY `fk_TELECONVERTER_1` (`manufacturer_id`),
  KEY `fk_TELECONVERTER_2` (`mount_id`),
  CONSTRAINT `fk_TELECONVERTER_1` FOREIGN KEY (`manufacturer_id`) REFERENCES `MANUFACTURER` (`manufacturer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_TELECONVERTER_2` FOREIGN KEY (`mount_id`) REFERENCES `MOUNT` (`mount_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog teleconverters (multipliers)';
/*!40101 SET character_set_client = @saved_cs_client */;
