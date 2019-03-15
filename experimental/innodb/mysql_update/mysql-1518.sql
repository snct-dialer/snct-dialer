ALTER TABLE system_settings ADD expired_lists_inactive ENUM('0','1') default '0';

UPDATE system_settings SET db_schema_version='1518',db_schema_update_date=NOW() where db_schema_version < 1518;
