UPDATE system_settings SET db_schema_version='1479',version='2.13rc1tk',db_schema_update_date=NOW() where db_schema_version < 1479;

UPDATE system_settings SET db_schema_version='1480',version='2.14b0.5',db_schema_update_date=NOW() where db_schema_version < 1480;

ALTER TABLE vicidial_settings_containers MODIFY container_type VARCHAR(40) default 'OTHER';

UPDATE system_settings SET db_schema_version='1481',db_schema_update_date=NOW() where db_schema_version < 1481;

CREATE TABLE parked_channels_recent (
channel VARCHAR(100) NOT NULL,
server_ip VARCHAR(15) NOT NULL,
channel_group VARCHAR(30),
park_end_time DATETIME,
index (channel_group),
index (park_end_time)
) ENGINE=Aria ROW_FORMAT=PAGE;

ALTER TABLE vicidial_manager_chats ADD column internal_chat_type ENUM('AGENT', 'MANAGER') default 'MANAGER' after manager_chat_id;
ALTER TABLE vicidial_manager_chats_archive ADD column internal_chat_type ENUM('AGENT', 'MANAGER') default 'MANAGER' after manager_chat_id;

ALTER TABLE vicidial_manager_chat_log ADD column message_id VARCHAR(20) after message;
ALTER TABLE vicidial_manager_chat_log_archive ADD column message_id VARCHAR(20) after message;

UPDATE system_settings SET db_schema_version='1482',db_schema_update_date=NOW() where db_schema_version < 1482;

ALTER TABLE system_settings ADD agent_chat_screen_colors VARCHAR(20) default 'default';

UPDATE system_settings SET db_schema_version='1483',db_schema_update_date=NOW() where db_schema_version < 1483;

ALTER TABLE servers ADD conf_qualify ENUM('Y','N') default 'Y';

UPDATE system_settings SET db_schema_version='1484',db_schema_update_date=NOW() where db_schema_version < 1484;

ALTER TABLE vicidial_inbound_groups ADD populate_lead_province VARCHAR(20) default 'DISABLED';

UPDATE system_settings SET db_schema_version='1485',db_schema_update_date=NOW() where db_schema_version < 1485;

ALTER TABLE vicidial_users ADD api_only_user ENUM('0','1') default '0';

UPDATE system_settings SET db_schema_version='1486',db_schema_update_date=NOW() where db_schema_version < 1486;

CREATE TABLE vicidial_api_urls (
api_id INT(9) UNSIGNED PRIMARY KEY NOT NULL,
api_date DATETIME,
remote_ip VARCHAR(50),
url MEDIUMTEXT
) ENGINE=Aria ROW_FORMAT=PAGE;

CREATE TABLE vicidial_api_urls_archive LIKE vicidial_api_urls;

UPDATE system_settings SET db_schema_version='1487',db_schema_update_date=NOW() where db_schema_version < 1487;

ALTER TABLE vicidial_campaigns ADD dead_to_dispo ENUM('ENABLED','DISABLED') default 'DISABLED';

UPDATE system_settings SET db_schema_version='1488',db_schema_update_date=NOW() where db_schema_version < 1488;

ALTER TABLE vicidial_live_agents ADD external_lead_id INT(9) UNSIGNED default '0';

UPDATE system_settings SET db_schema_version='1489',db_schema_update_date=NOW() where db_schema_version < 1489;

ALTER TABLE vicidial_inbound_groups ADD areacode_filter ENUM('DISABLED','ALLOW_ONLY','DROP_ONLY') default 'DISABLED';
ALTER TABLE vicidial_inbound_groups ADD areacode_filter_seconds SMALLINT(5) default '10';
ALTER TABLE vicidial_inbound_groups ADD areacode_filter_action ENUM('CALLMENU','INGROUP','DID','MESSAGE','EXTENSION','VOICEMAIL','VMAIL_NO_INST') default 'MESSAGE';
ALTER TABLE vicidial_inbound_groups ADD areacode_filter_action_value VARCHAR(255) default 'nbdy-avail-to-take-call|vm-goodbye';
ALTER TABLE vicidial_inbound_groups MODIFY max_calls_action ENUM('DROP','AFTERHOURS','NO_AGENT_NO_QUEUE','AREACODE_FILTER') default 'NO_AGENT_NO_QUEUE';

CREATE TABLE vicidial_areacode_filters (
group_id VARCHAR(20) NOT NULL,
areacode VARCHAR(6) NOT NULL,
index(group_id)
) ENGINE=Aria ROW_FORMAT=PAGE;

ALTER TABLE vicidial_closer_log MODIFY term_reason  ENUM('CALLER','AGENT','QUEUETIMEOUT','ABANDON','AFTERHOURS','HOLDRECALLXFER','HOLDTIME','NOAGENT','NONE','MAXCALLS','ACFILTER','CLOSETIME') default 'NONE';
ALTER TABLE vicidial_closer_log_archive MODIFY term_reason  ENUM('CALLER','AGENT','QUEUETIMEOUT','ABANDON','AFTERHOURS','HOLDRECALLXFER','HOLDTIME','NOAGENT','NONE','MAXCALLS','ACFILTER','CLOSETIME') default 'NONE';

UPDATE system_settings SET db_schema_version='1490',db_schema_update_date=NOW() where db_schema_version < 1490;

ALTER TABLE vicidial_lists_fields MODIFY field_required ENUM('Y','N','INBOUND_ONLY') default 'N';

UPDATE system_settings SET db_schema_version='1491',db_schema_update_date=NOW() where db_schema_version < 1491;

ALTER TABLE system_settings ADD enable_auto_reports ENUM('1','0') default '0';

ALTER TABLE vicidial_users ADD modify_auto_reports ENUM('1','0') default '0';

CREATE TABLE vicidial_automated_reports (
report_id VARCHAR(30) UNIQUE NOT NULL,
report_name VARCHAR(100),
report_last_run DATETIME,
report_last_length SMALLINT(5) default '0',
report_server VARCHAR(30) default 'active_voicemail_server',
report_times VARCHAR(100) default '',
report_weekdays VARCHAR(7) default '',
report_monthdays VARCHAR(100) default '',
report_destination ENUM('EMAIL','FTP') default 'EMAIL',
email_from VARCHAR(255) default '',
email_to VARCHAR(255) default '',
email_subject VARCHAR(255) default '',
ftp_server VARCHAR(255) default '',
ftp_user VARCHAR(255) default '',
ftp_pass VARCHAR(255) default '',
ftp_directory VARCHAR(255) default '',
report_url TEXT,
run_now_trigger ENUM('N','Y') default 'N',
active ENUM('N','Y') default 'N',
user_group VARCHAR(20) default '---ALL---',
index (report_times),
index (run_now_trigger)
) ENGINE=Aria ROW_FORMAT=PAGE;

UPDATE system_settings SET db_schema_version='1492',db_schema_update_date=NOW() where db_schema_version < 1492;

ALTER TABLE vicidial_campaigns ADD agent_xfer_validation ENUM('N','Y') default 'N';

ALTER TABLE vicidial_inbound_groups ADD populate_state_areacode ENUM('DISABLED','NEW_LEAD_ONLY','OVERWRITE_ALWAYS') default 'DISABLED';

UPDATE system_settings SET db_schema_version='1493',db_schema_update_date=NOW() where db_schema_version < 1493;

ALTER TABLE vicidial_campaigns MODIFY inbound_queue_no_dial ENUM('DISABLED','ENABLED','ALL_SERVERS','ENABLED_WITH_CHAT','ALL_SERVERS_WITH_CHAT') default 'DISABLED';

UPDATE system_settings SET db_schema_version='1494',db_schema_update_date=NOW() where db_schema_version < 1494;

ALTER TABLE phones ADD conf_qualify ENUM('Y','N') default 'Y';

UPDATE system_settings SET db_schema_version='1495',db_schema_update_date=NOW() where db_schema_version < 1495;

ALTER TABLE system_settings ADD enable_pause_code_limits ENUM('1','0') default '0';

ALTER TABLE vicidial_pause_codes ADD time_limit SMALLINT(5) UNSIGNED default '65000';

UPDATE system_settings SET db_schema_version='1496',db_schema_update_date=NOW() where db_schema_version < 1496;

ALTER TABLE system_settings ADD enable_drop_lists ENUM('0','1','2') default '0';

CREATE TABLE vicidial_drop_lists (
dl_id VARCHAR(30) UNIQUE NOT NULL,
dl_name VARCHAR(100),
last_run DATETIME,
dl_server VARCHAR(30) default 'active_voicemail_server',
dl_times VARCHAR(120) default '',
dl_weekdays VARCHAR(7) default '',
dl_monthdays VARCHAR(100) default '',
drop_statuses VARCHAR(255) default ' DROP -',
list_id BIGINT(14) UNSIGNED,
duplicate_check VARCHAR(50) default 'NONE',
run_now_trigger ENUM('N','Y') default 'N',
active ENUM('N','Y') default 'N',
user_group VARCHAR(20) default '---ALL---',
closer_campaigns TEXT,
index (dl_times),
index (run_now_trigger)
) ENGINE=Aria ROW_FORMAT=PAGE;

CREATE TABLE vicidial_drop_log (
uniqueid VARCHAR(50) NOT NULL,
server_ip VARCHAR(15) NOT NULL,
drop_date DATETIME NOT NULL,
lead_id INT(9) UNSIGNED NOT NULL,
phone_code VARCHAR(10),
phone_number VARCHAR(18),
campaign_id VARCHAR(20) NOT NULL,
status VARCHAR(6) NOT NULL,
drop_processed ENUM('N','Y','U') default 'N',
index(drop_date),
index(drop_processed)
) ENGINE=Aria ROW_FORMAT=PAGE;

CREATE TABLE vicidial_drop_log_archive LIKE vicidial_drop_log;
DROP INDEX drop_date on vicidial_drop_log_archive;
CREATE UNIQUE INDEX vicidial_drop_log_archive_key on vicidial_drop_log_archive(drop_date, uniqueid);

UPDATE system_settings SET db_schema_version='1497',db_schema_update_date=NOW() where db_schema_version < 1497;

ALTER TABLE vicidial_campaigns MODIFY use_custom_cid ENUM('Y','N','AREACODE','USER_CUSTOM_1','USER_CUSTOM_2','USER_CUSTOM_3','USER_CUSTOM_4','USER_CUSTOM_5') default 'N';

UPDATE system_settings SET db_schema_version='1498',db_schema_update_date=NOW() where db_schema_version < 1498;

ALTER TABLE system_settings ADD allow_ip_lists ENUM('0','1','2') default '0';
ALTER TABLE system_settings ADD system_ip_blacklist VARCHAR(30) default '';

ALTER TABLE vicidial_users ADD modify_ip_lists ENUM('1','0') default '0';
ALTER TABLE vicidial_users ADD ignore_ip_list ENUM('1','0') default '0';

ALTER TABLE vicidial_user_groups ADD admin_ip_list VARCHAR(30) default '';
ALTER TABLE vicidial_user_groups ADD agent_ip_list VARCHAR(30) default '';
ALTER TABLE vicidial_user_groups ADD api_ip_list VARCHAR(30) default '';

CREATE TABLE vicidial_ip_lists (
ip_list_id VARCHAR(30) UNIQUE NOT NULL,
ip_list_name VARCHAR(100),
active ENUM('N','Y') default 'N',
user_group VARCHAR(20) default '---ALL---'
) ENGINE=Aria ROW_FORMAT=PAGE;

CREATE TABLE vicidial_ip_list_entries (
ip_list_id VARCHAR(30) NOT NULL,
ip_address VARCHAR(45) NOT NULL,
index(ip_list_id),
index(ip_address)
) ENGINE=Aria ROW_FORMAT=PAGE;

UPDATE system_settings SET db_schema_version='1499',db_schema_update_date=NOW() where db_schema_version < 1499;

ALTER TABLE vicidial_drop_lists ADD dl_minutes MEDIUMINT(6) UNSIGNED default '0';

UPDATE system_settings SET db_schema_version='1500',db_schema_update_date=NOW() where db_schema_version < 1500;

ALTER TABLE vicidial_campaigns ADD ready_max_logout MEDIUMINT(7) default '0';

ALTER TABLE vicidial_users ADD ready_max_logout MEDIUMINT(7) default '-1';

ALTER TABLE servers ADD routing_prefix VARCHAR(10) default '13';

UPDATE system_settings SET db_schema_version='1501',db_schema_update_date=NOW() where db_schema_version < 1501;

CREATE TABLE cid_channels_recent (
caller_id_name VARCHAR(30) COLLATE utf8_unicode_ci NOT NULL,
connected_line_name VARCHAR(30) COLLATE utf8_unicode_ci NOT NULL,
server_ip VARCHAR(15) COLLATE utf8_unicode_ci DEFAULT NULL,
call_date DATETIME,
channel VARCHAR(100) COLLATE utf8_unicode_ci DEFAULT '',
dest_channel VARCHAR(100) COLLATE utf8_unicode_ci DEFAULT '',
linkedid VARCHAR(20) COLLATE utf8_unicode_ci DEFAULT '',
dest_uniqueid VARCHAR(20) COLLATE utf8_unicode_ci DEFAULT '',
uniqueid VARCHAR(20) COLLATE utf8_unicode_ci DEFAULT '',
index(call_date)
) ENGINE=Aria ROW_FORMAT=PAGE DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

UPDATE system_settings SET db_schema_version='1502',db_schema_update_date=NOW() where db_schema_version < 1502;

ALTER TABLE vicidial_campaigns ADD callback_display_days SMALLINT(3) default '0';

UPDATE system_settings SET db_schema_version='1503',db_schema_update_date=NOW() where db_schema_version < 1503;

ALTER TABLE vicidial_campaigns ADD three_way_record_stop ENUM('Y','N') default 'N';
ALTER TABLE vicidial_campaigns ADD hangup_xfer_record_start ENUM('Y','N') default 'N';

UPDATE system_settings SET db_schema_version='1504',db_schema_update_date=NOW() where db_schema_version < 1504;

CREATE TABLE vicidial_rt_monitor_log (
manager_user VARCHAR(20) NOT NULL,
manager_server_ip VARCHAR(15) NOT NULL,
manager_phone VARCHAR(20) NOT NULL,
manager_ip VARCHAR(15),
agent_user VARCHAR(20),
agent_server_ip VARCHAR(15),
agent_status VARCHAR(10),
agent_session VARCHAR(10),
lead_id INT(9) UNSIGNED,
campaign_id VARCHAR(8),
caller_code VARCHAR(20),
monitor_start_time DATETIME,
monitor_end_time DATETIME,
monitor_sec INT(9) UNSIGNED default '0',
monitor_type ENUM('LISTEN','BARGE','HIJACK','WHISPER') default 'LISTEN',
index (manager_user),
index (agent_user),
unique index (caller_code),
index (monitor_start_time)
) ENGINE=Aria ROW_FORMAT=PAGE;

CREATE TABLE vicidial_rt_monitor_log_archive LIKE vicidial_rt_monitor_log;

UPDATE system_settings SET db_schema_version='1505',db_schema_update_date=NOW() where db_schema_version < 1505;

ALTER TABLE servers ADD git_commit VARCHAR(55) default '';
ALTER TABLE servers ADD git_release VARCHAR(25) default '';
ALTER TABLE system_settings ADD git_commit VARCHAR(55) default '';
ALTER TABLE system_settings ADD git_release VARCHAR(25) default '';

UPDATE system_settings SET db_schema_version='1506',db_schema_update_date=NOW() where db_schema_version < 1506;

ALTER TABLE system_settings ADD agent_push_events ENUM('0','1') default '0';
ALTER TABLE system_settings ADD agent_push_url TEXT;
ALTER TABLE vicidial_call_time_holidays ADD holiday_color VARCHAR(7) default '';

UPDATE system_settings SET db_schema_version='1507',db_schema_update_date=NOW() where db_schema_version < 1507;

ALTER TABLE system_settings ADD pause_campaigns ENUM('Y','N') default 'N';
ALTER TABLE vicidial_agent_log ADD pause_campaign VARCHAR(20) default '';
ALTER TABLE system_settings ADD hide_inactive_lists ENUM('0','1') default '0';

UPDATE system_settings SET db_schema_version='1508',db_schema_update_date=NOW() where db_schema_version < 1508;

ALTER TABLE phones MODIFY pass VARCHAR(100);
ALTER TABLE phones MODIFY login_pass VARCHAR(100);

ALTER TABLE vicidial_users MODIFY pass VARCHAR(100) NOT NULL;
ALTER TABLE vicidial_users MODIFY phone_pass VARCHAR(100);
ALTER TABLE vicidial_users MODIFY pass_hash VARCHAR(500) default '';

ALTER TABLE vicidial_avatars MODIFY avatar_api_pass VARCHAR(100) default '';

ALTER TABLE system_settings MODIFY default_phone_registration_password VARCHAR(100) default 'test';
ALTER TABLE system_settings MODIFY default_phone_login_password VARCHAR(100) default 'test';
ALTER TABLE system_settings MODIFY default_server_password VARCHAR(100) default 'test';

UPDATE system_settings SET db_schema_version='1509',db_schema_update_date=NOW() where db_schema_version < 1509;

ALTER TABLE system_settings ADD detect_3way ENUM('Y','N') default 'Y';
ALTER TABLE system_settings ADD company_name VARCHAR(50) default '';

UPDATE system_settings SET db_schema_version='1510',db_schema_update_date=NOW() where db_schema_version < 1510;

ALTER TABLE vicidial_inbound_groups ADD custom_one VARCHAR(100) default '';
ALTER TABLE vicidial_inbound_groups ADD custom_two VARCHAR(100) default '';
ALTER TABLE vicidial_inbound_groups ADD custom_three VARCHAR(100) default '';
ALTER TABLE vicidial_inbound_groups ADD custom_four VARCHAR(100) default '';
ALTER TABLE vicidial_inbound_groups ADD custom_five VARCHAR(100) default '';

ALTER TABLE user_call_log ADD xfer_hungup VARCHAR(20) default '';
ALTER TABLE user_call_log ADD xfer_hungup_datetime DATETIME;

ALTER TABLE vicidial_agent_log ADD pause_code VARCHAR(6) default '';

UPDATE system_settings SET db_schema_version='1511',db_schema_update_date=NOW() where db_schema_version < 1511;

CREATE TABLE vicidial_campaign_hour_counts (
campaign_id VARCHAR(8),
date_hour DATETIME,
next_hour DATETIME,
last_update DATETIME,
type VARCHAR(8) default 'CALLS',
calls MEDIUMINT(6) UNSIGNED default '0',
hr TINYINT(2) default '0',
index (campaign_id),
index (date_hour),
unique index vchc_camp_hour (campaign_id, date_hour, type)
) ENGINE=Aria ROW_FORMAT=PAGE;

CREATE TABLE vicidial_campaign_hour_counts_archive LIKE vicidial_campaign_hour_counts;

CREATE TABLE vicidial_carrier_hour_counts (
date_hour DATETIME,
next_hour DATETIME,
last_update DATETIME,
type VARCHAR(20) default 'ANSWERED',
calls MEDIUMINT(6) UNSIGNED default '0',
hr TINYINT(2) default '0',
index (date_hour),
unique index vclhc_hour (date_hour, type)
) ENGINE=Aria ROW_FORMAT=PAGE;

CREATE TABLE vicidial_carrier_hour_counts_archive LIKE vicidial_carrier_hour_counts;

UPDATE system_settings SET db_schema_version='1512',db_schema_update_date=NOW() where db_schema_version < 1512;

CREATE TABLE user_call_log_archive LIKE user_call_log;
ALTER TABLE user_call_log_archive MODIFY user_call_log_id INT(9) UNSIGNED NOT NULL;

ALTER TABLE vicidial_lists ADD custom_one VARCHAR(100) default '';
ALTER TABLE vicidial_lists ADD custom_two VARCHAR(100) default '';
ALTER TABLE vicidial_lists ADD custom_three VARCHAR(100) default '';
ALTER TABLE vicidial_lists ADD custom_four VARCHAR(100) default '';
ALTER TABLE vicidial_lists ADD custom_five VARCHAR(100) default '';

ALTER TABLE system_settings ADD ticket_mail VARCHAR(100) default '';

UPDATE system_settings SET db_schema_version='1513',db_schema_update_date=NOW() where db_schema_version < 1513;

#
# Ab hier zusätzlich Einzelfiles
#

CREATE TABLE vicidial_inbound_survey_log (
uniqueid VARCHAR(50) NOT NULL,
lead_id INT(9) UNSIGNED NOT NULL,
campaign_id VARCHAR(20) NOT NULL,
call_date DATETIME,
participate ENUM('N','Y') default 'N',
played ENUM('N','R','Y') default 'N',
dtmf_response VARCHAR(1) default '',
next_call_menu TEXT,
index (call_date),
index (lead_id),
index (uniqueid)
) ENGINE=Aria ROW_FORMAT=PAGE;

CREATE TABLE vicidial_inbound_survey_log_archive LIKE vicidial_inbound_survey_log;
CREATE UNIQUE INDEX visla_key on vicidial_inbound_survey_log_archive(uniqueid, call_date, campaign_id, lead_id);

ALTER TABLE vicidial_inbound_groups ADD inbound_survey ENUM('DISABLED','ENABLED') default 'DISABLED';
ALTER TABLE vicidial_inbound_groups ADD inbound_survey_filename TEXT;
ALTER TABLE vicidial_inbound_groups ADD inbound_survey_accept_digit VARCHAR(1) default '';
ALTER TABLE vicidial_inbound_groups ADD inbound_survey_question_filename TEXT;
ALTER TABLE vicidial_inbound_groups ADD inbound_survey_callmenu TEXT;

ALTER TABLE system_settings ADD allow_manage_active_lists ENUM('0','1') default '0';

UPDATE system_settings SET db_schema_version='1514',db_schema_update_date=NOW() where db_schema_version < 1514;

ALTER TABLE vicidial_automated_reports ADD filename_override VARCHAR(255) default '';
ALTER TABLE vicidial_automated_reports MODIFY report_times VARCHAR(255) default '';

UPDATE system_settings SET db_schema_version='1515',db_schema_update_date=NOW() where db_schema_version < 1515;

CREATE INDEX vle_lead_id on vicidial_log_extended(lead_id);

ALTER TABLE vicidial_xfer_log ADD front_uniqueid VARCHAR(50) default '';
ALTER TABLE vicidial_xfer_log ADD close_uniqueid VARCHAR(50) default '';

CREATE TABLE vicidial_xfer_log_archive LIKE vicidial_xfer_log;
ALTER TABLE vicidial_xfer_log_archive MODIFY xfercallid INT(9) UNSIGNED NOT NULL;

UPDATE system_settings SET db_schema_version='1516',db_schema_update_date=NOW() where db_schema_version < 1516;


ALTER TABLE vicidial_agent_log_archive ADD pause_campaign VARCHAR(20) default '';
ALTER TABLE vicidial_agent_log_archive ADD pause_code VARCHAR(6) default '';

UPDATE system_settings SET db_schema_version='1517',db_schema_update_date=NOW() where db_schema_version < 1517;

ALTER TABLE system_settings ADD expired_lists_inactive ENUM('0','1') default '0';

UPDATE system_settings SET db_schema_version='1518',db_schema_update_date=NOW() where db_schema_version < 1518;

ALTER TABLE system_settings ADD did_system_filter ENUM('0','1') default '0';

CREATE TABLE vicidial_dnccom_scrub_log (
phone_number VARCHAR(18),
scrub_date DATETIME NOT NULL,
flag_invalid ENUM('','0','1') default '',
flag_dnc ENUM('','0','1') default '',
flag_litigator ENUM('','0','1') default '',
full_response VARCHAR(255) default '',
index(phone_number),
index(scrub_date)
) ENGINE=Aria ROW_FORMAT=PAGE;

ALTER TABLE vicidial_dnccom_scrub_log ADD flag_projdnc ENUM('','0','1') default '' AFTER flag_dnc;

ALTER TABLE vicidial_campaigns MODIFY extension_appended_cidname ENUM('Y','N','Y_USER','Y_WITH_CAMPAIGN','Y_USER_WITH_CAMPAIGN') default 'N';

ALTER TABLE vicidial_inbound_groups MODIFY extension_appended_cidname ENUM('Y','N','Y_USER','Y_WITH_CAMPAIGN','Y_USER_WITH_CAMPAIGN') default 'N';

ALTER TABLE vicidial_custom_reports MODIFY path_name TEXT COLLATE utf8_unicode_ci DEFAULT NULL;
ALTER TABLE vicidial_custom_reports ADD custom_variables TEXT COLLATE utf8_unicode_ci DEFAULT NULL AFTER path_name;

UPDATE system_settings SET db_schema_version='1519',db_schema_update_date=NOW() where db_schema_version < 1519;

ALTER TABLE server_performance ADD disk_reads MEDIUMINT(7);
ALTER TABLE server_performance ADD disk_writes MEDIUMINT(7);

UPDATE system_settings SET db_schema_version='1520',db_schema_update_date=NOW() where db_schema_version < 1520;

ALTER TABLE vicidial_lists ADD inbound_list_script_override VARCHAR(20);

UPDATE system_settings SET db_schema_version='1521',db_schema_update_date=NOW() where db_schema_version < 1521;

ALTER TABLE phones ADD webphone_layout VARCHAR(255) default '';

ALTER TABLE vicidial_user_groups ADD webphone_layout VARCHAR(255) default '';

UPDATE system_settings SET db_schema_version='1522',db_schema_update_date=NOW() where db_schema_version < 1522;

CREATE TABLE IF NOT EXISTS `WallBoardStat` (
  `ID` bigint(20) NOT NULL,
  `StandVom` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Datum` date DEFAULT NULL,
  `Gruppe` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Kunden` bigint(20) DEFAULT '0',
  `Calls` bigint(20) DEFAULT '0',
  `phones` bigint(20) DEFAULT '0',
  `Drops` bigint(20) DEFAULT '0',
  `WL` bigint(20) DEFAULT '0',
  `AB` bigint(20) DEFAULT '0',
  `Agent` bigint(20) DEFAULT '0',
  `ebk` double DEFAULT '0',
  `kebk` double DEFAULT '0',
  `SL0` bigint(20) DEFAULT '0',
  `SL1` bigint(20) DEFAULT '0',
  `SL2` bigint(20) DEFAULT '0',
  `waittime` double DEFAULT '0',
  `Unbekannt` bigint(20) DEFAULT '0',
  `TKunden` bigint(20) NOT NULL DEFAULT '0',
  `TCalls` bigint(20) NOT NULL DEFAULT '0',
  `Tphones` bigint(20) NOT NULL DEFAULT '0',
  `TDrops` bigint(20) NOT NULL DEFAULT '0',
  `TWL` bigint(20) NOT NULL DEFAULT '0',
  `TAB` bigint(20) NOT NULL DEFAULT '0',
  `TAgent` bigint(20) NOT NULL DEFAULT '0',
  `Tebk` double NOT NULL DEFAULT '0',
  `Tkebk` double NOT NULL DEFAULT '0',
  `TSL0` bigint(20) NOT NULL DEFAULT '0',
  `TSL1` bigint(20) NOT NULL DEFAULT '0',
  `TSL2` bigint(20) NOT NULL DEFAULT '0',
  `Twaittime` double NOT NULL DEFAULT '0',
  `TUnbekannt` bigint(20) NOT NULL DEFAULT '0'
) ENGINE=Aria ROW_FORMAT=PAGE DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

ALTER TABLE `WallBoardStat`
  ADD PRIMARY KEY (`ID`);

ALTER TABLE `WallBoardStat`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT;

CREATE TABLE IF NOT EXISTS `WallBoardData` (
  `ID` bigint(20) NOT NULL,
  `DateTBegin` datetime DEFAULT NULL,
  `DateTEnd` datetime DEFAULT NULL,
  `Status` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Done` tinyint(1) DEFAULT NULL,
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lead_id` int(9) DEFAULT NULL,
  `DIDGruppe` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `IBGruppe` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Agent` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CallerID` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `did_route` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SL0` tinyint(1) DEFAULT NULL,
  `SL1` tinyint(1) DEFAULT NULL,
  `SL2` tinyint(1) DEFAULT NULL,
  `Dauer` bigint(20) NOT NULL DEFAULT '0',
  `next_uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=Aria ROW_FORMAT=PAGE DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

ALTER TABLE `WallBoardData`
  ADD PRIMARY KEY (`ID`);

ALTER TABLE `WallBoardData`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT;

CREATE TABLE `WallBoardData_archive` LIKE `WallBoardData`;

ALTER TABLE vicidial_campaigns ADD scheduled_callbacks_email_alert ENUM('Y', 'N') default 'N';

ALTER TABLE vicidial_callbacks ADD email_alert datetime;
ALTER TABLE vicidial_callbacks ADD email_result ENUM('SENT','FAILED','NOT AVAILABLE');

ALTER TABLE vicidial_callbacks_archive ADD email_alert datetime;
ALTER TABLE vicidial_callbacks_archive ADD email_result ENUM('SENT','FAILED','NOT AVAILABLE');

INSERT INTO vicidial_settings_containers(container_id,container_notes,container_type,user_group,container_entry) VALUES ('AGENT_CALLBACK_EMAIL ','Scheduled callback email alert settings','OTHER','---ALL---','; sending email address\r\nemail_from => vicidial@local.server\r\n\r\n; subject of the email\r\nemail_subject => Scheduled callback alert for --A--agent_name--B--\r\n\r\nemail_body_begin => \r\nThis is a reminder that you have a scheduled callback right now for the following lead:\r\n\r\nName: --A--first_name--B-- --A--last_name--B--\r\nPhone: --A--phone_number--B--\r\nAlt. phone: --A--alt_phone--B--\r\nEmail: --A--email--B--\r\nCB Comments: --A--callback_comments--B--\r\nLead Comments: --A--comments--B--\r\n\r\nPlease don\'t respond to this, fool.\r\n\r\nemail_body_end');

UPDATE system_settings SET db_schema_version='1523',db_schema_update_date=NOW() where db_schema_version < 1523;

ALTER TABLE system_settings ADD allow_phonebook ENUM('0','1') default '0';
UPDATE system_settings SET db_schema_version='1524',db_schema_update_date=NOW() where db_schema_version < 1524;

ALTER TABLE `vicidial_agent_log` ADD INDEX `uniqueid` (`uniqueid`);
ALTER TABLE `WallBoardData` ADD INDEX `uniqueid` (`uniqueid`);
ALTER TABLE `WallBoardData_archive` ADD INDEX `uniqueid` (`uniqueid`);

UPDATE system_settings SET db_schema_version='1525',db_schema_update_date=NOW() where db_schema_version < 1525;

ALTER TABLE system_settings ADD servicelevel_direct SMALLINT UNSIGNED DEFAULT '4';
ALTER TABLE system_settings ADD servicelevel_one SMALLINT UNSIGNED DEFAULT '20';
ALTER TABLE system_settings ADD servicelevel_two SMALLINT UNSIGNED DEFAULT '40';
ALTER TABLE vicidial_lists_fields ADD field_duplicate ENUM('Y','N') default 'N';

UPDATE system_settings SET db_schema_version='1526',db_schema_update_date=NOW() where db_schema_version < 1526;

ALTER TABLE `vicidial_list` CHANGE `alt_phone` `alt_phone` VARCHAR(18) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `WallBoardStat` ADD `maxwaittime` BIGINT(20) NOT NULL DEFAULT '0', ADD `Tmaxwaittime` BIGINT(20) NOT NULL DEFAULT '0';

UPDATE system_settings SET db_schema_version='1527',db_schema_update_date=NOW() where db_schema_version < 1527;

ALTER TABLE vicidial_campaigns ADD max_inbound_calls_outcome ENUM('DEFAULT','ALLOW_AGENTDIRECT','ALLOW_MI_PAUSE','ALLOW_AGENTDIRECT_AND_MI_PAUSE') default 'DEFAULT';
ALTER TABLE vicidial_campaigns ADD manual_auto_next_options ENUM('DEFAULT','PAUSE_NO_COUNT') default 'DEFAULT';

ALTER TABLE contact_information ADD office_num_phone_code VARCHAR(10) COLLATE utf8_unicode_ci DEFAULT '';
ALTER TABLE contact_information ADD cell_num_phone_code VARCHAR(10) COLLATE utf8_unicode_ci DEFAULT '';
ALTER TABLE contact_information ADD other_num1_phone_code VARCHAR(10) COLLATE utf8_unicode_ci DEFAULT '';
ALTER TABLE contact_information ADD other_num2_phone_code VARCHAR(10) COLLATE utf8_unicode_ci DEFAULT '';

ALTER TABLE vicidial_campaigns ADD agent_screen_time_display VARCHAR(40) default 'DISABLED';

ALTER TABLE vicidial_campaigns MODIFY get_call_launch ENUM('NONE','SCRIPT','SCRIPTTWO','WEBFORM','WEBFORMTWO','WEBFORMTHREE','FORM','PREVIEW_WEBFORM','PREVIEW_WEBFORMTWO','PREVIEW_WEBFORMTHREE') default 'NONE';

UPDATE system_settings SET db_schema_version='1528',db_schema_update_date=NOW() where db_schema_version < 1528;

CREATE TABLE vicidial_ingroup_hour_counts (
group_id VARCHAR(20),
date_hour DATETIME,
next_hour DATETIME,
last_update DATETIME,
type VARCHAR(22) default 'CALLS',
calls INT(9) UNSIGNED default '0',
hr TINYINT(2) default '0',
index (group_id),
index (date_hour),
unique index vihc_ingr_hour (group_id, date_hour, type)
) ENGINE=Aria ROW_FORMAT=PAGE;

CREATE TABLE vicidial_ingroup_hour_counts_archive LIKE vicidial_ingroup_hour_counts;

ALTER TABLE vicidial_lists ADD default_xfer_group VARCHAR(20) default '---NONE---';

UPDATE system_settings SET db_schema_version='1529',db_schema_update_date=NOW() where db_schema_version < 1529;

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
) ENGINE=Aria ROW_FORMAT=PAGE;

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
) ENGINE=Aria ROW_FORMAT=PAGE;

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
) ENGINE=Aria ROW_FORMAT=PAGE;

CREATE TABLE vicidial_cid_groups (
cid_group_id VARCHAR(20) PRIMARY KEY NOT NULL,
cid_group_notes VARCHAR(255) default '',
cid_group_type ENUM('AREACODE','STATE') default 'AREACODE',
user_group VARCHAR(20) default '---ALL---'
) ENGINE=Aria ROW_FORMAT=PAGE CHARSET=utf8 COLLATE=utf8_unicode_ci;

ALTER TABLE vicidial_campaign_cid_areacodes MODIFY campaign_id VARCHAR(20) NOT NULL;

ALTER TABLE vicidial_campaigns ADD cid_group_id VARCHAR(20) default '---DISABLED---';

ALTER TABLE vicidial_campaigns ADD pause_max_dispo VARCHAR(6) default 'PAUSMX';

ALTER TABLE vicidial_inbound_groups MODIFY no_agent_no_queue ENUM('N','Y','NO_PAUSED','NO_READY') default 'N';

UPDATE system_settings SET db_schema_version='1530',db_schema_update_date=NOW() where db_schema_version < 1530;

ALTER TABLE `vicidial_inbound_groups` ADD `pickup_delay` TINYINT NOT NULL DEFAULT '0' AFTER `icbq_dial_filter`;
ALTER TABLE `system_settings` ADD `agent_prefix` VARCHAR(3) default '';

UPDATE system_settings SET db_schema_version='1531',db_schema_update_date=NOW() where db_schema_version < 1531;


ALTER TABLE `recording_log` ADD INDEX `UserTime` (`user`, `start_time`);
ALTER TABLE `recording_log_archive` ADD INDEX `UserTime` (`user`, `start_time`);

UPDATE system_settings SET db_schema_version='1532',db_schema_update_date=NOW() where db_schema_version < 1532;

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
status INT(9)
ip VARCHAR(18),
login_time DATETIME,
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
remote_lead_id INT(9) UNSIGNED,
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
ALTER TABLE vicidial_campaigns ADD call_quota_lead_ranking VARCHAR(40) default 'DISABLED';
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

ALTER TABLE `vicidial_cid_groups` CHANGE `cid_group_type` `cid_group_type` ENUM('AREACODE','STATE','PHONECODE') CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT 'AREACODE';
UPDATE `system_settings` SET `use_non_latin` = '1';

CREATE TABLE `vicidial_call_menu_log` (
`ID` bigint(20) NOT NULL AUTO_INCREMENT,
`campaign_id` VARCHAR(20) NOT NULL,
`menu_id` varchar(50) CHARACTER SET utf8 NOT NULL,
`lead_id` bigint(20) NOT NULL,
`select_time` datetime NOT NULL DEFAULT current_timestamp(),
`select_value` varchar(20) CHARACTER SET utf8 NOT NULL,
PRIMARY KEY (`ID`),
KEY `time` (`select_time`),
KEY `Menu_Time` (`menu_id`,`select_time`)
) ENGINE=Aria ROW_FORMAT=PAGE DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

ALTER TABLE `park_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT '0';
ALTER TABLE `recording_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `recording_log_archive` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `recording_log_deletion_queue` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `routing_initiated_recordings` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `thirty_days` CHANGE `lead_ID` `lead_ID` INT NOT NULL;
ALTER TABLE `twoday_recording_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `twoday_vicidial_agent_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `twoday_vicidial_closer_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `twoday_vicidial_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `twoday_vicidial_xfer_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `user_call_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `user_call_log_archive` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_agent_function_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_agent_function_log_archive` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_agent_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_agent_log_archive` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_agent_skip_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_agent_vmm_overrides` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_ajax_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_amd_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_amd_log_archive` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_auto_calls` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_bench_agent_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_call_notes` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_call_notes_archive` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_callbacks` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_callbacks_archive` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_callbacks_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_carrier_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_carrier_log_archive` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_ccc_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_ccc_log` CHANGE `remote_lead_id` `remote_lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_ccc_log_archive` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_ccc_log_archive` CHANGE `remote_lead_id` `remote_lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_chat_archive` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_closer_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_closer_log_archive` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_comments` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_cpd_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_dial_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_dial_log_archive` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_dnccom_filter_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_drop_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_drop_log_archive` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_email_list` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_email_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_grab_call_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_hopper` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_inbound_callback_queue` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_inbound_callback_queue_archive` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_inbound_survey_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_inbound_survey_log_archive` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_ivr` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_ivr_response` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_lead_call_quota_counts` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_lead_call_quota_counts_archive` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_list` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT; 
ALTER TABLE `vicidial_list_alt_phones` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_list_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_list_pins` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_live_agents` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_live_agents` CHANGE `preview_lead_id` `preview_lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_live_agents` CHANGE `external_lead_id` `external_lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_live_chats` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_log_archive` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_log_extended` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_log_extended_archive` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_log_noanswer` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_log_noanswer_archive` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_outbound_ivr_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_outbound_ivr_log_archive` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_qc_agent_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_recent_ascb_calls` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_recent_ascb_calls_archive` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_recording_access_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_remote_agent_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_rt_monitor_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_rt_monitor_log_archive` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_sessions_recent` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_sessions_recent_archive` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_sip_action_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_sip_action_log_archive` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_vdad_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_xfer_log` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_xfer_log_archive` CHANGE `lead_id` `lead_id` BIGINT UNSIGNED NULL DEFAULT NULL;


ALTER TABLE `dialable_inventory_snapshots` CHANGE `list_id` `list_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `phones` CHANGE `nva_new_list_id` `nva_new_list_id` BIGINT UNSIGNED NULL DEFAULT '995'; 
ALTER TABLE `twoday_vicidial_closer_log` CHANGE `list_id` `list_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `twoday_vicidial_log` CHANGE `list_id` `list_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `twoday_vicidial_xfer_log` CHANGE `list_id` `list_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_callbacks` CHANGE `list_id` `list_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_callbacks_archive` CHANGE `list_id` `list_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_callbacks_log` CHANGE `list_id` `list_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_campaigns` CHANGE `manual_dial_list_id` `manual_dial_list_id` BIGINT UNSIGNED NULL DEFAULT '998'; 
ALTER TABLE `vicidial_ccc_log` CHANGE `list_id` `list_id` BIGINT UNSIGNED NULL DEFAULT NULL; 
ALTER TABLE `vicidial_ccc_log_archive` CHANGE `list_id` `list_id` BIGINT UNSIGNED NULL DEFAULT NULL; 
ALTER TABLE `vicidial_closer_log` CHANGE `list_id` `list_id` BIGINT UNSIGNED NULL DEFAULT NULL; 
ALTER TABLE `vicidial_closer_log_archive` CHANGE `list_id` `list_id` BIGINT UNSIGNED NULL DEFAULT NULL; 
ALTER TABLE `vicidial_comments` CHANGE `list_id` `list_id` BIGINT UNSIGNED NOT NULL; 
ALTER TABLE `vicidial_custom_leadloader_templates` CHANGE `list_id` `list_id` BIGINT UNSIGNED NULL DEFAULT NULL; 
ALTER TABLE `vicidial_dnccom_filter_log` CHANGE `list_id` `list_id` BIGINT UNSIGNED NULL DEFAULT NULL; 
ALTER TABLE `vicidial_drop_lists` CHANGE `list_id` `list_id` BIGINT UNSIGNED NULL DEFAULT NULL; 
ALTER TABLE `vicidial_email_accounts` CHANGE `default_list_id` `default_list_id` BIGINT UNSIGNED NULL DEFAULT NULL; 
ALTER TABLE `vicidial_email_accounts` CHANGE `list_id` `list_id` BIGINT UNSIGNED NULL DEFAULT NULL; 
ALTER TABLE `vicidial_hopper` CHANGE `list_id` `list_id` BIGINT UNSIGNED NOT NULL; 
ALTER TABLE `vicidial_inbound_dids` CHANGE `list_id` `list_id` BIGINT UNSIGNED NULL DEFAULT '999'; 
ALTER TABLE `vicidial_inbound_dids` CHANGE `filter_list_id` `filter_list_id` BIGINT UNSIGNED NULL DEFAULT '999'; 
ALTER TABLE `vicidial_inbound_dids` CHANGE `entry_list_id` `entry_list_id` BIGINT UNSIGNED NULL DEFAULT '0'; 
ALTER TABLE `vicidial_inbound_dids` CHANGE `filter_entry_list_id` `filter_entry_list_id` BIGINT UNSIGNED NULL DEFAULT '0';
ALTER TABLE `vicidial_inbound_groups` CHANGE `hold_time_option_callback_list_id` `hold_time_option_callback_list_id` BIGINT UNSIGNED NULL DEFAULT '999'; 
ALTER TABLE `vicidial_inbound_groups` CHANGE `wait_time_option_callback_list_id` `wait_time_option_callback_list_id` BIGINT UNSIGNED NULL DEFAULT '999'; 
ALTER TABLE `vicidial_inbound_groups` CHANGE `closing_time_option_callback_list_id` `closing_time_option_callback_list_id` BIGINT UNSIGNED NULL DEFAULT '999'; 
ALTER TABLE `vicidial_lead_call_quota_counts` CHANGE `list_id` `list_id` BIGINT UNSIGNED NULL DEFAULT '0'; 
ALTER TABLE `vicidial_lead_call_quota_counts_archive` CHANGE `list_id` `list_id` BIGINT UNSIGNED NULL DEFAULT '0'; 
ALTER TABLE `vicidial_list` CHANGE `list_id` `list_id` BIGINT UNSIGNED NOT NULL DEFAULT '0'; 
ALTER TABLE `vicidial_list` CHANGE `entry_list_id` `entry_list_id` BIGINT UNSIGNED NOT NULL DEFAULT '0';
ALTER TABLE `vicidial_list_log` CHANGE `list_id` `list_id` BIGINT UNSIGNED NOT NULL DEFAULT '0'; 
ALTER TABLE `vicidial_list_log` CHANGE `entry_list_id` `entry_list_id` BIGINT UNSIGNED NOT NULL DEFAULT '0'; 
ALTER TABLE `vicidial_lists` CHANGE `list_id` `list_id` BIGINT UNSIGNED NOT NULL;
ALTER TABLE `vicidial_lists_custom` CHANGE `list_id` `list_id` BIGINT UNSIGNED NOT NULL;
ALTER TABLE `vicidial_lists_fields` CHANGE `list_id` `list_id` BIGINT UNSIGNED NOT NULL DEFAULT '0';
ALTER TABLE `vicidial_log` CHANGE `list_id` `list_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_log_archive` CHANGE `list_id` `list_id` BIGINT UNSIGNED NULL DEFAULT NULL;
ALTER TABLE `vicidial_log_noanswer` CHANGE `list_id` `list_id` BIGINT UNSIGNED NULL DEFAULT NULL; 
ALTER TABLE `vicidial_log_noanswer_archive` CHANGE `list_id` `list_id` BIGINT UNSIGNED NULL DEFAULT NULL; 
ALTER TABLE `vicidial_qc_agent_log` CHANGE `list_id` `list_id` BIGINT UNSIGNED NOT NULL; 
ALTER TABLE `vicidial_recent_ascb_calls` CHANGE `list_id` `list_id` BIGINT UNSIGNED NULL DEFAULT NULL; 
ALTER TABLE `vicidial_recent_ascb_calls_archive` CHANGE `list_id` `list_id` BIGINT UNSIGNED NULL DEFAULT NULL; 
ALTER TABLE `vicidial_user_list_new_lead` CHANGE `list_id` `list_id` BIGINT UNSIGNED NULL DEFAULT '999'; 
ALTER TABLE `vicidial_xfer_log` CHANGE `list_id` `list_id` BIGINT UNSIGNED NULL DEFAULT NULL; 
ALTER TABLE `vicidial_xfer_log_archive` CHANGE `list_id` `list_id` BIGINT UNSIGNED NULL DEFAULT NULL; 

ALTER TABLE `system_settings` ADD `show_newdispo` ENUM('0','1') NOT NULL DEFAULT '0';
ALTER TABLE `vicidial_inbound_groups` ADD `acr_id` BIGINT UNSIGNED NOT NULL DEFAULT '0'; 
ALTER TABLE `system_settings` ADD `show_archive` TINYINT NOT NULL DEFAULT '0'; 
ALTER TABLE `vicidial_campaigns` ADD `acr_id` BIGINT UNSIGNED NOT NULL DEFAULT '0';
ALTER TABLE `vicidial_campaign_statuses` ADD `Col` INT NOT NULL DEFAULT '0';
ALTER TABLE `vicidial_statuses` ADD `Col` INT NOT NULL DEFAULT '0';

RENAME TABLE `snctdialer-acr_select` TO `snctdialer_acr_select`;
RENAME TABLE `snctdialer-after_call_action` TO `snctdialer_after_call_action`;
RENAME TABLE `snctdialer-live` TO `snctdialer_live`;
