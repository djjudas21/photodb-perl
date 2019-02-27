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
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog accessories that are not tracked in more specific tables';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACCESSORY_COMPAT` (
  `compat_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for this compatibility',
  `accessory_id` int(11) NOT NULL COMMENT 'ID of the accessory',
  `camera_id` int(11) DEFAULT NULL COMMENT 'ID of the compatible camera',
  `lens_id` int(11) DEFAULT NULL COMMENT 'ID of the compatible lens',
  PRIMARY KEY (`compat_id`),
  KEY `fk_ACCESSORY_COMPAT_1_idx` (`accessory_id`),
  KEY `fk_ACCESSORY_COMPAT_2_idx` (`camera_id`),
  KEY `fk_ACCESSORY_COMPAT_3_idx` (`lens_id`),
  CONSTRAINT `fk_ACCESSORY_COMPAT_1` FOREIGN KEY (`accessory_id`) REFERENCES `ACCESSORY` (`accessory_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ACCESSORY_COMPAT_2` FOREIGN KEY (`camera_id`) REFERENCES `CAMERA` (`camera_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ACCESSORY_COMPAT_3` FOREIGN KEY (`lens_id`) REFERENCES `LENS` (`lens_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to define compatibility between accessories and cameras or lenses';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACCESSORY_TYPE` (
  `accessory_type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for this type of accessory',
  `accessory_type` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Type of accessory',
  PRIMARY KEY (`accessory_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog types of photographic accessory';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ARCHIVE` (
  `archive_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of this archive',
  `archive_type_id` int(11) DEFAULT NULL COMMENT 'ID of this type of archive',
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of this archive',
  `max_width` int(11) DEFAULT NULL COMMENT 'Maximum width of media that this archive can store',
  `max_height` int(11) DEFAULT NULL COMMENT 'Maximum height of media that this archive can store',
  `location` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Location of this archive',
  `storage` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The type of storage used for this archive, e.g. box, folder, ringbinder, etc',
  `sealed` tinyint(1) DEFAULT '0' COMMENT 'Whether or not this archive is sealed (closed to new additions)',
  PRIMARY KEY (`archive_id`),
  KEY `fk_ARCHIVE_3_idx` (`archive_type_id`),
  CONSTRAINT `fk_ARCHIVE_3` FOREIGN KEY (`archive_type_id`) REFERENCES `ARCHIVE_TYPE` (`archive_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to list all archives that exist for storing physical media';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ARCHIVE_TYPE` (
  `archive_type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of archive type',
  `archive_type` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of this type of archive',
  PRIMARY KEY (`archive_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to list the different types of archive available for materials';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BATTERY` (
  `battery_type` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique battery ID',
  `battery_name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Common name of the battery',
  `voltage` decimal(4,2) DEFAULT NULL COMMENT 'Nominal voltage of the battery',
  `chemistry` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Battery chemistry (e.g. Alkaline, Lithium, etc)',
  `other_names` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Alternative names for this kind of battery',
  PRIMARY KEY (`battery_type`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog of types of battery';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BODY_TYPE` (
  `body_type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique body type ID',
  `body_type` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of camera body type (e.g. SLR, compact, etc)',
  PRIMARY KEY (`body_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog types of camera body style';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CAMERA` (
  `camera_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Auto-incremented camera ID',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'Denotes the manufacturer of the camera.',
  `model` varchar(45) DEFAULT NULL COMMENT 'The model name of the camera',
  `mount_id` int(11) DEFAULT NULL COMMENT 'Denotes the lens mount of the camera if it is an interchangeable-lens camera',
  `format_id` int(11) DEFAULT NULL COMMENT 'Denotes the film format of the camera',
  `focus_type_id` int(11) DEFAULT NULL COMMENT 'Denotes the focus type of the camera',
  `metering` tinyint(1) DEFAULT NULL COMMENT 'Whether the camera has built-in metering',
  `coupled_metering` tinyint(1) DEFAULT NULL COMMENT 'Whether the camera''s meter is coupled automatically',
  `metering_type_id` int(11) DEFAULT NULL COMMENT 'Denotes the technology used in the meter',
  `body_type_id` int(11) DEFAULT NULL COMMENT 'Denotes the style of camera body',
  `weight` int(11) DEFAULT NULL COMMENT 'Weight of the camera body (without lens or batteries) in grammes (g)',
  `acquired` date DEFAULT NULL COMMENT 'Date on which the camera was acquired',
  `cost` decimal(6,2) DEFAULT NULL COMMENT 'Price paid for the camera, in local currency units',
  `introduced` smallint(6) DEFAULT NULL COMMENT 'Year in which the camera model was introduced',
  `discontinued` smallint(6) DEFAULT NULL COMMENT 'Year in which the camera model was discontinued',
  `serial` varchar(45) DEFAULT NULL COMMENT 'Serial number of the camera',
  `datecode` varchar(12) DEFAULT NULL COMMENT 'Date code of the camera, if different from the serial number',
  `manufactured` smallint(6) DEFAULT NULL COMMENT 'Year of manufacture of the camera',
  `own` tinyint(1) DEFAULT NULL COMMENT 'Whether the camera is currently owned',
  `negative_size_id` int(11) DEFAULT NULL COMMENT 'Denotes the size of negative made by the camera',
  `shutter_type_id` int(11) DEFAULT NULL COMMENT 'Denotes type of shutter',
  `shutter_model` varchar(45) DEFAULT NULL COMMENT 'Model of shutter',
  `cable_release` tinyint(1) DEFAULT NULL COMMENT 'Whether the camera has the facility for a remote cable release',
  `viewfinder_coverage` int(11) DEFAULT NULL COMMENT 'Percentage coverage of the viewfinder. Mostly applicable to SLRs.',
  `power_drive` tinyint(1) DEFAULT NULL COMMENT 'Whether the camera has integrated motor drive',
  `continuous_fps` decimal(3,1) DEFAULT NULL COMMENT 'The maximum rate at which the camera can shoot, in frames per second',
  `video` tinyint(1) DEFAULT NULL COMMENT 'Whether the camera can take video/movie',
  `digital` tinyint(1) DEFAULT NULL COMMENT 'Whether this is a digital camera',
  `fixed_mount` tinyint(1) DEFAULT NULL COMMENT 'Whether the camera has a fixed lens',
  `lens_id` int(11) DEFAULT NULL COMMENT 'If fixed_mount is true, specify the lens_id',
  `battery_qty` int(11) DEFAULT NULL COMMENT 'Quantity of batteries needed',
  `battery_type` int(11) DEFAULT NULL COMMENT 'Denotes type of battery needed',
  `notes` text COMMENT 'Freeform text field for extra notes',
  `lost` date DEFAULT NULL COMMENT 'Date on which the camera was lost/sold/etc',
  `lost_price` decimal(6,2) DEFAULT NULL COMMENT 'Price at which the camera was sold',
  `source` varchar(150) DEFAULT NULL COMMENT 'Where the camera was acquired from',
  `min_shutter` varchar(10) CHARACTER SET latin1 DEFAULT NULL COMMENT 'Fastest available shutter speed, expressed like 1/400',
  `max_shutter` varchar(10) CHARACTER SET latin1 DEFAULT NULL COMMENT 'Slowest available shutter speed, expressed like 30 (no ")',
  `bulb` tinyint(1) DEFAULT NULL COMMENT 'Whether the camera supports bulb (B) exposure',
  `time` tinyint(1) DEFAULT NULL COMMENT 'Whether the camera supports time (T) exposure',
  `min_iso` int(11) DEFAULT NULL COMMENT 'Minimum ISO the camera will accept for metering',
  `max_iso` int(11) DEFAULT NULL COMMENT 'Maximum ISO the camera will accept for metering',
  `af_points` tinyint(4) DEFAULT NULL COMMENT 'Number of autofocus points',
  `int_flash` tinyint(1) DEFAULT NULL COMMENT 'Whether the camera has an integrated flash',
  `int_flash_gn` tinyint(4) DEFAULT NULL COMMENT 'Guide number of internal flash',
  `ext_flash` tinyint(1) DEFAULT NULL COMMENT ' Whether the camera supports an external flash',
  `flash_metering` varchar(12) DEFAULT NULL COMMENT 'Flash metering protocol',
  `pc_sync` tinyint(1) DEFAULT NULL COMMENT 'Whether the camera has a PC sync socket for flash',
  `hotshoe` tinyint(1) DEFAULT NULL COMMENT 'Whether the camera has a hotshoe',
  `coldshoe` tinyint(1) DEFAULT NULL COMMENT 'Whether the camera has a coldshoe or accessory shoe',
  `x_sync` varchar(6) DEFAULT NULL COMMENT 'X-sync shutter speed, expressed like 1/125',
  `meter_min_ev` tinyint(4) DEFAULT NULL COMMENT 'Lowest EV/LV the built-in meter supports',
  `meter_max_ev` tinyint(4) DEFAULT NULL COMMENT 'Highest EV/LV the built-in meter supports',
  `condition_id` int(11) DEFAULT NULL COMMENT 'Denotes the cosmetic condition of the camera',
  `dof_preview` tinyint(1) DEFAULT NULL COMMENT 'Whether the camera has depth of field preview',
  `tripod` tinyint(1) DEFAULT NULL COMMENT 'Whether the camera has a tripod bush',
  `display_lens` int(11) DEFAULT NULL COMMENT 'Lens ID of the lens that this camera should normally be displayed with',
  PRIMARY KEY (`camera_id`),
  UNIQUE KEY `display_lens_UNIQUE` (`display_lens`),
  KEY `manufacturer_id` (`manufacturer_id`),
  KEY `body_type_id` (`body_type_id`),
  KEY `fk_body_type` (`body_type_id`),
  KEY `fk_focus_type` (`focus_type_id`),
  KEY `fk_mount` (`mount_id`),
  KEY `fk_format` (`format_id`),
  KEY `fk_manufacturer` (`manufacturer_id`),
  KEY `fk_metering_type` (`metering_type_id`),
  KEY `fk_negative_size_id` (`negative_size_id`),
  KEY `fk_shutter_type_id` (`shutter_type_id`),
  KEY `fk_CAMERA_3_idx` (`condition_id`),
  KEY `fk_CAMERA_1_idx` (`min_shutter`),
  KEY `fk_CAMERA_2_idx` (`max_shutter`),
  KEY `fk_CAMERA_3_idx1` (`display_lens`),
  KEY `fk_CAMERA_4_idx` (`battery_type`),
  CONSTRAINT `fk_CAMERA_1` FOREIGN KEY (`min_shutter`) REFERENCES `SHUTTER_SPEED` (`shutter_speed`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CAMERA_2` FOREIGN KEY (`max_shutter`) REFERENCES `SHUTTER_SPEED` (`shutter_speed`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CAMERA_3` FOREIGN KEY (`display_lens`) REFERENCES `LENS` (`lens_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CAMERA_4` FOREIGN KEY (`battery_type`) REFERENCES `BATTERY` (`battery_type`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CAMERA_5` FOREIGN KEY (`display_lens`) REFERENCES `LENS` (`lens_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_body_type` FOREIGN KEY (`body_type_id`) REFERENCES `BODY_TYPE` (`body_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_condition` FOREIGN KEY (`condition_id`) REFERENCES `CONDITION` (`condition_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_focus_type` FOREIGN KEY (`focus_type_id`) REFERENCES `FOCUS_TYPE` (`focus_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_format` FOREIGN KEY (`format_id`) REFERENCES `FORMAT` (`format_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_manufacturer` FOREIGN KEY (`manufacturer_id`) REFERENCES `MANUFACTURER` (`manufacturer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_metering_type` FOREIGN KEY (`metering_type_id`) REFERENCES `METERING_TYPE` (`metering_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_mount` FOREIGN KEY (`mount_id`) REFERENCES `MOUNT` (`mount_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_negative_size` FOREIGN KEY (`negative_size_id`) REFERENCES `NEGATIVE_SIZE` (`negative_size_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_shutter_type` FOREIGN KEY (`shutter_type_id`) REFERENCES `SHUTTER_TYPE` (`shutter_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4 COMMENT='Table to catalog cameras - both cameras with fixed lenses and cameras with interchangeable lenses';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CONDITION` (
  `condition_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique condition ID',
  `code` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Condition shortcode (e.g. EXC)',
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Full name of condition (e.g. Excellent)',
  `min_rating` int(11) DEFAULT NULL COMMENT 'The lowest percentage rating that encompasses this condition',
  `max_rating` int(11) DEFAULT NULL COMMENT 'The highest percentage rating that encompasses this condition',
  `description` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Longer description of condition',
  PRIMARY KEY (`condition_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to list of physical condition descriptions that can be used to evaluate equipment';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DEVELOPER` (
  `developer_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique developer ID',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'Denotes the manufacturer ID',
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of the developer',
  `for_paper` tinyint(1) DEFAULT NULL COMMENT 'Whether this developer can be used with paper',
  `for_film` tinyint(1) DEFAULT NULL COMMENT 'Whether this developer can be used with film',
  `chemistry` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The key chemistry on which this developer is based (e.g. phenidone)',
  PRIMARY KEY (`developer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to list film and paper developers';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ENLARGER` (
  `enlarger_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique enlarger ID',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'Manufacturer ID of the enlarger',
  `enlarger` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name/model of the enlarger',
  `negative_size_id` int(11) DEFAULT NULL COMMENT 'ID of the largest negative size that the enlarger can handle',
  `acquired` date DEFAULT NULL COMMENT 'Date on which the enlarger was acquired',
  `lost` date DEFAULT NULL COMMENT 'Date on which the enlarger was lost/sold',
  `introduced` year(4) DEFAULT NULL COMMENT 'Year in which the enlarger was introduced',
  `discontinued` year(4) DEFAULT NULL COMMENT 'Year in which the enlarger was discontinued',
  `cost` decimal(6,2) DEFAULT NULL COMMENT 'Purchase cost of the enlarger',
  `lost_price` decimal(6,2) DEFAULT NULL COMMENT 'Sale price of the enlarger',
  PRIMARY KEY (`enlarger_id`),
  KEY `fk_ENLARGER_1` (`manufacturer_id`),
  KEY `fk_ENLARGER_2` (`negative_size_id`),
  CONSTRAINT `fk_ENLARGER_1` FOREIGN KEY (`manufacturer_id`) REFERENCES `MANUFACTURER` (`manufacturer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ENLARGER_2` FOREIGN KEY (`negative_size_id`) REFERENCES `NEGATIVE_SIZE` (`negative_size_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to list enlargers';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EXHIBIT` (
  `exhibit_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for this exhibit',
  `exhibition_id` int(11) DEFAULT NULL COMMENT 'ID of the exhibition',
  `print_id` int(11) DEFAULT NULL COMMENT 'ID of the print',
  PRIMARY KEY (`exhibit_id`),
  KEY `fk_EXHIBIT_1_idx` (`exhibition_id`),
  KEY `fk_EXHIBIT_2_idx` (`print_id`),
  CONSTRAINT `fk_EXHIBIT_1` FOREIGN KEY (`exhibition_id`) REFERENCES `EXHIBITION` (`exhibition_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_EXHIBIT_2` FOREIGN KEY (`print_id`) REFERENCES `PRINT` (`print_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to record which prints were displayed in which exhibitions';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EXHIBITION` (
  `exhibition_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for this exhibition',
  `title` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Title of the exhibition',
  `location` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Location of the exhibition',
  `start_date` date DEFAULT NULL COMMENT 'Start date of the exhibition',
  `end_date` date DEFAULT NULL COMMENT 'End date of the exhibition',
  PRIMARY KEY (`exhibition_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to record exhibition events';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EXPOSURE_PROGRAM` (
  `exposure_program_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID of exposure program as defined by EXIF tag ExposureProgram',
  `exposure_program` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of exposure program as defined by EXIF tag ExposureProgram',
  PRIMARY KEY (`exposure_program_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Exposure programs as defined by EXIF tag ExposureProgram';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EXPOSURE_PROGRAM_AVAILABLE` (
  `camera_id` int(11) NOT NULL COMMENT 'ID of camera',
  `exposure_program_id` int(11) NOT NULL COMMENT 'ID of exposure program',
  PRIMARY KEY (`camera_id`,`exposure_program_id`),
  KEY `fk_EXPOSURE_PROGRAM_AVAILABLE_1_idx` (`camera_id`),
  KEY `fk_EXPOSURE_PROGRAM_AVAILABLE_2_idx` (`exposure_program_id`),
  CONSTRAINT `fk_EXPOSURE_PROGRAM_AVAILABLE_1` FOREIGN KEY (`camera_id`) REFERENCES `CAMERA` (`camera_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_EXPOSURE_PROGRAM_AVAILABLE_2` FOREIGN KEY (`exposure_program_id`) REFERENCES `EXPOSURE_PROGRAM` (`exposure_program_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to associate cameras with available exposure programs';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FILM` (
  `film_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of the film',
  `filmstock_id` int(11) DEFAULT NULL COMMENT 'ID of the filmstock used',
  `exposed_at` int(11) DEFAULT NULL COMMENT 'ISO at which the film was exposed',
  `format_id` int(11) DEFAULT NULL COMMENT 'ID of the film format',
  `date_loaded` date DEFAULT NULL COMMENT 'Date when the film was loaded into a camera',
  `date` date DEFAULT NULL COMMENT 'Date when the film was processed',
  `camera_id` int(11) DEFAULT NULL COMMENT 'ID of the camera that exposed this film',
  `notes` varchar(145) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Title of the film',
  `frames` int(11) DEFAULT NULL COMMENT 'Expected (not actual) number of frames from the film',
  `developer_id` int(11) DEFAULT NULL COMMENT 'ID of the developer used to process this film',
  `directory` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of the directory that contains the scanned images from this film',
  `photographer_id` int(11) DEFAULT NULL COMMENT 'ID of the photographer who took these pictures',
  `dev_uses` int(11) DEFAULT NULL COMMENT 'Numnber of previous uses of the developer',
  `dev_time` time DEFAULT NULL COMMENT 'Duration of development',
  `dev_temp` decimal(3,1) DEFAULT NULL COMMENT 'Temperature of development',
  `dev_n` int(11) DEFAULT NULL COMMENT 'Number of the Push/Pull rating of the film, e.g. N+1, N-2',
  `development_notes` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Extra freeform notes about the development process',
  `film_bulk_id` int(11) DEFAULT NULL COMMENT 'ID of bulk film from which this film was cut',
  `film_bulk_loaded` date DEFAULT NULL COMMENT 'Date that this film was cut from a bulk roll',
  `film_batch` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Batch number of the film',
  `film_expiry` date DEFAULT NULL COMMENT 'Expiry date of the film',
  `purchase_date` date DEFAULT NULL COMMENT 'Date this film was purchased',
  `price` decimal(4,2) DEFAULT NULL COMMENT 'Price paid for this film',
  `processed_by` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Person or place that processed this film',
  `archive_id` int(11) DEFAULT NULL COMMENT 'ID of the archive to which this film belongs',
  PRIMARY KEY (`film_id`),
  KEY `fk_filmstock_id` (`filmstock_id`),
  KEY `fk_camera_id` (`camera_id`),
  KEY `fk_format_id` (`format_id`),
  KEY `fk_FILM_1` (`developer_id`),
  KEY `fk_FILM_2_idx` (`photographer_id`),
  KEY `fk_FILM_3_idx` (`archive_id`),
  KEY `fk_FILM_4_idx` (`film_bulk_id`),
  CONSTRAINT `fk_FILM_1` FOREIGN KEY (`developer_id`) REFERENCES `DEVELOPER` (`developer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_FILM_2` FOREIGN KEY (`photographer_id`) REFERENCES `PERSON` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_FILM_3` FOREIGN KEY (`archive_id`) REFERENCES `ARCHIVE` (`archive_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_FILM_4` FOREIGN KEY (`film_bulk_id`) REFERENCES `FILM_BULK` (`film_bulk_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_camera_id` FOREIGN KEY (`camera_id`) REFERENCES `CAMERA` (`camera_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_filmstock_id` FOREIGN KEY (`filmstock_id`) REFERENCES `FILMSTOCK` (`filmstock_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_format_id` FOREIGN KEY (`format_id`) REFERENCES `FORMAT` (`format_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=349 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to list films which consist of one or more negatives. A film can be a roll film, one or more sheets of sheet film, one or more photographic plates, etc.';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FILMSTOCK` (
  `filmstock_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of the filmstock',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'ID of the manufacturer of the film',
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of the film',
  `iso` int(11) DEFAULT NULL COMMENT 'Nominal ISO speed of the film',
  `colour` tinyint(1) DEFAULT NULL COMMENT 'Whether the film is colour',
  `process_id` int(11) DEFAULT NULL COMMENT 'ID of the normal process for this film',
  `panchromatic` tinyint(1) DEFAULT NULL COMMENT 'Whether this film is panchromatic',
  PRIMARY KEY (`filmstock_id`),
  KEY `fk_manufacturer_id` (`manufacturer_id`),
  KEY `fk_FILMSTOCK_1_idx` (`process_id`),
  CONSTRAINT `fk_FILMSTOCK_1` FOREIGN KEY (`process_id`) REFERENCES `PROCESS` (`process_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_manufacturer_id` FOREIGN KEY (`manufacturer_id`) REFERENCES `MANUFACTURER` (`manufacturer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to list different brands of film stock';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FILM_BULK` (
  `film_bulk_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of this bulk roll of film',
  `format_id` int(11) DEFAULT NULL COMMENT 'ID of the format of this bulk roll',
  `filmstock_id` int(11) DEFAULT NULL COMMENT 'ID of the filmstock',
  `purchase_date` date DEFAULT NULL COMMENT 'Purchase date of this bulk roll',
  `cost` decimal(5,2) DEFAULT NULL COMMENT 'Purchase cost of this bulk roll',
  `source` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Place where this bulk roll was bought from',
  `batch` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Batch code of this bulk roll',
  `expiry` date DEFAULT NULL COMMENT 'Expiry date of this bulk roll',
  PRIMARY KEY (`film_bulk_id`),
  KEY `fk_FILM_BULK_1_idx` (`format_id`),
  KEY `fk_FILM_BULK_2_idx` (`filmstock_id`),
  CONSTRAINT `fk_FILM_BULK_1` FOREIGN KEY (`format_id`) REFERENCES `FORMAT` (`format_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_FILM_BULK_2` FOREIGN KEY (`filmstock_id`) REFERENCES `FILMSTOCK` (`filmstock_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to record bulk film stock, from which individual films can be cut';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FILTER` (
  `filter_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique filter ID',
  `thread` decimal(4,1) DEFAULT NULL COMMENT 'Diameter of screw thread in mm',
  `type` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Filter type (e.g. Red, CPL, UV)',
  `attenuation` decimal(2,1) DEFAULT NULL COMMENT 'Attenuation of this filter in decimal stops',
  `qty` int(11) DEFAULT NULL COMMENT 'Quantity of these filters available',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'Denotes the manufacturer of the filter.',
  PRIMARY KEY (`filter_id`),
  KEY `fk_FILTER_1_idx` (`manufacturer_id`),
  CONSTRAINT `fk_FILTER_1` FOREIGN KEY (`manufacturer_id`) REFERENCES `MANUFACTURER` (`manufacturer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog filters';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FILTER_ADAPTER` (
  `filter_adapter_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of filter adapter',
  `camera_thread` decimal(3,1) DEFAULT NULL COMMENT 'Diameter of camera-facing screw thread in mm',
  `filter_thread` decimal(3,1) DEFAULT NULL COMMENT 'Diameter of filter-facing screw thread in mm',
  PRIMARY KEY (`filter_adapter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalogue filter adapter rings';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FLASH` (
  `flash_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of external flash unit',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'Manufacturer ID of the flash',
  `model` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Model name/number of the flash',
  `guide_number` int(11) DEFAULT NULL COMMENT 'Guide number of the flash',
  `gn_info` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Extra freeform info about how the guide number was measured',
  `battery_powered` tinyint(1) DEFAULT NULL COMMENT 'Whether this flash takes batteries',
  `pc_sync` tinyint(1) DEFAULT NULL COMMENT 'Whether the flash has a PC sync socket',
  `hot_shoe` tinyint(1) DEFAULT NULL COMMENT 'Whether the flash has a hot shoe connection',
  `light_stand` tinyint(1) DEFAULT NULL COMMENT 'Whether the flash can be used on a light stand',
  `battery_type_id` int(11) DEFAULT NULL COMMENT 'ID of battery type',
  `battery_qty` int(11) DEFAULT NULL COMMENT 'Quantity of batteries needed in this flash',
  `manual_control` tinyint(1) DEFAULT NULL COMMENT 'Whether this flash offers manual power control',
  `swivel_head` tinyint(1) DEFAULT NULL COMMENT 'Whether this flash has a horizontal swivel head',
  `tilt_head` tinyint(1) DEFAULT NULL COMMENT 'Whether this flash has a vertical tilt head',
  `zoom` tinyint(1) DEFAULT NULL COMMENT 'Whether this flash can zoom',
  `dslr_safe` tinyint(1) DEFAULT NULL COMMENT 'Whether this flash is safe to use with a digital camera',
  `ttl` tinyint(1) DEFAULT NULL COMMENT 'Whether this flash supports TTL metering',
  `flash_protocol_id` int(11) DEFAULT NULL COMMENT 'ID of flash TTL metering protocol',
  `trigger_voltage` decimal(4,1) DEFAULT NULL COMMENT 'Trigger voltage of the flash, in Volts',
  `own` tinyint(1) DEFAULT NULL COMMENT 'Whether we currently own this flash',
  `acquired` date DEFAULT NULL COMMENT 'Date this flash was acquired',
  `cost` decimal(5,2) DEFAULT NULL COMMENT 'Purchase cost of this flash',
  PRIMARY KEY (`flash_id`),
  KEY `fk_FLASH_1_idx` (`flash_protocol_id`),
  KEY `fk_FLASH_2_idx` (`battery_type_id`),
  CONSTRAINT `fk_FLASH_1` FOREIGN KEY (`flash_protocol_id`) REFERENCES `FLASH_PROTOCOL` (`flash_protocol_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_FLASH_2` FOREIGN KEY (`battery_type_id`) REFERENCES `BATTERY` (`battery_type`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catlog flashes, flashguns and speedlights';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FLASH_PROTOCOL` (
  `flash_protocol_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of this flash protocol',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'ID of the manufacturer that introduced this flash protocol',
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of the flash protocol',
  PRIMARY KEY (`flash_protocol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog different protocols used to communicate with flashes';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FOCUS_TYPE` (
  `focus_type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of focus type',
  `focus_type` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of focus type',
  PRIMARY KEY (`focus_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog different focusing methods';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FORMAT` (
  `format_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for this format',
  `format` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The name of this film/sensor format',
  `digital` tinyint(1) DEFAULT NULL COMMENT 'Whether this is a digital format',
  PRIMARY KEY (`format_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalogue different film formats. These are distinct from negative sizes.';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LENS` (
  `lens_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for this lens',
  `mount_id` int(11) DEFAULT NULL COMMENT 'Denotes the ID of the lens mount, if this is an interchangeable lens',
  `zoom` tinyint(1) DEFAULT NULL COMMENT 'Whether this is a zoom lens',
  `min_focal_length` int(11) DEFAULT NULL COMMENT 'Shortest focal length of this lens, in mm',
  `max_focal_length` int(11) DEFAULT NULL COMMENT 'Longest focal length of this lens, in mm',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'ID of the manufacturer of this lens',
  `model` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Model name of this lens',
  `closest_focus` int(11) DEFAULT NULL COMMENT 'The closest focus possible with this lens, in cm',
  `max_aperture` decimal(4,1) DEFAULT NULL COMMENT 'Maximum (widest) aperture available on this lens (numerical part only, e.g. 2.8)',
  `min_aperture` decimal(4,1) DEFAULT NULL COMMENT 'Minimum (narrowest) aperture available on this lens (numerical part only, e.g. 22)',
  `elements` int(11) DEFAULT NULL COMMENT 'Number of optical lens elements',
  `groups` int(11) DEFAULT NULL COMMENT 'Number of optical groups',
  `weight` int(11) DEFAULT NULL COMMENT 'Weight of this lens, in grammes (g)',
  `nominal_min_angle_diag` int(11) DEFAULT NULL COMMENT 'Nominal minimum diagonal field of view from manufacturer''s specs',
  `nominal_max_angle_diag` int(11) DEFAULT NULL COMMENT 'Nominal maximum diagonal field of view from manufacturer''s specs',
  `aperture_blades` int(11) DEFAULT NULL COMMENT 'Number of aperture blades',
  `autofocus` tinyint(1) DEFAULT NULL COMMENT 'Whether this lens has autofocus capability',
  `filter_thread` decimal(4,1) DEFAULT NULL COMMENT 'Diameter of lens filter thread, in mm',
  `magnification` decimal(5,3) DEFAULT NULL COMMENT 'Maximum magnification ratio of the lens, expressed like 0.765',
  `url` varchar(145) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'URL to more information about this lens',
  `serial` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Serial number of this lens',
  `date_code` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Date code of this lens, if different from the serial number',
  `introduced` smallint(6) DEFAULT NULL COMMENT 'Year in which this lens model was introduced',
  `discontinued` smallint(6) DEFAULT NULL COMMENT 'Year in which this lens model was discontinued',
  `manufactured` smallint(6) DEFAULT NULL COMMENT 'Year in which this specific lens was manufactured',
  `negative_size_id` int(11) DEFAULT NULL COMMENT 'ID of the negative size which this lens is designed for',
  `acquired` date DEFAULT NULL COMMENT 'Date on which this lens was acquired',
  `cost` decimal(6,2) DEFAULT NULL COMMENT 'Price paid for this lens in local currency units',
  `fixed_mount` tinyint(1) DEFAULT NULL COMMENT 'Whether this is a fixed lens (i.e. on a compact camera)',
  `notes` text COLLATE utf8mb4_unicode_ci COMMENT 'Freeform notes field',
  `own` tinyint(1) DEFAULT NULL COMMENT 'Whether we currently own this lens',
  `lost` date DEFAULT NULL COMMENT 'Date on which lens was lost/sold/disposed',
  `lost_price` decimal(6,2) DEFAULT NULL COMMENT 'Price for which the lens was sold',
  `source` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Place where the lens was acquired from',
  `coating` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Notes about the lens coating type',
  `hood` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Model number of the compatible lens hood',
  `exif_lenstype` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'EXIF LensID number, if this lens has one officially registered. See documentation at http://www.sno.phy.queensu.ca/~phil/exiftool/TagNames/',
  `rectilinear` tinyint(1) DEFAULT NULL COMMENT 'Whether this is a rectilinear lens',
  `length` int(11) DEFAULT NULL COMMENT 'Length of lens in mm',
  `diameter` int(11) DEFAULT NULL COMMENT 'Width of lens in mm',
  `condition_id` int(11) DEFAULT NULL COMMENT 'Denotes the cosmetic condition of the camera',
  `image_circle` int(11) DEFAULT NULL COMMENT 'Diameter of image circle projected by lens, in mm',
  `formula` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of the type of lens formula (e.g. Tessar)',
  `shutter_model` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of the integrated shutter, if any',
  PRIMARY KEY (`lens_id`),
  KEY `fk_LENS_2` (`manufacturer_id`),
  KEY `fk_LENS_3` (`mount_id`),
  KEY `fk_LENS_4` (`negative_size_id`),
  KEY `fk_LENS_1_idx` (`condition_id`),
  CONSTRAINT `fk_LENS_1` FOREIGN KEY (`condition_id`) REFERENCES `CONDITION` (`condition_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_LENS_2` FOREIGN KEY (`manufacturer_id`) REFERENCES `MANUFACTURER` (`manufacturer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_LENS_3` FOREIGN KEY (`mount_id`) REFERENCES `MOUNT` (`mount_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_LENS_4` FOREIGN KEY (`negative_size_id`) REFERENCES `NEGATIVE_SIZE` (`negative_size_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog lenses';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LIGHT_METER` (
  `light_meter_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for this light meter',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'Denotes ID of manufacturer of the light meter',
  `model` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Model name or number of the light meter',
  `metering_type` int(11) DEFAULT NULL COMMENT 'ID of metering technology used in this light meter',
  `reflected` tinyint(1) DEFAULT NULL COMMENT 'Whether the meter is capable of reflected-light metering',
  `incident` tinyint(1) DEFAULT NULL COMMENT 'Whether the meter is capable of incident-light metering',
  `flash` tinyint(1) DEFAULT NULL COMMENT 'Whether the meter is capable of flash metering',
  `spot` tinyint(1) DEFAULT NULL COMMENT 'Whether the meter is capable of spot metering',
  `min_asa` int(11) DEFAULT NULL COMMENT 'Minimum ISO/ASA that this meter is capable of handling',
  `max_asa` int(11) DEFAULT NULL COMMENT 'Maximum ISO/ASA that this meter is capable of handling',
  `min_lv` int(11) DEFAULT NULL COMMENT 'Minimum light value (LV/EV) that this meter is capable of handling',
  `max_lv` int(11) DEFAULT NULL COMMENT 'Maximum light value (LV/EV) that this meter is capable of handling',
  PRIMARY KEY (`light_meter_id`),
  KEY `fk_LIGHT_METER_1_idx` (`manufacturer_id`),
  KEY `fk_LIGHT_METER_2_idx` (`metering_type`),
  CONSTRAINT `fk_LIGHT_METER_1` FOREIGN KEY (`manufacturer_id`) REFERENCES `MANUFACTURER` (`manufacturer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_LIGHT_METER_2` FOREIGN KEY (`metering_type`) REFERENCES `METERING_TYPE` (`metering_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog light meters';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LOG` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of the log entry',
  `datetime` datetime DEFAULT NULL COMMENT 'Timestamp for the log entry',
  `type` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Type of log message, e.g. ADD, EDIT',
  `message` varchar(450) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Log message',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1274 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to store data modification logs';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MANUFACTURER` (
  `manufacturer_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of the manufacturer',
  `manufacturer` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of the manufacturer',
  `city` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'City in which the manufacturer is based',
  `country` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Country in which the manufacturer is based',
  `url` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'URL to the manufacturer''s main website',
  `founded` smallint(6) DEFAULT NULL COMMENT 'Year in which the manufacturer was founded',
  `dissolved` smallint(6) DEFAULT NULL COMMENT 'Year in which the manufacturer was dissolved',
  PRIMARY KEY (`manufacturer_id`),
  UNIQUE KEY `manufacturer_UNIQUE` (`manufacturer`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog manufacturers of equipment and consumables';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `METERING_MODE` (
  `metering_mode_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID of metering mode as defined by EXIF tag MeteringMode',
  `metering_mode` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of metering mode as defined by EXIF tag MeteringMode',
  PRIMARY KEY (`metering_mode_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Metering modes as defined by EXIF tag MeteringMode';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `METERING_MODE_AVAILABLE` (
  `camera_id` int(11) NOT NULL COMMENT 'ID of camera',
  `metering_mode_id` int(11) NOT NULL COMMENT 'ID of metering mode',
  PRIMARY KEY (`camera_id`,`metering_mode_id`),
  KEY `fk_METERING_MODE_AVAILABLE_2_idx` (`metering_mode_id`),
  CONSTRAINT `fk_METERING_MODE_AVAILABLE_1` FOREIGN KEY (`camera_id`) REFERENCES `CAMERA` (`camera_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_METERING_MODE_AVAILABLE_2` FOREIGN KEY (`metering_mode_id`) REFERENCES `METERING_MODE` (`metering_mode_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to associate cameras with available metering modes';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `METERING_TYPE` (
  `metering_type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of the metering type',
  `metering` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of the metering type (e.g. Selenium)',
  PRIMARY KEY (`metering_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog different metering technologies and cell types';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MOUNT` (
  `mount_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of this lens mount',
  `mount` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of this lens mount (e.g. Canon FD)',
  `fixed` tinyint(1) DEFAULT NULL COMMENT 'Whether this is a fixed (non-interchangable) lens mount',
  `shutter_in_lens` tinyint(1) DEFAULT NULL COMMENT 'Whether this lens mount system incorporates the shutter into the lens',
  `type` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The physical mount type of this lens mount (e.g. Screw, Bayonet, etc)',
  `purpose` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The intended purpose of this lens mount (e.g. camera, enlarger, projector)',
  `notes` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Freeform notes field',
  `digital_only` tinyint(1) DEFAULT NULL COMMENT 'Whether this mount is intended only for digital cameras',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'Manufacturer ID of this lens mount, if applicable',
  PRIMARY KEY (`mount_id`),
  KEY `fk_MOUNT_1_idx` (`manufacturer_id`),
  CONSTRAINT `fk_MOUNT_1` FOREIGN KEY (`manufacturer_id`) REFERENCES `MANUFACTURER` (`manufacturer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog different lens mount standards. This is mostly used for camera lens mounts, but can also be used for enlarger and projector lenses.';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MOUNT_ADAPTER` (
  `mount_adapter_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of lens mount adapter',
  `lens_mount` int(11) DEFAULT NULL COMMENT 'ID of the mount used between the adapter and the lens',
  `camera_mount` int(11) DEFAULT NULL COMMENT 'ID of the mount used between the adapter and the camera',
  `has_optics` tinyint(1) DEFAULT NULL COMMENT 'Whether this adapter includes optical elements',
  `infinity_focus` tinyint(1) DEFAULT NULL COMMENT 'Whether this adapter allows infinity focus',
  `notes` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Freeform notes',
  PRIMARY KEY (`mount_adapter_id`),
  KEY `fk_MOUNT_ADAPTER_1` (`lens_mount`),
  KEY `fk_MOUNT_ADAPTER_2` (`camera_mount`),
  CONSTRAINT `fk_MOUNT_ADAPTER_1` FOREIGN KEY (`lens_mount`) REFERENCES `MOUNT` (`mount_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_MOUNT_ADAPTER_2` FOREIGN KEY (`camera_mount`) REFERENCES `MOUNT` (`mount_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog adapters to mount lenses on other cameras';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MOVIE` (
  `movie_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for this motion picture film / movie',
  `title` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Title of this movie',
  `camera_id` int(11) DEFAULT NULL COMMENT 'ID of the camera used to shoot this movie',
  `lens_id` int(11) DEFAULT NULL COMMENT 'ID of the lens used to shoot this movie',
  `format_id` int(11) DEFAULT NULL COMMENT 'ID of the film format on which this movie was shot',
  `sound` tinyint(1) DEFAULT NULL COMMENT 'Whether this movie has sound',
  `fps` int(11) DEFAULT NULL COMMENT 'Frame rate of this movie, in fps',
  `filmstock_id` int(11) DEFAULT NULL COMMENT 'ID of the filmstock used to shoot this movie',
  `feet` int(11) DEFAULT NULL COMMENT 'Length of this movie in feet',
  `date_loaded` date DEFAULT NULL COMMENT 'Date that the filmstock was loaded into a camera',
  `date_shot` date DEFAULT NULL COMMENT 'Date on which this movie was shot',
  `date_processed` date DEFAULT NULL COMMENT 'Date on which this movie was processed',
  `process_id` int(11) DEFAULT NULL COMMENT 'ID of the process used to develop this film',
  `description` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Table to catalog motion picture films (movies)',
  PRIMARY KEY (`movie_id`),
  KEY `fk_MOVIE_1_idx` (`camera_id`),
  KEY `fk_MOVIE_2_idx` (`lens_id`),
  KEY `fk_MOVIE_3_idx` (`format_id`),
  KEY `fk_MOVIE_4_idx` (`filmstock_id`),
  KEY `fk_MOVIE_5_idx` (`process_id`),
  CONSTRAINT `fk_MOVIE_1` FOREIGN KEY (`camera_id`) REFERENCES `CAMERA` (`camera_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_MOVIE_2` FOREIGN KEY (`lens_id`) REFERENCES `LENS` (`lens_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_MOVIE_3` FOREIGN KEY (`format_id`) REFERENCES `FORMAT` (`format_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_MOVIE_4` FOREIGN KEY (`filmstock_id`) REFERENCES `FILMSTOCK` (`filmstock_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_MOVIE_5` FOREIGN KEY (`process_id`) REFERENCES `PROCESS` (`process_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog motion picture films (movies)';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NEGATIVE` (
  `negative_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of this negative',
  `film_id` int(11) DEFAULT NULL COMMENT 'ID of the film that this negative belongs to',
  `frame` varchar(5) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Frame number or code of this negative',
  `description` varchar(145) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Caption of this picture',
  `date` datetime DEFAULT NULL COMMENT 'Date & time on which this picture was taken',
  `lens_id` int(11) DEFAULT NULL COMMENT 'ID of lens used to take this picture',
  `shutter_speed` varchar(45) CHARACTER SET latin1 DEFAULT NULL COMMENT 'Shutter speed used to take this picture',
  `aperture` decimal(4,1) DEFAULT NULL COMMENT 'Aperture used to take this picture (numerical part only)',
  `filter_id` int(11) DEFAULT NULL COMMENT 'ID of filter used to take this picture',
  `teleconverter_id` int(11) DEFAULT NULL COMMENT 'ID of teleconverter used to take this picture',
  `notes` text CHARACTER SET utf8mb4 COMMENT 'Extra freeform notes about this exposure',
  `mount_adapter_id` int(11) DEFAULT NULL COMMENT 'ID of lens mount adapter used to take this pciture',
  `focal_length` int(11) DEFAULT NULL COMMENT 'If a zoom lens was used, specify the focal length of the lens',
  `latitude` decimal(9,6) DEFAULT NULL COMMENT 'Latitude of the location where the picture was taken',
  `longitude` decimal(9,6) DEFAULT NULL COMMENT 'Longitude of the location where the picture was taken',
  `flash` tinyint(1) DEFAULT NULL COMMENT 'Whether flash was used',
  `metering_mode` int(11) DEFAULT NULL COMMENT 'MeteringMode ID as defined in EXIF spec',
  `exposure_program` int(11) DEFAULT NULL COMMENT 'ExposureProgram ID as defined in EXIF spec',
  `photographer_id` int(11) DEFAULT NULL COMMENT 'ID of person who took this photograph',
  `copy_of` int(11) DEFAULT NULL COMMENT 'Negative ID of negative from which this negative is reproduced/duplicated/rephotographed',
  PRIMARY KEY (`negative_id`),
  KEY `fk_NEGATIVE_1` (`film_id`),
  KEY `fk_NEGATIVE_2` (`lens_id`),
  KEY `fk_NEGATIVE_3` (`filter_id`),
  KEY `fk_NEGATIVE_4` (`teleconverter_id`),
  KEY `fk_NEGATIVE_5` (`mount_adapter_id`),
  KEY `fk_NEGATIVE_6_idx` (`metering_mode`),
  KEY `fk_NEGATIVE_7_idx` (`exposure_program`),
  KEY `fk_NEGATIVE_8_idx` (`photographer_id`),
  KEY `fk_NEGATIVE_9_idx` (`shutter_speed`),
  KEY `fk_NEGATIVE_10_idx` (`copy_of`),
  CONSTRAINT `fk_NEGATIVE_1` FOREIGN KEY (`film_id`) REFERENCES `FILM` (`film_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_NEGATIVE_10` FOREIGN KEY (`copy_of`) REFERENCES `NEGATIVE` (`negative_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_NEGATIVE_2` FOREIGN KEY (`lens_id`) REFERENCES `LENS` (`lens_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_NEGATIVE_3` FOREIGN KEY (`filter_id`) REFERENCES `FILTER` (`filter_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_NEGATIVE_4` FOREIGN KEY (`teleconverter_id`) REFERENCES `TELECONVERTER` (`teleconverter_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_NEGATIVE_5` FOREIGN KEY (`mount_adapter_id`) REFERENCES `MOUNT_ADAPTER` (`mount_adapter_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_NEGATIVE_6` FOREIGN KEY (`metering_mode`) REFERENCES `METERING_MODE` (`metering_mode_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_NEGATIVE_7` FOREIGN KEY (`exposure_program`) REFERENCES `EXPOSURE_PROGRAM` (`exposure_program_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_NEGATIVE_8` FOREIGN KEY (`photographer_id`) REFERENCES `PERSON` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_NEGATIVE_9` FOREIGN KEY (`shutter_speed`) REFERENCES `SHUTTER_SPEED` (`shutter_speed`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6823 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog negatives (which includes positives/slide too). Negatives are created by cameras, belong to films and can be used to create scans or prints.';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NEGATIVE_SIZE` (
  `negative_size_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of negative size',
  `width` decimal(4,1) DEFAULT NULL COMMENT 'Width of the negative size in mm',
  `height` decimal(4,1) DEFAULT NULL COMMENT 'Height of the negative size in mm',
  `negative_size` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Common name of the negative size (e.g. 35mm, 6x7, etc)',
  `crop_factor` decimal(4,2) DEFAULT NULL COMMENT 'Crop factor of this negative size',
  `area` int(11) DEFAULT NULL COMMENT 'Area of this negative size in sq. mm',
  `aspect_ratio` decimal(4,2) DEFAULT NULL COMMENT 'Aspect ratio of this negative size, expressed as a single decimal. (e.g. 3:2 is expressed as 1.5)',
  PRIMARY KEY (`negative_size_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog different negative sizes available. Negtives sizes are distinct from film formats.';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PAPER_STOCK` (
  `paper_stock_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of this paper stock',
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of this paper stock',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'ID of the manufacturer of this paper stock',
  `resin_coated` tinyint(1) DEFAULT NULL COMMENT 'Whether the paper is resin-coated',
  `tonable` tinyint(1) DEFAULT NULL COMMENT 'Whether this paper accepts chemical toning',
  `colour` tinyint(1) DEFAULT NULL COMMENT 'Whether this is a colour paper',
  `finish` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The finish of the paper surface',
  PRIMARY KEY (`paper_stock_id`),
  KEY `fk_PAPER_STOCK_1` (`manufacturer_id`),
  CONSTRAINT `fk_PAPER_STOCK_1` FOREIGN KEY (`manufacturer_id`) REFERENCES `MANUFACTURER` (`manufacturer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog different paper stocks available';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PERSON` (
  `person_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for the person',
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of the photographer',
  PRIMARY KEY (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog photographers';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PRINT` (
  `print_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for the print',
  `negative_id` int(11) DEFAULT NULL COMMENT 'ID of the negative that this print was made from',
  `date` date DEFAULT NULL COMMENT 'The date that the print was made',
  `paper_stock_id` int(11) DEFAULT NULL COMMENT 'ID of the paper stock used',
  `height` decimal(4,1) DEFAULT NULL COMMENT 'Height of the print in inches',
  `width` decimal(4,1) DEFAULT NULL COMMENT 'Width of the print in inches',
  `aperture` decimal(3,1) DEFAULT NULL COMMENT 'Aperture used to make this print (numerical part only, e.g. 5.6)',
  `exposure_time` decimal(5,1) DEFAULT NULL COMMENT 'Exposure time of this print in seconds',
  `filtration_grade` decimal(2,1) DEFAULT NULL COMMENT 'Contrast grade of paper used',
  `development_time` int(11) DEFAULT NULL COMMENT 'Development time of this print in seconds',
  `bleach_time` time DEFAULT NULL COMMENT 'Duration of bleaching',
  `toner_id` int(11) DEFAULT NULL COMMENT 'ID of the first toner used to make this print',
  `toner_dilution` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Dilution of the first toner used to make this print',
  `toner_time` time DEFAULT NULL COMMENT 'Duration of first toning',
  `2nd_toner_id` int(11) DEFAULT NULL COMMENT 'ID of the second toner used to make this print',
  `2nd_toner_dilution` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Dilution of the second toner used to make this print',
  `2nd_toner_time` time DEFAULT NULL COMMENT 'Duration of second toning',
  `own` tinyint(1) DEFAULT NULL COMMENT 'Whether we currently own this print',
  `location` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The place where this print is currently',
  `sold_price` decimal(5,2) DEFAULT NULL COMMENT 'Sale price of the print',
  `enlarger_id` int(11) DEFAULT NULL COMMENT 'ID of the enlarger used to make this print',
  `lens_id` int(11) DEFAULT NULL COMMENT 'ID of the lens used to make this print',
  `developer_id` int(11) DEFAULT NULL COMMENT 'ID of the developer used to develop this print',
  `fine` tinyint(1) DEFAULT NULL COMMENT 'Whether this is a fine print',
  `notes` text COLLATE utf8mb4_unicode_ci COMMENT 'Freeform notes about this print, e.g. dodging, burning & complex toning',
  `archive_id` int(11) DEFAULT NULL COMMENT 'ID of the archive to which this print belongs',
  `printer_id` int(11) DEFAULT NULL COMMENT 'ID of the person who made this print',
  PRIMARY KEY (`print_id`),
  KEY `fk_PRINT_1` (`paper_stock_id`),
  KEY `fk_PRINT_2` (`negative_id`),
  KEY `fk_PRINT_3` (`toner_id`),
  KEY `fk_PRINT_4` (`enlarger_id`),
  KEY `fk_PRINT_6` (`developer_id`),
  KEY `fk_PRINT_5_idx` (`lens_id`),
  KEY `fk_PRINT_7_idx` (`archive_id`),
  KEY `fk_PRINT_8_idx` (`printer_id`),
  CONSTRAINT `fk_PRINT_1` FOREIGN KEY (`paper_stock_id`) REFERENCES `PAPER_STOCK` (`paper_stock_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_PRINT_2` FOREIGN KEY (`negative_id`) REFERENCES `NEGATIVE` (`negative_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_PRINT_3` FOREIGN KEY (`toner_id`) REFERENCES `TONER` (`toner_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_PRINT_4` FOREIGN KEY (`enlarger_id`) REFERENCES `ENLARGER` (`enlarger_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_PRINT_5` FOREIGN KEY (`lens_id`) REFERENCES `LENS` (`lens_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_PRINT_6` FOREIGN KEY (`developer_id`) REFERENCES `DEVELOPER` (`developer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_PRINT_7` FOREIGN KEY (`archive_id`) REFERENCES `ARCHIVE` (`archive_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRINT_8` FOREIGN KEY (`printer_id`) REFERENCES `PERSON` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=966 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog prints made from negatives';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PROCESS` (
  `process_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID of this development process',
  `name` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of this developmenmt process (e.g. C-41, E-6)',
  `colour` tinyint(1) DEFAULT NULL COMMENT 'Whether this is a colour process',
  `positive` tinyint(1) DEFAULT NULL COMMENT 'Whether this is a positive/reversal process',
  PRIMARY KEY (`process_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog chemical processes that can be used to develop film and paper';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PROJECTOR` (
  `projector_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of this projector',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'ID of the manufacturer of this projector',
  `model` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Model name of this projector',
  `mount_id` int(11) DEFAULT NULL COMMENT 'ID of the lens mount of this projector, if it has interchangeable lenses',
  `negative_size_id` int(11) DEFAULT NULL COMMENT 'ID of the largest negative size that this projector can handle',
  `own` tinyint(1) DEFAULT NULL COMMENT 'Whether we currently own this projector',
  `cine` tinyint(1) DEFAULT NULL COMMENT 'Whether this is a cine (movie) projector',
  PRIMARY KEY (`projector_id`),
  KEY `fk_PROJECTOR_1_idx` (`manufacturer_id`),
  KEY `fk_PROJECTOR_2_idx` (`mount_id`),
  KEY `fk_PROJECTOR_3_idx` (`negative_size_id`),
  CONSTRAINT `fk_PROJECTOR_1` FOREIGN KEY (`manufacturer_id`) REFERENCES `MANUFACTURER` (`manufacturer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PROJECTOR_2` FOREIGN KEY (`mount_id`) REFERENCES `MOUNT` (`mount_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PROJECTOR_3` FOREIGN KEY (`negative_size_id`) REFERENCES `NEGATIVE_SIZE` (`negative_size_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog projectors (still and movie)';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REPAIR` (
  `repair_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for the repair job',
  `camera_id` int(11) DEFAULT NULL COMMENT 'ID of camera that was repaired',
  `lens_id` int(11) DEFAULT NULL COMMENT 'ID of lens that was repaired',
  `date` date DEFAULT NULL COMMENT 'The date of the repair',
  `summary` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Brief summary of the repair',
  `description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Longer description of the repair',
  PRIMARY KEY (`repair_id`),
  KEY `fk_REPAIR_1_idx` (`camera_id`),
  KEY `fk_REPAIR_2_idx` (`lens_id`),
  CONSTRAINT `fk_REPAIR_1` FOREIGN KEY (`camera_id`) REFERENCES `CAMERA` (`camera_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_REPAIR_2` FOREIGN KEY (`lens_id`) REFERENCES `LENS` (`lens_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabe to catalog all repairs and servicing undertaken on cameras and lenses in the collection';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SCAN` (
  `scan_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for this scan',
  `negative_id` int(11) DEFAULT NULL COMMENT 'ID of the negative that was scanned',
  `print_id` int(11) DEFAULT NULL COMMENT 'ID of the print  that was scanned',
  `filename` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Filename of the scan',
  `date` date DEFAULT NULL COMMENT 'Date that this scan was made',
  `colour` tinyint(1) DEFAULT NULL COMMENT 'Whether this is a colour image',
  `width` int(11) DEFAULT NULL COMMENT 'Width of the scanned image in pixels',
  `height` int(11) DEFAULT NULL COMMENT 'Height of the scanned image in pixels',
  PRIMARY KEY (`scan_id`),
  KEY `fk_SCAN_1_idx` (`negative_id`),
  KEY `fk_SCAN_2_idx` (`print_id`),
  CONSTRAINT `fk_SCAN_1` FOREIGN KEY (`negative_id`) REFERENCES `NEGATIVE` (`negative_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_SCAN_2` FOREIGN KEY (`print_id`) REFERENCES `PRINT` (`print_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9187 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to record all the images that have been scanned digitally';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SHUTTER_SPEED` (
  `shutter_speed` varchar(10) CHARACTER SET latin1 NOT NULL COMMENT 'Shutter speed in fractional notation, e.g. 1/250',
  `duration` decimal(7,5) DEFAULT NULL COMMENT 'Shutter speed in decimal notation, e.g. 0.04',
  PRIMARY KEY (`shutter_speed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Table to list all possible shutter speeds';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SHUTTER_SPEED_AVAILABLE` (
  `camera_id` int(11) NOT NULL COMMENT 'ID of the camera',
  `shutter_speed` varchar(10) CHARACTER SET latin1 NOT NULL COMMENT 'Shutter speed that this camera has',
  PRIMARY KEY (`camera_id`,`shutter_speed`),
  KEY `fk_SHUTTER_SPEED_AVAILABLE_1_idx` (`shutter_speed`),
  KEY `fk_SHUTTER_SPEED_AVAILABLE_2_idx` (`camera_id`),
  CONSTRAINT `fk_SHUTTER_SPEED_AVAILABLE_1` FOREIGN KEY (`shutter_speed`) REFERENCES `SHUTTER_SPEED` (`shutter_speed`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_SHUTTER_SPEED_AVAILABLE_2` FOREIGN KEY (`camera_id`) REFERENCES `CAMERA` (`camera_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Table to associate cameras with shutter speeds';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SHUTTER_TYPE` (
  `shutter_type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of the shutter type',
  `shutter_type` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of the shutter type (e.g. Focal plane, Leaf, etc)',
  PRIMARY KEY (`shutter_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog the different types of camera shutter';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TELECONVERTER` (
  `teleconverter_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of this teleconverter',
  `mount_id` int(11) DEFAULT NULL COMMENT 'ID of the lens mount used by this teleconverter',
  `factor` decimal(4,2) DEFAULT NULL COMMENT 'Magnification factor of this teleconverter (numerical part only, e.g. 1.4)',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'ID of the manufacturer of this teleconverter',
  `model` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Model name of this teleconverter',
  `elements` tinyint(4) DEFAULT NULL COMMENT 'Number of optical elements used in this teleconverter',
  `groups` tinyint(4) DEFAULT NULL COMMENT 'Number of optical groups used in this teleconverter',
  `multicoated` tinyint(1) DEFAULT NULL COMMENT 'Whether this teleconverter is multi-coated',
  PRIMARY KEY (`teleconverter_id`),
  KEY `fk_TELECONVERTER_1` (`manufacturer_id`),
  KEY `fk_TELECONVERTER_2` (`mount_id`),
  CONSTRAINT `fk_TELECONVERTER_1` FOREIGN KEY (`manufacturer_id`) REFERENCES `MANUFACTURER` (`manufacturer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_TELECONVERTER_2` FOREIGN KEY (`mount_id`) REFERENCES `MOUNT` (`mount_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog teleconverters (multipliers)';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TONER` (
  `toner_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of the toner',
  `manufacturer_id` int(11) DEFAULT NULL COMMENT 'ID of the manufacturer of the toner',
  `toner` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of the toner',
  `formulation` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Chemical formulation of the toner',
  `stock_dilution` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Stock dilution of the toner',
  PRIMARY KEY (`toner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalog paper toners that can be used during the printing process';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TO_PRINT` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID of this table',
  `negative_id` int(11) DEFAULT NULL COMMENT 'Negative ID to be printed',
  `width` int(11) DEFAULT NULL COMMENT 'Width of print to be made',
  `height` int(11) DEFAULT NULL COMMENT 'Height of print to be made',
  `printed` tinyint(1) DEFAULT '0' COMMENT 'Whether the print has been made',
  `print_id` int(11) DEFAULT NULL COMMENT 'ID of print made',
  `recipient` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Recipient of the print',
  `added` date DEFAULT NULL COMMENT 'Date that record was added',
  PRIMARY KEY (`id`),
  KEY `fk_TO_PRINT_1_idx` (`negative_id`),
  CONSTRAINT `fk_TO_PRINT_1` FOREIGN KEY (`negative_id`) REFERENCES `NEGATIVE` (`negative_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to catalogue negatives that should be printed';
/*!40101 SET character_set_client = @saved_cs_client */;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `archive_contents` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL,
  `archive_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `camera_chooser` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL,
  `manufacturer_id` tinyint NOT NULL,
  `mount_id` tinyint NOT NULL,
  `format_id` tinyint NOT NULL,
  `focus_type_id` tinyint NOT NULL,
  `metering` tinyint NOT NULL,
  `coupled_metering` tinyint NOT NULL,
  `metering_type_id` tinyint NOT NULL,
  `body_type_id` tinyint NOT NULL,
  `weight` tinyint NOT NULL,
  `manufactured` tinyint NOT NULL,
  `negative_size_id` tinyint NOT NULL,
  `shutter_type_id` tinyint NOT NULL,
  `shutter_model` tinyint NOT NULL,
  `cable_release` tinyint NOT NULL,
  `power_drive` tinyint NOT NULL,
  `continuous_fps` tinyint NOT NULL,
  `video` tinyint NOT NULL,
  `digital` tinyint NOT NULL,
  `fixed_mount` tinyint NOT NULL,
  `lens_id` tinyint NOT NULL,
  `battery_qty` tinyint NOT NULL,
  `battery_type` tinyint NOT NULL,
  `min_shutter` tinyint NOT NULL,
  `max_shutter` tinyint NOT NULL,
  `bulb` tinyint NOT NULL,
  `time` tinyint NOT NULL,
  `min_iso` tinyint NOT NULL,
  `max_iso` tinyint NOT NULL,
  `af_points` tinyint NOT NULL,
  `int_flash` tinyint NOT NULL,
  `int_flash_gn` tinyint NOT NULL,
  `ext_flash` tinyint NOT NULL,
  `flash_metering` tinyint NOT NULL,
  `pc_sync` tinyint NOT NULL,
  `hotshoe` tinyint NOT NULL,
  `coldshoe` tinyint NOT NULL,
  `x_sync` tinyint NOT NULL,
  `meter_min_ev` tinyint NOT NULL,
  `meter_max_ev` tinyint NOT NULL,
  `dof_preview` tinyint NOT NULL,
  `tripod` tinyint NOT NULL,
  `display_lens` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `cameralens_compat` (
  `camera_id` tinyint NOT NULL,
  `camera` tinyint NOT NULL,
  `lens_id` tinyint NOT NULL,
  `lens` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_accessory` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_accessory_compat` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL,
  `camera_id` tinyint NOT NULL,
  `lens_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_battery` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_bulk_film` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_camera` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL,
  `mount_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_camera_by_film` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL,
  `film_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_camera_without_exposure_programs` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_camera_without_metering_data` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_camera_without_shutter_data` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_display_lens` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL,
  `camera_id` tinyint NOT NULL,
  `mount_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_enlarger` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_enlarger_lens` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_film_to_develop` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_film_to_load` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_filmstock` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_filter` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL,
  `thread` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_flash_protocol` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_lens` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_lens_by_film` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL,
  `film_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_mount` (
  `mount_id` tinyint NOT NULL,
  `mount` tinyint NOT NULL,
  `purpose` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_mount_adapter_by_film` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL,
  `film_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_movie_camera` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_paper` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_scan` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL,
  `filename` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_shutter_speed_by_film` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL,
  `film_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_teleconverter_by_film` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL,
  `film_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `choose_todo` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `current_films` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `exhibits` (
  `id` tinyint NOT NULL,
  `opt` tinyint NOT NULL,
  `exhibition_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `exifdata` (
  `film_id` tinyint NOT NULL,
  `negative_id` tinyint NOT NULL,
  `print_id` tinyint NOT NULL,
  `Make` tinyint NOT NULL,
  `Model` tinyint NOT NULL,
  `Author` tinyint NOT NULL,
  `LensMake` tinyint NOT NULL,
  `LensModel` tinyint NOT NULL,
  `Lens` tinyint NOT NULL,
  `LensSerialNumber` tinyint NOT NULL,
  `SerialNumber` tinyint NOT NULL,
  `path` tinyint NOT NULL,
  `MaxApertureValue` tinyint NOT NULL,
  `directory` tinyint NOT NULL,
  `filename` tinyint NOT NULL,
  `ExposureTime` tinyint NOT NULL,
  `FNumber` tinyint NOT NULL,
  `ApertureValue` tinyint NOT NULL,
  `FocalLength` tinyint NOT NULL,
  `ISO` tinyint NOT NULL,
  `ImageDescription` tinyint NOT NULL,
  `DateTimeOriginal` tinyint NOT NULL,
  `GPSLatitude` tinyint NOT NULL,
  `GPSLongitude` tinyint NOT NULL,
  `ExposureProgram` tinyint NOT NULL,
  `MeteringMode` tinyint NOT NULL,
  `Flash` tinyint NOT NULL,
  `FocalLengthIn35mmFormat` tinyint NOT NULL,
  `Copyright` tinyint NOT NULL,
  `UserComment` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `info_accessory` (
  `Accessory ID` tinyint NOT NULL,
  `Accessory type` tinyint NOT NULL,
  `Model` tinyint NOT NULL,
  `Acquired` tinyint NOT NULL,
  `Cost` tinyint NOT NULL,
  `Lost` tinyint NOT NULL,
  `Lost price` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `info_archive` (
  `Archive ID` tinyint NOT NULL,
  `Archive name` tinyint NOT NULL,
  `Maximum size` tinyint NOT NULL,
  `Location` tinyint NOT NULL,
  `Storage type` tinyint NOT NULL,
  `Sealed` tinyint NOT NULL,
  `Archive type` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `info_camera` (
  `Camera ID` tinyint NOT NULL,
  `Camera` tinyint NOT NULL,
  `Negative size` tinyint NOT NULL,
  `Body type` tinyint NOT NULL,
  `Mount` tinyint NOT NULL,
  `Film format` tinyint NOT NULL,
  `Focus type` tinyint NOT NULL,
  `Metering` tinyint NOT NULL,
  `Coupled metering` tinyint NOT NULL,
  `Metering type` tinyint NOT NULL,
  `Weight` tinyint NOT NULL,
  `Date acquired` tinyint NOT NULL,
  `Cost` tinyint NOT NULL,
  `Manufactured between` tinyint NOT NULL,
  `Serial number` tinyint NOT NULL,
  `Datecode` tinyint NOT NULL,
  `Year of manufacture` tinyint NOT NULL,
  `Shutter type` tinyint NOT NULL,
  `Shutter model` tinyint NOT NULL,
  `Cable release` tinyint NOT NULL,
  `Viewfinder coverage` tinyint NOT NULL,
  `Power drive` tinyint NOT NULL,
  `continuous_fps` tinyint NOT NULL,
  `Video` tinyint NOT NULL,
  `Digital` tinyint NOT NULL,
  `Fixed mount` tinyint NOT NULL,
  `Lens` tinyint NOT NULL,
  `Battery` tinyint NOT NULL,
  `Notes` tinyint NOT NULL,
  `Lost` tinyint NOT NULL,
  `Lost price` tinyint NOT NULL,
  `Source` tinyint NOT NULL,
  `Bulb` tinyint NOT NULL,
  `Time` tinyint NOT NULL,
  `ISO range` tinyint NOT NULL,
  `Autofocus points` tinyint NOT NULL,
  `Internal flash` tinyint NOT NULL,
  `Internal flash guide number` tinyint NOT NULL,
  `External flash` tinyint NOT NULL,
  `Flash metering` tinyint NOT NULL,
  `PC sync socket` tinyint NOT NULL,
  `Hotshoe` tinyint NOT NULL,
  `Coldshoe` tinyint NOT NULL,
  `X-sync speed` tinyint NOT NULL,
  `Meter range` tinyint NOT NULL,
  `Condition` tinyint NOT NULL,
  `Depth of field preview` tinyint NOT NULL,
  `Exposure programs` tinyint NOT NULL,
  `Metering modes` tinyint NOT NULL,
  `Shutter speeds` tinyint NOT NULL,
  `Focal length` tinyint NOT NULL,
  `Maximum aperture` tinyint NOT NULL,
  `Films loaded` tinyint NOT NULL,
  `Frames shot` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `info_enlarger` (
  `Enlarger ID` tinyint NOT NULL,
  `Manufacturer` tinyint NOT NULL,
  `Model` tinyint NOT NULL,
  `Negative size` tinyint NOT NULL,
  `Acquired` tinyint NOT NULL,
  `Lost` tinyint NOT NULL,
  `Introduced` tinyint NOT NULL,
  `Discontinued` tinyint NOT NULL,
  `Cost` tinyint NOT NULL,
  `Lost price` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `info_film` (
  `Film ID` tinyint NOT NULL,
  `ISO` tinyint NOT NULL,
  `Date` tinyint NOT NULL,
  `Title` tinyint NOT NULL,
  `Frames` tinyint NOT NULL,
  `dev_time` tinyint NOT NULL,
  `dev_temp` tinyint NOT NULL,
  `Development notes` tinyint NOT NULL,
  `Processed by` tinyint NOT NULL,
  `Filmstock` tinyint NOT NULL,
  `Camera` tinyint NOT NULL,
  `Developer` tinyint NOT NULL,
  `Archive` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `info_lens` (
  `Lens ID` tinyint NOT NULL,
  `Mount` tinyint NOT NULL,
  `Focal length` tinyint NOT NULL,
  `Lens` tinyint NOT NULL,
  `Closest focus` tinyint NOT NULL,
  `Maximum aperture` tinyint NOT NULL,
  `Minimum aperture` tinyint NOT NULL,
  `Elements/Groups` tinyint NOT NULL,
  `Weight` tinyint NOT NULL,
  `Angle of view` tinyint NOT NULL,
  `Aperture blades` tinyint NOT NULL,
  `Autofocus` tinyint NOT NULL,
  `Filter thread` tinyint NOT NULL,
  `Maximum magnification` tinyint NOT NULL,
  `URL` tinyint NOT NULL,
  `Serial number` tinyint NOT NULL,
  `Date code` tinyint NOT NULL,
  `Manufactured between` tinyint NOT NULL,
  `Year of manufacture` tinyint NOT NULL,
  `Negative size` tinyint NOT NULL,
  `Date acquired` tinyint NOT NULL,
  `Cost` tinyint NOT NULL,
  `Notes` tinyint NOT NULL,
  `Date lost` tinyint NOT NULL,
  `Price sold` tinyint NOT NULL,
  `Source` tinyint NOT NULL,
  `Coating` tinyint NOT NULL,
  `Hood` tinyint NOT NULL,
  `EXIF LensType` tinyint NOT NULL,
  `Rectilinear` tinyint NOT NULL,
  `Dimensions (l×w)` tinyint NOT NULL,
  `Condition` tinyint NOT NULL,
  `Image circle` tinyint NOT NULL,
  `Optical formula` tinyint NOT NULL,
  `Shutter model` tinyint NOT NULL,
  `Frames shot` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `info_movie` (
  `Movie ID` tinyint NOT NULL,
  `Title` tinyint NOT NULL,
  `Camera` tinyint NOT NULL,
  `Lens` tinyint NOT NULL,
  `Format` tinyint NOT NULL,
  `Sound` tinyint NOT NULL,
  `Frame rate` tinyint NOT NULL,
  `Filmstock` tinyint NOT NULL,
  `Length (feet)` tinyint NOT NULL,
  `Date loaded` tinyint NOT NULL,
  `Date shot` tinyint NOT NULL,
  `Date processed` tinyint NOT NULL,
  `Process` tinyint NOT NULL,
  `Description` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `info_negative` (
  `Negative ID` tinyint NOT NULL,
  `Film ID` tinyint NOT NULL,
  `Frame` tinyint NOT NULL,
  `Metering mode` tinyint NOT NULL,
  `Date` tinyint NOT NULL,
  `Location` tinyint NOT NULL,
  `Filename` tinyint NOT NULL,
  `Shutter speed` tinyint NOT NULL,
  `Lens` tinyint NOT NULL,
  `Photographer` tinyint NOT NULL,
  `Aperture` tinyint NOT NULL,
  `Caption` tinyint NOT NULL,
  `Focal length` tinyint NOT NULL,
  `Exposure program` tinyint NOT NULL,
  `Prints made` tinyint NOT NULL,
  `Camera` tinyint NOT NULL,
  `Filmstock` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `info_print` (
  `Negative` tinyint NOT NULL,
  `Negative ID` tinyint NOT NULL,
  `Print` tinyint NOT NULL,
  `Description` tinyint NOT NULL,
  `Size` tinyint NOT NULL,
  `Exposure time` tinyint NOT NULL,
  `Aperture` tinyint NOT NULL,
  `Filtration grade` tinyint NOT NULL,
  `Paper` tinyint NOT NULL,
  `Enlarger` tinyint NOT NULL,
  `Enlarger lens` tinyint NOT NULL,
  `First toner` tinyint NOT NULL,
  `Second toner` tinyint NOT NULL,
  `Print date` tinyint NOT NULL,
  `Photo date` tinyint NOT NULL,
  `Photographer` tinyint NOT NULL,
  `Location` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `report_cameras_by_decade` (
  `Decade` tinyint NOT NULL,
  `Cameras` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `report_most_popular_lenses_relative` (
  `Lens` tinyint NOT NULL,
  `Days owned` tinyint NOT NULL,
  `Frames shot` tinyint NOT NULL,
  `Frames shot per day` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `report_never_used_cameras` (
  `Camera` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `report_never_used_lenses` (
  `Lens` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `report_total_negatives_per_camera` (
  `Camera` tinyint NOT NULL,
  `Frames shot` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `report_total_negatives_per_lens` (
  `Lens` tinyint NOT NULL,
  `Frames shot` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `report_unscanned_negs` (
  `negative_id` tinyint NOT NULL,
  `film_id` tinyint NOT NULL,
  `frame` tinyint NOT NULL,
  `description` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `scans_negs` (
  `scan_id` tinyint NOT NULL,
  `directory` tinyint NOT NULL,
  `filename` tinyint NOT NULL,
  `negative_id` tinyint NOT NULL,
  `film_id` tinyint NOT NULL,
  `frame` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `date` tinyint NOT NULL,
  `lens_id` tinyint NOT NULL,
  `shutter_speed` tinyint NOT NULL,
  `aperture` tinyint NOT NULL,
  `filter_id` tinyint NOT NULL,
  `teleconverter_id` tinyint NOT NULL,
  `notes` tinyint NOT NULL,
  `mount_adapter_id` tinyint NOT NULL,
  `focal_length` tinyint NOT NULL,
  `latitude` tinyint NOT NULL,
  `longitude` tinyint NOT NULL,
  `flash` tinyint NOT NULL,
  `metering_mode` tinyint NOT NULL,
  `exposure_program` tinyint NOT NULL,
  `photographer_id` tinyint NOT NULL,
  `copy_of` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `name` varchar(255) CHARACTER SET latin1 NOT NULL COMMENT 'Filename of applied migration',
  `date_applied` datetime NOT NULL COMMENT 'Date migration was applied',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table to record schema migrations';
/*!40101 SET character_set_client = @saved_cs_client */;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `view_film_stocks` (
  `film` tinyint NOT NULL,
  `qty` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!50001 DROP TABLE IF EXISTS `archive_contents`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `archive_contents` AS select concat('Film #',`FILM`.`film_id`) AS `id`,(`FILM`.`notes` collate utf8mb4_unicode_ci) AS `opt`,`FILM`.`archive_id` AS `archive_id` from `FILM` union select concat('Print #',`PRINT`.`print_id`) AS `id`,`NEGATIVE`.`description` AS `opt`,`PRINT`.`archive_id` AS `archive_id` from (`PRINT` join `NEGATIVE`) where (`PRINT`.`negative_id` = `NEGATIVE`.`negative_id`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `camera_chooser`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `camera_chooser` AS select `CAMERA`.`camera_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERA`.`model`) AS `opt`,`CAMERA`.`manufacturer_id` AS `manufacturer_id`,`CAMERA`.`mount_id` AS `mount_id`,`CAMERA`.`format_id` AS `format_id`,`CAMERA`.`focus_type_id` AS `focus_type_id`,`CAMERA`.`metering` AS `metering`,`CAMERA`.`coupled_metering` AS `coupled_metering`,`CAMERA`.`metering_type_id` AS `metering_type_id`,`CAMERA`.`body_type_id` AS `body_type_id`,`CAMERA`.`weight` AS `weight`,`CAMERA`.`manufactured` AS `manufactured`,`CAMERA`.`negative_size_id` AS `negative_size_id`,`CAMERA`.`shutter_type_id` AS `shutter_type_id`,`CAMERA`.`shutter_model` AS `shutter_model`,`CAMERA`.`cable_release` AS `cable_release`,`CAMERA`.`power_drive` AS `power_drive`,`CAMERA`.`continuous_fps` AS `continuous_fps`,`CAMERA`.`video` AS `video`,`CAMERA`.`digital` AS `digital`,`CAMERA`.`fixed_mount` AS `fixed_mount`,`CAMERA`.`lens_id` AS `lens_id`,`CAMERA`.`battery_qty` AS `battery_qty`,`CAMERA`.`battery_type` AS `battery_type`,`CAMERA`.`min_shutter` AS `min_shutter`,`CAMERA`.`max_shutter` AS `max_shutter`,`CAMERA`.`bulb` AS `bulb`,`CAMERA`.`time` AS `time`,`CAMERA`.`min_iso` AS `min_iso`,`CAMERA`.`max_iso` AS `max_iso`,`CAMERA`.`af_points` AS `af_points`,`CAMERA`.`int_flash` AS `int_flash`,`CAMERA`.`int_flash_gn` AS `int_flash_gn`,`CAMERA`.`ext_flash` AS `ext_flash`,`CAMERA`.`flash_metering` AS `flash_metering`,`CAMERA`.`pc_sync` AS `pc_sync`,`CAMERA`.`hotshoe` AS `hotshoe`,`CAMERA`.`coldshoe` AS `coldshoe`,`CAMERA`.`x_sync` AS `x_sync`,`CAMERA`.`meter_min_ev` AS `meter_min_ev`,`CAMERA`.`meter_max_ev` AS `meter_max_ev`,`CAMERA`.`dof_preview` AS `dof_preview`,`CAMERA`.`tripod` AS `tripod`,`CAMERA`.`display_lens` AS `display_lens` from ((((`CAMERA` left join `MANUFACTURER` on((`CAMERA`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`))) left join `EXPOSURE_PROGRAM_AVAILABLE` on((`CAMERA`.`camera_id` = `EXPOSURE_PROGRAM_AVAILABLE`.`camera_id`))) left join `METERING_MODE_AVAILABLE` on((`CAMERA`.`camera_id` = `METERING_MODE_AVAILABLE`.`camera_id`))) left join `SHUTTER_SPEED_AVAILABLE` on((`CAMERA`.`camera_id` = `SHUTTER_SPEED_AVAILABLE`.`camera_id`))) where (`CAMERA`.`own` = 1) group by `CAMERA`.`camera_id` order by concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERA`.`model`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `cameralens_compat`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `cameralens_compat` AS select `CAMERA`.`camera_id` AS `camera_id`,concat(`CM`.`manufacturer`,' ',`CAMERA`.`model`) AS `camera`,`LENS`.`lens_id` AS `lens_id`,concat(`LM`.`manufacturer`,' ',`LENS`.`model`) AS `lens` from ((((`CAMERA` join `MOUNT` on((`CAMERA`.`mount_id` = `MOUNT`.`mount_id`))) join `LENS` on((`MOUNT`.`mount_id` = `LENS`.`mount_id`))) join `MANUFACTURER` `CM` on((`CAMERA`.`manufacturer_id` = `CM`.`manufacturer_id`))) join `MANUFACTURER` `LM` on((`LENS`.`manufacturer_id` = `LM`.`manufacturer_id`))) where ((`CAMERA`.`own` = 1) and (`LENS`.`own` = 1)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `choose_accessory`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_accessory` AS select `ACCESSORY`.`accessory_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`ACCESSORY`.`model`,' (',`ACCESSORY_TYPE`.`accessory_type`,')') AS `opt` from ((`ACCESSORY` join `MANUFACTURER`) join `ACCESSORY_TYPE`) where ((`ACCESSORY`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`) and (`ACCESSORY`.`accessory_type_id` = `ACCESSORY_TYPE`.`accessory_type_id`) and isnull(`ACCESSORY`.`lost`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `choose_accessory_compat`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_accessory_compat` AS select `ACCESSORY`.`accessory_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`ACCESSORY`.`model`,' (',`ACCESSORY_TYPE`.`accessory_type`,')') AS `opt`,`ACCESSORY_COMPAT`.`camera_id` AS `camera_id`,`ACCESSORY_COMPAT`.`lens_id` AS `lens_id` from (((`ACCESSORY` join `ACCESSORY_COMPAT` on((`ACCESSORY_COMPAT`.`accessory_id` = `ACCESSORY`.`accessory_id`))) join `ACCESSORY_TYPE` on((`ACCESSORY`.`accessory_type_id` = `ACCESSORY_TYPE`.`accessory_type_id`))) left join `MANUFACTURER` on((`ACCESSORY`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `choose_battery`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_battery` AS select `BATTERY`.`battery_type` AS `id`,concat(`BATTERY`.`battery_name`,ifnull(concat(' (',`BATTERY`.`voltage`,'V)'),'')) AS `opt` from `BATTERY` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `choose_bulk_film`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_bulk_film` AS select `FILM_BULK`.`film_bulk_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`FILMSTOCK`.`name`,if(`FILM_BULK`.`batch`,concat(' (',`FILM_BULK`.`batch`,')'),'')) AS `opt` from ((`FILM_BULK` join `FILMSTOCK` on((`FILM_BULK`.`filmstock_id` = `FILMSTOCK`.`filmstock_id`))) join `MANUFACTURER` on((`FILMSTOCK`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `choose_camera`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_camera` AS select `CAMERA`.`camera_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERA`.`model`) AS `opt`,`CAMERA`.`mount_id` AS `mount_id` from (`CAMERA` join `MANUFACTURER`) where ((`CAMERA`.`own` = 1) and (`CAMERA`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`)) order by concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERA`.`model`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `choose_camera_by_film`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_camera_by_film` AS select `C`.`camera_id` AS `id`,concat(`M`.`manufacturer`,' ',`C`.`model`) AS `opt`,`F`.`film_id` AS `film_id` from ((`CAMERA` `C` join `FILM` `F`) join `MANUFACTURER` `M`) where ((`F`.`format_id` = `C`.`format_id`) and (`C`.`manufacturer_id` = `M`.`manufacturer_id`) and (`C`.`own` = 1)) order by concat(`M`.`manufacturer`,' ',`C`.`model`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `choose_camera_without_exposure_programs`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_camera_without_exposure_programs` AS select `CAMERA`.`camera_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERA`.`model`) AS `opt` from (`CAMERA` join `MANUFACTURER`) where ((not(`CAMERA`.`camera_id` in (select `EXPOSURE_PROGRAM_AVAILABLE`.`camera_id` from `EXPOSURE_PROGRAM_AVAILABLE`))) and (`CAMERA`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`) and (`CAMERA`.`own` = 1) and (`MANUFACTURER`.`manufacturer_id` <> 20)) order by concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERA`.`model`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `choose_camera_without_metering_data`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_camera_without_metering_data` AS select `CAMERA`.`camera_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERA`.`model`) AS `opt` from (`CAMERA` join `MANUFACTURER`) where ((not(`CAMERA`.`camera_id` in (select `METERING_MODE_AVAILABLE`.`camera_id` from `METERING_MODE_AVAILABLE`))) and (`CAMERA`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`) and (`CAMERA`.`own` = 1) and (`MANUFACTURER`.`manufacturer_id` <> 20)) order by concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERA`.`model`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `choose_camera_without_shutter_data`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_camera_without_shutter_data` AS select `CAMERA`.`camera_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERA`.`model`) AS `opt` from (`CAMERA` join `MANUFACTURER`) where ((not(`CAMERA`.`camera_id` in (select `SHUTTER_SPEED_AVAILABLE`.`camera_id` from `SHUTTER_SPEED_AVAILABLE`))) and (`CAMERA`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`) and (`CAMERA`.`own` = 1) and (`MANUFACTURER`.`manufacturer_id` <> 20)) order by concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERA`.`model`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `choose_display_lens`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_display_lens` AS select `LENS`.`lens_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`LENS`.`model`) AS `opt`,`CAMERA`.`camera_id` AS `camera_id`,`LENS`.`mount_id` AS `mount_id` from ((`LENS` left join `CAMERA` on((`LENS`.`lens_id` = `CAMERA`.`display_lens`))) join `MANUFACTURER` on((`LENS`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`))) where ((`LENS`.`mount_id` is not null) and (`LENS`.`own` = 1)) order by concat(`MANUFACTURER`.`manufacturer`,' ',`LENS`.`model`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `choose_enlarger`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_enlarger` AS select `ENLARGER`.`enlarger_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`ENLARGER`.`enlarger`) AS `opt` from (`ENLARGER` join `MANUFACTURER`) where ((`ENLARGER`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`) and isnull(`ENLARGER`.`lost`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `choose_enlarger_lens`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_enlarger_lens` AS select `LENS`.`lens_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`LENS`.`model`) AS `opt` from ((`LENS` join `MOUNT`) join `MANUFACTURER`) where ((`LENS`.`mount_id` = `MOUNT`.`mount_id`) and (`LENS`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`) and (`MOUNT`.`purpose` = 'Enlarger') and (`LENS`.`own` = 1)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `choose_film_to_develop`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_film_to_develop` AS select `FILM`.`film_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`FILMSTOCK`.`name`,' (',`FORMAT`.`format`,' format, ',if(`FILMSTOCK`.`colour`,'colour','B&W'),')') AS `opt` from (((`FILM` join `FILMSTOCK`) join `FORMAT`) join `MANUFACTURER`) where ((`FILM`.`camera_id` is not null) and isnull(`FILM`.`date`) and (`FILM`.`filmstock_id` = `FILMSTOCK`.`filmstock_id`) and (`FILM`.`format_id` = `FORMAT`.`format_id`) and (`FILMSTOCK`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`)) order by `FILM`.`film_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `choose_film_to_load`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_film_to_load` AS select `FILM`.`film_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`FILMSTOCK`.`name`,' (',`FORMAT`.`format`,' format, ',if(`FILMSTOCK`.`colour`,'colour','B&W'),')') AS `opt` from (((`FILM` join `FILMSTOCK`) join `FORMAT`) join `MANUFACTURER`) where (isnull(`FILM`.`camera_id`) and isnull(`FILM`.`date`) and (`FILM`.`filmstock_id` = `FILMSTOCK`.`filmstock_id`) and (`FILM`.`format_id` = `FORMAT`.`format_id`) and (`FILMSTOCK`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `choose_filmstock`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_filmstock` AS select `FILMSTOCK`.`filmstock_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`FILMSTOCK`.`name`) AS `opt` from (`FILMSTOCK` join `MANUFACTURER`) where (`FILMSTOCK`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`) order by concat(`MANUFACTURER`.`manufacturer`,' ',`FILMSTOCK`.`name`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `choose_filter`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_filter` AS select `FILTER`.`filter_id` AS `id`,concat(`FILTER`.`type`,' (',`FILTER`.`thread`,'mm)') AS `opt`,`FILTER`.`thread` AS `thread` from `FILTER` order by concat(`FILTER`.`type`,' (',`FILTER`.`thread`,'mm)') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `choose_flash_protocol`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_flash_protocol` AS select `FLASH_PROTOCOL`.`flash_protocol_id` AS `id`,if((isnull(`MANUFACTURER`.`manufacturer_id`) or (`MANUFACTURER`.`manufacturer` = 'Unknown')),`FLASH_PROTOCOL`.`name`,concat(`MANUFACTURER`.`manufacturer`,' ',`FLASH_PROTOCOL`.`name`)) AS `opt` from (`FLASH_PROTOCOL` left join `MANUFACTURER` on((`MANUFACTURER`.`manufacturer_id` = `FLASH_PROTOCOL`.`manufacturer_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `choose_lens`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_lens` AS select `LENS`.`lens_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`LENS`.`model`) AS `opt` from (`LENS` join `MANUFACTURER`) where ((`LENS`.`own` = 1) and (`LENS`.`fixed_mount` = 0) and (`LENS`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`)) order by concat(`MANUFACTURER`.`manufacturer`,' ',`LENS`.`model`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `choose_lens_by_film`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_lens_by_film` AS select `LENS`.`lens_id` AS `id`,`LENS`.`model` AS `opt`,`FILM`.`film_id` AS `film_id` from ((`FILM` join `CAMERA` on((`FILM`.`camera_id` = `CAMERA`.`camera_id`))) join `LENS` on((`CAMERA`.`mount_id` = `LENS`.`mount_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `choose_mount`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_mount` AS select `MOUNT`.`mount_id` AS `mount_id`,ifnull(concat(`MANUFACTURER`.`manufacturer`,' ',`MOUNT`.`mount`),`MOUNT`.`mount`) AS `mount`,`MOUNT`.`purpose` AS `purpose` from (`MOUNT` left join `MANUFACTURER` on((`MOUNT`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`))) order by ifnull(concat(`MANUFACTURER`.`manufacturer`,' ',`MOUNT`.`mount`),`MOUNT`.`mount`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `choose_mount_adapter_by_film`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_mount_adapter_by_film` AS select `MA`.`mount_adapter_id` AS `id`,`M`.`mount` AS `opt`,`F`.`film_id` AS `film_id` from (((`MOUNT_ADAPTER` `MA` join `CAMERA` `C` on((`C`.`mount_id` = `MA`.`camera_mount`))) join `FILM` `F` on((`F`.`camera_id` = `C`.`camera_id`))) join `MOUNT` `M` on((`M`.`mount_id` = `MA`.`lens_mount`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `choose_movie_camera`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_movie_camera` AS select `C`.`camera_id` AS `id`,concat(`M`.`manufacturer`,' ',`C`.`model`) AS `opt` from (`CAMERA` `C` join `MANUFACTURER` `M`) where ((`C`.`manufacturer_id` = `M`.`manufacturer_id`) and (`C`.`own` = 1) and (`C`.`video` = 1) and (`C`.`digital` = 0)) order by concat(`M`.`manufacturer`,' ',`C`.`model`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `choose_paper`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_paper` AS select `PAPER_STOCK`.`paper_stock_id` AS `id`,concat(`MANUFACTURER`.`manufacturer`,' ',`PAPER_STOCK`.`name`,ifnull(concat(' (',`PAPER_STOCK`.`finish`,')'),'')) AS `opt` from (`PAPER_STOCK` join `MANUFACTURER`) where (`PAPER_STOCK`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`) order by concat(`MANUFACTURER`.`manufacturer`,' ',`PAPER_STOCK`.`name`,ifnull(concat(' (',`PAPER_STOCK`.`finish`,')'),'')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `choose_scan`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_scan` AS select `SCAN`.`scan_id` AS `id`,ifnull(concat('Negative ',`NEGATIVE`.`film_id`,'/',`NEGATIVE`.`frame`,ifnull(concat(' ',`NEGATIVE`.`description`),'')),concat('Print #',`PRINT`.`print_id`,' ',`PRINTNEG`.`description`)) AS `opt`,`SCAN`.`filename` AS `filename` from (((`SCAN` left join `NEGATIVE` on((`SCAN`.`negative_id` = `NEGATIVE`.`negative_id`))) left join `PRINT` on((`SCAN`.`print_id` = `PRINT`.`print_id`))) left join `NEGATIVE` `PRINTNEG` on((`PRINT`.`negative_id` = `PRINTNEG`.`negative_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `choose_shutter_speed_by_film`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_shutter_speed_by_film` AS select `SHUTTER_SPEED`.`shutter_speed` AS `id`,'' AS `opt`,`FILM`.`film_id` AS `film_id` from (((`FILM` join `CAMERA` on((`FILM`.`camera_id` = `CAMERA`.`camera_id`))) join `SHUTTER_SPEED_AVAILABLE` on((`CAMERA`.`camera_id` = `SHUTTER_SPEED_AVAILABLE`.`camera_id`))) join `SHUTTER_SPEED` on((`SHUTTER_SPEED_AVAILABLE`.`shutter_speed` = `SHUTTER_SPEED`.`shutter_speed`))) order by `SHUTTER_SPEED`.`duration` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `choose_teleconverter_by_film`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_teleconverter_by_film` AS select `T`.`teleconverter_id` AS `id`,concat(`M`.`manufacturer`,' ',`T`.`model`,' (',`T`.`factor`,'x)') AS `opt`,`F`.`film_id` AS `film_id` from (((`TELECONVERTER` `T` join `CAMERA` `C` on((`C`.`mount_id` = `T`.`mount_id`))) join `FILM` `F` on((`F`.`camera_id` = `C`.`camera_id`))) join `MANUFACTURER` `M` on((`M`.`manufacturer_id` = `T`.`manufacturer_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `choose_todo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `choose_todo` AS select `TO_PRINT`.`id` AS `id`,concat(`NEGATIVE`.`film_id`,'/',`NEGATIVE`.`frame`,' ',`NEGATIVE`.`description`,' as ',ifnull(`TO_PRINT`.`width`,'?'),'x',ifnull(`TO_PRINT`.`height`,'?'),'"',if((`TO_PRINT`.`recipient` <> ''),concat(' for ',`TO_PRINT`.`recipient`),'')) AS `opt` from (`TO_PRINT` join `NEGATIVE`) where ((`TO_PRINT`.`negative_id` = `NEGATIVE`.`negative_id`) and (`TO_PRINT`.`printed` = 0)) order by `NEGATIVE`.`film_id`,`NEGATIVE`.`frame` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `current_films`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `current_films` AS select `FILM`.`film_id` AS `id`,concat(`FM`.`manufacturer`,' ',`FILMSTOCK`.`name`,ifnull(concat(' loaded into ',`CM`.`manufacturer`,' ',`CAMERA`.`model`),''),ifnull(concat(' on ',`FILM`.`date_loaded`),''),', ',count(`NEGATIVE`.`film_id`),ifnull(concat('/',`FILM`.`frames`),''),' frames registered') AS `opt` from (((((`FILM` join `CAMERA` on((`FILM`.`camera_id` = `CAMERA`.`camera_id`))) join `MANUFACTURER` `CM` on((`CAMERA`.`manufacturer_id` = `CM`.`manufacturer_id`))) join `FILMSTOCK` on((`FILM`.`filmstock_id` = `FILMSTOCK`.`filmstock_id`))) join `MANUFACTURER` `FM` on((`FILMSTOCK`.`manufacturer_id` = `FM`.`manufacturer_id`))) left join `NEGATIVE` on((`FILM`.`film_id` = `NEGATIVE`.`film_id`))) where isnull(`FILM`.`date`) group by `FILM`.`film_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `exhibits`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `exhibits` AS select `PRINT`.`print_id` AS `id`,concat(`NEGATIVE`.`description`,' (',`DISPLAYSIZE`(`PRINT`.`width`,`PRINT`.`height`),')') AS `opt`,`EXHIBIT`.`exhibition_id` AS `exhibition_id` from (((`NEGATIVE` join `PRINT` on((`PRINT`.`negative_id` = `NEGATIVE`.`negative_id`))) join `EXHIBIT` on((`EXHIBIT`.`print_id` = `PRINT`.`print_id`))) join `EXHIBITION` on((`EXHIBITION`.`exhibition_id` = `EXHIBIT`.`exhibition_id`))) order by `PRINT`.`print_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `exifdata`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `exifdata` AS select `f`.`film_id` AS `film_id`,`n`.`negative_id` AS `negative_id`,`PRINT`.`print_id` AS `print_id`,`cm`.`manufacturer` AS `Make`,concat(`cm`.`manufacturer`,' ',`c`.`model`) AS `Model`,`p`.`name` AS `Author`,`lm`.`manufacturer` AS `LensMake`,concat(`lm`.`manufacturer`,' ',`l`.`model`) AS `LensModel`,concat(`lm`.`manufacturer`,' ',`l`.`model`) AS `Lens`,`l`.`serial` AS `LensSerialNumber`,`c`.`serial` AS `SerialNumber`,concat(`f`.`directory`,'/',`s`.`filename`) AS `path`,`l`.`max_aperture` AS `MaxApertureValue`,`f`.`directory` AS `directory`,`s`.`filename` AS `filename`,`n`.`shutter_speed` AS `ExposureTime`,`n`.`aperture` AS `FNumber`,`n`.`aperture` AS `ApertureValue`,if((`l`.`min_focal_length` = `l`.`max_focal_length`),concat(`l`.`min_focal_length`,'.0 mm'),concat(`n`.`focal_length`,'.0 mm')) AS `FocalLength`,if((`f`.`exposed_at` is not null),`f`.`exposed_at`,`fs`.`iso`) AS `ISO`,`n`.`description` AS `ImageDescription`,date_format(`n`.`date`,'%Y:%m:%d %H:%i:%s') AS `DateTimeOriginal`,if((`n`.`latitude` >= 0),concat('+',format(`n`.`latitude`,6)),format(`n`.`latitude`,6)) AS `GPSLatitude`,if((`n`.`longitude` >= 0),concat('+',format(`n`.`longitude`,6)),format(`n`.`longitude`,6)) AS `GPSLongitude`,if((`ep`.`exposure_program` > 0),`ep`.`exposure_program`,NULL) AS `ExposureProgram`,if((`mm`.`metering_mode` > 0),`mm`.`metering_mode`,NULL) AS `MeteringMode`,(case when isnull(`n`.`flash`) then NULL when (`n`.`flash` = 0) then 'No Flash' when (`n`.`flash` > 0) then 'Fired' end) AS `Flash`,if((`l`.`min_focal_length` = `l`.`max_focal_length`),concat(round((`l`.`min_focal_length` * `NEGATIVE_SIZE`.`crop_factor`),0),' mm'),concat(round((`n`.`focal_length` * `NEGATIVE_SIZE`.`crop_factor`),0),' mm')) AS `FocalLengthIn35mmFormat`,concat('Copyright ',`p`.`name`,' ',year(`n`.`date`)) AS `Copyright`,concat(`n`.`description`,'\nFilm: ',`fsm`.`manufacturer`,' ',`fs`.`name`,ifnull(concat('\n                                Paper: ',`psm`.`manufacturer`,' ',`ps`.`name`),'')) AS `UserComment` from (((((((((((((((`scans_negs` `n` join `FILM` `f` on((`n`.`film_id` = `f`.`film_id`))) join `FILMSTOCK` `fs` on((`f`.`filmstock_id` = `fs`.`filmstock_id`))) join `PERSON` `p` on((`f`.`photographer_id` = `p`.`person_id`))) join `CAMERA` `c` on((`f`.`camera_id` = `c`.`camera_id`))) left join `MANUFACTURER` `cm` on((`c`.`manufacturer_id` = `cm`.`manufacturer_id`))) left join `LENS` `l` on((`n`.`lens_id` = `l`.`lens_id`))) left join `MANUFACTURER` `lm` on((`l`.`manufacturer_id` = `lm`.`manufacturer_id`))) left join `EXPOSURE_PROGRAM` `ep` on((`n`.`exposure_program` = `ep`.`exposure_program_id`))) left join `METERING_MODE` `mm` on((`n`.`metering_mode` = `mm`.`metering_mode_id`))) join `SCAN` `s` on((`n`.`scan_id` = `s`.`scan_id`))) left join `PRINT` on((`s`.`print_id` = `PRINT`.`print_id`))) left join `NEGATIVE_SIZE` on((`c`.`negative_size_id` = `NEGATIVE_SIZE`.`negative_size_id`))) left join `MANUFACTURER` `fsm` on((`fs`.`manufacturer_id` = `fsm`.`manufacturer_id`))) left join `PAPER_STOCK` `ps` on((`PRINT`.`paper_stock_id` = `ps`.`paper_stock_id`))) left join `MANUFACTURER` `psm` on((`ps`.`manufacturer_id` = `psm`.`manufacturer_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `info_accessory`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `info_accessory` AS select `ACCESSORY`.`accessory_id` AS `Accessory ID`,`ACCESSORY_TYPE`.`accessory_type` AS `Accessory type`,if(`ACCESSORY`.`manufacturer_id`,concat(`MANUFACTURER`.`manufacturer`,' ',`ACCESSORY`.`model`),`ACCESSORY`.`model`) AS `Model`,`ACCESSORY`.`acquired` AS `Acquired`,`ACCESSORY`.`cost` AS `Cost`,`ACCESSORY`.`lost` AS `Lost`,`ACCESSORY`.`lost_price` AS `Lost price` from ((`ACCESSORY` left join `MANUFACTURER` on((`ACCESSORY`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`))) join `ACCESSORY_TYPE` on((`ACCESSORY_TYPE`.`accessory_type_id` = `ACCESSORY`.`accessory_type_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `info_archive`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `info_archive` AS select `ARCHIVE`.`archive_id` AS `Archive ID`,`ARCHIVE`.`name` AS `Archive name`,concat(`ARCHIVE`.`max_width`,'x',`ARCHIVE`.`max_height`) AS `Maximum size`,`ARCHIVE`.`location` AS `Location`,`ARCHIVE`.`storage` AS `Storage type`,`printbool`(`ARCHIVE`.`sealed`) AS `Sealed`,`ARCHIVE_TYPE`.`archive_type` AS `Archive type` from (`ARCHIVE` join `ARCHIVE_TYPE` on((`ARCHIVE`.`archive_type_id` = `ARCHIVE_TYPE`.`archive_type_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `info_camera`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `info_camera` AS select `CAMERA`.`camera_id` AS `Camera ID`,concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERA`.`model`) AS `Camera`,`NEGATIVE_SIZE`.`negative_size` AS `Negative size`,`BODY_TYPE`.`body_type` AS `Body type`,`MOUNT`.`mount` AS `Mount`,`FORMAT`.`format` AS `Film format`,`FOCUS_TYPE`.`focus_type` AS `Focus type`,`printbool`(`CAMERA`.`metering`) AS `Metering`,`CAMERA`.`coupled_metering` AS `Coupled metering`,`METERING_TYPE`.`metering` AS `Metering type`,concat(`CAMERA`.`weight`,'g') AS `Weight`,`CAMERA`.`acquired` AS `Date acquired`,concat('£',`CAMERA`.`cost`) AS `Cost`,concat(`CAMERA`.`introduced`,'-',ifnull(`CAMERA`.`discontinued`,'?')) AS `Manufactured between`,`CAMERA`.`serial` AS `Serial number`,`CAMERA`.`datecode` AS `Datecode`,`CAMERA`.`manufactured` AS `Year of manufacture`,`SHUTTER_TYPE`.`shutter_type` AS `Shutter type`,`CAMERA`.`shutter_model` AS `Shutter model`,`PRINTBOOL`(`CAMERA`.`cable_release`) AS `Cable release`,concat(`CAMERA`.`viewfinder_coverage`,'%') AS `Viewfinder coverage`,`PRINTBOOL`(`CAMERA`.`power_drive`) AS `Power drive`,`CAMERA`.`continuous_fps` AS `continuous_fps`,`PRINTBOOL`(`CAMERA`.`video`) AS `Video`,`PRINTBOOL`(`CAMERA`.`digital`) AS `Digital`,`PRINTBOOL`(`CAMERA`.`fixed_mount`) AS `Fixed mount`,`LENS`.`model` AS `Lens`,concat(`CAMERA`.`battery_qty`,' x ',`BATTERY`.`battery_name`) AS `Battery`,`CAMERA`.`notes` AS `Notes`,`CAMERA`.`lost` AS `Lost`,`CAMERA`.`lost_price` AS `Lost price`,`CAMERA`.`source` AS `Source`,`CAMERA`.`bulb` AS `Bulb`,`CAMERA`.`time` AS `Time`,concat(`CAMERA`.`min_iso`,'-',`CAMERA`.`max_iso`) AS `ISO range`,`CAMERA`.`af_points` AS `Autofocus points`,`PRINTBOOL`(`CAMERA`.`int_flash`) AS `Internal flash`,`CAMERA`.`int_flash_gn` AS `Internal flash guide number`,`PRINTBOOL`(`CAMERA`.`ext_flash`) AS `External flash`,`CAMERA`.`flash_metering` AS `Flash metering`,`PRINTBOOL`(`CAMERA`.`pc_sync`) AS `PC sync socket`,`PRINTBOOL`(`CAMERA`.`hotshoe`) AS `Hotshoe`,`PRINTBOOL`(`CAMERA`.`coldshoe`) AS `Coldshoe`,`CAMERA`.`x_sync` AS `X-sync speed`,concat(`CAMERA`.`meter_min_ev`,'-',`CAMERA`.`meter_max_ev`) AS `Meter range`,`CONDITION`.`name` AS `Condition`,`PRINTBOOL`(`CAMERA`.`dof_preview`) AS `Depth of field preview`,group_concat(distinct `EXPOSURE_PROGRAM`.`exposure_program` separator ', ') AS `Exposure programs`,group_concat(distinct `METERING_MODE`.`metering_mode` separator ', ') AS `Metering modes`,group_concat(distinct `SHUTTER_SPEED_AVAILABLE`.`shutter_speed` separator ', ') AS `Shutter speeds`,if(`LENS`.`zoom`,concat(`LENS`.`min_focal_length`,'-',`LENS`.`max_focal_length`,'mm'),concat(`LENS`.`min_focal_length`,'mm')) AS `Focal length`,concat('f/',`LENS`.`max_aperture`) AS `Maximum aperture`,count(distinct `FILM`.`film_id`) AS `Films loaded`,count(distinct `NEGATIVE`.`negative_id`) AS `Frames shot` from ((((((((((((((((((`CAMERA` left join `MANUFACTURER` on((`CAMERA`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`))) left join `NEGATIVE_SIZE` on((`CAMERA`.`negative_size_id` = `NEGATIVE_SIZE`.`negative_size_id`))) left join `BODY_TYPE` on((`CAMERA`.`body_type_id` = `BODY_TYPE`.`body_type_id`))) left join `BATTERY` on((`CAMERA`.`battery_type` = `BATTERY`.`battery_type`))) left join `METERING_TYPE` on((`CAMERA`.`metering_type_id` = `METERING_TYPE`.`metering_type_id`))) left join `SHUTTER_TYPE` on((`CAMERA`.`shutter_type_id` = `SHUTTER_TYPE`.`shutter_type_id`))) left join `CONDITION` on((`CAMERA`.`condition_id` = `CONDITION`.`condition_id`))) left join `FOCUS_TYPE` on((`CAMERA`.`focus_type_id` = `FOCUS_TYPE`.`focus_type_id`))) left join `EXPOSURE_PROGRAM_AVAILABLE` on((`CAMERA`.`camera_id` = `EXPOSURE_PROGRAM_AVAILABLE`.`camera_id`))) left join `EXPOSURE_PROGRAM` on((`EXPOSURE_PROGRAM_AVAILABLE`.`exposure_program_id` = `EXPOSURE_PROGRAM`.`exposure_program_id`))) left join `METERING_MODE_AVAILABLE` on((`CAMERA`.`camera_id` = `METERING_MODE_AVAILABLE`.`camera_id`))) left join `METERING_MODE` on((`METERING_MODE_AVAILABLE`.`metering_mode_id` = `METERING_MODE`.`metering_mode_id`))) left join `SHUTTER_SPEED_AVAILABLE` on((`CAMERA`.`camera_id` = `SHUTTER_SPEED_AVAILABLE`.`camera_id`))) left join `FORMAT` on((`CAMERA`.`format_id` = `FORMAT`.`format_id`))) left join `MOUNT` on((`CAMERA`.`mount_id` = `MOUNT`.`mount_id`))) left join `LENS` on((`CAMERA`.`lens_id` = `LENS`.`lens_id`))) left join `FILM` on((`CAMERA`.`camera_id` = `FILM`.`camera_id`))) left join `NEGATIVE` on((`FILM`.`film_id` = `NEGATIVE`.`film_id`))) where (`CAMERA`.`own` = 1) group by `CAMERA`.`camera_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `info_enlarger`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `info_enlarger` AS select `ENLARGER`.`enlarger_id` AS `Enlarger ID`,`MANUFACTURER`.`manufacturer` AS `Manufacturer`,`ENLARGER`.`enlarger` AS `Model`,`NEGATIVE_SIZE`.`negative_size` AS `Negative size`,`ENLARGER`.`acquired` AS `Acquired`,`ENLARGER`.`lost` AS `Lost`,`ENLARGER`.`introduced` AS `Introduced`,`ENLARGER`.`discontinued` AS `Discontinued`,`ENLARGER`.`cost` AS `Cost`,`ENLARGER`.`lost_price` AS `Lost price` from ((`ENLARGER` left join `NEGATIVE_SIZE` on((`ENLARGER`.`negative_size_id` = `NEGATIVE_SIZE`.`negative_size_id`))) left join `MANUFACTURER` on((`ENLARGER`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `info_film`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `info_film` AS select `FILM`.`film_id` AS `Film ID`,concat('Box speed ',`FILMSTOCK`.`iso`,' exposed at EI ',`FILM`.`exposed_at`,if(`FILM`.`dev_n`,concat(' (',if(sign(`FILM`.`dev_n`),concat('N+',`FILM`.`dev_n`),concat('N-',`FILM`.`dev_n`)),')'),'')) AS `ISO`,`FILM`.`date` AS `Date`,`FILM`.`notes` AS `Title`,`FILM`.`frames` AS `Frames`,`FILM`.`dev_time` AS `dev_time`,`FILM`.`dev_temp` AS `dev_temp`,`FILM`.`development_notes` AS `Development notes`,`FILM`.`processed_by` AS `Processed by`,concat(`fm`.`manufacturer`,' ',`FILMSTOCK`.`name`) AS `Filmstock`,concat(`cm`.`manufacturer`,' ',`c`.`model`) AS `Camera`,concat(`dm`.`manufacturer`,' ',`DEVELOPER`.`name`) AS `Developer`,`ARCHIVE`.`name` AS `Archive` from (((((`FILM` left join (`FILMSTOCK` left join `MANUFACTURER` `fm` on((`FILMSTOCK`.`manufacturer_id` = `fm`.`manufacturer_id`))) on((`FILM`.`filmstock_id` = `FILMSTOCK`.`filmstock_id`))) left join `FORMAT` on((`FILM`.`format_id` = `FORMAT`.`format_id`))) left join (`CAMERA` `c` left join `MANUFACTURER` `cm` on((`c`.`manufacturer_id` = `cm`.`manufacturer_id`))) on((`FILM`.`camera_id` = `c`.`camera_id`))) left join (`DEVELOPER` left join `MANUFACTURER` `dm` on((`DEVELOPER`.`manufacturer_id` = `dm`.`manufacturer_id`))) on((`FILM`.`developer_id` = `DEVELOPER`.`developer_id`))) left join `ARCHIVE` on((`FILM`.`archive_id` = `ARCHIVE`.`archive_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `info_lens`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `info_lens` AS select `LENS`.`lens_id` AS `Lens ID`,`MOUNT`.`mount` AS `Mount`,if(`LENS`.`zoom`,concat(`LENS`.`min_focal_length`,'-',`LENS`.`max_focal_length`,'mm'),concat(`LENS`.`min_focal_length`,'mm')) AS `Focal length`,concat(`MANUFACTURER`.`manufacturer`,' ',`LENS`.`model`) AS `Lens`,concat(`LENS`.`closest_focus`,'cm') AS `Closest focus`,concat('f/',`LENS`.`max_aperture`) AS `Maximum aperture`,concat('f/',`LENS`.`min_aperture`) AS `Minimum aperture`,concat(`LENS`.`elements`,'/',`LENS`.`groups`) AS `Elements/Groups`,concat(`LENS`.`weight`,'g') AS `Weight`,if(`LENS`.`zoom`,concat(`LENS`.`nominal_max_angle_diag`,'°-',`LENS`.`nominal_min_angle_diag`,'°'),concat(`LENS`.`nominal_max_angle_diag`,'°')) AS `Angle of view`,`LENS`.`aperture_blades` AS `Aperture blades`,`printbool`(`LENS`.`autofocus`) AS `Autofocus`,concat(`LENS`.`filter_thread`,'mm') AS `Filter thread`,concat(`LENS`.`magnification`,'×') AS `Maximum magnification`,`LENS`.`url` AS `URL`,`LENS`.`serial` AS `Serial number`,`LENS`.`date_code` AS `Date code`,concat(ifnull(`LENS`.`introduced`,'?'),'-',ifnull(`LENS`.`discontinued`,'?')) AS `Manufactured between`,`LENS`.`manufactured` AS `Year of manufacture`,`NEGATIVE_SIZE`.`negative_size` AS `Negative size`,`LENS`.`acquired` AS `Date acquired`,concat('£',`LENS`.`cost`) AS `Cost`,`LENS`.`notes` AS `Notes`,`LENS`.`lost` AS `Date lost`,concat('£',`LENS`.`lost_price`) AS `Price sold`,`LENS`.`source` AS `Source`,`LENS`.`coating` AS `Coating`,`LENS`.`hood` AS `Hood`,`LENS`.`exif_lenstype` AS `EXIF LensType`,`printbool`(`LENS`.`rectilinear`) AS `Rectilinear`,concat(`LENS`.`length`,'×',`LENS`.`diameter`,'mm') AS `Dimensions (l×w)`,`CONDITION`.`name` AS `Condition`,concat(`LENS`.`image_circle`,'mm') AS `Image circle`,`LENS`.`formula` AS `Optical formula`,`LENS`.`shutter_model` AS `Shutter model`,count(`NEGATIVE`.`negative_id`) AS `Frames shot` from (((((`LENS` left join `MOUNT` on((`LENS`.`mount_id` = `MOUNT`.`mount_id`))) left join `MANUFACTURER` on((`LENS`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`))) left join `CONDITION` on((`LENS`.`condition_id` = `CONDITION`.`condition_id`))) left join `NEGATIVE_SIZE` on((`LENS`.`negative_size_id` = `NEGATIVE_SIZE`.`negative_size_id`))) left join `NEGATIVE` on((`NEGATIVE`.`lens_id` = `LENS`.`lens_id`))) where ((`LENS`.`own` = 1) and (`LENS`.`fixed_mount` = 0)) group by `LENS`.`lens_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `info_movie`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `info_movie` AS select `MOVIE`.`movie_id` AS `Movie ID`,`MOVIE`.`title` AS `Title`,concat(`CM`.`manufacturer`,' ',`CAMERA`.`model`) AS `Camera`,concat(`LM`.`manufacturer`,' ',`LENS`.`model`) AS `Lens`,`FORMAT`.`format` AS `Format`,`printbool`(`MOVIE`.`sound`) AS `Sound`,`MOVIE`.`fps` AS `Frame rate`,concat(`FM`.`manufacturer`,' ',`FILMSTOCK`.`name`) AS `Filmstock`,`MOVIE`.`feet` AS `Length (feet)`,`MOVIE`.`date_loaded` AS `Date loaded`,`MOVIE`.`date_shot` AS `Date shot`,`MOVIE`.`date_processed` AS `Date processed`,`PROCESS`.`name` AS `Process`,`MOVIE`.`description` AS `Description` from ((((((((`MOVIE` left join `CAMERA` on((`MOVIE`.`camera_id` = `CAMERA`.`camera_id`))) left join `FILMSTOCK` on((`MOVIE`.`filmstock_id` = `FILMSTOCK`.`filmstock_id`))) left join `LENS` on((`MOVIE`.`lens_id` = `LENS`.`lens_id`))) left join `MANUFACTURER` `CM` on((`CM`.`manufacturer_id` = `CAMERA`.`manufacturer_id`))) left join `MANUFACTURER` `FM` on((`FM`.`manufacturer_id` = `FILMSTOCK`.`manufacturer_id`))) left join `MANUFACTURER` `LM` on((`LM`.`manufacturer_id` = `LENS`.`manufacturer_id`))) left join `FORMAT` on((`MOVIE`.`format_id` = `FORMAT`.`format_id`))) left join `PROCESS` on((`MOVIE`.`process_id` = `PROCESS`.`process_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `info_negative`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `info_negative` AS select `n`.`negative_id` AS `Negative ID`,`n`.`film_id` AS `Film ID`,`n`.`frame` AS `Frame`,`mm`.`metering_mode` AS `Metering mode`,date_format(`n`.`date`,'%Y-%m-%d %H:%i:%s') AS `Date`,concat(`n`.`latitude`,', ',`n`.`longitude`) AS `Location`,`s`.`filename` AS `Filename`,`n`.`shutter_speed` AS `Shutter speed`,concat(`lm`.`manufacturer`,' ',`l`.`model`) AS `Lens`,`p`.`name` AS `Photographer`,concat('f/',`n`.`aperture`) AS `Aperture`,`n`.`description` AS `Caption`,if((`l`.`min_focal_length` = `l`.`max_focal_length`),concat(`l`.`min_focal_length`,'mm'),concat(`n`.`focal_length`,'mm')) AS `Focal length`,`ep`.`exposure_program` AS `Exposure program`,count(`PRINT`.`print_id`) AS `Prints made`,concat(`cm`.`manufacturer`,' ',`c`.`model`) AS `Camera`,concat(`fsm`.`manufacturer`,' ',`fs`.`name`) AS `Filmstock` from ((((((((((((`NEGATIVE` `n` join `FILM` `f` on((`n`.`film_id` = `f`.`film_id`))) join `FILMSTOCK` `fs` on((`f`.`filmstock_id` = `fs`.`filmstock_id`))) join `CAMERA` `c` on((`f`.`camera_id` = `c`.`camera_id`))) join `MANUFACTURER` `cm` on((`c`.`manufacturer_id` = `cm`.`manufacturer_id`))) left join `PERSON` `p` on((`n`.`photographer_id` = `p`.`person_id`))) left join `MANUFACTURER` `fsm` on((`fs`.`manufacturer_id` = `fsm`.`manufacturer_id`))) left join `LENS` `l` on((`n`.`lens_id` = `l`.`lens_id`))) left join `MANUFACTURER` `lm` on((`l`.`manufacturer_id` = `lm`.`manufacturer_id`))) left join `EXPOSURE_PROGRAM` `ep` on((`n`.`exposure_program` = `ep`.`exposure_program_id`))) left join `METERING_MODE` `mm` on((`n`.`metering_mode` = `mm`.`metering_mode_id`))) left join `PRINT` on((`n`.`negative_id` = `PRINT`.`negative_id`))) left join `SCAN` `s` on((`n`.`negative_id` = `s`.`negative_id`))) where (`s`.`filename` is not null) group by `n`.`negative_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `info_print`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `info_print` AS select concat(`NEGATIVE`.`film_id`,'/',`NEGATIVE`.`frame`) AS `Negative`,`NEGATIVE`.`negative_id` AS `Negative ID`,`PRINT`.`print_id` AS `Print`,`NEGATIVE`.`description` AS `Description`,`DISPLAYSIZE`(`PRINT`.`width`,`PRINT`.`height`) AS `Size`,concat(`PRINT`.`exposure_time`,'s') AS `Exposure time`,concat('f/',`PRINT`.`aperture`) AS `Aperture`,`PRINT`.`filtration_grade` AS `Filtration grade`,concat(`PAPER_STOCK_MANUFACTURER`.`manufacturer`,' ',`PAPER_STOCK`.`name`) AS `Paper`,concat(`ENLARGER_MANUFACTURER`.`manufacturer`,' ',`ENLARGER`.`enlarger`) AS `Enlarger`,concat(`LENS_MANUFACTURER`.`manufacturer`,' ',`LENS`.`model`) AS `Enlarger lens`,concat(`FIRSTTONER_MANUFACTURER`.`manufacturer`,' ',`FIRSTTONER`.`toner`,if((`PRINT`.`toner_dilution` is not null),concat(' (',`PRINT`.`toner_dilution`,')'),''),if((`PRINT`.`toner_time` is not null),concat(' for ',`PRINT`.`toner_time`),'')) AS `First toner`,concat(`SECONDTONER_MANUFACTURER`.`manufacturer`,' ',`SECONDTONER`.`toner`,if((`PRINT`.`2nd_toner_dilution` is not null),concat(' (',`PRINT`.`2nd_toner_dilution`,')'),''),if((`PRINT`.`2nd_toner_time` is not null),concat(' for ',`PRINT`.`2nd_toner_time`),'')) AS `Second toner`,date_format(`PRINT`.`date`,'%M %Y') AS `Print date`,date_format(`NEGATIVE`.`date`,'%M %Y') AS `Photo date`,`PERSON`.`name` AS `Photographer`,(case `PRINT`.`own` when 1 then ifnull(`ARCHIVE`.`name`,'Owned; location unknown') when 0 then ifnull(`PRINT`.`location`,'Not owned; location unknown') else 'No location information' end) AS `Location` from (((((((((((((`PRINT` join `PAPER_STOCK` on((`PRINT`.`paper_stock_id` = `PAPER_STOCK`.`paper_stock_id`))) join `MANUFACTURER` `PAPER_STOCK_MANUFACTURER` on((`PAPER_STOCK`.`manufacturer_id` = `PAPER_STOCK_MANUFACTURER`.`manufacturer_id`))) left join `ENLARGER` on((`PRINT`.`enlarger_id` = `ENLARGER`.`enlarger_id`))) join `MANUFACTURER` `ENLARGER_MANUFACTURER` on((`ENLARGER`.`manufacturer_id` = `ENLARGER_MANUFACTURER`.`manufacturer_id`))) left join `LENS` on((`PRINT`.`lens_id` = `LENS`.`lens_id`))) join `MANUFACTURER` `LENS_MANUFACTURER` on((`LENS`.`manufacturer_id` = `LENS_MANUFACTURER`.`manufacturer_id`))) left join `TONER` `FIRSTTONER` on((`PRINT`.`toner_id` = `FIRSTTONER`.`toner_id`))) left join `MANUFACTURER` `FIRSTTONER_MANUFACTURER` on((`FIRSTTONER`.`manufacturer_id` = `FIRSTTONER_MANUFACTURER`.`manufacturer_id`))) left join `TONER` `SECONDTONER` on((`PRINT`.`2nd_toner_id` = `SECONDTONER`.`toner_id`))) left join `MANUFACTURER` `SECONDTONER_MANUFACTURER` on((`SECONDTONER`.`manufacturer_id` = `SECONDTONER_MANUFACTURER`.`manufacturer_id`))) left join `NEGATIVE` on((`PRINT`.`negative_id` = `NEGATIVE`.`negative_id`))) left join `PERSON` on((`NEGATIVE`.`photographer_id` = `PERSON`.`person_id`))) left join `ARCHIVE` on((`PRINT`.`archive_id` = `ARCHIVE`.`archive_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `report_cameras_by_decade`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `report_cameras_by_decade` AS select (floor((`CAMERA`.`introduced` / 10)) * 10) AS `Decade`,count(`CAMERA`.`camera_id`) AS `Cameras` from `CAMERA` where (`CAMERA`.`introduced` is not null) group by (floor((`CAMERA`.`introduced` / 10)) * 10) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `report_most_popular_lenses_relative`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `report_most_popular_lenses_relative` AS select concat(`MANUFACTURER`.`manufacturer`,' ',`LENS`.`model`) AS `Lens`,(to_days(curdate()) - to_days(`LENS`.`acquired`)) AS `Days owned`,count(`NEGATIVE`.`negative_id`) AS `Frames shot`,(count(`NEGATIVE`.`negative_id`) / (to_days(curdate()) - to_days(`LENS`.`acquired`))) AS `Frames shot per day` from (((`LENS` join `MANUFACTURER` on((`LENS`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`))) join `NEGATIVE` on((`NEGATIVE`.`lens_id` = `LENS`.`lens_id`))) join `MOUNT` on((`LENS`.`mount_id` = `MOUNT`.`mount_id`))) where ((`LENS`.`acquired` is not null) and (`MOUNT`.`fixed` = 0)) group by `LENS`.`lens_id` order by (count(`NEGATIVE`.`negative_id`) / (to_days(curdate()) - to_days(`LENS`.`acquired`))) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `report_never_used_cameras`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `report_never_used_cameras` AS select concat('#',`CAMERA`.`camera_id`,' ',`MANUFACTURER`.`manufacturer`,' ',`CAMERA`.`model`) AS `Camera` from ((`CAMERA` left join `FILM` on((`CAMERA`.`camera_id` = `FILM`.`camera_id`))) left join `MANUFACTURER` on((`CAMERA`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`))) where (isnull(`FILM`.`camera_id`) and (`CAMERA`.`own` <> 0) and (`CAMERA`.`digital` = 0) and (`CAMERA`.`video` = 0)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `report_never_used_lenses`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `report_never_used_lenses` AS select concat('#',`LENS`.`lens_id`,' ',`MANUFACTURER`.`manufacturer`,' ',`LENS`.`model`) AS `Lens` from (((`LENS` join `MANUFACTURER` on((`LENS`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`))) join `MOUNT` on((`LENS`.`mount_id` = `MOUNT`.`mount_id`))) left join `NEGATIVE` on((`NEGATIVE`.`lens_id` = `LENS`.`lens_id`))) where ((`LENS`.`fixed_mount` = 0) and (`MOUNT`.`purpose` = 'Camera') and (`MOUNT`.`digital_only` = 0) and (`LENS`.`own` = 1) and isnull(`NEGATIVE`.`negative_id`)) order by `LENS`.`lens_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `report_total_negatives_per_camera`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `report_total_negatives_per_camera` AS select concat(`MANUFACTURER`.`manufacturer`,' ',`CAMERA`.`model`) AS `Camera`,count(`NEGATIVE`.`negative_id`) AS `Frames shot` from (((`CAMERA` join `FILM` on((`CAMERA`.`camera_id` = `FILM`.`camera_id`))) join `NEGATIVE` on((`FILM`.`film_id` = `NEGATIVE`.`film_id`))) join `MANUFACTURER` on((`CAMERA`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`))) group by `CAMERA`.`camera_id` order by count(`NEGATIVE`.`negative_id`) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `report_total_negatives_per_lens`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `report_total_negatives_per_lens` AS select concat(`MANUFACTURER`.`manufacturer`,' ',`LENS`.`model`) AS `Lens`,count(`NEGATIVE`.`negative_id`) AS `Frames shot` from (((`LENS` join `NEGATIVE` on((`LENS`.`lens_id` = `NEGATIVE`.`lens_id`))) join `MANUFACTURER` on((`LENS`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`))) join `MOUNT` on((`LENS`.`mount_id` = `MOUNT`.`mount_id`))) where ((`LENS`.`fixed_mount` = 0) and (`MOUNT`.`purpose` = 'Camera')) group by `LENS`.`lens_id` order by count(`NEGATIVE`.`negative_id`) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `report_unscanned_negs`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `report_unscanned_negs` AS select `NEGATIVE`.`negative_id` AS `negative_id`,`NEGATIVE`.`film_id` AS `film_id`,`NEGATIVE`.`frame` AS `frame`,`NEGATIVE`.`description` AS `description` from ((`NEGATIVE` left join `SCAN` on((`NEGATIVE`.`negative_id` = `SCAN`.`negative_id`))) left join `FILM` on((`NEGATIVE`.`film_id` = `FILM`.`film_id`))) where (isnull(`SCAN`.`negative_id`) and (`FILM`.`date` is not null)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `scans_negs`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `scans_negs` AS select `SCAN`.`scan_id` AS `scan_id`,`FILM`.`directory` AS `directory`,`SCAN`.`filename` AS `filename`,`NEGATIVE`.`negative_id` AS `negative_id`,`NEGATIVE`.`film_id` AS `film_id`,`NEGATIVE`.`frame` AS `frame`,`NEGATIVE`.`description` AS `description`,`NEGATIVE`.`date` AS `date`,`NEGATIVE`.`lens_id` AS `lens_id`,`NEGATIVE`.`shutter_speed` AS `shutter_speed`,`NEGATIVE`.`aperture` AS `aperture`,`NEGATIVE`.`filter_id` AS `filter_id`,`NEGATIVE`.`teleconverter_id` AS `teleconverter_id`,`NEGATIVE`.`notes` AS `notes`,`NEGATIVE`.`mount_adapter_id` AS `mount_adapter_id`,`NEGATIVE`.`focal_length` AS `focal_length`,`NEGATIVE`.`latitude` AS `latitude`,`NEGATIVE`.`longitude` AS `longitude`,`NEGATIVE`.`flash` AS `flash`,`NEGATIVE`.`metering_mode` AS `metering_mode`,`NEGATIVE`.`exposure_program` AS `exposure_program`,`NEGATIVE`.`photographer_id` AS `photographer_id`,`NEGATIVE`.`copy_of` AS `copy_of` from (((`SCAN` join `PRINT` on((`SCAN`.`print_id` = `PRINT`.`print_id`))) join `NEGATIVE` on((`PRINT`.`negative_id` = `NEGATIVE`.`negative_id`))) join `FILM` on((`NEGATIVE`.`film_id` = `FILM`.`film_id`))) union all select `SCAN`.`scan_id` AS `scan_id`,`FILM`.`directory` AS `directory`,`SCAN`.`filename` AS `filename`,`NEGATIVE`.`negative_id` AS `negative_id`,`NEGATIVE`.`film_id` AS `film_id`,`NEGATIVE`.`frame` AS `frame`,`NEGATIVE`.`description` AS `description`,`NEGATIVE`.`date` AS `date`,`NEGATIVE`.`lens_id` AS `lens_id`,`NEGATIVE`.`shutter_speed` AS `shutter_speed`,`NEGATIVE`.`aperture` AS `aperture`,`NEGATIVE`.`filter_id` AS `filter_id`,`NEGATIVE`.`teleconverter_id` AS `teleconverter_id`,`NEGATIVE`.`notes` AS `notes`,`NEGATIVE`.`mount_adapter_id` AS `mount_adapter_id`,`NEGATIVE`.`focal_length` AS `focal_length`,`NEGATIVE`.`latitude` AS `latitude`,`NEGATIVE`.`longitude` AS `longitude`,`NEGATIVE`.`flash` AS `flash`,`NEGATIVE`.`metering_mode` AS `metering_mode`,`NEGATIVE`.`exposure_program` AS `exposure_program`,`NEGATIVE`.`photographer_id` AS `photographer_id`,`NEGATIVE`.`copy_of` AS `copy_of` from ((`SCAN` join `NEGATIVE` on((`SCAN`.`negative_id` = `NEGATIVE`.`negative_id`))) join `FILM` on((`NEGATIVE`.`film_id` = `FILM`.`film_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `view_film_stocks`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jonathan`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_film_stocks` AS select concat(`MANUFACTURER`.`manufacturer`,' ',`FILMSTOCK`.`name`,' (',`FORMAT`.`format`,')') AS `film`,count(`FILMSTOCK`.`filmstock_id`) AS `qty` from (((`FILM` join `FILMSTOCK`) join `FORMAT`) join `MANUFACTURER`) where (isnull(`FILM`.`camera_id`) and isnull(`FILM`.`date`) and (`FILM`.`filmstock_id` = `FILMSTOCK`.`filmstock_id`) and (`FILM`.`format_id` = `FORMAT`.`format_id`) and (`FILMSTOCK`.`manufacturer_id` = `MANUFACTURER`.`manufacturer_id`)) group by concat(`MANUFACTURER`.`manufacturer`,' ',`FILMSTOCK`.`name`,' (',`FORMAT`.`format`,')') order by concat(`MANUFACTURER`.`manufacturer`,' ',`FILMSTOCK`.`name`,' (',`FORMAT`.`format`,')') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
