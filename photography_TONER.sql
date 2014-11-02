/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TONER` (
  `toner_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of the toner',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'ID of the manufacturer of the toner',
  `toner` varchar(45) DEFAULT NULL COMMENT 'Name of the toner',
  `formulation` varchar(45) DEFAULT NULL COMMENT 'Chemical formulation of the toner',
  PRIMARY KEY (`toner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
