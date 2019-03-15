
ALTER TABLE system_settings ADD allow_phonebook ENUM('0','1') default '0';
UPDATE system_settings SET db_schema_version='1524',db_schema_update_date=NOW() where db_schema_version < 1524;
