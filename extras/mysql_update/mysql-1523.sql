ALTER TABLE vicidial_campaigns ADD scheduled_callbacks_email_alert ENUM('Y', 'N') default 'N';

ALTER TABLE vicidial_callbacks ADD email_alert datetime;
ALTER TABLE vicidial_callbacks ADD email_result ENUM('SENT','FAILED','NOT AVAILABLE');

ALTER TABLE vicidial_callbacks_archive ADD email_alert datetime;
ALTER TABLE vicidial_callbacks_archive ADD email_result ENUM('SENT','FAILED','NOT AVAILABLE');

INSERT INTO vicidial_settings_containers(container_id,container_notes,container_type,user_group,container_entry) VALUES ('AGENT_CALLBACK_EMAIL ','Scheduled callback email alert settings','OTHER','---ALL---','; sending email address\r\nemail_from => vicidial@local.server\r\n\r\n; subject of the email\r\nemail_subject => Scheduled callback alert for --A--agent_name--B--\r\n\r\nemail_body_begin => \r\nThis is a reminder that you have a scheduled callback right now for the following lead:\r\n\r\nName: --A--first_name--B-- --A--last_name--B--\r\nPhone: --A--phone_number--B--\r\nAlt. phone: --A--alt_phone--B--\r\nEmail: --A--email--B--\r\nCB Comments: --A--callback_comments--B--\r\nLead Comments: --A--comments--B--\r\n\r\nPlease don\'t respond to this, fool.\r\n\r\nemail_body_end');

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

UPDATE system_settings SET db_schema_version='1523',db_schema_update_date=NOW() where db_schema_version < 1523;
