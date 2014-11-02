/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BATTERY` (
  `battery_type` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique battery ID',
  `battery_name` varchar(45) DEFAULT NULL COMMENT 'Common name of the battery',
  `voltage` decimal(4,2) DEFAULT NULL COMMENT 'Nominal voltage of the battery',
  `chemistry` varchar(45) DEFAULT NULL COMMENT 'Battery chemistry (e.g. Alkaline, Lithium, etc)',
  `other_names` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`battery_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
