ALTER TABLE `vicidial_inbound_groups` ADD `pickup_delay` TINYINT NOT NULL DEFAULT '0' AFTER `icbq_dial_filter`;

UPDATE system_settings SET db_schema_version='1531',db_schema_update_date=NOW() where db_schema_version < 1531;
