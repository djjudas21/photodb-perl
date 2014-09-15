/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MOTION_PICTURE_FILM` (
  `mp_film_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) DEFAULT NULL,
  `camera_id` int(11) DEFAULT NULL,
  `lens_id` int(11) DEFAULT NULL,
  `format_id` int(11) DEFAULT NULL,
  `sound` tinyint(1) DEFAULT NULL,
  `fps` int(11) DEFAULT NULL,
  `filmstock_id` int(11) DEFAULT NULL,
  `feet` int(11) DEFAULT NULL,
  `date_shot` date DEFAULT NULL,
  `process_id` int(11) DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`mp_film_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
