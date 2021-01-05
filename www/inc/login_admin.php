<?php 

#
# login_admin.php
#
# License AGPLv3
#
# Copyright 2018-2019 by Jörg Frings-Fürst <open_source@jff.email>
#           2018-2019 by SNCT GmbH <info@snct-gmbh.de>
#
# Version 0.0.2
#
# changelog
#
# 2018-08-31 jff first work
#
#


#$version="0.0.2";
#$build = "20180831-0935";

#
# $DB
# set to 1 to enable debug messages
#
#$DB=0;
#$Debug=0;
#$mel=0;
#$LOG=1;

$PHP_AUTH_USER=$_SERVER['PHP_AUTH_USER'];
$PHP_AUTH_PW=$_SERVER['PHP_AUTH_PW'];
$PHP_SELF=$_SERVER['PHP_SELF'];

$Log->Log("Start User Auth");

if ($non_latin < 1)
{
    $PHP_AUTH_USER = preg_replace('/[^-_0-9a-zA-Z]/', '', $PHP_AUTH_USER);
    $PHP_AUTH_PW = preg_replace('/[^-_0-9a-zA-Z]/', '', $PHP_AUTH_PW);
}
else
{
    $PHP_AUTH_PW = preg_replace("/'|\"|\\\\|;/","",$PHP_AUTH_PW);
    $PHP_AUTH_USER = preg_replace("/'|\"|\\\\|;/","",$PHP_AUTH_USER);
}

function user_authorization($user,$pass,$user_option,$user_update,$api_call)
{
    global $mysql;
    #	require("dbconnect_mysqli.php");
    
    #############################################
    ##### START SYSTEM_SETTINGS LOOKUP #####
    $stmt = "SELECT use_non_latin,webroot_writable,pass_hash_enabled,pass_key,pass_cost,allow_ip_lists,system_ip_blacklist FROM system_settings;";
    $rslt=$mysql->MySqlHdl->query($stmt);
    if ($DB) {echo "$stmt\n";}
    $qm_conf_ct = $rslt->num_rows;
    if ($qm_conf_ct > 0)
    {
        $row=$rslt->fetch_array(MYSQLI_BOTH);
        $non_latin =					$row[0];
        $SSwebroot_writable =			$row[1];
        $SSpass_hash_enabled =			$row[2];
        $SSpass_key =					$row[3];
        $SSpass_cost =					$row[4];
        $SSallow_ip_lists =				$row[5];
        $SSsystem_ip_blacklist =		$row[6];
    }
    ##### END SETTINGS LOOKUP #####
    ###########################################
    
    $STARTtime = date("U");
    $TODAY = date("Y-m-d");
    $NOW_TIME = date("Y-m-d H:i:s");
    $ip = getenv("REMOTE_ADDR");
    $browser = getenv("HTTP_USER_AGENT");
    $LOCK_over = ($STARTtime - 900); # failed login lockout time is 15 minutes(900 seconds)
    $LOCK_trigger_attempts = 10;
    
    $user = preg_replace("/\||`|&|\'|\"|\\\\|;| /","",$user);
    $pass = preg_replace("/\||`|&|\'|\"|\\\\|;| /","",$pass);
    
    $passSQL = "pass='$pass'";
    
    if ($SSpass_hash_enabled > 0)
    {
        if (file_exists("../agc/bp.pl"))
        {$pass_hash = exec("../agc/bp.pl --pass='$pass'");}
        else
        {$pass_hash = exec("../../agc/bp.pl --pass='$pass'");}
        $pass_hash = preg_replace("/PHASH: |\n|\r|\t| /",'',$pass_hash);
        $passSQL = "pass_hash='$pass_hash'";
    }
    
    $stmt="SELECT count(*) from vicidial_users where user='$user' and $passSQL and user_level > 7 and active='Y' and ( (failed_login_count < $LOCK_trigger_attempts) or (UNIX_TIMESTAMP(last_login_date) < $LOCK_over) );";
    if ($user_option == 'REPORTS')
    {$stmt="SELECT count(*) from vicidial_users where user='$user' and $passSQL and user_level > 6 and active='Y' and ( (failed_login_count < $LOCK_trigger_attempts) or (UNIX_TIMESTAMP(last_login_date) < $LOCK_over) );";}
    if ($user_option == 'REMOTE')
    {$stmt="SELECT count(*) from vicidial_users where user='$user' and $passSQL and user_level > 3 and active='Y' and ( (failed_login_count < $LOCK_trigger_attempts) or (UNIX_TIMESTAMP(last_login_date) < $LOCK_over) );";}
    if ($user_option == 'QC')
    {$stmt="SELECT count(*) from vicidial_users where user='$user' and $passSQL and user_level > 1 and active='Y' and ( (failed_login_count < $LOCK_trigger_attempts) or (UNIX_TIMESTAMP(last_login_date) < $LOCK_over) );";}
    if ($DB) {echo "|$stmt|\n";}
    if ($non_latin > 0) {$rslt=$mysql->MySqlHdl->query("SET NAMES 'UTF8'");}
    $rslt=$mysql->MySqlHdl->query($stmt);
    $row=$rslt->fetch_array(MYSQLI_BOTH);
    $auth=$row[0];
    
    if ($auth < 1)
    {
        $auth_key='BAD';
        $stmt="SELECT failed_login_count,UNIX_TIMESTAMP(last_login_date) from vicidial_users where user='$user';";
        if ($non_latin > 0) {$rslt=$mysql->MySqlHdl->query("SET NAMES 'UTF8'");}
        $rslt=$mysql->MySqlHdl->query($stmt);
        $cl_user_ct = $rslt->num_rows;
        if ($cl_user_ct > 0)
        {
            $row=$rslt->fetch_array(MYSQLI_BOTH);
            $failed_login_count =	$row[0];
            $last_login_date =		$row[1];
            
            if ($failed_login_count < $LOCK_trigger_attempts)
            {
                $stmt="UPDATE vicidial_users set failed_login_count=(failed_login_count+1),last_ip='$ip' where user='$user';";
                $rslt=$mysql->MySqlHdl->query($stmt);
            }
            else
            {
                if ($LOCK_over > $last_login_date)
                {
                    $stmt="UPDATE vicidial_users set last_login_date=NOW(),failed_login_count=1,last_ip='$ip' where user='$user';";
                    $rslt=$mysql->MySqlHdl($stmt);
                }
                else
                {$auth_key='LOCK';}
            }
        }
        if ($SSwebroot_writable > 0)
        {
            $fp = fopen ("./project_auth_entries.txt", "a");
            fwrite ($fp, "ADMIN|FAIL|$NOW_TIME|X|$auth_key|$ip|$browser|\n");
            fclose($fp);
        }
    }
    else
    {
        ##### BEGIN IP LIST FEATURES #####
        if ($SSallow_ip_lists > 0)
        {
            $ignore_ip_list=0;
            $whitelist_match=1;
            $blacklist_match=0;
            $stmt="SELECT user_group,ignore_ip_list from vicidial_users where user='$user';";
            if ($non_latin > 0) {$rslt=$mysql->MySqlHdl("SET NAMES 'UTF8'");}
            $rslt=$mysql->MySqlHdl->query($stmt);
            $iipl_user_ct = $rslt->num_rows;
            if ($iipl_user_ct > 0)
            {
                $row=$rslt->fetch_array(MYSQLI_BOTH);
                $user_group =		$row[0];
                $ignore_ip_list =	$row[1];
            }
            if ($ignore_ip_list < 1)
            {
                $ip_class_c = preg_replace('~\.\d+(?!.*\.\d+)~', '.x', $ip);
                
                if (strlen($SSsystem_ip_blacklist) > 1)
                {
                    $blacklist_match=1;
                    $stmt="SELECT count(*) from vicidial_ip_list_entries where ip_list_id='$SSsystem_ip_blacklist' and ip_address IN('$ip','$ip_class_c');";
                    $rslt=$mysql->MySqlHdl->query($stmt);
                    $vile_ct = $rslt->num_rows;
                    if ($vile_ct > 0)
                    {
                        $row=$rslt->fetch_array(MYSQLI_BOTH);
                        $blacklist_match =	$row[0];
                    }
                }
                
                $stmt="SELECT admin_ip_list,api_ip_list from vicidial_user_groups where user_group='$user_group';";
                $rslt=$mysql->MySqlHdl->query($stmt);
                $iipl_user_ct = $rslt->num_rows;
                if ($iipl_user_ct > 0)
                {
                    $row=$rslt->fetch_array(MYSQLI_BOTH);
                    $admin_ip_list =	$row[0];
                    $api_ip_list =		$row[1];
                    
                    if ($api_call != '1')
                    {$check_ip_list = $admin_ip_list;}
                    else
                    {$check_ip_list = $api_ip_list;}
                    
                    if (strlen($check_ip_list) > 1)
                    {
                        $whitelist_match=0;
                        $stmt="SELECT count(*) from vicidial_ip_list_entries where ip_list_id='$check_ip_list' and ip_address IN('$ip','$ip_class_c');";
                        $rslt=$mysql->MySqlHdl->query($stmt);
                        $vile_ct = $rslt->num_rows;
                        if ($vile_ct > 0)
                        {
                            $row=$rslt->fetch_array(MYSQLI_BOTH);
                            $whitelist_match =	$row[0];
                        }
                    }
                }
            }
            
            if ( ($whitelist_match < 1) or ($blacklist_match > 0) )
            {
                $auth_key='IPBLOCK';
                $login_problem++;
            }
        }
        ##### END IP LIST FEATURES #####
        
        if ($login_problem < 1)
        {
            if ($user_update > 0)
            {
                $stmt="UPDATE vicidial_users set last_login_date=NOW(),last_ip='$ip',failed_login_count=0 where user='$user';";
                $rslt=$mysql->MySqlHdl->query($stmt);
            }
            $auth_key='GOOD';
        }
    }
    return $auth_key;
}
##### END validate user login credentials, check for failed lock out #####



$stmt="SELECT selected_language from vicidial_users where user='$PHP_AUTH_USER';";
if ($DB) {echo "$stmt|";}
$rslt=$mysql->MySqlHdl->query($stmt);
$sl_ct = $rslt->num_rows;
if ($sl_ct > 0)
{
    $row=$rslt->fetch_array(MYSQLI_BOTH);
    $VUselected_language =		$row[0];
}

# Valid user
$auth=0;
$auth_message = user_authorization($PHP_AUTH_USER,$PHP_AUTH_PW,'',1,0);
if ($auth_message == 'GOOD')
{$auth=1;}

if ($auth < 1)
{
    $VDdisplayMESSAGE = "Login incorrect, please try again";
    if ($auth_message == 'LOCK')
    {
        $VDdisplayMESSAGE = _QXZ("Too many login attempts, try again in 15 minutes");
        Header ("Content-type: text/html; charset=utf-8");
        echo "$VDdisplayMESSAGE: |$PHP_AUTH_USER|$auth_message|\n";
        exit;
    }
    if ($auth_message == 'IPBLOCK')
    {
        $VDdisplayMESSAGE = _QXZ("Your IP Address is not allowed") . ": $ip";
        Header ("Content-type: text/html; charset=utf-8");
        echo "$VDdisplayMESSAGE: |$PHP_AUTH_USER|$auth_message|\n";
        exit;
    }
    Header("WWW-Authenticate: Basic realm=\"SNCT-Dialer\"");
    Header("HTTP/1.0 401 Unauthorized");
    echo "$VDdisplayMESSAGE: |$PHP_AUTH_USER|$PHP_AUTH_PW|$auth_message|\n";
    exit;
}

# User permissions
$rights_stmt = "SELECT user_group, modify_inbound_dids, delete_inbound_dids, modify_campaigns, delete_campaigns, modify_users, delete_users, user_level, modify_same_user_level from vicidial_users where user='$PHP_AUTH_USER';";
if ($DB) {echo "$rights_stmt|";}
$rights_rslt=$mysql->MySqlHdl->query($rights_stmt);
$rights_row=$rights_rslt->fetch_array(MYSQLI_BOTH);
$user_group =		$rights_row[0];
$modify_dids =		$rights_row[1];
$delete_dids =		$rights_row[2];
$modify_campaigns =	$rights_row[3];
$delete_campaigns =	$rights_row[4];
$modify_users =		$rights_row[5];
$delete_users =		$rights_row[6];
$user_level =		$rights_row[7];
$modify_level =		$rights_row[8];

# User group permissions
$rights_stmt = "SELECT allowed_campaigns,admin_viewable_groups from vicidial_user_groups where user_group='$user_group';";
if ($DB) {echo "$rights_stmt|";}
$rights_rslt=$mysql->MySqlHdl->query($rights_stmt);
$rights_row=$rights_rslt->fetch_array(MYSQLI_BOTH);
$LOGallowed_campaigns =			$rights_row[0];
$LOGadmin_viewable_groups =		$rights_row[1];

$allowed_campaignsSQL='';
if ( (!preg_match('/\-ALL/i', $LOGallowed_campaigns)) )
{
    $rawLOGallowed_campaignsSQL = preg_replace("/ -/",'',$LOGallowed_campaigns);
    $rawLOGallowed_campaignsSQL = preg_replace("/ /","','",$rawLOGallowed_campaignsSQL);
    $allowed_campaignsSQL = "campaign_id IN('$rawLOGallowed_campaignsSQL')";
}
else
{
    $rights_stmt = "SELECT campaign_id FROM vicidial_campaigns;";
    if ($DB) {echo "$rights_stmt|";}
    $rights_rslt=$mysql->MySqlHdl->query($rights_stmt);
    $rights_rsltCOUNT=$rights_rslt->num_rows;
    $allowed_campaignsSQL = "campaign_id IN(";
    $i=0;
    while ($i < $rights_rsltCOUNT)
    {
        $rights_row=mysqli_fetch_row($rights_rslt);
        $allowed_campaignsSQL.= "'" . $rights_row[0] . "',";
        $i++;
    }
    $allowed_campaignsSQL.= "'')";
}

$admin_viewable_groupsSQL='';
if  (!preg_match('/\-\-ALL\-\-/i',$LOGadmin_viewable_groups))
{
    $rawLOGadmin_viewable_groupsSQL = preg_replace("/ -/",'',$LOGadmin_viewable_groups);
    $rawLOGadmin_viewable_groupsSQL = preg_replace("/ /","','",$rawLOGadmin_viewable_groupsSQL);
    $admin_viewable_groupsSQL = "user_group IN('---ALL---','$rawLOGadmin_viewable_groupsSQL')";
}
else
{
    $rights_stmt = "SELECT user_group FROM vicidial_user_groups;";
    if ($DB) {echo "$rights_stmt|";}
    $rights_rslt=$mysql->MySqlHdl->query($rights_stmt);
    $rights_rsltCOUNT=$rights_rslt->num_rows;
    $admin_viewable_groupsSQL = "user_group IN('---ALL---',";
    $i=0;
    while ($i < $rights_rsltCOUNT)
    {
        $rights_row=mysqli_fetch_row($rights_rslt);
        $admin_viewable_groupsSQL.= "'" . $rights_row[0] . "',";
        $i++;
    }
    $admin_viewable_groupsSQL.= "'')";
}



?>