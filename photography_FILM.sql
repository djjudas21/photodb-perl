/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FILM` (
  `film_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of the film',
  `filmstock_id` int(11) DEFAULT NULL COMMENT 'ID of the filmstock used',
  `exposed_at` int(11) DEFAULT NULL COMMENT 'ISO at which the film was exposed',
  `format_id` int(11) DEFAULT NULL COMMENT 'ID of the film format',
  `date_loaded` date DEFAULT NULL COMMENT 'Date when the film was loaded into a camera',
  `date` date DEFAULT NULL COMMENT 'Date when the film was processed',
  `camera_id` int(11) DEFAULT NULL COMMENT 'ID of the camera that exposed this film',
  `notes` varchar(145) DEFAULT NULL COMMENT 'Title of the film',
  `frames` int(11) DEFAULT NULL COMMENT 'Expected (not actual) number of frames from the film',
  `developer_id` int(11) DEFAULT NULL COMMENT 'ID of the developer used to process this film',
  `directory` varchar(100) DEFAULT NULL COMMENT 'Name of the directory that contains the scanned images from this film',
  `photographer_id` int(11) DEFAULT NULL COMMENT 'ID of the photographer who took these pictures',
  `dev_uses` int(11) DEFAULT NULL COMMENT 'Numnber of previous uses of the developer',
  `dev_time` time DEFAULT NULL COMMENT 'Duration of development',
  `dev_temp` decimal(3,1) DEFAULT NULL COMMENT 'Temperature of development',
  `dev_n` int(11) DEFAULT NULL COMMENT 'Number of the Push/Pull rating of the film, e.g. N+1, N-2',
  `development_notes` varchar(200) DEFAULT NULL COMMENT 'Extra freeform notes about the development process',
  `film_bulk_id` int(11) DEFAULT NULL COMMENT 'ID of bulk film from which this film was cut',
  `film_bulk_loaded` date DEFAULT NULL COMMENT 'Date that this film was cut from a bulk roll',
  `film_batch` varchar(45) DEFAULT NULL COMMENT 'Batch number of the film',
  `film_expiry` date DEFAULT NULL COMMENT 'Expiry date of the film',
  `purchase_date` date DEFAULT NULL COMMENT 'Date this film was purchased',
  `price` decimal(4,2) DEFAULT NULL COMMENT 'Price paid for this film',
  `processed_by` varchar(45) DEFAULT NULL COMMENT 'Person or place that processed this film',
  PRIMARY KEY (`film_id`),
  KEY `fk_filmstock_id` (`filmstock_id`),
  KEY `fk_camera_id` (`camera_id`),
  KEY `fk_format_id` (`format_id`),
  KEY `fk_FILM_1` (`developer_id`),
  KEY `fk_FILM_2_idx` (`photographer_id`),
  CONSTRAINT `fk_FILM_1` FOREIGN KEY (`developer_id`) REFERENCES `DEVELOPER` (`developer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_FILM_2` FOREIGN KEY (`photographer_id`) REFERENCES `PHOTOGRAPHER` (`photographer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_camera_id` FOREIGN KEY (`camera_id`) REFERENCES `CAMERA` (`camera_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_filmstock_id` FOREIGN KEY (`filmstock_id`) REFERENCES `FILMSTOCK` (`filmstock_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_format_id` FOREIGN KEY (`format_id`) REFERENCES `FORMAT` (`format_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
