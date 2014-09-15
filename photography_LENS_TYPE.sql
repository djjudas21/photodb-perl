/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LENS_TYPE` (
  `lens_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `diagonal_angle_min` int(11) DEFAULT NULL,
  `diagonal_angle_max` int(11) DEFAULT NULL,
  `lens_type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`lens_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
