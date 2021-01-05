ALTER TABLE `system_settings` ADD `autoanswer_enable` ENUM('Y','N') default 'N';
ALTER TABLE `system_settings` ADD `autoanswer_prefix` VARCHAR(5) default 'AA';
ALTER TABLE `system_settings` ADD `autoanswer_delay` TINYINT default '1';

ALTER TABLE `phones` MODIFY on_hook_agent ENUM('Y','N', 'AutoAnswer') default 'N';
ALTER TABLE `phones` ADD `autoanswer_type` ENUM('','SNOM') default '';

ALTER TABLE vicidial_campaigns ADD script_top_dispo ENUM('Y', 'N') default 'N';

ALTER TABLE system_settings ADD source_id_display ENUM('0','1') default '0';

ALTER TABLE vicidial_pause_codes ADD require_mgr_approval ENUM('NO','YES') default 'NO';

ALTER TABLE vicidial_users ADD pause_code_approval ENUM('1','0') default '0';

CREATE TABLE vicidial_agent_function_log (
agent_function_log_id INT(9) UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
agent_log_id INT(9) UNSIGNED,
user VARCHAR(20),
function VARCHAR(20),
event_time DATETIME,
lead_id INT(9) UNSIGNED,
campaign_id VARCHAR(8),
user_group VARCHAR(20),
caller_code VARCHAR(30) default '',
comments VARCHAR(40) default '',
stage VARCHAR(40) default '',
uniqueid VARCHAR(20) default '',
index (event_time),
index (caller_code),
index (user),
index (lead_id),
index (stage)
) ENGINE=Aria ROW_FORMAT=PAGE;

CREATE TABLE vicidial_agent_function_log_archive LIKE vicidial_agent_function_log;
ALTER TABLE vicidial_agent_function_log_archive MODIFY agent_function_log_id INT(9) UNSIGNED NOT NULL;


ALTER TABLE vicidial_inbound_groups ADD populate_lead_source VARCHAR(20) default 'DISABLED';
ALTER TABLE vicidial_inbound_groups ADD populate_lead_vendor VARCHAR(20) default 'INBOUND_NUMBER';

ALTER TABLE vicidial_inbound_groups ADD park_file_name VARCHAR(100) default '';
ALTER TABLE vicidial_lists_fields MODIFY field_type ENUM('TEXT','AREA','SELECT','MULTI','RADIO','CHECKBOX','DATE','TIME','DISPLAY','SCRIPT','HIDDEN','READONLY','HIDEBLOB','SWITCH') default 'TEXT';

ALTER TABLE `vicidial_users` CHANGE `pass` `pass` VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL;

ALTER TABLE system_settings ADD help_modification_date VARCHAR(20) default '0';

CREATE TABLE help_documentation (
help_id varchar(100) PRIMARY KEY COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
help_title text COLLATE utf8_unicode_ci,
help_text text COLLATE utf8_unicode_ci
) ENGINE=Aria ROW_FORMAT=PAGE DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

ALTER TABLE vicidial_campaign_agents ADD hopper_calls_today SMALLINT(5) UNSIGNED default '0';
ALTER TABLE vicidial_campaign_agents ADD hopper_calls_hour SMALLINT(5) UNSIGNED default '0';

ALTER TABLE vicidial_users ADD max_hopper_calls SMALLINT(5) UNSIGNED default '0';
ALTER TABLE vicidial_users ADD max_hopper_calls_hour SMALLINT(5) UNSIGNED default '0';

CREATE TABLE vicidial_faillogin_log (
ID INT(9) UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
user VARCHAR(20),
status INT(9),
ip VARCHAR(18),
login_time DATETIME
) ENGINE=Aria ROW_FORMAT=PAGE;

ALTER TABLE vicidial_inbound_groups ADD waiting_call_url_on TEXT;
ALTER TABLE vicidial_inbound_groups ADD waiting_call_url_off TEXT;
ALTER TABLE vicidial_inbound_groups ADD waiting_call_count SMALLINT(5) UNSIGNED default '0';
ALTER TABLE vicidial_inbound_groups ADD enter_ingroup_url TEXT;

ALTER TABLE `phones` ADD `on_hook_auto_answer` ENUM('Y','N') NOT NULL DEFAULT 'N';
ALTER TABLE `phones` ADD `auto_answer_sipheader` VARCHAR(255) NOT NULL DEFAULT '';
ALTER TABLE `phones` ADD `auto_answer_prefix` VARCHAR(4) NOT NULL DEFAULT '';

ALTER TABLE `vicidial_live_agents` ADD `on_hook_saved_status` ENUM('READY','CLOSER','PAUSED','LOGIN') NULL DEFAULT NULL;
ALTER TABLE `vicidial_live_agents` ADD `on_hook_auto_answer` ENUM('Y','N') NOT NULL DEFAULT 'N';
ALTER TABLE `vicidial_live_agents` ADD `auto_answer_prefix` VARCHAR(4) NOT NULL DEFAULT '';


UPDATE system_settings SET db_schema_version='1533',db_schema_update_date=NOW() where db_schema_version < 1533;
