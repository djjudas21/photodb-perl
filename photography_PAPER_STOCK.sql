/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PAPER_STOCK` (
  `paper_stock_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of this paper stock',
  `name` varchar(45) DEFAULT NULL COMMENT 'Name of this paper stock',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'ID of the manufacturer of this paper stock',
  `resin_coated` tinyint(1) DEFAULT NULL COMMENT 'Whether the paper is resin-coated',
  `tonable` tinyint(1) DEFAULT NULL COMMENT 'Whether this paper accepts chemical toning',
  `colour` tinyint(1) DEFAULT NULL COMMENT 'Whether this is a colour paper',
  PRIMARY KEY (`paper_stock_id`),
  KEY `fk_PAPER_STOCK_1` (`manufacturer_id`),
  CONSTRAINT `fk_PAPER_STOCK_1` FOREIGN KEY (`manufacturer_id`) REFERENCES `MANUFACTURER` (`manufacturer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
