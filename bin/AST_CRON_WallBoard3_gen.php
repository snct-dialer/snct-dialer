<?php
#
# Copyright (c) 2017-2019 Jörg Frings-Fürst <jff@flyingpenguin.de>   LICENSE: AGPLv3
#               2017-2019 flyingpenguin UG <info@flyingpenguin.de>
#
# Generation of Wallbaoard 3.0 Statistics
#
# 20170329-0000 - first release
# 20171020-1900 - stable release
# 20171030-1410 - Set correct $PATHweb and PATHlogs
#               - Correct typo Custom_one
# 20171118-0851 - Typo InGroup Search
# 20171118-1232 - Add function GetServicelevel
# 20171121-1624 - Add maxwaittime and Tmaxwaittime.
# 20171122-0930 - Typo in statement15
# 20180525-1445 - Disable test against 0201 for forwarding
# 20190206-1001 - Correct typo
#

$version="1.0.7";
$build = "20190206-1001";


####  collect wallboard data should only be active on a single server
#*/1 * * * * php /usr/share/astguiclient/AST_CRON_WallBoard3_gen.php 


#
# $DB
# set to 1 to enable debug messages
#
$DB=0;
$Debug=0;
$mel=0;
$LOG=1;

$LogDatei = "";
$LogDateiName = "GenWallBoard-";
$LogFile = NULL;


$Server_ip_ext = $_SERVER['SERVER_ADDR'];
if ($DB) { print $Server_ip_ext; }

$server_port = getenv("SERVER_PORT");
if (preg_match("/80/i",$server_port)) {$HTTPprotocol = 'http:';}
  else {$HTTPprotocol = 'https:';}


if ( file_exists("/etc/astguiclient.conf") )
	{
	$DBCagc = file("/etc/astguiclient.conf");
	foreach ($DBCagc as $DBCline) 
		{
		$DBCline = preg_replace("/ |>|\n|\r|\t|\#.*|;.*/","",$DBCline);
		if (preg_match("/^PATHlogs/", $DBCline))
			{$PATHlogs = $DBCline;   $PATHlogs = preg_replace("/.*=/","",$PATHlogs);}
		if (preg_match("/^PATHweb/", $DBCline))
			{$WeBServeRRooT = $DBCline;   $WeBServeRRooT = preg_replace("/.*=/","",$WeBServeRRooT);}
		if (preg_match("/^VARserver_ip/", $DBCline))
			{$WEBserver_ip = $DBCline;   $WEBserver_ip = preg_replace("/.*=/","",$WEBserver_ip);}
		if (preg_match("/^VARDB_server/", $DBCline))
			{$VARDB_server = $DBCline;   $VARDB_server = preg_replace("/.*=/","",$VARDB_server);}
		if (preg_match("/^VARDB_database/", $DBCline))
			{$VARDB_database = $DBCline;   $VARDB_database = preg_replace("/.*=/","",$VARDB_database);}
		if (preg_match("/^VARDB_user/", $DBCline))
			{$VARDB_user = $DBCline;   $VARDB_user = preg_replace("/.*=/","",$VARDB_user);}
		if (preg_match("/^VARDB_pass/", $DBCline))
			{$VARDB_pass = $DBCline;   $VARDB_pass = preg_replace("/.*=/","",$VARDB_pass);}
		if (preg_match('/^VARDB_custom_user/', $DBCline))
			{$VARDB_custom_user = $DBCline;   $VARDB_custom_user = preg_replace("/.*=/","",$VARDB_custom_user);}
		if (preg_match('/^VARDB_custom_pass/', $DBCline))
			{$VARDB_custom_pass = $DBCline;   $VARDB_custom_pass = preg_replace("/.*=/","",$VARDB_custom_pass);}
		if (preg_match("/^VARDB_port/", $DBCline))
			{$VARDB_port = $DBCline;   $VARDB_port = preg_replace("/.*=/","",$VARDB_port);}
		if (preg_match("/^ExpectedDBSchema/", $DBCline))
			{$ExpectedDBSchema = $DBCline;   $ExpectedDBSchema = preg_replace("/.*=/","",$ExpectedDBSchema);}
		}
	}

#$use_slave_server = 1;
#$slave_db_server  = "172.16.2.13";


require_once($WeBServeRRooT . "/vicidial/dbconnect_mysqli.php");
require_once($WeBServeRRooT . "/vicidial/functions.php");

if (!isset($Server_ip_ext))  { $Server_ip_ext = $WEBserver_ip; }


//
// Global Vars
//
$DIDGroupsArray = array ();
$IBGroupsArray = array ();

$AZ_Begin = "00:00:00";
$AZ_Ende  = "23:59:59";

$TableName = "WallBoardData";
$TableNameArch = "WallBoardData_archive";
$TableNameStat = "WallBoardStat";

$SL021 = 3;
$SL122 = 20;
$SL22X = 40;

//
// function Log
//
// Log into Logfile or syslog
//
// Use: $DB, $link, $Log
//
// Input: LogText
// Return: --none--
//
function LogWB($LText) {
	global $DB, $link, $LogFile, $LOG;
		
	if($LOG != 0) {
		$Time=date("H:i:s : ");
		$str = $Time . $LText . PHP_EOL;
		fputs($LogFile, $str );
	}
	
}

//
// function GetSeviceLevel
//
// Get the ServiceLevel from Systemsettings
//
// Use: $DB, $link, $SLO21, $SL122, $SL22X
//
function GetServiceLevel() {
	global $DB, $link, $SL021, $SL122, $SL22X;
	
	$time_start = microtime(true);
	LogWB("---Start GetServiceLevel---");
	
	$statement="SELECT servicelevel_direct, servicelevel_one, servicelevel_two FROM `system_settings`;";
	if ($DB)
		print "$statement\n";
	$result = mysql_to_mysqli($statement, $link);
	$row = mysqli_fetch_array($result, MYSQLI_BOTH);
	$SL021 = $row["servicelevel_direct"];
	$SL122 = $row["servicelevel_one"];
	$SL22X = $row["servicelevel_two"];
	if ($DB) {
		print "SL0: $SL021\n";
		print "SL1: $SL122\n";
		print "SL2: $SL22X\n";
	}
	$time_end = microtime(true);
	$time = $time_end - $time_start;
	
	LogWB("---Ende GetServiceLevel--- nach " . $time . " Sek.");
	
}


//
// function GetDIDGroup
//
// Return the value from the field custom_one from vicidial_inbound_dids
//
// On empty fields a group called "Rest" is used
//
// Use: $DB, $link
//
// Input: $DID_ID
// Return: GruppenName
//
function GetDIDGroup($DID_ID) {
	global $DB, $link;
	
	$time_start = microtime(true);
	LogWB("---Start GetDIDGroup---");
	
	$statement="SELECT * FROM `vicidial_inbound_dids` WHERE `did_id` = '$DID_ID';";
	if ($DB)
		print "$statement\n";
	$result = mysql_to_mysqli($statement, $link);
	$row = mysqli_fetch_array($result, MYSQLI_BOTH);
	$Grp = $row["custom_one"];
	if($Grp == "") {
		$Grp = "Rest";
//		$Grp = $IB_ID;
	}
	
	$time_end = microtime(true);
	$time = $time_end - $time_start;
	
	LogWB("---Ende GetDIDGroup--- nach " . $time . " Sek.");
	
	return $Grp;
}

//
// function GetIBGroup
//
// Return the value from the field custom_one from vicidial_inbound_groups
//
// On empty fields a group called "Rest" is used
//
// Use: $DB, $link
//
// Input: $DID_ID
// Return: GruppenName
//
function GetIBGroup($IB_ID) {
	global $DB, $link;

	$time_start = microtime(true);
	LogWB("---Start GetIBGroup---");

	$statement="SELECT * FROM `vicidial_inbound_groups` WHERE `group_id` = '$IB_ID';";
	if ($DB)
		print "$statement\n";
	$result = mysql_to_mysqli($statement, $link);
	$row = mysqli_fetch_array($result, MYSQLI_BOTH);
	$Grp = $row["custom_one"];
	if($Grp == "") {
		$Grp = "Rest";
//		$Grp = $IB_ID;
	}

	$time_end = microtime(true);
	$time = $time_end - $time_start;
	LogWB("---Ende GetIBGroup--- nach " . $time . " Sek.");

	return $Grp;
}

//
// function GetAuswerteZeit
//
// Return the value from the field custom_oneX from vicidial_inbound_groups
//
// On empty fields a group called "Rest" is used
//
// Use: $DB, $link
//
// Input: $DID_ID
// Return: GruppenName
//
function GetAuswerteZeit() {
	global $DB, $link, $AZ_Begin, $AZ_Ende;

	$time_start = microtime(true);
	LogWB("---Start GetAuswerteZeit---");

	$statement="SELECT * FROM `vicidial_call_times` WHERE `call_time_id` = 'AUSWERTUNG';";
	if ($DB)
		print "$statement\n";
	$result = mysqli_query($link, $statement);
	$Anz=mysqli_num_rows($result);
	if($Anz > 0) {
		$row = mysqli_fetch_array($result, MYSQLI_BOTH);
		$tmp = $row["ct_default_start"];
		$min  = $tmp % 100;
		$hour = ($tmp - $min) / 100;
		$AZ_Begin = $hour . ":" . $min . ":00";
	
		$tmp  = $row["ct_default_stop"];
		$min  = $tmp % 100;
		$hour = ($tmp - $min) / 100;
		$AZ_Ende = $hour . ":" . $min . ":00";
	} else {
		$AZ_Begin = "00:00:00";
		$AZ_Ende  = "23:59:59";
	}
	
	$time_end = microtime(true);
	$time = $time_end - $time_start;
	LogWB("---Ende GetAuswerteZeit--- nach " . $time . " Sek.");
	
}



// 
// function GenDIDGroups
// 
// scan the field custom_one from vicidial_inbound_dids
// and put them into the DIDGroupsArray.
// 
// On empty fields a group called "Rest" is used
//
// Use: $DB, $link, $DIDGroupsArray
//
// Input: --none--
// Return: --none--
//
function GenDIDGroups() {
	global $DB, $link, $DIDGroupsArray;

	
	$time_start = microtime(true);
	LogWB("--Start GenDIDGroups--");
	
	$statement="SELECT did_id, custom_one FROM vicidial_inbound_dids GROUP BY custom_one;";
	if ($DB)
		print "$statement\n";
	$result=mysql_to_mysqli($statement, $link);
	$Anz=mysqli_num_rows($result);
	$i=0;
	while($i < $Anz) {
		$row = mysqli_fetch_array($result, MYSQLI_BOTH);
		$Grp = $row["custom_one"];
		if($Grp == "") {
			$Grp = "Rest";
		}
		#		$Grp = str_replace(' ', '_', $Grp);
		$DIDGroupsArray[] = $Grp;
	
		$i++;
	}
	if ($DB)
		var_dump($DIDGroupsArray);
		
	$time_end = microtime(true);
	$time = $time_end - $time_start;
		
	LogWB("--Ende GenDIDGroups-- nach " . $time . " Sek.");
}

//
// function GenIBGroups
//
// scan the field custom_one from vicidial_inbound_groups
// and put them into the IBGroupsArray.
//
// On empty fields a group called "Rest" is used
//
// Use: $DB, $link, $IBGroupsArray
//
// Input: --none--
// Return: --none--
//
function GenIBGroups() {
	global $DB, $link, $IBGroupsArray;
	
	$time_start = microtime(true);
	LogWB("--Start GetIBGroups--");
	
	$statement="SELECT group_id, custom_one FROM vicidial_inbound_groups GROUP BY custom_one;";
//	$statement="SELECT * FROM vicidial_inbound_groups GROUP BY group_id;";
	if ($DB)
		print "$statement\n";
	$result=mysql_to_mysqli($statement, $link);
	$Anz=mysqli_num_rows($result);
	$i=0;
	while($i < $Anz) {
		$row = mysqli_fetch_array($result, MYSQLI_BOTH);
		$Grp = $row["custom_one"];
		if($Grp == "") {
			$Grp = "Rest";
		}
		#		$Grp = str_replace(' ', '_', $Grp);
		$IBGroupsArray[] = $Grp;
		$i++;
	}
	if ($DB)
		var_dump($IBGroupsArray);
		
	$time_end = microtime(true);
	$time = $time_end - $time_start;
		
	LogWB("--Ende GenIBGroups-- nach " . $time . " Sek.");
}

//
// function Move2Arch
//
// Move Data not from today into the Arch Table
//
// Use: $DB, $link, $TableName, $TableNameArch
//
// Input: $Date -> today
// Output: if ok:      0
//         if failed: -1
//
function Move2Arch($Date) {
	global $DB, $link, $TableName, $TableNameArch;
	
	$time_start = microtime(true);
	LogWB("--Start Move2Arch--");
	
	if(($TableName == "") or ($TableNameArch == "")) {
		return -1;
	}
	$statement="INSERT INTO `$TableNameArch` SELECT * FROM `$TableName` WHERE `DateTBegin` < '$Date';";
	if ($DB)
		print "$statement\n";
	$result=mysql_to_mysqli($statement, $link);
	$statement1="DELETE FROM `$TableName` WHERE `DateTBegin` < '$Date';";
	if ($DB)
		print "$statement1\n";
	$result1=mysql_to_mysqli($statement1, $link);

	
	$time_end = microtime(true);
	$time = $time_end - $time_start;
	
	LogWB("--Ende Move2Arch-- nach " . $time . " Sek.");
	
	return 0;
}

//
// function GetCallsDidLog
//
// Get new Calls from vicidial_did_log
//
// Use: $DB, $link, $TableName
//
// Input: $Date -> today
// Output: if ok:      0
//         if failed: -1
//
function GetCallsDidLog($Date) {
	global $DB, $link, $TableName;
	
	
	$time_start = microtime(true);
	LogWB("--Start GetCallsDidLog--");
	
	if($TableName == "") {
		return -1;
	}
	$statement="SELECT * from vicidial_did_log WHERE call_date >= '$Date';";
	if ($DB)
		print "$statement\n";
	$result=mysql_to_mysqli($statement, $link);
	$Anz=mysqli_num_rows($result);
	$i=0;
	while($i < $Anz) {
		$row = mysqli_fetch_array($result, MYSQLI_BOTH);
		$uid = $row["uniqueid"];
		$cin = $row["caller_id_number"];
		$cd  = $row["call_date"];
		$did = $row["did_id"];
		$dir = $row["did_route"];
		$statement1 = "SELECT * FROM `$TableName` WHERE `uniqueid` = '$uid';";
		if ($DB)
			print "$statement1\n";
		$result1=mysql_to_mysqli($statement1, $link);
		$Anz1=mysqli_num_rows($result1);
		if($Anz1 == 0) {
			$DidGrp = GetDIDGroup($did);
			$statement3="INSERT INTO `$TableName` (`DateTBegin`, `Done`, `uniqueid`, `DIDGruppe`, `CallerID`, `did_route`) VALUES('$cd', false, '$uid', '$DidGrp', '$cin', '$dir');";
			if ($DB)
				print "$statement3\n";
			$result3=mysql_to_mysqli($statement3, $link);
			if (!$result3) {
				print 'Invalid query: ' . mysql_error();
			}
		}
		$i++;
	}
	
	$time_end = microtime(true);
	$time = $time_end - $time_start;
	
	LogWB("--Ende GetCallsDidLog-- nach " . $time . " Sek.");
	
	return 0;
}


//
// function GetNextUniqueid
//
// Get new Calls from vicidial_did_log
//
// Use: $DB, $link, $TableName
//
// Input: $Date -> today
// Output: if ok:      0
//         if failed: -1
//
function GetNextUniqueid($uid) {
	global $DB, $link, $TableName;
	
	$time_start = microtime(true);
	LogWB("--Start GetNextUniqueid--");
	
	$RetUid = "";
	
	static $clid = 0;
	
	if($uid == "") {
		return "";
	}
	
	$statement = "SELECT * FROM `vicidial_closer_log` WHERE `uniqueid` = '$uid' ORDER BY `call_date` DESC;" ;
	if ($DB)
		print "$statement\n";
	$result=mysqli_query($link, $statement);
	$Anz=mysqli_num_rows($result);
	if($Anz > 0) {
		$row = mysqli_fetch_array($result, MYSQLI_BOTH);
		$lid = $row["lead_id"];
		$end = $row["end_epoch"];
		$endp = $end + 20;
		$clid = $row["closecallid"];
		if($lid != 0) {
			$statement2 = "SELECT * FROM `vicidial_closer_log` WHERE `lead_id` = '$lid' AND `start_epoch` >= '$end' AND `start_epoch` <= '$endp' ORDER BY `call_date` DESC;" ;
			if ($DB)
				print "$statement2\n";
			$result2=mysqli_query($link, $statement2);
			$Anz2=mysqli_num_rows($result2);
			if($Anz2 > 0) {
				$row2 = mysqli_fetch_array($result2, MYSQLI_BOTH);
				$lUid = $row2["uniqueid"];
//				print "CallID : |" . $clid . "|" .$row2[0] . "|" . PHP_EOL;
				if(($lUid != "") && ($clid != $row2["closecallid"])) {
					$lUid1 = GetNextUniqueid($lUid);
					if($lUid1 != "") {
						$RetUid = $lUid1;
					} else {
						$RetUid = $lUid;
					}
				}
//				$clid = $row2[0];
			}
		
			mysqli_free_result($result2);
		}
	}
	mysqli_free_result($result);
	
	$time_end = microtime(true);
	$time = $time_end - $time_start;
	
	LogWB("--Ende GetNextUniqueid-- nach " . $time . " Sek.");
	
	return $RetUid;
}


//
// function GetCallsResult
//
// Get new Calls from vicidial_did_log
//
// Use: $DB, $link, $TableName, $SL122
//
// Input: $Date -> today
// Output: if ok:      0
//         if failed: -1
//
function GetCallsResult() {
	global $DB, $link, $TableName, $SL122, $SL021, $SL22X;

	$time_start = microtime(true);
	LogWB("--Start GetCallsResult--");
	
	$timeh = time() - 3600;
	$statement = "SELECT *, UNIX_TIMESTAMP(DateTBegin) AS TAA from `$TableName` WHERE `Done` = false;";
	if ($DB)
		print "$statement\n";
	$result=mysql_to_mysqli($statement, $link);
	$Anz=mysqli_num_rows($result);
	$i=0;
	while($i < $Anz) {
		$row = mysqli_fetch_array($result, MYSQLI_BOTH);
		$id  = $row["ID"];
		$uid = $row["uniqueid"];
		$taa = $row["TAA"];
		if($row[10] != "") {
			$nuid = GetNextUniqueid($uid);
		}
//		print "Org: " . $uid . " Last: " . $nuid . PHP_EOL;
		if($nuid != "") {
			$uid = $nuid;
		}
		$statement1 = "SELECT * FROM `vicidial_agent_log` WHERE `uniqueid` = '$uid';";
		if ($DB)
			print "$statement1\n";
		$result1=mysql_to_mysqli($statement1, $link);
		$Anz1=mysqli_num_rows($result1);
		if($Anz1 > 0) {
			$row1 = mysqli_fetch_array($result1, MYSQLI_BOTH);
			$agt = $row1["user"];
			$tae = $row1["talk_epoch"];
			$lid = $row1["lead_id"];

			$statement5 = "SELECT * FROM `vicidial_closer_log` WHERE `uniqueid` = '$uid' ORDER BY call_date DESC LIMIT 1;";
			if ($DB)
				print "$statement5\n";
			$result5=mysql_to_mysqli($statement5, $link);
			$Anz5=mysqli_num_rows($result5);
			$ibg = "";
			if ($Anz5 > 0) {
				$row5 = mysqli_fetch_array($result5, MYSQLI_BOTH);
				$ibg = GetIBGroup($row5[3]);
			}
			$Dauer = $tae - $taa;

			if($Dauer < $SL021) {
				$SL0 = true;
				$SL1 = false;
				$SL2 = false;
			} else {
				if($Dauer < $SL122) {
					$SL0 = false;
					$SL1 = true;
					$SL2 = false;
				} else {
					if(($Dauer < $SL22X)) {
						$SL0 = false;
						$SL1 = false;
						$SL2 = true;
					}
				}
			}
			
			$statement2 = "UPDATE `$TableName` SET `next_uniqueid` = '$nuid', `lead_id` = '$lid', `DateTEnd` = FROM_UNIXTIME('$tae'), `Agent` = '$agt', `IBGruppe` = '$ibg', `Status`= 'AGENT', `Done` = true, `Dauer` = '$Dauer', `SL0` = '$SL0', `SL1` = '$SL1', `SL2` = '$SL2' WHERE `ID`= '$id';";
			if ($DB)
				print "$statement2\n";
			$result2=mysql_to_mysqli($statement2, $link);
		}
		else {
			$statement3="SELECT * FROM `vicidial_closer_log` WHERE `uniqueid` = '$uid' ORDER BY call_date DESC LIMIT 1;";
			if ($DB)
				print "$statement3\n";
			$result3=mysql_to_mysqli($statement3, $link);
			$AnzVAL=mysqli_num_rows($result3);
			if ($AnzVAL > 0) {
				$row3 = mysqli_fetch_array($result3, MYSQLI_BOTH);
				$status = $row3["status"];
				$endt = $row3["end_epoch"];
				$lid  = $row3["lead_id"];
				$igb  = GetIBGroup($row3[3]);
				#				print "Status: " . $status . PHP_EOL;
				$Erg = "";

				$Dauer = $endt - $taa;
				
				if($Dauer < $SL021) {
					$SL0 = true;
					$SL1 = false;
					$SL2 = false;
				} else {
					if($Dauer < $SL122) {
						$SL0 = false;
						$SL1 = true;
						$SL2 = false;
					} else {
						if(($Dauer < $SL22X)) {
							$SL0 = false;
							$SL1 = false;
							$SL2 = true;
						}
					}
				}
			
				if($status == "QVMAIL") {
					$Erg = "MAILBOX";
					$statement4 = "UPDATE `$TableName` SET `lead_id` = '$lid', `IBGruppe` = '$igb',  `Status`= '$Erg', `DateTEnd`= FROM_UNIXTIME('$endt'), `Done` = true, `Dauer` = '$Dauer', `SL0` = '$SL0', `SL1` = '$SL1', `SL2` = '$SL2' WHERE `ID`= '$id';";
				}	
				if($status == "WAITTO") {
					$Erg = "RÜCKRUF";
					$statement4 = "UPDATE `$TableName` SET `lead_id` = '$lid', `IBGruppe` = '$igb',  `Status`= '$Erg', `DateTEnd`= FROM_UNIXTIME('$endt'), `Done` = true, `Dauer` = '$Dauer', `SL0` = '$SL0', `SL1` = '$SL1', `SL2` = '$SL2' WHERE `ID`= '$id';";
				}		
				if(($status == "AFTHRS") || ($status == "NANQUE") || ($status == "HANGUP") || ($status == "DROP") || ($status == "TIMEOT")) {
					$Erg = "DROP";
					if($endt < $timeh) {
						$statement4 = "UPDATE `$TableName` SET `lead_id` = '$lid', `IBGruppe` = '$igb',  `Status`= '$Erg', `DateTEnd`= FROM_UNIXTIME('$endt'), `Done` = true, `Dauer` = '$Dauer', `SL0` = '$SL0', `SL1` = '$SL1', `SL2` = '$SL2' WHERE `ID`= '$id';";
					}
					else {
						$statement4 = "UPDATE `$TableName` SET `lead_id` = '$lid', `IBGruppe` = '$igb',  `Status`= '$Erg', `DateTEnd`= FROM_UNIXTIME('$endt'), `Done` = false, `Dauer` = '$Dauer', `SL0` = '$SL0', `SL1` = '$SL1', `SL2` = '$SL2' WHERE `ID`= '$id';";
					}
				}
				if($Erg != "") {
					if ($DB)
						print "$statement4\n";
					$result4=mysql_to_mysqli($statement4, $link);
					if (!$result4) {
						print 'Invalid query: ' . mysql_error() . PHP_EOL;
					}
				} else {
					print "unbekannter Status: " . $status . "|" . $lid . "|" . $uid . PHP_EOL;
				}
			
			}
		}
		$i++;
	}	
	
	$time_end = microtime(true);
	$time = $time_end - $time_start;
	
	LogWB("--Ende GetCallsResult-- nach " . $time . " Sek.");
	
	return 0;

}

//
// function GenWBStatsTime
//
// calculate the stats
//
// Use: $DB, $link, $TableName, $TableNameStats;
//
// Input: $Date -> today
// Output: if ok:      0
//         if failed: -1
//
function GenWBStatsTime($IBG, $TimeAnf, $TimeEnd) {
	global $DB, $link, $TableName, $TableNameStat;


	$time_start = microtime(true);
	LogWB("--Start GenWBStatsTime--");

	$Date=date("Y-m-d");
	$DateAnf = $Date . " " . $TimeAnf;
	$DateEnd = $Date . " " . $TimeEnd;

	if($IBG == "") {
		$statement = "SELECT COUNT(*) FROM `$TableName` WHERE `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd' ;";
		if ($DB)
			print "$statement\n";
		$result=mysql_to_mysqli($statement, $link);
		$row = mysqli_fetch_row($result);
		$Gesamt = $row[0];

		$statement1 = "SELECT COUNT(*) FROM `$TableName` WHERE `did_route` = 'PHONE' AND `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd';";
		if ($DB)
			print "$statement1\n";
		$result1=mysql_to_mysqli($statement1, $link);
		$row1 = mysqli_fetch_row($result1);
		$Phones = $row1[0];
		$Gesamt -= $Phones;

		$statement2 = "SELECT COUNT(*) FROM `$TableName` WHERE `CallerID` != '' AND `lead_id` > 0 AND `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd' GROUP BY `lead_id`;";
		if ($DB)
			print "$statement2\n";
		$result2=mysql_to_mysqli($statement2, $link);
		$Kunden = mysqli_num_rows($result2);

		$statement3 = "SELECT COUNT(*) FROM `$TableName` WHERE `Status` = 'AGENT' AND `did_route` != 'PHONE' AND `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd' ;";
		if ($DB)
			print "$statement3\n";
		$result3=mysql_to_mysqli($statement3, $link);
		$row3 = mysqli_fetch_row($result3);
		$Agents = $row3[0];

		$statement4 = "SELECT COUNT(*) FROM `$TableName` WHERE `Status` = 'DROP' AND `did_route` != 'PHONE' AND `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd';";
		if ($DB)
			print "$statement4\n";
		$result4=mysql_to_mysqli($statement4, $link);
		$row4 = mysqli_fetch_row($result4);
		$Drops = $row4[0];

		$statement5 = "SELECT COUNT(*) FROM `$TableName` WHERE `SL0` = true AND `Status` = 'AGENT' AND `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd';";
		if ($DB)
			print "$statement5\n";
		$result5=mysql_to_mysqli($statement5, $link);
		$row5 = mysqli_fetch_row($result5);
		$SL0 = $row5[0];

		$statement6 = "SELECT COUNT(*) FROM `$TableName` WHERE `SL1` = true AND `Status` = 'AGENT' AND `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd';";
		if ($DB)
			print "$statement6\n";
		$result6=mysql_to_mysqli($statement6, $link);
		$row6 = mysqli_fetch_row($result6);
		$SL1 = $row6[0] + $SL0;

		$statement7 = "SELECT COUNT(*) FROM `$TableName` WHERE `SL2` = true AND `Status` = 'AGENT' AND `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd';";
		if ($DB)
			print "$statement7\n";
		$result7=mysql_to_mysqli($statement7, $link);
		$row7 = mysqli_fetch_row($result7);
		$SL2 = $row7[0] + $SL1;

		$statement8="SELECT SUM(Dauer) / COUNT(Dauer) AS Durch FROM `$TableName` WHERE `Dauer` != 0 AND `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd';";
		if ($DB)
			print "$statement8\n";
		$result8=mysql_to_mysqli($statement8, $link);
		$row8=mysqli_fetch_row($result8);
		$Warte = $row8[0];

		$statement10 = "SELECT COUNT(*) FROM `$TableName` WHERE `Status` != 'DROP' AND `CallerID` != '' AND `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd' GROUP BY `lead_id`;"; 
		if ($DB)
			print "$statement10\n";
		$result10=mysql_to_mysqli($statement10, $link);
		$KundenErr = mysqli_num_rows($result10);

#		$statement11 = "SELECT COUNT(*) from call_log WHERE start_time >= '$Date' and number_dialed LIKE '%02018321672%' AND `start_time` >= '$DateAnf' AND `start_time` <= '$DateEnd';";
#		if ($DB)
#			print "$statement\n";
#		$result11 = mysql_to_mysqli($statement11, $link);
#		$row11=mysqli_fetch_row($result11);
#		$Weiter = $row11[0];
		$Weiter = 0

		$statement12 = "SELECT COUNT(*) from `$TableName` WHERE `Status` = 'MAILBOX' AND `did_route` != 'PHONE' AND `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd';";
		if ($DB)
			print "$statement12\n";
		$result12 = mysql_to_mysqli($statement12, $link);
		$row12=mysqli_fetch_row($result12);
		$AB = $row12[0];

		$statement13 = "SELECT COUNT(*) from `$TableName` WHERE `CallerID` = '' AND `did_route` != 'PHONE' AND `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd';";
		if ($DB)
			print "$statement13\n";
		$result13 = mysql_to_mysqli($statement13, $link);
		$row13=mysqli_fetch_row($result13);
		$Unb = $row13[0];

		$statement14 = "SELECT COUNT(*) FROM `$TableName` WHERE `Status` = 'RÜCKRUF' AND `did_route` != 'PHONE' AND `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd';";
		if ($DB)
			print "$statement14\n";
		$result14=mysql_to_mysqli($statement14, $link);
		$row14 = mysqli_fetch_row($result14);
		$RRuf = $row14[0];
		$AB = $AB + $RRuf;
		
		$statement15 = "SELECT MAX(`Dauer`) FROM `$TableName` WHERE `did_route` != 'PHONE' AND `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd';";
		if ($DB)
			print "$statement15\n";
		$result15=mysql_to_mysqli($statement15, $link);
		$row15 = mysqli_fetch_row($result15);
		$MaxWT = $row15[0];

		$ebk = 0.0;
		if ($Gesamt != 0) {
			$ebk = $Agents * 100 / $Gesamt;
		}

		$kebk = 0.0;
		if ($Kunden != 0) {
			$kebk = $KundenErr * 100 / $Kunden;
		}

		$statement9= "SELECT  COUNT(*) FROM `$TableNameStat` WHERE Datum='$Date' AND Gruppe='Gesamt';";
		if ($DB)
			print "$statement\n";
		$result9= mysqli_query($link, $statement9);
		$row9=mysqli_fetch_row($result9);
		if($row9[0] > 0) {
			$DateT=date("Y-m-d H:i:s");
	 		$statementX="UPDATE `$TableNameStat` SET `TUnbekannt` = '$Unb', `TAB` = '$AB', `TWL` = '$Weiter',  `StandVom`='$DateT', `TPhones`= '$Phones', `TKunden`='$Kunden', `TCalls`='$Gesamt', `Tebk`='$ebk', `Tkebk`='$kebk', `TDrops` = '$Drops', `TAgent`= '$Agents', `TSL0`= '$SL0', `TSL1` = '$SL1', `TSL2`='$SL2', `Twaittime`= '$Warte', 'Tmaxwaittime`='$MaxWT' WHERE Datum='$Date' AND Gruppe='Gesamt';";
			if ($DB)
				print "$statementX\n";
			if(!mysqli_query($link, $statementX)) {
				printf("Error: %s\n", mysqli_error($link));
			}
		}
		else {
			$statementX1="INSERT INTO `$TableNameStat` SET `TUnbekannt` = '$Unb', `TAB` = '$AB', `TWL` = '$Weiter', `TPhones`= '$Phones', `TDatum` = '$Date', `TGruppe`='Gesamt', `TKunden`='$Kunden', `TCalls`='$Gesamt', `Tebk`='$ebk', `Tkebk`='$kebk', `TDrops` = '$Drops', `TAgent`= '$Agents', `TSL0`= '$SL0', `TSL1` = '$SL1', `TSL2`='$SL2', `Twaittime`= '$Warte', `Tmaxwaittime` = '$MaxWT';";
			if ($DB)
				print "$statement\n";
			if(!mysqli_query($link, $statementX1)) {
				printf("Error: %s\n", mysqli_error($link));
			}
		}
//		print "Werte Gesamt:" . $Gesamt . ";" . $Phones . ";" . $Kunden . ";" . $Agents . ";" . $Drops . ";" . $SL0 . ";" . $SL1 . ";" .  $SL2 . ";" . $Warte . PHP_EOL;
	} else {

		$statement = "SELECT COUNT(*) FROM `$TableName` WHERE `IBGruppe` = '$IBG' AND `did_route` != 'PHONE' AND `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd';";
		if ($DB)
			print "$statement\n";
		$result=mysql_to_mysqli($statement, $link);
		$row = mysqli_fetch_row($result);
		$Gesamt = $row[0];

		$statement1 = "SELECT COUNT(*) FROM `$TableName` WHERE `did_route` = 'PHONE' AND `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd';";
		if ($DB)
			print "$statement1\n";
		$result1=mysql_to_mysqli($statement1, $link);
		$row1 = mysqli_fetch_row($result1);
		$Phones = $row1[0];

		$statement2 = "SELECT COUNT(*) FROM `$TableName` WHERE `IBGruppe` = '$IBG' AND `CallerID` != '' AND `lead_id` > 0 AND `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd' GROUP BY `lead_id`;";
		if ($DB)
			print "$statement2\n";
		$result2=mysql_to_mysqli($statement2, $link);
		$Kunden = mysqli_num_rows($result2);

		$statement3 = "SELECT COUNT(*) FROM `$TableName` WHERE `Status` = 'AGENT' AND `IBGruppe` = '$IBG' AND `did_route` != 'PHONE' AND `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd';";
		if ($DB)
			print "$statement3\n";
		$result3=mysql_to_mysqli($statement3, $link);
		$row3 = mysqli_fetch_row($result3);
		$Agents = $row3[0];

		$statement4 = "SELECT COUNT(*) FROM `$TableName` WHERE `Status` = 'DROP' AND `IBGruppe` = '$IBG' AND `did_route` != 'PHONE' AND `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd';";
		if ($DB)
			print "$statement4\n";
		$result4=mysql_to_mysqli($statement4, $link);
		$row4 = mysqli_fetch_row($result4);
		$Drops = $row4[0];

		$statement5 = "SELECT COUNT(*) FROM `$TableName` WHERE `SL0` = true AND `Status` = 'AGENT' AND `IBGruppe` = '$IBG' AND `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd';";
		if ($DB)
			print "$statement5\n";
		$result5=mysql_to_mysqli($statement5, $link);
		$row5 = mysqli_fetch_row($result5);
		$SL0 = $row5[0];

		$statement6 = "SELECT COUNT(*) FROM `$TableName` WHERE `SL1` = true AND `Status` = 'AGENT' AND `IBGruppe` = '$IBG' AND `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd';";
		if ($DB)
			print "$statement6\n";
		$result6=mysql_to_mysqli($statement6, $link);
		$row6 = mysqli_fetch_row($result6);
		$SL1 = $row6[0] + $SL0;

		$statement7 = "SELECT COUNT(*) FROM `$TableName` WHERE `SL2` = true AND `Status` = 'AGENT' AND `IBGruppe` = '$IBG' AND `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd';";
			if ($DB)
		print "$statement7\n";
		$result7=mysql_to_mysqli($statement7, $link);
		$row7 = mysqli_fetch_row($result7);
		$SL2 = $row7[0] + $SL1;

		$statement8="SELECT SUM(Dauer) / COUNT(Dauer) AS Durch FROM `$TableName` WHERE `Dauer` != 0 AND `IBGruppe` = '$IBG' AND `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd';";
		if ($DB)
			print "$statement8\n";
		$result8=mysql_to_mysqli($statement8, $link);
		$row8=mysqli_fetch_row($result8);
		$Warte = $row8[0];

		$statement10 = "SELECT COUNT(*) FROM `$TableName` WHERE `IBGruppe` = '$IBG' AND `Status` = 'AGENT' AND `CallerID`!= '' AND `lead_id` > 0 AND `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd' GROUP BY `lead_id`;";
		if ($DB)
			print "$statement10\n";
		$result10=mysql_to_mysqli($statement10, $link);
		$KundenErr = mysqli_num_rows($result10);

		$statement12 = "SELECT COUNT(*) from `$TableName` WHERE `Status` = 'MAILBOX' AND `IBGruppe` = '$IBG' AND `did_route` != 'PHONE' AND `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd';";
		if ($DB)
			print "$statement12\n";
		$result12 = mysql_to_mysqli($statement12, $link);
		$row12=mysqli_fetch_row($result12);
		$AB = $row12[0];

		$statement13 = "SELECT COUNT(*) from `$TableName` WHERE `IBGruppe` = '$IBG' AND `CallerID` = '' AND `did_route` != 'PHONE' AND `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd';";
		if ($DB)
			print "$statement13\n";
		$result13 = mysql_to_mysqli($statement13, $link);
		$row13=mysqli_fetch_row($result13);
		$Unb = $row13[0];

		$statement14 = "SELECT COUNT(*) FROM `$TableName` WHERE `Status` = 'RÜCKRUF' AND `IBGruppe` = '$IBG' AND `did_route` != 'PHONE' AND `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd';";
		if ($DB)
			print "$statement14\n";
		$result14=mysql_to_mysqli($statement14, $link);
		$row14 = mysqli_fetch_row($result14);
		$RRuf = $row14[0];
		$AB = $AB + $RRuf;
		
		$statement15 = "SELECT MAX(`Dauer`) FROM `$TableName` WHERE `IBGruppe` = '$IBG' AND did_route` != 'PHONE' AND `DateTBegin` >= '$DateAnf' AND `DateTBegin` <= '$DateEnd';";
		if ($DB)
			print "$statement15\n";
			$result15=mysql_to_mysqli($statement15, $link);
			$row15 = mysqli_fetch_row($result15);
			$MaxWT = $row15[0];
			
		$ebk = 0.0;
		if ($Gesamt != 0) {
			$ebk = $Agents * 100 / $Gesamt;
		}

		$kebk = 0.0;
		if ($Kunden != 0) {
			$kebk = $KundenErr * 100 / $Kunden;
		}

		$statement9= "SELECT  COUNT(*) FROM `$TableNameStat` WHERE Datum='$Date' AND Gruppe='$IBG';";
		if ($DB)
			print "$statement\n";
		$result9= mysqli_query($link, $statement9);
		$row9=mysqli_fetch_row($result9);

		$ebk = 0.0;
		if ($Gesamt != 0) {
			$ebk = $Agents * 100 / $Gesamt;
		}

		if($row9[0] > 0) {
			$DateT=date("Y-m-d H:i:s");
			$statementX="UPDATE `$TableNameStat` SET `TUnbekannt` = '$Unb', `StandVom`='$DateT',  `TAB` = '$AB', `TKunden`='$Kunden', `TCalls`='$Gesamt', `TDrops` = '$Drops', `Tebk`='$ebk', `Tkebk`='$kebk', `TAgent`= '$Agents', `TSL0`= '$SL0', `TSL1` = '$SL1', `TSL2`='$SL2', `Twaittime`= '$Warte', `Tmaxwaittime` = '$MaxWT'  WHERE Datum='$Date' AND Gruppe='$IBG';";
			if ($DB)
				print "$statementX\n";
			if(!mysqli_query($link, $statementX)) {
				printf("Error: %s\n", mysqli_error($link));
			}
		}
		else {
			$statementX1="INSERT INTO `$TableNameStat` SET `TUnbekannt` = '$Unb', `Datum` = '$Date', `TAB` = '$RRUF', `TGruppe`='$IBG', `TKunden`='$Kunden', `TCalls`='$Gesamt', `Tebk`='$ebk', `Tkebk`='$kebk', `TDrops` = '$Drops', `TAgent`= '$Agents', `TSL0`= '$SL0', `TSL1` = '$SL1', `TSL2`='$SL2', `Twaittime`= '$Warte', `Tmaxwaittime` = '$MaxWT'  ;";
			if ($DB)
				print "$statement\n";
			if(!mysqli_query($link, $statementX1)) {
				printf("Error: %s\n", mysqli_error($link));
			}
		}
//		print "Werte " . $IBG . ":" . $Gesamt . ";" . $Phones . ";" . $Kunden . ";" . $Agents . ";" . $Drops . ";" . $SL0 . ";" . $SL1 . ";" .  $SL2 . ";" . $Warte . PHP_EOL;

	}


	$time_end = microtime(true);
	$time = $time_end - $time_start;

	LogWB("--Ende GenWBStatsTime-- nach " . $time . " Sek.");
}



//
// function GenWBStats
//
// calculate the stats
//
// Use: $DB, $link, $TableName, $TableNameStats;
//
// Input: $Date -> today
// Output: if ok:      0
//         if failed: -1
//
function GenWBStats($IBG) {
	global $DB, $link, $TableName, $TableNameStat;
	
	
	$time_start = microtime(true);
	LogWB("--Start GenWBStats--");
	
	$Date=date("Y-m-d");
	
	if($IBG == "") {
		$statement = "SELECT COUNT(*) FROM `$TableName` ;";
		if ($DB)
			print "$statement\n";
		$result=mysql_to_mysqli($statement, $link);
		$row = mysqli_fetch_row($result);
		$Gesamt = $row[0];
	
		$statement1 = "SELECT COUNT(*) FROM `$TableName` WHERE `did_route` = 'PHONE';";
		if ($DB)
			print "$statement1\n";
		$result1=mysql_to_mysqli($statement1, $link);
		$row1 = mysqli_fetch_row($result1);
		$Phones = $row1[0];
		$Gesamt -= $Phones;
	
		$statement2 = "SELECT COUNT(*) FROM `$TableName` WHERE `CallerID` != '' AND `lead_id` > 0 GROUP BY `lead_id`;";
		if ($DB)
			print "$statement2\n";
		$result2=mysql_to_mysqli($statement2, $link);
		$Kunden = mysqli_num_rows($result2);

		$statement3 = "SELECT COUNT(*) FROM `$TableName` WHERE `Status` = 'AGENT' AND `did_route` != 'PHONE';";
		if ($DB)
			print "$statement3\n";
		$result3=mysql_to_mysqli($statement3, $link);
		$row3 = mysqli_fetch_row($result3);
		$Agents = $row3[0];

		$statement4 = "SELECT COUNT(*) FROM `$TableName` WHERE `Status` = 'DROP' AND `did_route` != 'PHONE';";
		if ($DB)
			print "$statement4\n";
		$result4=mysql_to_mysqli($statement4, $link);
		$row4 = mysqli_fetch_row($result4);
		$Drops = $row4[0];

		$statement5 = "SELECT COUNT(*) FROM `$TableName` WHERE `SL0` = true AND `Status` = 'AGENT';";
		if ($DB)
			print "$statement5\n";
		$result5=mysql_to_mysqli($statement5, $link);
		$row5 = mysqli_fetch_row($result5);
		$SL0 = $row5[0];
	
		$statement6 = "SELECT COUNT(*) FROM `$TableName` WHERE `SL1` = true AND `Status` = 'AGENT';";
		if ($DB)
			print "$statement6\n";
		$result6=mysql_to_mysqli($statement6, $link);
		$row6 = mysqli_fetch_row($result6);
		$SL1 = $row6[0] + $SL0;

		$statement7 = "SELECT COUNT(*) FROM `$TableName` WHERE `SL2` = true AND `Status` = 'AGENT';";
		if ($DB)
			print "$statement7\n";
		$result7=mysql_to_mysqli($statement7, $link);
		$row7 = mysqli_fetch_row($result7);
		$SL2 = $row7[0] + $SL1;
	
		$statement8="SELECT SUM(Dauer) / COUNT(Dauer) AS Durch FROM `$TableName` WHERE `Dauer` != 0;";
		if ($DB)
			print "$statement8\n";
		$result8=mysql_to_mysqli($statement8, $link);
		$row8=mysqli_fetch_row($result8);
		$Warte = $row8[0];
		
		$statement10 = "SELECT COUNT(*) FROM `$TableName` WHERE `Status` != 'DROP' AND `CallerID` != '' GROUP BY `lead_id`;";
		if ($DB)
			print "$statement10\n";
		$result10=mysql_to_mysqli($statement10, $link);
		$KundenErr = mysqli_num_rows($result10);
		
#		$statement11 = "SELECT COUNT(*) from call_log WHERE start_time >= '$Date' and number_dialed LIKE '%02018321672%';";
#		if ($DB) 
#			print "$statement\n";
#		$result11 = mysql_to_mysqli($statement11, $link);
#		$row11=mysqli_fetch_row($result11);
#		$Weiter = $row11[0];
		$Weiter = 0;
		
		$statement12 = "SELECT COUNT(*) from `$TableName` WHERE `Status` = 'MAILBOX' AND `did_route` != 'PHONE';";
		if ($DB) 
			print "$statement12\n";
		$result12 = mysql_to_mysqli($statement12, $link);
		$row12=mysqli_fetch_row($result12);
		$AB = $row12[0];
		
		$statement13 = "SELECT COUNT(*) from `$TableName` WHERE `CallerID` = '' AND `did_route` != 'PHONE';";
		if ($DB)
			print "$statement13\n";
		$result13 = mysql_to_mysqli($statement13, $link);
		$row13=mysqli_fetch_row($result13);
		$Unb = $row13[0];

		$statement14 = "SELECT COUNT(*) FROM `$TableName` WHERE `Status` = 'RÜCKRUF' AND `did_route` != 'PHONE';";
		if ($DB)
			print "$statement14\n";
		$result14=mysql_to_mysqli($statement14, $link);
		$row14 = mysqli_fetch_row($result14);
		$RRuf = $row14[0];
		$AB = $AB + $RRuf;

		$statement15 = "SELECT MAX(`Dauer`) FROM `$TableName` WHERE `did_route` != 'PHONE';";
		if ($DB)
			print "$statement15\n";
		$result15=mysql_to_mysqli($statement15, $link);
		$row15 = mysqli_fetch_row($result15);
		$MaxWT = $row15[0];
			
		$ebk = 0.0;
		if ($Gesamt != 0) {
			$ebk = $Agents * 100 / $Gesamt;
		}
		
		$kebk = 0.0;
		if ($Kunden != 0) {
			$kebk = $KundenErr * 100 / $Kunden;
		}
		
		$statement9= "SELECT  COUNT(*) FROM `$TableNameStat` WHERE Datum='$Date' AND Gruppe='Gesamt';";
		if ($DB)
			print "$statement\n";
		$result9= mysqli_query($link, $statement9);
		$row9=mysqli_fetch_row($result9);
		if($row9[0] > 0) {
			$DateT=date("Y-m-d H:i:s");
			$statementX="UPDATE `$TableNameStat` SET `Unbekannt` = '$Unb', `AB` = '$AB', `WL` = '$Weiter',  `StandVom`='$DateT', `Phones`= '$Phones', `Kunden`='$Kunden', `Calls`='$Gesamt', `ebk`='$ebk', `kebk`='$kebk', `Drops` = '$Drops', `Agent`= '$Agents', `SL0`= '$SL0', `SL1` = '$SL1', `SL2`='$SL2', `waittime`= '$Warte', `maxwaittime` = '$MaxWT' WHERE Datum='$Date' AND Gruppe='Gesamt';";
			if ($DB)
				print "$statementX\n";
				if(!mysqli_query($link, $statementX)) {
					printf("Error: %s\n", mysqli_error($link));
				}
		}
		else {
			$statementX1="INSERT INTO `$TableNameStat` SET `Unbekannt` = '$Unb', `AB` = '$AB', `WL` = '$Weiter', `Phones`= '$Phones', `Datum` = '$Date', `Gruppe`='Gesamt', `Kunden`='$Kunden', `Calls`='$Gesamt', `ebk`='$ebk', `kebk`='$kebk', `Drops` = '$Drops', `Agent`= '$Agents', `SL0`= '$SL0', `SL1` = '$SL1', `SL2`='$SL2', `waittime`= '$Warte', `maxwaittime` = '$MaxWT';";
			if ($DB)
				print "$statement\n";
			if(!mysqli_query($link, $statementX1)) {
				printf("Error: %s\n", mysqli_error($link));
			}
		}
		
//		print "Werte Gesamt:" . $Gesamt . ";" . $Phones . ";" . $Kunden . ";" . $Agents . ";" . $Drops . ";" . $SL0 . ";" . $SL1 . ";" .  $SL2 . ";" . $Warte . PHP_EOL;
	} else {
		
		$statement = "SELECT COUNT(*) FROM `$TableName` WHERE `IBGruppe` = '$IBG' AND `did_route` != 'PHONE';";
		if ($DB)
			print "$statement\n";
		$result=mysql_to_mysqli($statement, $link);
		$row = mysqli_fetch_row($result);
		$Gesamt = $row[0];
	
		$statement1 = "SELECT COUNT(*) FROM `$TableName` WHERE `did_route` = 'PHONE';";
		if ($DB)
			print "$statement1\n";
		$result1=mysql_to_mysqli($statement1, $link);
		$row1 = mysqli_fetch_row($result1);
		$Phones = $row1[0];
	
		$statement2 = "SELECT COUNT(*) FROM `$TableName` WHERE `IBGruppe` = '$IBG' AND `CallerID` != '' AND `lead_id` > 0 GROUP BY `lead_id`;";
		if ($DB)
			print "$statement2\n";
		$result2=mysql_to_mysqli($statement2, $link);
		$Kunden = mysqli_num_rows($result2);

		$statement3 = "SELECT COUNT(*) FROM `$TableName` WHERE `Status` = 'AGENT' AND `IBGruppe` = '$IBG' AND `did_route` != 'PHONE';";
		if ($DB)
			print "$statement3\n";
		$result3=mysql_to_mysqli($statement3, $link);
		$row3 = mysqli_fetch_row($result3);
		$Agents = $row3[0];

		$statement4 = "SELECT COUNT(*) FROM `$TableName` WHERE `Status` = 'DROP' AND `IBGruppe` = '$IBG' AND `did_route` != 'PHONE';";
		if ($DB)
			print "$statement4\n";
		$result4=mysql_to_mysqli($statement4, $link);
		$row4 = mysqli_fetch_row($result4);
		$Drops = $row4[0];

		$statement5 = "SELECT COUNT(*) FROM `$TableName` WHERE `SL0` = true AND `Status` = 'AGENT' AND `IBGruppe` = '$IBG';";
		if ($DB)
			print "$statement5\n";
		$result5=mysql_to_mysqli($statement5, $link);
		$row5 = mysqli_fetch_row($result5);
		$SL0 = $row5[0];
	
		$statement6 = "SELECT COUNT(*) FROM `$TableName` WHERE `SL1` = true AND `Status` = 'AGENT' AND `IBGruppe` = '$IBG';";
		if ($DB)
			print "$statement6\n";
		$result6=mysql_to_mysqli($statement6, $link);
		$row6 = mysqli_fetch_row($result6);
		$SL1 = $row6[0] + $SL0;

		$statement7 = "SELECT COUNT(*) FROM `$TableName` WHERE `SL2` = true AND `Status` = 'AGENT' AND `IBGruppe` = '$IBG';";
		if ($DB)
			print "$statement7\n";
		$result7=mysql_to_mysqli($statement7, $link);
		$row7 = mysqli_fetch_row($result7);
		$SL2 = $row7[0] + $SL1;
	
		$statement8="SELECT SUM(Dauer) / COUNT(Dauer) AS Durch FROM `$TableName` WHERE `Dauer` != 0 AND `IBGruppe` = '$IBG';";
		if ($DB)
			print "$statement8\n";
		$result8=mysql_to_mysqli($statement8, $link);
		$row8=mysqli_fetch_row($result8);
		$Warte = $row8[0];
		
		$statement10 = "SELECT COUNT(*) FROM `$TableName` WHERE `IBGruppe` = '$IBG' AND `Status` = 'AGENT' AND `CallerID`!= '' AND `lead_id` > 0 GROUP BY `lead_id`;";
		if ($DB)
			print "$statement10\n";
		$result10=mysql_to_mysqli($statement10, $link);
		$KundenErr = mysqli_num_rows($result10);
		
		$statement12 = "SELECT COUNT(*) from `$TableName` WHERE `Status` = 'MAILBOX' AND `IBGruppe` = '$IBG' AND `did_route` != 'PHONE';";
		if ($DB)
			print "$statement12\n";
		$result12 = mysql_to_mysqli($statement12, $link);
		$row12=mysqli_fetch_row($result12);
		$AB = $row12[0];
		
		$statement13 = "SELECT COUNT(*) from `$TableName` WHERE `IBGruppe` = '$IBG' AND `CallerID` = '' AND `did_route` != 'PHONE';";
		if ($DB)
			print "$statement13\n";
		$result13 = mysql_to_mysqli($statement13, $link);
		$row13=mysqli_fetch_row($result13);
		$Unb = $row13[0];
		
		$statement14 = "SELECT COUNT(*) FROM `$TableName` WHERE `Status` = 'RÜCKRUF' AND `IBGruppe` = '$IBG' AND `did_route` != 'PHONE';";
		if ($DB)
			print "$statement14\n";
		$result14=mysql_to_mysqli($statement14, $link);
		$row14 = mysqli_fetch_row($result14);
		$RRuf = $row14[0];
		$AB = $AB + $RRuf;

		$statement15 = "SELECT MAX(`Dauer`) FROM `$TableName` WHERE `IBGruppe`= '$IBG' AND `did_route` != 'PHONE';";
		if ($DB)
			print "$statement15\n";
		$result15=mysql_to_mysqli($statement15, $link);
		$row15 = mysqli_fetch_row($result15);
		$MaxWT = $row15[0];

		$ebk = 0.0;
		if ($Gesamt != 0) {
			$ebk = $Agents * 100 / $Gesamt;
		}

		$kebk = 0.0;
		if ($Kunden != 0) {
			$kebk = $KundenErr * 100 / $Kunden;
		}
		
		$statement9= "SELECT  COUNT(*) FROM `$TableNameStat` WHERE Datum='$Date' AND Gruppe='$IBG';";
		if ($DB)
			print "$statement\n";
		$result9= mysqli_query($link, $statement9);
		$row9=mysqli_fetch_row($result9);

		$ebk = 0.0;
		if ($Gesamt != 0) {
			$ebk = $Agents * 100 / $Gesamt;
		}
		
		if($row9[0] > 0) {
			$DateT=date("Y-m-d H:i:s");
			$statementX="UPDATE `$TableNameStat` SET `Unbekannt` = '$Unb', `StandVom`='$DateT',  `AB` = '$AB', `Kunden`='$Kunden', `Calls`='$Gesamt', `Drops` = '$Drops', `ebk`='$ebk', `kebk`='$kebk', `Agent`= '$Agents', `SL0`= '$SL0', `SL1` = '$SL1', `SL2`='$SL2', `waittime`= '$Warte', `maxwaittime` = '$MaxWT' WHERE Datum='$Date' AND Gruppe='$IBG';";
			if ($DB)
				print "$statementX\n";
			if(!mysqli_query($link, $statementX)) {
				printf("Error: %s\n", mysqli_error($link));
			}
		}
		else {
			$statementX1="INSERT INTO `$TableNameStat` SET `Unbekannt` = '$Unb', `Datum` = '$Date', `AB` = '$RRUF', `Gruppe`='$IBG', `Kunden`='$Kunden', `Calls`='$Gesamt', `ebk`='$ebk', `kebk`='$kebk', `Drops` = '$Drops', `Agent`= '$Agents', `SL0`= '$SL0', `SL1` = '$SL1', `SL2`='$SL2', `waittime`= '$Warte', `maxwaittime` = '$MaxWT';";
			if ($DB)
				print "$statement\n";
			if(!mysqli_query($link, $statementX1)) {
				printf("Error: %s\n", mysqli_error($link));
			}
		}	
//		print "Werte " . $IBG . ":" . $Gesamt . ";" . $Phones . ";" . $Kunden . ";" . $Agents . ";" . $Drops . ";" . $SL0 . ";" . $SL1 . ";" .  $SL2 . ";" . $Warte . PHP_EOL;
		
	}
	
	
	$time_end = microtime(true);
	$time = $time_end - $time_start;
	
	LogWB("--Ende GenWBStats-- nach " . $time . " Sek.");
}


//
// Main Program
//

$time_start = microtime(true);

date_default_timezone_set("Europe/Berlin");
$Date=date("Y-m-d");


if($LOG != 0) {
	$LogDatei = $PATHlogs . "/" . $LogDateiName . $Date . ".log";
	$LogFile = fopen($LogDatei,"a");
}

LogWB("-Start WBGen-");


// First Get Groups
GenDIDGroups();
GenIBGroups();

// Move old Datasets to Arch
Move2Arch($Date);

// Get Servicelevel
GetServiceLevel();

// Read Calls from did log
GetCallsDidLog($Date);

// Search for Call Results
GetCallsResult(); 

// Calc Stats

GetAuswerteZeit();


$count = count($IBGroupsArray);
for ($i = 0; $i < $count; $i++) {
	GenWBStats($IBGroupsArray[$i]);
	if(($AZ_Begin != "00:00:00") OR ($AZ_Ende != "23:59:59")) {
		GenWBStatsTime($IBGroupsArray[$i], $AZ_Begin, $AZ_Ende);
	}
}
GenWBStats("");

if(($AZ_Begin != "00:00:00") OR ($AZ_Ende != "23:59:59")) {
	GenWBStatsTime("", $AZ_Begin, $AZ_Ende);
}


$time_end = microtime(true);
$time = $time_end - $time_start;

LogWB("-Ende WBGen- nach " . $time . " Sek.");

if($LOG != 0) {
	fclose($LogFile);
}

?>
