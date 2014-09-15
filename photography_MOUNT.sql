/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MOUNT` (
  `mount_id` int(11) NOT NULL AUTO_INCREMENT,
  `mount` varchar(45) DEFAULT NULL,
  `fixed` tinyint(1) DEFAULT NULL,
  `shutter_in_lens` tinyint(1) DEFAULT NULL,
  `type` varchar(25) DEFAULT NULL,
  `purpose` varchar(25) DEFAULT NULL,
  `notes` varchar(45) DEFAULT NULL,
  `digital_only` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`mount_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
