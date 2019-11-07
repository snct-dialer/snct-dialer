<?php
# AST_stat_callback.php
#
# Copyright (C) 2018 Jörg Frings-Fürst <jff@flyingpenguim.de>
#               2018 flyingpenguin UG <info@flyingpenguin.de>
#
# LICENSE: AGPLv2
#
# Callback stats
#
# CHANGELOG:
# 2018-27-01 - Inital release
# 2018-02-01 - First Release
#            - Add download
# 2018-02-02 - Add fields from lead
#            - Add company to title
#            - Add Laufzeit
# 2018-02-20 - Add ListId, ListMName and List activ
# 2018-02-27 - Add Kundennummer from vendor_lead_code
#

#
# ToDo
# - Fortschrittsbalken
#

$copyr = "2018 flyingpenguin.de UG, Jörg Frings-Fürst (AGPLv2)";
$release = '20180227-2';

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


$report_name = 'Callback Stats';
$db_source = 'M';
$DB = 0;

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

$loadn = sys_getloadavg();
if ($loadn[0] > 2.0) {
#		header('HTTP/1.1 503 Too busy, try again later');
	echo "Serverauslastung (".$loadn[0].") zu hoch! Versuchen Sie es später noch einmal." . PHP_EOL;
	exit;
}


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

$stmt="SELECT allowed_campaigns,allowed_reports from vicidial_user_groups where user_group='$LOGuser_group';";
if ($DB) {echo "|$stmt|\n";}
$rslt=mysql_to_mysqli($stmt, $link);
$row=mysqli_fetch_row($rslt);
$LOGallowed_campaigns = $row[0];
$LOGallowed_reports =	$row[1];

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
#	$user_group_SQLand = "and user_group IN($user_group_SQL)";
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
	$title = AddCompany2Title($report_name);
	echo "<script language=\"JavaScript\" src=\"calendar_db.js\"></script>\n";
	echo "<link rel=\"stylesheet\" href=\"calendar.css\">\n";

	echo "<META HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=utf-8\">\n";
	#echo"<META URL=$PHP_SELF?RR=$RR&DB=$DB$groupQS&adastats=$adastats&SIPmonitorLINK=$SIPmonitorLINK&IAXmonitorLINK=$IAXmonitorLINK&usergroup=$usergroup&UGdisplay=$UGdisplay&UidORname=$UidORname&orderby=$orderby&SERVdisplay=$SERVdisplay&CALLSdisplay=$CALLSdisplay&PHONEdisplay=$PHONEdisplay&CUSTPHONEdisplay=$CUSTPHONEdisplay&with_inbound=$with_inbound&monitor_active=$monitor_active&monitor_phone=$monitor_phone&ALLINGROUPstats=$ALLINGROUPstats&DROPINGROUPstats=$DROPINGROUPstats&NOLEADSalert=$NOLEADSalert&CARRIERstats=$CARRIERstats&PRESETstats=$PRESETstats&AGENTtimeSTATS=$AGENTtimeSTATS&INGROUPcolorOVERRIDE=$INGROUPcolorOVERRIDE&droppedOFtotal=$droppedOFtotal\">\n";
	echo "<TITLE>$title</TITLE></HEAD><BODY BGCOLOR=WHITE marginheight=0 marginwidth=0 leftmargin=0 topmargin=0>\n";

		$short_header=1;

		require("admin_header.php");

	}


#
# Ab hier Auswertung
#

#
# function GetList
#
# Parameter:
# - LeadID
#
# Return:
# - mysqli row if found
# - false if not found
#
# Use:
#
# - $DB for additional Output
# - $link Mysqli link

	function GetList($ListId) {
		global $DB, $link;

		$statement = "SELECT * FROM vicidial_lists WHERE list_id = \"$ListId\";";
		if ($DB) print "$statement\n";
		$result = mysqli_query($link, $statement) or die ("Error : " . mysqli_error($link));
		$row = mysqli_fetch_array($result, MYSQLI_BOTH);

		return $row;

	}

#
# function GetLead
#
# Parameter:
# - LeadID
#
# Return:
# - mysqli row if found
# - false if not found
#
# Use:
#
# - $DB for additional Output
# - $link Mysqli link

function GetLead($LeadId) {
	global $DB, $link;

	$statement = "SELECT * FROM vicidial_list WHERE lead_id = \"$LeadId\";";
	if ($DB) print "$statement\n";
	$result = mysqli_query($link, $statement) or die ("Error : " . mysqli_error($link));
	$row = mysqli_fetch_array($result, MYSQLI_BOTH);

	return $row;

}

#
# move to sep. file
#

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


#
# Main loop
#

$stmt = "SELECT * FROM vicidial_callbacks WHERE status NOT IN (\"INACTIVE\") ORDER BY campaign_id, callback_time";
$rslt=mysql_to_mysqli($stmt, $link);
if ($DB) {
	echo "$stmt\n";
}
$cb_to_print = mysqli_num_rows($rslt);

echo "<h1>Callbacks Übersicht</h1>" . PHP_EOL;


if($cb_to_print < 1) {
	$AgentsPrint = "keine Daten!";
}
else {
	$AgentsPrint = "<TABLE border=\"0\">" . PHP_EOL;
	$AgentsPrint .= " <TR bgcolor=\"f6fba5\">" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Campaign</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">List</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">List activ</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Callback Time</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Status</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Agent</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Typ</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">LeadStatus</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Lead ID</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Kundennummer</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Name</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Telefon</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Calls</font></TH>" . PHP_EOL;
	$AgentsPrint .= "  <TH nowrap><font size=\"-1\">Comment</font></TH>" . PHP_EOL;
	$CSVPrint = "Kampagne|List|List activ|Callback Zeit|Status|Agent|Typ|Lead - Status|Lead ID|Kundennummer|Name|Telefon|Calls|Comment";
	$AgentsPrint .= " </TR>" . PHP_EOL;
	$CSVPrint .= PHP_EOL;

	$pos = 0;
	$farb = 0;
	$sBackCol1 = "ccff99";
	$sBackCol2 = "ccf5ff";
	while($pos < $cb_to_print) {

		$row=mysqli_fetch_row($rslt);
		if($farb == 0) {
			$farb = 1;
			$printFarbe = $sBackCol1;
		}
		else {
			$farb = 0;
			$printFarbe = $sBackCol2;

		}
		$Lrow = GetLead($row[1]);
		$Lirow = GetList($row[2]);

		$AgentsPrint .= " <TR bgcolor=$printFarbe>" . PHP_EOL;
		$AgentsPrint .= "  <TD nowrap>$row[3]</TD> " . PHP_EOL;
		$AgentsPrint .= "  <TD nowrap>$Lirow[0] / $Lirow[1] </TD> " . PHP_EOL;
		$AgentsPrint .= "  <TD nowrap>$Lirow[3] </TD> " . PHP_EOL;
		$AgentsPrint .= "  <TD nowrap>$row[6]</TD> " . PHP_EOL;
		$AgentsPrint .= "  <TD nowrap>$row[4]</TD> " . PHP_EOL;
		$AgentsPrint .= "  <TD nowrap>$row[8]</TD> " . PHP_EOL;
		$AgentsPrint .= "  <TD nowrap>$row[9]</TD> " . PHP_EOL;
		$AgentsPrint .= "  <TD nowrap>$row[12]</TD> " . PHP_EOL;
		$AgentsPrint .= "  <TD nowrap><a href=/vicidial/admin_modify_lead.php?lead_id=$row[1] target=\"_blank\" >$row[1]</a></TD> " . PHP_EOL;
		$AgentsPrint .= "  <TD nowrap>$Lrow[5]</TD> " . PHP_EOL;
		$AgentsPrint .= "  <TD nowrap>$Lrow[13] $Lrow[15]</TD> " . PHP_EOL;
		$AgentsPrint .= "  <TD nowrap>$Lrow[11]</TD> " . PHP_EOL;
		$AgentsPrint .= "  <TD nowrap>$Lrow[30]</TD> " . PHP_EOL;
		$AgentsPrint .= "  <TD nowrap>$Lrow[29]</TD> " . PHP_EOL;

		$CSVPrint .= $row[3] . "|" . $Lirow[0] . " / " .$Lirow[1] . "|" . $Lirow[3] . "|" . $row[6] . "|" . $row[4] . "|" . $row[8] . "|" . $row[9] . "|" . $row[12] . "|" . $row[1] ."|" . "|" . $Lrow[5] ."|" . $Lrow[13] . " " . $Lrow[15] . "|" . $Lrow[11] . "|" . $Lrow[30] . "|" . $Lrow[29];

		$AgentsPrint .= " </TR>" . PHP_EOL;
		$CSVPrint .= PHP_EOL;

		$pos++;

	}


	$AgentsPrint .= "</TABLE> </br>" . PHP_EOL;

}


echo $AgentsPrint;

echo "<br>";

$FileName = "Callback_Übersicht.csv";

$DLURL = $test_ip . "://" . $DLDir . $FileName;

$fh = fopen($doc_root . "/" . $DLDir . $FileName, "w+");
fwrite($fh, $CSVPrint);
fclose($fh);

echo "<a href=\"http://" . $test_ip . "/vicidial/download.php?file=" . $FileName . "\" target=\"_blank\">Download</a>";



$ENDtime = date("U");

$Laufzeit = formatSec($ENDtime - $STARTtime);

echo "</br></br></br></br></br>" .PHP_EOL;
echo "<font size=\"1\"> Laufzeit: $Laufzeit</font></br></br>" . PHP_EOL;
echo "<font size=\"1\"> Version: $release</font></br>" . PHP_EOL;
echo "<font size=\"1\"> Copyright: $copyr</font>" . PHP_EOL;

?>

</BODY></HTML>

