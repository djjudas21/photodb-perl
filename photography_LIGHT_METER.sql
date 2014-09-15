/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LIGHT_METER` (
  `light_meter_id` int(11) NOT NULL AUTO_INCREMENT,
  `manufacturer_id` int(11) DEFAULT NULL,
  `model` varchar(45) DEFAULT NULL,
  `metering_type` int(11) DEFAULT NULL,
  `reflected` tinyint(1) DEFAULT NULL,
  `incident` tinyint(1) DEFAULT NULL,
  `flash` tinyint(1) DEFAULT NULL,
  `spot` tinyint(1) DEFAULT NULL,
  `min_asa` int(11) DEFAULT NULL,
  `max_asa` int(11) DEFAULT NULL,
  `min_lv` int(11) DEFAULT NULL,
  `max_lv` int(11) DEFAULT NULL,
  PRIMARY KEY (`light_meter_id`),
  KEY `fk_LIGHT_METER_1_idx` (`manufacturer_id`),
  KEY `fk_LIGHT_METER_2_idx` (`metering_type`),
  CONSTRAINT `fk_LIGHT_METER_1` FOREIGN KEY (`manufacturer_id`) REFERENCES `MANUFACTURER` (`manufacturer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_LIGHT_METER_2` FOREIGN KEY (`metering_type`) REFERENCES `METERING_TYPE` (`metering_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
