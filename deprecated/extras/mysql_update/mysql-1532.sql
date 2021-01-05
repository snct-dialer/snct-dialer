

ALTER TABLE `recording_log` ADD INDEX `UserTime` (`user`, `start_time`);
ALTER TABLE `recording_log_archive` ADD INDEX `UserTime` (`user`, `start_time`);

UPDATE system_settings SET db_schema_version='1532',db_schema_update_date=NOW() where db_schema_version < 1532;
