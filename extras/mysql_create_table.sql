CREATE TABLE `1Report` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL,
  `Datum` date NOT NULL,
  `Name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `UserGroup` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `SumID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UserIdDateGroup` (`UserID`,`Datum`,`UserGroup`)
) ENGINE=Aria AUTO_INCREMENT=39348 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
CREATE TABLE `1ReportAgent` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserID` bigint(20) NOT NULL,
  `Name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `UserGroup` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `SumID` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UserID` (`UserID`),
  KEY `UserGroup` (`UserGroup`) USING BTREE
) ENGINE=Aria AUTO_INCREMENT=616 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
CREATE TABLE `1ReportData` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ReportID` int(11) NOT NULL,
  `LK` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `CountNew` int(11) DEFAULT NULL,
  `SumNew` decimal(10,2) DEFAULT NULL,
  `CountOld` int(11) DEFAULT NULL,
  `SumOld` decimal(10,2) DEFAULT NULL,
  `UserID` bigint(20) NOT NULL,
  `Datum` date NOT NULL,
  `CheckRun` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UserLKDatum` (`UserID`,`LK`,`Datum`),
  KEY `Datum` (`Datum`)
) ENGINE=Aria AUTO_INCREMENT=27550425 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
CREATE TABLE `1ReportEinzel` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserID` bigint(20) NOT NULL,
  `Datum` date NOT NULL,
  `Auftragsnummer` int(11) NOT NULL,
  `BetragNetto` decimal(10,2) NOT NULL,
  `VendorID` int(11) NOT NULL,
  `Source` int(11) NOT NULL DEFAULT 0,
  `BuchDat` date DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `User` (`UserID`),
  KEY `Datum` (`Datum`),
  KEY `UserDatum` (`UserID`,`Datum`),
  KEY `BuchDatum` (`BuchDat`)
) ENGINE=Aria AUTO_INCREMENT=96412 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
CREATE TABLE `Newletter_sperre` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `aktiv_seit` datetime NOT NULL DEFAULT current_timestamp(),
  `MailSend` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=Aria AUTO_INCREMENT=184 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci PAGE_CHECKSUM=1;
CREATE TABLE `Newsletter` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) NOT NULL,
  `Email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `LK` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `gesendet` datetime NOT NULL,
  `aktiv` int(11) NOT NULL,
  `Name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Vorname` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `ID` (`ID`)
) ENGINE=Aria AUTO_INCREMENT=3445 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci PAGE_CHECKSUM=1;
CREATE TABLE `NewsletterOrg` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) NOT NULL,
  `Email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `LK` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `gesendet` datetime NOT NULL,
  `aktiv` int(11) NOT NULL,
  `Name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Vorname` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `ID` (`ID`)
) ENGINE=Aria AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci PAGE_CHECKSUM=0 TRANSACTIONAL=0;
CREATE TABLE `Newsletter_GK_D` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) NOT NULL,
  `Email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `LK` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `gesendet` datetime NOT NULL,
  `aktiv` int(11) NOT NULL,
  `Name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Vorname` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `ID` (`ID`)
) ENGINE=Aria AUTO_INCREMENT=6643 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci PAGE_CHECKSUM=1;
CREATE TABLE `Newsletter_PK_D` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) NOT NULL,
  `Email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `LK` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `gesendet` datetime NOT NULL,
  `aktiv` int(11) NOT NULL,
  `Name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Vorname` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `ID` (`ID`)
) ENGINE=Aria AUTO_INCREMENT=10969 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci PAGE_CHECKSUM=1;
CREATE TABLE `Newsletter_carlo` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) NOT NULL,
  `Email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `LK` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `gesendet` datetime NOT NULL,
  `aktiv` int(11) NOT NULL,
  `Name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Vorname` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `ID` (`ID`)
) ENGINE=Aria AUTO_INCREMENT=93 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci PAGE_CHECKSUM=1;
CREATE TABLE `Newsletter_gk` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) NOT NULL,
  `Email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `LK` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `gesendet` datetime NOT NULL,
  `aktiv` int(11) NOT NULL,
  `Name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Vorname` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `ID` (`ID`)
) ENGINE=Aria AUTO_INCREMENT=3480 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci PAGE_CHECKSUM=1;
CREATE TABLE `Newsletter_hamburg` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) NOT NULL,
  `Email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `LK` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `gesendet` datetime NOT NULL,
  `aktiv` int(11) NOT NULL,
  `Name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Vorname` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `ID` (`ID`)
) ENGINE=Aria AUTO_INCREMENT=906 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci PAGE_CHECKSUM=1;
CREATE TABLE `SNCT_Live` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Station` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `Phone` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `User` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `UserName` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `UserGrp` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `SessionID` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `Status` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `SubStatus` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `Pause` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `CustomPhone` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `ServerIP` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `CallServerIP` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `Time` time NOT NULL,
  `Campaign` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `Calls` int(11) NOT NULL,
  `Hold` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `Ingroup` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `invalid` int(11) NOT NULL DEFAULT 0,
  `SortStatus` int(11) NOT NULL DEFAULT 0,
  `Stand_vom` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UserID` (`User`),
  KEY `Sort` (`SortStatus`,`Time`) USING HASH
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
CREATE TABLE `Sheet1` (
  `Adressnummer` int(6) DEFAULT NULL,
  `telefon` varchar(28) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dnc` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
CREATE TABLE `User_Stats` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `User` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `Datum` date NOT NULL,
  `Calls` int(11) NOT NULL,
  `full_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `UserGroup` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Login_Time` int(11) NOT NULL,
  `Pause` int(11) NOT NULL,
  `Pause_Avg` double NOT NULL,
  `Wait` int(11) NOT NULL,
  `Wait_Avg` double NOT NULL,
  `Dispo` int(11) NOT NULL,
  `Dispo_Avg` double NOT NULL,
  `Dead` int(11) NOT NULL,
  `Dead_Avg` double NOT NULL,
  `Call_Time` int(11) NOT NULL,
  `Call_Time_Avg` double NOT NULL,
  `St_Bestellung` int(11) NOT NULL,
  `St_Kundeninfo` int(11) NOT NULL,
  `St_Beschwerde` int(11) NOT NULL,
  `St_Erstberatung` int(11) NOT NULL,
  `St_Rechnung` int(11) NOT NULL,
  `St_Lieferung` int(11) NOT NULL,
  `St_AB` int(11) NOT NULL,
  `St_Nummer_ungueltig` int(11) NOT NULL,
  `St_Hangup` int(11) NOT NULL,
  `St_Keine_Antwort` int(11) NOT NULL,
  `St_Sale` int(11) NOT NULL,
  `St_Sare` int(11) NOT NULL,
  `St_Xfer` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=Aria AUTO_INCREMENT=1465 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
CREATE TABLE `WallBoardData` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
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
  `Dauer` bigint(20) NOT NULL DEFAULT 0,
  `next_uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `uniqueid` (`uniqueid`)
) ENGINE=Aria AUTO_INCREMENT=182713 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
CREATE TABLE `WallBoardData_archive` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
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
  `Dauer` bigint(20) NOT NULL DEFAULT 0,
  `next_uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `uniqueid` (`uniqueid`)
) ENGINE=Aria AUTO_INCREMENT=181600 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WallBoardStat` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `StandVom` datetime NOT NULL DEFAULT current_timestamp(),
  `Datum` date DEFAULT NULL,
  `Gruppe` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Kunden` bigint(20) DEFAULT 0,
  `Calls` bigint(20) DEFAULT 0,
  `phones` bigint(20) DEFAULT 0,
  `Drops` bigint(20) DEFAULT 0,
  `WL` bigint(20) DEFAULT 0,
  `AB` bigint(20) DEFAULT 0,
  `Agent` bigint(20) DEFAULT 0,
  `ebk` double DEFAULT 0,
  `kebk` double DEFAULT 0,
  `SL0` bigint(20) DEFAULT 0,
  `SL1` bigint(20) DEFAULT 0,
  `SL2` bigint(20) DEFAULT 0,
  `waittime` double DEFAULT 0,
  `Unbekannt` bigint(20) DEFAULT 0,
  `TKunden` bigint(20) NOT NULL DEFAULT 0,
  `TCalls` bigint(20) NOT NULL DEFAULT 0,
  `Tphones` bigint(20) NOT NULL DEFAULT 0,
  `TDrops` bigint(20) NOT NULL DEFAULT 0,
  `TWL` bigint(20) NOT NULL DEFAULT 0,
  `TAB` bigint(20) NOT NULL DEFAULT 0,
  `TAgent` bigint(20) NOT NULL DEFAULT 0,
  `Tebk` double NOT NULL DEFAULT 0,
  `Tkebk` double NOT NULL DEFAULT 0,
  `TSL0` bigint(20) NOT NULL DEFAULT 0,
  `TSL1` bigint(20) NOT NULL DEFAULT 0,
  `TSL2` bigint(20) NOT NULL DEFAULT 0,
  `Twaittime` double NOT NULL DEFAULT 0,
  `TUnbekannt` bigint(20) NOT NULL DEFAULT 0,
  `maxwaittime` bigint(20) NOT NULL DEFAULT 0,
  `Tmaxwaittime` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=Aria AUTO_INCREMENT=4825 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agent_did_phones` (
  `did` int(2) NOT NULL,
  `user` int(4) NOT NULL,
  `phone` int(2) NOT NULL
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agent_dids` (
  `did` int(2) NOT NULL,
  `user` int(4) NOT NULL,
  UNIQUE KEY `did_user` (`did`,`user`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audio_store_details` (
  `audio_filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `audio_format` varchar(10) COLLATE utf8_unicode_ci DEFAULT 'unknown',
  `audio_filesize` bigint(20) unsigned DEFAULT 0,
  `audio_epoch` bigint(20) unsigned DEFAULT 0,
  `audio_length` int(10) unsigned DEFAULT 0,
  UNIQUE KEY `audio_filename` (`audio_filename`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_log` (
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `channel_group` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `number_dialed` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `caller_code` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `start_epoch` int(10) DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `end_epoch` int(10) DEFAULT NULL,
  `length_in_sec` int(10) DEFAULT NULL,
  `length_in_min` double(8,2) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `caller_code` (`caller_code`),
  KEY `server_ip` (`server_ip`),
  KEY `channel` (`channel`),
  KEY `start_time` (`start_time`),
  KEY `end_time` (`end_time`),
  KEY `time` (`start_time`,`end_time`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_log_archive` (
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `channel_group` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `number_dialed` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `caller_code` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `start_epoch` int(10) DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `end_epoch` int(10) DEFAULT NULL,
  `length_in_sec` int(10) DEFAULT NULL,
  `length_in_min` double(8,2) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `caller_code` (`caller_code`),
  KEY `server_ip` (`server_ip`),
  KEY `channel` (`channel`),
  KEY `start_time` (`start_time`),
  KEY `end_time` (`end_time`),
  KEY `time` (`start_time`,`end_time`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `callcard_accounts` (
  `card_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `pin` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('GENERATE','PRINT','SHIP','HOLD','ACTIVE','USED','EMPTY','CANCEL','VOID') COLLATE utf8_unicode_ci DEFAULT 'GENERATE',
  `balance_minutes` smallint(5) DEFAULT 3,
  `inbound_group_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  PRIMARY KEY (`card_id`),
  KEY `pin` (`pin`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `callcard_accounts_details` (
  `card_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `run` varchar(4) COLLATE utf8_unicode_ci DEFAULT '',
  `batch` varchar(5) COLLATE utf8_unicode_ci DEFAULT '',
  `pack` varchar(5) COLLATE utf8_unicode_ci DEFAULT '',
  `sequence` varchar(5) COLLATE utf8_unicode_ci DEFAULT '',
  `status` enum('GENERATE','PRINT','SHIP','HOLD','ACTIVE','USED','EMPTY','CANCEL','VOID') COLLATE utf8_unicode_ci DEFAULT 'GENERATE',
  `balance_minutes` smallint(5) DEFAULT 3,
  `initial_value` varchar(6) COLLATE utf8_unicode_ci DEFAULT '0.00',
  `initial_minutes` smallint(5) DEFAULT 3,
  `note_purchase_order` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `note_printer` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `note_did` varchar(18) COLLATE utf8_unicode_ci DEFAULT '',
  `inbound_group_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `note_language` varchar(10) COLLATE utf8_unicode_ci DEFAULT 'English',
  `note_name` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `note_comments` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `create_user` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `activate_user` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `used_user` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `void_user` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `activate_time` datetime DEFAULT NULL,
  `used_time` datetime DEFAULT NULL,
  `void_time` datetime DEFAULT NULL,
  PRIMARY KEY (`card_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `callcard_log` (
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `card_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `balance_minutes_start` smallint(5) DEFAULT 3,
  `call_time` datetime DEFAULT NULL,
  `agent_time` datetime DEFAULT NULL,
  `dispo_time` datetime DEFAULT NULL,
  `agent` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `agent_dispo` varchar(6) COLLATE utf8_unicode_ci DEFAULT '',
  `agent_talk_sec` mediumint(8) DEFAULT 0,
  `agent_talk_min` mediumint(8) DEFAULT 0,
  `phone_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `inbound_did` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `card_id` (`card_id`),
  KEY `call_time` (`call_time`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cid_channels_recent` (
  `caller_id_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `connected_line_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_date` datetime DEFAULT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `dest_channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `linkedid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `dest_uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  KEY `call_date` (`call_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cid_channels_recent_010100000001` (
  `caller_id_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `connected_line_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `call_date` datetime DEFAULT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `dest_channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `linkedid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `dest_uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  KEY `call_date` (`call_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cid_channels_recent_010100000005` (
  `caller_id_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `connected_line_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `call_date` datetime DEFAULT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `dest_channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `linkedid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `dest_uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  KEY `call_date` (`call_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cid_channels_recent_010100000009` (
  `caller_id_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `connected_line_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `call_date` datetime DEFAULT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `dest_channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `linkedid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `dest_uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  KEY `call_date` (`call_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cid_channels_recent_010100000013` (
  `caller_id_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `connected_line_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `call_date` datetime DEFAULT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `dest_channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `linkedid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `dest_uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  KEY `call_date` (`call_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conferences` (
  `conf_exten` int(7) unsigned NOT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact_information` (
  `contact_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `last_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `office_num` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `cell_num` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `other_num1` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `other_num2` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `bu_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `department` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `group_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `job_title` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `location` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `office_num_phone_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT '',
  `cell_num_phone_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT '',
  `other_num1_phone_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT '',
  `other_num2_phone_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT '',
  PRIMARY KEY (`contact_id`),
  KEY `ci_first_name` (`first_name`),
  KEY `ci_last_name` (`last_name`)
) ENGINE=Aria AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dialable_inventory_snapshots` (
  `snapshot_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `snapshot_time` datetime DEFAULT NULL,
  `list_id` bigint(20) unsigned DEFAULT NULL,
  `list_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `list_description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `list_lastcalldate` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `list_start_inv` mediumint(8) unsigned DEFAULT NULL,
  `dialable_count` mediumint(8) unsigned DEFAULT NULL,
  `dialable_count_nofilter` mediumint(8) unsigned DEFAULT NULL,
  `dialable_count_oneoff` mediumint(8) unsigned DEFAULT NULL,
  `dialable_count_inactive` mediumint(8) unsigned DEFAULT NULL,
  `average_call_count` decimal(3,1) DEFAULT NULL,
  `penetration` decimal(5,2) DEFAULT NULL,
  `shift_data` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `time_setting` enum('LOCAL','SERVER') COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`snapshot_id`),
  UNIQUE KEY `snapshot_date_list_key` (`snapshot_time`,`list_id`,`time_setting`),
  KEY `snapshot_date_key` (`snapshot_time`)
) ENGINE=Aria AUTO_INCREMENT=1057645 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups_alias` (
  `group_alias_id` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `group_alias_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `caller_id_number` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `caller_id_name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  PRIMARY KEY (`group_alias_id`),
  UNIQUE KEY `group_alias_id` (`group_alias_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help_documentation` (
  `help_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `help_title` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `help_text` text COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`help_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `import_items` (
  `product_ID` int(11) DEFAULT NULL,
  `vendor_id` int(11) NOT NULL,
  `order_nr` char(32) CHARACTER SET utf8 NOT NULL,
  `description` varchar(512) COLLATE utf8_unicode_ci NOT NULL,
  `COG` char(16) COLLATE utf8_unicode_ci NOT NULL,
  `unit` char(16) COLLATE utf8_unicode_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `min_price` decimal(10,2) NOT NULL,
  `tax` decimal(10,2) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `sort_order` float(14,8) NOT NULL,
  `active` tinyint(4) NOT NULL
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inbound_email_attachments` (
  `attachment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email_row_id` int(10) unsigned DEFAULT NULL,
  `filename` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `file_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `file_encoding` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `file_size` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `file_extension` varchar(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `file_contents` longblob NOT NULL,
  PRIMARY KEY (`attachment_id`),
  KEY `attachments_email_id_key` (`email_row_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inbound_numbers` (
  `extension` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `full_number` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `inbound_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `department` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lead_info` (
  `info_id` int(11) NOT NULL AUTO_INCREMENT,
  `info_description` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `info_order` float(11,3) NOT NULL,
  PRIMARY KEY (`info_id`)
) ENGINE=Aria AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `leave_vm_message_groups` (
  `leave_vm_message_group_id` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `leave_vm_message_group_notes` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `active` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  PRIMARY KEY (`leave_vm_message_group_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `leave_vm_message_groups_entries` (
  `leave_vm_message_group_id` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `audio_filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `audio_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `rank` smallint(5) DEFAULT 0,
  `time_start` varchar(4) COLLATE utf8_unicode_ci DEFAULT '0000',
  `time_end` varchar(4) COLLATE utf8_unicode_ci DEFAULT '2400'
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `live_channels` (
  `channel` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `channel_group` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `channel_data` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `live_inbound` (
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `caller_id` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_ext` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `acknowledged` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `inbound_number` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment_a` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment_b` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment_c` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment_d` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment_e` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `live_inbound_log` (
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `caller_id` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_ext` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `acknowledged` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `inbound_number` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment_a` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment_b` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment_c` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment_d` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment_e` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `uniqueid` (`uniqueid`),
  KEY `phone_ext` (`phone_ext`),
  KEY `start_time` (`start_time`),
  KEY `comment_a` (`comment_a`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `live_sip_channels` (
  `channel` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `channel_group` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `channel_data` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nanpa_prefix_exchanges_fast` (
  `ac_prefix` char(7) COLLATE utf8_unicode_ci DEFAULT '',
  `type` char(1) COLLATE utf8_unicode_ci DEFAULT '',
  KEY `nanpaacprefix` (`ac_prefix`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nanpa_prefix_exchanges_master` (
  `areacode` char(3) COLLATE utf8_unicode_ci DEFAULT '',
  `prefix` char(4) COLLATE utf8_unicode_ci DEFAULT '',
  `source` char(1) COLLATE utf8_unicode_ci DEFAULT '',
  `type` char(1) COLLATE utf8_unicode_ci DEFAULT '',
  `tier` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `postal_code` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `new_areacode` char(3) COLLATE utf8_unicode_ci DEFAULT '',
  `tzcode` varchar(4) COLLATE utf8_unicode_ci DEFAULT '',
  `region` char(2) COLLATE utf8_unicode_ci DEFAULT ''
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nanpa_wired_to_wireless` (
  `phone` char(10) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`phone`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nanpa_wireless_to_wired` (
  `phone` char(10) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`phone`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `office` (
  `Wellcome` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `Wellcome2` varchar(1024) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_app` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_id` int(11) NOT NULL,
  `order_nr` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `amount` int(3) NOT NULL,
  `motiv` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `font` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `color` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `position` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `text` varchar(1064) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=Aria AUTO_INCREMENT=9220 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci PAGE_CHECKSUM=1 ROW_FORMAT=PAGE;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_campaign_to_vendor` (
  `campaign_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `vendor_id` int(11) NOT NULL,
  `add_vat` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci PAGE_CHECKSUM=1 ROW_FORMAT=PAGE;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_positions` (
  `position_ID` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_ID` int(11) NOT NULL,
  `product_ID` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  PRIMARY KEY (`position_ID`),
  KEY `TransID` (`transaction_ID`),
  KEY `Product_ID` (`product_ID`)
) ENGINE=Aria AUTO_INCREMENT=11664190 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_product_stock` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `vendor_id` int(11) NOT NULL,
  `order_nr` char(32) CHARACTER SET utf8 NOT NULL,
  `product_ID` int(11) DEFAULT NULL,
  `aktiv` tinyint(4) NOT NULL DEFAULT 1,
  `Date_from` date DEFAULT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `sell` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=Aria AUTO_INCREMENT=517 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci PAGE_CHECKSUM=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_products` (
  `product_ID` int(11) NOT NULL AUTO_INCREMENT,
  `vendor_id` int(20) NOT NULL,
  `order_nr` char(32) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(512) COLLATE utf8_unicode_ci NOT NULL,
  `COG` char(16) COLLATE utf8_unicode_ci NOT NULL,
  `unit` char(16) COLLATE utf8_unicode_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `min_price` decimal(10,2) NOT NULL,
  `tax` decimal(6,3) NOT NULL DEFAULT 19.000,
  `from_date` date NOT NULL DEFAULT '2000-01-01',
  `to_date` date NOT NULL DEFAULT '2100-12-31',
  `sort_order` float(14,8) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`product_ID`),
  KEY `Name` (`description`(333)),
  KEY `IdVendor` (`product_ID`,`vendor_id`)
) ENGINE=Aria AUTO_INCREMENT=85420 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_transaction` (
  `transaction_ID` int(11) NOT NULL AUTO_INCREMENT,
  `vendor_id` int(20) NOT NULL DEFAULT 1,
  `transaction_comment` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `lead_ID` bigint(20) unsigned NOT NULL,
  `transaction_nr` int(11) NOT NULL,
  `transaction_type` char(20) COLLATE utf8_unicode_ci NOT NULL,
  `transaction_date` datetime NOT NULL,
  `user_ID` int(11) NOT NULL,
  `storno` tinyint(1) NOT NULL DEFAULT 0,
  `from_date` date DEFAULT '2010-01-01',
  `to_date` date DEFAULT '2100-12-31',
  `total` decimal(10,2) DEFAULT NULL,
  `gross` decimal(10,2) DEFAULT NULL,
  `sort_order` float NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `address1` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `postal_code` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `city` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `fax` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `contact_person` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `department` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `delivery_address` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `prefix` int(11) NOT NULL,
  `order_status` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `modify_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `NewOrder` int(11) NOT NULL DEFAULT 0,
  `Freigabe` int(11) DEFAULT 0,
  `NoTransfer` tinyint(4) NOT NULL DEFAULT 0,
  `transfer` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`transaction_ID`),
  KEY `lead_ID` (`lead_ID`),
  KEY `UserDate` (`user_ID`,`transaction_date`),
  KEY `modify_date` (`modify_date`) USING BTREE,
  KEY `Package` (`active`,`transaction_type`,`vendor_id`,`from_date`,`to_date`),
  KEY `Trans-Type` (`transaction_type`),
  KEY `Selector` (`storno`,`active`,`deleted`,`transaction_type`,`modify_date`) USING BTREE,
  KEY `NewOrder` (`NewOrder`),
  KEY `Sele_TransDate` (`storno`,`active`,`deleted`,`transaction_type`,`transaction_date`),
  KEY `Freigabe` (`transaction_date`,`Freigabe`),
  KEY `Datum` (`transaction_date`)
) ENGINE=Aria AUTO_INCREMENT=318484 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_transaction_call` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) NOT NULL,
  `call_date` datetime NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MEMORY AUTO_INCREMENT=14809 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_vendors` (
  `vendor_id` int(11) NOT NULL AUTO_INCREMENT,
  `vendor_name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `report_period` set('day','week','month','year') COLLATE utf8_unicode_ci NOT NULL,
  `report_grouping` set('none','group_name') COLLATE utf8_unicode_ci NOT NULL,
  `short_name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`vendor_id`)
) ENGINE=Aria AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci PAGE_CHECKSUM=1 ROW_FORMAT=PAGE;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `park_log` (
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `status` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `channel_group` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parked_time` datetime DEFAULT NULL,
  `grab_time` datetime DEFAULT NULL,
  `hangup_time` datetime DEFAULT NULL,
  `parked_sec` int(10) DEFAULT NULL,
  `talked_sec` int(10) DEFAULT NULL,
  `extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT 0,
  KEY `parked_time` (`parked_time`),
  KEY `lead_id` (`lead_id`),
  KEY `uniqueid_park` (`uniqueid`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parked_channels` (
  `channel` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `channel_group` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parked_by` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parked_time` datetime DEFAULT NULL
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parked_channels_recent` (
  `channel` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `channel_group` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `park_end_time` datetime DEFAULT NULL,
  KEY `channel_group` (`channel_group`),
  KEY `park_end_time` (`park_end_time`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phone_favorites` (
  `extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extensions_list` text COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phones` (
  `extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dialplan_number` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `voicemail_id` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `computer_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `login` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pass` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_type` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fullname` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `picture` varchar(19) COLLATE utf8_unicode_ci DEFAULT NULL,
  `messages` int(4) DEFAULT NULL,
  `old_messages` int(4) DEFAULT NULL,
  `protocol` enum('SIP','Zap','IAX2','EXTERNAL') COLLATE utf8_unicode_ci DEFAULT 'SIP',
  `local_gmt` varchar(6) COLLATE utf8_unicode_ci DEFAULT '-5.00',
  `ASTmgrUSERNAME` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'cron',
  `ASTmgrSECRET` varchar(20) COLLATE utf8_unicode_ci DEFAULT '1234',
  `login_user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `login_pass` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `login_campaign` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `park_on_extension` varchar(10) COLLATE utf8_unicode_ci DEFAULT '8301',
  `conf_on_extension` varchar(10) COLLATE utf8_unicode_ci DEFAULT '8302',
  `VICIDIAL_park_on_extension` varchar(10) COLLATE utf8_unicode_ci DEFAULT '8301',
  `VICIDIAL_park_on_filename` varchar(10) COLLATE utf8_unicode_ci DEFAULT 'park',
  `monitor_prefix` varchar(10) COLLATE utf8_unicode_ci DEFAULT '8612',
  `recording_exten` varchar(10) COLLATE utf8_unicode_ci DEFAULT '8309',
  `voicemail_exten` varchar(10) COLLATE utf8_unicode_ci DEFAULT '8501',
  `voicemail_dump_exten` varchar(20) COLLATE utf8_unicode_ci DEFAULT '85026666666666',
  `ext_context` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'default',
  `dtmf_send_extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT 'local/8500998@default',
  `call_out_number_group` varchar(100) COLLATE utf8_unicode_ci DEFAULT 'Zap/g2/',
  `client_browser` varchar(100) COLLATE utf8_unicode_ci DEFAULT '/usr/bin/mozilla',
  `install_directory` varchar(100) COLLATE utf8_unicode_ci DEFAULT '/usr/local/perl_TK',
  `local_web_callerID_URL` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'http://astguiclient.sf.net/test_callerid_output.php',
  `VICIDIAL_web_URL` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'http://astguiclient.sf.net/test_VICIDIAL_output.php',
  `AGI_call_logging_enabled` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `user_switching_enabled` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `conferencing_enabled` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `admin_hangup_enabled` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `admin_hijack_enabled` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `admin_monitor_enabled` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `call_parking_enabled` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `updater_check_enabled` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `AFLogging_enabled` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `QUEUE_ACTION_enabled` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `CallerID_popup_enabled` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `voicemail_button_enabled` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `enable_fast_refresh` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `fast_refresh_rate` int(5) DEFAULT 1000,
  `enable_persistant_mysql` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `auto_dial_next_number` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `VDstop_rec_after_each_call` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `DBX_server` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DBX_database` varchar(15) COLLATE utf8_unicode_ci DEFAULT 'asterisk',
  `DBX_user` varchar(15) COLLATE utf8_unicode_ci DEFAULT 'cron',
  `DBX_pass` varchar(15) COLLATE utf8_unicode_ci DEFAULT '1234',
  `DBX_port` int(6) DEFAULT 3306,
  `DBY_server` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DBY_database` varchar(15) COLLATE utf8_unicode_ci DEFAULT 'asterisk',
  `DBY_user` varchar(15) COLLATE utf8_unicode_ci DEFAULT 'cron',
  `DBY_pass` varchar(15) COLLATE utf8_unicode_ci DEFAULT '1234',
  `DBY_port` int(6) DEFAULT 3306,
  `outbound_cid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `enable_sipsak_messages` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `template_id` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `conf_override` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_context` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'default',
  `phone_ring_timeout` smallint(3) DEFAULT 60,
  `conf_secret` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'test',
  `delete_vm_after_email` enum('N','Y') COLLATE utf8_unicode_ci DEFAULT 'N',
  `is_webphone` enum('Y','N','Y_API_LAUNCH') COLLATE utf8_unicode_ci DEFAULT 'N',
  `use_external_server_ip` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `codecs_list` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `codecs_with_template` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `webphone_dialpad` enum('Y','N','TOGGLE','TOGGLE_OFF') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `on_hook_agent` enum('Y','N','AutoAnswer') COLLATE utf8_unicode_ci DEFAULT 'N',
  `webphone_auto_answer` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `voicemail_timezone` varchar(30) COLLATE utf8_unicode_ci DEFAULT 'eastern',
  `voicemail_options` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  `voicemail_greeting` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `voicemail_dump_exten_no_inst` varchar(20) COLLATE utf8_unicode_ci DEFAULT '85026666666667',
  `voicemail_instructions` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `on_login_report` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `unavail_dialplan_fwd_exten` varchar(40) COLLATE utf8_unicode_ci DEFAULT '',
  `unavail_dialplan_fwd_context` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `nva_call_url` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `nva_search_method` varchar(40) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `nva_error_filename` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `nva_new_list_id` bigint(20) unsigned DEFAULT 995,
  `nva_new_phone_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT '1',
  `nva_new_status` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'NVAINS',
  `webphone_dialbox` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `webphone_mute` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `webphone_volume` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `webphone_debug` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `outbound_alt_cid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `conf_qualify` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `webphone_layout` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `autoanswer_type` enum('','SNOM') COLLATE utf8_unicode_ci DEFAULT '',
  `on_hook_auto_answer` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `auto_answer_sipheader` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `auto_answer_prefix` varchar(4) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `redirect_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `redirect_busy` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `redirect_timeout` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `redirect_notavailable` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `redirect_context` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'default',
  UNIQUE KEY `extenserver` (`extension`,`server_ip`),
  KEY `server_ip` (`server_ip`),
  KEY `pvmid` (`voicemail_id`),
  KEY `pdpn` (`dialplan_number`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phones_alias` (
  `alias_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `alias_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logins_list` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  PRIMARY KEY (`alias_id`),
  UNIQUE KEY `alias_id` (`alias_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recording_log` (
  `recording_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `start_epoch` int(10) unsigned DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `end_epoch` int(10) unsigned DEFAULT NULL,
  `length_in_sec` mediumint(8) unsigned DEFAULT NULL,
  `length_in_min` double(8,2) DEFAULT NULL,
  `filename` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vicidial_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`recording_id`),
  KEY `filename` (`filename`),
  KEY `lead_id` (`lead_id`),
  KEY `user` (`user`),
  KEY `vicidial_id` (`vicidial_id`),
  KEY `UserTime` (`user`,`start_time`)
) ENGINE=Aria AUTO_INCREMENT=14025556 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recording_log_archive` (
  `recording_id` int(10) unsigned NOT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `start_epoch` int(10) unsigned DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `end_epoch` int(10) unsigned DEFAULT NULL,
  `length_in_sec` mediumint(8) unsigned DEFAULT NULL,
  `length_in_min` double(8,2) DEFAULT NULL,
  `filename` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vicidial_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  UNIQUE KEY `recording_id` (`recording_id`),
  KEY `filename` (`filename`),
  KEY `lead_id` (`lead_id`),
  KEY `user` (`user`),
  KEY `vicidial_id` (`vicidial_id`),
  KEY `UserTime` (`user`,`start_time`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recording_log_deletion_queue` (
  `recording_id` int(9) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `filename` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_queued` datetime DEFAULT NULL,
  `date_deleted` datetime DEFAULT NULL,
  PRIMARY KEY (`recording_id`),
  KEY `date_deleted` (`date_deleted`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `routing_initiated_recordings` (
  `recording_id` int(10) unsigned NOT NULL,
  `filename` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `launch_time` datetime DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `vicidial_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `processed` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`recording_id`),
  KEY `lead_id` (`lead_id`),
  KEY `user` (`user`),
  KEY `processed` (`processed`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_performance` (
  `start_time` datetime NOT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `sysload` int(6) NOT NULL,
  `freeram` smallint(5) unsigned NOT NULL,
  `usedram` smallint(5) unsigned NOT NULL,
  `processes` smallint(4) unsigned NOT NULL,
  `channels_total` smallint(4) unsigned NOT NULL,
  `trunks_total` smallint(4) unsigned NOT NULL,
  `clients_total` smallint(4) unsigned NOT NULL,
  `clients_zap` smallint(4) unsigned NOT NULL,
  `clients_iax` smallint(4) unsigned NOT NULL,
  `clients_local` smallint(4) unsigned NOT NULL,
  `clients_sip` smallint(4) unsigned NOT NULL,
  `live_recordings` smallint(4) unsigned NOT NULL,
  `cpu_user_percent` smallint(3) unsigned NOT NULL DEFAULT 0,
  `cpu_system_percent` smallint(3) unsigned NOT NULL DEFAULT 0,
  `cpu_idle_percent` smallint(3) unsigned NOT NULL DEFAULT 0,
  `disk_reads` mediumint(7) DEFAULT NULL,
  `disk_writes` mediumint(7) DEFAULT NULL
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_updater` (
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `last_update` datetime DEFAULT NULL,
  `db_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servers` (
  `server_id` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `server_description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `active` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT NULL,
  `asterisk_version` varchar(20) COLLATE utf8_unicode_ci DEFAULT '1.4.21.1',
  `max_vicidial_trunks` smallint(4) DEFAULT 23,
  `telnet_host` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'localhost',
  `telnet_port` int(5) NOT NULL DEFAULT 5038,
  `ASTmgrUSERNAME` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'cron',
  `ASTmgrSECRET` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '1234',
  `ASTmgrUSERNAMEupdate` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'updatecron',
  `ASTmgrUSERNAMElisten` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'listencron',
  `ASTmgrUSERNAMEsend` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'sendcron',
  `local_gmt` varchar(6) COLLATE utf8_unicode_ci DEFAULT '-5.00',
  `voicemail_dump_exten` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '85026666666666',
  `answer_transfer_agent` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '8365',
  `ext_context` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'default',
  `sys_perf_log` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `vd_server_logs` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `agi_output` enum('NONE','STDERR','FILE','BOTH') COLLATE utf8_unicode_ci DEFAULT 'FILE',
  `vicidial_balance_active` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `balance_trunks_offlimits` smallint(5) unsigned DEFAULT 0,
  `recording_web_link` enum('SERVER_IP','ALT_IP','EXTERNAL_IP') COLLATE utf8_unicode_ci DEFAULT 'SERVER_IP',
  `alt_server_ip` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `active_asterisk_server` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `generate_vicidial_conf` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `rebuild_conf_files` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `outbound_calls_per_second` smallint(3) unsigned DEFAULT 20,
  `sysload` int(6) NOT NULL DEFAULT 0,
  `channels_total` smallint(4) unsigned NOT NULL DEFAULT 0,
  `cpu_idle_percent` smallint(3) unsigned NOT NULL DEFAULT 0,
  `disk_usage` varchar(255) COLLATE utf8_unicode_ci DEFAULT '1',
  `sounds_update` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `vicidial_recording_limit` mediumint(8) DEFAULT 60,
  `carrier_logging_active` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `vicidial_balance_rank` tinyint(3) unsigned DEFAULT 0,
  `rebuild_music_on_hold` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `active_agent_login_server` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `conf_secret` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'test',
  `external_server_ip` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `custom_dialplan_entry` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `active_twin_server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT '',
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  `audio_store_purge` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `svn_revision` int(9) DEFAULT 0,
  `svn_info` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `system_uptime` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `auto_restart_asterisk` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `asterisk_temp_no_restart` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `voicemail_dump_exten_no_inst` varchar(20) COLLATE utf8_unicode_ci DEFAULT '85026666666667',
  `gather_asterisk_output` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `web_socket_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `conf_qualify` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `routing_prefix` varchar(10) COLLATE utf8_unicode_ci DEFAULT '13',
  `git_commit` varchar(55) COLLATE utf8_unicode_ci DEFAULT '',
  `git_release` varchar(25) COLLATE utf8_unicode_ci DEFAULT '',
  `external_web_socket_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  UNIQUE KEY `server_id` (`server_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `snctdialer-acr_select` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `uniqueid` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `lead_id` bigint(20) NOT NULL,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `acr_id` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `snctdialer-after_call_action` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Beschreibung` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `aktiv` enum('N','Y') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `Type` enum('Survey','') COLLATE utf8_unicode_ci NOT NULL,
  `Announcement_file` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Call_Menue` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=Aria AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `snctdialer-live` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Station` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `Phone` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `User` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `UserName` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `UserGrp` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `SessionID` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `Status` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `SubStatus` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `Pause` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `CustomPhone` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `ServerIP` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `CallServerIP` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `Time` time NOT NULL,
  `Campaign` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `Calls` int(11) NOT NULL,
  `Hold` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `Ingroup` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `invalid` int(11) NOT NULL DEFAULT 0,
  `SortStatus` int(11) NOT NULL DEFAULT 0,
  `Stand_vom` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UserID` (`User`),
  KEY `Sort` (`SortStatus`,`Time`) USING HASH
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `snctdialer_acr_select` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `uniqueid` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `lead_id` bigint(20) NOT NULL,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `acr_id` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MEMORY AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `snctdialer_after_call_action` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Beschreibung` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `aktiv` enum('N','Y') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `Type` enum('Survey','') COLLATE utf8_unicode_ci NOT NULL,
  `Announcement_file` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Call_Menue` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=Aria AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `snctdialer_list_log` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `LeadID` bigint(20) NOT NULL,
  `Change_date` datetime NOT NULL DEFAULT current_timestamp(),
  `Old_Listid` bigint(20) NOT NULL,
  `New_Listid` int(11) NOT NULL,
  `Old_Owner` varchar(20) NOT NULL,
  `New_Owner` varchar(20) NOT NULL,
  `Old_Status` varchar(6) NOT NULL,
  `New_Status` varchar(6) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `LeadID` (`LeadID`),
  KEY `LeadID_Date` (`LeadID`,`Change_date`)
) ENGINE=Aria AUTO_INCREMENT=1228717 DEFAULT CHARSET=utf8 CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `snctdialer_live` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Station` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `Phone` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `User` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `UserName` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `UserGrp` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `SessionID` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `Status` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `SubStatus` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `Pause` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `CustomPhone` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `ServerIP` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `CallServerIP` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `Time` time NOT NULL,
  `Campaign` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `Calls` int(11) NOT NULL,
  `Hold` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `Ingroup` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `invalid` int(11) NOT NULL DEFAULT 0,
  `SortStatus` int(11) NOT NULL DEFAULT 0,
  `Stand_vom` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UserID` (`User`),
  KEY `Sort` (`SortStatus`,`Time`) USING HASH
) ENGINE=MEMORY AUTO_INCREMENT=340 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_settings` (
  `version` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `install_date` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `use_non_latin` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `webroot_writable` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `enable_queuemetrics_logging` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `queuemetrics_server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `queuemetrics_dbname` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `queuemetrics_login` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `queuemetrics_pass` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `queuemetrics_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `queuemetrics_log_id` varchar(10) COLLATE utf8_unicode_ci DEFAULT 'VIC',
  `queuemetrics_eq_prepend` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `vicidial_agent_disable` enum('NOT_ACTIVE','LIVE_AGENT','EXTERNAL','ALL') COLLATE utf8_unicode_ci DEFAULT 'ALL',
  `allow_sipsak_messages` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `admin_home_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT '../vicidial/welcome.php',
  `enable_agc_xfer_log` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `db_schema_version` int(8) unsigned DEFAULT 0,
  `auto_user_add_value` int(9) unsigned DEFAULT 101,
  `timeclock_end_of_day` varchar(4) COLLATE utf8_unicode_ci DEFAULT '0000',
  `timeclock_last_reset_date` date DEFAULT NULL,
  `vdc_header_date_format` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'MS_DASH_24HR  2008-06-24 23:59:59',
  `vdc_customer_date_format` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'AL_TEXT_AMPM  OCT 24, 2008 11:59:59 PM',
  `vdc_header_phone_format` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'US_PARN (000)000-0000',
  `vdc_agent_api_active` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `qc_last_pull_time` datetime DEFAULT NULL,
  `enable_vtiger_integration` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `vtiger_server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vtiger_dbname` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vtiger_login` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vtiger_pass` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vtiger_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qc_features_active` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `outbound_autodial_active` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '1',
  `outbound_calls_per_second` smallint(3) unsigned DEFAULT 40,
  `enable_tts_integration` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `agentonly_callback_campaign_lock` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `sounds_central_control_active` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `sounds_web_server` varchar(50) COLLATE utf8_unicode_ci DEFAULT '127.0.0.1',
  `sounds_web_directory` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `active_voicemail_server` varchar(15) COLLATE utf8_unicode_ci DEFAULT '',
  `auto_dial_limit` varchar(5) COLLATE utf8_unicode_ci DEFAULT '4',
  `user_territories_active` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `allow_custom_dialplan` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `db_schema_update_date` datetime DEFAULT NULL,
  `enable_second_webform` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `default_webphone` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `default_external_server_ip` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `webphone_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `static_agent_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `default_phone_code` varchar(8) COLLATE utf8_unicode_ci DEFAULT '1',
  `enable_agc_dispo_log` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `custom_dialplan_entry` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `queuemetrics_loginout` enum('STANDARD','CALLBACK','NONE') COLLATE utf8_unicode_ci DEFAULT 'STANDARD',
  `callcard_enabled` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `queuemetrics_callstatus` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `default_codecs` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `custom_fields_enabled` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `admin_web_directory` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'vicidial',
  `label_title` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_first_name` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_middle_initial` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_last_name` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_address1` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_address2` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_address3` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_city` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_state` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_province` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_postal_code` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_vendor_lead_code` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_gender` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_phone_number` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_phone_code` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_alt_phone` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_security_phrase` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_email` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_comments` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `slave_db_server` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `reports_use_slave_db` varchar(2000) COLLATE utf8_unicode_ci DEFAULT '',
  `webphone_systemkey` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `first_login_trigger` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `hosted_settings` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `default_phone_registration_password` varchar(100) COLLATE utf8_unicode_ci DEFAULT 'test',
  `default_phone_login_password` varchar(100) COLLATE utf8_unicode_ci DEFAULT 'test',
  `default_server_password` varchar(100) COLLATE utf8_unicode_ci DEFAULT 'test',
  `admin_modify_refresh` smallint(5) unsigned DEFAULT 0,
  `nocache_admin` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `generate_cross_server_exten` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `queuemetrics_addmember_enabled` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `queuemetrics_dispo_pause` varchar(6) COLLATE utf8_unicode_ci DEFAULT '',
  `label_hide_field_logs` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'Y',
  `queuemetrics_pe_phone_append` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `test_campaign_calls` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `agents_calls_reset` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `voicemail_timezones` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `default_voicemail_timezone` varchar(30) COLLATE utf8_unicode_ci DEFAULT 'eastern',
  `default_local_gmt` varchar(6) COLLATE utf8_unicode_ci DEFAULT '-5.00',
  `noanswer_log` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `alt_log_server_ip` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `alt_log_dbname` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `alt_log_login` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `alt_log_pass` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `tables_use_alt_log_db` varchar(2000) COLLATE utf8_unicode_ci DEFAULT '',
  `did_agent_log` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `campaign_cid_areacodes_enabled` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `pllb_grouping_limit` smallint(5) DEFAULT 100,
  `did_ra_extensions_enabled` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `expanded_list_stats` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `contacts_enabled` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `svn_version` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `call_menu_qualify_enabled` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `admin_list_counts` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `allow_voicemail_greeting` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `audio_store_purge` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `svn_revision` int(9) DEFAULT 0,
  `queuemetrics_socket` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `queuemetrics_socket_url` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `enhanced_disconnect_logging` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `allow_emails` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `level_8_disable_add` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `pass_hash_enabled` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `pass_key` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `pass_cost` tinyint(2) unsigned DEFAULT 2,
  `disable_auto_dial` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `queuemetrics_record_hold` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `country_code_list_stats` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `reload_timestamp` datetime DEFAULT NULL,
  `queuemetrics_pause_type` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `frozen_server_call_clear` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `callback_time_24hour` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `active_modules` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `allow_chats` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `enable_languages` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `language_method` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `meetme_enter_login_filename` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `meetme_enter_leave3way_filename` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `enable_did_entry_list_id` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `enable_third_webform` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `chat_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `chat_timeout` int(3) unsigned DEFAULT NULL,
  `agent_debug_logging` varchar(20) COLLATE utf8_unicode_ci DEFAULT '0',
  `default_language` varchar(100) COLLATE utf8_unicode_ci DEFAULT 'default English',
  `agent_whisper_enabled` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `user_hide_realtime_enabled` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `custom_reports_use_slave_db` varchar(2000) COLLATE utf8_unicode_ci DEFAULT '',
  `usacan_phone_dialcode_fix` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `cache_carrier_stats_realtime` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `oldest_logs_date` datetime DEFAULT NULL,
  `log_recording_access` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `report_default_format` enum('TEXT','HTML') COLLATE utf8_unicode_ci DEFAULT 'TEXT',
  `alt_ivr_logging` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `admin_row_click` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `admin_screen_colors` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'default',
  `ofcom_uk_drop_calc` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `agent_screen_colors` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'default',
  `script_remove_js` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '1',
  `manual_auto_next` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `user_new_lead_limit` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `agent_xfer_park_3way` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `rec_prompt_count` int(9) unsigned DEFAULT 0,
  `agent_soundboards` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `web_loader_phone_length` varchar(10) COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `agent_script` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'vicidial.php',
  `vdad_debug_logging` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `agent_chat_screen_colors` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'default',
  `enable_auto_reports` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `enable_pause_code_limits` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `enable_drop_lists` enum('0','1','2') COLLATE utf8_unicode_ci DEFAULT '0',
  `allow_ip_lists` enum('0','1','2') COLLATE utf8_unicode_ci DEFAULT '0',
  `system_ip_blacklist` varchar(30) COLLATE utf8_unicode_ci DEFAULT '',
  `git_commit` varchar(55) COLLATE utf8_unicode_ci DEFAULT '',
  `git_release` varchar(25) COLLATE utf8_unicode_ci DEFAULT '',
  `agent_push_events` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `agent_push_url` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `pause_campaigns` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `hide_inactive_lists` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `detect_3way` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `company_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `ticket_mail` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `allow_manage_active_lists` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `expired_lists_inactive` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `did_system_filter` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `allow_phonebook` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `servicelevel_direct` smallint(5) unsigned DEFAULT 4,
  `servicelevel_one` smallint(5) unsigned DEFAULT 20,
  `servicelevel_two` smallint(5) unsigned DEFAULT 40,
  `anyone_callback_inactive_lists` enum('default','NO_ADD_TO_HOPPER','KEEP_IN_HOPPER') COLLATE utf8_unicode_ci DEFAULT 'default',
  `tmp_download_dir` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'download',
  `enable_gdpr_download_deletion` enum('0','1','2') COLLATE utf8_unicode_ci DEFAULT '0',
  `agent_prefix` varchar(3) COLLATE utf8_unicode_ci DEFAULT '',
  `autoanswer_enable` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `autoanswer_prefix` varchar(5) COLLATE utf8_unicode_ci DEFAULT 'AA',
  `autoanswer_delay` tinyint(4) DEFAULT 1,
  `source_id_display` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `help_modification_date` varchar(20) COLLATE utf8_unicode_ci DEFAULT '0',
  `agent_logout_link` enum('0','1','2','3','4') COLLATE utf8_unicode_ci DEFAULT '1',
  `manual_dial_validation` enum('0','1','2','3','4') COLLATE utf8_unicode_ci DEFAULT '0',
  `mute_recordings` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `user_admin_redirect` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `list_status_modification_confirmation` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `sip_event_logging` enum('0','1','2','3','4','5','6','7') COLLATE utf8_unicode_ci DEFAULT '0',
  `call_quota_lead_ranking` enum('0','1','2') COLLATE utf8_unicode_ci DEFAULT '0',
  `enable_second_script` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `default_po_language` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'en_EN',
  `show_archive` tinyint(4) NOT NULL DEFAULT 0,
  `show_newdispo` enum('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thirty_days` (
  `lead_ID` int(11) NOT NULL
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `twoday_call_log` (
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `channel_group` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `number_dialed` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `caller_code` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `start_epoch` int(10) DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `end_epoch` int(10) DEFAULT NULL,
  `length_in_sec` int(10) DEFAULT NULL,
  `length_in_min` double(8,2) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `caller_code` (`caller_code`),
  KEY `server_ip` (`server_ip`),
  KEY `channel` (`channel`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `twoday_recording_log` (
  `recording_id` int(10) unsigned NOT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `start_epoch` int(10) unsigned DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `end_epoch` int(10) unsigned DEFAULT NULL,
  `length_in_sec` mediumint(8) unsigned DEFAULT NULL,
  `length_in_min` double(8,2) DEFAULT NULL,
  `filename` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vicidial_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`recording_id`),
  KEY `filename` (`filename`),
  KEY `lead_id` (`lead_id`),
  KEY `user` (`user`),
  KEY `vicidial_id` (`vicidial_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `twoday_vicidial_agent_log` (
  `agent_log_id` int(9) unsigned NOT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `event_time` datetime DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pause_epoch` int(10) unsigned DEFAULT NULL,
  `pause_sec` smallint(5) unsigned DEFAULT 0,
  `wait_epoch` int(10) unsigned DEFAULT NULL,
  `wait_sec` smallint(5) unsigned DEFAULT 0,
  `talk_epoch` int(10) unsigned DEFAULT NULL,
  `talk_sec` smallint(5) unsigned DEFAULT 0,
  `dispo_epoch` int(10) unsigned DEFAULT NULL,
  `dispo_sec` smallint(5) unsigned DEFAULT 0,
  `status` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comments` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sub_status` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dead_epoch` int(10) unsigned DEFAULT NULL,
  `dead_sec` smallint(5) unsigned DEFAULT 0,
  `processed` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  PRIMARY KEY (`agent_log_id`),
  KEY `lead_id` (`lead_id`),
  KEY `user` (`user`),
  KEY `event_time` (`event_time`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `twoday_vicidial_closer_log` (
  `closecallid` int(9) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `list_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_date` datetime DEFAULT NULL,
  `start_epoch` int(10) unsigned DEFAULT NULL,
  `end_epoch` int(10) unsigned DEFAULT NULL,
  `length_in_sec` int(10) DEFAULT NULL,
  `status` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comments` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `processed` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT NULL,
  `queue_seconds` decimal(7,2) DEFAULT 0.00,
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `xfercallid` int(9) unsigned DEFAULT NULL,
  `term_reason` enum('CALLER','AGENT','QUEUETIMEOUT','ABANDON','AFTERHOURS','HOLDRECALLXFER','HOLDTIME','NOAGENT','NONE') COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `agent_only` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  PRIMARY KEY (`closecallid`),
  KEY `lead_id` (`lead_id`),
  KEY `call_date` (`call_date`),
  KEY `campaign_id` (`campaign_id`),
  KEY `uniqueid` (`uniqueid`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `twoday_vicidial_log` (
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `list_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_date` datetime DEFAULT NULL,
  `start_epoch` int(10) unsigned DEFAULT NULL,
  `end_epoch` int(10) unsigned DEFAULT NULL,
  `length_in_sec` int(10) DEFAULT NULL,
  `status` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comments` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `processed` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `term_reason` enum('CALLER','AGENT','QUEUETIMEOUT','ABANDON','AFTERHOURS','NONE','SYSTEM') COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `alt_dial` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  PRIMARY KEY (`uniqueid`),
  KEY `lead_id` (`lead_id`),
  KEY `call_date` (`call_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `twoday_vicidial_xfer_log` (
  `xfercallid` int(9) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `list_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_date` datetime DEFAULT NULL,
  `phone_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `closer` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`xfercallid`),
  KEY `lead_id` (`lead_id`),
  KEY `call_date` (`call_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_call_log` (
  `user_call_log_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_date` datetime DEFAULT NULL,
  `call_type` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `phone_number` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `number_dialed` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `callerid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `group_alias_id` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `preset_name` varchar(40) COLLATE utf8_unicode_ci DEFAULT '',
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `customer_hungup` enum('BEFORE_CALL','DURING_CALL','') COLLATE utf8_unicode_ci DEFAULT '',
  `customer_hungup_seconds` smallint(5) unsigned DEFAULT 0,
  `xfer_hungup` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `xfer_hungup_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`user_call_log_id`),
  KEY `user` (`user`),
  KEY `call_date` (`call_date`),
  KEY `group_alias_id` (`group_alias_id`)
) ENGINE=Aria AUTO_INCREMENT=3856240 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_call_log_archive` (
  `user_call_log_id` int(9) unsigned NOT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_date` datetime DEFAULT NULL,
  `call_type` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `phone_number` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `number_dialed` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `callerid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `group_alias_id` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `preset_name` varchar(40) COLLATE utf8_unicode_ci DEFAULT '',
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `customer_hungup` enum('BEFORE_CALL','DURING_CALL','') COLLATE utf8_unicode_ci DEFAULT '',
  `customer_hungup_seconds` smallint(5) unsigned DEFAULT 0,
  `xfer_hungup` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `xfer_hungup_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`user_call_log_id`),
  KEY `user` (`user`),
  KEY `call_date` (`call_date`),
  KEY `group_alias_id` (`group_alias_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_admin_log` (
  `admin_log_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `event_date` datetime NOT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `ip_address` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `event_section` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `event_type` enum('ADD','COPY','LOAD','RESET','MODIFY','DELETE','SEARCH','LOGIN','LOGOUT','CLEAR','OVERRIDE','EXPORT','OTHER') COLLATE utf8_unicode_ci DEFAULT 'OTHER',
  `record_id` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `event_code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `event_sql` mediumtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_notes` mediumtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  PRIMARY KEY (`admin_log_id`),
  KEY `user` (`user`),
  KEY `event_section` (`event_section`),
  KEY `record_id` (`record_id`)
) ENGINE=Aria AUTO_INCREMENT=2008543 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_agent_function_log` (
  `agent_function_log_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `agent_log_id` int(9) unsigned DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `function` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_time` datetime DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `caller_code` varchar(30) COLLATE utf8_unicode_ci DEFAULT '',
  `comments` varchar(40) COLLATE utf8_unicode_ci DEFAULT '',
  `stage` varchar(40) COLLATE utf8_unicode_ci DEFAULT '',
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  PRIMARY KEY (`agent_function_log_id`),
  KEY `event_time` (`event_time`),
  KEY `caller_code` (`caller_code`),
  KEY `user` (`user`),
  KEY `lead_id` (`lead_id`),
  KEY `stage` (`stage`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_agent_function_log_archive` (
  `agent_function_log_id` int(9) unsigned NOT NULL,
  `agent_log_id` int(9) unsigned DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `function` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_time` datetime DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `caller_code` varchar(30) COLLATE utf8_unicode_ci DEFAULT '',
  `comments` varchar(40) COLLATE utf8_unicode_ci DEFAULT '',
  `stage` varchar(40) COLLATE utf8_unicode_ci DEFAULT '',
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  PRIMARY KEY (`agent_function_log_id`),
  KEY `event_time` (`event_time`),
  KEY `caller_code` (`caller_code`),
  KEY `user` (`user`),
  KEY `lead_id` (`lead_id`),
  KEY `stage` (`stage`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_agent_log` (
  `agent_log_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `event_time` datetime DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pause_epoch` int(10) unsigned DEFAULT NULL,
  `pause_sec` smallint(5) unsigned DEFAULT 0,
  `wait_epoch` int(10) unsigned DEFAULT NULL,
  `wait_sec` smallint(5) unsigned DEFAULT 0,
  `talk_epoch` int(10) unsigned DEFAULT NULL,
  `talk_sec` smallint(5) unsigned DEFAULT 0,
  `dispo_epoch` int(10) unsigned DEFAULT NULL,
  `dispo_sec` smallint(5) unsigned DEFAULT 0,
  `status` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comments` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sub_status` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dead_epoch` int(10) unsigned DEFAULT NULL,
  `dead_sec` smallint(5) unsigned DEFAULT 0,
  `processed` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `pause_type` enum('UNDEFINED','SYSTEM','AGENT','API','ADMIN') COLLATE utf8_unicode_ci DEFAULT 'UNDEFINED',
  `pause_campaign` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `pause_code` varchar(6) COLLATE utf8_unicode_ci DEFAULT '',
  PRIMARY KEY (`agent_log_id`),
  KEY `lead_id` (`lead_id`),
  KEY `user` (`user`),
  KEY `event_time` (`event_time`),
  KEY `time_user` (`event_time`,`user`),
  KEY `uniqueid` (`uniqueid`,`lead_id`),
  KEY `Status` (`status`),
  KEY `time_lead` (`event_time`,`lead_id`),
  KEY `UserStatTimeIdx` (`user`,`status`,`event_time`)
) ENGINE=Aria AUTO_INCREMENT=20021041 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_agent_log_archive` (
  `agent_log_id` int(9) unsigned NOT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `event_time` datetime DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pause_epoch` int(10) unsigned DEFAULT NULL,
  `pause_sec` smallint(5) unsigned DEFAULT 0,
  `wait_epoch` int(10) unsigned DEFAULT NULL,
  `wait_sec` smallint(5) unsigned DEFAULT 0,
  `talk_epoch` int(10) unsigned DEFAULT NULL,
  `talk_sec` smallint(5) unsigned DEFAULT 0,
  `dispo_epoch` int(10) unsigned DEFAULT NULL,
  `dispo_sec` smallint(5) unsigned DEFAULT 0,
  `status` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comments` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sub_status` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dead_epoch` int(10) unsigned DEFAULT NULL,
  `dead_sec` smallint(5) unsigned DEFAULT 0,
  `processed` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `pause_type` enum('UNDEFINED','SYSTEM','AGENT','API','ADMIN') COLLATE utf8_unicode_ci DEFAULT 'UNDEFINED',
  `pause_campaign` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `pause_code` varchar(6) COLLATE utf8_unicode_ci DEFAULT '',
  PRIMARY KEY (`agent_log_id`),
  KEY `lead_id` (`lead_id`),
  KEY `user` (`user`),
  KEY `event_time` (`event_time`),
  KEY `time_user` (`event_time`,`user`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_agent_skip_log` (
  `user_skip_log_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_date` datetime DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `previous_status` varchar(6) COLLATE utf8_unicode_ci DEFAULT '',
  `previous_called_count` smallint(5) unsigned DEFAULT 0,
  PRIMARY KEY (`user_skip_log_id`),
  KEY `user` (`user`),
  KEY `event_date` (`event_date`),
  KEY `campaign_id` (`campaign_id`)
) ENGINE=Aria AUTO_INCREMENT=233206 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_agent_sph` (
  `campaign_group_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `stat_date` date NOT NULL,
  `shift` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `role` enum('FRONTER','CLOSER') COLLATE utf8_unicode_ci DEFAULT 'FRONTER',
  `user` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `calls` mediumint(8) unsigned DEFAULT 0,
  `sales` mediumint(8) unsigned DEFAULT 0,
  `login_sec` mediumint(8) unsigned DEFAULT 0,
  `login_hours` decimal(5,2) DEFAULT 0.00,
  `sph` decimal(6,2) DEFAULT 0.00,
  KEY `campaign_group_id` (`campaign_group_id`),
  KEY `stat_date` (`stat_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_agent_vmm_overrides` (
  `call_date` datetime DEFAULT NULL,
  `caller_code` varchar(30) COLLATE utf8_unicode_ci DEFAULT '',
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `vm_message` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  KEY `caller_code` (`caller_code`),
  KEY `call_date` (`call_date`),
  KEY `lead_id` (`lead_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_ajax_log` (
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `start_time` datetime NOT NULL,
  `db_time` datetime NOT NULL,
  `run_time` varchar(20) COLLATE utf8_unicode_ci DEFAULT '0',
  `php_script` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `action` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `stage` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `session_name` varchar(40) COLLATE utf8_unicode_ci DEFAULT '',
  `last_sql` text COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `ajax_dbtime_key` (`db_time`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_amd_log` (
  `call_date` datetime DEFAULT NULL,
  `caller_code` varchar(30) COLLATE utf8_unicode_ci DEFAULT '',
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `server_ip` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `AMDSTATUS` varchar(10) COLLATE utf8_unicode_ci DEFAULT '',
  `AMDRESPONSE` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `AMDCAUSE` varchar(30) COLLATE utf8_unicode_ci DEFAULT '',
  `run_time` varchar(20) COLLATE utf8_unicode_ci DEFAULT '0',
  `AMDSTATS` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  KEY `call_date` (`call_date`),
  KEY `lead_id` (`lead_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_amd_log_archive` (
  `call_date` datetime DEFAULT NULL,
  `caller_code` varchar(30) COLLATE utf8_unicode_ci DEFAULT '',
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `server_ip` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `AMDSTATUS` varchar(10) COLLATE utf8_unicode_ci DEFAULT '',
  `AMDRESPONSE` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `AMDCAUSE` varchar(30) COLLATE utf8_unicode_ci DEFAULT '',
  `run_time` varchar(20) COLLATE utf8_unicode_ci DEFAULT '0',
  `AMDSTATS` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  UNIQUE KEY `amd_unq_key` (`uniqueid`,`call_date`,`lead_id`),
  KEY `call_date` (`call_date`),
  KEY `lead_id` (`lead_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_amm_multi` (
  `amm_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `entry_type` enum('campaign','ingroup','list','') COLLATE utf8_unicode_ci DEFAULT '',
  `active` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `amm_field` varchar(30) COLLATE utf8_unicode_ci DEFAULT 'vendor_lead_code',
  `amm_rank` smallint(5) DEFAULT 1,
  `amm_wildcard` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `amm_filename` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `amm_description` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  PRIMARY KEY (`amm_id`),
  KEY `vicidial_AMM_multi_campaign_id_key` (`campaign_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_api_log` (
  `api_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `user` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `api_date` datetime DEFAULT NULL,
  `api_script` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `function` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `agent_user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `result` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `result_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `run_time` varchar(20) COLLATE utf8_unicode_ci DEFAULT '0',
  `webserver` smallint(5) unsigned DEFAULT 0,
  `api_url` int(9) unsigned DEFAULT 0,
  PRIMARY KEY (`api_id`),
  KEY `api_date` (`api_date`)
) ENGINE=Aria AUTO_INCREMENT=707545 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_api_log_archive` (
  `api_id` int(9) unsigned NOT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `api_date` datetime DEFAULT NULL,
  `api_script` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `function` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `agent_user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `result` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `result_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `run_time` varchar(20) COLLATE utf8_unicode_ci DEFAULT '0',
  `webserver` smallint(5) unsigned DEFAULT 0,
  `api_url` int(9) unsigned DEFAULT 0,
  PRIMARY KEY (`api_id`),
  KEY `api_date` (`api_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_api_urls` (
  `api_id` int(9) unsigned NOT NULL,
  `api_date` datetime DEFAULT NULL,
  `remote_ip` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` mediumtext COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`api_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_api_urls_archive` (
  `api_id` int(9) unsigned NOT NULL,
  `api_date` datetime DEFAULT NULL,
  `remote_ip` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` mediumtext COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`api_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_areacode_filters` (
  `group_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `areacode` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  KEY `group_id` (`group_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_asterisk_output` (
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `sip_peers` mediumtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `iax_peers` mediumtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `asterisk` mediumtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  UNIQUE KEY `server_ip` (`server_ip`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_auto_calls` (
  `auto_call_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('SENT','RINGING','LIVE','XFER','PAUSED','CLOSER','BUSY','DISCONNECT','IVR') COLLATE utf8_unicode_ci DEFAULT 'PAUSED',
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `callerid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_time` datetime DEFAULT NULL,
  `call_type` enum('IN','OUT','OUTBALANCE') COLLATE utf8_unicode_ci DEFAULT 'OUT',
  `stage` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'START',
  `last_update_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `alt_dial` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `queue_priority` tinyint(2) DEFAULT 0,
  `agent_only` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `agent_grab` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `queue_position` smallint(4) unsigned DEFAULT 1,
  `extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `agent_grab_extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  PRIMARY KEY (`auto_call_id`),
  KEY `uniqueid` (`uniqueid`),
  KEY `callerid` (`callerid`),
  KEY `call_time` (`call_time`),
  KEY `last_update_time` (`last_update_time`)
) ENGINE=MEMORY AUTO_INCREMENT=26242 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_automated_reports` (
  `report_id` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `report_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `report_last_run` datetime DEFAULT NULL,
  `report_last_length` smallint(5) DEFAULT 0,
  `report_server` varchar(30) COLLATE utf8_unicode_ci DEFAULT 'active_voicemail_server',
  `report_times` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `report_weekdays` varchar(7) COLLATE utf8_unicode_ci DEFAULT '',
  `report_monthdays` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `report_destination` enum('EMAIL','FTP') COLLATE utf8_unicode_ci DEFAULT 'EMAIL',
  `email_from` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `email_to` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `email_subject` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `ftp_server` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `ftp_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `ftp_pass` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `ftp_directory` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `report_url` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `run_now_trigger` enum('N','Y') COLLATE utf8_unicode_ci DEFAULT 'N',
  `active` enum('N','Y') COLLATE utf8_unicode_ci DEFAULT 'N',
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  `filename_override` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  UNIQUE KEY `report_id` (`report_id`),
  KEY `report_times` (`report_times`),
  KEY `run_now_trigger` (`run_now_trigger`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_avatar_audio` (
  `avatar_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `audio_filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `audio_name` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `rank` smallint(5) DEFAULT 0,
  `h_ord` smallint(5) DEFAULT 1,
  `level` smallint(5) DEFAULT 1,
  `parent_audio_filename` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `parent_rank` varchar(2) COLLATE utf8_unicode_ci DEFAULT '',
  `button_type` varchar(40) COLLATE utf8_unicode_ci DEFAULT 'button',
  `font_size` varchar(3) COLLATE utf8_unicode_ci DEFAULT '2',
  KEY `avatar_id` (`avatar_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_avatars` (
  `avatar_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `avatar_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `avatar_notes` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `avatar_api_user` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `avatar_api_pass` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `active` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `audio_functions` varchar(100) COLLATE utf8_unicode_ci DEFAULT 'PLAY-STOP-RESTART',
  `audio_display` varchar(100) COLLATE utf8_unicode_ci DEFAULT 'FILE-NAME',
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  `soundboard_layout` varchar(40) COLLATE utf8_unicode_ci DEFAULT 'default',
  `columns_limit` smallint(5) DEFAULT 5,
  PRIMARY KEY (`avatar_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_bench_agent_log` (
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `bench_date` datetime DEFAULT NULL,
  `absent_agent` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bench_agent` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `bench_date` (`bench_date`),
  KEY `lead_id` (`lead_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_call_menu` (
  `menu_id` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `menu_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `menu_prompt` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `menu_timeout` smallint(2) unsigned DEFAULT 10,
  `menu_timeout_prompt` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `menu_invalid_prompt` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `menu_repeat` tinyint(1) unsigned DEFAULT 0,
  `menu_time_check` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `call_time_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `track_in_vdac` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `custom_dialplan_entry` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `tracking_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'CALLMENU',
  `dtmf_log` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `dtmf_field` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  `qualify_sql` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `alt_dtmf_log` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `question` int(11) DEFAULT NULL,
  PRIMARY KEY (`menu_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_call_menu_log` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `menu_id` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `lead_id` bigint(20) NOT NULL,
  `select_time` datetime NOT NULL DEFAULT current_timestamp(),
  `select_value` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `time` (`select_time`),
  KEY `Menu_Time` (`menu_id`,`select_time`)
) ENGINE=Aria AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci PAGE_CHECKSUM=0;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_call_menu_options` (
  `menu_id` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `option_value` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `option_description` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `option_route` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `option_route_value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `option_route_value_context` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  UNIQUE KEY `menuoption` (`menu_id`,`option_value`),
  KEY `menu_id` (`menu_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_call_notes` (
  `notesid` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `vicidial_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_date` datetime DEFAULT NULL,
  `order_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `appointment_date` date DEFAULT NULL,
  `appointment_time` time DEFAULT NULL,
  `call_notes` text COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`notesid`),
  KEY `lead_id` (`lead_id`)
) ENGINE=Aria AUTO_INCREMENT=100 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_call_notes_archive` (
  `notesid` int(9) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `vicidial_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_date` datetime DEFAULT NULL,
  `order_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `appointment_date` date DEFAULT NULL,
  `appointment_time` time DEFAULT NULL,
  `call_notes` text COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`notesid`),
  KEY `lead_id` (`lead_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_call_time_holidays` (
  `holiday_id` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `holiday_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `holiday_comments` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `holiday_date` date DEFAULT NULL,
  `holiday_status` enum('ACTIVE','INACTIVE','EXPIRED') COLLATE utf8_unicode_ci DEFAULT 'INACTIVE',
  `ct_default_start` smallint(4) unsigned NOT NULL DEFAULT 900,
  `ct_default_stop` smallint(4) unsigned NOT NULL DEFAULT 2100,
  `default_afterhours_filename_override` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  `holiday_color` varchar(7) COLLATE utf8_unicode_ci DEFAULT '',
  PRIMARY KEY (`holiday_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_call_times` (
  `call_time_id` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `call_time_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `call_time_comments` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `ct_default_start` smallint(4) unsigned NOT NULL DEFAULT 900,
  `ct_default_stop` smallint(4) unsigned NOT NULL DEFAULT 2100,
  `ct_sunday_start` smallint(4) unsigned DEFAULT 0,
  `ct_sunday_stop` smallint(4) unsigned DEFAULT 0,
  `ct_monday_start` smallint(4) unsigned DEFAULT 0,
  `ct_monday_stop` smallint(4) unsigned DEFAULT 0,
  `ct_tuesday_start` smallint(4) unsigned DEFAULT 0,
  `ct_tuesday_stop` smallint(4) unsigned DEFAULT 0,
  `ct_wednesday_start` smallint(4) unsigned DEFAULT 0,
  `ct_wednesday_stop` smallint(4) unsigned DEFAULT 0,
  `ct_thursday_start` smallint(4) unsigned DEFAULT 0,
  `ct_thursday_stop` smallint(4) unsigned DEFAULT 0,
  `ct_friday_start` smallint(4) unsigned DEFAULT 0,
  `ct_friday_stop` smallint(4) unsigned DEFAULT 0,
  `ct_saturday_start` smallint(4) unsigned DEFAULT 0,
  `ct_saturday_stop` smallint(4) unsigned DEFAULT 0,
  `ct_state_call_times` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `default_afterhours_filename_override` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `sunday_afterhours_filename_override` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `monday_afterhours_filename_override` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `tuesday_afterhours_filename_override` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `wednesday_afterhours_filename_override` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `thursday_afterhours_filename_override` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `friday_afterhours_filename_override` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `saturday_afterhours_filename_override` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  `ct_holidays` text COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`call_time_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_callbacks` (
  `callback_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `list_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entry_time` datetime DEFAULT NULL,
  `callback_time` datetime DEFAULT NULL,
  `modify_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `recipient` enum('USERONLY','ANYONE') COLLATE utf8_unicode_ci DEFAULT NULL,
  `comments` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lead_status` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'CALLBK',
  `email_alert` datetime DEFAULT NULL,
  `email_result` enum('SENT','FAILED','NOT AVAILABLE') COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_timezone` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `customer_timezone_diff` varchar(6) COLLATE utf8_unicode_ci DEFAULT '',
  `customer_time` datetime DEFAULT NULL,
  PRIMARY KEY (`callback_id`),
  KEY `lead_id` (`lead_id`),
  KEY `status` (`status`),
  KEY `callback_time` (`callback_time`)
) ENGINE=Aria AUTO_INCREMENT=1866835 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_callbacks_archive` (
  `callback_id` int(9) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `list_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entry_time` datetime DEFAULT NULL,
  `callback_time` datetime DEFAULT NULL,
  `modify_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `recipient` enum('USERONLY','ANYONE') COLLATE utf8_unicode_ci DEFAULT NULL,
  `comments` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lead_status` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'CALLBK',
  `email_alert` datetime DEFAULT NULL,
  `email_result` enum('SENT','FAILED','NOT AVAILABLE') COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_timezone` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `customer_timezone_diff` varchar(6) COLLATE utf8_unicode_ci DEFAULT '',
  `customer_time` datetime DEFAULT NULL,
  PRIMARY KEY (`callback_id`),
  KEY `lead_id` (`lead_id`),
  KEY `status` (`status`),
  KEY `callback_time` (`callback_time`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_callbacks_log` (
  `callback_id` int(9) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `list_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entry_time` datetime DEFAULT NULL,
  `callback_time` datetime DEFAULT NULL,
  `modify_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `recipient` enum('USERONLY','ANYONE') COLLATE utf8_unicode_ci DEFAULT NULL,
  `comments` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lead_status` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'CALLBK',
  KEY `lead_id` (`lead_id`),
  KEY `status` (`status`),
  KEY `callback_time` (`callback_time`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=FIXED;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_campaign_agents` (
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `campaign_rank` tinyint(1) DEFAULT 0,
  `campaign_weight` tinyint(1) DEFAULT 0,
  `calls_today` smallint(5) unsigned DEFAULT 0,
  `group_web_vars` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `campaign_grade` tinyint(2) unsigned DEFAULT 1,
  `hopper_calls_today` smallint(5) unsigned DEFAULT 0,
  `hopper_calls_hour` smallint(5) unsigned DEFAULT 0,
  UNIQUE KEY `vlca_user_campaign_id` (`user`,`campaign_id`),
  KEY `campaign_id` (`campaign_id`),
  KEY `user` (`user`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_campaign_cid_areacodes` (
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `areacode` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `outbound_cid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` enum('Y','N','') COLLATE utf8_unicode_ci DEFAULT '',
  `cid_description` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_count_today` mediumint(7) DEFAULT 0,
  UNIQUE KEY `campareacode` (`campaign_id`,`areacode`,`outbound_cid`),
  KEY `campaign_id` (`campaign_id`),
  KEY `areacode` (`areacode`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_campaign_dnc` (
  `phone_number` varchar(18) COLLATE utf8_unicode_ci NOT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `phonecamp` (`phone_number`,`campaign_id`),
  KEY `phone_number` (`phone_number`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_campaign_hotkeys` (
  `status` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `hotkey` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `status_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `selectable` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `campaign_id` (`campaign_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_campaign_hour_counts` (
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_hour` datetime DEFAULT NULL,
  `next_hour` datetime DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  `type` varchar(8) COLLATE utf8_unicode_ci DEFAULT 'CALLS',
  `calls` mediumint(6) unsigned DEFAULT 0,
  `hr` tinyint(2) DEFAULT 0,
  UNIQUE KEY `vchc_camp_hour` (`campaign_id`,`date_hour`,`type`),
  KEY `campaign_id` (`campaign_id`),
  KEY `date_hour` (`date_hour`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_campaign_hour_counts_archive` (
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_hour` datetime DEFAULT NULL,
  `next_hour` datetime DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  `type` varchar(8) COLLATE utf8_unicode_ci DEFAULT 'CALLS',
  `calls` mediumint(6) unsigned DEFAULT 0,
  `hr` tinyint(2) DEFAULT 0,
  UNIQUE KEY `vchc_camp_hour` (`campaign_id`,`date_hour`,`type`),
  KEY `campaign_id` (`campaign_id`),
  KEY `date_hour` (`date_hour`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_campaign_server_stats` (
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `local_trunk_shortage` smallint(5) unsigned DEFAULT 0,
  KEY `campaign_id` (`campaign_id`),
  KEY `server_ip` (`server_ip`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_campaign_stats` (
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `dialable_leads` int(9) unsigned DEFAULT 0,
  `calls_today` int(9) unsigned DEFAULT 0,
  `answers_today` int(9) unsigned DEFAULT 0,
  `drops_today` decimal(12,3) DEFAULT 0.000,
  `drops_today_pct` varchar(6) COLLATE utf8_unicode_ci DEFAULT '0',
  `drops_answers_today_pct` varchar(6) COLLATE utf8_unicode_ci DEFAULT '0',
  `calls_hour` int(9) unsigned DEFAULT 0,
  `answers_hour` int(9) unsigned DEFAULT 0,
  `drops_hour` int(9) unsigned DEFAULT 0,
  `drops_hour_pct` varchar(6) COLLATE utf8_unicode_ci DEFAULT '0',
  `calls_halfhour` int(9) unsigned DEFAULT 0,
  `answers_halfhour` int(9) unsigned DEFAULT 0,
  `drops_halfhour` int(9) unsigned DEFAULT 0,
  `drops_halfhour_pct` varchar(6) COLLATE utf8_unicode_ci DEFAULT '0',
  `calls_fivemin` int(9) unsigned DEFAULT 0,
  `answers_fivemin` int(9) unsigned DEFAULT 0,
  `drops_fivemin` int(9) unsigned DEFAULT 0,
  `drops_fivemin_pct` varchar(6) COLLATE utf8_unicode_ci DEFAULT '0',
  `calls_onemin` int(9) unsigned DEFAULT 0,
  `answers_onemin` int(9) unsigned DEFAULT 0,
  `drops_onemin` int(9) unsigned DEFAULT 0,
  `drops_onemin_pct` varchar(6) COLLATE utf8_unicode_ci DEFAULT '0',
  `differential_onemin` varchar(20) COLLATE utf8_unicode_ci DEFAULT '0',
  `agents_average_onemin` varchar(20) COLLATE utf8_unicode_ci DEFAULT '0',
  `balance_trunk_fill` smallint(5) unsigned DEFAULT 0,
  `status_category_1` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status_category_count_1` int(9) unsigned DEFAULT 0,
  `status_category_2` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status_category_count_2` int(9) unsigned DEFAULT 0,
  `status_category_3` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status_category_count_3` int(9) unsigned DEFAULT 0,
  `status_category_4` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status_category_count_4` int(9) unsigned DEFAULT 0,
  `hold_sec_stat_one` mediumint(8) unsigned DEFAULT 0,
  `hold_sec_stat_two` mediumint(8) unsigned DEFAULT 0,
  `agent_non_pause_sec` mediumint(8) unsigned DEFAULT 0,
  `hold_sec_answer_calls` mediumint(8) unsigned DEFAULT 0,
  `hold_sec_drop_calls` mediumint(8) unsigned DEFAULT 0,
  `hold_sec_queue_calls` mediumint(8) unsigned DEFAULT 0,
  `agent_calls_today` int(9) unsigned DEFAULT 0,
  `agent_wait_today` bigint(14) unsigned DEFAULT 0,
  `agent_custtalk_today` bigint(14) unsigned DEFAULT 0,
  `agent_acw_today` bigint(14) unsigned DEFAULT 0,
  `agent_pause_today` bigint(14) unsigned DEFAULT 0,
  `answering_machines_today` int(9) unsigned DEFAULT 0,
  `agenthandled_today` int(9) unsigned DEFAULT 0,
  PRIMARY KEY (`campaign_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_campaign_stats_debug` (
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `entry_time` datetime DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `debug_output` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `adapt_output` text COLLATE utf8_unicode_ci DEFAULT NULL,
  UNIQUE KEY `campserver` (`campaign_id`,`server_ip`),
  KEY `campaign_id` (`campaign_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_campaign_statuses` (
  `status` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `status_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `selectable` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `human_answered` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `category` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'UNDEFINED',
  `sale` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `dnc` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `customer_contact` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `not_interested` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `unworkable` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `scheduled_callback` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `completed` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `min_sec` int(5) unsigned DEFAULT 0,
  `max_sec` int(5) unsigned DEFAULT 0,
  `answering_machine` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `Pos` int(5) NOT NULL DEFAULT 0,
  `Col` int(5) NOT NULL,
  UNIQUE KEY `vicidial_campaign_statuses_key` (`status`,`campaign_id`),
  KEY `campaign_id` (`campaign_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_campaigns` (
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `campaign_name` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT NULL,
  `dial_status_a` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dial_status_b` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dial_status_c` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dial_status_d` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dial_status_e` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lead_order` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `park_ext` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `park_file_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT 'default',
  `web_form_address` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `allow_closers` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT NULL,
  `hopper_level` int(8) unsigned DEFAULT 1,
  `auto_dial_level` varchar(6) COLLATE utf8_unicode_ci DEFAULT '0',
  `next_agent_call` varchar(40) COLLATE utf8_unicode_ci DEFAULT 'longest_wait_time',
  `local_call_time` varchar(10) COLLATE utf8_unicode_ci DEFAULT '9am-9pm',
  `voicemail_ext` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dial_timeout` tinyint(3) unsigned DEFAULT 60,
  `dial_prefix` varchar(20) COLLATE utf8_unicode_ci DEFAULT '9',
  `campaign_cid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '0000000000',
  `campaign_vdad_exten` varchar(20) COLLATE utf8_unicode_ci DEFAULT '8368',
  `campaign_rec_exten` varchar(20) COLLATE utf8_unicode_ci DEFAULT '8309',
  `campaign_recording` enum('NEVER','ONDEMAND','ALLCALLS','ALLFORCE') COLLATE utf8_unicode_ci DEFAULT 'ONDEMAND',
  `campaign_rec_filename` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'FULLDATE_CUSTPHONE',
  `campaign_script` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `get_call_launch` enum('NONE','SCRIPT','SCRIPTTWO','WEBFORM','WEBFORMTWO','WEBFORMTHREE','FORM','PREVIEW_WEBFORM','PREVIEW_WEBFORMTWO','PREVIEW_WEBFORMTHREE') COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `am_message_exten` varchar(100) COLLATE utf8_unicode_ci DEFAULT 'vm-goodbye',
  `amd_send_to_vmx` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `xferconf_a_dtmf` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `xferconf_a_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `xferconf_b_dtmf` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `xferconf_b_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `alt_number_dialing` enum('N','Y','SELECTED','SELECTED_TIMER_ALT','SELECTED_TIMER_ADDR3') COLLATE utf8_unicode_ci DEFAULT 'N',
  `scheduled_callbacks` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `lead_filter_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `drop_call_seconds` tinyint(3) DEFAULT 5,
  `drop_action` enum('HANGUP','MESSAGE','VOICEMAIL','IN_GROUP','AUDIO','CALLMENU','VMAIL_NO_INST') COLLATE utf8_unicode_ci DEFAULT 'AUDIO',
  `safe_harbor_exten` varchar(20) COLLATE utf8_unicode_ci DEFAULT '8307',
  `display_dialable_count` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `wrapup_seconds` smallint(3) unsigned DEFAULT 0,
  `wrapup_message` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'Wrapup Call',
  `closer_campaigns` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `use_internal_dnc` enum('Y','N','AREACODE') COLLATE utf8_unicode_ci DEFAULT 'N',
  `allcalls_delay` smallint(3) unsigned DEFAULT 0,
  `omit_phone_code` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `dial_method` enum('MANUAL','RATIO','ADAPT_HARD_LIMIT','ADAPT_TAPERED','ADAPT_AVERAGE','INBOUND_MAN') COLLATE utf8_unicode_ci DEFAULT 'MANUAL',
  `available_only_ratio_tally` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `adaptive_dropped_percentage` varchar(4) COLLATE utf8_unicode_ci DEFAULT '3',
  `adaptive_maximum_level` varchar(6) COLLATE utf8_unicode_ci DEFAULT '3.0',
  `adaptive_latest_server_time` varchar(4) COLLATE utf8_unicode_ci DEFAULT '2100',
  `adaptive_intensity` varchar(6) COLLATE utf8_unicode_ci DEFAULT '0',
  `adaptive_dl_diff_target` smallint(3) DEFAULT 0,
  `concurrent_transfers` enum('AUTO','1','2','3','4','5','6','7','8','9','10','15','20','25','30','40','50','60','80','100') COLLATE utf8_unicode_ci DEFAULT 'AUTO',
  `auto_alt_dial` enum('NONE','ALT_ONLY','ADDR3_ONLY','ALT_AND_ADDR3','ALT_AND_EXTENDED','ALT_AND_ADDR3_AND_EXTENDED','EXTENDED_ONLY','MULTI_LEAD') COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `auto_alt_dial_statuses` varchar(255) COLLATE utf8_unicode_ci DEFAULT ' B N NA DC -',
  `agent_pause_codes_active` enum('Y','N','FORCE') COLLATE utf8_unicode_ci DEFAULT 'N',
  `campaign_description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `campaign_changedate` datetime DEFAULT NULL,
  `campaign_stats_refresh` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `campaign_logindate` datetime DEFAULT NULL,
  `dial_statuses` varchar(255) COLLATE utf8_unicode_ci DEFAULT ' NEW -',
  `disable_alter_custdata` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `no_hopper_leads_logins` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `list_order_mix` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `campaign_allow_inbound` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `manual_dial_list_id` bigint(20) unsigned DEFAULT 998,
  `default_xfer_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---NONE---',
  `xfer_groups` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `queue_priority` tinyint(2) DEFAULT 50,
  `drop_inbound_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---NONE---',
  `qc_enabled` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `qc_statuses` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `qc_lists` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `qc_shift_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT '24HRMIDNIGHT',
  `qc_get_record_launch` enum('NONE','SCRIPT','WEBFORM','QCSCRIPT','QCWEBFORM') COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `qc_show_recording` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `qc_web_form_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qc_script` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `survey_first_audio_file` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'US_pol_survey_hello',
  `survey_dtmf_digits` varchar(16) COLLATE utf8_unicode_ci DEFAULT '1238',
  `survey_ni_digit` varchar(1) COLLATE utf8_unicode_ci DEFAULT '8',
  `survey_opt_in_audio_file` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'US_pol_survey_transfer',
  `survey_ni_audio_file` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'US_thanks_no_contact',
  `survey_method` enum('AGENT_XFER','VOICEMAIL','EXTENSION','HANGUP','CAMPREC_60_WAV','CALLMENU','VMAIL_NO_INST') COLLATE utf8_unicode_ci DEFAULT 'AGENT_XFER',
  `survey_no_response_action` enum('OPTIN','OPTOUT','DROP') COLLATE utf8_unicode_ci DEFAULT 'OPTIN',
  `survey_ni_status` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'NI',
  `survey_response_digit_map` varchar(255) COLLATE utf8_unicode_ci DEFAULT '1-DEMOCRAT|2-REPUBLICAN|3-INDEPENDANT|8-OPTOUT|X-NO RESPONSE|',
  `survey_xfer_exten` varchar(20) COLLATE utf8_unicode_ci DEFAULT '8300',
  `survey_camp_record_dir` varchar(255) COLLATE utf8_unicode_ci DEFAULT '/home/survey',
  `disable_alter_custphone` enum('Y','N','HIDE') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `display_queue_count` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `manual_dial_filter` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `agent_clipboard_copy` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `agent_extended_alt_dial` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `use_campaign_dnc` enum('Y','N','AREACODE') COLLATE utf8_unicode_ci DEFAULT 'N',
  `three_way_call_cid` enum('CAMPAIGN','CUSTOMER','AGENT_PHONE','AGENT_CHOOSE','CUSTOM_CID') COLLATE utf8_unicode_ci DEFAULT 'CAMPAIGN',
  `three_way_dial_prefix` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `web_form_target` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'vdcwebform',
  `vtiger_search_category` varchar(100) COLLATE utf8_unicode_ci DEFAULT 'LEAD',
  `vtiger_create_call_record` enum('Y','N','DISPO') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `vtiger_create_lead_record` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `vtiger_screen_login` enum('Y','N','NEW_WINDOW') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `cpd_amd_action` enum('DISABLED','DISPO','MESSAGE','CALLMENU','INGROUP') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `agent_allow_group_alias` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `default_group_alias` varchar(30) COLLATE utf8_unicode_ci DEFAULT '',
  `vtiger_search_dead` enum('DISABLED','ASK','RESURRECT') COLLATE utf8_unicode_ci DEFAULT 'ASK',
  `vtiger_status_call` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `survey_third_digit` varchar(1) COLLATE utf8_unicode_ci DEFAULT '',
  `survey_third_audio_file` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'US_thanks_no_contact',
  `survey_third_status` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'NI',
  `survey_third_exten` varchar(20) COLLATE utf8_unicode_ci DEFAULT '8300',
  `survey_fourth_digit` varchar(1) COLLATE utf8_unicode_ci DEFAULT '',
  `survey_fourth_audio_file` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'US_thanks_no_contact',
  `survey_fourth_status` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'NI',
  `survey_fourth_exten` varchar(20) COLLATE utf8_unicode_ci DEFAULT '8300',
  `drop_lockout_time` varchar(6) COLLATE utf8_unicode_ci DEFAULT '0',
  `quick_transfer_button` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'N',
  `prepopulate_transfer_preset` enum('N','PRESET_1','PRESET_2','PRESET_3','PRESET_4','PRESET_5') COLLATE utf8_unicode_ci DEFAULT 'N',
  `drop_rate_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `view_calls_in_queue` enum('NONE','ALL','1','2','3','4','5') COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `view_calls_in_queue_launch` enum('AUTO','MANUAL') COLLATE utf8_unicode_ci DEFAULT 'MANUAL',
  `grab_calls_in_queue` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `call_requeue_button` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `pause_after_each_call` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `no_hopper_dialing` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `agent_dial_owner_only` enum('NONE','USER','TERRITORY','USER_GROUP','USER_BLANK','TERRITORY_BLANK','USER_GROUP_BLANK') COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `agent_display_dialable_leads` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `web_form_address_two` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `waitforsilence_options` varchar(25) COLLATE utf8_unicode_ci DEFAULT '',
  `agent_select_territories` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `campaign_calldate` datetime DEFAULT NULL,
  `crm_popup_login` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `crm_login_address` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `timer_action` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `timer_action_message` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `timer_action_seconds` mediumint(7) DEFAULT -1,
  `start_call_url` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `dispo_call_url` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `xferconf_c_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `xferconf_d_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `xferconf_e_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `use_custom_cid` enum('Y','N','AREACODE','USER_CUSTOM_1','USER_CUSTOM_2','USER_CUSTOM_3','USER_CUSTOM_4','USER_CUSTOM_5') COLLATE utf8_unicode_ci DEFAULT 'N',
  `scheduled_callbacks_alert` enum('NONE','BLINK','RED','BLINK_RED','BLINK_DEFER','RED_DEFER','BLINK_RED_DEFER') COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `queuemetrics_callstatus_override` enum('DISABLED','NO','YES') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `extension_appended_cidname` enum('Y','N','Y_USER','Y_WITH_CAMPAIGN','Y_USER_WITH_CAMPAIGN') COLLATE utf8_unicode_ci DEFAULT 'N',
  `scheduled_callbacks_count` enum('LIVE','ALL_ACTIVE') COLLATE utf8_unicode_ci DEFAULT 'ALL_ACTIVE',
  `manual_dial_override` enum('NONE','ALLOW_ALL','DISABLE_ALL') COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `blind_monitor_warning` enum('DISABLED','ALERT','NOTICE','AUDIO','ALERT_NOTICE','ALERT_AUDIO','NOTICE_AUDIO','ALL') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `blind_monitor_message` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'Someone is blind monitoring your session',
  `blind_monitor_filename` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `inbound_queue_no_dial` enum('DISABLED','ENABLED','ALL_SERVERS','ENABLED_WITH_CHAT','ALL_SERVERS_WITH_CHAT') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `timer_action_destination` varchar(30) COLLATE utf8_unicode_ci DEFAULT '',
  `enable_xfer_presets` enum('DISABLED','ENABLED','CONTACTS') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `hide_xfer_number_to_dial` enum('DISABLED','ENABLED') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `manual_dial_prefix` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `customer_3way_hangup_logging` enum('DISABLED','ENABLED') COLLATE utf8_unicode_ci DEFAULT 'ENABLED',
  `customer_3way_hangup_seconds` smallint(5) unsigned DEFAULT 5,
  `customer_3way_hangup_action` enum('NONE','DISPO') COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `ivr_park_call` enum('DISABLED','ENABLED','ENABLED_PARK_ONLY','ENABLED_BUTTON_HIDDEN') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `ivr_park_call_agi` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `manual_preview_dial` enum('DISABLED','PREVIEW_AND_SKIP','PREVIEW_ONLY') COLLATE utf8_unicode_ci DEFAULT 'PREVIEW_AND_SKIP',
  `realtime_agent_time_stats` enum('DISABLED','WAIT_CUST_ACW','WAIT_CUST_ACW_PAUSE','CALLS_WAIT_CUST_ACW_PAUSE') COLLATE utf8_unicode_ci DEFAULT 'CALLS_WAIT_CUST_ACW_PAUSE',
  `use_auto_hopper` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `auto_hopper_multi` varchar(6) COLLATE utf8_unicode_ci DEFAULT '1',
  `auto_hopper_level` mediumint(8) unsigned DEFAULT 0,
  `auto_trim_hopper` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `api_manual_dial` enum('STANDARD','QUEUE','QUEUE_AND_AUTOCALL') COLLATE utf8_unicode_ci DEFAULT 'STANDARD',
  `manual_dial_call_time_check` enum('DISABLED','ENABLED') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `display_leads_count` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `lead_order_randomize` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `lead_order_secondary` enum('LEAD_ASCEND','LEAD_DESCEND','CALLTIME_ASCEND','CALLTIME_DESCEND','VENDOR_ASCEND','VENDOR_DESCEND') COLLATE utf8_unicode_ci DEFAULT 'LEAD_ASCEND',
  `per_call_notes` enum('ENABLED','DISABLED') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `my_callback_option` enum('CHECKED','UNCHECKED') COLLATE utf8_unicode_ci DEFAULT 'UNCHECKED',
  `agent_lead_search` enum('ENABLED','LIVE_CALL_INBOUND','LIVE_CALL_INBOUND_AND_MANUAL','DISABLED') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `agent_lead_search_method` varchar(30) COLLATE utf8_unicode_ci DEFAULT 'CAMPLISTS_ALL',
  `queuemetrics_phone_environment` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `auto_pause_precall` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `auto_pause_precall_code` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'PRECAL',
  `auto_resume_precall` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `manual_dial_cid` enum('CAMPAIGN','AGENT_PHONE') COLLATE utf8_unicode_ci DEFAULT 'CAMPAIGN',
  `post_phone_time_diff_alert` varchar(30) COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `custom_3way_button_transfer` varchar(30) COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `available_only_tally_threshold` enum('DISABLED','LOGGED-IN_AGENTS','NON-PAUSED_AGENTS','WAITING_AGENTS') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `available_only_tally_threshold_agents` smallint(5) unsigned DEFAULT 0,
  `dial_level_threshold` enum('DISABLED','LOGGED-IN_AGENTS','NON-PAUSED_AGENTS','WAITING_AGENTS') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `dial_level_threshold_agents` smallint(5) unsigned DEFAULT 0,
  `safe_harbor_audio` varchar(100) COLLATE utf8_unicode_ci DEFAULT 'buzz',
  `safe_harbor_menu_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `survey_menu_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `callback_days_limit` smallint(3) DEFAULT 0,
  `dl_diff_target_method` enum('ADAPT_CALC_ONLY','CALLS_PLACED') COLLATE utf8_unicode_ci DEFAULT 'ADAPT_CALC_ONLY',
  `disable_dispo_screen` enum('DISPO_ENABLED','DISPO_DISABLED','DISPO_SELECT_DISABLED') COLLATE utf8_unicode_ci DEFAULT 'DISPO_ENABLED',
  `disable_dispo_status` varchar(6) COLLATE utf8_unicode_ci DEFAULT '',
  `screen_labels` varchar(20) COLLATE utf8_unicode_ci DEFAULT '--SYSTEM-SETTINGS--',
  `status_display_fields` varchar(30) COLLATE utf8_unicode_ci DEFAULT 'CALLID',
  `na_call_url` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `survey_recording` enum('Y','N','Y_WITH_AMD') COLLATE utf8_unicode_ci DEFAULT 'N',
  `pllb_grouping` enum('DISABLED','ONE_SERVER_ONLY','CASCADING') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `pllb_grouping_limit` smallint(5) DEFAULT 50,
  `call_count_limit` smallint(5) unsigned DEFAULT 0,
  `call_count_target` smallint(5) unsigned DEFAULT 3,
  `callback_hours_block` tinyint(2) DEFAULT 0,
  `callback_list_calltime` enum('ENABLED','DISABLED') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  `hopper_vlc_dup_check` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `in_group_dial` enum('DISABLED','MANUAL_DIAL','NO_DIAL','BOTH') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `in_group_dial_select` enum('AGENT_SELECTED','CAMPAIGN_SELECTED','ALL_USER_GROUP') COLLATE utf8_unicode_ci DEFAULT 'CAMPAIGN_SELECTED',
  `safe_harbor_audio_field` varchar(30) COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `pause_after_next_call` enum('ENABLED','DISABLED') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `owner_populate` enum('ENABLED','DISABLED') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `use_other_campaign_dnc` varchar(8) COLLATE utf8_unicode_ci DEFAULT '',
  `allow_emails` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `amd_inbound_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `amd_callmenu` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `survey_wait_sec` tinyint(3) DEFAULT 10,
  `manual_dial_lead_id` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `dead_max` smallint(5) unsigned DEFAULT 0,
  `dead_max_dispo` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'DCMX',
  `dispo_max` smallint(5) unsigned DEFAULT 0,
  `dispo_max_dispo` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'DISMX',
  `pause_max` smallint(5) unsigned DEFAULT 0,
  `max_inbound_calls` smallint(5) unsigned DEFAULT 0,
  `manual_dial_search_checkbox` enum('SELECTED','SELECTED_RESET','UNSELECTED','UNSELECTED_RESET','SELECTED_LOCK','UNSELECTED_LOCK') COLLATE utf8_unicode_ci DEFAULT 'SELECTED',
  `hide_call_log_info` enum('Y','N','SHOW_1','SHOW_2','SHOW_3','SHOW_4','SHOW_5','SHOW_6','SHOW_7','SHOW_8','SHOW_9','SHOW_10') COLLATE utf8_unicode_ci DEFAULT 'N',
  `timer_alt_seconds` smallint(5) DEFAULT 0,
  `wrapup_bypass` enum('DISABLED','ENABLED') COLLATE utf8_unicode_ci DEFAULT 'ENABLED',
  `wrapup_after_hotkey` enum('DISABLED','ENABLED') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `callback_active_limit` smallint(5) unsigned DEFAULT 0,
  `callback_active_limit_override` enum('N','Y') COLLATE utf8_unicode_ci DEFAULT 'N',
  `allow_chats` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `comments_all_tabs` enum('DISABLED','ENABLED') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `comments_dispo_screen` enum('DISABLED','ENABLED','REPLACE_CALL_NOTES') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `comments_callback_screen` enum('DISABLED','ENABLED','REPLACE_CB_NOTES') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `qc_comment_history` enum('CLICK','AUTO_OPEN','CLICK_ALLOW_MINIMIZE','AUTO_OPEN_ALLOW_MINIMIZE') COLLATE utf8_unicode_ci DEFAULT 'CLICK',
  `show_previous_callback` enum('DISABLED','ENABLED') COLLATE utf8_unicode_ci DEFAULT 'ENABLED',
  `clear_script` enum('DISABLED','ENABLED') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `cpd_unknown_action` enum('DISABLED','DISPO','MESSAGE','CALLMENU','INGROUP') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `manual_dial_search_filter` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `web_form_address_three` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `manual_dial_override_field` enum('ENABLED','DISABLED') COLLATE utf8_unicode_ci DEFAULT 'ENABLED',
  `status_display_ingroup` enum('ENABLED','DISABLED') COLLATE utf8_unicode_ci DEFAULT 'ENABLED',
  `customer_gone_seconds` smallint(5) unsigned DEFAULT 30,
  `agent_display_fields` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `am_message_wildcards` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `manual_dial_timeout` varchar(3) COLLATE utf8_unicode_ci DEFAULT '',
  `routing_initiated_recordings` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `manual_dial_hopper_check` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `callback_useronly_move_minutes` mediumint(5) unsigned DEFAULT 0,
  `ofcom_uk_drop_calc` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `manual_auto_next` smallint(5) unsigned DEFAULT 0,
  `manual_auto_show` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `allow_required_fields` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `dead_to_dispo` enum('ENABLED','DISABLED') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `agent_xfer_validation` enum('N','Y') COLLATE utf8_unicode_ci DEFAULT 'N',
  `ready_max_logout` mediumint(7) DEFAULT 0,
  `callback_display_days` smallint(3) DEFAULT 0,
  `three_way_record_stop` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `hangup_xfer_record_start` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `scheduled_callbacks_email_alert` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `max_inbound_calls_outcome` enum('DEFAULT','ALLOW_AGENTDIRECT','ALLOW_MI_PAUSE','ALLOW_AGENTDIRECT_AND_MI_PAUSE') COLLATE utf8_unicode_ci DEFAULT 'DEFAULT',
  `manual_auto_next_options` enum('DEFAULT','PAUSE_NO_COUNT') COLLATE utf8_unicode_ci DEFAULT 'DEFAULT',
  `agent_screen_time_display` varchar(40) COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `next_dial_my_callbacks` enum('DISABLED','ENABLED') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `inbound_no_agents_no_dial_container` varchar(40) COLLATE utf8_unicode_ci DEFAULT '---DISABLED---',
  `inbound_no_agents_no_dial_threshold` smallint(5) DEFAULT 0,
  `cid_group_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---DISABLED---',
  `pause_max_dispo` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'PAUSMX',
  `script_top_dispo` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `dead_trigger_seconds` smallint(5) DEFAULT 0,
  `dead_trigger_action` enum('DISABLED','AUDIO','URL','AUDIO_AND_URL') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `dead_trigger_repeat` enum('NO','REPEAT_ALL','REPEAT_AUDIO','REPEAT_URL') COLLATE utf8_unicode_ci DEFAULT 'NO',
  `dead_trigger_filename` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `dead_trigger_url` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `scheduled_callbacks_force_dial` enum('N','Y') COLLATE utf8_unicode_ci DEFAULT 'N',
  `scheduled_callbacks_auto_reschedule` varchar(10) COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `scheduled_callbacks_timezones_container` varchar(40) COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `three_way_volume_buttons` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'ENABLED',
  `callback_dnc` enum('ENABLED','DISABLED') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `manual_dial_validation` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `mute_recordings` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `auto_active_list_new` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `call_quota_lead_ranking` varchar(40) COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `call_quota_process_running` tinyint(3) DEFAULT 0,
  `call_quota_last_run_date` datetime DEFAULT NULL,
  `sip_event_logging` varchar(40) COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `campaign_script_two` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `leave_vm_no_dispo` enum('ENABLED','DISABLED') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `leave_vm_message_group_id` varchar(40) COLLATE utf8_unicode_ci DEFAULT '---NONE---',
  `acr_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`campaign_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadmin`@`localhost`*/ /*!50003 TRIGGER `Manu_auto_Dial` BEFORE UPDATE ON `vicidial_campaigns` FOR EACH ROW IF NEW.campaign_id NOT IN ('ALT_SPEZ', 'ALT_JAHD', 'ALT_JAHA') THEN
	IF NEW.campaign_id LIKE 'ALT%' THEN
  		IF (NEW.dial_method IN ('MANUAL', 'INBOUND_MAN')) THEN
    		SET NEW.no_hopper_dialing = 'Y',
         	NEW.agent_dial_owner_only = 'USER',
		 	NEW.auto_hopper_level = 0,
         	NEW.callback_useronly_move_minutes = 0;
     	ELSE
    		SET NEW.no_hopper_dialing = 'N',
         	NEW.agent_dial_owner_only = 'NONE',
	 	 	NEW.auto_hopper_level = 12,
         	NEW.callback_useronly_move_minutes = 0;
     	END IF;
   	END IF;
END IF */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_campaigns_list_mix` (
  `vcl_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `vcl_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `list_mix_container` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `mix_method` enum('EVEN_MIX','IN_ORDER','RANDOM') COLLATE utf8_unicode_ci DEFAULT 'IN_ORDER',
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8_unicode_ci DEFAULT 'INACTIVE',
  PRIMARY KEY (`vcl_id`),
  KEY `campaign_id` (`campaign_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_carrier_hour_counts` (
  `date_hour` datetime DEFAULT NULL,
  `next_hour` datetime DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  `type` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'ANSWERED',
  `calls` mediumint(6) unsigned DEFAULT 0,
  `hr` tinyint(2) DEFAULT 0,
  UNIQUE KEY `vclhc_hour` (`date_hour`,`type`),
  KEY `date_hour` (`date_hour`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_carrier_hour_counts_archive` (
  `date_hour` datetime DEFAULT NULL,
  `next_hour` datetime DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  `type` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'ANSWERED',
  `calls` mediumint(6) unsigned DEFAULT 0,
  `hr` tinyint(2) DEFAULT 0,
  UNIQUE KEY `vclhc_hour` (`date_hour`,`type`),
  KEY `date_hour` (`date_hour`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_carrier_log` (
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `call_date` datetime DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `hangup_cause` tinyint(1) unsigned DEFAULT 0,
  `dialstatus` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dial_time` smallint(3) unsigned DEFAULT 0,
  `answered_time` smallint(4) unsigned DEFAULT 0,
  `sip_hangup_cause` smallint(4) unsigned DEFAULT 0,
  `sip_hangup_reason` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `caller_code` varchar(30) COLLATE utf8_unicode_ci DEFAULT '',
  PRIMARY KEY (`uniqueid`),
  KEY `call_date` (`call_date`),
  KEY `vdcllid` (`lead_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_carrier_log_archive` (
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `call_date` datetime DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `hangup_cause` tinyint(1) unsigned DEFAULT 0,
  `dialstatus` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dial_time` smallint(3) unsigned DEFAULT 0,
  `answered_time` smallint(4) unsigned DEFAULT 0,
  `sip_hangup_cause` smallint(4) unsigned DEFAULT 0,
  `sip_hangup_reason` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `caller_code` varchar(30) COLLATE utf8_unicode_ci DEFAULT '',
  PRIMARY KEY (`uniqueid`),
  KEY `call_date` (`call_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_ccc_log` (
  `call_date` datetime DEFAULT NULL,
  `remote_call_id` varchar(30) COLLATE utf8_unicode_ci DEFAULT '',
  `local_call_id` varchar(30) COLLATE utf8_unicode_ci DEFAULT '',
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `server_ip` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `list_id` bigint(20) unsigned DEFAULT NULL,
  `container_id` varchar(40) COLLATE utf8_unicode_ci DEFAULT '',
  `remote_lead_id` bigint(20) unsigned DEFAULT NULL,
  KEY `call_date` (`call_date`),
  KEY `local_call_id` (`local_call_id`),
  KEY `lead_id` (`lead_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_ccc_log_archive` (
  `call_date` datetime DEFAULT NULL,
  `remote_call_id` varchar(30) COLLATE utf8_unicode_ci DEFAULT '',
  `local_call_id` varchar(30) COLLATE utf8_unicode_ci DEFAULT '',
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `server_ip` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `list_id` bigint(20) unsigned DEFAULT NULL,
  `container_id` varchar(40) COLLATE utf8_unicode_ci DEFAULT '',
  `remote_lead_id` bigint(20) unsigned DEFAULT NULL,
  UNIQUE KEY `ccc_unq_key` (`uniqueid`,`call_date`,`lead_id`),
  KEY `call_date` (`call_date`),
  KEY `local_call_id` (`local_call_id`),
  KEY `lead_id` (`lead_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_chat_archive` (
  `chat_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `chat_start_time` datetime DEFAULT NULL,
  `status` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `chat_creator` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `group_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `transferring_agent` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_direct` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_direct_group_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`chat_id`),
  KEY `vicidial_chat_archive_lead_id_key` (`lead_id`),
  KEY `vicidial_chat_archive_start_time_key` (`chat_start_time`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_chat_log` (
  `message_row_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `chat_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `message` mediumtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `message_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `poster` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `chat_member_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `chat_level` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  PRIMARY KEY (`message_row_id`),
  KEY `vicidial_chat_log_user_key` (`poster`),
  KEY `live_chat_id` (`chat_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_chat_log_archive` (
  `message_row_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `chat_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `message` mediumtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `message_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `poster` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `chat_member_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `chat_level` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  PRIMARY KEY (`message_row_id`),
  KEY `vicidial_chat_log_archive_user_key` (`poster`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_chat_participants` (
  `chat_participant_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `chat_id` int(9) unsigned DEFAULT NULL,
  `chat_member` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `chat_member_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ping_date` datetime DEFAULT NULL,
  `vd_agent` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  PRIMARY KEY (`chat_participant_id`),
  UNIQUE KEY `vicidial_chat_participants_key` (`chat_id`,`chat_member`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_cid_groups` (
  `cid_group_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `cid_group_notes` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `cid_group_type` enum('AREACODE','STATE','PHONECODE') COLLATE utf8_unicode_ci DEFAULT 'AREACODE',
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  PRIMARY KEY (`cid_group_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_closer_log` (
  `closecallid` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `list_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_date` datetime DEFAULT NULL,
  `start_epoch` int(10) unsigned DEFAULT NULL,
  `end_epoch` int(10) unsigned DEFAULT NULL,
  `length_in_sec` int(10) DEFAULT NULL,
  `status` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comments` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `processed` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT NULL,
  `queue_seconds` decimal(7,2) DEFAULT 0.00,
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `xfercallid` int(9) unsigned DEFAULT NULL,
  `term_reason` enum('CALLER','AGENT','QUEUETIMEOUT','ABANDON','AFTERHOURS','HOLDRECALLXFER','HOLDTIME','NOAGENT','NONE','MAXCALLS','ACFILTER','CLOSETIME') COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `agent_only` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `queue_position` smallint(4) unsigned DEFAULT 1,
  `called_count` smallint(5) unsigned DEFAULT 0,
  PRIMARY KEY (`closecallid`),
  KEY `lead_id` (`lead_id`),
  KEY `call_date` (`call_date`),
  KEY `campaign_id` (`campaign_id`),
  KEY `uniqueid` (`uniqueid`),
  KEY `phone_number` (`phone_number`),
  KEY `date_user` (`call_date`,`user`)
) ENGINE=Aria AUTO_INCREMENT=1420876 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_closer_log_archive` (
  `closecallid` int(9) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `list_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_date` datetime DEFAULT NULL,
  `start_epoch` int(10) unsigned DEFAULT NULL,
  `end_epoch` int(10) unsigned DEFAULT NULL,
  `length_in_sec` int(10) DEFAULT NULL,
  `status` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comments` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `processed` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT NULL,
  `queue_seconds` decimal(7,2) DEFAULT 0.00,
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `xfercallid` int(9) unsigned DEFAULT NULL,
  `term_reason` enum('CALLER','AGENT','QUEUETIMEOUT','ABANDON','AFTERHOURS','HOLDRECALLXFER','HOLDTIME','NOAGENT','NONE','MAXCALLS','ACFILTER','CLOSETIME') COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `agent_only` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `queue_position` smallint(4) unsigned DEFAULT 1,
  `called_count` smallint(5) unsigned DEFAULT 0,
  PRIMARY KEY (`closecallid`),
  KEY `lead_id` (`lead_id`),
  KEY `call_date` (`call_date`),
  KEY `campaign_id` (`campaign_id`),
  KEY `uniqueid` (`uniqueid`),
  KEY `phone_number` (`phone_number`),
  KEY `date_user` (`call_date`,`user`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_comments` (
  `comment_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `list_id` bigint(20) unsigned NOT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `comment` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `hidden` tinyint(1) DEFAULT NULL,
  `hidden_user_id` int(11) DEFAULT NULL,
  `hidden_timestamp` datetime DEFAULT NULL,
  `unhidden_user_id` int(11) DEFAULT NULL,
  `unhidden_timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `lead_id` (`lead_id`)
) ENGINE=Aria AUTO_INCREMENT=4306 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_conf_templates` (
  `template_id` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `template_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `template_contents` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  UNIQUE KEY `template_id` (`template_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_conferences` (
  `conf_exten` int(7) unsigned NOT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `leave_3way` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `leave_3way_datetime` datetime DEFAULT NULL,
  UNIQUE KEY `serverconf` (`server_ip`,`conf_exten`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_configuration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(36) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=Aria AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_country_iso_tld` (
  `country_name` varchar(200) COLLATE utf8_unicode_ci DEFAULT '',
  `iso2` varchar(2) COLLATE utf8_unicode_ci DEFAULT '',
  `iso3` varchar(3) COLLATE utf8_unicode_ci DEFAULT '',
  `num3` varchar(4) COLLATE utf8_unicode_ci DEFAULT '',
  `tld` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  KEY `iso3` (`iso3`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_cpd_log` (
  `cpd_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `channel` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `callerid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `event_date` datetime DEFAULT NULL,
  `result` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('NEW','PROCESSED') COLLATE utf8_unicode_ci DEFAULT 'NEW',
  `cpd_seconds` decimal(7,2) DEFAULT 0.00,
  PRIMARY KEY (`cpd_id`),
  KEY `uniqueid` (`uniqueid`),
  KEY `callerid` (`callerid`),
  KEY `lead_id` (`lead_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_custom_cid` (
  `cid` varchar(18) COLLATE utf8_unicode_ci NOT NULL,
  `state` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `areacode` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_code` smallint(5) unsigned DEFAULT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT '--ALL--',
  KEY `state` (`state`),
  KEY `areacode` (`areacode`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_custom_leadloader_templates` (
  `template_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `template_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `template_description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `list_id` bigint(20) unsigned DEFAULT NULL,
  `standard_variables` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `custom_table` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `custom_variables` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `template_statuses` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`template_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_custom_reports` (
  `custom_report_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `report_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `domain` varchar(70) COLLATE utf8_unicode_ci DEFAULT NULL,
  `path_name` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `custom_variables` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `user_modify` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`custom_report_id`),
  UNIQUE KEY `custom_report_name_key` (`report_name`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_daily_max_stats` (
  `stats_date` date NOT NULL,
  `stats_flag` enum('OPEN','CLOSED','CLOSING') COLLATE utf8_unicode_ci DEFAULT 'CLOSED',
  `stats_type` enum('TOTAL','INGROUP','CAMPAIGN','') COLLATE utf8_unicode_ci DEFAULT '',
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `closed_time` datetime DEFAULT NULL,
  `max_channels` mediumint(8) unsigned DEFAULT 0,
  `max_calls` mediumint(8) unsigned DEFAULT 0,
  `max_inbound` mediumint(8) unsigned DEFAULT 0,
  `max_outbound` mediumint(8) unsigned DEFAULT 0,
  `max_agents` mediumint(8) unsigned DEFAULT 0,
  `max_remote_agents` mediumint(8) unsigned DEFAULT 0,
  `total_calls` int(9) unsigned DEFAULT 0,
  KEY `stats_date` (`stats_date`),
  KEY `stats_flag` (`stats_flag`),
  KEY `campaign_id` (`campaign_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_daily_ra_stats` (
  `stats_date` date NOT NULL,
  `stats_flag` enum('OPEN','CLOSED','CLOSING') COLLATE utf8_unicode_ci DEFAULT 'CLOSED',
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `update_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `closed_time` datetime DEFAULT NULL,
  `max_calls` mediumint(8) unsigned DEFAULT 0,
  `total_calls` int(9) unsigned DEFAULT 0,
  KEY `stats_date` (`stats_date`),
  KEY `stats_flag` (`stats_flag`),
  KEY `user` (`user`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_dial_log` (
  `caller_code` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_date` datetime DEFAULT NULL,
  `extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `context` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `timeout` mediumint(7) unsigned DEFAULT 0,
  `outbound_cid` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `sip_hangup_cause` smallint(4) unsigned DEFAULT 0,
  `sip_hangup_reason` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  KEY `caller_code` (`caller_code`),
  KEY `call_date` (`call_date`),
  KEY `vddllid` (`lead_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_dial_log_archive` (
  `caller_code` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_date` datetime DEFAULT NULL,
  `extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `context` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `timeout` mediumint(7) unsigned DEFAULT 0,
  `outbound_cid` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `sip_hangup_cause` smallint(4) unsigned DEFAULT 0,
  `sip_hangup_reason` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  UNIQUE KEY `vddla` (`caller_code`,`call_date`),
  KEY `caller_code` (`caller_code`),
  KEY `call_date` (`call_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_did_agent_log` (
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `caller_id_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `caller_id_name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_date` datetime DEFAULT NULL,
  `did_id` varchar(9) COLLATE utf8_unicode_ci DEFAULT '',
  `did_description` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `did_route` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `group_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'VDCL',
  KEY `uniqueid` (`uniqueid`),
  KEY `caller_id_number` (`caller_id_number`),
  KEY `extension` (`extension`),
  KEY `call_date` (`call_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_did_agent_log_archive` (
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `caller_id_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `caller_id_name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_date` datetime DEFAULT NULL,
  `did_id` varchar(9) COLLATE utf8_unicode_ci DEFAULT '',
  `did_description` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `did_route` varchar(9) COLLATE utf8_unicode_ci DEFAULT '',
  `group_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'VDCL',
  UNIQUE KEY `vdala` (`uniqueid`,`call_date`,`did_route`),
  KEY `uniqueid` (`uniqueid`),
  KEY `caller_id_number` (`caller_id_number`),
  KEY `extension` (`extension`),
  KEY `call_date` (`call_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_did_log` (
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `caller_id_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `caller_id_name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_date` datetime DEFAULT NULL,
  `did_id` varchar(9) COLLATE utf8_unicode_ci DEFAULT '',
  `did_route` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  KEY `uniqueid` (`uniqueid`),
  KEY `caller_id_number` (`caller_id_number`),
  KEY `extension` (`extension`),
  KEY `call_date` (`call_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_did_log_archive` (
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `caller_id_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `caller_id_name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_date` datetime DEFAULT NULL,
  `did_id` varchar(9) COLLATE utf8_unicode_ci DEFAULT '',
  `did_route` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  UNIQUE KEY `vdidla_key` (`uniqueid`,`call_date`,`server_ip`),
  KEY `uniqueid` (`uniqueid`),
  KEY `caller_id_number` (`caller_id_number`),
  KEY `extension` (`extension`),
  KEY `call_date` (`call_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_did_ra_extensions` (
  `did_id` int(9) unsigned NOT NULL,
  `user_start` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extension` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `description` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` enum('Y','N','') COLLATE utf8_unicode_ci DEFAULT '',
  `call_count_today` mediumint(7) DEFAULT 0,
  UNIQUE KEY `didraexten` (`did_id`,`user_start`,`extension`),
  KEY `did_id` (`did_id`),
  KEY `user_start` (`user_start`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_dnc` (
  `phone_number` varchar(18) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`phone_number`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_dnc_log` (
  `phone_number` varchar(18) COLLATE utf8_unicode_ci NOT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `action` enum('add','delete') COLLATE utf8_unicode_ci DEFAULT 'add',
  `action_date` datetime NOT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  KEY `phone_number` (`phone_number`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_dnccom_filter_log` (
  `filter_log_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `list_id` bigint(20) unsigned DEFAULT NULL,
  `filter_date` datetime DEFAULT NULL,
  `new_status` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `old_status` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dnccom_data` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`filter_log_id`),
  KEY `lead_id` (`lead_id`),
  KEY `filter_date` (`filter_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_dnccom_scrub_log` (
  `phone_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `scrub_date` datetime NOT NULL,
  `flag_invalid` enum('','0','1') COLLATE utf8_unicode_ci DEFAULT '',
  `flag_dnc` enum('','0','1') COLLATE utf8_unicode_ci DEFAULT '',
  `flag_projdnc` enum('','0','1') COLLATE utf8_unicode_ci DEFAULT '',
  `flag_litigator` enum('','0','1') COLLATE utf8_unicode_ci DEFAULT '',
  `full_response` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  KEY `phone_number` (`phone_number`),
  KEY `scrub_date` (`scrub_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_drop_lists` (
  `dl_id` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `dl_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_run` datetime DEFAULT NULL,
  `dl_server` varchar(30) COLLATE utf8_unicode_ci DEFAULT 'active_voicemail_server',
  `dl_times` varchar(120) COLLATE utf8_unicode_ci DEFAULT '',
  `dl_weekdays` varchar(7) COLLATE utf8_unicode_ci DEFAULT '',
  `dl_monthdays` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `drop_statuses` varchar(255) COLLATE utf8_unicode_ci DEFAULT ' DROP -',
  `list_id` bigint(20) unsigned DEFAULT NULL,
  `duplicate_check` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `run_now_trigger` enum('N','Y') COLLATE utf8_unicode_ci DEFAULT 'N',
  `active` enum('N','Y') COLLATE utf8_unicode_ci DEFAULT 'N',
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  `closer_campaigns` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `dl_minutes` mediumint(6) unsigned DEFAULT 0,
  UNIQUE KEY `dl_id` (`dl_id`),
  KEY `dl_times` (`dl_times`),
  KEY `run_now_trigger` (`run_now_trigger`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_drop_log` (
  `uniqueid` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `drop_date` datetime NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `phone_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `drop_processed` enum('N','Y','U') COLLATE utf8_unicode_ci DEFAULT 'N',
  KEY `drop_date` (`drop_date`),
  KEY `drop_processed` (`drop_processed`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_drop_log_archive` (
  `uniqueid` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `drop_date` datetime NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `phone_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `drop_processed` enum('N','Y','U') COLLATE utf8_unicode_ci DEFAULT 'N',
  UNIQUE KEY `vicidial_drop_log_archive_key` (`drop_date`,`uniqueid`),
  KEY `drop_processed` (`drop_processed`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_drop_rate_groups` (
  `group_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `calls_today` int(9) unsigned DEFAULT 0,
  `answers_today` int(9) unsigned DEFAULT 0,
  `drops_today` double(12,3) DEFAULT 0.000,
  `drops_today_pct` varchar(6) COLLATE utf8_unicode_ci DEFAULT '0',
  `drops_answers_today_pct` varchar(6) COLLATE utf8_unicode_ci DEFAULT '0',
  `answering_machines_today` int(9) unsigned DEFAULT 0,
  `agenthandled_today` int(9) unsigned DEFAULT 0,
  PRIMARY KEY (`group_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_dtmf_log` (
  `dtmf_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dtmf_time` datetime DEFAULT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `digit` varchar(1) COLLATE utf8_unicode_ci DEFAULT '',
  `direction` enum('Received','Sent') COLLATE utf8_unicode_ci DEFAULT 'Received',
  `state` enum('BEGIN','END') COLLATE utf8_unicode_ci DEFAULT 'BEGIN',
  PRIMARY KEY (`dtmf_id`),
  KEY `vicidial_dtmf_uniqueid_key` (`uniqueid`)
) ENGINE=Aria AUTO_INCREMENT=581773 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_email_accounts` (
  `email_account_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `email_account_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_account_description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  `protocol` enum('POP3','IMAP','SMTP') COLLATE utf8_unicode_ci DEFAULT 'IMAP',
  `email_replyto_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_account_server` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_account_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_account_pass` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pop3_auth_mode` enum('BEST','PASS','APOP','CRAM-MD5') COLLATE utf8_unicode_ci DEFAULT 'BEST',
  `active` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `email_frequency_check_mins` tinyint(3) unsigned DEFAULT 5,
  `group_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `default_list_id` bigint(20) unsigned DEFAULT NULL,
  `call_handle_method` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'CID',
  `agent_search_method` enum('LO','LB','SO') COLLATE utf8_unicode_ci DEFAULT 'LB',
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `list_id` bigint(20) unsigned DEFAULT NULL,
  `email_account_type` enum('INBOUND','OUTBOUND') COLLATE utf8_unicode_ci DEFAULT 'INBOUND',
  PRIMARY KEY (`email_account_id`),
  KEY `email_accounts_group_key` (`group_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_email_list` (
  `email_row_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `email_date` datetime DEFAULT NULL,
  `protocol` enum('POP3','IMAP','NONE') COLLATE utf8_unicode_ci DEFAULT 'IMAP',
  `email_to` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_from` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_from_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subject` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `mime_type` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `content_type` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `content_transfer_encoding` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `x_mailer` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `sender_ip` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `message` text CHARACTER SET utf8 DEFAULT NULL,
  `email_account_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `group_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `direction` enum('INBOUND','OUTBOUND') COLLATE utf8_unicode_ci DEFAULT 'INBOUND',
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `xfercallid` int(9) unsigned DEFAULT NULL,
  PRIMARY KEY (`email_row_id`),
  KEY `email_list_account_key` (`email_account_id`),
  KEY `email_list_user_key` (`user`),
  KEY `vicidial_email_lead_id_key` (`lead_id`),
  KEY `vicidial_email_group_key` (`group_id`),
  KEY `vicidial_email_xfer_key` (`xfercallid`)
) ENGINE=Aria AUTO_INCREMENT=1690 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_email_log` (
  `email_log_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email_row_id` int(10) unsigned DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `email_date` datetime DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_to` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `message` text CHARACTER SET utf8 DEFAULT NULL,
  `campaign_id` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attachments` text COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`email_log_id`),
  KEY `vicidial_email_log_lead_id_key` (`lead_id`),
  KEY `vicidial_email_log_email_row_id_key` (`email_row_id`)
) ENGINE=Aria AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_extension_groups` (
  `extension_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `extension_group_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT '8300',
  `rank` mediumint(7) DEFAULT 0,
  `campaign_groups` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_count_today` mediumint(7) DEFAULT 0,
  `last_call_time` datetime DEFAULT NULL,
  `last_callerid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  PRIMARY KEY (`extension_id`),
  KEY `extension_group_id` (`extension_group_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_faillogin_log` (
  `ID` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` int(9) DEFAULT NULL,
  `ip` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `login_time` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_filter_phone_groups` (
  `filter_phone_group_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `filter_phone_group_name` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `filter_phone_group_description` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  KEY `filter_phone_group_id` (`filter_phone_group_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_filter_phone_numbers` (
  `phone_number` varchar(18) COLLATE utf8_unicode_ci NOT NULL,
  `filter_phone_group_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `phonefilter` (`phone_number`,`filter_phone_group_id`),
  KEY `phone_number` (`phone_number`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_grab_call_log` (
  `auto_call_id` int(9) unsigned NOT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_date` datetime DEFAULT NULL,
  `call_time` datetime DEFAULT NULL,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `queue_priority` tinyint(2) DEFAULT 0,
  `call_type` enum('IN','OUT','OUTBALANCE') COLLATE utf8_unicode_ci DEFAULT 'OUT',
  KEY `auto_call_id` (`auto_call_id`),
  KEY `event_date` (`event_date`),
  KEY `user` (`user`),
  KEY `campaign_id` (`campaign_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_hopper` (
  `hopper_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('READY','QUEUE','INCALL','DONE','HOLD','DNC') COLLATE utf8_unicode_ci DEFAULT 'READY',
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `list_id` bigint(20) unsigned NOT NULL,
  `gmt_offset_now` decimal(4,2) DEFAULT 0.00,
  `state` varchar(2) COLLATE utf8_unicode_ci DEFAULT '',
  `alt_dial` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `priority` tinyint(2) DEFAULT 0,
  `source` varchar(1) COLLATE utf8_unicode_ci DEFAULT '',
  `vendor_lead_code` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  PRIMARY KEY (`hopper_id`),
  KEY `lead_id` (`lead_id`)
) ENGINE=MEMORY AUTO_INCREMENT=28729 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_html_cache_stats` (
  `stats_type` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `stats_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `stats_date` datetime NOT NULL,
  `stats_count` int(9) unsigned DEFAULT 0,
  `stats_html` mediumtext COLLATE utf8_unicode_ci DEFAULT NULL,
  UNIQUE KEY `vicidial_html_cache_stats_key` (`stats_type`,`stats_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_inbound_callback_queue` (
  `icbq_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `icbq_date` datetime DEFAULT NULL,
  `icbq_status` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `icbq_phone_number` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `icbq_phone_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `icbq_nextday_choice` enum('Y','N','U') COLLATE utf8_unicode_ci DEFAULT 'U',
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `group_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `queue_priority` tinyint(2) DEFAULT 0,
  `call_date` datetime DEFAULT NULL,
  `gmt_offset_now` decimal(4,2) DEFAULT 0.00,
  `modify_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`icbq_id`),
  KEY `icbq_status` (`icbq_status`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_inbound_callback_queue_archive` (
  `icbq_id` int(9) unsigned NOT NULL,
  `icbq_date` datetime DEFAULT NULL,
  `icbq_status` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `icbq_phone_number` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `icbq_phone_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `icbq_nextday_choice` enum('Y','N','U') COLLATE utf8_unicode_ci DEFAULT 'U',
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `group_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `queue_priority` tinyint(2) DEFAULT 0,
  `call_date` datetime DEFAULT NULL,
  `gmt_offset_now` decimal(4,2) DEFAULT 0.00,
  `modify_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`icbq_id`),
  KEY `icbq_status` (`icbq_status`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_inbound_dids` (
  `did_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `did_pattern` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `did_description` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `did_active` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `did_route` enum('EXTEN','VOICEMAIL','AGENT','PHONE','IN_GROUP','CALLMENU','VMAIL_NO_INST') COLLATE utf8_unicode_ci DEFAULT 'EXTEN',
  `extension` varchar(50) COLLATE utf8_unicode_ci DEFAULT '9998811112',
  `exten_context` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'default',
  `voicemail_ext` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_unavailable_action` enum('IN_GROUP','EXTEN','VOICEMAIL','PHONE','VMAIL_NO_INST') COLLATE utf8_unicode_ci DEFAULT 'VOICEMAIL',
  `user_route_settings_ingroup` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'AGENTDIRECT',
  `group_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_handle_method` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'CID',
  `agent_search_method` enum('LO','LB','SO') COLLATE utf8_unicode_ci DEFAULT 'LB',
  `list_id` bigint(20) unsigned DEFAULT 999,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT '1',
  `menu_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `record_call` enum('Y','N','Y_QUEUESTOP') COLLATE utf8_unicode_ci DEFAULT 'N',
  `filter_inbound_number` enum('DISABLED','GROUP','URL','DNC_INTERNAL','DNC_CAMPAIGN','GROUP_AREACODE') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `filter_phone_group_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `filter_url` varchar(1000) COLLATE utf8_unicode_ci DEFAULT '',
  `filter_action` enum('EXTEN','VOICEMAIL','AGENT','PHONE','IN_GROUP','CALLMENU','VMAIL_NO_INST') COLLATE utf8_unicode_ci DEFAULT 'EXTEN',
  `filter_extension` varchar(50) COLLATE utf8_unicode_ci DEFAULT '9998811112',
  `filter_exten_context` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'default',
  `filter_voicemail_ext` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `filter_phone` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `filter_server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `filter_user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `filter_user_unavailable_action` enum('IN_GROUP','EXTEN','VOICEMAIL','PHONE','VMAIL_NO_INST') COLLATE utf8_unicode_ci DEFAULT 'VOICEMAIL',
  `filter_user_route_settings_ingroup` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'AGENTDIRECT',
  `filter_group_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `filter_call_handle_method` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'CID',
  `filter_agent_search_method` enum('LO','LB','SO') COLLATE utf8_unicode_ci DEFAULT 'LB',
  `filter_list_id` bigint(20) unsigned DEFAULT 999,
  `filter_campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `filter_phone_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT '1',
  `filter_menu_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `filter_clean_cid_number` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `custom_one` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `custom_two` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `custom_three` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `custom_four` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `custom_five` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  `filter_dnc_campaign` varchar(8) COLLATE utf8_unicode_ci DEFAULT '',
  `filter_url_did_redirect` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `no_agent_ingroup_redirect` enum('DISABLED','Y','NO_PAUSED','READY_ONLY') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `no_agent_ingroup_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `no_agent_ingroup_extension` varchar(50) COLLATE utf8_unicode_ci DEFAULT '9998811112',
  `pre_filter_phone_group_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `pre_filter_extension` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `entry_list_id` bigint(20) unsigned DEFAULT 0,
  `filter_entry_list_id` bigint(20) unsigned DEFAULT 0,
  `max_queue_ingroup_calls` smallint(5) DEFAULT 0,
  `max_queue_ingroup_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `max_queue_ingroup_extension` varchar(50) COLLATE utf8_unicode_ci DEFAULT '9998811112',
  `did_carrier_description` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  PRIMARY KEY (`did_id`),
  UNIQUE KEY `did_pattern` (`did_pattern`),
  KEY `group_id` (`group_id`)
) ENGINE=Aria AUTO_INCREMENT=1762 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_inbound_group_agents` (
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `group_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `group_rank` tinyint(1) DEFAULT 0,
  `group_weight` tinyint(1) DEFAULT 0,
  `calls_today` smallint(5) unsigned DEFAULT 0,
  `group_web_vars` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `group_grade` tinyint(2) unsigned DEFAULT 1,
  `group_type` varchar(1) COLLATE utf8_unicode_ci DEFAULT 'C',
  `calls_today_filtered` smallint(5) unsigned DEFAULT 0,
  UNIQUE KEY `viga_user_group_id` (`user`,`group_id`),
  KEY `group_id` (`group_id`),
  KEY `user` (`user`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_inbound_groups` (
  `group_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `group_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `group_color` varchar(7) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT NULL,
  `web_form_address` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `voicemail_ext` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `next_agent_call` varchar(40) COLLATE utf8_unicode_ci DEFAULT 'longest_wait_time',
  `fronter_display` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `ingroup_script` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `get_call_launch` enum('NONE','SCRIPT','SCRIPTTWO','WEBFORM','WEBFORMTWO','WEBFORMTHREE','FORM','EMAIL') COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `xferconf_a_dtmf` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `xferconf_a_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `xferconf_b_dtmf` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `xferconf_b_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `drop_call_seconds` smallint(4) unsigned DEFAULT 360,
  `drop_action` enum('HANGUP','MESSAGE','VOICEMAIL','IN_GROUP','CALLMENU','VMAIL_NO_INST') COLLATE utf8_unicode_ci DEFAULT 'MESSAGE',
  `drop_exten` varchar(20) COLLATE utf8_unicode_ci DEFAULT '8307',
  `call_time_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT '24hours',
  `after_hours_action` enum('HANGUP','MESSAGE','EXTENSION','VOICEMAIL','IN_GROUP','CALLMENU','VMAIL_NO_INST') COLLATE utf8_unicode_ci DEFAULT 'MESSAGE',
  `after_hours_message_filename` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'vm-goodbye',
  `after_hours_exten` varchar(20) COLLATE utf8_unicode_ci DEFAULT '8300',
  `after_hours_voicemail` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `welcome_message_filename` varchar(255) COLLATE utf8_unicode_ci DEFAULT '---NONE---',
  `moh_context` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'default',
  `onhold_prompt_filename` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'generic_hold',
  `prompt_interval` smallint(5) unsigned DEFAULT 60,
  `agent_alert_exten` varchar(100) COLLATE utf8_unicode_ci DEFAULT 'ding',
  `agent_alert_delay` int(6) DEFAULT 1000,
  `default_xfer_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---NONE---',
  `queue_priority` tinyint(2) DEFAULT 0,
  `drop_inbound_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---NONE---',
  `ingroup_recording_override` enum('DISABLED','NEVER','ONDEMAND','ALLCALLS','ALLFORCE') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `ingroup_rec_filename` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `afterhours_xfer_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---NONE---',
  `qc_enabled` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `qc_statuses` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `qc_shift_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT '24HRMIDNIGHT',
  `qc_get_record_launch` enum('NONE','SCRIPT','WEBFORM','QCSCRIPT','QCWEBFORM') COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `qc_show_recording` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `qc_web_form_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qc_script` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `play_place_in_line` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `play_estimate_hold_time` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `hold_time_option` varchar(30) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `hold_time_option_seconds` smallint(5) DEFAULT 360,
  `hold_time_option_exten` varchar(20) COLLATE utf8_unicode_ci DEFAULT '8300',
  `hold_time_option_voicemail` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `hold_time_option_xfer_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---NONE---',
  `hold_time_option_callback_filename` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'vm-hangup',
  `hold_time_option_callback_list_id` bigint(20) unsigned DEFAULT 999,
  `hold_recall_xfer_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---NONE---',
  `no_delay_call_route` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `play_welcome_message` enum('ALWAYS','NEVER','IF_WAIT_ONLY','YES_UNLESS_NODELAY') COLLATE utf8_unicode_ci DEFAULT 'ALWAYS',
  `answer_sec_pct_rt_stat_one` smallint(5) unsigned DEFAULT 20,
  `answer_sec_pct_rt_stat_two` smallint(5) unsigned DEFAULT 30,
  `default_group_alias` varchar(30) COLLATE utf8_unicode_ci DEFAULT '',
  `no_agent_no_queue` enum('N','Y','NO_PAUSED','NO_READY') COLLATE utf8_unicode_ci DEFAULT 'N',
  `no_agent_action` enum('CALLMENU','INGROUP','DID','MESSAGE','EXTENSION','VOICEMAIL','VMAIL_NO_INST') COLLATE utf8_unicode_ci DEFAULT 'MESSAGE',
  `no_agent_action_value` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'nbdy-avail-to-take-call|vm-goodbye',
  `web_form_address_two` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `timer_action` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `timer_action_message` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `timer_action_seconds` mediumint(7) DEFAULT -1,
  `start_call_url` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `dispo_call_url` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `xferconf_c_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `xferconf_d_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `xferconf_e_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `ignore_list_script_override` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `extension_appended_cidname` enum('Y','N','Y_USER','Y_WITH_CAMPAIGN','Y_USER_WITH_CAMPAIGN') COLLATE utf8_unicode_ci DEFAULT 'N',
  `uniqueid_status_display` enum('DISABLED','ENABLED','ENABLED_PREFIX','ENABLED_PRESERVE') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `uniqueid_status_prefix` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `hold_time_option_minimum` smallint(5) DEFAULT 0,
  `hold_time_option_press_filename` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'to-be-called-back|digits/1',
  `hold_time_option_callmenu` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `hold_time_option_no_block` enum('N','Y') COLLATE utf8_unicode_ci DEFAULT 'N',
  `hold_time_option_prompt_seconds` smallint(5) DEFAULT 10,
  `onhold_prompt_no_block` enum('N','Y') COLLATE utf8_unicode_ci DEFAULT 'N',
  `onhold_prompt_seconds` smallint(5) DEFAULT 10,
  `hold_time_second_option` varchar(30) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `hold_time_third_option` varchar(30) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `wait_hold_option_priority` enum('WAIT','HOLD','BOTH') COLLATE utf8_unicode_ci DEFAULT 'WAIT',
  `wait_time_option` varchar(30) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `wait_time_second_option` varchar(30) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `wait_time_third_option` varchar(30) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `wait_time_option_seconds` smallint(5) DEFAULT 120,
  `wait_time_option_exten` varchar(20) COLLATE utf8_unicode_ci DEFAULT '8300',
  `wait_time_option_voicemail` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `wait_time_option_xfer_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---NONE---',
  `wait_time_option_callmenu` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `wait_time_option_callback_filename` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'vm-hangup',
  `wait_time_option_callback_list_id` bigint(20) unsigned DEFAULT 999,
  `wait_time_option_press_filename` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'to-be-called-back|digits/1',
  `wait_time_option_no_block` enum('N','Y') COLLATE utf8_unicode_ci DEFAULT 'N',
  `wait_time_option_prompt_seconds` smallint(5) DEFAULT 10,
  `timer_action_destination` varchar(30) COLLATE utf8_unicode_ci DEFAULT '',
  `calculate_estimated_hold_seconds` smallint(5) unsigned DEFAULT 0,
  `add_lead_url` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `eht_minimum_prompt_filename` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `eht_minimum_prompt_no_block` enum('N','Y') COLLATE utf8_unicode_ci DEFAULT 'N',
  `eht_minimum_prompt_seconds` smallint(5) DEFAULT 10,
  `on_hook_ring_time` smallint(5) DEFAULT 15,
  `na_call_url` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `on_hook_cid` varchar(30) COLLATE utf8_unicode_ci DEFAULT 'GENERIC',
  `group_calldate` datetime DEFAULT NULL,
  `action_xfer_cid` varchar(18) COLLATE utf8_unicode_ci DEFAULT 'CUSTOMER',
  `drop_callmenu` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `after_hours_callmenu` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  `max_calls_method` enum('TOTAL','IN_QUEUE','DISABLED') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `max_calls_count` smallint(5) DEFAULT 0,
  `max_calls_action` enum('DROP','AFTERHOURS','NO_AGENT_NO_QUEUE','AREACODE_FILTER') COLLATE utf8_unicode_ci DEFAULT 'NO_AGENT_NO_QUEUE',
  `dial_ingroup_cid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `group_handling` enum('PHONE','EMAIL','CHAT') COLLATE utf8_unicode_ci DEFAULT 'PHONE',
  `web_form_address_three` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `populate_lead_ingroup` enum('ENABLED','DISABLED') COLLATE utf8_unicode_ci DEFAULT 'ENABLED',
  `drop_lead_reset` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `after_hours_lead_reset` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `nanq_lead_reset` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `wait_time_lead_reset` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `hold_time_lead_reset` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `status_group_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `routing_initiated_recordings` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `on_hook_cid_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT '',
  `customer_chat_screen_colors` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'default',
  `customer_chat_survey_link` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_chat_survey_text` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `populate_lead_province` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `areacode_filter` enum('DISABLED','ALLOW_ONLY','DROP_ONLY') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `areacode_filter_seconds` smallint(5) DEFAULT 10,
  `areacode_filter_action` enum('CALLMENU','INGROUP','DID','MESSAGE','EXTENSION','VOICEMAIL','VMAIL_NO_INST') COLLATE utf8_unicode_ci DEFAULT 'MESSAGE',
  `areacode_filter_action_value` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'nbdy-avail-to-take-call|vm-goodbye',
  `populate_state_areacode` enum('DISABLED','NEW_LEAD_ONLY','OVERWRITE_ALWAYS') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `custom_one` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `custom_two` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `custom_three` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `custom_four` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `custom_five` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `inbound_survey` enum('DISABLED','ENABLED') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `inbound_survey_filename` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `inbound_survey_accept_digit` varchar(1) COLLATE utf8_unicode_ci DEFAULT '',
  `inbound_survey_question_filename` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `inbound_survey_callmenu` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `icbq_expiration_hours` smallint(5) DEFAULT 96,
  `closing_time_action` varchar(30) COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `closing_time_now_trigger` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `closing_time_filename` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `closing_time_end_filename` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `closing_time_lead_reset` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `closing_time_option_exten` varchar(20) COLLATE utf8_unicode_ci DEFAULT '8300',
  `closing_time_option_callmenu` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `closing_time_option_voicemail` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `closing_time_option_xfer_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---NONE---',
  `closing_time_option_callback_list_id` bigint(20) unsigned DEFAULT 999,
  `add_lead_timezone` enum('SERVER','PHONE_CODE_AREACODE') COLLATE utf8_unicode_ci DEFAULT 'SERVER',
  `icbq_call_time_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT '24hours',
  `icbq_dial_filter` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `pickup_delay` tinyint(4) NOT NULL DEFAULT 0,
  `populate_lead_source` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `populate_lead_vendor` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'INBOUND_NUMBER',
  `park_file_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `waiting_call_url_on` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `waiting_call_url_off` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `waiting_call_count` smallint(5) unsigned DEFAULT 0,
  `enter_ingroup_url` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `cid_cb_confirm_number` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'NO',
  `cid_cb_invalid_filter_phone_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `cid_cb_valid_length` varchar(30) COLLATE utf8_unicode_ci DEFAULT '10',
  `cid_cb_valid_filename` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `cid_cb_confirmed_filename` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `cid_cb_enter_filename` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `cid_cb_you_entered_filename` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `cid_cb_press_to_confirm_filename` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `cid_cb_invalid_filename` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `cid_cb_reenter_filename` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `cid_cb_error_filename` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `group_exten` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `place_in_line_caller_number_filename` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `place_in_line_you_next_filename` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `ingroup_script_two` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `acr_id` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`group_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_inbound_survey_log` (
  `uniqueid` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `call_date` datetime DEFAULT NULL,
  `participate` enum('N','Y') COLLATE utf8_unicode_ci DEFAULT 'N',
  `played` enum('N','R','Y') COLLATE utf8_unicode_ci DEFAULT 'N',
  `dtmf_response` varchar(1) COLLATE utf8_unicode_ci DEFAULT '',
  `next_call_menu` text COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `call_date` (`call_date`),
  KEY `lead_id` (`lead_id`),
  KEY `uniqueid` (`uniqueid`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_inbound_survey_log_archive` (
  `uniqueid` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `call_date` datetime DEFAULT NULL,
  `participate` enum('N','Y') COLLATE utf8_unicode_ci DEFAULT 'N',
  `played` enum('N','R','Y') COLLATE utf8_unicode_ci DEFAULT 'N',
  `dtmf_response` varchar(1) COLLATE utf8_unicode_ci DEFAULT '',
  `next_call_menu` text COLLATE utf8_unicode_ci DEFAULT NULL,
  UNIQUE KEY `visla_key` (`uniqueid`,`call_date`,`campaign_id`,`lead_id`),
  KEY `call_date` (`call_date`),
  KEY `lead_id` (`lead_id`),
  KEY `uniqueid` (`uniqueid`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_ingroup_hour_counts` (
  `group_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_hour` datetime DEFAULT NULL,
  `next_hour` datetime DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  `type` varchar(22) COLLATE utf8_unicode_ci DEFAULT 'CALLS',
  `calls` int(9) unsigned DEFAULT 0,
  `hr` tinyint(2) DEFAULT 0,
  UNIQUE KEY `vihc_ingr_hour` (`group_id`,`date_hour`,`type`),
  KEY `group_id` (`group_id`),
  KEY `date_hour` (`date_hour`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_ingroup_hour_counts_archive` (
  `group_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_hour` datetime DEFAULT NULL,
  `next_hour` datetime DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  `type` varchar(22) COLLATE utf8_unicode_ci DEFAULT 'CALLS',
  `calls` int(9) unsigned DEFAULT 0,
  `hr` tinyint(2) DEFAULT 0,
  UNIQUE KEY `vihc_ingr_hour` (`group_id`,`date_hour`,`type`),
  KEY `group_id` (`group_id`),
  KEY `date_hour` (`date_hour`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_ip_list_entries` (
  `ip_list_id` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `ip_address` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  KEY `ip_list_id` (`ip_list_id`),
  KEY `ip_address` (`ip_address`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_ip_lists` (
  `ip_list_id` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `ip_list_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` enum('N','Y') COLLATE utf8_unicode_ci DEFAULT 'N',
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  UNIQUE KEY `ip_list_id` (`ip_list_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_ivr` (
  `ivr_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `entry_time` datetime DEFAULT NULL,
  `length_in_sec` smallint(5) unsigned DEFAULT 0,
  `inbound_number` varchar(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `recording_id` int(9) unsigned DEFAULT NULL,
  `recording_filename` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company_id` varchar(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `product_code` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prompt_audio_1` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prompt_response_1` tinyint(1) unsigned DEFAULT 0,
  `prompt_audio_2` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prompt_response_2` tinyint(1) unsigned DEFAULT 0,
  `prompt_audio_3` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prompt_response_3` tinyint(1) unsigned DEFAULT 0,
  `prompt_audio_4` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prompt_response_4` tinyint(1) unsigned DEFAULT 0,
  `prompt_audio_5` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prompt_response_5` tinyint(1) unsigned DEFAULT 0,
  `prompt_audio_6` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prompt_response_6` tinyint(1) unsigned DEFAULT 0,
  `prompt_audio_7` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prompt_response_7` tinyint(1) unsigned DEFAULT 0,
  `prompt_audio_8` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prompt_response_8` tinyint(1) unsigned DEFAULT 0,
  `prompt_audio_9` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prompt_response_9` tinyint(1) unsigned DEFAULT 0,
  `prompt_audio_10` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prompt_response_10` tinyint(1) unsigned DEFAULT 0,
  `prompt_audio_11` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prompt_response_11` tinyint(1) unsigned DEFAULT 0,
  `prompt_audio_12` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prompt_response_12` tinyint(1) unsigned DEFAULT 0,
  `prompt_audio_13` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prompt_response_13` tinyint(1) unsigned DEFAULT 0,
  `prompt_audio_14` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prompt_response_14` tinyint(1) unsigned DEFAULT 0,
  `prompt_audio_15` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prompt_response_15` tinyint(1) unsigned DEFAULT 0,
  `prompt_audio_16` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prompt_response_16` tinyint(1) unsigned DEFAULT 0,
  `prompt_audio_17` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prompt_response_17` tinyint(1) unsigned DEFAULT 0,
  `prompt_audio_18` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prompt_response_18` tinyint(1) unsigned DEFAULT 0,
  `prompt_audio_19` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prompt_response_19` tinyint(1) unsigned DEFAULT 0,
  `prompt_audio_20` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prompt_response_20` tinyint(1) unsigned DEFAULT 0,
  PRIMARY KEY (`ivr_id`),
  KEY `phone_number` (`phone_number`),
  KEY `entry_time` (`entry_time`)
) ENGINE=Aria AUTO_INCREMENT=1000000 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_ivr_response` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `btn` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `question` int(11) DEFAULT NULL,
  `response` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uniqueid` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `campaign` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_created` (`question`,`uniqueid`,`campaign`,`created`),
  KEY `lead_id` (`lead_id`)
) ENGINE=Aria AUTO_INCREMENT=1624 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_language_phrases` (
  `phrase_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `english_text` varchar(10000) COLLATE utf8_unicode_ci DEFAULT '',
  `translated_text` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `source` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `modify_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`phrase_id`),
  KEY `language_id` (`language_id`),
  KEY `english_text` (`english_text`(333))
) ENGINE=Aria AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_languages` (
  `language_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `language_code` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `language_description` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  `modify_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `active` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  UNIQUE KEY `language_id` (`language_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_lead_call_quota_counts` (
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `list_id` bigint(20) unsigned DEFAULT 0,
  `first_call_date` datetime DEFAULT NULL,
  `last_call_date` datetime DEFAULT NULL,
  `status` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `called_count` smallint(5) unsigned DEFAULT 0,
  `session_one_calls` tinyint(3) DEFAULT 0,
  `session_two_calls` tinyint(3) DEFAULT 0,
  `session_three_calls` tinyint(3) DEFAULT 0,
  `session_four_calls` tinyint(3) DEFAULT 0,
  `session_five_calls` tinyint(3) DEFAULT 0,
  `session_six_calls` tinyint(3) DEFAULT 0,
  `day_one_calls` tinyint(3) DEFAULT 0,
  `day_two_calls` tinyint(3) DEFAULT 0,
  `day_three_calls` tinyint(3) DEFAULT 0,
  `day_four_calls` tinyint(3) DEFAULT 0,
  `day_five_calls` tinyint(3) DEFAULT 0,
  `day_six_calls` tinyint(3) DEFAULT 0,
  `day_seven_calls` tinyint(3) DEFAULT 0,
  `session_one_today_calls` tinyint(3) DEFAULT 0,
  `session_two_today_calls` tinyint(3) DEFAULT 0,
  `session_three_today_calls` tinyint(3) DEFAULT 0,
  `session_four_today_calls` tinyint(3) DEFAULT 0,
  `session_five_today_calls` tinyint(3) DEFAULT 0,
  `session_six_today_calls` tinyint(3) DEFAULT 0,
  `rank` smallint(5) NOT NULL DEFAULT 0,
  `modify_date` datetime DEFAULT NULL,
  UNIQUE KEY `vlcqc_lead_list` (`lead_id`,`list_id`),
  KEY `last_call_date` (`last_call_date`),
  KEY `list_id` (`list_id`),
  KEY `modify_date` (`modify_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_lead_call_quota_counts_archive` (
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `list_id` bigint(20) unsigned DEFAULT 0,
  `first_call_date` datetime DEFAULT NULL,
  `last_call_date` datetime DEFAULT NULL,
  `status` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `called_count` smallint(5) unsigned DEFAULT 0,
  `session_one_calls` tinyint(3) DEFAULT 0,
  `session_two_calls` tinyint(3) DEFAULT 0,
  `session_three_calls` tinyint(3) DEFAULT 0,
  `session_four_calls` tinyint(3) DEFAULT 0,
  `session_five_calls` tinyint(3) DEFAULT 0,
  `session_six_calls` tinyint(3) DEFAULT 0,
  `day_one_calls` tinyint(3) DEFAULT 0,
  `day_two_calls` tinyint(3) DEFAULT 0,
  `day_three_calls` tinyint(3) DEFAULT 0,
  `day_four_calls` tinyint(3) DEFAULT 0,
  `day_five_calls` tinyint(3) DEFAULT 0,
  `day_six_calls` tinyint(3) DEFAULT 0,
  `day_seven_calls` tinyint(3) DEFAULT 0,
  `session_one_today_calls` tinyint(3) DEFAULT 0,
  `session_two_today_calls` tinyint(3) DEFAULT 0,
  `session_three_today_calls` tinyint(3) DEFAULT 0,
  `session_four_today_calls` tinyint(3) DEFAULT 0,
  `session_five_today_calls` tinyint(3) DEFAULT 0,
  `session_six_today_calls` tinyint(3) DEFAULT 0,
  `rank` smallint(5) NOT NULL DEFAULT 0,
  `modify_date` datetime DEFAULT NULL,
  UNIQUE KEY `vlcqc_lead_date` (`lead_id`,`first_call_date`),
  KEY `first_call_date` (`first_call_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_lead_filters` (
  `lead_filter_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `lead_filter_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `lead_filter_comments` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lead_filter_sql` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  PRIMARY KEY (`lead_filter_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_lead_recycle` (
  `recycle_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `attempt_delay` smallint(5) unsigned DEFAULT 1800,
  `attempt_maximum` tinyint(3) unsigned DEFAULT 2,
  `active` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  PRIMARY KEY (`recycle_id`),
  KEY `campaign_id` (`campaign_id`)
) ENGINE=Aria AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_lead_search_log` (
  `search_log_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `user` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `event_date` datetime NOT NULL,
  `source` varchar(10) COLLATE utf8_unicode_ci DEFAULT '',
  `search_query` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `results` int(9) unsigned DEFAULT 0,
  `seconds` mediumint(7) unsigned DEFAULT 0,
  PRIMARY KEY (`search_log_id`),
  KEY `user` (`user`),
  KEY `event_date` (`event_date`)
) ENGINE=Aria AUTO_INCREMENT=39904 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_lead_search_log_archive` (
  `search_log_id` int(9) unsigned NOT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `event_date` datetime NOT NULL,
  `source` varchar(10) COLLATE utf8_unicode_ci DEFAULT '',
  `search_query` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `results` int(9) unsigned DEFAULT 0,
  `seconds` mediumint(7) unsigned DEFAULT 0,
  PRIMARY KEY (`search_log_id`),
  KEY `user` (`user`),
  KEY `event_date` (`event_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_list` (
  `lead_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `entry_date` datetime DEFAULT NULL,
  `modify_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vendor_lead_code` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `list_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `gmt_offset_now` decimal(4,2) DEFAULT 0.00,
  `called_since_last_reset` enum('Y','N','Y1','Y2','Y3','Y4','Y5','Y6','Y7','Y8','Y9','Y10') COLLATE utf8_unicode_ci DEFAULT 'N',
  `phone_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(18) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `middle_initial` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address1` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address2` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address3` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `province` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postal_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` enum('M','F','U') COLLATE utf8_unicode_ci DEFAULT 'U',
  `date_of_birth` date DEFAULT NULL,
  `alt_phone` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(70) COLLATE utf8_unicode_ci DEFAULT NULL,
  `security_phrase` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comments` varchar(4096) COLLATE utf8_unicode_ci DEFAULT NULL,
  `called_count` smallint(5) unsigned DEFAULT 0,
  `last_local_call_time` datetime DEFAULT NULL,
  `rank` smallint(5) NOT NULL DEFAULT 0,
  `owner` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `entry_list_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `coord_one` point DEFAULT NULL,
  `coord_two` point DEFAULT NULL,
  `address_source` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LastVKDate` date DEFAULT NULL,
  `LastVK` decimal(10,2) DEFAULT 0.00,
  `HighVK` decimal(10,2) DEFAULT 0.00,
  `AnzVK` int(11) NOT NULL,
  `AnzStorno` int(11) DEFAULT 0,
  `sperr_list_id` bigint(20) DEFAULT NULL,
  `sperr_owner` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sperr_status` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sperr_type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lead_id`),
  KEY `phone_number` (`phone_number`),
  KEY `list_id` (`list_id`),
  KEY `called_since_last_reset` (`called_since_last_reset`),
  KEY `status` (`status`),
  KEY `gmt_offset_now` (`gmt_offset_now`),
  KEY `postal_code` (`postal_code`),
  KEY `last_local_call_time` (`last_local_call_time`),
  KEY `rank` (`rank`),
  KEY `owner` (`owner`),
  KEY `phone_list` (`phone_number`,`list_id`),
  KEY `list_phone` (`list_id`,`phone_number`),
  KEY `list_status` (`list_id`,`status`),
  KEY `modify_date` (`modify_date`),
  KEY `Called_status` (`called_since_last_reset`,`status`),
  KEY `alt_phone` (`alt_phone`),
  KEY `Owner_status` (`owner`,`status`),
  KEY `VK_Date` (`LastVKDate`),
  KEY `MaxVK` (`HighVK`),
  KEY `AnzVK` (`AnzVK`)
) ENGINE=Aria AUTO_INCREMENT=6996130 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadmin`@`%`*/ /*!50003 TRIGGER `LogListChanges` AFTER UPDATE ON `vicidial_list` FOR EACH ROW IF (((NEW.list_id <=> OLD.list_id) = 0) OR ((NEW.owner <=> OLD.owner) = 0) OR ((NEW.status <=> OLD.status) = 0)) THEN
  INSERT INTO snctdialer_list_log (LeadID, Change_date, Old_Listid, New_Listid, Old_Owner, New_Owner, Old_Status, New_Status )
VALUES(NEW.lead_id, NOW(), OLD.list_id, NEW.list_id, OLD.owner, NEW.owner, OLD.status, NEW.status);
END IF */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_list_alt_phones` (
  `alt_phone_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `phone_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `alt_phone_note` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `alt_phone_count` smallint(5) unsigned DEFAULT NULL,
  `active` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  PRIMARY KEY (`alt_phone_id`),
  KEY `lead_id` (`lead_id`),
  KEY `phone_number` (`phone_number`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_list_log` (
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `entry_date` datetime DEFAULT NULL,
  `modify_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vendor_lead_code` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `list_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `gmt_offset_now` decimal(4,2) DEFAULT 0.00,
  `called_since_last_reset` enum('Y','N','Y1','Y2','Y3','Y4','Y5','Y6','Y7','Y8','Y9','Y10') COLLATE utf8_unicode_ci DEFAULT 'N',
  `phone_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(18) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `middle_initial` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address1` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address2` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address3` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `province` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postal_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` enum('M','F','U') COLLATE utf8_unicode_ci DEFAULT 'U',
  `date_of_birth` date DEFAULT NULL,
  `alt_phone` varchar(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(70) COLLATE utf8_unicode_ci DEFAULT NULL,
  `security_phrase` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comments` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `called_count` smallint(5) unsigned DEFAULT 0,
  `last_local_call_time` datetime DEFAULT NULL,
  `rank` smallint(5) NOT NULL DEFAULT 0,
  `owner` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `entry_list_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  KEY `phone_number` (`phone_number`),
  KEY `list_id` (`list_id`),
  KEY `called_since_last_reset` (`called_since_last_reset`),
  KEY `status` (`status`),
  KEY `gmt_offset_now` (`gmt_offset_now`),
  KEY `postal_code` (`postal_code`),
  KEY `last_local_call_time` (`last_local_call_time`),
  KEY `rank` (`rank`),
  KEY `owner` (`owner`),
  KEY `phone_list` (`phone_number`,`list_id`),
  KEY `list_phone` (`list_id`,`phone_number`),
  KEY `list_status` (`list_id`,`status`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_list_pins` (
  `pins_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `entry_time` datetime DEFAULT NULL,
  `phone_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `product_code` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `digits` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`pins_id`),
  KEY `lead_id` (`lead_id`),
  KEY `phone_number` (`phone_number`),
  KEY `entry_time` (`entry_time`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_list_test` (
  `lead_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `entry_date` datetime DEFAULT NULL,
  `modify_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vendor_lead_code` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `list_id` bigint(14) unsigned NOT NULL DEFAULT 0,
  `gmt_offset_now` decimal(4,2) DEFAULT 0.00,
  `called_since_last_reset` enum('Y','N','Y1','Y2','Y3','Y4','Y5','Y6','Y7','Y8','Y9','Y10') COLLATE utf8_unicode_ci DEFAULT 'N',
  `phone_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(18) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `middle_initial` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address1` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address2` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address3` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `province` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postal_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_code` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` enum('M','F','U') COLLATE utf8_unicode_ci DEFAULT 'U',
  `date_of_birth` date DEFAULT NULL,
  `alt_phone` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(70) COLLATE utf8_unicode_ci DEFAULT NULL,
  `security_phrase` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comments` varchar(4096) COLLATE utf8_unicode_ci DEFAULT NULL,
  `called_count` smallint(5) unsigned DEFAULT 0,
  `last_local_call_time` datetime DEFAULT NULL,
  `rank` smallint(5) NOT NULL DEFAULT 0,
  `owner` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `entry_list_id` bigint(14) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`lead_id`),
  KEY `phone_number` (`phone_number`),
  KEY `list_id` (`list_id`),
  KEY `called_since_last_reset` (`called_since_last_reset`),
  KEY `status` (`status`),
  KEY `gmt_offset_now` (`gmt_offset_now`),
  KEY `postal_code` (`postal_code`),
  KEY `last_local_call_time` (`last_local_call_time`),
  KEY `rank` (`rank`),
  KEY `owner` (`owner`),
  KEY `phone_list` (`phone_number`,`list_id`),
  KEY `list_phone` (`list_id`,`phone_number`),
  KEY `list_status` (`list_id`,`status`)
) ENGINE=Aria AUTO_INCREMENT=4253289 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_list_update_log` (
  `event_date` datetime DEFAULT NULL,
  `lead_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vendor_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `old_status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `result` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `result_rows` smallint(3) unsigned DEFAULT 0,
  `list_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `event_date` (`event_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_lists` (
  `list_id` bigint(20) unsigned NOT NULL,
  `list_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT NULL,
  `list_description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `list_changedate` datetime DEFAULT NULL,
  `list_lastcalldate` datetime DEFAULT NULL,
  `reset_time` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `agent_script_override` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `campaign_cid_override` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `am_message_exten_override` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `drop_inbound_group_override` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `xferconf_a_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `xferconf_b_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `xferconf_c_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `xferconf_d_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `xferconf_e_number` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `web_form_address` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `web_form_address_two` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `time_zone_setting` enum('COUNTRY_AND_AREA_CODE','POSTAL_CODE','NANPA_PREFIX','OWNER_TIME_ZONE_CODE') COLLATE utf8_unicode_ci DEFAULT 'COUNTRY_AND_AREA_CODE',
  `inventory_report` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `expiration_date` date DEFAULT '2099-12-31',
  `na_call_url` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `local_call_time` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'campaign',
  `web_form_address_three` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `status_group_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `user_new_lead_limit` smallint(5) DEFAULT -1,
  `custom_one` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `custom_two` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `custom_three` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `custom_four` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `custom_five` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `inbound_list_script_override` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `default_xfer_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---NONE---',
  `daily_reset_limit` smallint(5) DEFAULT -1,
  `resets_today` smallint(5) unsigned DEFAULT 0,
  `auto_active_list_rank` smallint(5) DEFAULT 0,
  `cache_count` int(9) unsigned DEFAULT 0,
  `cache_count_new` int(9) unsigned DEFAULT 0,
  `cache_count_dialable_new` int(9) unsigned DEFAULT 0,
  `cache_date` datetime DEFAULT NULL,
  PRIMARY KEY (`list_id`),
  KEY `campaign_active` (`campaign_id`,`active`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci PAGE_CHECKSUM=1 ROW_FORMAT=PAGE;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_lists_custom` (
  `list_id` bigint(20) unsigned NOT NULL,
  `audit_comments` tinyint(1) DEFAULT NULL COMMENT 'visible',
  `audit_comments_enabled` tinyint(1) DEFAULT NULL COMMENT 'invisible',
  PRIMARY KEY (`list_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_lists_fields` (
  `field_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `list_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `field_label` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_name` varchar(5000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_description` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_rank` smallint(5) DEFAULT NULL,
  `field_help` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_type` enum('TEXT','AREA','SELECT','MULTI','RADIO','CHECKBOX','DATE','TIME','DISPLAY','SCRIPT','HIDDEN','READONLY','HIDEBLOB','SWITCH') COLLATE utf8_unicode_ci DEFAULT 'TEXT',
  `field_options` varchar(5000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_size` smallint(5) DEFAULT NULL,
  `field_max` smallint(5) DEFAULT NULL,
  `field_default` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_cost` smallint(5) DEFAULT NULL,
  `field_required` enum('Y','N','INBOUND_ONLY') COLLATE utf8_unicode_ci DEFAULT 'N',
  `name_position` enum('LEFT','TOP') COLLATE utf8_unicode_ci DEFAULT 'LEFT',
  `multi_position` enum('HORIZONTAL','VERTICAL') COLLATE utf8_unicode_ci DEFAULT 'HORIZONTAL',
  `field_order` smallint(5) DEFAULT 1,
  `field_encrypt` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `field_show_hide` enum('DISABLED','X_OUT_ALL','LAST_1','LAST_2','LAST_3','LAST_4','FIRST_1_LAST_4') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `field_duplicate` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  PRIMARY KEY (`field_id`),
  UNIQUE KEY `listfield` (`list_id`,`field_label`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_live_agents` (
  `live_agent_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `conf_exten` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('READY','QUEUE','INCALL','PAUSED','CLOSER','MQUEUE') COLLATE utf8_unicode_ci DEFAULT 'PAUSED',
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `callerid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `random_id` int(8) unsigned DEFAULT NULL,
  `last_call_time` datetime DEFAULT NULL,
  `last_update_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_call_finish` datetime DEFAULT NULL,
  `closer_campaigns` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_level` tinyint(3) unsigned DEFAULT 0,
  `comments` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `campaign_weight` tinyint(1) DEFAULT 0,
  `calls_today` smallint(5) unsigned DEFAULT 0,
  `external_hangup` varchar(1) COLLATE utf8_unicode_ci DEFAULT '',
  `external_status` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `external_pause` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `external_dial` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `external_ingroups` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `external_blended` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `external_igb_set_user` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `external_update_fields` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `external_update_fields_data` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `external_timer_action` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `external_timer_action_message` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `external_timer_action_seconds` mediumint(7) DEFAULT -1,
  `agent_log_id` int(9) unsigned DEFAULT 0,
  `last_state_change` datetime DEFAULT NULL,
  `agent_territories` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `outbound_autodial` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `manager_ingroup_set` enum('Y','N','SET') COLLATE utf8_unicode_ci DEFAULT 'N',
  `ra_user` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `ra_extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `external_dtmf` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `external_transferconf` varchar(120) COLLATE utf8_unicode_ci DEFAULT '',
  `external_park` varchar(40) COLLATE utf8_unicode_ci DEFAULT '',
  `external_timer_action_destination` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `on_hook_agent` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `on_hook_ring_time` smallint(5) DEFAULT 15,
  `ring_callerid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `last_inbound_call_time` datetime DEFAULT NULL,
  `last_inbound_call_finish` datetime DEFAULT NULL,
  `campaign_grade` tinyint(2) unsigned DEFAULT 1,
  `external_recording` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `external_pause_code` varchar(6) COLLATE utf8_unicode_ci DEFAULT '',
  `pause_code` varchar(6) COLLATE utf8_unicode_ci DEFAULT '',
  `preview_lead_id` bigint(20) unsigned DEFAULT NULL,
  `external_lead_id` bigint(20) unsigned DEFAULT NULL,
  `on_hook_saved_status` enum('READY','CLOSER','PAUSED','LOGIN') COLLATE utf8_unicode_ci DEFAULT NULL,
  `on_hook_auto_answer` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `auto_answer_prefix` varchar(4) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `last_inbound_call_time_filtered` datetime DEFAULT NULL,
  `last_inbound_call_finish_filtered` datetime DEFAULT NULL,
  PRIMARY KEY (`live_agent_id`),
  KEY `random_id` (`random_id`),
  KEY `last_call_time` (`last_call_time`),
  KEY `last_update_time` (`last_update_time`),
  KEY `last_call_finish` (`last_call_finish`),
  KEY `vlali` (`lead_id`),
  KEY `vlaus` (`user`)
) ENGINE=Aria AUTO_INCREMENT=16060 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_live_chats` (
  `chat_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `chat_start_time` datetime DEFAULT NULL,
  `status` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `chat_creator` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `group_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `transferring_agent` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_direct` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_direct_group_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`chat_id`),
  KEY `vicidial_live_chats_lead_id_key` (`lead_id`),
  KEY `vicidial_live_chats_start_time_key` (`chat_start_time`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_live_inbound_agents` (
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `group_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `group_weight` tinyint(1) DEFAULT 0,
  `calls_today` smallint(5) unsigned DEFAULT 0,
  `last_call_time` datetime DEFAULT NULL,
  `last_call_finish` datetime DEFAULT NULL,
  `group_grade` tinyint(2) unsigned DEFAULT 1,
  `calls_today_filtered` smallint(5) unsigned DEFAULT 0,
  `last_call_time_filtered` datetime DEFAULT NULL,
  `last_call_finish_filtered` datetime DEFAULT NULL,
  UNIQUE KEY `vlia_user_group_id` (`user`,`group_id`),
  KEY `group_id` (`group_id`),
  KEY `group_weight` (`group_weight`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_log` (
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `list_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_date` datetime DEFAULT NULL,
  `start_epoch` int(10) unsigned DEFAULT NULL,
  `end_epoch` int(10) unsigned DEFAULT NULL,
  `length_in_sec` int(10) DEFAULT NULL,
  `status` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comments` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `processed` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `term_reason` enum('CALLER','AGENT','QUEUETIMEOUT','ABANDON','AFTERHOURS','NONE','SYSTEM') COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `alt_dial` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `called_count` smallint(5) unsigned DEFAULT 0,
  PRIMARY KEY (`uniqueid`),
  KEY `lead_id` (`lead_id`),
  KEY `call_date` (`call_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_log_archive` (
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `list_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_date` datetime DEFAULT NULL,
  `start_epoch` int(10) unsigned DEFAULT NULL,
  `end_epoch` int(10) unsigned DEFAULT NULL,
  `length_in_sec` int(10) DEFAULT NULL,
  `status` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comments` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `processed` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `term_reason` enum('CALLER','AGENT','QUEUETIMEOUT','ABANDON','AFTERHOURS','NONE','SYSTEM') COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `alt_dial` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `called_count` smallint(5) unsigned DEFAULT 0,
  PRIMARY KEY (`uniqueid`),
  KEY `lead_id` (`lead_id`),
  KEY `call_date` (`call_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_log_extended` (
  `uniqueid` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_date` datetime DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `caller_code` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `custom_call_id` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `start_url_processed` enum('N','Y','U') COLLATE utf8_unicode_ci DEFAULT 'N',
  `dispo_url_processed` enum('N','Y','U','XY','XU') COLLATE utf8_unicode_ci DEFAULT 'N',
  `multi_alt_processed` enum('N','Y','U') COLLATE utf8_unicode_ci DEFAULT 'N',
  `noanswer_processed` enum('N','Y','U') COLLATE utf8_unicode_ci DEFAULT 'N',
  PRIMARY KEY (`uniqueid`),
  KEY `call_date` (`call_date`),
  KEY `vlecc` (`caller_code`),
  KEY `vle_lead_id` (`lead_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_log_extended_archive` (
  `uniqueid` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_date` datetime DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `caller_code` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `custom_call_id` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `start_url_processed` enum('N','Y','U') COLLATE utf8_unicode_ci DEFAULT 'N',
  `dispo_url_processed` enum('N','Y','U','XY','XU') COLLATE utf8_unicode_ci DEFAULT 'N',
  `multi_alt_processed` enum('N','Y','U') COLLATE utf8_unicode_ci DEFAULT 'N',
  `noanswer_processed` enum('N','Y','U') COLLATE utf8_unicode_ci DEFAULT 'N',
  PRIMARY KEY (`uniqueid`),
  UNIQUE KEY `vlea` (`uniqueid`,`call_date`,`lead_id`),
  KEY `call_date` (`call_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_log_extended_sip` (
  `call_date` datetime(6) DEFAULT NULL,
  `caller_code` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `invite_to_ring` decimal(10,6) DEFAULT 0.000000,
  `ring_to_final` decimal(10,6) DEFAULT 0.000000,
  `invite_to_final` decimal(10,6) DEFAULT 0.000000,
  `last_event_code` smallint(3) DEFAULT 0,
  KEY `call_date` (`call_date`),
  KEY `caller_code` (`caller_code`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_log_extended_sip_archive` (
  `call_date` datetime(6) DEFAULT NULL,
  `caller_code` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `invite_to_ring` decimal(10,6) DEFAULT 0.000000,
  `ring_to_final` decimal(10,6) DEFAULT 0.000000,
  `invite_to_final` decimal(10,6) DEFAULT 0.000000,
  `last_event_code` smallint(3) DEFAULT 0,
  UNIQUE KEY `vlesa` (`caller_code`,`call_date`),
  KEY `call_date` (`call_date`),
  KEY `caller_code` (`caller_code`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_log_noanswer` (
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `list_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_date` datetime DEFAULT NULL,
  `start_epoch` int(10) unsigned DEFAULT NULL,
  `end_epoch` int(10) unsigned DEFAULT NULL,
  `length_in_sec` int(10) DEFAULT NULL,
  `status` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comments` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `processed` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `term_reason` enum('CALLER','AGENT','QUEUETIMEOUT','ABANDON','AFTERHOURS','NONE','SYSTEM') COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `alt_dial` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `caller_code` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `lead_id` (`lead_id`),
  KEY `call_date` (`call_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_log_noanswer_archive` (
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `list_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_date` datetime DEFAULT NULL,
  `start_epoch` int(10) unsigned DEFAULT NULL,
  `end_epoch` int(10) unsigned DEFAULT NULL,
  `length_in_sec` int(10) DEFAULT NULL,
  `status` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comments` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `processed` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `term_reason` enum('CALLER','AGENT','QUEUETIMEOUT','ABANDON','AFTERHOURS','NONE','SYSTEM') COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `alt_dial` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `caller_code` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `lead_id` (`lead_id`),
  KEY `call_date` (`call_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_manager` (
  `man_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `entry_date` datetime DEFAULT NULL,
  `status` enum('NEW','QUEUE','SENT','UPDATED','DEAD') COLLATE utf8_unicode_ci DEFAULT NULL,
  `response` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `action` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `callerid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cmd_line_b` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cmd_line_c` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cmd_line_d` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cmd_line_e` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cmd_line_f` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cmd_line_g` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cmd_line_h` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cmd_line_i` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cmd_line_j` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cmd_line_k` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`man_id`),
  KEY `callerid` (`callerid`),
  KEY `uniqueid` (`uniqueid`),
  KEY `serverstat` (`server_ip`,`status`)
) ENGINE=Aria AUTO_INCREMENT=82719814 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_manager_chat_log` (
  `manager_chat_message_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `manager_chat_id` int(10) unsigned DEFAULT NULL,
  `manager_chat_subid` tinyint(3) unsigned DEFAULT NULL,
  `manager` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `message` mediumtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `message_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `message_date` datetime DEFAULT NULL,
  `message_viewed_date` datetime DEFAULT NULL,
  `message_posted_by` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `audio_alerted` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  PRIMARY KEY (`manager_chat_message_id`),
  KEY `manager_chat_id_key` (`manager_chat_id`),
  KEY `manager_chat_subid_key` (`manager_chat_subid`),
  KEY `manager_chat_manager_key` (`manager`),
  KEY `manager_chat_user_key` (`user`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_manager_chat_log_archive` (
  `manager_chat_message_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `manager_chat_id` int(10) unsigned DEFAULT NULL,
  `manager_chat_subid` tinyint(3) unsigned DEFAULT NULL,
  `manager` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `message` mediumtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `message_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `message_date` datetime DEFAULT NULL,
  `message_viewed_date` datetime DEFAULT NULL,
  `message_posted_by` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `audio_alerted` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  PRIMARY KEY (`manager_chat_message_id`),
  KEY `manager_chat_id_archive_key` (`manager_chat_id`),
  KEY `manager_chat_subid_archive_key` (`manager_chat_subid`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_manager_chats` (
  `manager_chat_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `internal_chat_type` enum('AGENT','MANAGER') COLLATE utf8_unicode_ci DEFAULT 'MANAGER',
  `chat_start_date` datetime DEFAULT NULL,
  `manager` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `selected_agents` mediumtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `selected_user_groups` mediumtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `selected_campaigns` mediumtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `allow_replies` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  PRIMARY KEY (`manager_chat_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_manager_chats_archive` (
  `manager_chat_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `internal_chat_type` enum('AGENT','MANAGER') COLLATE utf8_unicode_ci DEFAULT 'MANAGER',
  `chat_start_date` datetime DEFAULT NULL,
  `manager` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `selected_agents` mediumtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `selected_user_groups` mediumtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `selected_campaigns` mediumtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `allow_replies` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  PRIMARY KEY (`manager_chat_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_manual_dial_queue` (
  `mdq_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `entry_time` datetime DEFAULT NULL,
  `status` enum('READY','QUEUE') COLLATE utf8_unicode_ci DEFAULT 'READY',
  `external_dial` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  PRIMARY KEY (`mdq_id`),
  KEY `user` (`user`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_monitor_calls` (
  `monitor_call_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `callerid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `context` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `monitor_time` datetime DEFAULT NULL,
  `user_phone` varchar(10) COLLATE utf8_unicode_ci DEFAULT 'USER',
  `api_log` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `barge_listen` enum('LISTEN','BARGE') COLLATE utf8_unicode_ci DEFAULT 'LISTEN',
  `prepop_id` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `campaigns_limit` varchar(1000) COLLATE utf8_unicode_ci DEFAULT '',
  `users_list` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  PRIMARY KEY (`monitor_call_id`),
  KEY `callerid` (`callerid`),
  KEY `monitor_time` (`monitor_time`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_monitor_log` (
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `callerid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `context` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `monitor_time` datetime DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `user` (`user`),
  KEY `campaign_id` (`campaign_id`),
  KEY `monitor_time` (`monitor_time`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_music_on_hold` (
  `moh_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `moh_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `random` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `remove` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  PRIMARY KEY (`moh_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_music_on_hold_files` (
  `filename` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `moh_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `rank` smallint(5) DEFAULT NULL,
  UNIQUE KEY `mohfile` (`filename`,`moh_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_nanpa_filter_log` (
  `output_code` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'BEGIN',
  `server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT '',
  `list_id` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `leads_count` bigint(14) DEFAULT 0,
  `filter_count` bigint(14) DEFAULT 0,
  `status_line` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `script_output` text COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`output_code`),
  KEY `start_time` (`start_time`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_nanpa_prefix_codes` (
  `areacode` char(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prefix` char(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `GMT_offset` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DST` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT NULL,
  `latitude` varchar(17) COLLATE utf8_unicode_ci DEFAULT NULL,
  `longitude` varchar(17) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `state` varchar(2) COLLATE utf8_unicode_ci DEFAULT '',
  `postal_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT '',
  `country` varchar(2) COLLATE utf8_unicode_ci DEFAULT '',
  `lata_type` varchar(1) COLLATE utf8_unicode_ci DEFAULT '',
  KEY `areaprefix` (`areacode`,`prefix`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_outbound_ivr_log` (
  `uniqueid` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `caller_code` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `event_date` datetime DEFAULT NULL,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `menu_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `menu_action` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  UNIQUE KEY `campserver` (`event_date`,`lead_id`,`menu_id`),
  KEY `event_date` (`event_date`),
  KEY `lead_id` (`lead_id`),
  KEY `campaign_id` (`campaign_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_outbound_ivr_log_archive` (
  `uniqueid` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `caller_code` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `event_date` datetime DEFAULT NULL,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `menu_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `menu_action` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  UNIQUE KEY `campserver` (`event_date`,`lead_id`,`menu_id`),
  KEY `event_date` (`event_date`),
  KEY `lead_id` (`lead_id`),
  KEY `campaign_id` (`campaign_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_override_ids` (
  `id_table` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `active` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `value` int(9) DEFAULT 0,
  PRIMARY KEY (`id_table`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_pause_codes` (
  `pause_code` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `pause_code_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billable` enum('NO','YES','HALF') COLLATE utf8_unicode_ci DEFAULT 'NO',
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `time_limit` smallint(5) unsigned DEFAULT 65000,
  `require_mgr_approval` enum('NO','YES') COLLATE utf8_unicode_ci DEFAULT 'NO',
  KEY `campaign_id` (`campaign_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_pause_codes_gratis` (
  `pause_code` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `pause_code_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billable` enum('NO','YES','HALF') COLLATE utf8_unicode_ci DEFAULT 'NO',
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `campaign_id` (`campaign_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_phone_codes` (
  `country_code` smallint(5) unsigned DEFAULT NULL,
  `country` char(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `areacode` char(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
  `GMT_offset` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DST` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT NULL,
  `DST_range` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `geographic_description` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tz_code` varchar(4) COLLATE utf8_unicode_ci DEFAULT '',
  `php_tz` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  KEY `country_area_code` (`country_code`,`areacode`),
  KEY `country_state` (`country_code`,`state`),
  KEY `country_code` (`country_code`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_postal_codes` (
  `postal_code` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `state` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
  `GMT_offset` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DST` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT NULL,
  `DST_range` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` char(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_code` smallint(5) unsigned DEFAULT NULL,
  KEY `country_postal_code` (`country_code`,`postal_code`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_process_log` (
  `serial_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `run_time` datetime DEFAULT NULL,
  `run_sec` int(11) DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `script` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `process` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `output_lines` mediumtext COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `serial_id` (`serial_id`),
  KEY `run_time` (`run_time`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_process_trigger_log` (
  `trigger_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `trigger_time` datetime DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `trigger_lines` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `trigger_results` mediumtext COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `trigger_id` (`trigger_id`),
  KEY `trigger_time` (`trigger_time`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_process_triggers` (
  `trigger_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `trigger_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `trigger_time` datetime DEFAULT NULL,
  `trigger_run` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `trigger_lines` text COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`trigger_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_qc_agent_log` (
  `qc_agent_log_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `qc_user` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `qc_user_group` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `qc_user_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `lead_user` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `web_server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `view_datetime` datetime NOT NULL,
  `save_datetime` datetime DEFAULT NULL,
  `view_epoch` int(10) unsigned NOT NULL,
  `save_epoch` int(10) unsigned DEFAULT NULL,
  `elapsed_seconds` smallint(5) unsigned DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `list_id` bigint(20) unsigned NOT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `old_status` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `new_status` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `details` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `processed` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`qc_agent_log_id`),
  KEY `view_epoch` (`view_epoch`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_qc_codes` (
  `code` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `code_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qc_result_type` enum('PASS','FAIL','CANCEL','COMMIT') COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_recent_ascb_calls` (
  `call_date` datetime DEFAULT NULL,
  `callback_date` datetime DEFAULT NULL,
  `callback_id` int(9) unsigned DEFAULT 0,
  `caller_code` varchar(30) COLLATE utf8_unicode_ci DEFAULT '',
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `server_ip` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `orig_status` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'CALLBK',
  `reschedule` varchar(10) COLLATE utf8_unicode_ci DEFAULT '',
  `list_id` bigint(20) unsigned DEFAULT NULL,
  `rescheduled` enum('U','P','Y','N') COLLATE utf8_unicode_ci DEFAULT 'U',
  UNIQUE KEY `caller_code` (`caller_code`),
  KEY `call_date` (`call_date`),
  KEY `lead_id` (`lead_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_recent_ascb_calls_archive` (
  `call_date` datetime DEFAULT NULL,
  `callback_date` datetime DEFAULT NULL,
  `callback_id` int(9) unsigned DEFAULT 0,
  `caller_code` varchar(30) COLLATE utf8_unicode_ci DEFAULT '',
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `server_ip` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `orig_status` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'CALLBK',
  `reschedule` varchar(10) COLLATE utf8_unicode_ci DEFAULT '',
  `list_id` bigint(20) unsigned DEFAULT NULL,
  `rescheduled` enum('U','P','Y','N') COLLATE utf8_unicode_ci DEFAULT 'U',
  UNIQUE KEY `caller_code` (`caller_code`),
  KEY `call_date` (`call_date`),
  KEY `lead_id` (`lead_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_recording_access_log` (
  `recording_access_log_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `recording_id` int(10) unsigned DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `access_datetime` datetime DEFAULT NULL,
  `access_result` enum('ACCESSED','INVALID USER','INVALID PERMISSIONS','NO RECORDING','RECORDING UNAVAILABLE') COLLATE utf8_unicode_ci DEFAULT NULL,
  `ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT '',
  PRIMARY KEY (`recording_access_log_id`),
  KEY `recording_id` (`recording_id`),
  KEY `lead_id` (`lead_id`)
) ENGINE=Aria AUTO_INCREMENT=3183 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_remote_agent_log` (
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `callerid` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `ra_user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_time` datetime DEFAULT NULL,
  `extension` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `phone_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT '',
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `processed` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `comment` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  KEY `call_time` (`call_time`),
  KEY `ra_user` (`ra_user`),
  KEY `extension` (`extension`),
  KEY `phone_number` (`phone_number`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_remote_agents` (
  `remote_agent_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `user_start` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `number_of_lines` tinyint(3) unsigned DEFAULT 1,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `conf_exten` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8_unicode_ci DEFAULT 'INACTIVE',
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `closer_campaigns` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `extension_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `extension_group_order` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `on_hook_agent` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `on_hook_ring_time` smallint(5) DEFAULT 15,
  PRIMARY KEY (`remote_agent_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_report_log` (
  `report_log_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `event_date` datetime NOT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `ip_address` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `report_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `browser` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `referer` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `run_time` varchar(20) COLLATE utf8_unicode_ci DEFAULT '0',
  `webserver` smallint(5) unsigned DEFAULT 0,
  PRIMARY KEY (`report_log_id`),
  KEY `user` (`user`),
  KEY `report_name` (`report_name`)
) ENGINE=Aria AUTO_INCREMENT=159694 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_rt_monitor_log` (
  `manager_user` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `manager_server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `manager_phone` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `manager_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `agent_user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `agent_server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `agent_status` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `agent_session` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `caller_code` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `monitor_start_time` datetime DEFAULT NULL,
  `monitor_end_time` datetime DEFAULT NULL,
  `monitor_sec` int(9) unsigned DEFAULT 0,
  `monitor_type` enum('LISTEN','BARGE','HIJACK','WHISPER') COLLATE utf8_unicode_ci DEFAULT 'LISTEN',
  UNIQUE KEY `caller_code` (`caller_code`),
  KEY `manager_user` (`manager_user`),
  KEY `agent_user` (`agent_user`),
  KEY `monitor_start_time` (`monitor_start_time`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_rt_monitor_log_archive` (
  `manager_user` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `manager_server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `manager_phone` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `manager_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `agent_user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `agent_server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `agent_status` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `agent_session` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `caller_code` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `monitor_start_time` datetime DEFAULT NULL,
  `monitor_end_time` datetime DEFAULT NULL,
  `monitor_sec` int(9) unsigned DEFAULT 0,
  `monitor_type` enum('LISTEN','BARGE','HIJACK','WHISPER') COLLATE utf8_unicode_ci DEFAULT 'LISTEN',
  UNIQUE KEY `caller_code` (`caller_code`),
  KEY `manager_user` (`manager_user`),
  KEY `agent_user` (`agent_user`),
  KEY `monitor_start_time` (`monitor_start_time`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_screen_colors` (
  `colors_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `colors_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `menu_background` varchar(6) COLLATE utf8_unicode_ci DEFAULT '015B91',
  `frame_background` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'D9E6FE',
  `std_row1_background` varchar(6) COLLATE utf8_unicode_ci DEFAULT '9BB9FB',
  `std_row2_background` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'B9CBFD',
  `std_row3_background` varchar(6) COLLATE utf8_unicode_ci DEFAULT '8EBCFD',
  `std_row4_background` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'B6D3FC',
  `std_row5_background` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'A3C3D6',
  `alt_row1_background` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'BDFFBD',
  `alt_row2_background` varchar(6) COLLATE utf8_unicode_ci DEFAULT '99FF99',
  `alt_row3_background` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'CCFFCC',
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  `web_logo` varchar(100) COLLATE utf8_unicode_ci DEFAULT 'default_new',
  PRIMARY KEY (`colors_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_screen_labels` (
  `label_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `label_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `label_hide_field_logs` varchar(6) COLLATE utf8_unicode_ci DEFAULT 'Y',
  `label_title` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_first_name` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_middle_initial` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_last_name` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_address1` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_address2` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_address3` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_city` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_state` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_province` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_postal_code` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_vendor_lead_code` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_gender` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_phone_number` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_phone_code` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_alt_phone` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_security_phrase` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_email` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `label_comments` varchar(60) COLLATE utf8_unicode_ci DEFAULT '',
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  PRIMARY KEY (`label_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_scripts` (
  `script_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `script_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `script_comments` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `script_text` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  `script_color` varchar(7) COLLATE utf8_unicode_ci DEFAULT 'white',
  PRIMARY KEY (`script_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_server_carriers` (
  `carrier_id` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `carrier_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `registration_string` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `template_id` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `account_entry` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `protocol` enum('SIP','Zap','IAX2','EXTERNAL') COLLATE utf8_unicode_ci DEFAULT 'SIP',
  `globals_string` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dialplan_entry` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `active` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `carrier_description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  UNIQUE KEY `carrier_id` (`carrier_id`),
  KEY `server_ip` (`server_ip`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_server_trunks` (
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `dedicated_trunks` smallint(5) unsigned DEFAULT 0,
  `trunk_restriction` enum('MAXIMUM_LIMIT','OVERFLOW_ALLOWED') COLLATE utf8_unicode_ci DEFAULT 'OVERFLOW_ALLOWED',
  KEY `campaign_id` (`campaign_id`),
  KEY `server_ip` (`server_ip`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_session_data` (
  `session_name` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `conf_exten` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extension` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `login_time` datetime NOT NULL,
  `webphone_url` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `agent_login_call` text COLLATE utf8_unicode_ci DEFAULT NULL,
  UNIQUE KEY `session_name` (`session_name`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_sessions_recent` (
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `call_date` datetime DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `conf_exten` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_type` varchar(1) COLLATE utf8_unicode_ci DEFAULT '',
  KEY `lead_id` (`lead_id`),
  KEY `call_date` (`call_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_sessions_recent_archive` (
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `call_date` datetime DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `conf_exten` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_type` varchar(1) COLLATE utf8_unicode_ci DEFAULT '',
  KEY `lead_id` (`lead_id`),
  KEY `call_date` (`call_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_settings_containers` (
  `container_id` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `container_notes` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `container_type` varchar(40) COLLATE utf8_unicode_ci DEFAULT 'OTHER',
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  `container_entry` mediumtext COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`container_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_shifts` (
  `shift_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `shift_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shift_start_time` varchar(4) COLLATE utf8_unicode_ci DEFAULT '0900',
  `shift_length` varchar(5) COLLATE utf8_unicode_ci DEFAULT '16:00',
  `shift_weekdays` varchar(7) COLLATE utf8_unicode_ci DEFAULT '0123456',
  `report_option` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  `report_rank` smallint(5) DEFAULT 1,
  KEY `shift_id` (`shift_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_sip_action_log` (
  `call_date` datetime(6) DEFAULT NULL,
  `caller_code` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `phone_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `result` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `call_date` (`call_date`),
  KEY `caller_code` (`caller_code`),
  KEY `result` (`result`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_sip_action_log_archive` (
  `call_date` datetime(6) DEFAULT NULL,
  `caller_code` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `phone_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `result` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  UNIQUE KEY `vlesa` (`caller_code`,`call_date`),
  KEY `call_date` (`call_date`),
  KEY `caller_code` (`caller_code`),
  KEY `result` (`result`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_sip_event_archive_details` (
  `wday` tinyint(1) unsigned NOT NULL,
  `start_event_date` datetime(6) DEFAULT NULL,
  `end_event_date` datetime(6) DEFAULT NULL,
  `record_count` int(9) unsigned DEFAULT 0,
  PRIMARY KEY (`wday`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_sip_event_log` (
  `sip_event_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `caller_code` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sip_call_id` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_date` datetime(6) DEFAULT NULL,
  `event` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`sip_event_id`),
  KEY `caller_code` (`caller_code`),
  KEY `event_date` (`event_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_sip_event_log_0` (
  `sip_event_id` int(9) unsigned NOT NULL,
  `caller_code` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sip_call_id` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_date` datetime(6) DEFAULT NULL,
  `event` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`sip_event_id`),
  KEY `caller_code` (`caller_code`),
  KEY `event_date` (`event_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_sip_event_log_1` (
  `sip_event_id` int(9) unsigned NOT NULL,
  `caller_code` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sip_call_id` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_date` datetime(6) DEFAULT NULL,
  `event` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`sip_event_id`),
  KEY `caller_code` (`caller_code`),
  KEY `event_date` (`event_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_sip_event_log_2` (
  `sip_event_id` int(9) unsigned NOT NULL,
  `caller_code` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sip_call_id` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_date` datetime(6) DEFAULT NULL,
  `event` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`sip_event_id`),
  KEY `caller_code` (`caller_code`),
  KEY `event_date` (`event_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_sip_event_log_3` (
  `sip_event_id` int(9) unsigned NOT NULL,
  `caller_code` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sip_call_id` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_date` datetime(6) DEFAULT NULL,
  `event` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`sip_event_id`),
  KEY `caller_code` (`caller_code`),
  KEY `event_date` (`event_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_sip_event_log_4` (
  `sip_event_id` int(9) unsigned NOT NULL,
  `caller_code` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sip_call_id` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_date` datetime(6) DEFAULT NULL,
  `event` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`sip_event_id`),
  KEY `caller_code` (`caller_code`),
  KEY `event_date` (`event_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_sip_event_log_5` (
  `sip_event_id` int(9) unsigned NOT NULL,
  `caller_code` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sip_call_id` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_date` datetime(6) DEFAULT NULL,
  `event` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`sip_event_id`),
  KEY `caller_code` (`caller_code`),
  KEY `event_date` (`event_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_sip_event_log_6` (
  `sip_event_id` int(9) unsigned NOT NULL,
  `caller_code` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sip_call_id` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_date` datetime(6) DEFAULT NULL,
  `event` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`sip_event_id`),
  KEY `caller_code` (`caller_code`),
  KEY `event_date` (`event_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_sip_event_recent` (
  `caller_code` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uniqueid` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `invite_date` datetime(6) DEFAULT NULL,
  `first_100_date` datetime(6) DEFAULT NULL,
  `first_180_date` datetime(6) DEFAULT NULL,
  `first_183_date` datetime(6) DEFAULT NULL,
  `last_100_date` datetime(6) DEFAULT NULL,
  `last_180_date` datetime(6) DEFAULT NULL,
  `last_183_date` datetime(6) DEFAULT NULL,
  `200_date` datetime(6) DEFAULT NULL,
  `error_date` datetime(6) DEFAULT NULL,
  `processed` enum('N','Y','U') COLLATE utf8_unicode_ci DEFAULT 'N',
  KEY `caller_code` (`caller_code`),
  KEY `invite_date` (`invite_date`),
  KEY `processed` (`processed`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_state_call_times` (
  `state_call_time_id` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `state_call_time_state` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `state_call_time_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `state_call_time_comments` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `sct_default_start` smallint(4) unsigned NOT NULL DEFAULT 900,
  `sct_default_stop` smallint(4) unsigned NOT NULL DEFAULT 2100,
  `sct_sunday_start` smallint(4) unsigned DEFAULT 0,
  `sct_sunday_stop` smallint(4) unsigned DEFAULT 0,
  `sct_monday_start` smallint(4) unsigned DEFAULT 0,
  `sct_monday_stop` smallint(4) unsigned DEFAULT 0,
  `sct_tuesday_start` smallint(4) unsigned DEFAULT 0,
  `sct_tuesday_stop` smallint(4) unsigned DEFAULT 0,
  `sct_wednesday_start` smallint(4) unsigned DEFAULT 0,
  `sct_wednesday_stop` smallint(4) unsigned DEFAULT 0,
  `sct_thursday_start` smallint(4) unsigned DEFAULT 0,
  `sct_thursday_stop` smallint(4) unsigned DEFAULT 0,
  `sct_friday_start` smallint(4) unsigned DEFAULT 0,
  `sct_friday_stop` smallint(4) unsigned DEFAULT 0,
  `sct_saturday_start` smallint(4) unsigned DEFAULT 0,
  `sct_saturday_stop` smallint(4) unsigned DEFAULT 0,
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  `ct_holidays` text COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`state_call_time_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_stations` (
  `agent_station` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `phone_channel` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `computer_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `DB_server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `DB_user` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DB_pass` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DB_port` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`agent_station`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_status_categories` (
  `vsc_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `vsc_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vsc_description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tovdad_display` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `sale_category` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `dead_lead_category` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  PRIMARY KEY (`vsc_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_status_groups` (
  `status_group_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `status_group_notes` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  PRIMARY KEY (`status_group_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_statuses` (
  `status` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `status_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `selectable` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT NULL,
  `human_answered` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `category` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'UNDEFINED',
  `sale` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `dnc` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `customer_contact` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `not_interested` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `unworkable` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `scheduled_callback` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `completed` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `min_sec` int(5) unsigned DEFAULT 0,
  `max_sec` int(5) unsigned DEFAULT 0,
  `answering_machine` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `Pos` int(5) NOT NULL DEFAULT 0,
  `Col` int(5) NOT NULL DEFAULT 0,
  PRIMARY KEY (`status`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_territories` (
  `territory_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `territory` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `territory_description` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  PRIMARY KEY (`territory_id`),
  UNIQUE KEY `uniqueterritory` (`territory`)
) ENGINE=Aria AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_timeclock_audit_log` (
  `timeclock_id` int(9) unsigned NOT NULL,
  `event_epoch` int(10) unsigned NOT NULL,
  `event_date` datetime NOT NULL,
  `login_sec` int(10) unsigned DEFAULT NULL,
  `event` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `user_group` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `ip_address` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shift_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_datestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `tcid_link` int(9) unsigned DEFAULT NULL,
  KEY `timeclock_id` (`timeclock_id`),
  KEY `user` (`user`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_timeclock_log` (
  `timeclock_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `event_epoch` int(10) unsigned NOT NULL,
  `event_date` datetime NOT NULL,
  `login_sec` int(10) unsigned DEFAULT NULL,
  `event` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `user_group` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `ip_address` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shift_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notes` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `manager_user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `manager_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_datestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `tcid_link` int(9) unsigned DEFAULT NULL,
  PRIMARY KEY (`timeclock_id`),
  KEY `user` (`user`),
  KEY `vtl_event_epoch` (`event_epoch`)
) ENGINE=Aria AUTO_INCREMENT=30976 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_timeclock_status` (
  `user` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `user_group` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `event_epoch` int(10) unsigned DEFAULT NULL,
  `event_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ip_address` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shift_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  UNIQUE KEY `user` (`user`),
  KEY `user_2` (`user`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_tts_prompts` (
  `tts_id` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `tts_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT NULL,
  `tts_text` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `tts_voice` varchar(100) COLLATE utf8_unicode_ci DEFAULT 'Allison-8kHz',
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  PRIMARY KEY (`tts_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_url_log` (
  `url_log_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `uniqueid` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `url_date` datetime DEFAULT NULL,
  `url_type` varchar(10) COLLATE utf8_unicode_ci DEFAULT '',
  `response_sec` smallint(5) unsigned DEFAULT 0,
  `url` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `url_response` text COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`url_log_id`),
  KEY `uniqueid` (`uniqueid`)
) ENGINE=Aria AUTO_INCREMENT=4664284 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_url_multi` (
  `url_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `entry_type` enum('campaign','ingroup','list','') COLLATE utf8_unicode_ci DEFAULT '',
  `active` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `url_type` enum('dispo','start','addlead','noagent','') COLLATE utf8_unicode_ci DEFAULT '',
  `url_rank` smallint(5) DEFAULT 1,
  `url_statuses` varchar(1000) COLLATE utf8_unicode_ci DEFAULT '',
  `url_description` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `url_address` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `url_lists` varchar(1000) COLLATE utf8_unicode_ci DEFAULT '',
  PRIMARY KEY (`url_id`),
  KEY `vicidial_url_multi_campaign_id_key` (`campaign_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_urls` (
  `url_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  PRIMARY KEY (`url_id`),
  UNIQUE KEY `url` (`url`)
) ENGINE=Aria AUTO_INCREMENT=100 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_user_closer_log` (
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_date` datetime DEFAULT NULL,
  `blended` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `closer_campaigns` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `manager_change` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  KEY `user` (`user`),
  KEY `event_date` (`event_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_user_groups` (
  `user_group` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `group_name` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `allowed_campaigns` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `qc_allowed_campaigns` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `qc_allowed_inbound_groups` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `group_shifts` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `forced_timeclock_login` enum('Y','N','ADMIN_EXEMPT') COLLATE utf8_unicode_ci DEFAULT 'N',
  `shift_enforcement` enum('OFF','START','ALL','ADMIN_EXEMPT') COLLATE utf8_unicode_ci DEFAULT 'OFF',
  `agent_status_viewable_groups` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `agent_status_view_time` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `agent_call_log_view` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `agent_xfer_consultative` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `agent_xfer_dial_override` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `agent_xfer_vm_transfer` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `agent_xfer_blind_transfer` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `agent_xfer_dial_with_customer` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `agent_xfer_park_customer_dial` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `agent_fullscreen` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `allowed_reports` varchar(2000) COLLATE utf8_unicode_ci DEFAULT 'ALL REPORTS',
  `webphone_url_override` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `webphone_systemkey_override` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `webphone_dialpad_override` enum('DISABLED','Y','N','TOGGLE','TOGGLE_OFF') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `admin_viewable_groups` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `admin_viewable_call_times` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `allowed_custom_reports` varchar(2000) COLLATE utf8_unicode_ci DEFAULT '',
  `agent_allowed_chat_groups` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `agent_xfer_park_3way` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `admin_ip_list` varchar(30) COLLATE utf8_unicode_ci DEFAULT '',
  `agent_ip_list` varchar(30) COLLATE utf8_unicode_ci DEFAULT '',
  `api_ip_list` varchar(30) COLLATE utf8_unicode_ci DEFAULT '',
  `webphone_layout` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `group_email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_user_list_new_lead` (
  `user` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `list_id` bigint(20) unsigned DEFAULT 999,
  `user_override` smallint(5) DEFAULT -1,
  `new_count` mediumint(8) unsigned DEFAULT 0,
  UNIQUE KEY `userlistnew` (`user`,`list_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_user_log` (
  `user_log_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_date` datetime DEFAULT NULL,
  `event_epoch` int(10) unsigned DEFAULT NULL,
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `session_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `extension` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `computer_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `browser` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_login` varchar(15) COLLATE utf8_unicode_ci DEFAULT '',
  `server_phone` varchar(15) COLLATE utf8_unicode_ci DEFAULT '',
  `phone_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT '',
  `webserver` smallint(5) unsigned DEFAULT 0,
  `login_url` int(9) unsigned DEFAULT 0,
  `browser_width` smallint(5) unsigned DEFAULT 0,
  `browser_height` smallint(5) unsigned DEFAULT 0,
  PRIMARY KEY (`user_log_id`),
  KEY `user` (`user`),
  KEY `phone_ip` (`phone_ip`),
  KEY `vuled` (`event_date`)
) ENGINE=Aria AUTO_INCREMENT=763861 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_user_territories` (
  `user` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `territory` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `level` enum('TOP_AGENT','STANDARD_AGENT','BOTTOM_AGENT') COLLATE utf8_unicode_ci DEFAULT 'STANDARD_AGENT',
  UNIQUE KEY `userterritory` (`user`,`territory`),
  KEY `user` (`user`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_user_territory_log` (
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_date` datetime DEFAULT NULL,
  `agent_territories` text COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `user` (`user`),
  KEY `event_date` (`event_date`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_users` (
  `user_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `user` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `pass` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `full_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_level` tinyint(3) unsigned DEFAULT 1,
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_login` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_pass` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `delete_users` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `delete_user_groups` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `delete_lists` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `delete_campaigns` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `delete_ingroups` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `delete_remote_agents` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `load_leads` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `campaign_detail` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `ast_admin_access` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `ast_delete_phones` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `delete_scripts` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `modify_leads` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `hotkeys_active` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `change_agent_campaign` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `agent_choose_ingroups` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `closer_campaigns` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `scheduled_callbacks` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `agentonly_callbacks` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `agentcall_manual` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `vicidial_recording` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `vicidial_transfers` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `delete_filters` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `alter_agent_interface_options` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `closer_default_blended` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `delete_call_times` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `modify_call_times` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `modify_users` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `modify_campaigns` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `modify_lists` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `modify_scripts` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `modify_filters` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `modify_ingroups` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `modify_usergroups` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `modify_remoteagents` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `modify_servers` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `view_reports` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `vicidial_recording_override` enum('DISABLED','NEVER','ONDEMAND','ALLCALLS','ALLFORCE') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `alter_custdata_override` enum('NOT_ACTIVE','ALLOW_ALTER') COLLATE utf8_unicode_ci DEFAULT 'NOT_ACTIVE',
  `qc_enabled` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `qc_user_level` int(2) DEFAULT 1,
  `qc_pass` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `qc_finish` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `qc_commit` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `add_timeclock_log` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `modify_timeclock_log` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `delete_timeclock_log` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `alter_custphone_override` enum('NOT_ACTIVE','ALLOW_ALTER') COLLATE utf8_unicode_ci DEFAULT 'NOT_ACTIVE',
  `vdc_agent_api_access` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `modify_inbound_dids` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `delete_inbound_dids` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `active` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `alert_enabled` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `download_lists` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `agent_shift_enforcement_override` enum('DISABLED','OFF','START','ALL') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `manager_shift_enforcement_override` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `shift_override_flag` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `export_reports` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `delete_from_dnc` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `email` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `user_code` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `territory` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `allow_alerts` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `agent_choose_territories` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `custom_one` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `custom_two` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `custom_three` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `custom_four` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `custom_five` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `voicemail_id` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `agent_call_log_view_override` enum('DISABLED','Y','N') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `callcard_admin` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `agent_choose_blended` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `realtime_block_user_info` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `custom_fields_modify` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `force_change_password` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  `agent_lead_search_override` enum('NOT_ACTIVE','ENABLED','LIVE_CALL_INBOUND','LIVE_CALL_INBOUND_AND_MANUAL','DISABLED') COLLATE utf8_unicode_ci DEFAULT 'NOT_ACTIVE',
  `modify_shifts` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `modify_phones` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `modify_carriers` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `modify_labels` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `modify_statuses` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `modify_voicemail` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `modify_audiostore` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `modify_moh` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `modify_tts` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `preset_contact_search` enum('NOT_ACTIVE','ENABLED','DISABLED') COLLATE utf8_unicode_ci DEFAULT 'NOT_ACTIVE',
  `modify_contacts` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `modify_same_user_level` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `admin_hide_lead_data` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `admin_hide_phone_data` enum('0','1','2_DIGITS','3_DIGITS','4_DIGITS') COLLATE utf8_unicode_ci DEFAULT '0',
  `agentcall_email` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `modify_email_accounts` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `failed_login_count` tinyint(3) unsigned DEFAULT 0,
  `last_login_date` datetime DEFAULT '2001-01-01 00:00:01',
  `last_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT '',
  `pass_hash` varchar(500) COLLATE utf8_unicode_ci DEFAULT '',
  `alter_admin_interface_options` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '1',
  `max_inbound_calls` smallint(5) unsigned DEFAULT 0,
  `modify_custom_dialplans` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `wrapup_seconds_override` smallint(4) DEFAULT -1,
  `modify_languages` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `selected_language` varchar(100) COLLATE utf8_unicode_ci DEFAULT 'default English',
  `user_choose_language` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `ignore_group_on_search` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `api_list_restrict` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `api_allowed_functions` varchar(1000) COLLATE utf8_unicode_ci DEFAULT ' ALL_FUNCTIONS ',
  `lead_filter_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT 'NONE',
  `admin_cf_show_hidden` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `agentcall_chat` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `user_hide_realtime` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `access_recordings` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `modify_colors` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `user_nickname` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `user_new_lead_limit` smallint(5) DEFAULT -1,
  `api_only_user` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `modify_auto_reports` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `modify_ip_lists` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `ignore_ip_list` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `ready_max_logout` mediumint(7) DEFAULT -1,
  `export_gdpr_leads` enum('0','1','2') COLLATE utf8_unicode_ci DEFAULT '0',
  `pause_code_approval` enum('1','0') COLLATE utf8_unicode_ci DEFAULT '0',
  `max_hopper_calls` smallint(5) unsigned DEFAULT 0,
  `max_hopper_calls_hour` smallint(5) unsigned DEFAULT 0,
  `mute_recordings` enum('DISABLED','Y','N') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `hide_call_log_info` enum('DISABLED','Y','N','SHOW_1','SHOW_2','SHOW_3','SHOW_4','SHOW_5','SHOW_6','SHOW_7','SHOW_8','SHOW_9','SHOW_10') COLLATE utf8_unicode_ci DEFAULT 'DISABLED',
  `next_dial_my_callbacks` enum('NOT_ACTIVE','DISABLED','ENABLED') COLLATE utf8_unicode_ci DEFAULT 'NOT_ACTIVE',
  `user_admin_redirect_url` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `agent_disable_manual` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `agent_disable_alt_dial` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `max_inbound_filter_enabled` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `max_inbound_filter_statuses` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `max_inbound_filter_ingroups` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `max_inbound_filter_min_sec` smallint(5) DEFAULT -1,
  `selected_po_language` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'en_EN',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user` (`user`),
  UNIQUE KEY `GroupUser` (`user_group`,`user`)
) ENGINE=Aria AUTO_INCREMENT=676 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_vdad_log` (
  `caller_code` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_date` datetime DEFAULT NULL,
  `epoch_micro` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `db_time` datetime NOT NULL,
  `run_time` varchar(20) COLLATE utf8_unicode_ci DEFAULT '0',
  `vdad_script` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `stage` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `step` smallint(5) unsigned DEFAULT 0,
  KEY `caller_code` (`caller_code`),
  KEY `vdad_dbtime_key` (`db_time`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_voicemail` (
  `voicemail_id` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `active` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'Y',
  `pass` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `fullname` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `messages` int(4) DEFAULT 0,
  `old_messages` int(4) DEFAULT 0,
  `email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `delete_vm_after_email` enum('N','Y') COLLATE utf8_unicode_ci DEFAULT 'N',
  `voicemail_timezone` varchar(30) COLLATE utf8_unicode_ci DEFAULT 'eastern',
  `voicemail_options` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `user_group` varchar(20) COLLATE utf8_unicode_ci DEFAULT '---ALL---',
  `voicemail_greeting` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `on_login_report` enum('Y','N') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  PRIMARY KEY (`voicemail_id`),
  UNIQUE KEY `voicemail_id` (`voicemail_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_webservers` (
  `webserver_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `webserver` varchar(125) COLLATE utf8_unicode_ci DEFAULT '',
  `hostname` varchar(125) COLLATE utf8_unicode_ci DEFAULT '',
  PRIMARY KEY (`webserver_id`),
  UNIQUE KEY `vdweb` (`webserver`,`hostname`)
) ENGINE=Aria AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_xfer_log` (
  `xfercallid` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `list_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_date` datetime DEFAULT NULL,
  `phone_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `closer` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `front_uniqueid` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `close_uniqueid` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  PRIMARY KEY (`xfercallid`),
  KEY `lead_id` (`lead_id`),
  KEY `call_date` (`call_date`),
  KEY `date_user` (`call_date`,`user`),
  KEY `date_closer` (`call_date`,`closer`),
  KEY `phone_number` (`phone_number`)
) ENGINE=Aria AUTO_INCREMENT=113992 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_xfer_log_archive` (
  `xfercallid` int(9) unsigned NOT NULL,
  `lead_id` bigint(20) unsigned DEFAULT NULL,
  `list_id` bigint(20) unsigned DEFAULT NULL,
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_date` datetime DEFAULT NULL,
  `phone_code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `closer` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `front_uniqueid` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `close_uniqueid` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  PRIMARY KEY (`xfercallid`),
  KEY `lead_id` (`lead_id`),
  KEY `call_date` (`call_date`),
  KEY `date_user` (`call_date`,`user`),
  KEY `date_closer` (`call_date`,`closer`),
  KEY `phone_number` (`phone_number`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_xfer_presets` (
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `preset_name` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `preset_number` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `preset_dtmf` varchar(50) COLLATE utf8_unicode_ci DEFAULT '',
  `preset_hide_number` enum('Y','N') COLLATE utf8_unicode_ci DEFAULT 'N',
  KEY `preset_name` (`preset_name`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vicidial_xfer_stats` (
  `campaign_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `preset_name` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `xfer_count` smallint(5) unsigned DEFAULT 0,
  KEY `campaign_id` (`campaign_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vtiger_rank_data` (
  `account` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `seqacct` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `last_attempt_days` smallint(5) unsigned NOT NULL,
  `orders` smallint(5) NOT NULL,
  `net_sales` smallint(5) NOT NULL,
  `net_sales_ly` smallint(5) NOT NULL,
  `percent_variance` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `imu` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `aov` smallint(5) NOT NULL,
  `returns` smallint(5) NOT NULL,
  `rank` smallint(5) NOT NULL,
  PRIMARY KEY (`account`),
  UNIQUE KEY `seqacct` (`seqacct`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vtiger_rank_parameters` (
  `parameter_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `parameter` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `lower_range` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `upper_range` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `points` smallint(5) NOT NULL,
  PRIMARY KEY (`parameter_id`),
  KEY `parameter` (`parameter`)
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vtiger_vicidial_roles` (
  `user_level` tinyint(2) DEFAULT NULL,
  `vtiger_role` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_client_sessions` (
  `extension` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `server_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `program` enum('agc','vicidial','monitor','other') COLLATE utf8_unicode_ci DEFAULT 'agc',
  `start_time` datetime NOT NULL,
  `session_name` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `session_name` (`session_name`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `www_phrases` (
  `phrase_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `phrase_text` varchar(10000) COLLATE utf8_unicode_ci DEFAULT '',
  `php_filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `php_directory` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `source` varchar(20) COLLATE utf8_unicode_ci DEFAULT '',
  `insert_date` datetime DEFAULT NULL,
  PRIMARY KEY (`phrase_id`),
  KEY `phrase_text` (`phrase_text`(333))
) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1;
/*!40101 SET character_set_client = @saved_cs_client */;
