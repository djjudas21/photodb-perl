/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FILTER_ADAPTER` (
  `filter_adapter_id` int(11) NOT NULL AUTO_INCREMENT,
  `camera_thread` decimal(3,1) DEFAULT NULL,
  `filter_thread` decimal(3,1) DEFAULT NULL,
  PRIMARY KEY (`filter_adapter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
