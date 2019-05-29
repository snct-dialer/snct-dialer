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
