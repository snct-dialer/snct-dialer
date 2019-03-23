ALTER TABLE vicidial_agent_log_archive ADD pause_campaign VARCHAR(20) default '';
ALTER TABLE vicidial_agent_log_archive ADD pause_code VARCHAR(6) default '';


UPDATE system_settings SET db_schema_version='1517',db_schema_update_date=NOW() where db_schema_version < 1517;
