/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PAPER_STOCK` (
  `paper_stock_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `manufacturer_id` int(11) DEFAULT NULL,
  `resin_coated` tinyint(1) DEFAULT NULL,
  `tonable` tinyint(1) DEFAULT NULL,
  `colour` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`paper_stock_id`),
  KEY `fk_PAPER_STOCK_1` (`manufacturer_id`),
  CONSTRAINT `fk_PAPER_STOCK_1` FOREIGN KEY (`manufacturer_id`) REFERENCES `MANUFACTURER` (`manufacturer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
