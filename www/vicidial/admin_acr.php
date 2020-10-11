<?php
# admin_acr.php
#
# LICENSE: AGPLv3
#
# Copyright (©) 2020      SNCT GmbH <info@snct-gmbh.de>
#               2020      Jörg Frings-Fürst <open_source@jff.email>
#
# This module manage global After Call Routing
#
# changes:
# 2020-06-01 jff First Build
#

$admin_version = '3.0.1';
$acr_build = '20200601-1';

$sh="AfterCallRouting";

require("dbconnect_mysqli.php");
require("functions.php");

$PHP_AUTH_USER=$_SERVER['PHP_AUTH_USER'];
$PHP_AUTH_PW=$_SERVER['PHP_AUTH_PW'];
$PHP_SELF=$_SERVER['PHP_SELF'];

if (isset($_GET["DB"]))							{$DB=$_GET["DB"];}
	elseif (isset($_POST["DB"]))				{$DB=$_POST["DB"];}
if (isset($_GET["action"]))						{$action=$_GET["action"];}
	elseif (isset($_POST["action"]))			{$action=$_POST["action"];}
if (isset($_GET["SUBMIT"]))						{$SUBMIT=$_GET["SUBMIT"];}
	elseif (isset($_POST["SUBMIT"]))			{$SUBMIT=$_POST["SUBMIT"];}
if (isset($_GET["stage"]))						{$stage=$_GET["stage"];}
	elseif (isset($_POST["stage"]))				{$stage=$_POST["stage"];}
if (isset($_GET["eact"]))						{$eact=$_GET["eact"];}
	elseif (isset($_POST["eact"]))				{$eact=$_POST["eact"];}
if (isset($_GET["confirm_deletion"]))			{$confirm_deletion=$_GET["confirm_deletion"];}
	elseif (isset($_POST["confirm_deletion"]))	{$confirm_deletion=$_POST["confirm_deletion"];}


if (isset($_GET["acr_name"]))						{$acr_name=$_GET["acr_name"];}
	elseif (isset($_POST["acr_name"]))				{$acr_name=$_POST["acr_name"];}
if (isset($_GET["acr_beschreibung"]))				{$acr_beschreibung=$_GET["acr_beschreibung"];}
	elseif (isset($_POST["acr_beschreibung"]))		{$acr_beschreibung=$_POST["acr_beschreibung"];}
if (isset($_GET["acr_active"]))						{$acr_active=$_GET["acr_active"];}
	elseif (isset($_POST["acr_active"]))			{$acr_active=$_POST["acr_active"];}
if (isset($_GET["acr_survey_callmenu"]))			{$acr_survey_callmenu=$_GET["acr_survey_callmenu"];}
	elseif (isset($_POST["acr_survey_callmenu"]))	{$acr_survey_callmenu=$_POST["acr_survey_callmenu"];}
if (isset($_GET["acr_survey_question_filename"]))			{$acr_survey_question_filename=$_GET["acr_survey_question_filename"];}
	elseif (isset($_POST["acr_survey_question_filename"]))	{$acr_survey_question_filename=$_POST["acr_survey_question_filename"];}
if (isset($_GET["acr_type"]))						{$acr_type=$_GET["acr_type"];}
	elseif (isset($_POST["acr_type"]))				{$acr_type=$_POST["acr_type"];}
if (isset($_GET["acr_id"]))							{$acr_id=$_GET["acr_id"];}
	elseif (isset($_POST["acr_id"]))				{$acr_id=$_POST["acr_id"];}

require_once("../tools/system_wide_settings.php");

$localePreferences = explode(",",$_SERVER['HTTP_ACCEPT_LANGUAGE']);
if(is_array($localePreferences) && count($localePreferences) > 0) {
	$browserLocale = $localePreferences[0];
	if(($browserLocale ==  "de") || ($browserLocale ==  "de-DE") || ($browserLocale ==  "de-de")) {
		$browserLocale = "de_DE.UTF-8";
	}
	$_SESSION['browser_locale'] = $browserLocale;
}


if (!function_exists("gettext")){ echo "gettext is not installed\n"; }


#echo $browserLocale ."<br>";

putenv("LANG=$browserLocale");
setlocale(LC_ALL, $browserLocale);
bindtextdomain('snctdialer', './locale');
bind_textdomain_codeset('snctdialer', 'UTF-8');
textdomain('snctdialer');

#
# Init acr Type
#

#print_r($_GET);
#print_r($_POST);

$ACRTypeArr = ["Survey", "Test"];


#############################################
##### START SYSTEM_SETTINGS LOOKUP #####
$stmt = "SELECT use_non_latin,enable_queuemetrics_logging,enable_vtiger_integration,qc_features_active,outbound_autodial_active,sounds_central_control_active,enable_second_webform,user_territories_active,custom_fields_enabled,admin_web_directory,webphone_url,first_login_trigger,hosted_settings,default_phone_registration_password,default_phone_login_password,default_server_password,test_campaign_calls,active_voicemail_server,voicemail_timezones,default_voicemail_timezone,default_local_gmt,campaign_cid_areacodes_enabled,pllb_grouping_limit,did_ra_extensions_enabled,expanded_list_stats,contacts_enabled,alt_log_server_ip,alt_log_dbname,alt_log_login,alt_log_pass,tables_use_alt_log_db,allow_emails,allow_emails,level_8_disable_add,enable_languages,language_method,active_modules FROM system_settings;";
$rslt=mysql_to_mysqli($stmt, $link);
if ($DB) {echo "$stmt\n";}
$qm_conf_ct = mysqli_num_rows($rslt);
if ($qm_conf_ct > 0)
	{
	$row=mysqli_fetch_row($rslt);
	$non_latin =							$row[0];
	$SSenable_queuemetrics_logging =		$row[1];
	$SSenable_vtiger_integration =			$row[2];
	$SSqc_features_active =					$row[3];
	$SSoutbound_autodial_active =			$row[4];
	$SSsounds_central_control_active =		$row[5];
	$SSenable_second_webform =				$row[6];
	$SSuser_territories_active =			$row[7];
	$SScustom_fields_enabled =				$row[8];
	$SSadmin_web_directory =				$row[9];
	$SSwebphone_url =						$row[10];
	$SSfirst_login_trigger =				$row[11];
	$SShosted_settings =					$row[12];
	$SSdefault_phone_registration_password =$row[13];
	$SSdefault_phone_login_password =		$row[14];
	$SSdefault_server_password =			$row[15];
	$SStest_campaign_calls =				$row[16];
	$SSactive_voicemail_server =			$row[17];
	$SSvoicemail_timezones =				$row[18];
	$SSdefault_voicemail_timezone =			$row[19];
	$SSdefault_local_gmt =					$row[20];
	$SScampaign_cid_areacodes_enabled =		$row[21];
	$SSpllb_grouping_limit =				$row[22];
	$SSdid_ra_extensions_enabled =			$row[23];
	$SSexpanded_list_stats =				$row[24];
	$SScontacts_enabled =					$row[25];
	$SSalt_log_server_ip =					$row[26];
	$SSalt_log_dbname =						$row[27];
	$SSalt_log_login =						$row[28];
	$SSalt_log_pass =						$row[29];
	$SStables_use_alt_log_db =				$row[30];
	$SSallow_emails =						$row[31];
	$SSemail_enabled =						$row[32];
	$SSlevel_8_disable_add =				$row[33];
	$SSenable_languages =					$row[34];
	$SSlanguage_method =					$row[35];
	$SSactive_modules =						$row[36];
	}
##### END SETTINGS LOOKUP #####
###########################################


$PHP_AUTH_USER = preg_replace("/'|\"|\\\\|;/","",$PHP_AUTH_USER);
$PHP_AUTH_PW = preg_replace("/'|\"|\\\\|;/","",$PHP_AUTH_PW);


$STARTtime = date("U");
$TODAY = date("Y-m-d");
$NOW_TIME = date("Y-m-d H:i:s");
$date = date("r");
$ip = getenv("REMOTE_ADDR");
$browser = getenv("HTTP_USER_AGENT");
$user = $PHP_AUTH_USER;
$add_copy_disabled=0;

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
$auth_message = user_authorization($PHP_AUTH_USER,$PHP_AUTH_PW,'',1,0);
if ($auth_message == 'GOOD')
	{$auth=1;}

if ($auth < 1)
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

$stmt="SELECT full_name,user_level,user_group,modify_email_accounts,qc_enabled from vicidial_users where user='$PHP_AUTH_USER';";
$rslt=mysql_to_mysqli($stmt, $link);
$row=mysqli_fetch_row($rslt);
$LOGfullname =				$row[0];
$LOGuser_level =			$row[1];
$LOGuser_group =			$row[2];
$LOGemails_modify =			$row[3];
$qc_auth =					$row[4];

if ($LOGuser_level < 9)
	{
	Header ("Content-type: text/html; charset=utf-8");
	echo _("You do not have permissions to modify after call routing")."\n";
	exit;
	}

$stmt="SELECT allowed_campaigns,allowed_reports,admin_viewable_groups,admin_viewable_call_times from vicidial_user_groups where user_group='$LOGuser_group';";
$rslt=mysql_to_mysqli($stmt, $link);
$row=mysqli_fetch_row($rslt);
$LOGallowed_campaigns =			$row[0];
$LOGallowed_reports =			$row[1];
$LOGadmin_viewable_groups =		$row[2];
$LOGadmin_viewable_call_times =	$row[3];
$admin_viewable_groupsALL=0;
$LOGadmin_viewable_groupsSQL='';
$whereLOGadmin_viewable_groupsSQL='';
$valLOGadmin_viewable_groupsSQL='';
$vmLOGadmin_viewable_groupsSQL='';
if ( (!preg_match("/\-\-ALL\-\-/i",$LOGadmin_viewable_groups)) and (strlen($LOGadmin_viewable_groups) > 3) )
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
$regexLOGadmin_viewable_groups = " $LOGadmin_viewable_groups ";

$UUgroups_list='';
if ($admin_viewable_groupsALL > 0)
	{$UUgroups_list .= "<option value=\"---ALL---\">"._QXZ("All Admin User Groups")."</option>\n";}
$stmt="SELECT user_group,group_name from vicidial_user_groups $whereLOGadmin_viewable_groupsSQL order by user_group;";
$rslt=mysql_to_mysqli($stmt, $link);
$UUgroups_to_print = mysqli_num_rows($rslt);
$o=0;
while ($UUgroups_to_print > $o)
	{
	$rowx=mysqli_fetch_row($rslt);
	$UUgroups_list .= "<option value=\"$rowx[0]\">$rowx[0] - $rowx[1]</option>\n";
	$o++;
	}

$stmt="SELECT group_id,group_name from vicidial_inbound_groups where group_handling='EMAIL' $LOGadmin_viewable_groupsSQL order by group_id;";
#	$stmt="SELECT group_id,group_name from vicidial_inbound_groups where group_id NOT IN('AGENTDIRECT') order by group_id";
$rslt=mysql_to_mysqli($stmt, $link);
$Dgroups_to_print = mysqli_num_rows($rslt);
$Dgroups_menu='';
$Dgroups_selected=0;
$o=0;
while ($Dgroups_to_print > $o)
	{
	$rowx=mysqli_fetch_row($rslt);
	$Dgroups_menu .= "<option ";
	if ($drop_inbound_group == "$rowx[0]")
		{
		$Dgroups_menu .= "SELECTED ";
		$Dgroups_selected++;
		}
	$Dgroups_menu .= "value=\"$rowx[0]\">$rowx[0] - $rowx[1]</option>\n";
	$o++;
	}
if ($Dgroups_selected < 1)
	{$Dgroups_menu .= "<option SELECTED value=\"---NONE---\">---"._QXZ("NONE")."---</option>\n";}
else
	{$Dgroups_menu .= "<option value=\"---NONE---\">---"._QXZ("NONE")."---</option>\n";}


$SSmenu_background='015B91';
$SSframe_background='D9E6FE';
$SSstd_row1_background='9BB9FB';
$SSstd_row2_background='B9CBFD';
$SSstd_row3_background='8EBCFD';
$SSstd_row4_background='B6D3FC';
$SSstd_row5_background='A3C3D6';
$SSalt_row1_background='BDFFBD';
$SSalt_row2_background='99FF99';
$SSalt_row3_background='CCFFCC';

if ($SSadmin_screen_colors != 'default')
	{
	$stmt = "SELECT menu_background,frame_background,std_row1_background,std_row2_background,std_row3_background,std_row4_background,std_row5_background,alt_row1_background,alt_row2_background,alt_row3_background FROM vicidial_screen_colors where colors_id='$SSadmin_screen_colors';";
	$rslt=mysql_to_mysqli($stmt, $link);
	if ($DB) {echo "$stmt\n";}
	$colors_ct = mysqli_num_rows($rslt);
	if ($colors_ct > 0)
		{
		$row=mysqli_fetch_row($rslt);
		$SSmenu_background =		$row[0];
		$SSframe_background =		$row[1];
		$SSstd_row1_background =	$row[2];
		$SSstd_row2_background =	$row[3];
		$SSstd_row3_background =	$row[4];
		$SSstd_row4_background =	$row[5];
		$SSstd_row5_background =	$row[6];
		$SSalt_row1_background =	$row[7];
		$SSalt_row2_background =	$row[8];
		$SSalt_row3_background =	$row[9];
		}
	}
$Mhead_color =	$SSstd_row5_background;
$Mmain_bgcolor = $SSmenu_background;
$Mhead_color =	$SSstd_row5_background;

?>
<html>
<head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">

<link rel="stylesheet" type="text/css" href="vicidial_stylesheet.php">
<script language="JavaScript" src="help.js"></script>
<div id='HelpDisplayDiv' class='help_info' style='display:none;'></div>

<title><?php echo _("ADMINISTRATION: After Call Routing"); ?>
<?php

##### BEGIN Set variables to make header show properly #####
$ADD =					'0';
$hh =					'admin';
$sh =					'AfterCallRouting';
$LOGast_admin_access =	'1';
$ADMIN =				'admin.php';
$page_width='770';
$section_width='750';
$header_font_size='3';
$subheader_font_size='2';
$subcamp_font_size='2';
$header_selected_bold='<b>';
$header_nonselected_bold='';
$admin_color =		'#FFFF99';
$admin_font =		'BLACK';
$admin_color =		'#E6E6E6';
$emails_color =		'#FFFF99';
$emails_font =		'BLACK';
$emails_color =		'#C6C6C6';
$subcamp_color =	'#C6C6C6';
##### END Set variables to make header show properly #####

require("admin_header.php");

$NWB = "<IMG SRC=\"help.png\" onClick=\"FillAndShowHelpDiv(event, '";
$NWE = "')\" WIDTH=20 HEIGHT=20 BORDER=0 ALT=\"HELP\" ALIGN=TOP>";


if ($DB > 0) {
	echo "$DB,$action,$ip,$user,$copy_option,$stage,$eact,$confirm_deletion,$acr_id,$acr_name,$acr_beschreibung";
}

if ($eact=="DELETE" && $confirm_deletion=="yes" && $acr_id) {
	$del_stmt="delete from `snctdialer-after_call_action` where ID='$acr_id'";
	print $del_stmt;
	$del_rslt=mysql_to_mysqli($del_stmt, $link);
	$message="ACCOUNT $acr_id DELETED<BR/>";
	$eact="";
}



if (($stage=="SUBMIT" || $stage=="UPDATE"))
	{
	$error_msg="";
	if (!$acr_name) {$error_msg.="- "._("ACR Name is invalid or null")."<BR/>";}
	if (!$acr_beschreibung) {$error_msg.="- "._("ACR Description is invalid or null")."<BR/>";}

	if (!$error_msg)
		{
		if ($stage=="SUBMIT")
			{
			if ($add_copy_disabled > 0)
				{
				echo "<br>"._QXZ("You do not have permission to add records on this system")." -system_settings-\n";
				}
			else
				{
				$ins_stmt="INSERT INTO `snctdialer-after_call_action` (Name, Beschreibung, aktiv, Type, Announcement_file, Call_Menue) VALUES('$acr_name', '$acr_beschreibung', '$acr_active', '$acr_type', '$acr_survey_question_filename', '$acr_survey_callmenu')";
				
				$ins_rslt=mysql_to_mysqli($ins_stmt, $link);
				if (mysqli_affected_rows($link)==0) {
					$error_msg.="- "._QXZ("There was an unknown error when attempting to create the new account")."<BR/>";
					if($DB>0) {$error_msg.="<B>$ins_stmt</B><BR>";}
				} else {
					$acr_id = mysqli_insert_id($link);
					$message=_("NEW ACR ")." $acr_id "._("SUCCESSFULLY CREATED");
					$eact="";

					### LOG INSERTION Admin Log Table ###
					$SQL_log = "$ins_stmt|";
					$SQL_log = preg_replace('/;/','',$SQL_log);
					$SQL_log = addslashes($SQL_log);
					$stmt="INSERT INTO vicidial_admin_log set event_date=now(), user='$PHP_AUTH_USER', ip_address='$ip', event_section='ACR', event_type='ADD', record_id='$user', event_code='NEW ACR RECORD ADDED', event_sql=\"$SQL_log\", event_notes='';";
					if ($DB) {echo "|$stmt|\n";}
					$rslt=mysql_to_mysqli($stmt, $link);
					}
				}
			}
		else
			{
			$upd_stmt="update `snctdialer-after_call_action` set Name='$acr_name', Beschreibung='$acr_beschreibung', aktiv='$acr_active', Announcement_file='$acr_survey_question_filename', Call_Menue='$acr_survey_callmenu' WHERE ID='$acr_id'";
			$upd_rslt=mysql_to_mysqli($upd_stmt, $link);
			if (mysqli_affected_rows($link)==0)
				{
				$error_msg.="- "._QXZ("There was an unknown error when attempting to update account")." $email_account_id<BR/>";
				if($DB>0) {$error_msg.="<B>$upd_stmt</B><BR>";}
				}
			else
				{
				$message=_QXZ("ACCOUNT")." $acr_id "._QXZ("SUCCESSFULLY MODIFIED");
				# $eact="";

				### LOG INSERTION Admin Log Table ###
				$SQL_log = "$upd_stmt|";
				$SQL_log = preg_replace('/;/','',$SQL_log);
				$SQL_log = addslashes($SQL_log);
				$stmt="INSERT INTO vicidial_admin_log set event_date=now(), user='$PHP_AUTH_USER', ip_address='$ip', event_section='ACR', event_type='MODIFY', record_id='$email_account_id', event_code='EMAIL ACCOUNT MODIFIED', event_sql=\"$SQL_log\", event_notes='';";
				if ($DB) {echo "|$stmt|\n";}
				$rslt=mysql_to_mysqli($stmt, $link);
				}
			}
		}
	}
else if ($stage=="COPY") {

}



################################################################################
##### BEGIN copy fields to a list form
if ($eact == "COPY") {
	
}


### END copy fields to a list form
else if ($eact == "ADD") {

	if ($LOGuser_level == 9) {
		$stmt="SELECT campaign_id,campaign_name from vicidial_campaigns $whereLOGallowed_campaignsSQL order by campaign_id;";
		$rslt=mysql_to_mysqli($stmt, $link);
		$campaigns_to_print = mysqli_num_rows($rslt);
		$campaigns_list='<fieldlist>';
		$o=0;
		while ($campaigns_to_print > $o) {
			$rowx=mysqli_fetch_row($rslt);
			$campaigns_list .= "<label><input type=\"checkbox\" name=\"XX-$rowx[0]\" id=\"$rowx[0]\" value=\"$rowx[0]\">$rowx[0]</input> -- $rowx[1]</label><br>\n";
			$o++;
		}
		$campaigns_list.='</fieldlist>';

		##### get in-groups listings for dynamic pulldown
		$stmt="SELECT group_id,group_name from vicidial_inbound_groups $whereLOGadmin_viewable_groupsSQL order by group_id;";
		$rslt=mysql_to_mysqli($stmt, $link);
		$Xgroups_to_print = mysqli_num_rows($rslt);
		$Xgroups_menu='';
		$Xgroups_selected=0;
		$FXgroups_menu='';
		$FXgroups_selected=0;
		$TypeGroup ='';
		$o=0;
		foreach ($ACRTypeArr as $value) {
			if ($o == 0) {
				$TypeGroup .= "<option SELECTED value=\"$value\">$value</option>\n";
				$o++;
			} else {
				$TypeGroup .= "<option value=\"$value\">$value</option>\n";
			}
		}
		$o=0;
		
		if ($Xgroups_selected < 1)
			{$Xgroups_menu .= "<option SELECTED value=\"---NONE---\">---"._QXZ("NONE")."---</option>\n";}
		else
			{$Xgroups_menu .= "<option value=\"---NONE---\">---"._QXZ("NONE")."---</option>\n";}
		if ($FXgroups_selected < 1)
			{$FXgroups_menu .= "<option SELECTED value=\"---NONE---\">---"._QXZ("NONE")."---</option>\n";}
		else
			{$FXgroups_menu .= "<option value=\"---NONE---\">---"._QXZ("NONE")."---</option>\n";}

		##### get callmenu listings for dynamic pulldown
		$stmt="SELECT menu_id,menu_name from vicidial_call_menu $whereLOGadmin_viewable_groupsSQL order by menu_id;";
		$rslt=mysql_to_mysqli($stmt, $link);
		$Xmenus_to_print = mysqli_num_rows($rslt);
		$o=0;
		$Xmenuslist='';
		$Wmenuslist='';
		while ($Xmenus_to_print > $o)
		{
			$rowx=mysqli_fetch_row($rslt);
			$Xmenuslist .= "<option ";
			$Wmenuslist .= "<option ";
			if ($hold_time_option_callmenu == "$rowx[0]")
			{
				$Xmenuslist .= "SELECTED ";
				$Xmenus_selected++;
			}
			if ($wait_time_option_callmenu == "$rowx[0]")
			{
				$Wmenuslist .= "SELECTED ";
				$Wmenus_selected++;
			}
			$Xmenuslist .= "value=\"$rowx[0]\">$rowx[0] - $rowx[1]</option>\n";
			$Wmenuslist .= "value=\"$rowx[0]\">$rowx[0] - $rowx[1]</option>\n";
			$o++;
		}
		if ($Xmenus_selected < 1)
			{$Xmenuslist .= "<option SELECTED value=\"---NONE---\">---"._QXZ("NONE")."---</option>\n";}
		if ($Wmenus_selected < 1)
			{$Wmenuslist .= "<option SELECTED value=\"---NONE---\">---"._QXZ("NONE")."---</option>\n";}



		##### get in-groups listings for dynamic pulldown
		$stmt="SELECT group_id,group_name from vicidial_inbound_groups where group_id NOT IN('AGENTDIRECT') $LOGadmin_viewable_groupsSQL order by group_id;";
		$rslt=mysql_to_mysqli($stmt, $link);
		$Dgroups_to_print = mysqli_num_rows($rslt);
		$Dgroups_menu='';
		$Dgroups_selected=0;
		$FDgroups_menu='';
		$FDgroups_selected=0;
		$o=0;
		while ($Dgroups_to_print > $o)
			{
			$rowx=mysqli_fetch_row($rslt);
			$Dgroups_menu .= "<option ";
			$FDgroups_menu .= "<option ";
			if ($group_id == "$rowx[0]")
				{
				$Dgroups_menu .= "SELECTED ";
				$Dgroups_selected++;
				}
			if ($filter_group_id == "$rowx[0]")
				{
				$FDgroups_menu .= "SELECTED ";
				$FDgroups_selected++;
				}
			$Dgroups_menu .= "value=\"$rowx[0]\">$rowx[0] - $rowx[1]</option>\n";
			$FDgroups_menu .= "value=\"$rowx[0]\">$rowx[0] - $rowx[1]</option>\n";
			$o++;
			}
		if ($Dgroups_selected < 1)
			{$Dgroups_menu .= "<option SELECTED value=\"---NONE---\">---"._QXZ("NONE")."---</option>\n";}
		else
			{$Dgroups_menu .= "<option value=\"---NONE---\">---"._QXZ("NONE")."---</option>\n";}
		if ($FDgroups_selected < 1)
			{$FDgroups_menu .= "<option SELECTED value=\"---NONE---\">---"._QXZ("NONE")."---</option>\n";}
		else
			{$FDgroups_menu .= "<option value=\"---NONE---\">---"._QXZ("NONE")."---</option>\n";}


		echo "<TABLE>\n";
		echo "<TR><TD>\n";
		echo "<FONT FACE=\"ARIAL,HELVETICA\" COLOR=BLACK SIZE=2>";
		if ($error_msg) {echo "ACCOUNT NOT INSERTED<BR/>"._("The data you submitted has the following errors").":<BR/>$error_msg";}
		echo "<br>"._("Add new After Call Routing")."<form action='$PHP_SELF' method='POST'>\n";
		echo "<center><TABLE width=$section_width cellspacing=3>\n";

		echo "<tr bgcolor=#$SSstd_row4_background><td align=right>"._("ACR Name").": </td><td align=left><input type=text name=acr_name size=20 maxlength=50 value='$acr_name'>$NWB#email_accounts-email_account_id$NWE</td></tr>\n";
		echo "<tr bgcolor=#$SSstd_row4_background><td align=right>"._("ACR Description").": </td><td align=left><input type=text name=acr_beschreibung size=40 maxlength=100 value='$acr_beschreibung'>$NWB#email_accounts-email_account_name$NWE</td></tr>\n";
		echo "<tr bgcolor=#$SSstd_row4_background><td align=right>"._("Active").": </td><td align=left><select size=1 name=acr_active><option value='Y'>"._("Y")."</option><option SELECTED value='N'>"._("N")."</option></select>$NWB#email_accounts-email_account_active$NWE</td></tr>\n";
				
		echo "<tr bgcolor=#$SSstd_row4_background><td align=right>"._("ACR Type").": </td><td align=left><select size=1 name=acr_type>";
		echo "$TypeGroup";
#		echo "<option value='$arc_type' selected>$acr_type</option></select>$NWB#email_accounts-in_group$NWE</td></tr>\n";
		echo "$NWB#email_accounts-in_group$NWE</td></tr>\n";

		echo "<tr bgcolor=#$SSstd_row3_background><td align=right>"._QXZ("After Call Question Filename").": </td><td align=left><input type=text name=acr_survey_question_filename id=acr_survey_question_filename size=50 maxlength=255 value=\"$acr_survey_question_filename\"> <a href=\"javascript:launch_chooser('inbound_survey_question_filename','date');\">"._QXZ("audio chooser")."</a> $NWB#inbound_groups-inbound_survey_question_filename$NWE</td></tr>\n";

		echo "<tr bgcolor=#$SSstd_row4_background><td align=right>"._("After Call End Call Menu").":</td><td align=left><select size=1 name=acr_survey_callmenu id=acr_survey_callmenu>$Xmenuslist<option SELECTED>$acr_survey_callmenu</option></select>$NWB#inbound_groups-inbound_survey_callmenu$NWE</td></tr>\n";

#		echo "<tr bgcolor=#$SSstd_row4_background><td align=right>"._("ACR Campaigens").": $NWB#email_accounts-in_group$NWE</td><td align=left>";
#		echo "$campaigns_list";
##		echo "<option value='$arc_type' selected>$acr_type</option></select>$NWB#email_accounts-in_group$NWE</td></tr>\n";
#		echo "</td></tr>\n";

		echo "<tr bgcolor=#$SSstd_row4_background><td align=center colspan=2><input type=submit name=SUBMIT VALUE='"._("SUBMIT")."'>";
		echo "<input type=hidden name=acr_id value='$acr_id'><input type=hidden name='eact' value='ADD'><input type=hidden name=stage value='SUBMIT'></td></tr>\n";
		
		echo "</TABLE></center></form>\n";
	}
	else {
		echo _QXZ("You do not have permission to view this page")."\n";
		exit;
	}
} else if (($eact=="DELETE" || $eact=="UPDATE") && $acr_id) {
	if ($LOGuser_level == 9) {
		$stmt="SELECT * from `snctdialer-after_call_action` where ID='$acr_id'";
		$rslt=mysql_to_mysqli($stmt, $link);
		$row=mysqli_fetch_array($rslt);

		$acr_name=$row["Name"];
		$acr_beschreibung=$row["Beschreibung"];
		$acr_type=$row["Type"];
		$acr_active=$row["Aktiv"];
		$acr_survey_question_filename=$row["Announcement_file"];
		$acr_survey_callmenu=$row["Call_Menue"];

		$TypeGroup ='';
		$o=0;
		foreach ($ACRTypeArr as $value) {
			if ($o == 0) {
				$TypeGroup .= "<option SELECTED value=\"$value\">$value</option>\n";
				$o++;
			} else {
				$TypeGroup .= "<option value=\"$value\">$value</option>\n";
			}
		}

		##### get callmenu listings for dynamic pulldown
		$stmt="SELECT menu_id,menu_name from vicidial_call_menu $whereLOGadmin_viewable_groupsSQL order by menu_id;";
		$rslt=mysql_to_mysqli($stmt, $link);
		$Xmenus_to_print = mysqli_num_rows($rslt);
		$o=0;
		$Xmenuslist='';
		$Wmenuslist='';
		while ($Xmenus_to_print > $o)
		{
			$rowx=mysqli_fetch_row($rslt);
			$Xmenuslist .= "<option ";
			$Wmenuslist .= "<option ";
			if ($hold_time_option_callmenu == "$rowx[0]")
			{
				$Xmenuslist .= "SELECTED ";
				$Xmenus_selected++;
			}
			if ($wait_time_option_callmenu == "$rowx[0]")
			{
				$Wmenuslist .= "SELECTED ";
				$Wmenus_selected++;
			}
			$Xmenuslist .= "value=\"$rowx[0]\">$rowx[0] - $rowx[1]</option>\n";
			$Wmenuslist .= "value=\"$rowx[0]\">$rowx[0] - $rowx[1]</option>\n";
			$o++;
		}
		if ($Xmenus_selected < 1)
		{$Xmenuslist .= "<option SELECTED value=\"---NONE---\">---"._QXZ("NONE")."---</option>\n";}
		if ($Wmenus_selected < 1)
		{$Wmenuslist .= "<option SELECTED value=\"---NONE---\">---"._QXZ("NONE")."---</option>\n";}
		
		if ($eact=="DELETE" && $acr_id) {
			echo "<FONT FACE=\"ARIAL,HELVETICA\" COLOR=BLACK SIZE=2>";
			echo "<br><B>"._("CONFIRM DELETION OF ACR Record")." $acr_id</B><BR>\n";
			echo "<a href='$PHP_SELF?eact=DELETE&acr_id=$acr_id&confirm_deletion=yes'>"._("Click to delete account")." $acr_id</a>\n";
			echo "</font>";
		}
		
		
		echo "<TABLE>\n";
		echo "<TR><TD>\n";
		echo "<FONT FACE=\"ARIAL,HELVETICA\" COLOR=BLACK SIZE=2>";
		if ($error_msg) {echo "ACCOUNT NOT INSERTED<BR/>"._("The data you submitted has the following errors").":<BR/>$error_msg";}
		echo "<br>"._("Add new After Call Routing")."<form action='$PHP_SELF' method='POST'>\n";
		echo "<center><TABLE width=$section_width cellspacing=3>\n";
		
		echo "<tr bgcolor=#$SSstd_row4_background><td align=right>"._("ACR Name").": </td><td align=left><input type=text name=acr_name size=20 maxlength=50 value='$acr_name'>$NWB#email_accounts-email_account_id$NWE</td></tr>\n";
		echo "<tr bgcolor=#$SSstd_row4_background><td align=right>"._("ACR Description").": </td><td align=left><input type=text name=acr_beschreibung size=40 maxlength=100 value='$acr_beschreibung'>$NWB#email_accounts-email_account_name$NWE</td></tr>\n";
		echo "<tr bgcolor=#$SSstd_row4_background><td align=right>"._("Active").": </td><td align=left><select size=1 name=acr_active><option value='Y'>"._("Y")."</option><option SELECTED value='N'>"._("N")."</option></select>$NWB#email_accounts-email_account_active$NWE</td></tr>\n";
		
		echo "<tr bgcolor=#$SSstd_row4_background><td align=right>"._("ACR Type").": </td><td align=left><select size=1 name=acr_type>";
		echo "$TypeGroup";
		#		echo "<option value='$arc_type' selected>$acr_type</option></select>$NWB#email_accounts-in_group$NWE</td></tr>\n";
		echo "$NWB#email_accounts-in_group$NWE</td></tr>\n";
		
		echo "<tr bgcolor=#$SSstd_row3_background><td align=right>"._QXZ("After Call Question Filename").": </td><td align=left><input type=text name=acr_survey_question_filename id=acr_survey_question_filename size=50 maxlength=255 value=\"$acr_survey_question_filename\"> <a href=\"javascript:launch_chooser('acr_survey_question_filename','date');\">"._QXZ("audio chooser")."</a> $NWB#inbound_groups-inbound_survey_question_filename$NWE</td></tr>\n";
		
		echo "<tr bgcolor=#$SSstd_row4_background><td align=right>"._("After Call Call Menu").":</td><td align=left><select size=1 name=acr_survey_callmenu id=acr_survey_callmenu>$Xmenuslist<option SELECTED>$acr_survey_callmenu</option></select>$NWB#inbound_groups-inbound_survey_callmenu$NWE</td></tr>\n";
		
		#		echo "<tr bgcolor=#$SSstd_row4_background><td align=right>"._("ACR Campaigens").": $NWB#email_accounts-in_group$NWE</td><td align=left>";
		#		echo "$campaigns_list";
		##		echo "<option value='$arc_type' selected>$acr_type</option></select>$NWB#email_accounts-in_group$NWE</td></tr>\n";
		#		echo "</td></tr>\n";
		
		echo "<tr bgcolor=#$SSstd_row4_background><td align=center colspan=2><input type=submit name=SUBMIT VALUE='UPDATE'>";
		echo "<input type=hidden name=acr_id value='$acr_id'><input type=hidden name='eact' value='UPDATE'><input type=hidden name=stage value='UPDATE'></td></tr>\n";
		
		echo "</TABLE></center></form>\n";
		
		
		

#		if ($message) {echo "<B>$message</B><BR>";}
#		if ($error_msg) {echo _QXZ("ACCOUNT NOT UPDATED")."<BR/>"._QXZ("The data you submitted has the following errors").":<BR/>$error_msg";}
#		echo "<br>"._QXZ("UPDATE AN EXISTING INBOUND EMAIL ACCOUNT")."<form action='$PHP_SELF' method='GET'>\n";
#		echo "<center><TABLE width=$section_width cellspacing=3>\n";

		echo "<BR><BR><a href='$PHP_SELF?eact=DELETE&acr_id=$acr_id'>"._QXZ("DELETE ACR Record")."</a></center></form>\n";
		}
	else
		{
		echo _QXZ("You do not have permission to view this page")."\n";
		exit;
		}
	}
else
	{
	echo "<img src=\"images/icon_acr.png\" width=42 height=42 align=left> <FONT FACE=\"ARIAL,HELVETICA\" COLOR=BLACK SIZE=2>";
	if ($message) {echo "<B>$message</B><BR>";}
	echo "<br>"._("After Call Routing Listings").":\n";
	echo "<center><TABLE width=750 cellspacing=0 cellpadding=1>\n";
	echo "<TR BGCOLOR=BLACK>\n";
	echo "<TD><font size=1 color=white>"._("ID")."</TD>\n";
	echo "<TD><font size=1 color=white>"._("ACR NAME")."</TD>\n";
	echo "<TD><font size=1 color=white>"._("DESCRIPTION")."</TD>\n";
	echo "<TD><font size=1 color=white>"._("TPYE")."</TD>\n";
	echo "<TD><font size=1 color=white>"._("ACTIVE")."</TD>\n";
	echo "<TD><font size=1 color=white>"._("MODIFY")."</TD></tr>\n";

	$stmt="SELECT * from `snctdialer-after_call_action` order by `ID`;";
	$rslt=mysql_to_mysqli($stmt, $link);
	$accounts_to_print = mysqli_num_rows($rslt);
	$o=0;
	while ($accounts_to_print > $o)
		{
		$row=mysqli_fetch_array($rslt);

		if (preg_match("/1$|3$|5$|7$|9$/i", $o))
			{$bgcolor='class="records_list_x"';}
		else
			{$bgcolor='class="records_list_y"';}
		echo "<tr $bgcolor"; if ($SSadmin_row_click > 0) {echo " onclick=\"window.document.location='$PHP_SELF?eact=UPDATE&acr_id=$row[ID]'\"";} 
		echo "><td><a href=\"$PHP_SELF?eact=UPDATE&acr_id=$row[ID]\"><font size=1 color=black>$row[ID]</a></font></td>";
		echo "<td><font size=1> $row[Name]</font></td>";
		echo "<td><font size=1> $row[Beschreibung]</font></td>";
		echo "<td><font size=1> $row[Type]</font></td>";
		echo "<td><font size=1> $row[aktiv]</font></td>";
		echo "<td><font size=1><a href=\"$PHP_SELF?eact=UPDATE&act_id=$row[ID]\">"._("MODIFY")."</a></font></td></tr>\n";
		$o++;
		}

	echo "</table></font>";
	}


$ENDtime = date("U");
$RUNtime = ($ENDtime - $STARTtime);
echo "\n\n\n<br><br><br>\n<font size=1> "._("runtime").": $RUNtime "._("seconds")." &nbsp; &nbsp; &nbsp; &nbsp; "._("Version").": $admin_version &nbsp; &nbsp; "._("Build").": $acr_build</font>";

?>

</body>
</html>
