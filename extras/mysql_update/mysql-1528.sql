ALTER TABLE vicidial_campaigns ADD max_inbound_calls_outcome ENUM('DEFAULT','ALLOW_AGENTDIRECT','ALLOW_MI_PAUSE','ALLOW_AGENTDIRECT_AND_MI_PAUSE') default 'DEFAULT';
UPDATE system_settings SET db_schema_version='1528',db_schema_update_date=NOW() where db_schema_version < 1528;
