/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REPAIR` (
  `repair_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for the repair job',
  `oid` int(11) DEFAULT NULL COMMENT 'ID of the camera or lens that was repaired',
  `object_type` varchar(45) DEFAULT NULL COMMENT 'Type of object that was repaired (e.g. Camera, Lens, etc)',
  `date` date DEFAULT NULL COMMENT 'The date of the repair',
  `summary` varchar(100) DEFAULT NULL COMMENT 'Brief summary of the repair',
  `description` varchar(500) DEFAULT NULL COMMENT 'Longer description of the repair',
  PRIMARY KEY (`repair_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
