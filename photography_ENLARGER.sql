/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ENLARGER` (
  `enlarger_id` int(11) NOT NULL AUTO_INCREMENT,
  `manufacturer_id` int(11) DEFAULT NULL,
  `enlarger` varchar(45) DEFAULT NULL,
  `negative_size_id` int(11) DEFAULT NULL,
  `acquired` date DEFAULT NULL,
  `lost` date DEFAULT NULL,
  `introduced` year(4) DEFAULT NULL,
  `discontinued` year(4) DEFAULT NULL,
  `cost` decimal(6,2) DEFAULT NULL,
  `lost_price` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`enlarger_id`),
  KEY `fk_ENLARGER_1` (`manufacturer_id`),
  KEY `fk_ENLARGER_2` (`negative_size_id`),
  CONSTRAINT `fk_ENLARGER_1` FOREIGN KEY (`manufacturer_id`) REFERENCES `MANUFACTURER` (`manufacturer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ENLARGER_2` FOREIGN KEY (`negative_size_id`) REFERENCES `NEGATIVE_SIZE` (`negative_size_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
