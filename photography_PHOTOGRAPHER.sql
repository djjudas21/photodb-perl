/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PHOTOGRAPHER` (
  `photographer_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for the photographer',
  `name` varchar(45) DEFAULT NULL COMMENT 'Name of the photographer',
  PRIMARY KEY (`photographer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
