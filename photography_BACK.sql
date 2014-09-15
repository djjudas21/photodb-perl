/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BACK` (
  `back_id` int(11) NOT NULL AUTO_INCREMENT,
  `manufacturer_id` int(11) DEFAULT NULL,
  `format_id` int(11) DEFAULT NULL,
  `negative_size_id` int(11) DEFAULT NULL,
  `back_mount_id` int(11) DEFAULT NULL,
  `model` varchar(45) DEFAULT NULL,
  `qty_shots` int(11) DEFAULT NULL,
  `qty_backs` int(11) DEFAULT NULL,
  PRIMARY KEY (`back_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
