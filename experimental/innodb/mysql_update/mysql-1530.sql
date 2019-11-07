ALTER TABLE vicidial_campaigns ADD next_dial_my_callbacks ENUM('DISABLED','ENABLED') default 'DISABLED';
ALTER TABLE system_settings ADD anyone_callback_inactive_lists ENUM('default','NO_ADD_TO_HOPPER','KEEP_IN_HOPPER') default 'default';

CREATE TABLE vicidial_process_log (
serial_id VARCHAR(20) NOT NULL,
run_time DATETIME,
run_sec INT,
server_ip VARCHAR(15) NOT NULL,
script VARCHAR(100),
process VARCHAR(100),
output_lines MEDIUMTEXT,
index (serial_id),
index (run_time)
) ENGINE=InnoDB;

DELETE from cid_channels_recent;

ALTER TABLE system_settings ADD tmp_download_dir VARCHAR(255) default 'download';


ALTER TABLE vicidial_process_trigger_log MODIFY trigger_results MEDIUMTEXT;

ALTER TABLE vicidial_campaigns ADD inbound_no_agents_no_dial_container VARCHAR(40) default '---DISABLED---';
ALTER TABLE vicidial_campaigns ADD inbound_no_agents_no_dial_threshold SMALLINT(5) default '0';

ALTER TABLE vicidial_settings_containers MODIFY container_type VARCHAR(40) default 'OTHER';

CREATE TABLE vicidial_inbound_callback_queue (
icbq_id INT(9) UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
icbq_date DATETIME,
icbq_status VARCHAR(10),
icbq_phone_number VARCHAR(20),
icbq_phone_code VARCHAR(10),
icbq_nextday_choice ENUM('Y','N','U') default 'U',
lead_id INT(9) UNSIGNED NOT NULL,
group_id VARCHAR(20) NOT NULL,
queue_priority TINYINT(2) default '0',
call_date DATETIME,
gmt_offset_now DECIMAL(4,2) DEFAULT '0.00',
modify_date TIMESTAMP,
index (icbq_status)
) ENGINE=InnoDB;

CREATE TABLE vicidial_inbound_callback_queue_archive LIKE vicidial_inbound_callback_queue;
ALTER TABLE vicidial_inbound_callback_queue_archive MODIFY icbq_id INT(9) UNSIGNED NOT NULL;

ALTER TABLE vicidial_inbound_groups ADD icbq_expiration_hours SMALLINT(5) default '96';
ALTER TABLE vicidial_inbound_groups ADD closing_time_action VARCHAR(30) default 'DISABLED';
ALTER TABLE vicidial_inbound_groups ADD closing_time_now_trigger ENUM('Y','N') default 'N';
ALTER TABLE vicidial_inbound_groups ADD closing_time_filename TEXT;
ALTER TABLE vicidial_inbound_groups ADD closing_time_end_filename TEXT;
ALTER TABLE vicidial_inbound_groups ADD closing_time_lead_reset ENUM('Y','N') default 'N';
ALTER TABLE vicidial_inbound_groups ADD closing_time_option_exten VARCHAR(20) default '8300';
ALTER TABLE vicidial_inbound_groups ADD closing_time_option_callmenu VARCHAR(50) default '';
ALTER TABLE vicidial_inbound_groups ADD closing_time_option_voicemail VARCHAR(20) default '';
ALTER TABLE vicidial_inbound_groups ADD closing_time_option_xfer_group VARCHAR(20) default '---NONE---';
ALTER TABLE vicidial_inbound_groups ADD closing_time_option_callback_list_id BIGINT(14) UNSIGNED default '999';
ALTER TABLE vicidial_inbound_groups ADD add_lead_timezone ENUM('SERVER','PHONE_CODE_AREACODE') default 'SERVER';
ALTER TABLE vicidial_inbound_groups ADD icbq_call_time_id VARCHAR(20) default '24hours';
ALTER TABLE vicidial_inbound_groups ADD icbq_dial_filter VARCHAR(50) default 'NONE';

ALTER TABLE vicidial_closer_log MODIFY term_reason  ENUM('CALLER','AGENT','QUEUETIMEOUT','ABANDON','AFTERHOURS','HOLDRECALLXFER','HOLDTIME','NOAGENT','NONE','MAXCALLS','ACFILTER','CLOSETIME') default 'NONE';
ALTER TABLE vicidial_closer_log_archive MODIFY term_reason  ENUM('CALLER','AGENT','QUEUETIMEOUT','ABANDON','AFTERHOURS','HOLDRECALLXFER','HOLDTIME','NOAGENT','NONE','MAXCALLS','ACFILTER','CLOSETIME') default 'NONE';


ALTER TABLE system_settings ADD enable_gdpr_download_deletion ENUM('0','1','2') default '0';

ALTER TABLE vicidial_users ADD export_gdpr_leads ENUM('0','1','2') default '0';

CREATE TABLE recording_log_deletion_queue (
recording_id INT(9) UNSIGNED PRIMARY KEY,
lead_id int(10) UNSIGNED,
filename VARCHAR(100),
location VARCHAR(255),
date_queued DATETIME,
date_deleted DATETIME,
index (date_deleted)
) ENGINE=InnoDB;


CREATE TABLE vicidial_cid_groups (
cid_group_id VARCHAR(20) PRIMARY KEY NOT NULL,
cid_group_notes VARCHAR(255) default '',
cid_group_type ENUM('AREACODE','STATE') default 'AREACODE',
user_group VARCHAR(20) default '---ALL---'
) ENGINE=InnoDB CHARSET=utf8 COLLATE=utf8_unicode_ci;

ALTER TABLE vicidial_campaign_cid_areacodes MODIFY campaign_id VARCHAR(20) NOT NULL;

ALTER TABLE vicidial_campaigns ADD cid_group_id VARCHAR(20) default '---DISABLED---';

ALTER TABLE vicidial_campaigns ADD pause_max_dispo VARCHAR(6) default 'PAUSMX';

ALTER TABLE vicidial_inbound_groups MODIFY no_agent_no_queue ENUM('N','Y','NO_PAUSED','NO_READY') default 'N';

UPDATE system_settings SET db_schema_version='1530',db_schema_update_date=NOW() where db_schema_version < 1530;

