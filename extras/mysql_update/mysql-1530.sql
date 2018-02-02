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
) ENGINE=MyISAM;

DELETE from cid_channels_recent;

ALTER TABLE system_settings ADD tmp_download_dir VARCHAR(255) default 'download';


ALTER TABLE vicidial_process_trigger_log MODIFY trigger_results MEDIUMTEXT;

ALTER TABLE vicidial_campaigns ADD inbound_no_agents_no_dial_container VARCHAR(40) default '---DISABLED---';
ALTER TABLE vicidial_campaigns ADD inbound_no_agents_no_dial_threshold SMALLINT(5) default '0';

ALTER TABLE vicidial_settings_containers MODIFY container_type VARCHAR(40) default 'OTHER';


UPDATE system_settings SET db_schema_version='1530',db_schema_update_date=NOW() where db_schema_version < 1530;

