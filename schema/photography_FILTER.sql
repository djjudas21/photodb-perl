/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FILTER` (
  `filter_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique filter ID',
  `thread` decimal(4,1) DEFAULT NULL COMMENT 'Diameter of screw thread in mm',
  `type` varchar(45) DEFAULT NULL COMMENT 'Filter type (e.g. Red, CPL, UV)',
  `attenuation` decimal(2,1) DEFAULT NULL COMMENT 'Attenuation of this filter in decimal stops',
  `qty` int(11) DEFAULT NULL COMMENT 'Quantity of these filters available',
  PRIMARY KEY (`filter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
