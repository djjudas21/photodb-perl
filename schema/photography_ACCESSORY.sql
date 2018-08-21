/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACCESSORY` (
  `accessory_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of this accessory',
  `accessory_type_id` int(11) DEFAULT NULL COMMENT 'ID of this type of accessory',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'ID of the manufacturer',
  `model` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Model of the accessory',
  `acquired` date DEFAULT NULL COMMENT 'Date that this accessory was acquired',
  `cost` decimal(5,2) DEFAULT NULL COMMENT 'Purchase cost of the accessory',
  `lost` date DEFAULT NULL COMMENT 'Date that this accessory was lost',
  `lost_price` decimal(5,2) DEFAULT NULL COMMENT 'Sale price of the accessory',
  PRIMARY KEY (`accessory_id`),
  KEY `fk_ACCESSORY_1_idx` (`accessory_type_id`),
  CONSTRAINT `fk_ACCESSORY_1` FOREIGN KEY (`accessory_type_id`) REFERENCES `ACCESSORY_TYPE` (`accessory_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog accessories that are not tracked in more specific tables';
/*!40101 SET character_set_client = @saved_cs_client */;
