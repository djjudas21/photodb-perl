CREATE TABLE `photography`.`NEGATIVEFORMAT_COMPAT` (
  `format_id` INT NOT NULL COMMENT 'ID of the film format',
  `negative_size_id` INT NOT NULL COMMENT 'ID of the negative size',
  PRIMARY KEY (`format_id`, `negative_size_id`),
  INDEX `negative_size_id_idx` (`negative_size_id` ASC),
  CONSTRAINT `format_id`
    FOREIGN KEY (`format_id`)
    REFERENCES `photography`.`FORMAT` (`format_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `negative_size_id`
    FOREIGN KEY (`negative_size_id`)
    REFERENCES `photography`.`NEGATIVE_SIZE` (`negative_size_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
COMMENT = 'Table to record compatibility between film formats and negative sizes';
