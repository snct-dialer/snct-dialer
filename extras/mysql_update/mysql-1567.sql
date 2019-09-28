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
) ENGINE=MyISAM;

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
) ENGINE=MyISAM;

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
) ENGINE=MyISAM;

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
) ENGINE=MyISAM;  

CREATE TABLE vicidial_log_extended_sip (
call_date DATETIME(6),
caller_code VARCHAR(30) NOT NULL,
invite_to_ring DECIMAL(10,6) DEFAULT '0.000000',
ring_to_final DECIMAL(10,6) DEFAULT '0.000000',
invite_to_final DECIMAL(10,6) DEFAULT '0.000000',
last_event_code SMALLINT(3) default '0',
index(call_date),
index(caller_code)
) ENGINE=MyISAM;

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
) ENGINE=MyISAM;

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
) ENGINE=MyISAM;

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
) ENGINE=MyISAM;

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
) ENGINE=MyISAM;

CREATE TABLE vicidial_sip_action_log_archive LIKE vicidial_sip_action_log;
CREATE UNIQUE INDEX vlesa on vicidial_sip_action_log_archive (caller_code,call_date);

ALTER TABLE vicidial_log MODIFY term_reason ENUM('CALLER','AGENT','QUEUETIMEOUT','ABANDON','AFTERHOURS','NONE','SYSTEM') default 'NONE';
ALTER TABLE twoday_vicidial_log MODIFY term_reason ENUM('CALLER','AGENT','QUEUETIMEOUT','ABANDON','AFTERHOURS','NONE','SYSTEM') default 'NONE';
ALTER TABLE vicidial_log_noanswer MODIFY term_reason  ENUM('CALLER','AGENT','QUEUETIMEOUT','ABANDON','AFTERHOURS','NONE','SYSTEM') default 'NONE';
ALTER TABLE vicidial_log_archive MODIFY term_reason ENUM('CALLER','AGENT','QUEUETIMEOUT','ABANDON','AFTERHOURS','NONE','SYSTEM') default 'NONE';
ALTER TABLE vicidial_log_noanswer_archive MODIFY term_reason ENUM('CALLER','AGENT','QUEUETIMEOUT','ABANDON','AFTERHOURS','NONE','SYSTEM') default 'NONE';


UPDATE system_settings SET db_schema_version='1576',db_schema_update_date=NOW() where db_schema_version < 1576;
