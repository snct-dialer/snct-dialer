ALTER TABLE vicidial_lists ADD inbound_list_script_override VARCHAR(20);

UPDATE system_settings SET db_schema_version='1521',db_schema_update_date=NOW() where db_schema_version < 1521;
