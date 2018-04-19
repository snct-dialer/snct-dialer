ALTER TABLE `system_settings` ADD `autoanswer_enable` ENUM('Y','N') default 'N';
ALTER TABLE `system_settings` ADD `autoanswer_prefix` VARCHAR(5) default 'AA';
ALTER TABLE `system_settings` ADD `autoanswer_delay` TINYINT default '1';

ALTER TABLE `phones` MODIFY on_hook_agent ENUM('Y','N', 'AutoAnswer') default 'N';
ALTER TABLE `phones` ADD `autoanswer_type` ENUM('','SNOM') default '';

ALTER TABLE vicidial_campaigns ADD script_top_dispo ENUM('Y', 'N') default 'N';

UPDATE system_settings SET db_schema_version='1533',db_schema_update_date=NOW() where db_schema_version < 1533;
