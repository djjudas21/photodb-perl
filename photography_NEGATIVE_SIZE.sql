/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NEGATIVE_SIZE` (
  `negative_size_id` int(11) NOT NULL AUTO_INCREMENT,
  `width` decimal(4,1) DEFAULT NULL,
  `height` decimal(4,1) DEFAULT NULL,
  `negative_size` varchar(45) DEFAULT NULL,
  `crop_factor` decimal(4,2) DEFAULT NULL,
  `area` int(11) DEFAULT NULL,
  `aspect_ratio` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`negative_size_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
