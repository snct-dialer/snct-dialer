UPDATE system_settings SET db_schema_version='1479',version='2.13rc1tk',db_schema_update_date=NOW() where db_schema_version < 1479;

UPDATE system_settings SET db_schema_version='1480',version='2.14b0.5',db_schema_update_date=NOW() where db_schema_version < 1480;

ALTER TABLE vicidial_settings_containers MODIFY container_type ENUM('OTHER','PERL_CLI','EMAIL_TEMPLATE','AGI') default 'OTHER';

UPDATE system_settings SET db_schema_version='1481',db_schema_update_date=NOW() where db_schema_version < 1481;

CREATE TABLE parked_channels_recent (
channel VARCHAR(100) NOT NULL,
server_ip VARCHAR(15) NOT NULL,
channel_group VARCHAR(30),
park_end_time DATETIME,
index (channel_group),
index (park_end_time)
) ENGINE=MyISAM;

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
) ENGINE=MyISAM;

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
) ENGINE=MyISAM;

ALTER TABLE vicidial_closer_log MODIFY term_reason  ENUM('CALLER','AGENT','QUEUETIMEOUT','ABANDON','AFTERHOURS','HOLDRECALLXFER','HOLDTIME','NOAGENT','NONE','MAXCALLS','ACFILTER') default 'NONE';
ALTER TABLE vicidial_closer_log_archive MODIFY term_reason  ENUM('CALLER','AGENT','QUEUETIMEOUT','ABANDON','AFTERHOURS','HOLDRECALLXFER','HOLDTIME','NOAGENT','NONE','MAXCALLS','ACFILTER') default 'NONE';

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
) ENGINE=MyISAM;

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
) ENGINE=MyISAM;

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
) ENGINE=MyISAM;

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
) ENGINE=MyISAM;

CREATE TABLE vicidial_ip_list_entries (
ip_list_id VARCHAR(30) NOT NULL,
ip_address VARCHAR(45) NOT NULL,
index(ip_list_id),
index(ip_address)
) ENGINE=MyISAM;

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
) ENGINE=MyISAM;

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
) ENGINE=MyISAM;

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
) ENGINE=MyISAM;

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
) ENGINE=MyISAM;

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
) ENGINE=MyISAM;

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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

ALTER TABLE vicidial_campaigns ADD agent_screen_time_display ENUM('DISABLED','ENABLED_BASIC','ENABLED_FULL','ENABLED_BILL_BREAK_LUNCH_COACH') default 'DISABLED';
ALTER TABLE vicidial_campaigns MODIFY get_call_launch ENUM('NONE','SCRIPT','WEBFORM','WEBFORMTWO','WEBFORMTHREE','FORM','PREVIEW_WEBFORM','PREVIEW_WEBFORMTWO','PREVIEW_WEBFORMTHREE') default 'NONE';

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
) ENGINE=MyISAM;

CREATE TABLE vicidial_ingroup_hour_counts_archive LIKE vicidial_ingroup_hour_counts;

ALTER TABLE vicidial_lists ADD default_xfer_group VARCHAR(20) default '---NONE---';

UPDATE system_settings SET db_schema_version='1529',db_schema_update_date=NOW() where db_schema_version < 1529;

ALTER TABLE vicidial_campaigns ADD next_dial_my_callbacks ENUM('DISABLED','ENABLED') default 'DISABLED';

UPDATE system_settings SET db_schema_version='1530',db_schema_update_date=NOW() where db_schema_version < 1530;

