/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `name` varchar(255) CHARACTER SET latin1 NOT NULL COMMENT 'Filename of applied migration',
  `date_applied` datetime NOT NULL COMMENT 'Date migration was applied',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to record schema migrations';
/*!40101 SET character_set_client = @saved_cs_client */;
