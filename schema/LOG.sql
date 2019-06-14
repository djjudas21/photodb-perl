/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LOG` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of the log entry',
  `datetime` datetime DEFAULT NULL COMMENT 'Timestamp for the log entry',
  `type` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Type of log message, e.g. ADD, EDIT',
  `message` varchar(450) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Log message',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to store data modification logs';
/*!40101 SET character_set_client = @saved_cs_client */;
