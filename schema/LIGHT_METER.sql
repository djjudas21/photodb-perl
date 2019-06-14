/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LIGHT_METER` (
  `light_meter_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for this light meter',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'Denotes ID of manufacturer of the light meter',
  `model` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Model name or number of the light meter',
  `metering_type` int(11) DEFAULT NULL COMMENT 'ID of metering technology used in this light meter',
  `reflected` tinyint(1) DEFAULT NULL COMMENT 'Whether the meter is capable of reflected-light metering',
  `incident` tinyint(1) DEFAULT NULL COMMENT 'Whether the meter is capable of incident-light metering',
  `flash` tinyint(1) DEFAULT NULL COMMENT 'Whether the meter is capable of flash metering',
  `spot` tinyint(1) DEFAULT NULL COMMENT 'Whether the meter is capable of spot metering',
  `min_asa` int(11) DEFAULT NULL COMMENT 'Minimum ISO/ASA that this meter is capable of handling',
  `max_asa` int(11) DEFAULT NULL COMMENT 'Maximum ISO/ASA that this meter is capable of handling',
  `min_lv` int(11) DEFAULT NULL COMMENT 'Minimum light value (LV/EV) that this meter is capable of handling',
  `max_lv` int(11) DEFAULT NULL COMMENT 'Maximum light value (LV/EV) that this meter is capable of handling',
  PRIMARY KEY (`light_meter_id`),
  KEY `fk_LIGHT_METER_1_idx` (`manufacturer_id`),
  KEY `fk_LIGHT_METER_2_idx` (`metering_type`),
  CONSTRAINT `fk_LIGHT_METER_1` FOREIGN KEY (`manufacturer_id`) REFERENCES `MANUFACTURER` (`manufacturer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_LIGHT_METER_2` FOREIGN KEY (`metering_type`) REFERENCES `METERING_TYPE` (`metering_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog light meters';
/*!40101 SET character_set_client = @saved_cs_client */;
