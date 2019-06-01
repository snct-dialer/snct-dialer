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
