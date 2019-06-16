/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FILM_BULK` (
  `film_bulk_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of this bulk roll of film',
  `format_id` int(11) DEFAULT NULL COMMENT 'ID of the format of this bulk roll',
  `filmstock_id` int(11) DEFAULT NULL COMMENT 'ID of the filmstock',
  `purchase_date` date DEFAULT NULL COMMENT 'Purchase date of this bulk roll',
  `cost` decimal(5,2) DEFAULT NULL COMMENT 'Purchase cost of this bulk roll',
  `source` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Place where this bulk roll was bought from',
  `batch` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Batch code of this bulk roll',
  `expiry` date DEFAULT NULL COMMENT 'Expiry date of this bulk roll',
  PRIMARY KEY (`film_bulk_id`),
  KEY `fk_FILM_BULK_1_idx` (`format_id`),
  KEY `fk_FILM_BULK_2_idx` (`filmstock_id`),
  CONSTRAINT `fk_FILM_BULK_1` FOREIGN KEY (`format_id`) REFERENCES `FORMAT` (`format_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_FILM_BULK_2` FOREIGN KEY (`filmstock_id`) REFERENCES `FILMSTOCK` (`filmstock_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to record bulk film stock, from which individual films can be cut';
/*!40101 SET character_set_client = @saved_cs_client */;
