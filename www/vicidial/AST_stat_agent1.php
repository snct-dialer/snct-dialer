<?php 
# AST_stat_agent1.php
# 
# Copyright (©) 2016-2019 Jörg Frings-Fürst <open_source@jff.email>    
#               2016-2018 flyingpenguin UG <info@flyingpenguin.de>
#               2019      SNCT GmbH <info@snct-gmbh.de>
#
# LICENSE: AGPLv3
#
# Agent stats for snct GmbH
# based on Agent stats for MediCenter Mittelrhein
# 
# CHANGELOG:
# 2016-12-13 - Inital release   
# 2017-01-11 - First Release
# 2017-01-12 - Zusammenfassung Dispo & Dead, Add Group, change order, add calendar
# 2018-01-22 - Umstellung auf Liveberechnung und auf alle selectierbaren Stati
#            - Login_Time test auf doppeltes Logout
# 2018-01-24 - Neu Zeitraum & Download
# 2019-03-19 - Add Campaign Status
# 2019-05-18 - Add viewable Data only for allowed user_groups
#
#

$copyr = "2016-2019 SNCT GmbH, Jörg Frings-Fürst (AGPLv3)";
$release = '20190514-15';

header ("Content-type: text/html; charset=utf-8");


require("dbconnect_mysqli.php");
require("functions.php");

$PHP_AUTH_USER=$_SERVER['PHP_AUTH_USER'];
$PHP_AUTH_PW=$_SERVER['PHP_AUTH_PW'];
$PHP_SELF=$_SERVER['PHP_SELF'];
if (isset($_GET["server_ip"]))			{$server_ip=$_GET["server_ip"];}
	elseif (isset($_POST["server_ip"]))	{$server_ip=$_POST["server_ip"];}
if (isset($_GET["DateVon"]))			{$DateVon=$_GET["DateVon"];}
	elseif (isset($_POST["DateVon"]))	{$DateVon=$_POST["DateVon"];}
if (isset($_GET["DateBis"]))			{$DateBis=$_GET["DateBis"];}
	elseif (isset($_POST["DateBis"]))	{$DateBis=$_POST["DateBis"];}


$report_name = 'Mitarbeiter Agenten Stat';
$db_source = 'M';

$ArrStati = array();
$ArrStatiIdx = array();
$DLDir = "stats/";

#############################################
##### START SYSTEM_SETTINGS LOOKUP #####
$stmt = "SELECT use_non_latin,outbound_autodial_active,slave_db_server,reports_use_slave_db,enable_languages,language_method,agent_whisper_enabled,allow_chats,cache_carrier_stats_realtime FROM system_settings;";
$rslt=mysql_to_mysqli($stmt, $link);
if ($DB) {echo "$stmt\n";}
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
	$agent_whisper_enabled =		$row[6];
	$allow_chats =					$row[7];
	$cache_carrier_stats_realtime = $row[8];
	}
##### END SETTINGS LOOKUP #####
###########################################

if ( (strlen($slave_db_server)>5) and (preg_match("/$report_name/",$reports_use_slave_db)) )
	{
	mysqli_close($link);
	$use_slave_server=1;
	$db_source = 'S';
	require("dbconnect_mysqli.php");
	echo "<!-- Using slave server $slave_db_server $db_source -->\n";
	}

if (!isset($DB))			{$DB=0;}
if (!isset($RR))			{$RR=40;}
if (!isset($group))			{$group='ALL-ACTIVE';}
if (!isset($user_group_filter))		{$user_group_filter='';}
if (!isset($usergroup))		{$usergroup='';}
if (!isset($UGdisplay))		{$UGdisplay=0;}	# 0=no, 1=yes
if (!isset($UidORname))		{$UidORname=1;}	# 0=id, 1=name
if (!isset($orderby))		{$orderby='timeup';}
if (!isset($SERVdisplay))	{$SERVdisplay=0;}	# 0=no, 1=yes
if (!isset($CALLSdisplay))	{$CALLSdisplay=1;}	# 0=no, 1=yes
if (!isset($PHONEdisplay))	{$PHONEdisplay=0;}	# 0=no, 1=yes
if (!isset($CUSTPHONEdisplay))	{$CUSTPHONEdisplay=1;}	# 0=no, 1=yes
if (!isset($PAUSEcodes))	{$PAUSEcodes='N';}  # 0=no, 1=yes
if (!isset($with_inbound))	{$with_inbound='M';}

$ingroup_detail='';

if ( (strlen($group)>1) and (strlen($groups[0])<1) ) {$groups[0] = $group;  $RR=40;}
else {$group = $groups[0];}

$NOW_TIME = date("Y-m-d H:i:s");
$NOW_DAY = date("Y-m-d");
$NOW_HOUR = date("H:i:s");
$STARTtime = date("U");
$epochONEminuteAGO = ($STARTtime - 60);
$timeONEminuteAGO = date("Y-m-d H:i:s",$epochONEminuteAGO);
$epochFIVEminutesAGO = ($STARTtime - 300);
$timeFIVEminutesAGO = date("Y-m-d H:i:s",$epochFIVEminutesAGO);
$epochFIFTEENminutesAGO = ($STARTtime - 900);
$timeFIFTEENminutesAGO = date("Y-m-d H:i:s",$epochFIFTEENminutesAGO);
$epochONEhourAGO = ($STARTtime - 3600);
$timeONEhourAGO = date("Y-m-d H:i:s",$epochONEhourAGO);
$epochSIXhoursAGO = ($STARTtime - 21600);
$timeSIXhoursAGO = date("Y-m-d H:i:s",$epochSIXhoursAGO);
$epochTWENTYFOURhoursAGO = ($STARTtime - 86400);
$timeTWENTYFOURhoursAGO = date("Y-m-d H:i:s",$epochTWENTYFOURhoursAGO);




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

$stmt="SELECT selected_language from vicidial_users where user='$PHP_AUTH_USER';";
if ($DB) {echo "|$stmt|\n";}
$rslt=mysql_to_mysqli($stmt, $link);
$sl_ct = mysqli_num_rows($rslt);
if ($sl_ct > 0)
	{
	$row=mysqli_fetch_row($rslt);
	$VUselected_language =		$row[0];
	}

$auth=0;
$reports_auth=0;
$admin_auth=0;
$auth_message = user_authorization($PHP_AUTH_USER,$PHP_AUTH_PW,'REPORTS',0,0);
if ($auth_message == 'GOOD')
	{$auth=1;}

if ($auth > 0)
	{
	$stmt="SELECT count(*) from vicidial_users where user='$PHP_AUTH_USER' and user_level > 7 and view_reports='1';";
	if ($DB) {echo "|$stmt|\n";}
	$rslt=mysql_to_mysqli($stmt, $link);
	$row=mysqli_fetch_row($rslt);
	$admin_auth=$row[0];

	$stmt="SELECT count(*) from vicidial_users where user='$PHP_AUTH_USER' and user_level > 6 and view_reports='1';";
	if ($DB) {echo "|$stmt|\n";}
	$rslt=mysql_to_mysqli($stmt, $link);
	$row=mysqli_fetch_row($rslt);
	$reports_auth=$row[0];

	if ($reports_auth < 1)
		{
		$VDdisplayMESSAGE = _QXZ("You are not allowed to view reports");
		Header ("Content-type: text/html; charset=utf-8");
		echo "$VDdisplayMESSAGE: |$PHP_AUTH_USER|$auth_message|\n";
		exit;
		}
	if ( ($reports_auth > 0) and ($admin_auth < 1) )
		{
		$ADD=999999;
		$reports_only_user=1;
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
	Header("WWW-Authenticate: Basic realm=\"CONTACT-CENTER-ADMIN\"");
	Header("HTTP/1.0 401 Unauthorized");
	echo "$VDdisplayMESSAGE: |$PHP_AUTH_USER|$PHP_AUTH_PW|$auth_message|\n";
	exit;
	}

$test_ip = $_SERVER['SERVER_ADDR'];	
$doc_root = $_SERVER['DOCUMENT_ROOT'];

#if($test_ip != "172.16.2.13") {
#	$loadn = sys_getloadavg();
#	if ($loadn[0] > 2.0) {
#		header('HTTP/1.1 503 Too busy, try again later');
#		echo "Serverauslastung (".$loadn[0].") zu hoch! Versuchen Sie es später noch einmal." . PHP_EOL;
#		exit;
#	}
#	echo "<br>Bitte verwenden Sie für den Aufruf des $report_name nur den Server ViciDB2 (172.16.2.13)" . PHP_EOL;
#}

	
$stmt="SELECT user_id,user,pass,full_name,user_level,user_group,phone_login,phone_pass,delete_users,delete_user_groups,delete_lists,delete_campaigns,delete_ingroups,delete_remote_agents,load_leads,campaign_detail,ast_admin_access,ast_delete_phones,delete_scripts,modify_leads,hotkeys_active,change_agent_campaign,agent_choose_ingroups,closer_campaigns,scheduled_callbacks,agentonly_callbacks,agentcall_manual,vicidial_recording,vicidial_transfers,delete_filters,alter_agent_interface_options,closer_default_blended,delete_call_times,modify_call_times,modify_users,modify_campaigns,modify_lists,modify_scripts,modify_filters,modify_ingroups,modify_usergroups,modify_remoteagents,modify_servers,view_reports,vicidial_recording_override,alter_custdata_override,qc_enabled,qc_user_level,qc_pass,qc_finish,qc_commit,add_timeclock_log,modify_timeclock_log,delete_timeclock_log,alter_custphone_override,vdc_agent_api_access,modify_inbound_dids,delete_inbound_dids,active,alert_enabled,download_lists,agent_shift_enforcement_override,manager_shift_enforcement_override,shift_override_flag,export_reports,delete_from_dnc,email,user_code,territory,allow_alerts,callcard_admin,force_change_password,modify_shifts,modify_phones,modify_carriers,modify_labels,modify_statuses,modify_voicemail,modify_audiostore,modify_moh,modify_tts,modify_contacts,modify_same_user_level from vicidial_users where user='$PHP_AUTH_USER';";
$rslt=mysql_to_mysqli($stmt, $link);
$row=mysqli_fetch_row($rslt);
$LOGfull_name				=$row[3];
$LOGuser_level				=$row[4];
$LOGuser_group				=$row[5];
$LOGdelete_users			=$row[8];
$LOGdelete_user_groups		=$row[9];
$LOGdelete_lists			=$row[10];
$LOGdelete_campaigns		=$row[11];
$LOGdelete_ingroups			=$row[12];
$LOGdelete_remote_agents	=$row[13];
$LOGload_leads				=$row[14];
$LOGcampaign_detail			=$row[15];
$LOGast_admin_access		=$row[16];
$LOGast_delete_phones		=$row[17];
$LOGdelete_scripts			=$row[18];
$LOGdelete_filters			=$row[29];
$LOGalter_agent_interface	=$row[30];
$LOGdelete_call_times		=$row[32];
$LOGmodify_call_times		=$row[33];
$LOGmodify_users			=$row[34];
$LOGmodify_campaigns		=$row[35];
$LOGmodify_lists			=$row[36];
$LOGmodify_scripts			=$row[37];
$LOGmodify_filters			=$row[38];
$LOGmodify_ingroups			=$row[39];
$LOGmodify_usergroups		=$row[40];
$LOGmodify_remoteagents		=$row[41];
$LOGmodify_servers			=$row[42];
$LOGview_reports			=$row[43];
$LOGmodify_dids				=$row[56];
$LOGdelete_dids				=$row[57];
$LOGmanager_shift_enforcement_override=$row[61];
$LOGexport_reports			=$row[64];
$LOGdelete_from_dnc			=$row[65];
$LOGcallcard_admin			=$row[70];
$LOGforce_change_password	=$row[71];
$LOGmodify_shifts			=$row[72];
$LOGmodify_phones			=$row[73];
$LOGmodify_carriers			=$row[74];
$LOGmodify_labels			=$row[75];
$LOGmodify_statuses			=$row[76];
$LOGmodify_voicemail		=$row[77];
$LOGmodify_audiostore		=$row[78];
$LOGmodify_moh				=$row[79];
$LOGmodify_tts				=$row[80];
$LOGmodify_contacts			=$row[81];
$LOGmodify_same_user_level	=$row[82];

$stmt="SELECT allowed_campaigns,allowed_reports,admin_viewable_groups,admin_viewable_call_times from vicidial_user_groups where user_group='$LOGuser_group';";
$rslt=mysql_to_mysqli($stmt, $link);
$row=mysqli_fetch_row($rslt);
$LOGallowed_campaigns =			$row[0];
$LOGallowed_reports =			$row[1];
$LOGadmin_viewable_groups =		$row[2];
$LOGadmin_viewable_call_times =	$row[3];

$LOGadmin_viewable_groupsSQL='';
$valLOGadmin_viewable_groupsSQL='';
$vmLOGadmin_viewable_groupsSQL='';
if ( (!preg_match('/\-\-ALL\-\-/i',$LOGadmin_viewable_groups)) and (strlen($LOGadmin_viewable_groups) > 3) )
	{
	$rawLOGadmin_viewable_groupsSQL = preg_replace("/ -/",'',$LOGadmin_viewable_groups);
	$rawLOGadmin_viewable_groupsSQL = preg_replace("/ /","','",$rawLOGadmin_viewable_groupsSQL);
	$LOGadmin_viewable_groupsSQL = "and user_group IN('---ALL---','$rawLOGadmin_viewable_groupsSQL')";
	$whereLOGadmin_viewable_groupsSQL = "where user_group IN('---ALL---','$rawLOGadmin_viewable_groupsSQL')";
	$valLOGadmin_viewable_groupsSQL = "and val.user_group IN('---ALL---','$rawLOGadmin_viewable_groupsSQL')";
	$vmLOGadmin_viewable_groupsSQL = "and vm.user_group IN('---ALL---','$rawLOGadmin_viewable_groupsSQL')";
	}
else 
	{$admin_viewable_groupsALL=1;}

#  and (preg_match("/MONITOR|BARGE|HIJACK|WHISPER/",$monitor_active) ) )
if ( (!isset($monitor_phone)) or (strlen($monitor_phone)<1) )
	{
	$stmt="SELECT phone_login from vicidial_users where user='$PHP_AUTH_USER';";
	$rslt=mysql_to_mysqli($stmt, $link);
	if ($DB) {echo "$stmt\n";}
	$row=mysqli_fetch_row($rslt);
	$monitor_phone = $row[0];
	}

$stmt="SELECT realtime_block_user_info,user_group,admin_hide_lead_data,admin_hide_phone_data from vicidial_users where user='$PHP_AUTH_USER';";
if ($DB) {echo "|$stmt|\n";}
$rslt=mysql_to_mysqli($stmt, $link);
$row=mysqli_fetch_row($rslt);
$realtime_block_user_info = $row[0];
$LOGuser_group =			$row[1];
$LOGadmin_hide_lead_data =	$row[2];
$LOGadmin_hide_phone_data =	$row[3];

$stmt="SELECT allowed_campaigns,allowed_reports,admin_viewable_groups from vicidial_user_groups where user_group='$LOGuser_group';";
if ($DB) {echo "|$stmt|\n";}
$rslt=mysql_to_mysqli($stmt, $link);
$row=mysqli_fetch_row($rslt);
$LOGallowed_campaigns = $row[0];
$LOGallowed_reports =	$row[1];
$LOGallowed_ugroups = $row[2];

if ( (!preg_match("/$report_name/",$LOGallowed_reports)) and (!preg_match("/ALL REPORTS/",$LOGallowed_reports)) )
	{
    Header("WWW-Authenticate: Basic realm=\"CONTACT-CENTER-ADMIN\"");
    Header("HTTP/1.0 401 Unauthorized");
    echo _QXZ("You are not allowed to view this report").": |$PHP_AUTH_USER|$report_name|"._QXZ("$report_name")."|\n";
    exit;
	}

$LOGallowed_campaignsSQL='';
$whereLOGallowed_campaignsSQL='';
if ( (!preg_match("/ALL-/",$LOGallowed_campaigns)) )
	{
	$rawLOGallowed_campaignsSQL = preg_replace("/ -/",'',$LOGallowed_campaigns);
	$rawLOGallowed_campaignsSQL = preg_replace("/ /","','",$rawLOGallowed_campaignsSQL);
	$LOGallowed_campaignsSQL = "and campaign_id IN('$rawLOGallowed_campaignsSQL')";
	$whereLOGallowed_campaignsSQL = "where campaign_id IN('$rawLOGallowed_campaignsSQL')";
	}
$regexLOGallowed_campaigns = " $LOGallowed_campaigns ";

$allactivecampaigns='';
$stmt="SELECT campaign_id,campaign_name from vicidial_campaigns where active='Y' $LOGallowed_campaignsSQL order by campaign_id;";
$rslt=mysql_to_mysqli($stmt, $link);
if ($DB) {echo "$stmt\n";}
$groups_to_print = mysqli_num_rows($rslt);
$i=0;
$LISTgroups[$i]='ALL-ACTIVE';
$i++;
$groups_to_print++;
while ($i < $groups_to_print)
	{
	$row=mysqli_fetch_row($rslt);
	$LISTgroups[$i] =$row[0];
	$LISTnames[$i] =$row[1];
	$allactivecampaigns .= "'$LISTgroups[$i]',";
	$i++;
	}
$allactivecampaigns .= "''";

$i=0;
$group_string='|';
$group_ct = count($groups);
while($i < $group_ct)
	{
	$groups[$i] = preg_replace("/'|\"|\\\\|;/","",$groups[$i]);
	if ( (preg_match("/ $groups[$i] /",$regexLOGallowed_campaigns)) or (preg_match("/ALL-/",$LOGallowed_campaigns)) )
		{
		$group_string .= "$groups[$i]|";
		$group_SQL .= "'$groups[$i]',";
		$groupQS .= "&groups[]=$groups[$i]";
		}

	$i++;
	}
$group_SQL = preg_replace('/,$/i', '',$group_SQL);

$i=0;
$user_group_string='|';
$user_group_ct = count($user_group_filter);
while($i < $user_group_ct)
	{
	$user_group_filter[$i] = preg_replace("/'|\"|\\\\|;/","",$user_group_filter[$i]);
#	if ( (preg_match("/ $user_group_filter[$i] /",$regexLOGallowed_campaigns)) or (preg_match("/ALL-/",$LOGallowed_campaigns)) )
#		{
		$user_group_string .= "$user_group_filter[$i]|";
		$user_group_SQL .= "'$user_group_filter[$i]',";
		$usergroupQS .= "&user_group_filter[]=$user_group_filter[$i]";
#		}
	$i++;
	}
$user_group_SQL = preg_replace('/,$/i', '',$user_group_SQL);

### if no campaigns selected, display all
if ( ($group_ct < 1) or (strlen($group_string) < 2) )
	{
	$groups[0] = 'ALL-ACTIVE';
	$group_string = '|ALL-ACTIVE|';
	$group = 'ALL-ACTIVE';
	$groupQS .= "&groups[]=ALL-ACTIVE";
	}
### if no user groups selected, display all
if ( ($user_group_ct < 1) or (strlen($user_group_string) < 2) )
	{
	$user_group_filter[0] = 'ALL-GROUPS';
	$user_group_string = '|ALL-GROUPS|';
	$usergroupQS .= "&user_group_filter[]=ALL-GROUPS";
	}

if ( (preg_match('/\s\-\-NONE\-\-\s/',$group_string) ) or ($group_ct < 1) )
	{
	$all_active = 0;
	$group_SQL = "''";
	$group_SQLand = "and FALSE";
	$group_SQLwhere = "where FALSE";
	}
elseif ( preg_match('/ALL\-ACTIVE/i',$group_string) )
	{
	$all_active = 1;
	$group_SQL = $allactivecampaigns;
	$group_SQLand = "and campaign_id IN($allactivecampaigns)";
	$group_SQLwhere = "where campaign_id IN($allactivecampaigns)";
	}
else
	{
	$all_active = 0;
	$group_SQLand = "and campaign_id IN($group_SQL)";
	$group_SQLwhere = "where campaign_id IN($group_SQL)";
	}
### USER GROUP STUFF
if ( (preg_match('/\s\-\-NONE\-\-\s/',$user_group_string) ) or ($user_group_ct < 1) )
	{
	$all_active_groups = 0;
	$user_group_SQL = "''";
#	$user_group_SQLand = "and FALSE";
#	$user_group_SQLwhere = "where FALSE";
	}
elseif ( preg_match('/ALL\-GROUPS/i',$user_group_string) )
	{
	$all_active_groups = 1;
#	$user_group_SQL = '';
	$user_group_SQL = "'$rawLOGadmin_viewable_groupsSQL'";
#	$group_SQLand = "and campaign_id IN($allactivecampaigns)";
#	$group_SQLwhere = "where campaign_id IN($allactivecampaigns)";
	}
else
	{
	$all_active_groups = 0;
	$user_group_SQLand = "and user_group IN($user_group_SQL)";
#	$user_group_SQLwhere = "where user_group IN($user_group_SQL)";
	}



$stmt="SELECT user_group from vicidial_user_groups $whereLOGadmin_viewable_groupsSQL order by user_group;";
$rslt=mysql_to_mysqli($stmt, $link);
if (!isset($DB))   {$DB=0;}
if ($DB) {echo "$stmt\n";}
$usergroups_to_print = mysqli_num_rows($rslt);
$i=0;
$usergroups[$i]='ALL-GROUPS';
$usergroupnames[$i] = 'All user groups';
$i++;
$usergroups_to_print++;
while ($i < $usergroups_to_print)
	{
	$row=mysqli_fetch_row($rslt);
	$usergroups[$i] =$row[0];
	$i++;
	}

if (!isset($RR))   {$RR=4;}

$NFB = '<b><font size=6 face="courier">';
$NFE = '</font></b>';
$F=''; $FG=''; $B=''; $BG='';

$select_list = "<TABLE WIDTH=700 CELLPADDING=5 BGCOLOR=\"#D9E6FE\"><TR><TD VALIGN=TOP>"._QXZ("Select Campaigns").": <BR>";
$select_list .= "<SELECT SIZE=15 NAME=groups[] multiple>";
$o=0;
while ($groups_to_print > $o)
	{
	if (preg_match("/\|$LISTgroups[$o]\|/",$group_string)) 
		{$select_list .= "<option selected value=\"$LISTgroups[$o]\">$LISTgroups[$o] - $LISTnames[$o]</option>";}
	else
		{$select_list .= "<option value=\"$LISTgroups[$o]\">$LISTgroups[$o] - $LISTnames[$o]</option>";}
	$o++;
	}
$select_list .= "</SELECT>";
$select_list .= "<BR><font size=1>"._QXZ("(To select more than 1 campaign, hold down the Ctrl key and click)")."<font>";

$select_list .= "</TD><TD VALIGN=TOP ALIGN=CENTER>";
$select_list .= "<a href=\"#\" onclick=\"closeDiv(\'campaign_select_list\');\">"._QXZ("Close Panel")."</a><BR><BR>";
$select_list .= "<TABLE CELLPADDING=2 CELLSPACING=2 BORDER=0>";

$select_list .= "</TABLE><BR>";
$select_list .= "<INPUT type=hidden name=droppedOFtotal value=\"$droppedOFtotal\">";
$select_list .= "<INPUT type=submit NAME=SUBMIT VALUE=SUBMIT><FONT FACE=\"ARIAL,HELVETICA\" COLOR=BLACK SIZE=2> &nbsp; &nbsp; &nbsp; &nbsp; ";
$select_list .= "</TD></TR>";
$select_list .= "<TR><TD ALIGN=CENTER>";
$select_list .= "<font size=1> &nbsp; </font>";
$select_list .= "</TD>";
$select_list .= "<TD NOWRAP align=right>";
$select_list .= "<font size=1>"._QXZ("VERSION").": $version &nbsp; "._QXZ("BUILD").": $build</font>";
$select_list .= "</TD></TR></TABLE>";

$open_list = '<TABLE WIDTH=250 CELLPADDING=0 CELLSPACING=0 BGCOLOR=\'#D9E6FE\'><TR><TD ALIGN=CENTER><a href=\'#\' onclick=\\"openDiv(\'campaign_select_list\');\\"><font size=2>'._QXZ("Choose Report Display Options").'</a></TD></TR></TABLE>';

?>

<HTML>
<HEAD>

<?php 

if ($RTajax > 0)
	{
	echo "<!-- ajax-mode -->\n";
	}
else
	{
	?>
	<script language="Javascript">

	window.onload = startup;

	// function to detect the XY position on the page of the mouse
	function startup() 
		{
		hide_ingroup_info();
		if (window.Event) 
			{
			document.captureEvents(Event.MOUSEMOVE);
			}
		document.onmousemove = getCursorXY;
		}

	function getCursorXY(e) 
		{
		document.getElementById('cursorX').value = (window.Event) ? e.pageX : event.clientX + (document.documentElement.scrollLeft ? document.documentElement.scrollLeft : document.body.scrollLeft);
		document.getElementById('cursorY').value = (window.Event) ? e.pageY : event.clientY + (document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop);
		}

	var select_list = "<?php echo $select_list ?>";
	var open_list = "<?php echo $open_list ?>";
	var monitor_phone = '<?php echo $monitor_phone ?>';
	var user = '<?php echo $PHP_AUTH_USER ?>';
	var pass = '<?php echo $PHP_AUTH_PW ?>';

	// functions to hide and show different DIVs
	function openDiv(divvar) 
		{
		document.getElementById(divvar).innerHTML = select_list;
		document.getElementById(divvar).style.left = 0;
		}
	function closeDiv(divvar)
		{
		document.getElementById(divvar).innerHTML = open_list;
		document.getElementById(divvar).style.left = 160;
		}
	function closeAlert(divvar)
		{
		document.getElementById(divvar).innerHTML = '';
		}
	// function to launch monitoring calls

	// function to display in-groups selected for a specific agent
	function ingroup_info(agent_user,count)
		{
		var cursorheight = (document.REALTIMEform.cursorY.value - 0);
		var newheight = (cursorheight + 10);
		document.getElementById("agent_ingroup_display").style.top = newheight;
		//	alert(session_id + "|" + server_ip + "|" + monitor_phone + "|" + stage + "|" + user);
		var xmlhttp=false;
		/*@cc_on @*/
		/*@if (@_jscript_version >= 5)
		// JScript gives us Conditional compilation, we can cope with old IE versions.
		// and security blocked creation of the objects.
		 try {
		  xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
		 } catch (e) {
		  try {
		   xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		  } catch (E) {
		   xmlhttp = false;
		  }
		 }
		@end @*/
		if (!xmlhttp && typeof XMLHttpRequest!='undefined')
			{
			xmlhttp = new XMLHttpRequest();
			}
		if (xmlhttp) 
			{
			var monitorQuery = "source=realtime&function=agent_ingroup_info&stage=change&user=" + user + "&pass=" + pass + "&agent_user=" + agent_user;
			xmlhttp.open('POST', 'non_agent_api.php'); 
			xmlhttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded; charset=UTF-8');
			xmlhttp.send(monitorQuery); 
			xmlhttp.onreadystatechange = function() 
				{ 
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) 
					{
				//	alert(xmlhttp.responseText);
					var Xoutput = null;
					Xoutput = xmlhttp.responseText;
					var regXFerr = new RegExp("ERROR","g");
					if (Xoutput.match(regXFerr))
						{alert(xmlhttp.responseText);}
					else
						{
						document.getElementById("agent_ingroup_display").visibility = "visible";
						document.getElementById("agent_ingroup_display").innerHTML = Xoutput;
						}
					}
				}
			delete xmlhttp;
			}
		}

	// function to display in-groups selected for a specific agent
	function hide_ingroup_info()
		{
		document.getElementById("agent_ingroup_display").visibility = "hidden";
		document.getElementById("agent_ingroup_display").innerHTML = '';
		}



	</script>

	<STYLE type="text/css">
	<!--
		.green {color: white; background-color: green}
		.red {color: white; background-color: red}
		.lightblue {color: black; background-color: #ADD8E6}
		.blue {color: white; background-color: blue}
		.midnightblue {color: white; background-color: #191970}
		.purple {color: white; background-color: purple}
		.violet {color: black; background-color: #EE82EE} 
		.thistle {color: black; background-color: #D8BFD8} 
		.olive {color: white; background-color: #808000}
		.lime {color: white; background-color: #006600}
		.yellow {color: black; background-color: yellow}
		.khaki {color: black; background-color: #F0E68C}
		.orange {color: black; background-color: orange}
		.black {color: white; background-color: black}
		.salmon {color: white; background-color: #FA8072}

		.r1 {color: black; background-color: #FFCCCC}
		.r2 {color: black; background-color: #FF9999}
		.r3 {color: black; background-color: #FF6666}
		.r4 {color: white; background-color: #FF0000}
		.b1 {color: black; background-color: #CCCCFF}
		.b2 {color: black; background-color: #9999FF}
		.b3 {color: black; background-color: #6666FF}
		.b4 {color: white; background-color: #0000FF}
		.rd1 {color: black; background-color: #FF0000}
		.gr1 {color: black; background-color: #00FF00}
		.ge1 {color: black; background-color: #FFFF00}

		.Hfb1 {color: white; background-color: #015b91; font-family: HELVETICA; font-size: 18; font-weight: bold;}
		.Hfr1 {color: black; background-color: #FFCCCC; font-family: HELVETICA; font-size: 18; font-weight: bold;}
		.Hfr2 {color: black; background-color: #FF9999; font-family: HELVETICA; font-size: 18; font-weight: bold;}
		.Hfr3 {color: black; background-color: #FF6666; font-family: HELVETICA; font-size: 18; font-weight: bold;}
		.Hfr4 {color: white; background-color: #FF0000; font-family: HELVETICA; font-size: 18; font-weight: bold;}
		
		div.clear { clear: both; }
		   
  		table tr td {  
   			font-size:12px;  
   			font-family:Verdana, Arial, Helvetica, sans-serif;  
  		}  


	<?php
		$stmt="SELECT group_id,group_color from vicidial_inbound_groups;";
		$rslt=mysql_to_mysqli($stmt, $link);
		if ($DB) {echo "$stmt\n";}
		$INgroups_to_print = mysqli_num_rows($rslt);
			if ($INgroups_to_print > 0)
			{
			$g=0;
			while ($g < $INgroups_to_print)
				{
				$row=mysqli_fetch_row($rslt);
				$group_id[$g] = $row[0];
				$group_color[$g] = $row[1];
				echo "   .csc$group_id[$g] {color: black; background-color: $group_color[$g]}\n";
				$g++;
				}
			}

	echo "\n-->\n
	</STYLE>\n";

	echo "<script language=\"JavaScript\" src=\"calendar_db.js\"></script>\n";
	echo "<link rel=\"stylesheet\" href=\"calendar.css\">\n";
	
	echo "<META HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=utf-8\">\n";
	#echo"<META URL=$PHP_SELF?RR=$RR&DB=$DB$groupQS&adastats=$adastats&SIPmonitorLINK=$SIPmonitorLINK&IAXmonitorLINK=$IAXmonitorLINK&usergroup=$usergroup&UGdisplay=$UGdisplay&UidORname=$UidORname&orderby=$orderby&SERVdisplay=$SERVdisplay&CALLSdisplay=$CALLSdisplay&PHONEdisplay=$PHONEdisplay&CUSTPHONEdisplay=$CUSTPHONEdisplay&with_inbound=$with_inbound&monitor_active=$monitor_active&monitor_phone=$monitor_phone&ALLINGROUPstats=$ALLINGROUPstats&DROPINGROUPstats=$DROPINGROUPstats&NOLEADSalert=$NOLEADSalert&CARRIERstats=$CARRIERstats&PRESETstats=$PRESETstats&AGENTtimeSTATS=$AGENTtimeSTATS&INGROUPcolorOVERRIDE=$INGROUPcolorOVERRIDE&droppedOFtotal=$droppedOFtotal\">\n";
	echo "<TITLE>$report_name: $group</TITLE></HEAD><BODY BGCOLOR=WHITE marginheight=0 marginwidth=0 leftmargin=0 topmargin=0>\n";

		$short_header=1;

		require("admin_header.php");

	}

function GetLoginTime($agent, $datum_von, $datum_bis) {
    global $DB, $link;
	    
	$start_date = $datum_von . " 00:00:00";
	$end_date   = $datum_bis . " 23:59:59";
	   
	$ep_start = 0;
	$eo_end   = 0;
	$ep_sum   = 0;
	    
	$statement = "SELECT * FROM vicidial_user_log  WHERE user = $agent AND event_date >= \"$start_date\" AND event_date <= \"$end_date\";";
	if ($DB) print "$statement\n";
	$result = mysqli_query($link, $statement) or die ("Error : " . mysqli_error($link));
	while ($row = mysqli_fetch_array($result, MYSQLI_BOTH)) {
	   if($row["event"] == "LOGIN") {
	       $ep_start = $row["event_epoch"];
	   }
	   if(($row["event"] == "LOGOUT") && ($ep_start > 0)){
	       $ep_end = $row["event_epoch"];
	            
	   }
	   if(($ep_start > 0) && ($ep_end > 0)) {
	       $ep_sum = $ep_sum + ($ep_end - $ep_start);
	       $ep_end = 0;
	       $ep_start = 0;
	   }
    }
	if(($ep_start > 0) && ($ep_end == 0)) {
	   $ep_end = time();
	   $ep_sum = $ep_sum + ($ep_end - $ep_start);
    }
	return $ep_sum;
}

function GetLoginDays($agent, $datum_von, $datum_bis) {
    global $DB, $link;
    
    $start_date = $datum_von . " 00:00:00";
    $end_date   = $datum_bis . " 23:59:59";
        
    $statement = "SELECT * FROM vicidial_user_log  WHERE user = $agent AND event_date >= \"$start_date\" AND event_date <= \"$end_date\" GROUP by DATE(event_date);";
    if ($DB)  print "$statement\n";
    $result = mysqli_query($link, $statement) or die ("Error : " . mysqli_error($link));
    $days = mysqli_num_rows($result);
    return $days;
}

function GetTrueSales($agent, $datum_von, $datum_bis) {
    global $DB, $link;
    
    $start_date = $datum_von . " 00:00:00";
    $end_date   = $datum_bis . " 23:59:59";
    
    $statement = "SELECT * FROM order_transaction  WHERE user_ID = $agent AND transaction_type = 'order' AND transaction_date >= \"$start_date\" AND transaction_date <= \"$end_date\" GROUP BY lead_ID;";
    if ($DB)  print "$statement\n";
    $result = mysqli_query($link, $statement) or die ("Error : " . mysqli_error($link));
    $Sales = mysqli_num_rows($result);
    return $Sales;
}
	
	
function GetAnz($agent, $datum_von, $datum_bis, $type) {
    global $DB, $link;
	    
	$start_date = $datum_von . " 00:00:00";
	$end_date   = $datum_bis . " 23:59:59";
	if($type == "Pause") $field = "pause_sec";
	if($type == "Wait") $field = "wait_sec";
	if($type == "Dispo") $field = "dispo_sec";
	if($type == "Dead") $field = "dead_sec";
	if($type == "Talk") $field = "talk_sec";
	    
	$statement = "SELECT COUNT($field) FROM vicidial_agent_log  WHERE user = $agent AND $field > 0 AND event_time >= \"$start_date\" AND event_time <= \"$end_date\";";
	if ($DB) print "$statement\n";
	$result = mysqli_query($link, $statement) or die ("Error : " . mysqli_error($link));
	$row = mysqli_fetch_array($result, MYSQLI_BOTH);
	    
	return $row;
}

function GetSum($agent, $datum_von, $datum_bis, $type) {
    global $DB, $link;
    
    $start_date = $datum_von . " 00:00:00";
    $end_date   = $datum_bis . " 23:59:59";
    if($type == "Pause") $field = "pause_sec";
    if($type == "Wait") $field = "wait_sec";
    if($type == "Dispo") $field = "dispo_sec";
    if($type == "Dead") $field = "dead_sec";
    if($type == "Talk") $field = "talk_sec";
    
    $statement = "SELECT SUM($field) FROM vicidial_agent_log  WHERE user = $agent AND event_time >= \"$start_date\" AND event_time <= \"$end_date\";";
    if ($DB) print "$statement\n";
    $result = mysqli_query($link, $statement) or die ("Error : " . mysqli_error($link));
    $row = mysqli_fetch_array($result, MYSQLI_BOTH);
    
    return $row;
}

function GetPauseSum($agent, $datum_von, $datum_bis, $type) {
    global $DB, $link;
    
    $start_date = $datum_von . " 00:00:00";
    $end_date   = $datum_bis . " 23:59:59";
    $field = "pause_sec";
    
    $statement = "SELECT SUM($field) FROM vicidial_agent_log  WHERE user = $agent AND event_time >= \"$start_date\" AND event_time <= \"$end_date\" AND pause_code = '$type';";
    if ($DB) print "$statement\n";
    $result = mysqli_query($link, $statement) or die ("Error : " . mysqli_error($link));
    $row = mysqli_fetch_array($result, MYSQLI_BOTH);
    
    return $row;
}

function GetAnzStati($agent, $datum_von, $datum_bis, $stati) {
    global $DB, $link;
    
    $start_date = $datum_von . " 00:00:00";
    $end_date   = $datum_bis . " 23:59:59";
    
    $statement = "SELECT COUNT(status) FROM vicidial_agent_log  WHERE user = $agent AND status = \"$stati\" AND event_time >= \"$start_date\" AND event_time <= \"$end_date\";";
    if ($DB) print "$statement\n";
    $result = mysqli_query($link, $statement) or die ("Error : " . mysqli_error($link));
    $row = mysqli_fetch_array($result, MYSQLI_BOTH);
    
    return $row;
}

	
function GetFinalStati() {
    global $ArrStati, $ArrStatiIdx, $link;
    
    $pos  = 0;
    $stmt = "SELECT * FROM `vicidial_statuses` WHERE `selectable` = 'Y' AND `status` LIKE 'SALE';";
    $rslt=mysql_to_mysqli($stmt, $link);
    if ($DB) {echo "$stmt\n";}
    $Num = mysqli_num_rows($rslt);
    if ($Num > 0) {
        while($row = mysqli_fetch_assoc($rslt)){
            $name = $row["status_name"];
            $ArrStati[$pos] = $name;
            $ArrStatiIdx[$pos] = $row["status"];
            $pos++;
        }
         
        
    }
 #  print_r($ArrStatiIdx);
 #   $stmt = "SELECT * FROM `vicidial_campaign_statuses` WHERE `selectable` = 'Y';";
 #   $rslt=mysql_to_mysqli($stmt, $link);
 #   if ($DB) {echo "$stmt\n";}
 #   $Num = mysqli_num_rows($rslt);
 #   if ($Num > 0) {
 #   	while($row = mysqli_fetch_assoc($rslt)){
 #   		if(! in_array($row["status_name"], $ArrStati)) {
 #   			$name = $row["status_name"];
 #   			$ArrStati[$pos] = $name;
 #   			$ArrStatiIdx[$pos] = $row["status"];
 #   			$pos++;
 #   		}
 #   	}
 #   }
}    
	
function makeDownload($file, $dir, $type) {
    
    header("Content-Type: $type");
    
    header("Content-Disposition: attachment; filename=\"$file\"");
    
    readfile($dir.$file);
    
} 

function formatSec($sekunden) {

	$stunden = floor($sekunden / 3600);
	$minuten = floor(($sekunden - ($stunden * 3600)) / 60);
	$sekunden = round($sekunden - ($stunden * 3600) - ($minuten * 60), 0);
	
	if ($stunden <= 9) {
		$strStunden = "0" . $stunden;
	} else {
		$strStunden = $stunden;
	}
	
	if ($minuten <= 9) {
		$strMinuten = "0" . $minuten;
	} else {
		$strMinuten = $minuten;
	}
	
	if ($sekunden <= 9) {
		$strSekunden = "0" . $sekunden;
	} else {
		$strSekunden = $sekunden;
	}
	
	return "$strStunden:$strMinuten:$strSekunden";
}
	
if ($DateVon == "") {
	$DateVon = date("Y-m-d", time()-86400);	
}

if ($DateBis == "") {
    $DateBis = date("Y-m-d", time()-86400);
}


GetFinalStati();

$admin_allowed_ugroupsSQL='';
if  (!preg_match('/\-\-ALL\-\-/i',$LOGallowed_ugroups))
{
    $rawLOGallowed_ugroupsSQL = preg_replace("/ -/",'',$LOGallowed_ugroups);
    $rawLOGallowed_ugroupsSQL = preg_replace("/ /","','",$rawLOGallowed_ugroupsSQL);
    $admin_allowed_ugroupsSQL = "user_group IN('$rawLOGallowed_ugroupsSQL')";
}
else
{
    $rights_stmt = "SELECT user_group FROM vicidial_user_groups;";
    if ($DB) {echo "$rights_stmt|";}
    $rights_rslt=mysql_to_mysqli($rights_stmt, $link);
    $rights_rsltCOUNT = mysqli_num_rows($rights_rslt);
    $admin_allowed_ugroupsSQL = "user_group IN('---ALL---',";
    $i=0;
    while ($i < $rights_rsltCOUNT)
    {
        $rights_row=mysqli_fetch_row($rights_rslt);
        $admin_allowed_ugroupsSQL.= "'" . $rights_row[0] . "',";
        $i++;
    }
    $admin_allowed_ugroupsSQL .= "'')";
}


$stmt = "SELECT user,full_name,user_group, custom_three FROM vicidial_users WHERE user_level <= 9 AND custom_three != '' and " . $admin_allowed_ugroupsSQL . " ORDER BY user_group, custom_three, full_name";
$rslt=mysql_to_mysqli($stmt, $link);
if ($DB) {
	echo "$stmt\n";
}
$agents_to_print = mysqli_num_rows($rslt);

echo "<h1>Mitarbeiter Tagesübersicht</h1>" . PHP_EOL;
echo "<form name=Datum id=Datum>" .PHP_EOL;
echo " <label for=\"DateVon\">Datum (JJJJ-MM-TT)</label>" . PHP_EOL; 
echo " <input type=\"date\" name=\"DateVon\" id=\"DateVon\" value=\"$DateVon\" size=\"10\">" . PHP_EOL;

?>

<script language="JavaScript">
function openNewWindow(url)
{
	window.open (url,"",'width=620,height=300,scrollbars=yes,menubar=yes,address=yes');
}

var o_cal = new tcal ({
	// form name
	'formname': 'Datum',
	// input name
	'controlname': 'DateVon'
});
o_cal.a_tpl.yearscroll = false;
o_cal.a_tpl.weekstart = 1; // Monday week start
</script>

<?php

echo " <label for=\"DateBis\">Datum (JJJJ-MM-TT)</label>" . PHP_EOL;
echo " <input type=\"date\" name=\"DateBis\" id=\"DateBis\" value=\"$DateBis\" size=\"10\">" . PHP_EOL;


?>

<script language="JavaScript">
function openNewWindow(url)
{
	window.open (url,"",'width=620,height=300,scrollbars=yes,menubar=yes,address=yes');
}

var o_cal = new tcal ({
	// form name
	'formname': 'Datum',
	// input name
	'controlname': 'DateBis'
});
o_cal.a_tpl.yearscroll = false;
o_cal.a_tpl.weekstart = 1; // Monday week start
</script>

<?php

echo " <button type=\"submit\">Absenden</button>" . PHP_EOL;
echo "</form>" . PHP_EOL;

if($agents_to_print < 1) {
	$AgentsPrint = "keine Daten!";
}
else {	
	$AgentsPrint = "<TABLE border=\"0\">" . PHP_EOL;
	$AgentsPrint .= " <TR bgcolor=\"f6fba5\">" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Gruppe</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Name</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Datum von </font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Datum bis </font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Tage </font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Arbeitszeit </font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Dispo max</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Dispo ist</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Dispo Diff</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Dead max</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Dead ist</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Dead Diff</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Sales Status</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Sales ist</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Sales Zeit Vorgabe</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Sales Zeit ist</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Sales Diff</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Raucherpause</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">WC-Pause</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Abzüge Sek.</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Abzüge Min.</font></TH>" . PHP_EOL;
	$CSVPrint = "Gruppe|Name|Datum von|Datum bis|Anrufe|Loginzeit|Pause|Pause ᴓ|Pause %|Wartezeit|Wartezeit ᴓ|Dispo|Dispo ᴓ|Anrufdauer|Anrufdauer ᴓ";
	$AgentsPrint .= " </TR>" . PHP_EOL;
	$CSVPrint .= PHP_EOL;

	$pos = 0;	
	$farb = 0;
	$sBackCol1 = "ccff99";
	$sBackCol2 = "ccf5ff";
	while($pos < $agents_to_print) {
		
		$row=mysqli_fetch_row($rslt);

		$Talk_Anz = GetAnz($row[0], $DateVon, $DateBis, "Talk");
				
#		$printFarbe =
		if($Talk_Anz[0] >0 ) {
		    if($farb == 0) {
		        $farb = 1;
		        $printFarbe = $sBackCol1;
		    }
		    else {
		        $farb = 0;
		        $printFarbe = $sBackCol2;
		        
		    }
		$AgentsPrint .= " <TR bgcolor=$printFarbe>" . PHP_EOL;	
		$AgentsPrint .= "  <TD nowrap>$row[2]</TD> " . PHP_EOL;
		$AgentsPrint .= "  <TD nowrap>$row[1]</TD> " . PHP_EOL;
		$AgentsPrint .= "  <TD nowrap>$DateVon</TD> " . PHP_EOL;
		$AgentsPrint .= "  <TD nowrap>$DateBis</TD> " . PHP_EOL;
		$LoginDays = GetLoginDays($row[0], $DateVon, $DateBis);
		$AgentsPrint .= "  <TD nowrap>$LoginDays</TD> " . PHP_EOL;
		$DispoMax = $row[3] * 230 * $LoginDays;
		$AgentsPrint .= "  <TD nowrap>$row[3]</TD> " . PHP_EOL;
		$AgentsPrint .= "  <TD nowrap>$DispoMax</TD> " . PHP_EOL;
		$Dispo_ges = GetSum($row[0], $DateVon, $DateBis, "Dispo");
		$AgentsPrint .= "  <TD nowrap>$Dispo_ges[0]</TD> " . PHP_EOL;
		$DispoDiff = "";
		if($DispoMax < $Dispo_ges[0]) {
		    $DispoDiff = $DispoMax - $Dispo_ges[0];
		}
		$AgentsPrint .= "  <TD nowrap>$DispoDiff</TD> " . PHP_EOL;
				
		$DeadMax = $row[3] * 240 * $LoginDays;
		$AgentsPrint .= "  <TD nowrap>$DeadMax</TD> " . PHP_EOL;
		
		$Dead_ges = GetSum($row[0], $DateVon, $DateBis, "Dead");
		$AgentsPrint .= "  <TD nowrap>$Dead_ges[0]</TD> " . PHP_EOL;
		$DeadDiff = "";
		if($DeadMax < $Dead_ges[0]) {
		    $DeadDiff = $DeadMax - $Dead_ges[0];
		}
		$AgentsPrint .= "  <TD nowrap>$DeadDiff</TD> " . PHP_EOL;
		
		$SalesStatus = GetAnzStati($row[0], $DateVon, $DateBis, "SALE");
		$SalesStatusRS = GetAnzStati($row[0], $DateVon, $DateBis, "SALERS");
		$AgentsPrint .= "  <TD nowrap>$SalesStatus[0] + $SalesStatusRS[0]</TD> " . PHP_EOL;
		$Sales_ist = $SalesStatus[0] + $SalesStatusRS[0];
		$Sales_ist = GetTrueSales($row[0], $DateVon, $DateBis);
		$AgentsPrint .= "  <TD nowrap>$Sales_ist</TD> " . PHP_EOL;
		$SalesVorgabe = 78 * $Sales_ist;
		$AgentsPrint .= "  <TD nowrap>$SalesVorgabe</TD> " . PHP_EOL;
		$Sales_ges = GetPauseSum($row[0], $DateVon, $DateBis, "SALE");
		$AgentsPrint .= "  <TD nowrap>$Sales_ges[0]</TD> " . PHP_EOL;
		$SalesDiff = "";
		if($SalesVorgabe < $Sales_ges[0]) {
		    $SalesDiff = $SalesVorgabe - $Sales_ges[0];
		}
		$AgentsPrint .= "  <TD nowrap>$SalesDiff</TD> " . PHP_EOL;
		
		
		$Rauch_ges = GetPauseSum($row[0], $DateVon, $DateBis, "RAUCH");
		$AgentsPrint .= "  <TD nowrap>-$Rauch_ges[0]</TD> " . PHP_EOL;
		
		
		$WC_ges = GetPauseSum($row[0], $DateVon, $DateBis, "WC");
		$AgentsPrint .= "  <TD nowrap>-$WC_ges[0]</TD> " . PHP_EOL;
		
		$Abzug_Gesamt = $DispoDiff + $DeadDiff + $SalesDiff + (-1 * $Rauch_ges[0]);
		$AgentsPrint .= "  <TD nowrap>$Abzug_Gesamt</TD> " . PHP_EOL;
		$str = formatSec(abs($Abzug_Gesamt));
		$AgentsPrint .= "  <TD nowrap>-$str</TD> " . PHP_EOL;
		$AgentsPrint .= " </TR>" . PHP_EOL;
		$CSVPrint .= PHP_EOL;
        }
		$pos++;

	}


	$AgentsPrint .= "</TABLE> </br>" . PHP_EOL;

}


echo $AgentsPrint;

echo "<br>";

$FileName = "Mitarbeiter_Übersicht_" . $DateVon . "_" . $DateBis . ".csv";

$DLURL = $test_ip . "://" . $DLDir . $FileName;

$fh = fopen($doc_root . "/" . $DLDir . $FileName, "w+");
fwrite($fh, $CSVPrint);
fclose($fh);

echo "<a href=\"http://" . $test_ip . "/download.php?file=" . $FileName . "\">Download</a>";


echo "</br></br></br></br></br>" .PHP_EOL;
echo "<font size=\"1\"> Version: $release</font></br>" . PHP_EOL;
echo "<font size=\"1\"> Copyright: $copyr</font>" . PHP_EOL;

?>

</BODY></HTML>
