<?php 

##########################################################
#
# Modul: UserHandling.php
# 
# Part of: vicidial-de
#
# License: AGPLv3
#
# Copyright © 2018 flyingpenguin.de UG <info@flyingpenguin.de>
#             2018 Jörg Frings-Fürst <j.fringsfuerst@flyingpenguin.de>
#
# Description: Basic functions for checking the user.
#
# Functions:
#
# - SetFailLogin
# - CheckLoginCred
#
##########################################################
#
# ToDo:
# 
# Global system_settings
#
#
# Changelog:
#
# 09.04.2018 0.1.1 jff   First Version.
# 08.05.2018 0.1.2 jff   Add function SetFailLogin
#
#
#


$Version = "0.1.2";
$Modul = "TUserHandling";

#
# Globale Parameter
#
$DB=0;



#######################################
#
# function SetFailLogin
#
# Parameter $User (requested)
#           $FailCount
#
# Return : ok    0
#          fail -1
#
# Version : 0.0.1
#
function SetFailLogin($User, $FailCount = 0) {
	global $link;
	
	# Test for requested vars
	if (empty($User)) {
		return -1;
	}
	
	
	$ip = getenv("REMOTE_ADDR");
	
	if($mStmt = $link->prepare("UPDATE vicidial_users SET failed_login_count = ?, set last_login_date=NOW(), last_ip = ? WHERE user = ?;")) {
		$mStmt->bind_param('iss', ($FailCount + 1), $ip, $User);
		$mStmt->execute();
		$mStmt->close();
		return 0;
	} else {
		if($DB) {
			echo("Statement Prepare failed: " . $mysqli->error . PHP_EOL);
		}
	}
	return -1;
}

#######################################
#
# function CheckLoginCred
# 
# Parameter: $User (requested)
#            $Pass (requested)
#
# Return: if ok: Userlevel (>= 1)
#         if wrong User/Pass: 0
#         if error: <0
#
# Version : 0.0.2
#
function CheckUserCred($User, $Pass) {
	global $link;
	
	# Test for requested vars
	if ((empty($User)) || (empty($Pass))) {
		return -1;
	}
	
	$STARTtime = date("U");
	$LOCK_over = ($STARTtime - 900); # failed login lockout time is 15 minutes(900 seconds)
	$LOCK_trigger_attempts = 10;
	
	# Get Crypto method
	# ToDo: own function
	#
	$stmt = "SELECT pass_hash_enabled,pass_key,pass_cost FROM system_settings;";
	$rslt=mysql_to_mysqli($stmt, $link);
	if ($DB) {echo "$stmt\n";}
	$qm_conf_ct = mysqli_num_rows($rslt);
	if ($qm_conf_ct > 0) {
		$row=mysqli_fetch_row($rslt);
		$SSpass_hash_enabled =			$row[0];
		$SSpass_key =					$row[1];
		$SSpass_cost =					$row[2];
	}
	
	$passSQL = "pass='$pass'";
	$passField = "pass";
	$passTest = $pass;
	
	if ($SSpass_hash_enabled > 0) {
		if (file_exists("../agc/bp.pl")) {
			$pass_hash = exec("../agc/bp.pl --pass='$pass'");
		} else {
			$pass_hash = exec("../../agc/bp.pl --pass='$pass'");
		}
		$pass_hash = preg_replace("/PHASH: |\n|\r|\t| /",'',$pass_hash);
		$passSQL = "pass_hash='$pass_hash'";
		$passField = "pass_hash";
		$passTest = $pass_hash;
	}
	
	if($mStmt = $link->prepare("SELECT user_level, failed_login_count, UNIX_TIMESTAMP(last_login_date) from vicidial_users where user = ? and $passField = ? and active='Y' and ( (failed_login_count < ?) or (UNIX_TIMESTAMP(last_login_date) < ?) );")) {
		$mStmt->bind_param('ssii', $User, $passTest, $LOCK_trigger_attempts, $LOCK_over);
		$mStmt->execute();
		$mStmt->bind_result($ul, $failCount, $lld);
		if($mStmt->fetch()) {
			$mStmt->close();
			return $ul;;
		}
		$mStmt->close();
	} else {
		if($DB) {
			echo("Statement Prepare failed: " . $mysqli->error . PHP_EOL);
		}
	}
	SetFailLogin($User, $failCount, $lld);
	return 0;
}





?>