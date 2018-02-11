/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DEV_BATCH` (
  `dev_batch_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique developer batch ID',
  `developer_id` int(11) DEFAULT NULL COMMENT 'Denotes the developer used to make this batch',
  `dilution` varchar(45) DEFAULT NULL COMMENT 'The dilution of the developer in this batch (e.g. 1+0, 1+1, etc)',
  `prepared` date DEFAULT NULL COMMENT 'Date that this batch was prepared',
  PRIMARY KEY (`dev_batch_id`),
  KEY `fk_DEV_BATCH_1_idx` (`developer_id`),
  CONSTRAINT `fk_DEV_BATCH_1` FOREIGN KEY (`developer_id`) REFERENCES `DEVELOPER` (`developer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table to catalog batches of developer that have been prepared';
/*!40101 SET character_set_client = @saved_cs_client */;
