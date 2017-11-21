ALTER TABLE `vicidial_list` CHANGE `alt_phone` `alt_phone` VARCHAR(18) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `WallBoardStat` ADD `maxwaittime` BIGINT(20) NOT NULL DEFAULT '0', ADD `Tmaxwaittime` BIGINT(20) NOT NULL DEFAULT '0';

UPDATE system_settings SET db_schema_version='1527',db_schema_update_date=NOW() where db_schema_version < 1527;
