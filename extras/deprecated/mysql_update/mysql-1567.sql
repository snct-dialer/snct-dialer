CREATE TABLE vicidial_amd_log (
call_date DATETIME,
caller_code VARCHAR(30) default '',
lead_id INT(9) UNSIGNED,
uniqueid VARCHAR(20) default '',
channel VARCHAR(100) default '',
server_ip VARCHAR(60) NOT NULL,
AMDSTATUS VARCHAR(10) default '',
AMDRESPONSE VARCHAR(20) default '',
AMDCAUSE VARCHAR(30) default '',
run_time VARCHAR(20) default '0',
AMDSTATS VARCHAR(100) default '',
index (call_date),
index (lead_id)
) ENGINE=Aria ROW_FORMAT=PAGE;

CREATE TABLE vicidial_amd_log_archive LIKE vicidial_amd_log;
CREATE UNIQUE INDEX amd_unq_key on vicidial_amd_log_archive(uniqueid, call_date, lead_id);

UPDATE system_settings SET db_schema_version='1567',db_schema_update_date=NOW() where db_schema_version < 1567;

ALTER TABLE vicidial_users ADD next_dial_my_callbacks ENUM('NOT_ACTIVE','DISABLED','ENABLED') default 'NOT_ACTIVE';

UPDATE system_settings SET db_schema_version='1568',db_schema_update_date=NOW() where db_schema_version < 1568;

ALTER TABLE system_settings ADD user_admin_redirect ENUM('1','0') default '0';

ALTER TABLE vicidial_users ADD user_admin_redirect_url TEXT;

UPDATE system_settings SET db_schema_version='1569',db_schema_update_date=NOW() where db_schema_version < 1569;

ALTER TABLE vicidial_users ADD agent_disable_manual ENUM('0','1') default '0';
ALTER TABLE vicidial_users ADD agent_disable_alt_dial ENUM('0','1') default '0';

UPDATE system_settings SET db_schema_version='1570',db_schema_update_date=NOW() where db_schema_version < 1570;

ALTER TABLE system_settings ADD list_status_modification_confirmation ENUM('1','0') default '0';

UPDATE system_settings SET db_schema_version='1570',db_schema_update_date=NOW() where db_schema_version < 1570;

ALTER TABLE system_settings ADD sip_event_logging ENUM('0','1','2','3','4','5','6','7') default '0';

CREATE TABLE vicidial_sip_event_log (
sip_event_id INT(9) UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
caller_code VARCHAR(30) NOT NULL,
channel VARCHAR(100),
server_ip VARCHAR(15),
uniqueid VARCHAR(20),
sip_call_id VARCHAR(256),
event_date DATETIME(6),
event VARCHAR(10),
index(caller_code),
index(event_date)
) ENGINE=Aria ROW_FORMAT=PAGE;

CREATE TABLE vicidial_sip_event_log_0 LIKE vicidial_sip_event_log;
ALTER TABLE vicidial_sip_event_log_0 MODIFY sip_event_id INT(9) UNSIGNED NOT NULL;
CREATE TABLE vicidial_sip_event_log_1 LIKE vicidial_sip_event_log;
ALTER TABLE vicidial_sip_event_log_1 MODIFY sip_event_id INT(9) UNSIGNED NOT NULL;
CREATE TABLE vicidial_sip_event_log_2 LIKE vicidial_sip_event_log;
ALTER TABLE vicidial_sip_event_log_2 MODIFY sip_event_id INT(9) UNSIGNED NOT NULL;
CREATE TABLE vicidial_sip_event_log_3 LIKE vicidial_sip_event_log;
ALTER TABLE vicidial_sip_event_log_3 MODIFY sip_event_id INT(9) UNSIGNED NOT NULL;
CREATE TABLE vicidial_sip_event_log_4 LIKE vicidial_sip_event_log;
ALTER TABLE vicidial_sip_event_log_4 MODIFY sip_event_id INT(9) UNSIGNED NOT NULL;
CREATE TABLE vicidial_sip_event_log_5 LIKE vicidial_sip_event_log;
ALTER TABLE vicidial_sip_event_log_5 MODIFY sip_event_id INT(9) UNSIGNED NOT NULL;
CREATE TABLE vicidial_sip_event_log_6 LIKE vicidial_sip_event_log;
ALTER TABLE vicidial_sip_event_log_6 MODIFY sip_event_id INT(9) UNSIGNED NOT NULL;

CREATE TABLE vicidial_sip_event_archive_details (
wday TINYINT(1) UNSIGNED PRIMARY KEY NOT NULL,
start_event_date DATETIME(6),
end_event_date DATETIME(6),
record_count INT(9) UNSIGNED default '0'
) ENGINE=Aria ROW_FORMAT=PAGE;

CREATE TABLE vicidial_sip_event_recent (
caller_code VARCHAR(20) default '',
channel VARCHAR(100),
server_ip VARCHAR(15),
uniqueid VARCHAR(20),
invite_date DATETIME(6),
first_100_date DATETIME(6),
first_180_date DATETIME(6),
first_183_date DATETIME(6),
last_100_date DATETIME(6),
last_180_date DATETIME(6),
last_183_date DATETIME(6),
200_date DATETIME(6),
error_date DATETIME(6),
processed ENUM('N','Y','U') default 'N',
index(caller_code),
index(invite_date),
index(processed)
) ENGINE=Aria ROW_FORMAT=PAGE;

CREATE TABLE vicidial_log_extended_sip (
call_date DATETIME(6),
caller_code VARCHAR(30) NOT NULL,
invite_to_ring DECIMAL(10,6) DEFAULT '0.000000',
ring_to_final DECIMAL(10,6) DEFAULT '0.000000',
invite_to_final DECIMAL(10,6) DEFAULT '0.000000',
last_event_code SMALLINT(3) default '0',
index(call_date),
index(caller_code)
) ENGINE=Aria ROW_FORMAT=PAGE;

CREATE TABLE vicidial_log_extended_sip_archive LIKE vicidial_log_extended_sip;
CREATE UNIQUE INDEX vlesa on vicidial_log_extended_sip_archive (caller_code,call_date);

UPDATE system_settings SET db_schema_version='1571',db_schema_update_date=NOW() where db_schema_version < 1571;

CREATE INDEX vicidial_email_xfer_key on vicidial_email_list (xfercallid);

ALTER TABLE vicidial_campaigns MODIFY agent_screen_time_display VARCHAR(40) default 'DISABLED';

UPDATE system_settings SET db_schema_version='1572',db_schema_update_date=NOW() where db_schema_version < 1572;

ALTER TABLE system_settings ADD call_quota_lead_ranking ENUM('0','1','2') default '0';

ALTER TABLE vicidial_campaigns ADD auto_active_list_new VARCHAR(20) default 'DISABLED';
ALTER TABLE vicidial_campaigns ADD call_quota_lead_ranking VARCHAR(20) default 'DISABLED';
ALTER TABLE vicidial_campaigns ADD call_quota_process_running TINYINT(3) default '0';
ALTER TABLE vicidial_campaigns ADD call_quota_last_run_date DATETIME;

ALTER TABLE vicidial_lists ADD auto_active_list_rank SMALLINT(5) default '0';
ALTER TABLE vicidial_lists ADD cache_count INT(9) UNSIGNED default '0';
ALTER TABLE vicidial_lists ADD cache_count_new INT(9) UNSIGNED default '0';
ALTER TABLE vicidial_lists ADD cache_count_dialable_new INT(9) UNSIGNED default '0';
ALTER TABLE vicidial_lists ADD cache_date DATETIME;

CREATE TABLE vicidial_lead_call_quota_counts (
lead_id INT(9) UNSIGNED NOT NULL,
list_id BIGINT(14) UNSIGNED DEFAULT '0',
first_call_date DATETIME,
last_call_date DATETIME,
status VARCHAR(6),
called_count SMALLINT(5) UNSIGNED default '0',
session_one_calls TINYINT(3) default '0',
session_two_calls TINYINT(3) default '0',
session_three_calls TINYINT(3) default '0',
session_four_calls TINYINT(3) default '0',
session_five_calls TINYINT(3) default '0',
session_six_calls TINYINT(3) default '0',
day_one_calls TINYINT(3) default '0',
day_two_calls TINYINT(3) default '0',
day_three_calls TINYINT(3) default '0',
day_four_calls TINYINT(3) default '0',
day_five_calls TINYINT(3) default '0',
day_six_calls TINYINT(3) default '0',
day_seven_calls TINYINT(3) default '0',
session_one_today_calls TINYINT(3) default '0',
session_two_today_calls TINYINT(3) default '0',
session_three_today_calls TINYINT(3) default '0',
session_four_today_calls TINYINT(3) default '0',
session_five_today_calls TINYINT(3) default '0',
session_six_today_calls TINYINT(3) default '0',
rank SMALLINT(5) NOT NULL default '0',
modify_date DATETIME,
unique index vlcqc_lead_list (lead_id, list_id),
index(last_call_date),
index(list_id),
index(modify_date)
) ENGINE=Aria ROW_FORMAT=PAGE;

CREATE TABLE vicidial_lead_call_quota_counts_archive (
lead_id INT(9) UNSIGNED NOT NULL,
list_id BIGINT(14) UNSIGNED DEFAULT '0',
first_call_date DATETIME,
last_call_date DATETIME,
status VARCHAR(6),
called_count SMALLINT(5) UNSIGNED default '0',
session_one_calls TINYINT(3) default '0',
session_two_calls TINYINT(3) default '0',
session_three_calls TINYINT(3) default '0',
session_four_calls TINYINT(3) default '0',
session_five_calls TINYINT(3) default '0',
session_six_calls TINYINT(3) default '0',
day_one_calls TINYINT(3) default '0',
day_two_calls TINYINT(3) default '0',
day_three_calls TINYINT(3) default '0',
day_four_calls TINYINT(3) default '0',
day_five_calls TINYINT(3) default '0',
day_six_calls TINYINT(3) default '0',
day_seven_calls TINYINT(3) default '0',
session_one_today_calls TINYINT(3) default '0',
session_two_today_calls TINYINT(3) default '0',
session_three_today_calls TINYINT(3) default '0',
session_four_today_calls TINYINT(3) default '0',
session_five_today_calls TINYINT(3) default '0',
session_six_today_calls TINYINT(3) default '0',
rank SMALLINT(5) NOT NULL default '0',
modify_date DATETIME,
unique index vlcqc_lead_date (lead_id, first_call_date),
index(first_call_date)
) ENGINE=Aria ROW_FORMAT=PAGE;

UPDATE system_settings SET db_schema_version='1573',db_schema_update_date=NOW() where db_schema_version < 1573;

ALTER TABLE vicidial_campaigns ADD sip_event_logging VARCHAR(40) default 'DISABLED';
ALTER TABLE vicidial_campaigns MODIFY call_quota_lead_ranking VARCHAR(40) default 'DISABLED';

UPDATE system_settings SET db_schema_version='1574',db_schema_update_date=NOW() where db_schema_version < 1574;

CREATE TABLE vicidial_bench_agent_log (
lead_id INT(9) UNSIGNED,
bench_date DATETIME,
absent_agent VARCHAR(20),
bench_agent VARCHAR(20),
user VARCHAR(20),
index (bench_date),
index (lead_id)
) ENGINE=Aria ROW_FORMAT=PAGE;

UPDATE system_settings SET db_schema_version='1575',db_schema_update_date=NOW() where db_schema_version < 1575;

CREATE TABLE vicidial_sip_action_log (
call_date DATETIME(6),
caller_code VARCHAR(30) NOT NULL,
lead_id INT(9) UNSIGNED,
phone_number VARCHAR(18),
user VARCHAR(20),
result VARCHAR(40),
index(call_date),
index(caller_code),
index(result)
) ENGINE=Aria ROW_FORMAT=PAGE;

CREATE TABLE vicidial_sip_action_log_archive LIKE vicidial_sip_action_log;
CREATE UNIQUE INDEX vlesa on vicidial_sip_action_log_archive (caller_code,call_date);

ALTER TABLE vicidial_log MODIFY term_reason ENUM('CALLER','AGENT','QUEUETIMEOUT','ABANDON','AFTERHOURS','NONE','SYSTEM') default 'NONE';
ALTER TABLE twoday_vicidial_log MODIFY term_reason ENUM('CALLER','AGENT','QUEUETIMEOUT','ABANDON','AFTERHOURS','NONE','SYSTEM') default 'NONE';
ALTER TABLE vicidial_log_noanswer MODIFY term_reason  ENUM('CALLER','AGENT','QUEUETIMEOUT','ABANDON','AFTERHOURS','NONE','SYSTEM') default 'NONE';
ALTER TABLE vicidial_log_archive MODIFY term_reason ENUM('CALLER','AGENT','QUEUETIMEOUT','ABANDON','AFTERHOURS','NONE','SYSTEM') default 'NONE';
ALTER TABLE vicidial_log_noanswer_archive MODIFY term_reason ENUM('CALLER','AGENT','QUEUETIMEOUT','ABANDON','AFTERHOURS','NONE','SYSTEM') default 'NONE';

ALTER TABLE vicidial_list ADD address_source VARCHAR(150) DEFAULT '';
ALTER TABLE vicidial_list ADD INDEX alt_phone (alt_phone);

UPDATE system_settings SET db_schema_version='1576',db_schema_update_date=NOW() where db_schema_version < 1576;

ALTER TABLE vicidial_users ADD max_inbound_filter_enabled ENUM('0','1') default '0';
ALTER TABLE vicidial_users ADD max_inbound_filter_statuses TEXT;
ALTER TABLE vicidial_users ADD max_inbound_filter_ingroups TEXT;
ALTER TABLE vicidial_users ADD max_inbound_filter_min_sec SMALLINT(5) default '-1';

ALTER TABLE vicidial_live_inbound_agents ADD calls_today_filtered SMALLINT(5) UNSIGNED default '0';
ALTER TABLE vicidial_live_inbound_agents ADD last_call_time_filtered DATETIME;
ALTER TABLE vicidial_live_inbound_agents ADD last_call_finish_filtered DATETIME;

ALTER TABLE vicidial_inbound_group_agents ADD calls_today_filtered SMALLINT(5) UNSIGNED default '0';

ALTER TABLE vicidial_live_agents ADD last_inbound_call_time_filtered DATETIME;
ALTER TABLE vicidial_live_agents ADD last_inbound_call_finish_filtered DATETIME;

UPDATE system_settings SET db_schema_version='1577',db_schema_update_date=NOW() where db_schema_version < 1577;

UPDATE vicidial_screen_colors SET web_logo="SNCT.png";

ALTER TABLE system_settings ADD enable_second_script ENUM('0','1') default '0';

ALTER TABLE vicidial_inbound_groups ADD ingroup_script_two VARCHAR(20) default '';
ALTER TABLE vicidial_inbound_groups MODIFY get_call_launch ENUM('NONE','SCRIPT','SCRIPTTWO','WEBFORM','WEBFORMTWO','WEBFORMTHREE','FORM','EMAIL') default 'NONE';

ALTER TABLE vicidial_campaigns ADD campaign_script_two VARCHAR(20) default '';
ALTER TABLE vicidial_campaigns MODIFY get_call_launch ENUM('NONE','SCRIPT','SCRIPTTWO','WEBFORM','WEBFORMTWO','WEBFORMTHREE','FORM','PREVIEW_WEBFORM','PREVIEW_WEBFORMTWO','PREVIEW_WEBFORMTHREE') default 'NONE';
ALTER TABLE vicidial_campaigns ADD leave_vm_no_dispo ENUM('ENABLED','DISABLED') default 'DISABLED';
ALTER TABLE vicidial_campaigns ADD leave_vm_message_group_id VARCHAR(40) default '---NONE---';

CREATE TABLE leave_vm_message_groups (
leave_vm_message_group_id VARCHAR(40) PRIMARY KEY NOT NULL,
leave_vm_message_group_notes VARCHAR(255) default '',
active ENUM('Y','N') default 'Y',
user_group VARCHAR(20) default '---ALL---'
) ENGINE=Aria ROW_FORMAT=PAGE CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE leave_vm_message_groups_entries (
leave_vm_message_group_id VARCHAR(40) NOT NULL,
audio_filename VARCHAR(255) NOT NULL,
audio_name VARCHAR(255) default '',
rank SMALLINT(5) default '0',
time_start VARCHAR(4) default '0000',
time_end VARCHAR(4) default '2400'
) ENGINE=Aria ROW_FORMAT=PAGE CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE vicidial_agent_vmm_overrides (
call_date DATETIME,
caller_code VARCHAR(30) default '',
lead_id INT(9) UNSIGNED,
user VARCHAR(20) default '',
vm_message VARCHAR(255) default '',
index (caller_code),
index (call_date),
index (lead_id)
) ENGINE=Aria ROW_FORMAT=PAGE;

ALTER TABLE `vicidial_statuses` ADD `Pos` INT(5) NOT NULL DEFAULT '0';
ALTER TABLE `vicidial_campaign_statuses` ADD `Pos` INT(5) NOT NULL DEFAULT '0';

ALTER TABLE `system_settings` CHANGE `use_non_latin` `use_non_latin` ENUM('0','1') CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '1'; 
ALTER TABLE `system_settings` ADD `default_pdo_language` VARCHAR(20) NOT NULL DEFAULT 'en_EN';
ALTER TABLE `vicidial_users` ADD `selected_pdo_language` VARCHAR(20) NOT NULL DEFAULT 'en_EN'; 

UPDATE system_settings SET db_schema_version='1578',db_schema_update_date=NOW() where db_schema_version < 1578;
