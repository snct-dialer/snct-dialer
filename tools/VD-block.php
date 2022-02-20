<?php 
#
# Modul Block All Inbounds from list_id
#
# Copyright (©) 2019-2021 Jörg Frings-Fürst (j.fringsfuerst@snct-dialer.de)
#               2019-2021 SNCT Gmbh (info@snct-gmbh.de)
#
#  LICENSE: AGPLv3
#
# Changelog:
#
# 20211106 jff add SystemUser
# 20200331 jff add SplitPhoneNumber
# 20190308 jff if not set get phone_code from vicidial_inbound_dids
# 20190305 jff First work
#
#

$mod_vd_block = '0.0.4';
$build = '20211106-5';

$DB=0;
$Log=0;

if (isset($_GET["DB"]))						{$DB=$_GET["DB"];}
    elseif (isset($_POST["DB"]))			{$DB=$_POST["DB"];}
if (isset($_GET["phone_number"]))			{$phone_number=$_GET["phone_number"];}
    elseif (isset($_POST["phone_number"]))	{$phone_number=$_POST["phone_number"];}
if (isset($_GET["did_pattern"]))    		{$did_pattern=$_GET["did_pattern"];}
    elseif (isset($_POST["did_pattern"]))	{$did_pattern=$_POST["did_pattern"];}
if (isset($_GET["list_id"]))                {$list_id=$_GET["list_id"];}
    elseif (isset($_POST["list_id"]))   	{$list_id=$_POST["list_id"];}
if (isset($_GET["phone_code"]))		       	{$phone_code=$_GET["phone_code"];}
    elseif (isset($_POST["phone_code"]))	{$phone_code=$_POST["phone_code"];}
if (isset($_GET["central"]))		       	{$central=$_GET["central"];}
    elseif (isset($_POST["central"]))	    {$central=$_POST["central"];}

#exit(0);

if((!isset($list_id)) | (!isset($phone_code)) | (!isset($phone_number))) {
    exit(0);
}

if(!isset($central)) {
    $central = 0;
}


require_once ("../tools/format_phone.php");

$TmpArray = SplitPhoneNr("$phone_number");
if((isset($TmpArray[0])) && (isset($TmpArray[1]))) {
	$phone_code = $TmpArray[0];
	$phone_number = $TmpArray[1];
}

openlog("VD-BlockLog", LOG_PID | LOG_PERROR, LOG_LOCAL0);
syslog(LOG_DEBUG,"PNR: ". $phone_number . "|PHC: ". $phone_code);


if (strcmp($phone_number, "Anonymous") == 0) {    exit("4949494949631");
}

if ((strncmp($phone_number,"158831", 6) == 0) AND ($phone_code == "43")) {
    exit("4949494949631");
}

require("dbconnect_mysqli.php");
require("functions.php");

if(!isset($phone_code)) {
    $sql = "SELECT `phone_code` FROM `vicidial_inbound_dids` WHERE `did_pattern` = '$did_pattern';";
    if ($DB) {echo "|$sql|\n";}
    $rslt1=mysql_to_mysqli($sql, $link);
    $row1=mysqli_fetch_row($rslt1);
    $phone_code=$row1[0];
}

if ($central != 2) {

    $sql = "SELECT COUNT(*) FROM `vicidial_list` WHERE (`phone_number` = '$phone_number' OR `alt_phone` = '$phone_number') AND `block_status` = 'full' AND `phone_code` = '$phone_code';";
    if ($DB) {echo "|$sql|\n";}
    $rslt2=mysql_to_mysqli($sql, $link);
    $row2=mysqli_fetch_row($rslt2);
    $found=$row2[0];
    if($found > 0) {
	syslog(LOG_DEBUG,"Blocked full found: ". $phone_number . "|". $phone_code);
        exit("4949494949631");
    }

    $sql = "SELECT COUNT(*) FROM `vicidial_list` WHERE (`phone_number` = '$phone_number' OR `alt_phone` = '$phone_number') AND `list_id` = '$list_id' AND `phone_code` = '$phone_code';";
    if ($DB) {echo "|$sql|\n";}
    $rslt2=mysql_to_mysqli($sql, $link);
    $row2=mysqli_fetch_row($rslt2);
    $found=$row2[0];
    if($found > 0) {
	syslog(LOG_DEBUG,"Anwalt found: ". $phone_number . "|". $phone_code);
        exit("4949494949631");
    }
}

#exit(0);

if($central >= 1) {
    $sql = "SELECT `user`, `owner`, `lead_id` from `vicidial_list` WHERE (`phone_number` = '$phone_number' OR `alt_phone` = '$phone_number') AND `phone_code` = '$phone_code'  ORDER BY `last_local_call_time` DESC LIMIT 1;";
    if ($DB) {echo "|$sql|\n";}
    $rslt3=mysql_to_mysqli($sql, $link);
    $row3=mysqli_fetch_row($rslt3);
    $LastUser=$row3[0];
    $Owner=$row3[1];
    
    $User = "";
    if($Owner != "") {
        $User = $Owner; 
    } else {
        if($LastUser != "") {
            $User = $LastUser;
        }
    }
    if(($User != "VDCL") && ($User != "VDAD") && ($User != "")) {
        $sql2 = "SELECT `user`, `custom_one` FROM `vicidial_users` WHERE `user` = '$User' AND `active` = 'Y' AND `SystemUser` = 0;";
        if ($DB) {echo "|$sql2|\n";}
        $rslt4=mysql_to_mysqli($sql2, $link);
        $row4=mysqli_fetch_row($rslt4);
        $found = $row4[1];
        if($found != "") {
	    syslog(LOG_DEBUG,"User/Owner found: ". $User );
            $len = strlen($found);
            if($len == 7) {
                if($phone_code == "43") {
                    $DID = "012661274" . substr($found,0,3);
	            syslog(LOG_DEBUG,"Sendto DID: ". $DID);
                } else {
                    $DID = "4957666470" . substr($found,0,3);
	            syslog(LOG_DEBUG,"Sendto DID: ". $DID);
                }
                exit($DID);
            } else {
                if($phone_code == "43") {
                    $DID = "012661274" . substr($found,-3);
	            syslog(LOG_DEBUG,"Sendto DID: ". $DID);
                } else {
                    $DID = "4957666470" . substr($found,-3);
	            syslog(LOG_DEBUG,"Sendto DID: ". $DID);
                }
                exit($DID);
            }
        }
    }
}

syslog(LOG_DEBUG,"Sendto DID: '0'");
closelog();
exit(0);

?>