/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DEV_BATCH` (
  `dev_batch_id` int(11) NOT NULL AUTO_INCREMENT,
  `developer_id` int(11) DEFAULT NULL,
  `dilution` varchar(45) DEFAULT NULL,
  `prepared` date DEFAULT NULL,
  PRIMARY KEY (`dev_batch_id`),
  KEY `fk_DEV_BATCH_1_idx` (`developer_id`),
  CONSTRAINT `fk_DEV_BATCH_1` FOREIGN KEY (`developer_id`) REFERENCES `DEVELOPER` (`developer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
