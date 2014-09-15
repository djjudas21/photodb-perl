/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FORMULA` (
  `formula_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `elements` int(11) DEFAULT NULL,
  `groups` int(11) DEFAULT NULL,
  `application` varchar(45) DEFAULT NULL,
  `anastigmatic` tinyint(1) DEFAULT NULL,
  `achromatic` tinyint(1) DEFAULT NULL,
  `apochromatic` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`formula_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
