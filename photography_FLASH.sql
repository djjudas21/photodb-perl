/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FLASH` (
  `flash_id` int(11) NOT NULL AUTO_INCREMENT,
  `manufacturer_id` int(11) DEFAULT NULL,
  `model` varchar(45) DEFAULT NULL,
  `guide_number` int(11) DEFAULT NULL,
  `gn_info` varchar(45) DEFAULT NULL,
  `battery_powered` tinyint(1) DEFAULT NULL,
  `pc_sync` tinyint(1) DEFAULT NULL,
  `hot_shoe` tinyint(1) DEFAULT NULL,
  `light_stand` tinyint(1) DEFAULT NULL,
  `battery_type` varchar(45) DEFAULT NULL,
  `battery_qty` varchar(45) DEFAULT NULL,
  `manual_control` tinyint(1) DEFAULT NULL,
  `swivel_head` tinyint(1) DEFAULT NULL,
  `tilt_head` tinyint(1) DEFAULT NULL,
  `zoom` tinyint(1) DEFAULT NULL,
  `dslr_safe` tinyint(1) DEFAULT NULL,
  `ttl` tinyint(1) DEFAULT NULL,
  `ttl_compatibility` varchar(45) DEFAULT NULL,
  `trigger_voltage` decimal(4,1) DEFAULT NULL,
  `own` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`flash_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
