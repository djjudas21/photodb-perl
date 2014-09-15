/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FILTER` (
  `filter_id` int(11) NOT NULL AUTO_INCREMENT,
  `thread` decimal(4,1) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `attenuation` decimal(1,1) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  PRIMARY KEY (`filter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
