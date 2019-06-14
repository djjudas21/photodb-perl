/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FLASH` (
  `flash_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of external flash unit',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'Manufacturer ID of the flash',
  `model` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Model name/number of the flash',
  `guide_number` int(11) DEFAULT NULL COMMENT 'Guide number of the flash',
  `gn_info` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Extra freeform info about how the guide number was measured',
  `battery_powered` tinyint(1) DEFAULT NULL COMMENT 'Whether this flash takes batteries',
  `pc_sync` tinyint(1) DEFAULT NULL COMMENT 'Whether the flash has a PC sync socket',
  `hot_shoe` tinyint(1) DEFAULT NULL COMMENT 'Whether the flash has a hot shoe connection',
  `light_stand` tinyint(1) DEFAULT NULL COMMENT 'Whether the flash can be used on a light stand',
  `battery_type_id` int(11) DEFAULT NULL COMMENT 'ID of battery type',
  `battery_qty` int(11) DEFAULT NULL COMMENT 'Quantity of batteries needed in this flash',
  `manual_control` tinyint(1) DEFAULT NULL COMMENT 'Whether this flash offers manual power control',
  `swivel_head` tinyint(1) DEFAULT NULL COMMENT 'Whether this flash has a horizontal swivel head',
  `tilt_head` tinyint(1) DEFAULT NULL COMMENT 'Whether this flash has a vertical tilt head',
  `zoom` tinyint(1) DEFAULT NULL COMMENT 'Whether this flash can zoom',
  `dslr_safe` tinyint(1) DEFAULT NULL COMMENT 'Whether this flash is safe to use with a digital camera',
  `ttl` tinyint(1) DEFAULT NULL COMMENT 'Whether this flash supports TTL metering',
  `flash_protocol_id` int(11) DEFAULT NULL COMMENT 'ID of flash TTL metering protocol',
  `trigger_voltage` decimal(4,1) DEFAULT NULL COMMENT 'Trigger voltage of the flash, in Volts',
  `own` tinyint(1) DEFAULT NULL COMMENT 'Whether we currently own this flash',
  `acquired` date DEFAULT NULL COMMENT 'Date this flash was acquired',
  `cost` decimal(5,2) DEFAULT NULL COMMENT 'Purchase cost of this flash',
  PRIMARY KEY (`flash_id`),
  KEY `fk_FLASH_1_idx` (`flash_protocol_id`),
  KEY `fk_FLASH_2_idx` (`battery_type_id`),
  CONSTRAINT `fk_FLASH_1` FOREIGN KEY (`flash_protocol_id`) REFERENCES `FLASH_PROTOCOL` (`flash_protocol_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_FLASH_2` FOREIGN KEY (`battery_type_id`) REFERENCES `BATTERY` (`battery_type`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catlog flashes, flashguns and speedlights';
/*!40101 SET character_set_client = @saved_cs_client */;
