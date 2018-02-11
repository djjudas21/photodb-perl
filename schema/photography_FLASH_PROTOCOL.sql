/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FLASH_PROTOCOL` (
  `flash_protocol_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of this flash protocol',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'ID of the manufacturer that introduced this flash protocol',
  `name` varchar(45) DEFAULT NULL COMMENT 'Name of the flash protocol',
  PRIMARY KEY (`flash_protocol_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table to catalog different protocols used to communicate with flashes';
/*!40101 SET character_set_client = @saved_cs_client */;
