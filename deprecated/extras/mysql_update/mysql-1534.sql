
ALTER TABLE vicidial_campaigns ADD dead_trigger_seconds SMALLINT(5) default '0';
ALTER TABLE vicidial_campaigns ADD dead_trigger_action ENUM('DISABLED','AUDIO','URL','AUDIO_AND_URL') default 'DISABLED';
ALTER TABLE vicidial_campaigns ADD dead_trigger_repeat ENUM('NO','REPEAT_ALL','REPEAT_AUDIO','REPEAT_URL') default 'NO';
ALTER TABLE vicidial_campaigns ADD dead_trigger_filename TEXT;
ALTER TABLE vicidial_campaigns ADD dead_trigger_url TEXT;

CREATE TABLE vicidial_ccc_log (
call_date DATETIME,
remote_call_id VARCHAR(30) default '',
local_call_id VARCHAR(30) default '',
lead_id INT(9) UNSIGNED,
uniqueid VARCHAR(20) default '',
channel VARCHAR(100) default '',
server_ip VARCHAR(60) NOT NULL,
list_id BIGINT(14) UNSIGNED,
container_id VARCHAR(40) default '',
index (call_date),
index (local_call_id),
index (lead_id)
) ENGINE=Aria ROW_FORMAT=PAGE;

ALTER TABLE vicidial_list ADD INDEX `modify_date` (`modify_date`);
ALTER TABLE vicidial_list ADD coord_one POINT NULL DEFAULT NULL;
ALTER TABLE vicidial_list ADD coord_two POINT NULL DEFAULT NULL;

CREATE TABLE vicidial_did_log_archive LIKE vicidial_did_log;
CREATE UNIQUE INDEX vdidla_key on vicidial_did_log_archive(uniqueid, call_date, server_ip);

ALTER TABLE vicidial_inbound_groups ADD cid_cb_confirm_number VARCHAR(20) default 'NO';
ALTER TABLE vicidial_inbound_groups ADD cid_cb_invalid_filter_phone_group VARCHAR(20) default '';
ALTER TABLE vicidial_inbound_groups ADD cid_cb_valid_length VARCHAR(30) default '10';
ALTER TABLE vicidial_inbound_groups ADD cid_cb_valid_filename TEXT;
ALTER TABLE vicidial_inbound_groups ADD cid_cb_confirmed_filename TEXT;
ALTER TABLE vicidial_inbound_groups ADD cid_cb_enter_filename TEXT;
ALTER TABLE vicidial_inbound_groups ADD cid_cb_you_entered_filename TEXT;
ALTER TABLE vicidial_inbound_groups ADD cid_cb_press_to_confirm_filename TEXT;
ALTER TABLE vicidial_inbound_groups ADD cid_cb_invalid_filename TEXT;
ALTER TABLE vicidial_inbound_groups ADD cid_cb_reenter_filename TEXT;
ALTER TABLE vicidial_inbound_groups ADD cid_cb_error_filename TEXT;

ALTER TABLE system_settings ADD agent_logout_link ENUM('0','1','2','3','4') default '1';

ALTER TABLE vicidial_campaigns ADD scheduled_callbacks_force_dial ENUM('N','Y') default 'N';


ALTER TABLE vicidial_campaigns ADD scheduled_callbacks_auto_reschedule VARCHAR(10) default 'DISABLED';

CREATE TABLE vicidial_recent_ascb_calls (
call_date DATETIME,
callback_date DATETIME,
callback_id INT(9) UNSIGNED default '0',
caller_code VARCHAR(30) default '',
lead_id INT(9) UNSIGNED,
server_ip VARCHAR(60) NOT NULL,
orig_status VARCHAR(6) default 'CALLBK',
reschedule VARCHAR(10) default '',
list_id BIGINT(14) UNSIGNED,
rescheduled ENUM('U','P','Y','N') default 'U',
unique index (caller_code),
index (call_date),
index (lead_id)
) ENGINE=Aria ROW_FORMAT=PAGE;

CREATE TABLE vicidial_recent_ascb_calls_archive LIKE vicidial_recent_ascb_calls;

ALTER TABLE vicidial_phone_codes ADD php_tz VARCHAR(100) default '';

ALTER TABLE vicidial_campaigns ADD scheduled_callbacks_timezones_container VARCHAR(40) default 'DISABLED';

ALTER TABLE vicidial_callbacks ADD customer_timezone VARCHAR(100) default '';
ALTER TABLE vicidial_callbacks ADD customer_timezone_diff VARCHAR(6) default '';
ALTER TABLE vicidial_callbacks ADD customer_time DATETIME;

ALTER TABLE vicidial_callbacks_archive ADD customer_timezone VARCHAR(100) default '';
ALTER TABLE vicidial_callbacks_archive ADD customer_timezone_diff VARCHAR(6) default '';
ALTER TABLE vicidial_callbacks_archive ADD customer_time DATETIME;

INSERT INTO vicidial_settings_containers(container_id,container_notes,container_type,user_group,container_entry) VALUES ('TIMEZONES_USA','USA Timezone List','TIMEZONE_LIST','---ALL---','USA,AST,N,Atlantic Time Zone\nUSA,EST,Y,Eastern Time Zone\nUSA,CST,Y,Central Time Zone\nUSA,MST,Y,Mountain Time Zone\nUSA,MST,N,Arizona Time Zone\nUSA,PST,Y,Pacific Time Zone\nUSA,AKST,Y,Alaska Time Zone\nUSA,HST,N,Hawaii Time Zone\n');
INSERT INTO vicidial_settings_containers(container_id,container_notes,container_type,user_group,container_entry) VALUES ('TIMEZONES_CANADA','Canadian Timezone List','TIMEZONE_LIST','---ALL---','CAN,NST,Y,Newfoundland Time Zone\nCAN,AST,Y,Atlantic Time Zone\nCAN,EST,Y,Eastern Time Zone\nCAN,CST,Y,Central Time Zone\nCAN,CST,N,Saskatchewan Time Zone\nCAN,MST,Y,Mountain Time Zone\nCAN,PST,Y,Pacific Time Zone\n');
INSERT INTO vicidial_settings_containers(container_id,container_notes,container_type,user_group,container_entry) VALUES ('TIMEZONES_AUSTRALIA','Australian Timezone List','TIMEZONE_LIST','---ALL---','AUS,AEST,Y,Eastern Australia Time Zone\nAUS,AEST,N,Queensland Time Zone\nAUS,ACST,Y,Central Australia Time Zone\nAUS,ACST,N,Northern Territory Time Zone\nAUS,AWST,N,Western Australia Time Zone\n');

CREATE INDEX vicidial_email_group_key on vicidial_email_list(group_id);

ALTER TABLE vicidial_ccc_log ADD remote_lead_id INT(9) UNSIGNED;

CREATE TABLE vicidial_ccc_log_archive LIKE vicidial_ccc_log;
CREATE UNIQUE INDEX ccc_unq_key on vicidial_ccc_log_archive(uniqueid, call_date, lead_id);

ALTER TABLE vicidial_lists ADD daily_reset_limit SMALLINT(5) default '-1';
ALTER TABLE vicidial_lists ADD resets_today SMALLINT(5) UNSIGNED default '0';

ALTER TABLE vicidial_campaigns ADD three_way_volume_buttons VARCHAR(20) default 'ENABLED';

ALTER TABLE vicidial_campaigns ADD callback_dnc ENUM('ENABLED','DISABLED') default 'DISABLED';

ALTER TABLE vicidial_campaigns MODIFY next_agent_call VARCHAR(40) default 'longest_wait_time';
ALTER TABLE vicidial_inbound_groups MODIFY next_agent_call VARCHAR(40) default 'longest_wait_time';

ALTER TABLE servers ADD external_web_socket_url VARCHAR(255) default '';


ALTER TABLE system_settings ADD manual_dial_validation ENUM('0','1','2','3','4') default '0';

ALTER TABLE vicidial_campaigns ADD manual_dial_validation ENUM('Y','N') default 'N';


ALTER TABLE phones ADD redirect_user VARCHAR(16) NULL DEFAULT NULL;
ALTER TABLE phones ADD redirect_busy VARCHAR(16) NULL DEFAULT NULL;
ALTER TABLE phones ADD redirect_timeout VARCHAR(16) NULL DEFAULT NULL;
ALTER TABLE phones ADD redirect_notavailable VARCHAR(16) NULL DEFAULT NULL;
ALTER TABLE phones ADD redirect_context VARCHAR(20) NOT NULL DEFAULT 'default';

ALTER TABLE vicidial_inbound_groups ADD group_exten VARCHAR(20) NULL DEFAULT NULL;

CREATE TABLE vicidial_sessions_recent (
lead_id INT(9) UNSIGNED,
server_ip VARCHAR(15) NOT NULL,
call_date DATETIME,
user VARCHAR(20),
campaign_id VARCHAR(20),
conf_exten VARCHAR(20),
call_type VARCHAR(1) default '',
index(lead_id),
index(call_date)
) ENGINE=Aria ROW_FORMAT=PAGE;

CREATE TABLE vicidial_sessions_recent_archive LIKE vicidial_sessions_recent;

ALTER TABLE vicidial_inbound_groups ADD place_in_line_caller_number_filename TEXT;
ALTER TABLE vicidial_inbound_groups ADD place_in_line_you_next_filename TEXT;

ALTER TABLE system_settings ADD mute_recordings ENUM('1','0') default '0';

ALTER TABLE vicidial_campaigns ADD mute_recordings ENUM('Y','N') default 'N';

ALTER TABLE vicidial_users ADD mute_recordings ENUM('DISABLED','Y','N') default 'DISABLED';

ALTER TABLE vicidial_campaigns MODIFY hide_call_log_info ENUM('Y','N','SHOW_1','SHOW_2','SHOW_3','SHOW_4','SHOW_5','SHOW_6','SHOW_7','SHOW_8','SHOW_9','SHOW_10') default 'N';

ALTER TABLE vicidial_users ADD hide_call_log_info ENUM('DISABLED','Y','N','SHOW_1','SHOW_2','SHOW_3','SHOW_4','SHOW_5','SHOW_6','SHOW_7','SHOW_8','SHOW_9','SHOW_10') default 'DISABLED';

UPDATE system_settings SET db_schema_version='1534',db_schema_update_date=NOW() where db_schema_version < 1534;
