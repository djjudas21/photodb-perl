/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TONER` (
  `toner_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of the toner',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'ID of the manufacturer of the toner',
  `toner` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `formulation` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stock_dilution` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`toner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog paper toners that can be used during the printing process';
/*!40101 SET character_set_client = @saved_cs_client */;
