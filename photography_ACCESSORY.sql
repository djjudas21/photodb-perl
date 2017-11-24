/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACCESSORY` (
  `accessory_id` int(11) NOT NULL AUTO_INCREMENT,
  `accessory_type` varchar(45) DEFAULT NULL,
  `accessory_type_id` int(11) DEFAULT NULL,
  `manufacturer_id` int(11) DEFAULT NULL,
  `model` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`accessory_id`),
  KEY `fk_ACCESSORY_1_idx` (`accessory_type_id`),
  CONSTRAINT `fk_ACCESSORY_1` FOREIGN KEY (`accessory_type_id`) REFERENCES `ACCESSORY_TYPE` (`accessory_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
