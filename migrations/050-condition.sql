ALTER TABLE `LENS` 
ADD COLUMN `condition` TEXT NULL COMMENT 'Description of condition' AFTER `condition_id`;

ALTER TABLE `CAMERA`
ADD COLUMN `condition` TEXT NULL COMMENT 'Description of condition' AFTER `condition_id`;
