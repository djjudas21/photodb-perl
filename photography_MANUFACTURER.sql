/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MANUFACTURER` (
  `manufacturer_id` int(11) NOT NULL AUTO_INCREMENT,
  `manufacturer` varchar(45) DEFAULT NULL,
  ` city` varchar(45) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  `url` varchar(45) DEFAULT NULL,
  `founded` smallint(6) DEFAULT NULL,
  `dissolved` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`manufacturer_id`),
  UNIQUE KEY `manufacturer_UNIQUE` (`manufacturer`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
