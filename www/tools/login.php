<?php
###############################################################################
#
# Modul login.php
#
# SNCT-Dialer™ handle login
#
# Copyright (©) 2023 SNCT GmbH <info@snct-gmbh.de>
#               2023 Jörg Frings-Fürst <open_source@jff.email>
#
# LICENSE: AGPLv3
#
###############################################################################
#
# requested Module:
#
# dbconnect_mysqli.php
# functions.php
# admin_functions.php
# admin_header.php
# options.php
# ../tools/system_wide_settings.php
# ../inc/get_system_settings.php
# ../inc/funtions_ng.php
# language_header.php
#
###############################################################################
#
# Version  / Build
#
$admin_login_version = '3.1.1-1';
$admin_login_build = '20230720-1';
#
###############################################################################
#
# Changelog
#
# 2023-07-20 jff    First version
#
#

require_once("../tools/system_wide_settings.php");
require_once("language_header.php");

$PHP_AUTH_USER = preg_replace("/'|\"|\\\\|;/","",$PHP_AUTH_USER);
$PHP_AUTH_PW = preg_replace("/'|\"|\\\\|;/","",$PHP_AUTH_PW);


$auth=0;
$auth_message = user_authorization_ng($PHP_AUTH_USER,$PHP_AUTH_PW,'',1,0);

if ($auth_message == 'GOOD') {
    $auth=1;
}

if ($auth < 1) {
    $VDdisplayMESSAGE = _QXZ("Login incorrect, please try again");
    if ($auth_message == 'LOCK')     {
        $VDdisplayMESSAGE = _QXZ("Too many login attempts, try again in 15 minutes");
        Header ("Content-type: text/html; charset=utf-8");
        echo "$VDdisplayMESSAGE: |$PHP_AUTH_USER|$auth_message|\n";
        exit;
    }
    if ($auth_message == 'IPBLOCK') {
        $VDdisplayMESSAGE = _QXZ("Your IP Address is not allowed") . ": $ip";
        Header ("Content-type: text/html; charset=utf-8");
        echo "$VDdisplayMESSAGE: |$PHP_AUTH_USER|$auth_message|\n";
        exit;
    }
    Header("WWW-Authenticate: Basic realm=\"CONTACT-CENTER-ADMIN\"");
    Header("HTTP/1.0 401 Unauthorized");
    echo "$VDdisplayMESSAGE: |$PHP_AUTH_USER|$PHP_AUTH_PW|$auth_message|\n";
    exit;
}


##### BEGIN validate user login credentials, check for failed lock out #####
function user_authorization_ng($user,$pass,$user_option,$user_update,$bcrypt,$return_hash,$api_call,$source) {
    global $DB, $mel;
    
    require("dbconnect_mysqli.php");
    
    #############################################
    ##### START SYSTEM_SETTINGS LOOKUP #####
    $stmt = "SELECT use_non_latin,webroot_writable,pass_hash_enabled,pass_key,pass_cost,hosted_settings,allow_ip_lists,system_ip_blacklist FROM system_settings;";
    $rslt=mysql_to_mysqli($stmt, $link);
    if ($DB) {echo "$stmt\n";}
    $qm_conf_ct = mysqli_num_rows($rslt);
    if ($qm_conf_ct > 0) {
        $row=mysqli_fetch_row($rslt);
        $non_latin =					$row[0];
        $SSwebroot_writable =			$row[1];
        $SSpass_hash_enabled =			$row[2];
        $SSpass_key =					$row[3];
        $SSpass_cost =					$row[4];
        $SShosted_settings =			$row[5];
        $SSallow_ip_lists =				$row[6];
        $SSsystem_ip_blacklist =		$row[7];
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
    $pass_hash='';
    
    $user = preg_replace("/\||`|&|\'|\"|\\\\|;| /","",$user);
    $pass = preg_replace("/\||`|&|\'|\"|\\\\|;| /","",$pass);
    
    $passSQL = "pass='$pass'";
    
    if ($SSpass_hash_enabled > 0) {
        if ($bcrypt < 1) {
            $pass_hash = exec("./bp.pl --pass='$pass'");
            $pass_hash = preg_replace("/PHASH: |\n|\r|\t| /",'',$pass_hash);
        } else {
            $pass_hash = $pass;
        }
        $passSQL = "pass_hash='$pass_hash'";
    }
    
    $stmt="SELECT count(*) from vicidial_users where user='$user' and $passSQL and user_level > 0 and active='Y' and ( (failed_login_count < $LOCK_trigger_attempts) or (UNIX_TIMESTAMP(last_login_date) < $LOCK_over) );";
    if ($user_option == 'MGR') {
        $stmt="SELECT count(*) from vicidial_users where user='$user' and $passSQL and manager_shift_enforcement_override='1' and active='Y' and ( (failed_login_count < $LOCK_trigger_attempts) or (UNIX_TIMESTAMP(last_login_date) < $LOCK_over) );";
    }
    if ($DB) {
        echo "|$stmt|\n";
    }
    if ($non_latin > 0) {
        $rslt=mysql_to_mysqli("SET NAMES 'UTF8'", $link);
    }
    $rslt=mysql_to_mysqli($stmt, $link);
    if ($mel > 0) {
        mysql_error_logging($NOW_TIME,$link,$mel,$stmt,'05009',$user,$server_ip,$session_name,$one_mysql_log);
    }
    $row=mysqli_fetch_row($rslt);
    $auth=$row[0];
    
    if ($auth < 1) {
        $auth_key='BAD'."|$bcrypt|$source|$stmt";
        $stmt="SELECT failed_login_count,UNIX_TIMESTAMP(last_login_date) from vicidial_users where user='$user';";
        if ($non_latin > 0) {
            $rslt=mysql_to_mysqli("SET NAMES 'UTF8'", $link);
        }
        $rslt=mysql_to_mysqli($stmt, $link);
        if ($mel > 0) {
            mysql_error_logging($NOW_TIME,$link,$mel,$stmt,'05010',$user,$server_ip,$session_name,$one_mysql_log);
        }
        $cl_user_ct = mysqli_num_rows($rslt);
        if ($cl_user_ct > 0) {
            $row=mysqli_fetch_row($rslt);
            $failed_login_count =	$row[0];
            $last_login_date =		$row[1];
            
            if ($failed_login_count < $LOCK_trigger_attempts) {
                $stmt="UPDATE vicidial_users set failed_login_count=(failed_login_count+1),last_ip='$ip' where user='$user';";
                $rslt=mysql_to_mysqli($stmt, $link);
                if ($mel > 0) {
                    mysql_error_logging($NOW_TIME,$link,$mel,$stmt,'05011',$user,$server_ip,$session_name,$one_mysql_log);
                }
            } else {
                if ($LOCK_over > $last_login_date) {
                    $stmt="UPDATE vicidial_users set last_login_date=NOW(),failed_login_count=1,last_ip='$ip' where user='$user';";
                    $rslt=mysql_to_mysqli($stmt, $link);
                    if ($mel > 0) {
                        mysql_error_logging($NOW_TIME,$link,$mel,$stmt,'05012',$user,$server_ip,$session_name,$one_mysql_log);
                    }
                } else {
                    $auth_key='LOCK';
                }
            }
        }
        if ($SSwebroot_writable > 0) {
            $fp = fopen ("./project_auth_entries.txt", "a");
            fwrite ($fp, "AGENT|FAIL|$NOW_TIME|$user|$auth_key|$ip|$browser|\n");
            fclose($fp);
        }
    } else {
        $login_problem=0;
        $aas_total=0;
        $ap_total=0;
        $vla_total=0;
        $mvla_total=0;
        $vla_set=0;
        $vla_on=0;
        
        $stmt = "SELECT count(*) FROM servers where active='Y' and active_asterisk_server='Y';";
        $rslt=mysql_to_mysqli($stmt, $link);
        if ($DB) {
            echo "$stmt\n";
        }
        $aas_ct = mysqli_num_rows($rslt);
        if ($aas_ct > 0) {
            $row=mysqli_fetch_row($rslt);
            $aas_total =				$row[0];
        }
        
        #	$stmt = "SELECT count(*) FROM phones where active='Y';";
        #	$rslt=mysql_to_mysqli($stmt, $link);
        #	if ($DB) {echo "$stmt\n";}
        #	$ap_ct = mysqli_num_rows($rslt);
        #	if ($ap_ct > 0)
        #		{
        #		$row=mysqli_fetch_row($rslt);
            #		$ap_total =					$row[0];
            #		}
            
        $stmt = "SELECT count(*) FROM vicidial_live_agents where user!='$user';";
        $rslt=mysql_to_mysqli($stmt, $link);
        if ($DB) {
            echo "$stmt\n";
        }
        $vla_ct = mysqli_num_rows($rslt);
        if ($vla_ct > 0) {
            $row=mysqli_fetch_row($rslt);
            $vla_total =				$row[0];
        }
            
        $stmt = "SELECT count(*) FROM vicidial_live_agents where user='$user';";
        $rslt=mysql_to_mysqli($stmt, $link);
        if ($DB) {
            echo "$stmt\n";
        }
        $mvla_ct = mysqli_num_rows($rslt);
        if ($mvla_ct > 0) {
            $row=mysqli_fetch_row($rslt);
            $mvla_total =				$row[0];
        }
            
        if ( (preg_match("/MXAG/",$SShosted_settings)) and ($mvla_total < 1) ) {
            $vla_set = $SShosted_settings;
            $vla_set = preg_replace("/.*MXAG|_BUILD_|DRA|_MXCS\d+|_MXTR\d+| /",'',$vla_set);
            $vla_set = preg_replace('/[^0-9]/','',$vla_set);
            if (strlen($vla_set)>0) {
                $vla_on++;
            }
        }
            
        if ($aas_total < 1) {
            $auth_key='ERRSERVERS';
            $login_problem++;
        }
            #	if ($ap_total < 1)
            #		{
            #		$auth_key='ERRPHONES';
                #		$login_problem++;
                #		}
        if ( ($vla_total >= $vla_set) and ($vla_on > 0) and ($api_call != '1') ) {
            $auth_key='ERRAGENTS';
            $login_problem++;
        }
                
                ##### BEGIN IP LIST FEATURES #####
        if ($SSallow_ip_lists > 0) {
            $ignore_ip_list=0;
            $whitelist_match=1;
            $blacklist_match=0;
            $stmt="SELECT user_group,ignore_ip_list from vicidial_users where user='$user';";
            if ($non_latin > 0) {
                $rslt=mysql_to_mysqli("SET NAMES 'UTF8'", $link);
            }
            $rslt=mysql_to_mysqli($stmt, $link);
            if ($mel > 0) {
                mysql_error_logging($NOW_TIME,$link,$mel,$stmt,'05023',$user,$server_ip,$session_name,$one_mysql_log);
            }
            $iipl_user_ct = mysqli_num_rows($rslt);
            if ($iipl_user_ct > 0) {
                $row=mysqli_fetch_row($rslt);
                $user_group =		$row[0];
                $ignore_ip_list =	$row[1];
            }
            if ($ignore_ip_list < 1) {
                $ip_class_c = preg_replace('~\.\d+(?!.*\.\d+)~', '.x', $ip);
                        
                if (strlen($SSsystem_ip_blacklist) > 1) {
                $blacklist_match=1;
                $stmt="SELECT count(*) from vicidial_ip_list_entries where ip_list_id='$SSsystem_ip_blacklist' and ip_address IN('$ip','$ip_class_c');";
                $rslt=mysql_to_mysqli($stmt, $link);
                if ($mel > 0) {
                    mysql_error_logging($NOW_TIME,$link,$mel,$stmt,'05024',$user,$server_ip,$session_name,$one_mysql_log);
                }
                $vile_ct = mysqli_num_rows($rslt);
                if ($vile_ct > 0) {
                    $row=mysqli_fetch_row($rslt);
                    $blacklist_match =	$row[0];
                }
            }
                        
            $stmt="SELECT agent_ip_list,api_ip_list from vicidial_user_groups where user_group='$user_group';";
            $rslt=mysql_to_mysqli($stmt, $link);
            if ($mel > 0) {
                mysql_error_logging($NOW_TIME,$link,$mel,$stmt,'05025',$user,$server_ip,$session_name,$one_mysql_log);
            }
            $iipl_user_ct = mysqli_num_rows($rslt);
            if ($iipl_user_ct > 0) {
                $row=mysqli_fetch_row($rslt);
                $agent_ip_list =	$row[0];
                $api_ip_list =		$row[1];
                            
                if ($api_call != '1') {
                $check_ip_list = $agent_ip_list;
            } else {
                $check_ip_list = $api_ip_list;
            }
                            
            if (strlen($check_ip_list) > 1) {
                $whitelist_match=0;
                $stmt="SELECT count(*) from vicidial_ip_list_entries where ip_list_id='$check_ip_list' and ip_address IN('$ip','$ip_class_c');";
                $rslt=mysql_to_mysqli($stmt, $link);
                if ($mel > 0) {
                    mysql_error_logging($NOW_TIME,$link,$mel,$stmt,'05026',$user,$server_ip,$session_name,$one_mysql_log);
                }
                $vile_ct = mysqli_num_rows($rslt);
                if ($vile_ct > 0) {
                    $row=mysqli_fetch_row($rslt);
                    $whitelist_match =	$row[0];
                }
            }
        }
    }
                    
    if ( ($whitelist_match < 1) or ($blacklist_match > 0) ) {
        $auth_key='IPBLOCK';
        $login_problem++;
    }
}
##### END IP LIST FEATURES #####
                
            if ($login_problem < 1) {
                if ($user_update > 0) {
                    $stmt="UPDATE vicidial_users set last_login_date=NOW(),last_ip='$ip',failed_login_count=0 where user='$user';";
                    $rslt=mysql_to_mysqli($stmt, $link);
                    if ($mel > 0) {
                        mysql_error_logging($NOW_TIME,$link,$mel,$stmt,'05013',$user,$server_ip,$session_name,$one_mysql_log);
                    }
                }
                $auth_key='GOOD';
                if ( ($return_hash == '1') and ($SSpass_hash_enabled > 0) and (strlen($pass_hash) > 12) ) {
                    $auth_key .= "|$pass_hash";
                }
            }
        }
        return $auth_key;
}
        ##### END validate user login credentials, check for failed lock out #####
        


?>