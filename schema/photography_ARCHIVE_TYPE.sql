/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ARCHIVE_TYPE` (
  `archive_type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of archive type',
  `archive_type` varchar(45) DEFAULT NULL COMMENT 'Name of this type of archive',
  PRIMARY KEY (`archive_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table to list the different types of archive available for materials';
/*!40101 SET character_set_client = @saved_cs_client */;
