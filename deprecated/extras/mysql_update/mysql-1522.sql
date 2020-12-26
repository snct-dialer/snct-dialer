ALTER TABLE phones ADD webphone_layout VARCHAR(255) default '';
ALTER TABLE vicidial_user_groups ADD webphone_layout VARCHAR(255) default '';

UPDATE system_settings SET db_schema_version='1522',db_schema_update_date=NOW() where db_schema_version < 1522;
