/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `METERING_TYPE` (
  `metering_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `metering` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`metering_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
