/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PAPER_GRADE` (
  `paper_grade_id` int(11) NOT NULL AUTO_INCREMENT,
  `paper_stock_id` int(11) DEFAULT NULL,
  `grade` decimal(2,1) DEFAULT NULL,
  `magenta` smallint(6) DEFAULT NULL,
  `yellow` smallint(6) DEFAULT NULL,
  `blue` smallint(6) DEFAULT NULL,
  `double_filtration` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`paper_grade_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
