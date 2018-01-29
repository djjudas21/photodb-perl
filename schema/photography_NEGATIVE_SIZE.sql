/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NEGATIVE_SIZE` (
  `negative_size_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of negative size',
  `width` decimal(4,1) DEFAULT NULL COMMENT 'Width of the negative size in mm',
  `height` decimal(4,1) DEFAULT NULL COMMENT 'Height of the negative size in mm',
  `negative_size` varchar(45) DEFAULT NULL COMMENT 'Common name of the negative size (e.g. 35mm, 6x7, etc)',
  `crop_factor` decimal(4,2) DEFAULT NULL COMMENT 'Crop factor of this negative size',
  `area` int(11) DEFAULT NULL COMMENT 'Area of this negative size in sq. mm',
  `aspect_ratio` decimal(4,2) DEFAULT NULL COMMENT 'Aspect ratio of this negative size, expressed as a single decimal. (e.g. 3:2 is expressed as 1.5)',
  PRIMARY KEY (`negative_size_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
