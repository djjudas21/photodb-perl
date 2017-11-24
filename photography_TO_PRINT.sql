/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TO_PRINT` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `negative_id` int(11) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `printed` tinyint(4) DEFAULT '0',
  `print_id` int(11) DEFAULT NULL,
  `recipient` varchar(45) DEFAULT NULL,
  `added` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_TO_PRINT_1_idx` (`negative_id`),
  CONSTRAINT `fk_TO_PRINT_1` FOREIGN KEY (`negative_id`) REFERENCES `NEGATIVE` (`negative_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
