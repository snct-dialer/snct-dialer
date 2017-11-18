
ALTER TABLE system_settings ADD servicelevel_direct SMALLINT UNSIGNED DEFAULT '4';
ALTER TABLE system_settings ADD servicelevel_one SMALLINT UNSIGNED DEFAULT '20';
ALTER TABLE system_settings ADD servicelevel_two SMALLINT UNSIGNED DEFAULT '40';

UPDATE system_settings SET db_schema_version='1526',db_schema_update_date=NOW() where db_schema_version < 1526;
