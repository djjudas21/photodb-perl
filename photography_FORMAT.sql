/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FORMAT` (
  `format_id` int(11) NOT NULL AUTO_INCREMENT,
  `format` varchar(45) DEFAULT NULL,
  `digital` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`format_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
