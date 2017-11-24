/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACCESSORY_COMPAT` (
  `compat_id` int(11) NOT NULL AUTO_INCREMENT,
  `accessory_id` int(11) NOT NULL,
  `camera_id` int(11) DEFAULT NULL,
  `lens_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`compat_id`),
  KEY `fk_ACCESSORY_COMPAT_1_idx` (`accessory_id`),
  CONSTRAINT `fk_ACCESSORY_COMPAT_1` FOREIGN KEY (`accessory_id`) REFERENCES `ACCESSORY` (`accessory_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
