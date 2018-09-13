/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FILTER_ADAPTER` (
  `filter_adapter_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of filter adapter',
  `camera_thread` decimal(3,1) DEFAULT NULL COMMENT 'Diameter of camera-facing screw thread in mm',
  `filter_thread` decimal(3,1) DEFAULT NULL COMMENT 'Diameter of filter-facing screw thread in mm',
  PRIMARY KEY (`filter_adapter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalogue filter adapter rings';
/*!40101 SET character_set_client = @saved_cs_client */;
