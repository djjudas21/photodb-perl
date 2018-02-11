/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LOCATION` (
  `loc_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of a location',
  `description` varchar(45) DEFAULT NULL COMMENT 'Name of the location',
  `latitude` decimal(9,6) DEFAULT NULL COMMENT 'Latitude of the location',
  `longitude` decimal(9,6) DEFAULT NULL COMMENT 'Longitude of the location',
  PRIMARY KEY (`loc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table to record commonly-used locations';
/*!40101 SET character_set_client = @saved_cs_client */;
