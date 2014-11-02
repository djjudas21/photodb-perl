/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `METERING_PATTERN` (
  `metering_pattern_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of the metering pattern',
  `metering_pattern` varchar(45) DEFAULT NULL COMMENT 'Name of the metering mode/pattern (e.g. Centre-weighted)',
  PRIMARY KEY (`metering_pattern_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
