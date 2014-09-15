/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DEVELOPER` (
  `developer_id` int(11) NOT NULL AUTO_INCREMENT,
  `manufacturer_id` int(11) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `for_paper` tinyint(1) DEFAULT NULL,
  `for_film` tinyint(1) DEFAULT NULL,
  `chemistry` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`developer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
