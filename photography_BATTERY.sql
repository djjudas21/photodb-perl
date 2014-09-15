/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BATTERY` (
  `battery_type` int(11) NOT NULL AUTO_INCREMENT,
  `battery_name` varchar(45) DEFAULT NULL,
  `voltage` decimal(4,2) DEFAULT NULL,
  `chemistry` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`battery_type`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
