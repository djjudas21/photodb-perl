/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SHUTTER_SPEED` (
  `shutter_speed` varchar(10) NOT NULL,
  `duration` decimal(7,5) DEFAULT NULL,
  PRIMARY KEY (`shutter_speed`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
