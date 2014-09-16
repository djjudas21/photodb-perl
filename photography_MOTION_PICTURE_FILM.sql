/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MOTION_PICTURE_FILM` (
  `mp_film_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for this motion picture film / movie',
  `title` varchar(45) DEFAULT NULL COMMENT 'Title of this movie',
  `camera_id` int(11) DEFAULT NULL COMMENT 'ID of the camera used to shoot this movie',
  `lens_id` int(11) DEFAULT NULL COMMENT 'ID of the lens used to shoot this movie',
  `format_id` int(11) DEFAULT NULL COMMENT 'ID of the film format on which this movie was shot',
  `sound` tinyint(1) DEFAULT NULL COMMENT 'Whether this movie has sound',
  `fps` int(11) DEFAULT NULL COMMENT 'Frame rate of thsi movie, in fps',
  `filmstock_id` int(11) DEFAULT NULL COMMENT 'ID of the filmstock used to shoot this movie',
  `feet` int(11) DEFAULT NULL COMMENT 'Length of this movie in feet',
  `date_shot` date DEFAULT NULL COMMENT 'Date on which this movie was shot',
  `process_id` int(11) DEFAULT NULL COMMENT 'ID of the process used to develop this film',
  `description` varchar(45) DEFAULT NULL COMMENT 'Freeform text description of this movie',
  PRIMARY KEY (`mp_film_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
