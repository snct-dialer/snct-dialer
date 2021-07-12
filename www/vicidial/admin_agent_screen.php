<?php
###############################################################################
#
# Modul admin_agent_screen.php
#
# SNCT-Dialer™ Setup Agent Screen
#
# Copyright (©) 2020-2021 SNCT GmbH <info@snct-gmbh.de>
#               2020-2021 Jörg Frings-Fürst <open_source@jff.email>
#
# LICENSE: AGPLv3
#
###############################################################################
#
# requested Module:
#
# dbconnect_mysqli.php
# functions.php
# ../tools/system_wide_settings.php
# admin_header.php
#
###############################################################################
#
# Version  / Build
#
$admin_agent_screen_version = '3.1.1-1';
$admin_agent_screen_build = '20210712-1';
#
###############################################################################
#
# Changelog
#
# 2021-07-12 jff First Build
#

$sh="SetupAgentScreen";

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
if (isset($_GET["eact"]))						{$eact=$_GET["eact"];}
	elseif (isset($_POST["eact"]))				{$eact=$_POST["eact"];}


if (isset($_GET["ID"]))                         {$ID=$_GET["ID"];}
    elseif (isset($_POST["ID"]))                {$ID=$_POST["ID"];}
if (isset($_GET["DisplayName"]))                {$DisplayName=$_GET["DisplayName"];}
    elseif (isset($_POST["DisplayName"]))       {$DisplayName=$_POST["DisplayName"];}
if (isset($_GET["InputType"]))                  {$InputType=$_GET["InputType"];}
    elseif (isset($_POST["InputType"]))         {$InputType=$_POST["InputType"];}
if (isset($_GET["aktiv"]))                      {$aktiv=$_GET["aktiv"];}
    elseif (isset($_POST["aktiv"]))             {$aktiv=$_POST["aktiv"];}
if (isset($_GET["MinLen"]))                     {$MinLen=$_GET["MinLen"];}
    elseif (isset($_POST["MinLen"]))            {$MinLen=$_POST["MinLen"];}
if (isset($_GET["MaxLen"]))                     {$MaxLen=$_GET["MaxLen"];}
    elseif (isset($_POST["MaxLen"]))            {$MaxLen=$_POST["MaxLen"];}
if (isset($_GET["Line"]))                       {$Line=$_GET["Line"];}
    elseif (isset($_POST["Line"]))              {$Line=$_POST["Line"];}
if (isset($_GET["Pos"]))                        {$Pos=$_GET["Pos"];}
    elseif (isset($_POST["Pos"]))               {$Pos=$_POST["Pos"];}
if (isset($_GET["Marker"]))                     {$Marker=$_GET["Marker"];}
    elseif (isset($_POST["Marker"]))            {$Marker=$_POST["Marker"];}
if (isset($_GET["stage"]))						{$stage=$_GET["stage"];}
    elseif (isset($_POST["stage"]))				{$stage=$_POST["stage"];}
if (isset($_GET["span_id"]))					{$span_id=$_GET["span_id"];}
    elseif (isset($_POST["span_id"]))			{$span_id=$_POST["span_id"];}
    
$aktiv = (isset($aktiv)) ? 1 : 0;
$Marker = (isset($Marker)) ? 1 : 0;
if(!isset($stage)) {
    $stage = "";
}
    
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


#print_r($_GET);
#print_r($_POST);




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

<title><?php echo _("ADMINISTRATION: Setup Agent Screen"); ?>
<?php

##### BEGIN Set variables to make header show properly #####
$ADD =					'0';
$hh =					'admin';
$sh =                    "SetupAgentScreen";
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

if ($LOGuser_level < 9) {
    echo _("You do not have permission to view this page")."\n";
    exit;
}


if ($DB > 0) {
	echo "$DB,$action,$ip,$user,$copy_option,$stage,$eact,$confirm_deletion,$acr_id,$acr_name,$acr_beschreibung";
}

if($stage == "modify") { 
    
    $statement  = "UPDATE `snctdialer_agent_interface` SET `DisplayName` = ?, `InputType` = ?, `MinLen` = ?, `MaxLen` = ?";
    $statement .= ", `Line` = ?, `Position` = ?, `Marker` = ?, `aktiv` = ?, `span_id` = ? ";
    $statement .= " WHERE `ID` = '".$ID."';";
    
#    echo $statement . PHP_EOL;
    
    $stmt1 = mysqli_prepare($link, $statement);
    
    if ( false===$stmt1 ) {
        echo "Error : ". (mysqli_error($link)) . PHP_EOL;
    }
    mysqli_stmt_bind_param($stmt1, "ssiiiiiis", $DisplayName, $InputType, $MinLen, $MaxLen, $Line, $Position, $Marker, $aktiv, $span_id);
    mysqli_stmt_execute($stmt1);
    $stage = "";
#    echo "Stmt1: " . $stmt1 . PHP_EOL;
    
}

if($stage == "") {
	echo "<img src=\"images/agent_setup.png\" width=42 height=42 align=left> <FONT FACE=\"ARIAL,HELVETICA\" COLOR=BLACK SIZE=2>";
	if ($message) {echo "<B>$message</B><BR>";}
	echo "<br>"._("Agent Screen Setup").":\n";
	echo "<center><TABLE width=750 cellspacing=0 cellpadding=1>\n";
	echo "<TR BGCOLOR=BLACK>\n";
	echo "<TD><font size=1 color=white>"._("ID")."</TD>\n";
	echo "<TD><font size=1 color=white>"._("Fieldname")."</TD>\n";
	echo "<TD><font size=1 color=white>"._("Displayname")."</TD>\n";
	echo "<TD><font size=1 color=white>"._("FieldType")."</TD>\n";
	echo "<TD><font size=1 color=white>"._("Active")."</TD>\n";
	echo "<TD><font size=1 color=white>"._("InputType")."</TD>\n";
	echo "<TD><font size=1 color=white>"._("MinLength")."</TD>\n";
	echo "<TD><font size=1 color=white>"._("MaxLength")."</TD>\n";
	echo "<TD><font size=1 color=white>"._("Line")."</TD>\n";
	echo "<TD><font size=1 color=white>"._("Pos")."</TD>\n";
	echo "<TD><font size=1 color=white>"._("Marker")."</TD>\n";
	echo "<TD><font size=1 color=white>"._("SpanID")."</TD>\n";
	echo "<TD><font size=1 color=white>"._("Submit")."</TD>\n";
	
	echo "</TR>";

	$stmt="SELECT * from `snctdialer_agent_interface` WHERE `System` = '0' order by `ID`;";
	$result = mysqli_query($link, $stmt);
	while ($row = mysqli_fetch_array($result, MYSQLI_BOTH)) {

	    if (preg_match("/1$|3$|5$|7$|9$/i", $o)) {
	        $bgcolor='class="records_list_x"';
	    } else {
	        $bgcolor='class="records_list_y"';
	    }
		
			
		echo "<tr $bgcolor><form action=$PHP_SELF method=POST>\n";
#		echo "<input type=hidden name=ADD value=421111111111111>\n";
		echo "<input type=hidden name=stage value=modify>\n";
		
#		echo "<tr $bgcolor"; if ($SSadmin_row_click > 0) {echo " onclick=\"window.document.location='$PHP_SELF?eact=UPDATE&acr_id=$row[ID]'\"";} 
#		echo "><td><a href=\"$PHP_SELF?eact=UPDATE&acr_id=$row[ID]\"><font size=1 color=black>$row[ID]</a></font></td>";

		$SelAkt = "";
		$SelMarker = "";
		$GlbRO = "readonly";
		if($row["aktiv"] == 1) {
		    $SelAkt = "checked";
		    $GlbRO = "";
		}
		if($row["Marker"] == 1) {
		    $SelMarker = "checked";
		}
		
		echo "<td><input type=text name=ID size=2 maxlength=3 value=\"".$row["ID"]."\"  readonly></td>\n";
		echo "<td><input type=text name=List_Field size=15 maxlength=25 value=\"".$row["List_Field"]."\"  readonly></td>\n";
		echo "<td><input type=text name=DisplayName size=15 maxlength=50 value=\"".$row["DisplayName"]."\" $GlbRO></td>\n";
		echo "<td><input type=text name=FieldType size=7 maxlength=20 value=\"".$row["FieldType"]."\" readonly></td>\n";
		
		echo "<td><input type=CheckBox name=aktiv value=\"1\" $SelAkt></td>\n";
		echo "<td><input type=text name=InputType size=7 maxlength=20 value=\"".$row["InputType"]."\" $GlbRO></td>\n";
		echo "<td><input type=text name=MinLen size=2 maxlength=3 value=\"".$row["MinLen"]."\" $GlbRO></td>\n";
		echo "<td><input type=text name=MaxLen size=2 maxlength=3 value=\"".$row["MaxLen"]."\" $GlbRO></td>\n";
		echo "<td><input type=text name=Line size=2 maxlength=2 value=\"".$row["Line"]."\" $GlbRO></td>\n";
		echo "<td><input type=text name=Position size=2 maxlength=2 value=\"".$row["Position"]."\" $GlbRO></td>\n";
		echo "<td><input type=CheckBox name=Marker value=\"1\" $SelMarker $GlbRO></td>\n";
		echo "<td><input type=text name=span_id size=10 maxlength=30 value=\"".$row["span_id"]."\" $GlbRO></td>\n";
		
		echo "<td align=center nowrap><font size=1><input type=submit name=submit value='"._QXZ("MODIFY")."'></td>";
		echo "</form></TR>";
#		echo "<td><a href=\"$PHP_SELF?eact=UPDATE&acr_id=$row[ID]\"><font size=1 color=black>$row[ID]</a></font></td>";
#		echo "<td><font size=1> $row[Name]</font></td>";
#		echo "<td><font size=1> $row[Beschreibung]</font></td>";
#		echo "<td><font size=1> $row[Type]</font></td>";
#		echo "<td><font size=1> $row[aktiv]</font></td>";
#		echo "<td><font size=1><a href=\"$PHP_SELF?eact=UPDATE&acr_id=$row[ID]\">"._("MODIFY")."</a></font></td></tr>\n";
#		$o++;
	}
	echo "</table></font>";
}

$ENDtime = date("U");
$RUNtime = ($ENDtime - $STARTtime);
echo "\n\n\n<br><br><br>\n<font size=1> "._("runtime").": $RUNtime "._("seconds")." &nbsp; &nbsp; &nbsp; &nbsp; "._("Version").": $admin_agent_screen_version &nbsp; &nbsp; "._("Build").": $admin_agent_screen_build</font>";

?>

</body>
</html>
