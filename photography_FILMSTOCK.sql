/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FILMSTOCK` (
  `filmstock_id` int(11) NOT NULL AUTO_INCREMENT,
  `manufacturer_id` int(11) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `iso` int(11) DEFAULT NULL,
  `colour` tinyint(1) DEFAULT NULL,
  `process_id` int(11) DEFAULT NULL,
  `ei_dull` int(11) DEFAULT NULL,
  `ei_brightovercast` int(11) DEFAULT NULL,
  `ei_sunny` int(11) DEFAULT NULL,
  `panchromatic` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`filmstock_id`),
  KEY `fk_manufacturer_id` (`manufacturer_id`),
  CONSTRAINT `fk_manufacturer_id` FOREIGN KEY (`manufacturer_id`) REFERENCES `MANUFACTURER` (`manufacturer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
