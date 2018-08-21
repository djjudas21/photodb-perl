/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SHUTTER_SPEED` (
  `shutter_speed` varchar(10) CHARACTER SET latin1 NOT NULL COMMENT 'Shutter speed in fractional notation, e.g. 1/250',
  `duration` decimal(7,5) DEFAULT NULL COMMENT 'Shutter speed in decimal notation, e.g. 0.04',
  PRIMARY KEY (`shutter_speed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Table to list all possible shutter speeds';
/*!40101 SET character_set_client = @saved_cs_client */;
