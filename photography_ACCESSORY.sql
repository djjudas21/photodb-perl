/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACCESSORY` (
  `accessory_id` int(11) NOT NULL AUTO_INCREMENT,
  `accessory` varchar(45) DEFAULT NULL,
  `accessory_type` varchar(45) DEFAULT NULL,
  `manufacturer_id` varchar(45) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  PRIMARY KEY (`accessory_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
