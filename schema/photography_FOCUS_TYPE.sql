/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FOCUS_TYPE` (
  `focus_type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of focus type',
  `focus_type` varchar(45) DEFAULT NULL COMMENT 'Name of focus type',
  PRIMARY KEY (`focus_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table to catalog different focusing methods';
/*!40101 SET character_set_client = @saved_cs_client */;
