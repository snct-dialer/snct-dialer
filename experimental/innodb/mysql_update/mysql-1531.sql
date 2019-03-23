ALTER TABLE `vicidial_inbound_groups` ADD `pickup_delay` TINYINT NOT NULL DEFAULT '0' AFTER `icbq_dial_filter`;
ALTER TABLE `system_settings` ADD `agent_prefix` VARCHAR(3) default ''; 

UPDATE system_settings SET db_schema_version='1531',db_schema_update_date=NOW() where db_schema_version < 1531;
