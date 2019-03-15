ALTER TABLE `vicidial_agent_log` ADD INDEX `uniqueid` (`uniqueid`);
ALTER TABLE `WallBoardData` ADD INDEX `uniqueid` (`uniqueid`);
ALTER TABLE `WallBoardData_archive` ADD INDEX `uniqueid` (`uniqueid`);

UPDATE system_settings SET db_schema_version='1525',db_schema_update_date=NOW() where db_schema_version < 1525;

