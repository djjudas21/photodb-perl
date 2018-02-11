/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BACK` (
  `back_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for the film back',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'Denotes the manufacturer of the camera',
  `format_id` int(11) DEFAULT NULL COMMENT 'Denotes the film format that the back accepts',
  `negative_size_id` int(11) DEFAULT NULL COMMENT 'Denotes the negative size that the back produces',
  `back_mount_id` int(11) DEFAULT NULL,
  `model` varchar(45) DEFAULT NULL COMMENT 'Model name of the film back',
  `qty_shots` int(11) DEFAULT NULL COMMENT 'Number of exposures this back can hold',
  `qty_backs` int(11) DEFAULT NULL COMMENT 'Quantity of backs like this that you own',
  PRIMARY KEY (`back_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table to catalog Interchangeable backs and film holders';
/*!40101 SET character_set_client = @saved_cs_client */;
