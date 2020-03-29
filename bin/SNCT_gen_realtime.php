<?php 

# SNCT_gen_realtime.php   version 1.0.1
#
# LICENSE: AGPLv3
#
# Copyright (©) 2019-2020 SNCT GmbH <info@snct-dialer.de>
#               2019-2020 Jörg Frings-Fürst <open_source@jff.email>
#
#
# SNCT - Changelog
#
# 2020-03-18 13:30 jff	First work
#
# ToDo:
#
# Add Hold & Ingroup done
# Add Waiting Calls
# Add Add Check for mysql connection
#
#
#
# Gen Data for Realtime view serverbased
#
#
#

if (file_exists('../inc/include.php')) {
	require_once '../inc/include.php';
} elseif (file_exists('./inc/include.php')) {
	require_once './inc/include.php';
} else {
	require_once 'om/inc/include.php';
}

$versionSNCTGenRealTime = "1.0.4";

$SetupDir = "/etc/snct-dialer/";
$SetupFiles = array ("snct-dialer.conf", "tools/tools.conf", "tools/tools.local");

$SetUp = setup::MakeWithArray($SetupDir, $SetupFiles);


$Log = new Log($SetUp->GetData("Log", "GenRealTime"), $versionSNCTGenRealTime);

#
# Globale Vars
#
#
$DB = 0;
$Debug = 0;
$EnPauseStatus = 0;
$InboundArr = array();

$TableNameRTV = "2Live";


$mysql = new DB($SetUp->GetData("Database", "Server"),
	$SetUp->GetData("Database", "Database"),
	$SetUp->GetData("Database", "User"),
	$SetUp->GetData("Database", "Pass"),
	$SetUp->GetData("Database", "Port"));


function GetPauseStatus($User, $AgentLogID) {
	global $mysql, $DB, $Log, $EnPauseStatus, $Debug;
	
	$time_start = microtime(true);
	$Ret = "";
	if($EnPauseStatus > 0) {
		$sql1 = "SELECT sub_status from vicidial_agent_log where agent_log_id >= \"$AgentLogID\" and user='$User' order by agent_log_id desc limit 1;";
		if($DB) { $Log->Log($sql1);}
		if ($res1 = $mysql->MySqlHdl->query($sql1)) {
			if($res1->num_rows >= 1) {
				$row1 = $res1->fetch_array(MYSQLI_BOTH);
				$Ret = $row1[0];
			}
		} else {
			if($err = $mysql->MySqlHdl->error) {
				$Log->Log(" -- MariaDB Fehler: " . $err);
			}
		}
	}
	
	$time_end = microtime(true);
	
	$time = $time_end - $time_start;
	if($Debug) {
		$Log->Log("  GetPauseStatus Dauer: ".$time);
	}
	return $Ret;
}

function GetAgentPhone($Ext, $IP) {
	global $mysql, $DB, $Log, $Debug;
	
	
	$time_start = microtime(true);
	$protocol = "";
	$dialplan = "";
	$exten = "";
	$Ret = "";
	
	if (preg_match("/R\//i",$Ext))
	{
		$protocol = 'EXTERNAL';
		$dialplan = preg_replace('/R\//i', '',$Ext);
		$dialplan = preg_replace('/\@.*/i', '',$dialplan);
		$exten = "dialplan_number='$dialplan'";
	}
	if (preg_match("/Local\//i",$Ext))
	{
		$protocol = 'EXTERNAL';
		$dialplan = preg_replace('/Local\//i', '',$Ext);
		$dialplan = preg_replace('/\@.*/i', '',$dialplan);
		$exten = "dialplan_number='$dialplan'";
	}
	if (preg_match('/SIP\//i',$Ext))
	{
		$protocol = 'SIP';
		$dialplan = preg_replace('/SIP\//i', '',$Ext);
		$dialplan = preg_replace('/\-.*/i', '',$dialplan);
		$exten = "extension='$dialplan'";
	}
	if (preg_match('/IAX2\//i',$Ext))
	{
		$protocol = 'IAX2';
		$dialplan = preg_replace('/IAX2\//i', '',$Ext);
		$dialplan = preg_replace('/\-.*/i', '',$dialplan);
		$exten = "extension='$dialplan'";
	}
	if (preg_match('/Zap\//i',$Ext))
	{
		$protocol = 'Zap';
		$dialplan = preg_replace('/Zap\//i', '',$Ext);
		$exten = "extension='$dialplan'";
	}
	if (preg_match('/DAHDI\//i',$Ext))
	{
		$protocol = 'Zap';
		$dialplan = preg_replace('/DAHDI\//i', '',$Ext);
		$exten = "extension='$dialplan'";
	}
	
	$sql1="SELECT login from phones where server_ip='$IP' and $exten and protocol='$protocol';";
	if($DB) { $Log->Log($sql1);}
	if ($res1 = $mysql->MySqlHdl->query($sql1)) {
		$row1 = $res1->fetch_array(MYSQLI_BOTH);
		$Ret = $row1["login"];
	} else {
		
		if($err = $mysql->MySqlHdl->error) {
			$Log->Log(" -- MariaDB Fehler: " . $err);
		}
	}
	$time_end = microtime(true);
	
	$time = $time_end - $time_start;
	if($Debug) {
		$Log->Log("  GetAgentPhone Dauer: ".$time);
	}
	return $Ret;
}

function GetCustPhone($LeadID) {
	global $mysql, $DB, $Log, $Debug;
	
	
	$time_start = microtime(true);
	if($LeadID == 0) {
		return "";
	}
	$Ret = "";
	$sql1="SELECT callerid,lead_id,phone_number, phone_code from `vicidial_auto_calls` WHERE `lead_id` = '".$LeadID."';";
	if($DB) { $Log->Log($sql1);}
	if ($res1 = $mysql->MySqlHdl->query($sql1)) {
		if($res1->num_rows >= 1) {
			$row1 = $res1->fetch_array(MYSQLI_BOTH);
			$Ret = "+".$row1["phone_code"] . $row1["phone_number"];
		}
	} else {
		if($err = $mysql->MySqlHdl->error) {
			$Log->Log(" -- MariaDB Fehler: " . $err);
		}
	}
	$time_end = microtime(true);
	
	$time = $time_end - $time_start;
	if($Debug) {
		$Log->Log("  GetCustomPhone Dauer: ".$time);
	}
	return $Ret;
}

function FillUser() {
	global $mysql, $TableNameRTV, $DB, $Log, $Debug;
	
	
	$time_start = microtime(true);
	$sql = "SELECT * FROM `".$TableNameRTV."` WHERE `UserName` = '';";
	if($DB) { $Log->Log($sql);}
	if ($res = $mysql->MySqlHdl->query($sql)) {
		while($row = $res->fetch_array(MYSQLI_BOTH)) {
			$sql1 = "SELECT * FROM `vicidial_users` WHERE `user` = '".$row["User"]."';";
			$res1 = $mysql->MySqlHdl->query($sql1);
			$row1 = $res1->fetch_array(MYSQLI_BOTH);
			
			$sql2 = "UPDATE `".$TableNameRTV."` SET `UserName` = '".$row1["full_name"]."', `UserGrp` = '".$row1["user_group"]."'  WHERE `User` = '".$row["User"]."';";
			if($DB) { $Log->Log($sql2);}
			$res2 = $mysql->MySqlHdl->query($sql2);
		}
	}
	$time_end = microtime(true);
	
	$time = $time_end - $time_start;
	if($Debug) {
		$Log->Log("  FillUser Dauer: ".$time);
	}
}

function FillPhone() {
	global $mysql, $TableNameRTV, $DB, $Log, $Debug;
	
	
	$time_start = microtime(true);
	$sql = "SELECT * FROM `".$TableNameRTV."` WHERE `Phone` = '';";
	if($DB) { $Log->Log($sql);}
	if ($res = $mysql->MySqlHdl->query($sql)) {
		while($row = $res->fetch_array(MYSQLI_BOTH)) {
			$APhone = GetAgentPhone($row["Station"], $row["ServerIP"]);
			$sql2 = "UPDATE `".$TableNameRTV."` SET `Phone` = '".$APhone."' WHERE `User` = '".$row["User"]."';";
			if($DB) { $Log->Log($sql2);}
			$res2 = $mysql->MySqlHdl->query($sql2);
		}
	}
	$time_end = microtime(true);
	
	$time = $time_end - $time_start;
	if($Debug) {
		$Log->Log("  FillPhone Dauer: ".$time);
	}
}

function GetInbound($CallerID) {
	global $mysql, $TableNameRTV, $DB, $Log, $InboundArr, $Debug;
	
	$InGrp = "";
	$WaitTime = "";
	
	$time_start = microtime(true);
		
	$sql="SELECT vac.campaign_id,vac.stage,vig.group_name,vig.group_id from vicidial_auto_calls vac,vicidial_inbound_groups vig where vac.callerid='$CallerID' and vac.campaign_id=vig.group_id LIMIT 1;";
	if($DB) { $Log->Log($sql);}
	if($res = $mysql->MySqlHdl->query($sql)) {
		$row = $res->fetch_array(MYSQLI_BOTH);
		$InGrp = $row[0] ." - ". $row[2];
		$row[1] = preg_replace('/.*\-/i', '',$row[1]);
		$WaitTime = sprintf("%-4s", $row[1]);
		$WaitTime = $row[1];
	} else {
		if($err = $mysql->MySqlHdl->error) {
			$Log->Log(" -- MariaDB Fehler: " . $err);
		}
	}
	$time_end = microtime(true);
	
	$time = $time_end - $time_start;
	if($Debug) {
		$Log->Log("  GetInbound Dauer: ".$time);
	}
	return array ($InGrp, $WaitTime);
}

function CheckMySqlConnection() {
	global $mysql, $Log, $Setup, $Debug;
	
	$time_start = microtime(true);
	if(!$mysql->MySqlHdl->ping()) {
		$Log->Log(" CheckMySql failed: " . $mysql->MySqlHdl->connect_error);
		$mysql->MySqlHdl->close();
		free($mysql);
		
		$mysql = new DB($SetUp->GetData("Database", "Server"),
			$SetUp->GetData("Database", "Database"),
			$SetUp->GetData("Database", "User"),
			$SetUp->GetData("Database", "Pass"),
			$SetUp->GetData("Database", "Port"));
		$Log->Log(" MySql restarted");
	}
	$time_end = microtime(true);
	$time = $time_end - $time_start;
#	if($Debug) {
		$Log->Log("  CheckMySqlConnection Dauer: ".$time);
#	}
}

$sqlX = "SELECT count(*) from vicidial_campaigns where agent_pause_codes_active != 'N';";
if($DB) { $Log->Log($sqlX);}
if($resX = $mysql->MySqlHdl->query($sqlX)) {
	$rowX = $resX->fetch_array(MYSQLI_BOTH);
	$EnPauseStatus = $rowX[0];
} else {
	if($err = $mysql->MySqlHdl->error) {
		$Log->Log(" -- MariaDB Fehler: " . $err);
	}
}



while(1) {

	$time_start = microtime(true);
	
	CheckMysqlConnection();
	
	$sql = "UPDATE `".$TableNameRTV."` SET `invalid` = 1;";
	if($DB) { $Log->Log($sql);}
	if(!$res = $mysql->MySqlHdl->query($sql)) {
		if($err = $mysql->MySqlHdl->error) {
			$Log->Log(" -- MariaDB Fehler: " . $err);
		}
	}
	
	$sql1 = "SELECT * FROM `vicidial_live_agents`;";
	if($DB) { $Log->Log($sql1);}
	$Anz = 0;
	if ($res1 = $mysql->MySqlHdl->query($sql1)) {
		while($row = $res1->fetch_array(MYSQLI_BOTH)) {
			
			$InGrp = "";
			$WaitTime = "";
			$CustPhone = GetCustPhone($row["lead_id"]);
#			$AgentPhone = GetAgentPhone($row["extension"], $row["server_ip"]);
			
			if (!preg_match("/INCALL|DIAL|QUEUE|PARK|3-WAY/i",$row["status"])) {
				$TimeFirst = strtotime($row["last_state_change"]);
			} else if (preg_match("/3-WAY/i",$row["status"])) {
				$TimeFirst = strtotime($row["last_call_time"]);
			} else {
				$TimeFirst = strtotime($row["last_call_time"]);
			}
			if(($row["lead_id"] != 0) && ($CustPhone == "")) {
				$row["status"] = "DEAD";
				$TimeFirst = strtotime($row["last_state_change"]);
			}
			$TimeDiff = time() - $TimeFirst;
			$SubSt = "";
			if($row["status"] == "INCALL") {
				if($row["comments"] == "MANUAL") {
					$SubSt = "M";
				}
				if($row["comments"] == "AUTO") {
					$SubSt = "A";
				}
				if($row["comments"] == "INBOUND") {
					$SubSt = "I";
					list($InGrp, $WaitTime) = GetInbound($row["callerid"]);
				}
			}
			$PauseSt = "";
			if($row["status"] == "PAUSED") {
				$PauseSt = GetPauseStatus($row["user"], $row["agent_log_id"]);
			}
			
#			$sql2  = "INSERT IGNORE INTO `".$TableNameRTV."` (`Station`,`Phone`, `User`, `UserGrp`, `SessionID`, `Status`, `SubStatus`, `CustomPhone`, `ServerIP`, `CallServerIP`, `Time`, `Campaign`, `Calls`, `Hold`, `Ingroup`) ";
			$sql2  = "INSERT IGNORE INTO `".$TableNameRTV."` SET `Station` = '".$row["extension"]."', `Phone` = '', `User` = '".$row["user"]."', `UserGrp` = '' , `SessionID` = '".$row["conf_exten"]."', `Status` = '".$row["status"]."', `SubStatus` = '".$SubSt."', `CustomPhone` = '".$CustPhone."', `ServerIP` = '".$row["server_ip"]."', `CallServerIP` = '".$row["call_server_ip"]."', `Time` = 0, `Campaign` = '".$row["campaign_id"]."', `Calls` = '".$row["calls_today"]."', `Pause` = '".$PauseSt."', `Hold` = '".$WaitTime."', `Ingroup` = '".$InGrp."', `invalid` = 0 ";
			$sql2 .= " ON DUPLICATE KEY UPDATE ";
			$sql2 .= " `Station` = '".$row["extension"]."',`Pause` = '".$PauseSt."', `Time` = '".$TimeDiff."', `SessionID` = '".$row["conf_exten"]."', `Status` = '".$row["status"]."', `SubStatus` = '".$SubSt."', `CustomPhone` = '".$CustPhone."', `ServerIP` = '".$row["server_ip"]."', `CallServerIP` = '".$row["call_server_ip"]."', `Campaign` = '".$row["campaign_id"]."', `Calls` = '".$row["calls_today"]."', `Hold` = '".$WaitTime."', `Ingroup` = '".$InGrp."', `invalid` = 0;";
#			$sql2 .= "VALUES ('".$row["extension"]."', '', '".$row["user"]."', '', '".$row["conf_exten"]."', '".$row["status"]."', '', '', '".$row["server_ip"]."', '".$row["call_server_ip"]."', '', '".$row["campaign_id"]."', '".$row["calls_today"]."', '', ''); ";
			if($DB) { $Log->Log($sql2);}
			if ($res2 = $mysql->MySqlHdl->query($sql2)) {
				if($DB) {
					$Log->Log($row['user'] . " Update with ".$row["status"] ."|". $PauseSt);
				}
			} else {
				if($err = $mysql->MySqlHdl->error) {
					$Log->Log(" -- MariaDB Fehler: " . $err);
				}
			}
			$Anz++;
		}
	} else {
		if($err = $mysql->MySqlHdl->error) {
			$Log->Log(" -- MariaDB Fehler: " . $err);
		}
	}
	FillUser();
	FillPhone();
	$sql = "DELETE FROM `".$TableNameRTV."` WHERE `invalid` = 1;";
	if($DB) { $Log->Log($sql);}
	if(!$res = $mysql->MySqlHdl->query($sql)) {
		if($err = $mysql->MySqlHdl->error) {
			$Log->Log(" -- MariaDB Fehler: " . $err);
		}
	}
	
	$time_end = microtime(true);
	
	$time = $time_end - $time_start;
	$Log->Log("Main Anz|Dauer: ".$Anz."|".$time);
	
	if($Anz > 0) {
		usleep(1000000);
	} else {
		usleep(10000000);
	}
}



?>