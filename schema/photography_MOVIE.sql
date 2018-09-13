/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MOVIE` (
  `movie_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for this motion picture film / movie',
  `title` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `camera_id` int(11) DEFAULT NULL COMMENT 'ID of the camera used to shoot this movie',
  `lens_id` int(11) DEFAULT NULL COMMENT 'ID of the lens used to shoot this movie',
  `format_id` int(11) DEFAULT NULL COMMENT 'ID of the film format on which this movie was shot',
  `sound` tinyint(1) DEFAULT NULL COMMENT 'Whether this movie has sound',
  `fps` int(11) DEFAULT NULL COMMENT 'Frame rate of this movie, in fps',
  `filmstock_id` int(11) DEFAULT NULL COMMENT 'ID of the filmstock used to shoot this movie',
  `feet` int(11) DEFAULT NULL COMMENT 'Length of this movie in feet',
  `date_loaded` date DEFAULT NULL COMMENT 'Date that the filmstock was loaded into a camera',
  `date_shot` date DEFAULT NULL COMMENT 'Date on which this movie was shot',
  `date_processed` date DEFAULT NULL COMMENT 'Date on which this movie was processed',
  `process_id` int(11) DEFAULT NULL COMMENT 'ID of the process used to develop this film',
  `description` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`movie_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog motion picture films (movies)';
/*!40101 SET character_set_client = @saved_cs_client */;
