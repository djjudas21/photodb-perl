/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PROCESS` (
  `process_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID of this development process',
  `name` varchar(12) DEFAULT NULL COMMENT 'Name of this developmenmt process (e.g. C-41, E-6)',
  `colour` tinyint(1) DEFAULT NULL COMMENT 'Whether this is a colour process',
  `positive` tinyint(1) DEFAULT NULL COMMENT 'Whether this is a positive/reversal process',
  PRIMARY KEY (`process_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;