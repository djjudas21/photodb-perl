/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HOOD` (
  `hood_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique hood ID',
  `model` varchar(45) DEFAULT NULL COMMENT 'Modal name of lens hood',
  `qty` smallint(6) DEFAULT NULL COMMENT 'Number of lens hoods in the collection',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'Manufacturer ID of lens hood',
  `type` varchar(15) DEFAULT NULL COMMENT 'Type of lens hood, e.g. petal, circular, square',
  `mounting` varchar(15) DEFAULT NULL COMMENT 'How the lens hood attaches to the lens',
  PRIMARY KEY (`hood_id`),
  UNIQUE KEY `model_UNIQUE` (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
