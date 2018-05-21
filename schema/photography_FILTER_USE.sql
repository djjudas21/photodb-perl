/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FILTER_USE` (
  `filter_use_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Auto-increment ID',
  `filter_id` int(11) DEFAULT NULL COMMENT 'ID of the filter used in the exposure',
  `negative_id` int(11) DEFAULT NULL COMMENT 'ID of the negative',
  PRIMARY KEY (`filter_use_id`),
  KEY `fk_FILTER_USE_1_idx` (`filter_id`),
  KEY `fk_FILTER_USE_2_idx` (`negative_id`),
  CONSTRAINT `fk_FILTER_USE_1` FOREIGN KEY (`filter_id`) REFERENCES `FILTER` (`filter_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_FILTER_USE_2` FOREIGN KEY (`negative_id`) REFERENCES `NEGATIVE` (`negative_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table to record which filters were used in each exposure';
/*!40101 SET character_set_client = @saved_cs_client */;
