/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
CREATE FUNCTION `DISPLAYSIZE`(`width` decimal(5,2), `height` decimal(5,2)) RETURNS varchar(10) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci
    DETERMINISTIC
BEGIN
  declare size varchar(10);
  set size = concat(ifnull((trim(width) + 0),'?'),'×',ifnull((trim(height) + 0),'?'), '"');
RETURN size;
END ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
CREATE FUNCTION `lenstype`(n int) RETURNS varchar(32) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci
BEGIN
declare x varchar(32);
if n <= 8 then set x = 'Super telephoto' ;
elseif n > 8 and n <= 25 then set x ='Medium telephoto';
elseif n > 25 and n <= 39 then set x ='Short telephoto';
elseif n > 39 and n <= 62 then set x ='Normal';
elseif n > 62 and n <= 84 then set x ='Wide angle';
elseif n > 84 and n <= 120 then set x ='Super wide angle';
else set x = 'Fisheye';
end if;
RETURN x;
END ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
CREATE FUNCTION `lookupneg`(p_film_id int, p_frame varchar(5)) RETURNS int(11)
    DETERMINISTIC
BEGIN
	declare negid int;
    select negative_id into negid
    from NEGATIVE
    where film_id = p_film_id
		and frame = p_frame collate utf8mb4_general_ci;
RETURN negid;
END ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
CREATE FUNCTION `printbool`(b int) RETURNS varchar(3) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci
    DETERMINISTIC
BEGIN
return if(b, 'Yes', 'No');
END ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
CREATE PROCEDURE `delete_logs`()
BEGIN
DELETE from LOG
WHERE datetime < date_sub(now(), interval 90 day);
END ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
CREATE PROCEDURE `print_unarchive`(IN printId int)
BEGIN
UPDATE PRINT set archive_id = null WHERE print_id = printId;
END ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
CREATE PROCEDURE `set_fixed_lenses`()
BEGIN
UPDATE
    LENS,
    CAMERA
SET
    LENS.own=0,
    LENS.lost=CAMERA.lost
WHERE
    LENS.lens_id=CAMERA.lens_id
        and CAMERA.own=0
        and CAMERA.fixed_mount=1;
END ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
CREATE PROCEDURE `update_copied_negs`()
BEGIN
UPDATE NEGATIVE ORIG
        JOIN
    NEGATIVE COPY ON ORIG.negative_id = COPY.copy_of 
SET 
    COPY.description = ORIG.description,
    COPY.notes = CONCAT('Copied from negative ',
            ORIG.film_id,
            '/',
            ORIG.frame)
WHERE
    COPY.copy_of IS NOT NULL;
END ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
CREATE PROCEDURE `update_dates_of_fixed_lenses`()
BEGIN
UPDATE
    LENS,
    CAMERA
SET
    LENS.acquired=CAMERA.acquired
WHERE
    LENS.lens_id = CAMERA.lens_id
        and CAMERA.fixed_mount = 1
        and CAMERA.acquired is not null
        and LENS.acquired!=CAMERA.acquired;
END ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
CREATE PROCEDURE `update_exposure_programs`()
BEGIN
UPDATE
    NEGATIVE,
    FILM,
    CAMERA,
    EXPOSURE_PROGRAM_AVAILABLE,
    (SELECT
        CAMERA.camera_id
    FROM
        CAMERA, EXPOSURE_PROGRAM_AVAILABLE
    where
        CAMERA.camera_id = EXPOSURE_PROGRAM_AVAILABLE.camera_id
    group by camera_id
    having count(exposure_program_id) = 1
    ) as VALIDCAMERA
    set
        NEGATIVE.exposure_program = EXPOSURE_PROGRAM_AVAILABLE.exposure_program_id
    where
        CAMERA.camera_id = EXPOSURE_PROGRAM_AVAILABLE.camera_id
            and EXPOSURE_PROGRAM_AVAILABLE.exposure_program_id <> 0
            and NEGATIVE.film_id=FILM.film_id
            and FILM.camera_id=CAMERA.camera_id
            and CAMERA.camera_id = VALIDCAMERA.camera_id
            and NEGATIVE.exposure_program is null;
END ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
CREATE PROCEDURE `update_focal_length`()
BEGIN
UPDATE
    NEGATIVE left join TELECONVERTER on (NEGATIVE.teleconverter_id=TELECONVERTER.teleconverter_id),
    LENS
SET
    NEGATIVE.focal_length=round(LENS.min_focal_length * coalesce(TELECONVERTER.factor,1))
WHERE
   NEGATIVE.lens_id=LENS.lens_id
   and LENS.zoom = 0
   and LENS.min_focal_length is not null
   and NEGATIVE.focal_length is null;
END ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
CREATE PROCEDURE `update_lens_id_fixed_camera`()
BEGIN
UPDATE NEGATIVE,
    LENS,
    CAMERA,
    FILM 
SET 
    NEGATIVE.lens_id = LENS.lens_id
WHERE
    NEGATIVE.film_id = FILM.film_id
        AND FILM.camera_id = CAMERA.camera_id
        AND CAMERA.fixed_mount = 1
        AND CAMERA.lens_id = LENS.lens_id;
END ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
CREATE PROCEDURE `update_metering_modes`()
BEGIN
UPDATE
    NEGATIVE,
    FILM,
    CAMERA,
    METERING_MODE_AVAILABLE,
    (SELECT
        CAMERA.camera_id
    FROM
        CAMERA, METERING_MODE_AVAILABLE
    where
        CAMERA.camera_id = METERING_MODE_AVAILABLE.camera_id
    group by camera_id
    having count(METERING_MODE_AVAILABLE.metering_mode_id) = 1
    ) as VALIDCAMERA
SET
    NEGATIVE.metering_mode = METERING_MODE_AVAILABLE.metering_mode_id
WHERE
    CAMERA.camera_id = METERING_MODE_AVAILABLE.camera_id
        and METERING_MODE_AVAILABLE.metering_mode_id <> 0
        and NEGATIVE.film_id=FILM.film_id
        and FILM.camera_id=CAMERA.camera_id
        and CAMERA.camera_id = VALIDCAMERA.camera_id
        and NEGATIVE.metering_mode is null;
END ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
CREATE PROCEDURE `update_negative_flash`()
BEGIN
UPDATE
    CAMERA
    join FILM on FILM.camera_id=CAMERA.camera_id
    join NEGATIVE on NEGATIVE.film_id = FILM.film_id
SET
    NEGATIVE.flash = 0
WHERE
    int_flash=0
    and ext_flash=0
    and NEGATIVE.flash is null;
END ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
CREATE PROCEDURE `update_negative_sizes`()
BEGIN
UPDATE
    NEGATIVE_SIZE
SET
    crop_factor = round(sqrt(24*24 + 36*36)/sqrt(width*width + height*height),2),
    area = width*height,
    aspect_ratio = round(width/height, 2)
WHERE
    width is not null
        and height is not null;
END ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
