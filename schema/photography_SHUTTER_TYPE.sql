/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SHUTTER_TYPE` (
  `shutter_type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of the shutter type',
  `shutter_type` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of the shutter type (e.g. Focal plane, Leaf, etc)',
  PRIMARY KEY (`shutter_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog the different types of camera shutter';
/*!40101 SET character_set_client = @saved_cs_client */;
