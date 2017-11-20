ALTER TABLE `vicidial_list` CHANGE `alt_phone` `alt_phone` VARCHAR(18) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;

UPDATE system_settings SET db_schema_version='1527',db_schema_update_date=NOW() where db_schema_version < 1527;
