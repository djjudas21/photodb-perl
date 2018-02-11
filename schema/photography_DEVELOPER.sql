/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DEVELOPER` (
  `developer_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique developer ID',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'Denotes the manufacturer ID',
  `name` varchar(45) DEFAULT NULL COMMENT 'Name of the developer',
  `for_paper` tinyint(1) DEFAULT NULL COMMENT 'Whether this developer can be used with paper',
  `for_film` tinyint(1) DEFAULT NULL COMMENT 'Whether this developer can be used with film',
  `chemistry` varchar(45) DEFAULT NULL COMMENT 'The key chemistry on which this developer is based (e.g. phenidone)',
  PRIMARY KEY (`developer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table to list film and paper developers';
/*!40101 SET character_set_client = @saved_cs_client */;
