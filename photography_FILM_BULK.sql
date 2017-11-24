/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FILM_BULK` (
  `film_bulk_id` int(11) NOT NULL AUTO_INCREMENT,
  `format_id` int(11) DEFAULT NULL,
  `filmstock_id` int(11) DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `cost` decimal(5,2) DEFAULT NULL,
  `source` varchar(45) DEFAULT NULL,
  `batch` varchar(45) DEFAULT NULL,
  `expiry` date DEFAULT NULL,
  PRIMARY KEY (`film_bulk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
