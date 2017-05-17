<?php
# NANPA_running_processes.php
# 
# Copyright (C) 2017  Matt Florell <vicidial@gmail.com>    LICENSE: AGPLv2
#
# This script shows running NANPA filter batch proccesses
#
# CHANGELOG:
# 130921-0756 - First build of script
# 141007-2044 - Finalized adding QXZ translation to all admin files
# 141229-2020 - Added code for on-the-fly language translations display
# 160108-2300 - Changed some mysqli_query to mysql_to_mysqli for consistency
# 170409-1537 - Added IP List validation code
#

$version = '2.14-5';
$build = '170409-1537';
$startMS = microtime();

require("dbconnect_mysqli.php");
require("functions.php");

$PHP_AUTH_USER=$_SERVER['PHP_AUTH_USER'];
$PHP_AUTH_PW=$_SERVER['PHP_AUTH_PW'];
$PHP_SELF=$_SERVER['PHP_SELF'];
if (isset($_GET["output_codes_to_display"]))			{$output_codes_to_display=$_GET["output_codes_to_display"];}
	elseif (isset($_POST["output_codes_to_display"]))	{$output_codes_to_display=$_POST["output_codes_to_display"];}
if (isset($_GET["show_history"]))			{$show_history=$_GET["show_history"];}
	elseif (isset($_POST["show_history"]))	{$show_history=$_POST["show_history"];}
if (isset($_GET["process_limit"]))			{$process_limit=$_GET["process_limit"];}
	elseif (isset($_POST["process_limit"]))	{$process_limit=$_POST["process_limit"];}

#############################################
##### START SYSTEM_SETTINGS LOOKUP #####
$stmt = "SELECT use_non_latin,outbound_autodial_active,slave_db_server,reports_use_slave_db,enable_languages,language_method FROM system_settings;";
$rslt=mysql_to_mysqli($stmt, $link);
if ($DB) {$MAIN.="$stmt\n";}
$qm_conf_ct = mysqli_num_rows($rslt);
if ($qm_conf_ct > 0)
	{
	$row=mysqli_fetch_row($rslt);
	$non_latin =					$row[0];
	$outbound_autodial_active =		$row[1];
	$slave_db_server =				$row[2];
	$reports_use_slave_db =			$row[3];
	$SSenable_languages =			$row[4];
	$SSlanguage_method =			$row[5];
	}
##### END SETTINGS LOOKUP #####
###########################################

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

$process_limit = preg_replace('/[^-_0-9a-zA-Z]/', '', $process_limit);

$NOW_DATE = date("Y-m-d");

$stmt="SELECT selected_language from vicidial_users where user='$PHP_AUTH_USER';";
if ($DB) {echo "|$stmt|\n";}
$rslt=mysql_to_mysqli($stmt, $link);
$sl_ct = mysqli_num_rows($rslt);
if ($sl_ct > 0)
	{
	$row=mysqli_fetch_row($rslt);
	$VUselected_language =		$row[0];
	}

$user_auth=0;
$auth=0;
$reports_auth=0;
$qc_auth=0;
$auth_message = user_authorization($PHP_AUTH_USER,$PHP_AUTH_PW,'QC',1,0);
if ($auth_message == 'GOOD')
	{$user_auth=1;}

if ($user_auth > 0)
	{
	$stmt="SELECT count(*) from vicidial_users where user='$PHP_AUTH_USER' and user_level > 7;";
	if ($DB) {echo "|$stmt|\n";}
	$rslt=mysql_to_mysqli($stmt, $link);
	$row=mysqli_fetch_row($rslt);
	$auth=$row[0];

	$stmt="SELECT count(*) from vicidial_users where user='$PHP_AUTH_USER' and user_level > 6 and view_reports='1';";
	if ($DB) {echo "|$stmt|\n";}
	$rslt=mysql_to_mysqli($stmt, $link);
	$row=mysqli_fetch_row($rslt);
	$reports_auth=$row[0];

	$stmt="SELECT count(*) from vicidial_users where user='$PHP_AUTH_USER' and user_level > 1 and qc_enabled='1';";
	if ($DB) {echo "|$stmt|\n";}
	$rslt=mysql_to_mysqli($stmt, $link);
	$row=mysqli_fetch_row($rslt);
	$qc_auth=$row[0];

	$reports_only_user=0;
	$qc_only_user=0;
	if ( ($reports_auth > 0) and ($auth < 1) )
		{
		$ADD=999999;
		$reports_only_user=1;
		}
	if ( ($qc_auth > 0) and ($reports_auth < 1) and ($auth < 1) )
		{
		if ( ($ADD != '881') and ($ADD != '100000000000000') )
			{
            $ADD=100000000000000;
			}
		$qc_only_user=1;
		}
	if ( ($qc_auth < 1) and ($reports_auth < 1) and ($auth < 1) )
		{
		$VDdisplayMESSAGE = _QXZ("You do not have permission to be here");
		Header ("Content-type: text/html; charset=utf-8");
		echo "$VDdisplayMESSAGE: |$PHP_AUTH_USER|$auth_message|\n";
		exit;
		}
	}
else
	{
	$VDdisplayMESSAGE = _QXZ("Login incorrect, please try again");
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
	Header("WWW-Authenticate: Basic realm=\"CONTACT-CENTER-ADMIN\"");
	Header("HTTP/1.0 401 Unauthorized");
	echo "$VDdisplayMESSAGE: |$PHP_AUTH_USER|$PHP_AUTH_PW|$auth_message|\n";
	exit;
	}

$oc_ct=count($output_codes_to_display);
$oc_SQL="'',";
$url_str="";

for ($i=0; $i<$oc_ct; $i++) 
	{
	$oc_SQL.="'$output_codes_to_display[$i]',";
	$url_str.="output_codes_to_display[]=".$output_codes_to_display[$i];
	}
$oc_SQL=substr($oc_SQL, 0, -1);

if (!$show_history) {
	$process_stmt="SELECT output_code,status,server_ip,list_id,start_time,update_time,user,leads_count,filter_count,status_line,script_output from vicidial_nanpa_filter_log where output_code in ($oc_SQL) and status!='COMPLETED'";
	$process_rslt=mysql_to_mysqli($process_stmt, $link);
	$report_title=_QXZ("Currently running NANPA scrubs");
} else {
	if (!$process_limit) {$process_limit=10;}
	$process_stmt="SELECT output_code,status,server_ip,list_id,start_time,update_time,user,leads_count,filter_count,status_line,script_output from vicidial_nanpa_filter_log where user='$PHP_AUTH_USER' and status='COMPLETED' order by start_time desc limit $process_limit";

	$process_rslt=mysql_to_mysqli($process_stmt, $link);
	$report_title=_QXZ("Past NANPA scrubs for user")." $PHP_AUTH_USER";

	$past_process_ct=mysqli_num_rows($process_rslt);
	if ($process_limit<=$past_process_ct) {
		$upper_limit=$process_limit+10;
		$more_history_link="<BR><FONT FACE=\"ARIAL,HELVETICA\" COLOR=BLACK SIZE=1><a name='past_scrubs' href='#past_scrubs' onClick='ShowPastProcesses($upper_limit)'>"._QXZ("Show more processes")."</a></font>";
	} else {
		$more_history_link="";
	}
}

if (mysqli_num_rows($process_rslt)>0) {
	echo "<table width='770' cellpadding=5 cellspacing=0>";
	echo "<tr><th colspan='7' bgcolor='#015B91'><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE SIZE=2>$report_title</th></tr>";
	echo "<tr>";
	echo "<td align='left' bgcolor='#015B91' width='80'><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE SIZE=2>"._QXZ("Start time")."</th>";
	echo "<td align='left' bgcolor='#015B91' width='80'><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE SIZE=2>"._QXZ("Status")."</th>";
	echo "<td align='left' bgcolor='#015B91' width='100'><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE SIZE=2>"._QXZ("Last updated")."</th>";
	echo "<td align='left' bgcolor='#015B91' width='80'><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE SIZE=2>"._QXZ("Leads count")."</th>";
	echo "<td align='left' bgcolor='#015B91' width='80'><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE SIZE=2>"._QXZ("Filter count")."</th>";
	echo "<td align='left' bgcolor='#015B91' width='180'><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE SIZE=2>"._QXZ("Status line")."</th>";
	echo "<td align='left' bgcolor='#015B91' width='170'><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE SIZE=2>"._QXZ("Last script output")."</th>";
	echo "</tr>";

	while ($row=mysqli_fetch_array($process_rslt)) {
		if ($bgcolor=="#9BB9FB") {$bgcolor="#B9CBFD";} else {$bgcolor='#9BB9FB';}
		$row["script_output"]=preg_replace('/\n/', '<BR/>', $row["script_output"]);
		echo "<tr>";
		echo "<td align='left' bgcolor='$bgcolor' width='80'><FONT FACE=\"ARIAL,HELVETICA\" COLOR='#000000' size='1'>$row[start_time]</th>";
		echo "<td align='left' bgcolor='$bgcolor' width='80'><FONT FACE=\"ARIAL,HELVETICA\" COLOR='#000000' size='1'>$row[status]</th>";
		echo "<td align='left' bgcolor='$bgcolor' width='100'><FONT FACE=\"ARIAL,HELVETICA\" COLOR='#000000' size='1'>$row[update_time]</th>";
		echo "<td align='left' bgcolor='$bgcolor' width='80'><FONT FACE=\"ARIAL,HELVETICA\" COLOR='#000000' size='1'>$row[leads_count]</th>";
		echo "<td align='left' bgcolor='$bgcolor' width='80'><FONT FACE=\"ARIAL,HELVETICA\" COLOR='#000000' size='1'>$row[filter_count]</th>";
		echo "<td align='left' bgcolor='$bgcolor' width='180'><FONT FACE=\"ARIAL,HELVETICA\" COLOR='#000000' size='1'>List: $row[list_id]\n<BR>$row[status_line]</th>";
		echo "<td align='left' bgcolor='$bgcolor' width='170'><FONT FACE=\"ARIAL,HELVETICA\" COLOR='#000000' size='1'>$row[script_output]</th>";
		echo "</tr>";
	}
	echo "</table>";
	echo $more_history_link;
} else { 
	echo $more_history_link;
}
?>
