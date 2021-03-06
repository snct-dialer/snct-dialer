<?php
###############################################################################
#
# Modul admin_modify_lead.php
#
# SNCT-Dialer™ Modify Leads
#
# Copyright (©) 2019-2021 SNCT GmbH <info@snct-gmbh.de>
#               2017-2021 Jörg Frings-Fürst <open_source@jff.email>
#
# LICENSE: AGPLv3
#
###############################################################################
#
# based on VICIdial®
# (© 2019  Matt Florell <vicidial@gmail.com>)
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
$admin_modify_lead_version = '3.1.1-7';
$admin_modify_lead_build = '20210510-1';
#
###############################################################################
#
# Changelog#
# 
# 2021-05-10 jff    Fix save owner. 
# 2021-04-30 jff    Move system-settings to ../inc/get_system_settings.php
#                   Add language_header.php    
# 2021-04-29 jff    Add field customer_status
#                   Add new function sd_error_log and sd_debug_log
# 2021-04-28 jff    Add field for selections
# 2021-04-13 jff    Fix GDPR download
# 2021-04-07 jff    Add field housenr1
# 2021-02-08 jff    Remove preselect Modify [vicidial|agent] log
#                   Change default date on CBHOLD to today and Useronly
# 20201225 jff	Show only recordings of allowed users
#				Mark archiv records with red
# 20201122 jff	Add iframe to show lead changes 
# 20200921 jff	Add global ShowArchive for UserLevel >= 9.
# 20200629 jff	Add external link from lead.
#
#
#

#
# Settings for download zip files via readfile
#
apache_setenv('no-gzip', 1);
ini_set('zlib.output_compression', 0);


require("dbconnect_mysqli.php");
require("functions.php");
require("admin_functions.php");
require("../inc/functions_ng.php");

require_once("../tools/system_wide_settings.php");
require_once("language_header.php");



$PHP_AUTH_USER=$_SERVER['PHP_AUTH_USER'];
$PHP_AUTH_PW=$_SERVER['PHP_AUTH_PW'];
$PHP_SELF=$_SERVER['PHP_SELF'];

if (isset($_GET["vendor_id"]))				  {$vendor_id=$_GET["vendor_id"];}
	elseif (isset($_POST["vendor_id"]))		  {$vendor_id=$_POST["vendor_id"];}
if (isset($_GET["source_id"]))				  {$source_id=$_GET["source_id"];}
	elseif (isset($_POST["source_id"]))		  {$source_id=$_POST["source_id"];}
if (isset($_GET["phone"]))				      {$phone=$_GET["phone"];}
	elseif (isset($_POST["phone"]))		      {$phone=$_POST["phone"];}
if (isset($_GET["old_phone"]))				  {$old_phone=$_GET["old_phone"];}
	elseif (isset($_POST["old_phone"]))		  {$old_phone=$_POST["old_phone"];}
if (isset($_GET["lead_id"]))				  {$lead_id=$_GET["lead_id"];}
	elseif (isset($_POST["lead_id"]))		  {$lead_id=$_POST["lead_id"];}
if (isset($_GET["title"]))				      {$title=$_GET["title"];}
	elseif (isset($_POST["title"]))		      {$title=$_POST["title"];}
if (isset($_GET["first_name"]))		          {$first_name=$_GET["first_name"];}
	elseif (isset($_POST["first_name"]))	  {$first_name=$_POST["first_name"];}
if (isset($_GET["middle_initial"]))			  {$middle_initial=$_GET["middle_initial"];}
	elseif (isset($_POST["middle_initial"]))  {$middle_initial=$_POST["middle_initial"];}
if (isset($_GET["last_name"]))				  {$last_name=$_GET["last_name"];}
	elseif (isset($_POST["last_name"]))		  {$last_name=$_POST["last_name"];}
if (isset($_GET["phone_number"]))			  {$phone_number=$_GET["phone_number"];}
	elseif (isset($_POST["phone_number"]))	  {$phone_number=$_POST["phone_number"];}
if (isset($_GET["end_call"]))				  {$end_call=$_GET["end_call"];}
	elseif (isset($_POST["end_call"]))		  {$end_call=$_POST["end_call"];}
if (isset($_GET["DB"]))					{$DB=$_GET["DB"];}
	elseif (isset($_POST["DB"]))		{$DB=$_POST["DB"];}
if (isset($_GET["dispo"]))				{$dispo=$_GET["dispo"];}
	elseif (isset($_POST["dispo"]))		{$dispo=$_POST["dispo"];}
if (isset($_GET["list_id"]))				{$list_id=$_GET["list_id"];}
	elseif (isset($_POST["list_id"]))		{$list_id=$_POST["list_id"];}
if (isset($_GET["campaign_id"]))			{$campaign_id=$_GET["campaign_id"];}
	elseif (isset($_POST["campaign_id"]))	{$campaign_id=$_POST["campaign_id"];}
if (isset($_GET["phone_code"]))				{$phone_code=$_GET["phone_code"];}
    elseif (isset($_POST["phone_code"]))	{$phone_code=$_POST["phone_code"];}
if (isset($_GET["phone_code_alt1"]))				{$phone_code_alt1=$_GET["phone_code_alt1"];}
    elseif (isset($_POST["phone_code_alt1"]))	{$phone_code_alt1=$_POST["phone_code_alt1"];}
if (isset($_GET["phone_code_alt2"]))			{$phone_code_alt2=$_GET["phone_code_alt2"];}
    elseif (isset($_POST["phone_code_alt2"]))	{$phone_code_alt2=$_POST["phone_code_alt2"];}
if (isset($_GET["phone_code_alt3"]))			{$phone_code_alt3=$_GET["phone_code_alt3"];}
    elseif (isset($_POST["phone_code_alt3"]))	{$phone_code_alt3=$_POST["phone_code_alt3"];}
if (isset($_GET["server_ip"]))				{$server_ip=$_GET["server_ip"];}
	elseif (isset($_POST["server_ip"]))		{$server_ip=$_POST["server_ip"];}
if (isset($_GET["extension"]))				{$extension=$_GET["extension"];}
	elseif (isset($_POST["extension"]))		{$extension=$_POST["extension"];}
if (isset($_GET["channel"]))				{$channel=$_GET["channel"];}
	elseif (isset($_POST["channel"]))		{$channel=$_POST["channel"];}
if (isset($_GET["call_began"]))				{$call_began=$_GET["call_began"];}
	elseif (isset($_POST["call_began"]))	{$call_began=$_POST["call_began"];}
if (isset($_GET["parked_time"]))			{$parked_time=$_GET["parked_time"];}
	elseif (isset($_POST["parked_time"]))	{$parked_time=$_POST["parked_time"];}
if (isset($_GET["tsr"]))				{$tsr=$_GET["tsr"];}
	elseif (isset($_POST["tsr"]))		{$tsr=$_POST["tsr"];}
if (isset($_GET["address1"]))				{$address1=$_GET["address1"];}
    elseif (isset($_POST["address1"]))		{$address1=$_POST["address1"];}
if (isset($_GET["housenr1"]))				{$housenr1=$_GET["housenr1"];}
    elseif (isset($_POST["housenr1"]))		{$housenr1=$_POST["housenr1"];}
if (isset($_GET["address2"]))				{$address2=$_GET["address2"];}
    elseif (isset($_POST["address2"]))		{$address2=$_POST["address2"];}
if (isset($_GET["housenr2"]))				{$housenr2=$_GET["housenr2"];}
    elseif (isset($_POST["housenr2"]))		{$housenr2=$_POST["housenr2"];}
if (isset($_GET["address3"]))				{$address3=$_GET["address3"];}
    elseif (isset($_POST["address3"]))		{$address3=$_POST["address3"];}
if (isset($_GET["housenr3"]))				{$housenr3=$_GET["housenr3"];}
    elseif (isset($_POST["housenr3"]))		{$housenr3=$_POST["housenr3"];}
if (isset($_GET["city"]))				{$city=$_GET["city"];}
	elseif (isset($_POST["city"]))		{$city=$_POST["city"];}
if (isset($_GET["state"]))				{$state=$_GET["state"];}
	elseif (isset($_POST["state"]))		{$state=$_POST["state"];}
if (isset($_GET["postal_code"]))			{$postal_code=$_GET["postal_code"];}
	elseif (isset($_POST["postal_code"]))	{$postal_code=$_POST["postal_code"];}
if (isset($_GET["province"]))				{$province=$_GET["province"];}
	elseif (isset($_POST["province"]))		{$province=$_POST["province"];}
if (isset($_GET["country_code"]))			{$country_code=$_GET["country_code"];}
	elseif (isset($_POST["country_code"]))	{$country_code=$_POST["country_code"];}
if (isset($_GET["alt_phone"]))				{$alt_phone=$_GET["alt_phone"];}
    elseif (isset($_POST["alt_phone"]))		{$alt_phone=$_POST["alt_phone"];}
if (isset($_GET["alt_phone2"]))				{$alt_phone2=$_GET["alt_phone2"];}
    elseif (isset($_POST["alt_phone2"]))		{$alt_phone2=$_POST["alt_phone2"];}   
if (isset($_GET["alt_phone3"]))				{$alt_phone3=$_GET["alt_phone3"];}
    elseif (isset($_POST["alt_phone3"]))	{$alt_phone3=$_POST["alt_phone3"];}
if (isset($_GET["email"]))				{$email=$_GET["email"];}
	elseif (isset($_POST["email"]))		{$email=$_POST["email"];}
if (isset($_GET["security"]))				{$security=$_GET["security"];}
	elseif (isset($_POST["security"]))		{$security=$_POST["security"];}
if (isset($_GET["comments"]))				{$comments=$_GET["comments"];}
	elseif (isset($_POST["comments"]))		{$comments=$_POST["comments"];}
if (isset($_GET["status"]))				{$status=$_GET["status"];}
	elseif (isset($_POST["status"]))	{$status=$_POST["status"];}
if (isset($_GET["rank"]))				{$rank=$_GET["rank"];}
	elseif (isset($_POST["rank"]))		{$rank=$_POST["rank"];}
if (isset($_GET["owner"]))				{$owner=$_GET["owner"];}
	elseif (isset($_POST["owner"]))		{$owner=$_POST["owner"];}
if (isset($_GET["submit"]))				{$submit=$_GET["submit"];}
	elseif (isset($_POST["submit"]))	{$submit=$_POST["submit"];}
if (isset($_GET["SUBMIT"]))				{$SUBMIT=$_GET["SUBMIT"];}
	elseif (isset($_POST["SUBMIT"]))	{$SUBMIT=$_POST["SUBMIT"];}
if (isset($_GET["CBchangeUSERtoANY"]))				{$CBchangeUSERtoANY=$_GET["CBchangeUSERtoANY"];}
	elseif (isset($_POST["CBchangeUSERtoANY"]))		{$CBchangeUSERtoANY=$_POST["CBchangeUSERtoANY"];}
if (isset($_GET["CBchangeANYtoUSER"]))				{$CBchangeANYtoUSER=$_GET["CBchangeANYtoUSER"];}
	elseif (isset($_POST["CBchangeANYtoUSER"]))		{$CBchangeANYtoUSER=$_POST["CBchangeANYtoUSER"];}
if (isset($_GET["CBchangeDATE"]))				{$CBchangeDATE=$_GET["CBchangeDATE"];}
	elseif (isset($_POST["CBchangeDATE"]))		{$CBchangeDATE=$_POST["CBchangeDATE"];}
if (isset($_GET["callback_id"]))				{$callback_id=$_GET["callback_id"];}
	elseif (isset($_POST["callback_id"]))		{$callback_id=$_POST["callback_id"];}
if (isset($_GET["CBuser"]))				{$CBuser=$_GET["CBuser"];}
	elseif (isset($_POST["CBuser"]))	{$CBuser=$_POST["CBuser"];}
if (isset($_GET["modify_logs"]))			{$modify_logs=$_GET["modify_logs"];}
	elseif (isset($_POST["modify_logs"]))	{$modify_logs=$_POST["modify_logs"];}
if (isset($_GET["modify_closer_logs"]))				{$modify_closer_logs=$_GET["modify_closer_logs"];}
	elseif (isset($_POST["modify_closer_logs"]))	{$modify_closer_logs=$_POST["modify_closer_logs"];}
if (isset($_GET["modify_agent_logs"]))			{$modify_agent_logs=$_GET["modify_agent_logs"];}
	elseif (isset($_POST["modify_agent_logs"]))	{$modify_agent_logs=$_POST["modify_agent_logs"];}
if (isset($_GET["add_closer_record"]))			{$add_closer_record=$_GET["add_closer_record"];}
	elseif (isset($_POST["add_closer_record"]))	{$add_closer_record=$_POST["add_closer_record"];}
if (isset($_POST["appointment_date"]))			{$appointment_date=$_POST["appointment_date"];}
	elseif (isset($_GET["appointment_date"]))	{$appointment_date=$_GET["appointment_date"];}
if (isset($_POST["appointment_time"]))			{$appointment_time=$_POST["appointment_time"];}
	elseif (isset($_GET["appointment_time"]))	{$appointment_time=$_GET["appointment_time"];}
if (isset($_GET["CBstatus"]))				{$CBstatus=$_GET["CBstatus"];}
	elseif (isset($_POST["CBstatus"]))		{$CBstatus=$_POST["CBstatus"];}
if (isset($_GET["archive_search"]))				{$archive_search=$_GET["archive_search"];}
	elseif (isset($_POST["archive_search"]))	{$archive_search=$_POST["archive_search"];}
if (isset($_GET["archive_log"]))			{$archive_log=$_GET["archive_log"];}
	elseif (isset($_POST["archive_log"]))	{$archive_log=$_POST["archive_log"];}
if (isset($_GET["date_of_birth"]))			{$date_of_birth=$_GET["date_of_birth"];}
	elseif (isset($_POST["date_of_birth"]))	{$date_of_birth=$_POST["date_of_birth"];}
if (isset($_GET["gdpr_action"]))			{$gdpr_action=$_GET["gdpr_action"];}
	elseif (isset($_POST["gdpr_action"]))	{$gdpr_action=$_POST["gdpr_action"];}
if (isset($_GET["CIDdisplay"]))				{$CIDdisplay=$_GET["CIDdisplay"];}
	elseif (isset($_POST["CIDdisplay"]))	{$CIDdisplay=$_POST["CIDdisplay"];}
	
if (isset($_GET["block_status"]))			{$block_status=$_GET["block_status"];}
	elseif (isset($_POST["block_status"]))	{$block_status=$_POST["block_status"];}
if (isset($_GET["selection"]))              {$selection=$_GET["selection"];}
    elseif (isset($_POST["selection"]))     {$selection=$_POST["selection"];}
if (isset($_GET["customer_status"]))              {$customer_status=$_GET["customer_status"];}
    elseif (isset($_POST["customer_status"]))     {$customer_status=$_POST["customer_status"];}

   
if ($archive_search=="Yes") {
    $vl_table="vicidial_list_archive";
} else {
    $vl_table="vicidial_list";
    $archive_search="No";
}
$altCIDdisplay="Yes";
if ($CIDdisplay=="Yes") {
    $altCIDdisplay="No";
}

$STARTtime = date("U");
$TODAY = date("Y-m-d");
$NOW_TIME = date("Y-m-d H:i:s");
$date = date("r");
$ip = getenv("REMOTE_ADDR");
$browser = getenv("HTTP_USER_AGENT");
$AMDcount=0;

$htmlconvert=1;
$nonselectable_statuses=0;
if (file_exists('options.php')) {
	require('options.php');
}
$selectableSQL = "where selectable='Y'";
$selectableSQLand = "and selectable='Y'";
if ($nonselectable_statuses > 0) {
    $selectableSQL='';
    $selectableSQLand='';
}

require_once '../inc/get_system_settings.php';


$lead_id = preg_replace('/[^0-9a-zA-Z]/','',$lead_id);


$PHP_AUTH_USER = preg_replace("/'|\"|\\\\|;/","",$PHP_AUTH_USER);
$PHP_AUTH_PW = preg_replace("/'|\"|\\\\|;/","",$PHP_AUTH_PW);


if (strlen($phone_number)<6) {
    $phone_number=$old_phone;
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

if ($non_latin > 0) {$rslt=mysqli_query($link, "SET NAMES 'UTF8'");}
$rights_stmt = "SELECT modify_leads,selected_language from vicidial_users where user='$PHP_AUTH_USER';";
if ($DB) {sd_debug_log($stmt);}
$rights_rslt=mysqli_query($link, $rights_stmt);
$rights_row=mysqli_fetch_row($rights_rslt);
$modify_leads =			$rights_row[0];
$VUselected_language =	$rights_row[1];

# check their permissions
if ($modify_leads < 1)
	{
	header ("Content-type: text/html; charset=utf-8");
	echo _QXZ("You do not have permissions to modify leads")."\n";
	exit;
	}

$stmt="SELECT full_name,modify_leads,admin_hide_lead_data,admin_hide_phone_data,user_group,user_level,ignore_group_on_search from vicidial_users where user='$PHP_AUTH_USER';";
$rslt=mysqli_query($link, $stmt);
$row=mysqli_fetch_row($rslt);
$LOGfullname =					$row[0];
$LOGmodify_leads =				$row[1];
$LOGadmin_hide_lead_data =		$row[2];
$LOGadmin_hide_phone_data =		$row[3];
$LOGuser_group =				$row[4];
$LOGuser_level =				$row[5];
$LOGignore_group_on_search =	$row[6];

$LOGallowed_listsSQL='';
$stmt="SELECT allowed_campaigns from vicidial_user_groups where user_group='$LOGuser_group';";
if ($DB) {$HTML_text.="|$stmt|\n";}
$rslt=mysqli_query($link, $stmt);
$row=mysqli_fetch_row($rslt);
$LOGallowed_campaigns =			$row[0];

if ( (!preg_match('/\-ALL/i', $LOGallowed_campaigns)) and ($LOGignore_group_on_search != '1') )
	{
	$rawLOGallowed_campaignsSQL = preg_replace("/ -/",'',$LOGallowed_campaigns);
	$rawLOGallowed_campaignsSQL = preg_replace("/ /","','",$rawLOGallowed_campaignsSQL);
	$LOGallowed_campaignsSQL = "and campaign_id IN('$rawLOGallowed_campaignsSQL')";
	$whereLOGallowed_campaignsSQL = "where campaign_id IN('$rawLOGallowed_campaignsSQL')";

	$stmt="SELECT list_id from vicidial_lists $whereLOGallowed_campaignsSQL;";
	$rslt=mysqli_query($link, $stmt);
	$lists_to_print = mysqli_num_rows($rslt);
	$o=0;
	while ($lists_to_print > $o)
		{
		$rowx=mysqli_fetch_row($rslt);
		$camp_lists .= "'$rowx[0]',";
		$o++;
		}
	$camp_lists = preg_replace('/.$/i','',$camp_lists);;
	if (strlen($camp_lists)<2) {$camp_lists="''";}
	$LOGallowed_listsSQL = "and list_id IN($camp_lists)";
	$whereLOGallowed_listsSQL = "where list_id IN($camp_lists)";
	}

#
# Show archive on first call if ShowArchive is set.
#
if(($archive_log == "0") || (!isset($archive_log))) {
	if($LOGuser_level >= 9) {
		if ($ShowArchive == 1) {
			$archive_log = "Yes";
		} else {
			$archive_log = "No";
		}
	}
}

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
$SSweb_logo='default_old';


function GetDistributorNr($LeadID) {
    global $DB, $link, $SSalt_row3_background;
    
    $return = "";
    $stmt = "SELECT * FROM `snctdialer_distributor_customernr` WHERE `lead_id` = '".$LeadID."';";
    if($DB) {
        sd_debug_log($stmt);
    }
    $rslt = mysqli_query($link, $stmt);

    if(mysqli_num_rows($rslt) > 0) {
#        $return  = "</table>";
        $return .= "<b>"._("external") . " " . _("Customer No")."</b>";
        $return .= "<TABLE style=\"background-color:#".$SSalt_row3_background."\";>";
        $return .= "<tr><th>"._("Distributor")."</th><th>"._("Customer No")."</th></tr>";
        while($row = mysqli_fetch_array($rslt, MYSQLI_BOTH)) {
            $stmt1 = "SELECT * FROM `snctdialer_distributor` WHERE `DistID` = '".$row["DistributorID"] ."';";
            if($DB) {
                sd_debug_log($stmt1);
            }
            $rslt1 = mysqli_query($link, $stmt1);
            $row1 = mysqli_fetch_array($rslt1, MYSQLI_BOTH);
            
            $return .= "<TR><TD>".$row1["Name"]."</TD><TD>".$row["DistributorCustomerNr"]."</TD></TR>";
        }
#        $return .= "</table><table  cellpadding=1 cellspacing=0>";
        $return .= "</table><br>";
    }
    return $return;
}

if ($SSadmin_screen_colors != 'default')
	{
	$stmt = "SELECT menu_background,frame_background,std_row1_background,std_row2_background,std_row3_background,std_row4_background,std_row5_background,alt_row1_background,alt_row2_background,alt_row3_background,web_logo FROM vicidial_screen_colors where colors_id='$SSadmin_screen_colors';";
	$rslt=mysqli_query($link, $stmt);
	if ($DB) {sd_debug_log($stmt);}
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
		$SSweb_logo =				$row[10];
		}
	}


if ($enable_gdpr_download_deletion>0)
	{
	$stmt="SELECT export_gdpr_leads from vicidial_users where user='$PHP_AUTH_USER' and export_gdpr_leads >= 1;";
	$rslt=mysqli_query($link, $stmt);
	$row=mysqli_fetch_row($rslt);
	$gdpr_display=$row[0];

	if ($gdpr_display>=1 && $gdpr_action && $lead_id)
		{
		$table_array=array("vicidial_list", "recording_log", "vicidial_log", "vicidial_xfer_log", "vicidial_closer_log", "vicidial_carrier_log", "vicidial_agent_log");
		$date_field_array=array("entry_date", "start_time", "call_date", "call_date", "call_date", "call_date", "event_time");
		$purge_field_array=array(
			"vicidial_list" => array("phone_code", "phone_number", "title", "first_name", "middle_initial", "last_name", "address1", "address2", "address3", "city", "state", "province", "postal_code", "country_code", "gender", "date_of_birth", "alt_phone", "email", "security_phrase", "comments"),
			"vicidial_log" => array(),
			"vicidial_xfer_log" => array(),
			"vicidial_closer_log" => array(),
			"vicidial_carrier_log" => array(),
			"vicidial_agent_log" => array(),
			"recording_log" => array("filename", "location")
		);
		$table_count=count($table_array);

		$CSV_text="";
		$HTML_text="";
		$SQL_log = "";

		if ($gdpr_action=="confirm_purge")
			{
			$archive_table_name=use_archive_table("vicidial_list");
			$mysql_stmt="(select list_id from vicidial_list where lead_id='$lead_id')";
			if ($archive_table_name!="vicidial_list") {$mysql_stmt.=" UNION (select list_id from ".$archive_table_name." where lead_id='$lead_id')";}
			$mysql_rslt=mysqli_query($link, $mysql_stmt);
			if(mysqli_num_rows($mysql_rslt)>0)
				{
				$mysql_row=mysqli_fetch_row($mysql_rslt);
				$list_id=$mysql_row[0];
				}

			for ($t=0; $t<$table_count; $t++)
				{
				$table_name=$table_array[$t];
				$archive_table_name=use_archive_table($table_name);

				if ($list_id && $table_name=="vicidial_list" && table_exists("custom_$list_id"))
					{
					array_splice($table_array, 1, 0, "custom_$list_id");
					array_splice($date_field_array, 1, 0, "lead_id");
					$custom_table_array=array("custom_$list_id" => array());
					$purge_field_array=array_merge($purge_field_array, $custom_table_array);
					$table_count++;

					$custom_stmt="SHOW COLUMNS FROM custom_".$list_id."";
					$custom_rslt=mysqli_query($link, $custom_stmt);
					while($custom_row=mysqli_fetch_row($custom_rslt))
						{
						if ($custom_row[0]!="lead_id")
							{
							array_push($purge_field_array["custom_$list_id"], $custom_row[0]);
							}
						}
					}

				if(count($purge_field_array["$table_name"])>0)
					{
					if ($table_name=="recording_log")
						{
						$ins_stmt="insert ignore into recording_log_deletion_queue(recording_id,lead_id, filename, location, date_queued) (select recording_id,lead_id, filename, location, now() from recording_log where lead_id='$lead_id') UNION (select recording_id,lead_id, filename, location, now() from recording_log_archive where lead_id='$lead_id')";
						$ins_rslt=mysqli_query($link, $ins_stmt);
						}

					$upd_clause=implode("=null, ", $purge_field_array["$table_name"])."=null ";
					$upd_stmt="update $table_name set $upd_clause where lead_id='$lead_id'";
					$upd_rslt=mysql_query($link, $upd_stmt, $link);
					$SQL_log.="$upd_stmt|";
					if ($archive_table_name!=$table_name)
						{
						$upd_stmt="update $archive_table_name set $upd_clause where lead_id='$lead_id'";
						$upd_rslt=mysqli_query($link, $upd_stmt);
						$SQL_log.="$upd_stmt|";
						}
					}
				}

			$SQL_log = addslashes($SQL_log);
			$stmt="INSERT INTO vicidial_admin_log set event_date='$NOW_TIME', user='$PHP_AUTH_USER', ip_address='$ip', event_section='LEADS', event_type='DELETE', record_id='$lead_id', event_code='GDPR PURGE LEAD DATA', event_sql=\"$SQL_log\", event_notes='';";
			if ($DB) {sd_debug_log($stmt);}
			$rslt=mysqli_query($link, $stmt);

			}

		$HTML_text.="<BR><BR>";
		$HTML_text.="<TABLE width=1000 cellspacing=1 cellpadding=5>\n";
		$HTML_text.="<tr>\n";
		$HTML_text.="\t<td align='left'><B>"._QXZ("GDPR DATA PURGE PREVIEW")."</B> <I>("._QXZ("greyed fields will be emptied").")</I>:</td>";
		$HTML_text.="\t<th><a href=\"admin_modify_lead.php?lead_id=$lead_id&gdpr_action=download\">"._QXZ("DOWNLOAD")."</a></th>";
		$HTML_text.="\t<th><a href=\"admin_modify_lead.php?lead_id=$lead_id&gdpr_action=confirm_purge\">"._QXZ("CONFIRM PURGE")."</a></th>";
		$HTML_text.="</tr>";
		$HTML_text.="</table><BR><BR>";

		for ($t=0; $t<$table_count; $t++)
			{
			$table_name=$table_array[$t];
			$archive_table_name=use_archive_table($table_name);
			$mysql_stmt="(select * from ".$table_name." where lead_id='$lead_id')";
			if ($archive_table_name!=$table_name) {$mysql_stmt.=" UNION (select * from ".$archive_table_name." where lead_id='$lead_id')";}
			$list_id=""; $HTML_header=""; $CSV_header=""; $HTML_body=""; $CSV_body="";

			$mysql_stmt.=" order by ".$date_field_array[$t]." desc";
			$mysql_rslt=mysqli_query($link, $mysql_stmt);
			if ($DB) {sd_debug_log($mysql_stmt);}
			if (mysqli_num_rows($mysql_rslt)>0)
				{
				$CSV_text.="\""._QXZ("TABLE NAME").":\",\"$table_name\"\n";
				$HTML_text.="<B>"._QXZ("TABLE NAME").": $table_name</B><BR>\n";
				$HTML_text.="<TABLE width=1000 cellspacing=1 cellpadding=5>\n";

				$j=0;
				while($row=mysqli_fetch_array($mysql_rslt,MYSQLI_ASSOC))
					{
					if ($j%2==0)
						{
						$bgcolor=$SSstd_row2_background;
						}
					else
						{
						$bgcolor=$SSstd_row3_background;
						}

					if ($j==0)
						{
						$HTML_header.="<tr>\n";
						}
					$HTML_body.="<tr>\n";
					while (list($key, $val)=each($row))
						{
						if ($key=="entry_list_id") {$list_id=$val;}
						if (in_array($key, $purge_field_array["$table_name"]) || (preg_match("/^custom_/", $table_name) && $key!="lead_id"))
							{
							$bgcolor="bgcolor='#999999'";
							$sb="<B>";
							$eb="</B>";
							}
						else
							{
							$bgcolor="bgcolor='#$SSstd_row1_background'";
							$sb="";
							$eb="";
							}
						if ($j==0)
							{
							$CSV_header.="\"".$key."\",";
							$HTML_header.="\t<td $bgcolor>$sb<font size='2'>".$key."</font>$eb</td>\n";
							}
						$CSV_body.="\"$val\",";
						$HTML_body.="\t<td $bgcolor>$sb<font size='2'>".$val."</font>$eb</td>\n";
						}
					if ($j==0)
						{
						$CSV_header=substr($CSV_header, 0, -1)."\n";
						$HTML_header.="</tr>\n";
						}
					$CSV_body=substr($CSV_body, 0, -1)."\n";
					$HTML_body.="</tr>\n";
					$j++;
					}

					$CSV_text.=$CSV_header.$CSV_body;
					$HTML_text.=$HTML_header.$HTML_body;

					$CSV_text.="\n";
					$HTML_text.="</table><BR><BR>";

				}

				if ($list_id && $table_name=="vicidial_list" && table_exists("custom_$list_id") && !in_array("custom_$list_id", $table_array))
				{
					array_splice($table_array, 1, 0, "custom_$list_id");
					array_splice($date_field_array, 1, 0, "lead_id");
					$custom_table_array=array("custom_$list_id" => array());
					$purge_field_array=array_merge($purge_field_array, $custom_table_array);
					$table_count++;
				}
			}

		if (strlen($CSV_text)>0 && $gdpr_action=="download")
		{
		    $files_to_zip=array();

			$rec_stmt="select start_time, location, filename from recording_log where lead_id='$lead_id' AND location LIKE 'http%' order by start_time asc";
			$rec_rslt=mysqli_query($link, $rec_stmt);
			while ($rec_row=mysqli_fetch_row($rec_rslt)) {
				$start_time=$rec_row[0];
				$start_date=substr($start_time, 1, 10);
				$location=$rec_row[1];
				$filename=$rec_row[2];
				preg_match("/$filename.*$/", $location, $matches);

				$location = GetRealRecordingsURL($location, $link);

				$destination_filename=$matches[0];
				set_time_limit(0);

				$fp = fopen("/tmp/$destination_filename", 'w+');
				$ch = curl_init(str_replace(" ","%20",$location));
				curl_setopt($ch, CURLOPT_TIMEOUT, 50);
				curl_setopt($ch, CURLOPT_FILE, $fp);
				curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
				curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
				curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
				curl_exec($ch);
				curl_close($ch);
				fclose($fp);

				array_push($files_to_zip, "$destination_filename");
			}

			$rec_stmt="select start_time, location, filename from recording_log_archive where lead_id='$lead_id' AND location LIKE 'http%' order by start_time asc";
			$rec_rslt=mysqli_query($link, $rec_stmt);
			while ($rec_row=mysqli_fetch_row($rec_rslt)) {
			    $start_time=$rec_row[0];
			    $start_date=substr($start_time, 1, 10);
			    $location=$rec_row[1];
			    $filename=$rec_row[2];
			    preg_match("/$filename.*$/", $location, $matches);

			    $location = GetRealRecordingsURL($location, $link);

			    $destination_filename=$matches[0];
			    set_time_limit(0);

			    $fp = fopen("/tmp/$destination_filename", 'w+');
			    $ch = curl_init(str_replace(" ","%20",$location));
			    curl_setopt($ch, CURLOPT_TIMEOUT, 50);
			    curl_setopt($ch, CURLOPT_FILE, $fp);
			    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
			    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
			    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
			    curl_exec($ch);
			    curl_close($ch);
			    fclose($fp);

			    array_push($files_to_zip, "$destination_filename");
			}

			$stmt="INSERT INTO vicidial_admin_log set event_date='$NOW_TIME', user='$PHP_AUTH_USER', ip_address='$ip', event_section='LEADS', event_type='EXPORT', record_id='$lead_id', event_code='GDPR EXPORT LEAD DATA', event_sql=\"$SQL_log\", event_notes='';";
			if ($DB) {sd_debug_log($stmt);}
			$rslt=mysqli_query($link, $stmt);


			$FILE_TIME = date("Ymd-His");
			$CSVfilename = "GDPR_export_$US$FILE_TIME.csv";
			$CSV_text=preg_replace('/^\s+/', '', $CSV_text);
			$CSV_text=preg_replace('/ +\"/', '"', $CSV_text);
			$CSV_text=preg_replace('/\" +/', '"', $CSV_text);

			array_push($files_to_zip, "$CSVfilename");
			$fp = fopen("/tmp/$CSVfilename", 'w+');
			fwrite($fp, $CSV_text);
			fclose($fp);

			$zipname = "$lead_id.zip";
			$zip = new ZipArchive;
			$zip->open($zipname, ZipArchive::CREATE|ZipArchive::OVERWRITE);
			foreach ($files_to_zip as $file) {
				$tempfile="/tmp/$file";
				if (file_exists($tempfile)) {
				    $zip->addFile($tempfile);
				}
			}
			$zip->close();

			if (!headers_sent()) {
			    header('Content-Description: File Transfer');
			    header("Pragma: public");
			    header("Expires: 0");
			    header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
			    header("Cache-Control: private",false);
			    header('Content-Type: application/zip');
			    header('Content-disposition: attachment; filename='.$zipname);
			    header('Content-Length:' . filesize($zipname));
			    header('Content-Transfer-Encoding: binary');
			    ob_clean();
			    readfile($zipname);
			    unlink($zipname);
			} else {
			    echo _("Header sent before upload");
			}

			/*
			// We'll be outputting a TXT file
			header('Content-type: application/octet-stream');

			// It will be called LIST_101_20090209-121212.txt
			header("Content-Disposition: attachment; filename=\"$CSVfilename\"");
			header('Expires: 0');
			header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
			header('Pragma: public');
			ob_clean();
			flush();

			echo "$CSV_text";
			*/

			exit;
			}
		}


	}


$label_title =				_("Title");
$label_first_name =			_("First");
$label_middle_initial =		_("MI");
$label_last_name =			_("Last");
$label_address1 =			_("Address1");
$label_address2 =			_("Address2");
$label_address3 =			_("Address3");
$label_city =				_("City");
$label_state =				_("State");
$label_province =			_("Province");
$label_postal_code =		_("Postal Code");
$label_vendor_lead_code =	_("Vendor ID");
$label_source_id =			_("Source ID");
$label_gender =				_("Gender");
$label_phone_number =		_("Phone");
$label_phone_code =			_("DialCode");
$label_alt_phone =			_("Alt. Phone");
$label_alt_phone2 =			_("Alt. Phone 2");
$label_security_phrase =	_("Show");
$label_email =				_("Email");
$label_comments =			_("Comments");
$label_BlockStatus =        _("Block status");
$label_Selection =          _("Selection");
$label_CustStatus =         _("Customer status");

### find any custom field labels
$stmt="SELECT label_title,label_first_name,label_middle_initial,label_last_name,label_address1,label_address2,label_address3,label_city,label_state,label_province,label_postal_code,label_vendor_lead_code,label_gender,label_phone_number,label_phone_code,label_alt_phone,label_security_phrase,label_email,label_comments from system_settings;";
$rslt=mysqli_query($link, $stmt);
$row=mysqli_fetch_row($rslt);
if (strlen($row[0])>0)	{$label_title =				$row[0];}
if (strlen($row[1])>0)	{$label_first_name =		$row[1];}
if (strlen($row[2])>0)	{$label_middle_initial =	$row[2];}
if (strlen($row[3])>0)	{$label_last_name =			$row[3];}
if (strlen($row[4])>0)	{$label_address1 =			$row[4];}
if (strlen($row[5])>0)	{$label_address2 =			$row[5];}
if (strlen($row[6])>0)	{$label_address3 =			$row[6];}
if (strlen($row[7])>0)	{$label_city =				$row[7];}
if (strlen($row[8])>0)	{$label_state =				$row[8];}
if (strlen($row[9])>0)	{$label_province =			$row[9];}
if (strlen($row[10])>0) {$label_postal_code =		$row[10];}
if (strlen($row[11])>0) {$label_vendor_lead_code =	$row[11];}
if (strlen($row[12])>0) {$label_gender =			$row[12];}
if (strlen($row[13])>0) {$label_phone_number =		$row[13];}
if (strlen($row[14])>0) {$label_phone_code =		$row[14];}
if (strlen($row[15])>0) {$label_alt_phone =			$row[15];}
if (strlen($row[16])>0) {$label_security_phrase =	$row[16];}
if (strlen($row[17])>0) {$label_email =				$row[17];}
if (strlen($row[18])>0) {$label_comments =			$row[18];}


##### BEGIN vicidial_list FIELD LENGTH LOOKUP #####
$MAXvendor_lead_code =		'20';
$MAXsource_id =				'50';
$MAXphone_code =			'10';
$MAXphone_number =			'18';
$MAXtitle =					'4';
$MAXfirst_name =			'30';
$MAXmiddle_initial =		'1';
$MAXlast_name =				'30';
$MAXaddress1 =				'100';
$MAXhousenr1 =				'20';
$MAXaddress2 =				'100';
$MAXaddress3 =				'100';
$MAXcity =					'50';
$MAXstate =					'2';
$MAXprovince =				'50';
$MAXpostal_code =			'10';
$MAXalt_phone =				'12';
$MAXemail =					'70';
$MAXsecurity_phrase =		'100';
$MAXcountry_code =			'3';
$MAXowner =					'20';

$stmt = "SHOW COLUMNS FROM vicidial_list;";
$rslt=mysqli_query($link, $stmt);
if ($DB) {sd_debug_log($stmt);}
$scvl_ct = mysqli_num_rows($rslt);
$s=0;
while ($scvl_ct > $s)
	{
	$row=mysqli_fetch_row($rslt);
	$vl_field =	$row[0];
	$vl_type = preg_replace("/[^0-9]/",'',$row[1]);
	if (strlen($vl_type) > 0)
		{
		if ( ($vl_field == 'vendor_lead_code') and ($MAXvendor_lead_code != $vl_type) )
			{$MAXvendor_lead_code = $vl_type;}
		if ( ($vl_field == 'source_id') and ($MAXsource_id != $vl_type) )
			{$MAXsource_id = $vl_type;}
		if ( ($vl_field == 'phone_code') and ($MAXphone_code != $vl_type) )
			{$MAXphone_code = $vl_type;}
		if ( ($vl_field == 'phone_number') and ($MAXphone_number != $vl_type) )
			{$MAXphone_number = $vl_type;}
		if ( ($vl_field == 'title') and ($MAXtitle != $vl_type) )
			{$MAXtitle = $vl_type;}
		if ( ($vl_field == 'first_name') and ($MAXfirst_name != $vl_type) )
			{$MAXfirst_name = $vl_type;}
		if ( ($vl_field == 'middle_initial') and ($MAXmiddle_initial != $vl_type) )
			{$MAXmiddle_initial = $vl_type;}
		if ( ($vl_field == 'last_name') and ($MAXlast_name != $vl_type) )
			{$MAXlast_name = $vl_type;}
		if ( ($vl_field == 'address1') and ($MAXaddress1 != $vl_type) )
		    {$MAXaddress1 = $vl_type;}
		if ( ($vl_field == 'housenr1') and ($MAXhousenr1  != $vl_type) )
		    {$MAXhousenr1 = $vl_type;}
		if ( ($vl_field == 'address2') and ($MAXaddress2 != $vl_type) )
			{$MAXaddress2 = $vl_type;}
		if ( ($vl_field == 'address3') and ($MAXaddress3 != $vl_type) )
			{$MAXaddress3 = $vl_type;}
		if ( ($vl_field == 'city') and ($MAXcity != $vl_type) )
			{$MAXcity = $vl_type;}
		if ( ($vl_field == 'state') and ($MAXstate != $vl_type) )
			{$MAXstate = $vl_type;}
		if ( ($vl_field == 'province') and ($MAXprovince != $vl_type) )
			{$MAXprovince = $vl_type;}
		if ( ($vl_field == 'postal_code') and ($MAXpostal_code != $vl_type) )
			{$MAXpostal_code = $vl_type;}
		if ( ($vl_field == 'alt_phone') and ($MAXalt_phone != $vl_type) )
			{$MAXalt_phone = $vl_type;}
		if ( ($vl_field == 'email') and ($MAXemail != $vl_type) )
			{$MAXemail = $vl_type;}
		if ( ($vl_field == 'security_phrase') and ($MAXsecurity_phrase != $vl_type) )
			{$MAXsecurity_phrase = $vl_type;}
		if ( ($vl_field == 'country_code') and ($MAXcountry_code != $vl_type) )
			{$MAXcountry_code = $vl_type;}
		if ( ($vl_field == 'owner') and ($MAXowner != $vl_type) )
			{$MAXowner = $vl_type;}
		}
	$s++;
	}
##### END vicidial_list FIELD LENGTH LOOKUP #####

### find out if status(dispo) is a scheduled callback status
$scheduled_callback='';
$stmt="SELECT scheduled_callback from vicidial_statuses where status='$dispo';";
$rslt=mysqli_query($link, $stmt);
$scb_count_to_print = mysqli_num_rows($rslt);
if ($scb_count_to_print > 0)
	{
	$row=mysqli_fetch_row($rslt);
	if (strlen($row[0])>0)	{$scheduled_callback =	$row[0];}
	}
$stmt="SELECT scheduled_callback from vicidial_campaign_statuses where status='$dispo';";
$rslt=mysqli_query($link, $stmt);
$scb_count_to_print = mysqli_num_rows($rslt);
if ($scb_count_to_print > 0)
	{
	$row=mysqli_fetch_row($rslt);
	if (strlen($row[0])>0)	{$scheduled_callback =	$row[0];}
	}

$search_archived_data='';
if ($archive_log == 'Yes') {$search_archived_data='checked';}

$vdc_form_display = 'vdc_form_display.php';
if (preg_match("/cf_encrypt/",$active_modules))
	{$vdc_form_display = 'vdc_form_display_encrypt.php';}

header ("Content-type: text/html; charset=utf-8");

echo "<html>\n";
echo "<head>\n";
echo "<META HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=utf-8\">\n";
echo "<TITLE>"._QXZ("Modify Lead")."</TITLE>\n";
?>
<STYLE type="text/css">
<!--
body
	{
    font-family: HELVETICA;
	}

.form_field
	{
	font-family: Helvetica;
	font-size: 10px;
	margin-bottom: 3px;
	padding: 2px;
	border: solid 1px;
	}

-->
</STYLE>
<?php
echo "</HEAD><BODY BGCOLOR=white marginheight=0 marginwidth=0 leftmargin=0 topmargin=0>\n";
echo "<script language=\"JavaScript\" src=\"calendar_db.js\"></script>\n";
echo "<script language=\"JavaScript\">";
echo "var user = '$PHP_AUTH_USER';\n";
echo "var pass = '$PHP_AUTH_PW';</script>\n";
?>
<span style="position:absolute;left:500px;top:30px;z-index:50;visibility:hidden;" id="list_log_span">
</span>
<script language="JavaScript">
function UpdateCallback(callback_id) {
	var apt_date_field="appointment_date_"+callback_id;
	var apt_hour_field="appointment_hour_"+callback_id;
	var apt_min_field="appointment_min_"+callback_id;
	var cbstatus_field="CBstatus_"+callback_id;
	var cbuser_field="CBuser_"+callback_id;
	var comments_field="comments_"+callback_id;
	var recipient_field="CBchangeRecipient_"+callback_id;

	var appointment_date=document.getElementById(apt_date_field).value;
	var e = document.getElementById(apt_hour_field);
	var appointment_hour = e.options[e.selectedIndex].text;
	var e = document.getElementById(apt_min_field);
	var appointment_min = e.options[e.selectedIndex].text;
	var CBstatus=document.getElementById(cbstatus_field).value;
	var CBuser=document.getElementById(cbuser_field).value;
	var recipientField=document.getElementsByName(recipient_field);


    for (var i = 0; i < recipientField.length; i++) {
        var button = recipientField[i];
        if (button.checked) {
            var recipient=button.value;
        }
    }

	if(recipient=="A") {
		var CBchangeUSERtoANY="YES";
		var CBchangeANYtoUSER="";
	} else if(recipient=="U") {
		var CBchangeUSERtoANY="";
		var CBchangeANYtoUSER="YES";
	}

	var appointment_time = appointment_hour + ":" + appointment_min + ":00";

	var comments=encodeURIComponent(document.getElementById(comments_field).value);

	document.getElementById('vsn').action="<?php echo $PHP_SELF; ?>?appointment_date="+appointment_date+"&appointment_time="+appointment_time+"&CBstatus="+CBstatus+"&CBchangeUSERtoANY="+CBchangeUSERtoANY+"&CBchangeANYtoUSER="+CBchangeANYtoUSER+"&CBuser="+CBuser+"&comments="+comments+"&callback_id="+callback_id;
	document.vsn.submit();

}

mouseY=0;
function getMousePos(event) {
	mouseY=event.pageY;
}
document.addEventListener("click", getMousePos);

function close_chooser() {
	document.getElementById("list_log_span").style.visibility = 'hidden';
	document.getElementById("list_log_span").innerHTML = '';
}

function launch_list_log(LeadID) {

	var h = window.innerHeight;
	var vposition=mouseY;

	var listlogURL = "./non_agent_api.php";
	var listlogQuery = "source=admin&function=lead_log_list&user=" + user + "&pass=" + pass + "&format=selectframe&lead_id=" + LeadID;
	var Iframe_content = '<IFRAME SRC="' + listlogURL + '?' + listlogQuery + '"  style="width:740;height:440;background-color:yellow;" scrolling="NO" frameborder="0" allowtransparency="false" id="list_log_frame" name="list_log_frame" width="740" height="460" STYLE="z-index:2"> </IFRAME>';

	document.getElementById("list_log_span").style.position = "absolute";
	document.getElementById("list_log_span").style.left = "220px";
	document.getElementById("list_log_span").style.top = vposition + "px";
	document.getElementById("list_log_span").style.visibility = 'visible';
	document.getElementById("list_log_span").innerHTML = Iframe_content;
}

<?php

if ( ($CIDdisplay == "Yes") and ($SSsip_event_logging > 0) )
	{
	echo "</script>\n";
	echo "<div id='DetailDisplayDiv' style='position:absolute; top:0; left:0; z-index:20; background-color:white display:none;'></div>\n";
	echo "<script language=\"JavaScript\">\n";
	echo "mouseY=0;\n";
	echo "function getMousePos(event) {mouseY=event.pageY;}\n";
	echo "document.addEventListener(\"click\", getMousePos);\n";
	echo "// Detect if the browser is IE or not.\n";
	echo "// If it is not IE, we assume that the browser is NS.\n";
	echo "var IE = document.all?true:false\n";
	echo "// If NS -- that is, !IE -- then set up for mouse capture\n";
	echo "if (!IE) document.captureEvents(Event.MOUSEMOVE)\n";
	echo "\n";
	echo "function ClearAndHideDetailDiv() {\n";
	echo "	document.getElementById(\"DetailDisplayDiv\").innerHTML=\"\";\n";
	echo "	document.getElementById(\"DetailDisplayDiv\").style.display=\"none\";\n";
	echo "}\n";
	echo "function ShowCallDetail(e, call_id, color) \n";
	echo "	{\n";
	echo "	document.getElementById(\"DetailDisplayDiv\").innerHTML=\"\";\n";
	echo "	if (IE) { // grab the x-y pos.s if browser is IE\n";
	echo "		tempX = event.clientX + document.body.scrollLeft+250\n";
	echo "		tempY = event.clientY + document.body.scrollTop\n";
	echo "	} else {  // grab the x-y pos.s if browser is NS\n";
	echo "		tempX = e.pageX\n";
	echo "		tempY = e.pageY\n";
	echo "	}  \n";
	echo "	// catch possible negative values in NS4\n";
	echo "	if (tempX < 0){tempX = 0}\n";
	echo "	if (tempY < 0){tempY = 0}  \n";
	echo "	// show the position values in the form named Show\n";
	echo "	// in the text fields named MouseX and MouseY\n";
	echo "	tempX-=400;\n";
	echo "	tempY+=10;\n";
	echo "	document.getElementById(\"DetailDisplayDiv\").style.display=\"block\";\n";
	echo "	document.getElementById(\"DetailDisplayDiv\").style.left = tempX + \"px\";\n";
	echo "	document.getElementById(\"DetailDisplayDiv\").style.top = tempY + \"px\";\n";
	#echo "  alert(tempX + '|' + tempY);\n";
	echo "	var DetailVerbiage = null;\n";
	echo "	var xmlhttp=false;\n";
	echo "	/*@cc_on @*/\n";
	echo "	/*@if (@_jscript_version >= 5)\n";
	echo "	// JScript gives us Conditional compilation, we can cope with old IE versions.\n";
	echo "	// and security blocked creation of the objects.\n";
	echo "	 try {\n";
	echo "	  xmlhttp = new ActiveXObject(\"Msxml2.XMLHTTP\");\n";
	echo "	 } catch (e) {\n";
	echo "	  try {\n";
	echo "	   xmlhttp = new ActiveXObject(\"Microsoft.XMLHTTP\");\n";
	echo "	  } catch (E) {\n";
	echo "	   xmlhttp = false;\n";
	echo "	  }\n";
	echo "	 }\n";
	echo "	@end @*/\n";
	echo "	if (!xmlhttp && typeof XMLHttpRequest!='undefined')\n";
	echo "		{\n";
	echo "		xmlhttp = new XMLHttpRequest();\n";
	echo "		}\n";
	echo "	if (xmlhttp) \n";
	echo "		{ \n";
	echo "		detail_query = \"&search_archived_data=$search_archived_data&stage=\" + call_id + \"&color=\" + color;\n";
	echo "		xmlhttp.open('POST', 'AST_SIP_event_report.php');\n";
	echo "		xmlhttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded; charset=UTF-8');\n";
	echo "		xmlhttp.send(detail_query); \n";
	echo "		xmlhttp.onreadystatechange = function() \n";
	echo "			{ \n";
	echo "			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) \n";
	echo "				{\n";
	echo "				DetailVerbiage = xmlhttp.responseText;\n";
	echo "				document.getElementById(\"DetailDisplayDiv\").innerHTML=DetailVerbiage;\n";
	echo "				}\n";
	echo "			}\n";
	echo "		delete xmlhttp;\n";
	echo "		}\n";
	echo "	}\n";
	}
echo "</script>\n";
echo "<link rel=\"stylesheet\" href=\"calendar.css\">\n";
echo "<span style=\"position:absolute;left:0px;top:0px;z-index:20;\" id=admin_header>";

$short_header=1;
$ADD==1212121212121212121212121212121212;
require("admin_header.php");

echo "</span>\n";

if ($gdpr_display==2 && preg_match("/purge$/", $gdpr_action))
	{
	echo $HTML_text;
	echo "</body></html>";
	exit;
	}

echo "<span style=\"position:absolute;left:3px;top:30px;z-index:19;\" id=agent_status_stats>\n";

### BEGIN - Add a new lead in the system ###
if ($lead_id == 'NEW')
	{
	$secX = date("U");
	$hour = date("H");
	$min = date("i");
	$sec = date("s");
	$mon = date("m");
	$mday = date("d");
	$year = date("Y");
	$isdst = date("I");
	$Shour = date("H");
	$Smin = date("i");
	$Ssec = date("s");
	$Smon = date("m");
	$Smday = date("d");
	$Syear = date("Y");

	### Grab Server GMT value from the database
	$stmt="SELECT local_gmt FROM servers where active='Y' limit 1;";
	$rslt=mysqli_query($link, $stmt);
	$gmt_recs = mysqli_num_rows($rslt);
	if ($gmt_recs > 0)
		{
		$row=mysqli_fetch_row($rslt);
		$DBSERVER_GMT		=		$row[0];
		if (strlen($DBSERVER_GMT)>0)	{$SERVER_GMT = $DBSERVER_GMT;}
		if ($isdst) {$SERVER_GMT++;}
		}
	else
		{
		$SERVER_GMT = date("O");
		$SERVER_GMT = preg_replace("/\+/i","",$SERVER_GMT);
		$SERVER_GMT = ($SERVER_GMT + 0);
		$SERVER_GMT = ($SERVER_GMT / 100);
		}

	$LOCAL_GMT_OFF = $SERVER_GMT;
	$LOCAL_GMT_OFF_STD = $SERVER_GMT;

	$USarea = substr($phone_number, 0, 3);
	$USprefix = 	substr($phone_number, 3, 1);
	$postalgmt='';

	$gmt_offset = lookup_gmt($phone_code,$USarea,$state,$LOCAL_GMT_OFF_STD,$Shour,$Smin,$Ssec,$Smon,$Smday,$Syear,$postalgmt,$postal_code,$owner,$USprefix);
	$comments = preg_replace("/\n/",'!N',$comments);
	$comments = preg_replace("/\r/",'',$comments);

	$list_valid=0;
	$stmt="SELECT count(*) from vicidial_lists where list_id='" . mysqli_real_escape_string($link, $list_id) . "' $LOGallowed_campaignsSQL;";
	$rslt=mysqli_query($link, $stmt);
	$list_to_print = mysqli_num_rows($rslt);
	if ($list_to_print > 0)
		{
		$rowx=mysqli_fetch_row($rslt);
		$list_valid = $rowx[0];
		}

	if ( ($list_valid > 0) or (preg_match('/\-ALL/i', $LOGallowed_campaigns)) )
		{
		$source_idSQL='';
		if ($SSsource_id_display > 0)
			{$source_idSQL = ",source_id='" . mysqli_real_escape_string($link, $source_id) . "'";}
			$stmt="INSERT INTO vicidial_list set status='" . mysqli_real_escape_string($link, $status) . "',title='" . mysqli_real_escape_string($link, $title) . "',first_name='" . mysqli_real_escape_string($link, $first_name) . "',middle_initial='" . mysqli_real_escape_string($link, $middle_initial) . "',last_name='" . mysqli_real_escape_string($link, $last_name) . "',address1='" . mysqli_real_escape_string($link, $address1) . "',housenr1='" . mysqli_real_escape_string($link, $housenr1) . "',address2='" . mysqli_real_escape_string($link, $address2) . "',address3='" . mysqli_real_escape_string($link, $address3) . "',city='" . mysqli_real_escape_string($link, $city) . "',state='" . mysqli_real_escape_string($link, $state) . "',province='" . mysqli_real_escape_string($link, $province) . "',postal_code='" . mysqli_real_escape_string($link, $postal_code) . "',country_code='" . mysqli_real_escape_string($link, $country_code) . "',alt_phone='" . mysqli_real_escape_string($link, $alt_phone) . "',phone_number='$phone_number',phone_code='$phone_code',email='" . mysqli_real_escape_string($link, $email) . "',security_phrase='" . mysqli_real_escape_string($link, $security) . "',comments='" . mysqli_real_escape_string($link, $comments) . "',rank='" . mysqli_real_escape_string($link, $rank) . "',owner='" . mysqli_real_escape_string($link, $owner) . "',vendor_lead_code='" . mysqli_real_escape_string($link, $vendor_id) . "'$source_idSQL, list_id='" . mysqli_real_escape_string($link, $list_id) . "',date_of_birth='" . mysqli_real_escape_string($link, $date_of_birth) . "',gmt_offset_now='$gmt_offset',entry_date=NOW();";
		if ($DB) {sd_debug_log($stmt);}
		$rslt=mysqli_query($link, $stmt);
		$affected_rows = mysqli_affected_rows($link);
		if ($affected_rows > 0)
			{
			$lead_id = mysqli_insert_id($link);
			echo _QXZ("Lead has been added").": $lead_id ($gmt_offset)<BR><BR>\n";
			$end_call=0;
			}
		else
			{echo _QXZ("ERROR: Lead not added, please go back and look at what you entered")."<BR><BR>\n";}
		}
	else
		{
		echo _QXZ("you do not have permission to add this lead")." $list_id &nbsp; &nbsp; &nbsp; $NOW_TIME\n<BR><BR>\n";
		}
	### END - Add a new lead in the system ###
	}
else
	{
	$stmt="SELECT count(*) from $vl_table where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "'";
	$rslt=mysqli_query($link, $stmt);
	if ($DB) {sd_debug_log($stmt);}
	$row=mysqli_fetch_row($rslt);
	$lead_exists =	$row[0];

	$stmt="SELECT count(*) from $vl_table where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' $LOGallowed_listsSQL";
	$rslt=mysqli_query($link, $stmt);
	if ($DB) {sd_debug_log($stmt);}
	$row=mysqli_fetch_row($rslt);
	$lead_count =	$row[0];
	if ( ($lead_exists > 0) and ($lead_count < 1) )
		{
		echo _QXZ("lead does not exist")."\n";
		exit;
		}
	}

if (strlen($lead_id) < 1)
	{$lead_id = 'NEW';}

if ($end_call > 0)
	{
	$comments = preg_replace("/\n/",'!N',$comments);
	$comments = preg_replace("/\r/",'',$comments);

	$list_valid=0;
	$stmt="SELECT count(*) from vicidial_lists where list_id='" . mysqli_real_escape_string($link, $list_id) . "' $LOGallowed_campaignsSQL;";
	$rslt=mysqli_query($link, $stmt);
	$list_to_print = mysqli_num_rows($rslt);
	if ($list_to_print > 0)
		{
		$rowx=mysqli_fetch_row($rslt);
		$list_valid = $rowx[0];
		}

	if ( ($list_valid > 0) or (preg_match('/\-ALL/i', $LOGallowed_campaigns)) )
		{
		$diff_orig=''; $diff_new='';
		# gather existing lead data to store for admin log diff
		$stmt="SELECT lead_id,entry_date,modify_date,status,user,vendor_lead_code,source_id,list_id,gmt_offset_now,called_since_last_reset,phone_code,phone_number,title,first_name,middle_initial,last_name,address1,address2,address3,city,state,province,postal_code,country_code,gender,date_of_birth,alt_phone,email,security_phrase,comments,called_count,last_local_call_time,rank,owner,entry_list_id from $vl_table where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' $LOGallowed_listsSQL";
		$rslt=mysqli_query($link, $stmt);
		$diff_to_print = mysqli_num_rows($rslt);
		if ($DB) {sd_debug_log("$diff_to_print|$stmt");}
		if ($diff_to_print > 0)
			{
			$row=mysqli_fetch_row($rslt);
			$diff_orig = "lead_id=$row[0]|entry_date=$row[1]|modify_date=$row[2]|status=$row[3]|user=$row[4]|vendor_lead_code=$row[5]|source_id=$row[6]|list_id=$row[7]|gmt_offset_now=$row[8]|called_since_last_reset=$row[9]|phone_code=$row[10]|phone_number=$row[11]|title=$row[12]|first_name=$row[13]|middle_initial=$row[14]|last_name=$row[15]|address1=$row[16]|address2=$row[17]|address3=$row[18]|city=$row[19]|state=$row[20]|province=$row[21]|postal_code=$row[22]|country_code=$row[23]|gender=$row[24]|date_of_birth=$row[25]|alt_phone=$row[26]|email=$row[27]|security_phrase=$row[28]|comments=$row[29]|called_count=$row[30]|last_local_call_time=$row[31]|rank=$row[32]|owner=$row[33]|entry_list_id=$row[34]|";
			}

		$source_idSQL='';
		if ($SSsource_id_display > 0)
			{$source_idSQL = ",source_id='" . mysqli_real_escape_string($link, $source_id) . "'";}
		### update the lead record in the vicidial_list table
			$stmtA  = "UPDATE $vl_table set status='" . mysqli_real_escape_string($link, $status) . "', ";
            $stmtA .= "title='" . mysqli_real_escape_string($link, $title) . "', ";
            $stmtA .= "first_name='" . mysqli_real_escape_string($link, $first_name) . "', ";
            $stmtA .= "middle_initial='" . mysqli_real_escape_string($link, $middle_initial) . "', ";
            $stmtA .= "last_name='" . mysqli_real_escape_string($link, $last_name) . "', ";
            $stmtA .= "address1='" . mysqli_real_escape_string($link, $address1) . "', ";
            $stmtA .= "housenr1='" . mysqli_real_escape_string($link, $housenr1) . "', ";
            $stmtA .= "address2='" . mysqli_real_escape_string($link, $address2) . "', ";
            $stmtA .= "address3='" . mysqli_real_escape_string($link, $address3) . "', ";
            $stmtA .= "city='" . mysqli_real_escape_string($link, $city) . "', ";
            $stmtA .= "state='" . mysqli_real_escape_string($link, $state) . "', ";
            $stmtA .= "province='" . mysqli_real_escape_string($link, $province) . "', ";
            $stmtA .= "postal_code='" . mysqli_real_escape_string($link, $postal_code) . "', ";
            $stmtA .= "country_code='" . mysqli_real_escape_string($link, $country_code) . "', ";
            $stmtA .= "alt_phone='" . mysqli_real_escape_string($link, $alt_phone) . "', ";
            $stmtA .= "phone_number='$phone_number', ";
            $stmtA .= "phone_code='$phone_code', ";
            $stmtA .= "phone_code_alt1='$phone_code_alt1', ";
            $stmtA .= "phone_code_alt2='$phone_code_alt2', ";
            $stmtA .= "phone_code_alt3='$phone_code_alt3', ";
            $stmtA .= "email='" . mysqli_real_escape_string($link, $email) . "', ";
            $stmtA .= "owner='" . mysqli_real_escape_string($link, $owner) . "', ";
            $stmtA .= "security_phrase='" . mysqli_real_escape_string($link, $security) . "', ";
            $stmtA .= "comments='" . mysqli_real_escape_string($link, $comments) . "', ";
            $stmtA .= "rank='" . mysqli_real_escape_string($link, $rank) . "', ";
            $stmtA .= "vendor_lead_code='" . mysqli_real_escape_string($link, $vendor_id) ." ";
            $stmtA .= "'$source_idSQL, ";
            $stmtA .= "block_status='" .$block_status . "', "; 
            $stmtA .= "date_of_birth='" . mysqli_real_escape_string($link, $date_of_birth) . "', ";
            $stmtA .= "selection='" . mysqli_real_escape_string($link, $selection) . "', ";
            $stmtA .= "customer_status='" .$customer_status . "' ";
            $stmtA .= "where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "'";
		sd_debug_log($stmt);
		if ($DB) {sd_debug_log($stmt);}
		$rslt=mysqli_query($link, $stmtA);

		# gather new lead data to store for admin log diff
		$stmt="SELECT lead_id,entry_date,modify_date,status,user,vendor_lead_code,source_id,list_id,gmt_offset_now,called_since_last_reset,phone_code,phone_number,title,first_name,middle_initial,last_name,address1,housenr1,address2,address3,city,state,province,postal_code,country_code,gender,date_of_birth,alt_phone,email,security_phrase,comments,called_count,last_local_call_time,rank,owner,entry_list_id from $vl_table where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' $LOGallowed_listsSQL";
		$rslt=mysqli_query($link, $stmt);
		$diff_to_print = mysqli_num_rows($rslt);
		if ($DB) {sd_debug_log("$diff_to_print|$stmt");}
		if ($diff_to_print > 0)
			{
			$row=mysqli_fetch_row($rslt);
			$diff_new = "lead_id=$row[0]|entry_date=$row[1]|modify_date=$row[2]|status=$row[3]|user=$row[4]|vendor_lead_code=$row[5]|source_id=$row[6]|list_id=$row[7]|gmt_offset_now=$row[8]|called_since_last_reset=$row[9]|phone_code=$row[10]|phone_number=$row[11]|title=$row[12]|first_name=$row[13]|middle_initial=$row[14]|last_name=$row[15]|address1=$row[16]|address2=$row[17]|address3=$row[18]|city=$row[19]|state=$row[20]|province=$row[21]|postal_code=$row[22]|country_code=$row[23]|gender=$row[24]|date_of_birth=$row[25]|alt_phone=$row[26]|email=$row[27]|security_phrase=$row[28]|comments=$row[29]|called_count=$row[30]|last_local_call_time=$row[31]|rank=$row[32]|owner=$row[33]|entry_list_id=$row[34]|";
			}

		echo _QXZ("information modified")."<BR><BR>\n";
		echo "<a href=\"$PHP_SELF?lead_id=$lead_id&DB=$DB&archive_search=$archive_search&archive_log=$archive_log\">"._QXZ("Go back to the lead modification page")."</a><BR><BR>\n";
		echo "<form><input type=button value=\""._QXZ("Close This Window")."\" onClick=\"javascript:window.close();\"></form>\n";

		if ( ($dispo != $status) and ($dispo == 'CBHOLD') )
			{
			### inactivate vicidial_callbacks record for this lead
			$stmtB="UPDATE vicidial_callbacks set status='INACTIVE' where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' and status='ACTIVE';";
			if ($DB) {sd_debug_log($stmtB);}
			$rslt=mysqli_query($link, $stmtB);

			echo "<BR>"._QXZ("vicidial_callback record inactivated").": $lead_id<BR>\n";
			}
		if ( ($dispo != $status) and ( ($dispo == 'CALLBK') or ($scheduled_callback == 'Y') ) )
			{
			### inactivate vicidial_callbacks record for this lead
			$stmtC="UPDATE vicidial_callbacks set status='INACTIVE' where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' and status IN('ACTIVE','LIVE');";
			if ($DB) {sd_debug_log($stmtC);}
			$rslt=mysqli_query($link, $stmtC);

			echo "<BR>"._QXZ("vicidial_callback record inactivated").": $lead_id<BR>\n";
			}

		if ( ($dispo != $status) and ($status == 'CBHOLD') )
			{
			### find any vicidial_callback records for this lead
			$stmtD="SELECT callback_id from vicidial_callbacks where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' and status IN('ACTIVE','LIVE') order by callback_id desc LIMIT 1;";
			if ($DB) {sd_debug_log($stmtD);}
			$rslt=mysqli_query($link, $stmtD);
			$CBM_to_print = mysqli_num_rows($rslt);
			if ($CBM_to_print > 0)
				{
				$rowx=mysqli_fetch_row($rslt);
				$callback_id = $rowx[0];
				}
			else
				{
				$tomorrow = date("Y-m-d", mktime(date("H"),date("i"),date("s"),date("m"),date("d"),date("Y")));
				$cb_hour = date("H:i:s", mktime(date("H") + 1,0,0,0,0,0));
				$CLEAN_campaign_id = mysqli_real_escape_string($link, $campaign_id);
				$CLEAN_campaign_id = preg_replace("/'|\"|\\\\|;/","",$CLEAN_campaign_id);
				$CLEAN_campaign_id = preg_replace('/[^-_0-9a-zA-Z]/','',$CLEAN_campaign_id);

				if (strlen($CLEAN_campaign_id)<1)
					{
					$stmt="SELECT campaign_id from vicidial_lists where list_id='" . mysqli_real_escape_string($link, $list_id) . "';";
					$rslt=mysqli_query($link, $stmt);
					$cidvl_count_to_print = mysqli_num_rows($rslt);
					if ($cidvl_count_to_print > 0)
						{
						$row=mysqli_fetch_row($rslt);
						if (strlen($row[0])>0)	{$CLEAN_campaign_id =	$row[0];}
						}
					}

				$stmtE="INSERT INTO vicidial_callbacks SET lead_id='" . mysqli_real_escape_string($link, $lead_id) . "',recipient='USERONLY',status='ACTIVE',user='$PHP_AUTH_USER',user_group='ADMIN',list_id='" . mysqli_real_escape_string($link, $list_id) . "',callback_time='$tomorrow $cb_hour',entry_time='$NOW_TIME',comments='',campaign_id='$CLEAN_campaign_id';";
				if ($DB) {sd_debug_log($stmtE);}
				$rslt=mysqli_query($link, $stmtE);

				echo "<BR>"._QXZ("Scheduled Callback added").": $lead_id - $phone_number<BR>\n";
				}
			}


		if ( ($dispo != $status) and ($status == 'DNC') )
			{
			### add lead to the internal DNC list
			$stmtF="INSERT INTO vicidial_dnc (phone_number) values('" . mysqli_real_escape_string($link, $phone_number) . "');";
			if ($DB) {sd_debug_log($stmtF);}
			$rslt=mysqli_query($link, $stmtF);

			echo "<BR>"._QXZ("Lead added to DNC List").": $lead_id - $phone_number<BR>\n";
			}
		### update last record in vicidial_log table
		   if (($dispo != $status) and ($modify_logs > 0))
			{
			$stmtG="UPDATE vicidial_log set status='" . mysqli_real_escape_string($link, $status) . "' where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' order by call_date desc limit 1";
			if ($DB) {sd_debug_log($stmtG);}
			$rslt=mysqli_query($link, $stmtG);
			}

		### update last record in vicidial_closer_log table
		   if (($dispo != $status) and ($modify_closer_logs > 0))
			{
			$stmtH="UPDATE vicidial_closer_log set status='" . mysqli_real_escape_string($link, $status) . "' where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' order by closecallid desc limit 1";
			if ($DB) {sd_debug_log($stmtH);}
			$rslt=mysqli_query($link, $stmtH);
			}

		### update last record in vicidial_agent_log table
		   if (($dispo != $status) and ($modify_agent_logs > 0))
			{
			$stmtI="UPDATE vicidial_agent_log set status='" . mysqli_real_escape_string($link, $status) . "' where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' order by agent_log_id desc limit 1";
			if ($DB) {sd_debug_log($stmtI);}
			$rslt=mysqli_query($link, $stmtI);
			}

		if ($add_closer_record > 0)
			{
			$comments = preg_replace("/\n/",'!N',$comments);
			$comments = preg_replace("/\r/",'',$comments);
			### insert a NEW record to the vicidial_closer_log table
			$stmtJ="INSERT INTO vicidial_closer_log (lead_id,list_id,campaign_id,call_date,start_epoch,end_epoch,length_in_sec,status,phone_code,phone_number,user,comments,processed) values('" . mysqli_real_escape_string($link, $lead_id) . "','" . mysqli_real_escape_string($link, $list_id) . "','" . mysqli_real_escape_string($link, $campaign_id) . "','" . mysqli_real_escape_string($link, $parked_time) . "','$NOW_TIME','$STARTtime','1','" . mysqli_real_escape_string($link, $status) . "','" . mysqli_real_escape_string($link, $phone_code) . "','" . mysqli_real_escape_string($link, $phone_number) . "','$PHP_AUTH_USER','" . mysqli_real_escape_string($link, $comments) . "','Y')";
			if ($DB) {sd_debug_log($stmtJ);}
			$rslt=mysqli_query($link, $stmtJ);
			}

		### LOG INSERTION Admin Log Table ###
		$SQL_log = "$stmtA|$stmtB|$stmtC|$stmtE|$stmtF|$stmtG|$stmtH|$stmtI|$stmtJ|";
		$SQL_log = preg_replace('/;/', '', $SQL_log);
		$SQL_log = addslashes($SQL_log);
		$stmt="INSERT INTO vicidial_admin_log set event_date='$NOW_TIME', user='$PHP_AUTH_USER', ip_address='$ip', event_section='LEADS', event_type='MODIFY', record_id='$lead_id', event_code='ADMIN MODIFY LEAD', event_sql=\"$SQL_log\", event_notes=\"".$diff_orig."---ORIG---NEW---".$diff_new."\";";
		if ($DB) {sd_debug_log($stmt);}
		$rslt=mysqli_query($link, $stmt);
		}
	else
		{
		echo _QXZ("you do not have permission to modify this lead")." $lead_id &nbsp; &nbsp; &nbsp; $list_id &nbsp; &nbsp; &nbsp; $NOW_TIME\n<BR><BR>\n";
		}
	}
else
	{
	if ($CBchangeUSERtoANY == 'YES')
		{
		### set vicidial_callbacks record to an ANYONE callback for this lead
		$stmtK="UPDATE vicidial_callbacks set recipient='ANYONE' where callback_id='" . mysqli_real_escape_string($link, $callback_id) . "';";
		if ($DB) {sd_debug_log($stmtK);}
		$rslt=mysqli_query($link, $stmtK);

		echo "<BR>"._QXZ("vicidial_callback record changed to ANYONE")."<BR>\n";
		}
	if ($CBchangeANYtoUSER == 'YES')
		{
		### set vicidial_callbacks record to an USERONLY callback for this lead
		$stmtM="UPDATE vicidial_callbacks set user='" . mysqli_real_escape_string($link, $CBuser) . "',recipient='USERONLY' where callback_id='" . mysqli_real_escape_string($link, $callback_id) . "';";
		if ($DB) {sd_debug_log($stmtM);}
		$rslt=mysqli_query($link, $stmtM);

		echo "<BR>"._QXZ("vicidial_callback record changed to USERONLY, user").": $CBuser<BR>\n";
		}

	if ($CBchangeDATE == 'YES')
		{
		$comments = preg_replace("/\n/",' ',$comments);
		$comments = preg_replace("/\r/",'',$comments);
		### change date/time of vicidial_callbacks record for this lead
		$stmtN="UPDATE vicidial_callbacks set callback_time='" . mysqli_real_escape_string($link, $appointment_date) . " " . mysqli_real_escape_string($link, $appointment_time) . "',comments='" . mysqli_real_escape_string($link, $comments) . "',lead_status='" . mysqli_real_escape_string($link, $CBstatus) . "' where callback_id='" . mysqli_real_escape_string($link, $callback_id) . "';";
		if ($DB) {sd_debug_log($stmtN);}
		$rslt=mysqli_query($link, $stmtN);

		echo "<BR>"._QXZ("vicidial_callback record changed to")." $appointment_date $appointment_time $CBstatus<BR>\n";
		}

	if ( (strlen($stmtK)>10) or (strlen($stmtL)>10) or (strlen($stmtM)>10) or (strlen($stmtN)>10) )
		{
		### LOG INSERTION Admin Log Table ###
		$SQL_log = "$stmtK|$stmtL|$stmtM|$stmtN|";
		$SQL_log = preg_replace('/;/', '', $SQL_log);
		$SQL_log = addslashes($SQL_log);
		$stmt="INSERT INTO vicidial_admin_log set event_date='$NOW_TIME', user='$PHP_AUTH_USER', ip_address='$ip', event_section='LEADS', event_type='MODIFY', record_id='$lead_id', event_code='ADMIN MODIFY LEAD CALLBACK', event_sql=\"$SQL_log\", event_notes='';";
		if ($DB) {sd_debug_log($stmt);}
		$rslt=mysqli_query($link, $stmt);
		}

	$stmt="SELECT count(*) from $vl_table where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' $LOGallowed_listsSQL";
	$rslt=mysqli_query($link, $stmt);
	if ($DB) {sd_debug_log($stmt);}
	$row=mysqli_fetch_row($rslt);
	$lead_count = $row[0];

	if ($lead_count > 0)
		{
		##### grab vicidial_list_alt_phones records #####
		$stmt="SELECT phone_code,phone_number,alt_phone_note,alt_phone_count,active from vicidial_list_alt_phones where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' order by alt_phone_count limit 500;";
		$rslt=mysqli_query($link, $stmt);
		if ($DB) {sd_debug_log($stmt);}
		$alts_to_print = mysqli_num_rows($rslt);

		$c=0;
		$alts_output = '';
		while ($alts_to_print > $c)
			{
			$row=mysqli_fetch_row($rslt);
			if (preg_match("/1$|3$|5$|7$|9$/i", $c))
				{$bgcolor="bgcolor=\"#$SSstd_row2_background\"";}
			else
				{$bgcolor="bgcolor=\"#$SSstd_row1_background\"";}

			$c++;
			$alts_output .= "<tr $bgcolor>";
			$alts_output .= "<td><font size=1>$c</td>";
			$alts_output .= "<td><font size=2>$row[0] $row[1]</td>";
			$alts_output .= "<td align=left><font size=2> $row[2]</td>\n";
			$alts_output .= "<td align=left><font size=2> $row[3]</td>\n";
			$alts_output .= "<td align=left><font size=2> $row[4] </td></tr>\n";
			}

		}
	else
		{
		if ($lead_id != 'NEW')
			{
			echo _QXZ("lead lookup FAILED for lead_id")." $lead_id &nbsp; &nbsp; &nbsp; $NOW_TIME\n<BR><BR>\n";
			if (!preg_match('/\-ALL/i', $LOGallowed_campaigns))
				{exit;}
			}
#		echo "<a href=\"$PHP_SELF\">Close this window</a>\n<BR><BR>\n";
		}

	##### grab vicidial_log records #####
	$stmt="SELECT uniqueid,lead_id,list_id,campaign_id,call_date,start_epoch,end_epoch,length_in_sec,status,phone_code,phone_number,user,comments,processed,user_group,term_reason,alt_dial from vicidial_log where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' order by uniqueid desc limit 500;";
	$rslt=mysqli_query($link, $stmt);
	$logs_to_print = mysqli_num_rows($rslt);
	if ($DB) {sd_debug_log("$logs_to_print|$stmt");}

	$u=0;
	$call_log = '';
	$log_campaign = '';
	while ($logs_to_print > $u)
		{
		$row=mysqli_fetch_row($rslt);
		if (strlen($log_campaign)<1) {$log_campaign = $row[3];}
		if (preg_match("/1$|3$|5$|7$|9$/i", $u))
			{$bgcolor="bgcolor=\"#$SSstd_row2_background\"";}
		else
			{$bgcolor="bgcolor=\"#$SSstd_row1_background\"";}

		$u++;
		$call_log .= "<tr $bgcolor>";
		$call_log .= "<td><font size=1>$u</td>";
		$call_log .= "<td><font size=2>$row[4]</td>";
		$call_log .= "<td align=left><font size=2> $row[7]</td>\n";
		$call_log .= "<td align=left><font size=2> $row[8]</td>\n";
		$call_log .= "<td align=left><font size=2> <A HREF=\"user_stats.php?user=$row[11]\" target=\"_blank\">$row[11]</A> </td>\n";
		$call_log .= "<td align=right><font size=2> $row[3] </td>\n";
		$call_log .= "<td align=right><font size=2> $row[2] </td>\n";
		$call_log .= "<td align=right><font size=2> $row[1] </td>\n";
		$call_log .= "<td align=right><font size=2> $row[15] </td>\n";
		$call_log .= "<td align=right><font size=2>&nbsp; $row[10] </td>\n";

		if ($CIDdisplay=="Yes")
			{
			$caller_code='';
			$stmtA="SELECT caller_code FROM vicidial_log_extended WHERE lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' and uniqueid='$row[0]';";
			$rsltA=mysqli_query($link, $stmtA);
			$cc_to_print = mysqli_num_rows($rslt);
			if ($cc_to_print > 0)
				{
				$rowA=mysqli_fetch_row($rsltA);
				$caller_code = $rowA[0];
				}
			$outbound_cid='';
			$stmtA="SELECT outbound_cid FROM vicidial_dial_log WHERE lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' and caller_code='$caller_code';";
			$rsltA=mysqli_query($link, $stmtA);
			$cid_to_print = mysqli_num_rows($rslt);
			if ($cid_to_print > 0)
				{
				$rowA=mysqli_fetch_row($rsltA);
				$outbound_cid = $rowA[0];
				$outbound_cid = preg_replace("/\".*\" /",'',$outbound_cid);
				}
			if ($SSsip_event_logging > 0)
				{
				$call_log .= "<td align=right nowrap><font size=2>&nbsp; $outbound_cid  <span onClick=\"ShowCallDetail(event,'$caller_code','$SSframe_background')\"><font color=blue><u>$caller_code</u></font></span></td><td align=right><font size=2>&nbsp; $row[0]</td>\n";
				}
			else
				{
				$call_log .= "<td align=right nowrap><font size=2>&nbsp; $outbound_cid $caller_code</td><td align=right><font size=2>&nbsp; $row[0]</td>\n";
				}
			$AMDSTATUS='';	$AMDRESPONSE='';
			$stmtA="SELECT AMDSTATUS,AMDRESPONSE FROM vicidial_amd_log WHERE lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' and caller_code='$caller_code';";
			$rsltA=mysqli_query($link, $stmtA);
			$amd_to_print = mysqli_num_rows($rslt);
			if ($amd_to_print > 0)
				{
				$rowA=mysqli_fetch_row($rsltA);
				$AMDSTATUS =	$rowA[0];
				$AMDRESPONSE =	$rowA[1];
				$call_log .= "<td align=right nowrap><font size=2>&nbsp; $AMDSTATUS</td><td align=right><font size=2>&nbsp; $AMDRESPONSE</td>\n";
				if (strlen($AMDSTATUS) > 0) {$AMDcount++;}
				}
			}
		$call_log .= "</tr>\n";

		$stmtA="SELECT call_notes FROM vicidial_call_notes WHERE lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' and vicidial_id='$row[0]';";
		$rsltA=mysqli_query($link, $stmtA);
		$out_notes_to_print = mysqli_num_rows($rslt);
		if ($out_notes_to_print > 0)
			{
			$rowA=mysqli_fetch_row($rsltA);
			if (strlen($rowA[0]) > 0)
				{
				$call_log .= "<TR>";
				$call_log .= "<td></td>";
				$call_log .= "<TD $bgcolor COLSPAN=9><font style=\"font-size:11px;font-family:sans-serif;\"> "._QXZ("NOTES").": &nbsp; $rowA[0] </font></TD>";
				$call_log .= "</TR>";
				}
			}

		$campaign_id = $row[3];
		}

	##### grab vicidial_agent_log records #####
	$stmt="SELECT agent_log_id,user,server_ip,event_time,lead_id,campaign_id,pause_epoch,pause_sec,wait_epoch,wait_sec,talk_epoch,talk_sec,dispo_epoch,dispo_sec,status,user_group,comments,sub_status from vicidial_agent_log where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' order by agent_log_id desc limit 500;";
	$rslt=mysqli_query($link, $stmt);
	$Alogs_to_print = mysqli_num_rows($rslt);
	if ($DB) {sd_debug_log("$Alogs_to_print|$stmt");}

	$y=0;
	$agent_log = '';
	$Alog_campaign = '';
	while ($Alogs_to_print > $y)
		{
		$row=mysqli_fetch_row($rslt);
		if (strlen($Alog_campaign)<1) {$Alog_campaign = $row[5];}
		if (preg_match("/1$|3$|5$|7$|9$/i", $y))
			{$bgcolor="bgcolor=\"#$SSstd_row2_background\"";}
		else
			{$bgcolor="bgcolor=\"#$SSstd_row1_background\"";}

		$y++;
		$agent_log .= "<tr $bgcolor>";
		$agent_log .= "<td><font size=1>$y</td>";
		$agent_log .= "<td><font size=2>$row[3]</td>";
		$agent_log .= "<td align=left><font size=2> $row[5]</td>\n";
		$agent_log .= "<td align=left><font size=2> <A HREF=\"user_stats.php?user=$row[1]\" target=\"_blank\">$row[1]</A> </td>\n";
		$agent_log .= "<td align=right><font size=2> $row[7]</td>\n";
		$agent_log .= "<td align=right><font size=2> $row[9] </td>\n";
		$agent_log .= "<td align=right><font size=2> $row[11] </td>\n";
		$agent_log .= "<td align=right><font size=2> $row[13] </td>\n";
		$agent_log .= "<td align=right><font size=2> &nbsp; $row[14] </td>\n";
		$agent_log .= "<td align=right><font size=2> &nbsp; $row[15] </td>\n";
		$agent_log .= "<td align=right><font size=2> &nbsp; $row[17] </td></tr>\n";

		$campaign_id = $row[5];
		}

	##### grab vicidial_closer_log records #####
	$stmt="SELECT closecallid,lead_id,list_id,campaign_id,call_date,start_epoch,end_epoch,length_in_sec,status,phone_code,phone_number,user,comments,processed,queue_seconds,user_group,xfercallid,term_reason,uniqueid,agent_only from vicidial_closer_log where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' order by closecallid desc limit 500;";
	$rslt=mysqli_query($link, $stmt);
	$Clogs_to_print = mysqli_num_rows($rslt);
	if ($DB) {sd_debug_log("$Clogs_to_print|$stmt");}

	$y=0;
	$closer_log = '';
	$Clog_campaign = '';
	while ($Clogs_to_print > $y)
		{
		$row=mysqli_fetch_row($rslt);
		if (strlen($Clog_campaign)<1) {$Clog_campaign = $row[3];}
		if (preg_match("/1$|3$|5$|7$|9$/i", $y))
			{$bgcolor="bgcolor=\"#$SSstd_row2_background\"";}
		else
			{$bgcolor="bgcolor=\"#$SSstd_row1_background\"";}

		$y++;
		$closer_log .= "<tr $bgcolor>";
		$closer_log .= "<td><font size=1>$y</td>";
		$closer_log .= "<td><font size=2>$row[4]</td>";
		$closer_log .= "<td align=left><font size=2> $row[7]</td>\n";
		$closer_log .= "<td align=left><font size=2> $row[8]</td>\n";
		$closer_log .= "<td align=left><font size=2> <A HREF=\"user_stats.php?user=$row[11]\" target=\"_blank\">$row[11]</A> </td>\n";
		$closer_log .= "<td align=right><font size=2> $row[3] </td>\n";
		$closer_log .= "<td align=right><font size=2> $row[2] </td>\n";
		$closer_log .= "<td align=right><font size=2> $row[1] </td>\n";
		$closer_log .= "<td align=right><font size=2> &nbsp; $row[14] </td>\n";
		$closer_log .= "<td align=right><font size=2> &nbsp; $row[17] </td></tr>\n";

		$stmtA="SELECT call_notes FROM vicidial_call_notes WHERE lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' and vicidial_id IN('$row[0]','$row[18]');";
		$rsltA=mysqli_query($link, $stmtA);
		$in_notes_to_print = mysqli_num_rows($rslt);
		if ($in_notes_to_print > 0)
			{
			$rowA=mysqli_fetch_row($rsltA);
			if (strlen($rowA[0]) > 0)
				{
				$closer_log .= "<TR>";
				$closer_log .= "<td></td>";
				$closer_log .= "<TD $bgcolor COLSPAN=9><font style=\"font-size:11px;font-family:sans-serif;\"> "._QXZ("NOTES").": &nbsp; $rowA[0] </font></TD>";
				$closer_log .= "</TR>";
				}
			}

		$campaign_id = $row[3];
		}


	########## BEGIN ARCHIVE LOG SEARCH ##########
	if ($archive_log == 'Yes')
		{
		##### grab vicidial_log_archive records #####
		$stmt="SELECT uniqueid,lead_id,list_id,campaign_id,call_date,start_epoch,end_epoch,length_in_sec,status,phone_code,phone_number,user,comments,processed,user_group,term_reason,alt_dial from vicidial_log_archive where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' order by uniqueid desc limit 500;";
		$rslt=mysqli_query($link, $stmt);
		$logs_to_print = mysqli_num_rows($rslt);
		if ($DB) {sd_debug_log("$logs_to_print|$stmt");}

		$u=0;
	#	$call_log = '';
	#	$log_campaign = '';
		while ($logs_to_print > $u)
			{
			$row=mysqli_fetch_row($rslt);
			if (strlen($log_campaign)<1) {$log_campaign = $row[3];}
			if (preg_match("/1$|3$|5$|7$|9$/i", $u))
				{$bgcolor="bgcolor=\"#$SSstd_row2_background\"";}
			else
				{$bgcolor="bgcolor=\"#$SSstd_row1_background\"";}

			$u++;
			$call_log .= "<tr $bgcolor>";
			$call_log .= "<td><font size=1>$u</td>";
			$call_log .= "<td><font size=2><font color='#FF0000'>$row[4]</font></td>";
			$call_log .= "<td align=left><font size=2> $row[7]</td>\n";
			$call_log .= "<td align=left><font size=2> $row[8]</td>\n";
			$call_log .= "<td align=left><font size=2> <A HREF=\"user_stats.php?user=$row[11]\" target=\"_blank\">$row[11]</A> </td>\n";
			$call_log .= "<td align=right><font size=2> $row[3] </td>\n";
			$call_log .= "<td align=right><font size=2> $row[2] </td>\n";
			$call_log .= "<td align=right><font size=2> $row[1] </td>\n";
			$call_log .= "<td align=right><font size=2> $row[15] </td>\n";
			$call_log .= "<td align=right><font size=2>&nbsp; $row[10] </td>\n";

			if ($CIDdisplay=="Yes")
				{
				$caller_code='';
				$stmtA="SELECT caller_code FROM vicidial_log_extended_archive WHERE lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' and uniqueid='$row[0]';";
				$rsltA=mysqli_query($link, $stmtA);
				$cc_to_print = mysqli_num_rows($rslt);
				if ($cc_to_print > 0)
					{
					$rowA=mysqli_fetch_row($rsltA);
					$caller_code = $rowA[0];
					}
				$outbound_cid='';
				$stmtA="SELECT outbound_cid FROM vicidial_dial_log_archive WHERE lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' and caller_code='$caller_code';";
				$rsltA=mysqli_query($link, $stmtA);
				$cid_to_print = mysqli_num_rows($rslt);
				if ($cid_to_print > 0)
					{
					$rowA=mysqli_fetch_row($rsltA);
					$outbound_cid = $rowA[0];
					$outbound_cid = preg_replace("/\".*\" /",'',$outbound_cid);
					}
				if ($SSsip_event_logging > 0)
					{
					$call_log .= "<td align=right nowrap><font size=2>&nbsp; $outbound_cid  <span onClick=\"ShowCallDetail(event,'$caller_code','$SSframe_background')\"><font color=blue><u>$caller_code</u></font></span></td><td align=right><font size=2>&nbsp; $row[0]</td>\n";
					}
				else
					{
					$call_log .= "<td align=right nowrap><font size=2>&nbsp; $outbound_cid $caller_code</td><td align=right><font size=2>&nbsp; $row[0]</td>\n";
					}
				}
			$call_log .= "</tr>\n";

			$stmtA="SELECT call_notes FROM vicidial_call_notes WHERE lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' and vicidial_id='$row[0]';";
			$rsltA=mysqli_query($link, $stmtA);
			$out_notes_to_print = mysqli_num_rows($rslt);
			if ($out_notes_to_print > 0)
				{
				$rowA=mysqli_fetch_row($rsltA);
				if (strlen($rowA[0]) > 0)
					{
					$call_log .= "<TR>";
					$call_log .= "<td></td>";
					$call_log .= "<TD $bgcolor COLSPAN=9><font style=\"font-size:11px;font-family:sans-serif;\"> "._QXZ("NOTES").": &nbsp; $rowA[0] </font></TD>";
					$call_log .= "</TR>";
					}
				}

			$campaign_id = $row[3];
			}

		##### grab vicidial_agent_log_archive records #####
		$stmt="SELECT agent_log_id,user,server_ip,event_time,lead_id,campaign_id,pause_epoch,pause_sec,wait_epoch,wait_sec,talk_epoch,talk_sec,dispo_epoch,dispo_sec,status,user_group,comments,sub_status from vicidial_agent_log_archive where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' order by agent_log_id desc limit 500;";
		$rslt=mysqli_query($link, $stmt);
		$Alogs_to_print = mysqli_num_rows($rslt);
		if ($DB) {sd_debug_log("$Alogs_to_print|$stmt");}

		$y=0;
	#	$agent_log = '';
	#	$Alog_campaign = '';
		while ($Alogs_to_print > $y)
			{
			$row=mysqli_fetch_row($rslt);
			if (strlen($Alog_campaign)<1) {$Alog_campaign = $row[5];}
			if (preg_match("/1$|3$|5$|7$|9$/i", $y))
				{$bgcolor="bgcolor=\"#$SSstd_row2_background\"";}
			else
				{$bgcolor="bgcolor=\"#$SSstd_row1_background\"";}

			$y++;
			$agent_log .= "<tr $bgcolor>";
			$agent_log .= "<td><font size=1>$y</td>";
			$agent_log .= "<td><font size=2><font color='#FF0000'>$row[3]</font></td>";
			$agent_log .= "<td align=left><font size=2> $row[5]</td>\n";
			$agent_log .= "<td align=left><font size=2> <A HREF=\"user_stats.php?user=$row[1]\" target=\"_blank\">$row[1]</A> </td>\n";
			$agent_log .= "<td align=right><font size=2> $row[7]</td>\n";
			$agent_log .= "<td align=right><font size=2> $row[9] </td>\n";
			$agent_log .= "<td align=right><font size=2> $row[11] </td>\n";
			$agent_log .= "<td align=right><font size=2> $row[13] </td>\n";
			$agent_log .= "<td align=right><font size=2> &nbsp; $row[14] </td>\n";
			$agent_log .= "<td align=right><font size=2> &nbsp; $row[15] </td>\n";
			$agent_log .= "<td align=right><font size=2> &nbsp; $row[17] </td></tr>\n";

			$campaign_id = $row[5];
			}

		##### grab vicidial_closer_log_archive records #####
		$stmt="SELECT closecallid,lead_id,list_id,campaign_id,call_date,start_epoch,end_epoch,length_in_sec,status,phone_code,phone_number,user,comments,processed,queue_seconds,user_group,xfercallid,term_reason,uniqueid,agent_only from vicidial_closer_log_archive where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' order by closecallid desc limit 500;";
		$rslt=mysqli_query($link, $stmt);
		$Clogs_to_print = mysqli_num_rows($rslt);
		if ($DB) {sd_debug_log("$Clogs_to_print|$stmt");}

		$y=0;
	#	$closer_log = '';
	#	$Clog_campaign = '';
		while ($Clogs_to_print > $y)
			{
			$row=mysqli_fetch_row($rslt);
			if (strlen($Clog_campaign)<1) {$Clog_campaign = $row[3];}
			if (preg_match("/1$|3$|5$|7$|9$/i", $y))
				{$bgcolor="bgcolor=\"#$SSstd_row2_background\"";}
			else
				{$bgcolor="bgcolor=\"#$SSstd_row1_background\"";}

			$y++;
			$closer_log .= "<tr $bgcolor>";
			$closer_log .= "<td><font size=1>$y</td>";
			$closer_log .= "<td><font size=2><font color='#FF0000'>$row[4]</font></td>";
			$closer_log .= "<td align=left><font size=2> $row[7]</td>\n";
			$closer_log .= "<td align=left><font size=2> $row[8]</td>\n";
			$closer_log .= "<td align=left><font size=2> <A HREF=\"user_stats.php?user=$row[11]\" target=\"_blank\">$row[11]</A> </td>\n";
			$closer_log .= "<td align=right><font size=2> $row[3] </td>\n";
			$closer_log .= "<td align=right><font size=2> $row[2] </td>\n";
			$closer_log .= "<td align=right><font size=2> $row[1] </td>\n";
			$closer_log .= "<td align=right><font size=2> &nbsp; $row[14] </td>\n";
			$closer_log .= "<td align=right><font size=2> &nbsp; $row[17] </td></tr>\n";

			$stmtA="SELECT call_notes FROM vicidial_call_notes WHERE lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' and vicidial_id IN('$row[0]','$row[18]');";
			$rsltA=mysqli_query($link, $stmtA);
			$in_notes_to_print = mysqli_num_rows($rslt);
			if ($in_notes_to_print > 0)
				{
				$rowA=mysqli_fetch_row($rsltA);
				if (strlen($rowA[0]) > 0)
					{
					$closer_log .= "<TR>";
					$closer_log .= "<td></td>";
					$closer_log .= "<TD $bgcolor COLSPAN=9><font style=\"font-size:11px;font-family:sans-serif;\"> "._QXZ("NOTES").": &nbsp; $rowA[0] </font></TD>";
					$closer_log .= "</TR>";
					}
				}

			$campaign_id = $row[3];
			}
		}
	########## END ARCHIVE LOG SEARCH ##########


	##### grab vicidial_list data for lead #####
	$stmt="SELECT * FROM $vl_table WHERE lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' $LOGallowed_listsSQL";
	$rslt=mysqli_query($link, $stmt);
	if ($DB) {sd_debug_log($stmt);}
	$row=mysqli_fetch_array($rslt, MYSQLI_BOTH);

	if ($LOGadmin_hide_phone_data != '0')
		{
		    if ($DB > 0) {sd_debug_log('HIDEPHONEDATA|$row["phone_number"]|$LOGadmin_hide_phone_data|');}
		$phone_temp = $row["phone_number"];
		if (strlen($phone_temp) > 0)
			{
			if ($LOGadmin_hide_phone_data == '4_DIGITS')
				{$row[11] = str_repeat("X", (strlen($phone_temp) - 4)) . substr($phone_temp,-4,4);}
			elseif ($LOGadmin_hide_phone_data == '3_DIGITS')
				{$row[11] = str_repeat("X", (strlen($phone_temp) - 3)) . substr($phone_temp,-3,3);}
			elseif ($LOGadmin_hide_phone_data == '2_DIGITS')
				{$row[11] = str_repeat("X", (strlen($phone_temp) - 2)) . substr($phone_temp,-2,2);}
			else
				{$row[11] = preg_replace("/./",'X',$phone_temp);}
			}
		}
	if ($LOGadmin_hide_lead_data != '0')
		{
		if ($DB > 0) {
		    sd_debug_log('HIDELEADDATA|$row["vendor_lead_code"]|$row["source_id"]|$row["title"]|$row["first_name"]|$row["middle_initial"]|$row["last_name"]|$row["address1"]|$row["address2"]|$row["address3"]|$row["city"]|$row["state"]|$row["province"]|$row["postal_code"]|$row["alt_phone"]|$row["email"]|$row["security_phrase"]|$LOGadmin_hide_lead_data|');
		}
		
		if (strlen($row["vendor_lead_code"]) > 0) {
		  $data_temp = $row["vendor_lead_code"];
		  $row["vendor_lead_code"] = preg_replace("/./",'X',$data_temp);
		}
		if (strlen($row["source_id"]) > 0) {
		  $data_temp = $row["source_id"];
		  $row["source_id"] = preg_replace("/./",'X',$data_temp);
		}
		if (strlen($row["title"]) > 0) {
		  $data_temp = $row["title"];   
		  $row["title"] = preg_replace("/./",'X',$data_temp);
		}
		if (strlen($row["first_name"]) > 0) {
		    $data_temp = $row["first_name"];   
		    $row["first_name"] = preg_replace("/./",'X',$data_temp);
		}
		if (strlen($row["middle_initial"]) > 0) {
		    $data_temp = $row["middle_initial"];
		    $row["middle_initial"] = preg_replace("/./",'X',$data_temp);
		}
		if (strlen($row["last_name"]) > 0) {
		    $data_temp = $row["last_name"];
		    $row["last_name"] = preg_replace("/./",'X',$data_temp);
		}
		if (strlen($row["address1"]) > 0) {
		    $data_temp = $row["address1"];   
		    $row["address1"] = preg_replace("/./",'X',$data_temp);
		}
		if (strlen($row["address2"]) > 0)	{
		    $data_temp = $row["address2"];
		    $row["address2"] = preg_replace("/./",'X',$data_temp);
		}
		if (strlen($row["address3"]) > 0) {
		    $data_temp = $row["address3"];   
		    $row["address3"] = preg_replace("/./",'X',$data_temp);
		}
		if (strlen($row["city"]) > 0) {
		    $data_temp = $row["city"];
		    $row["city"] = preg_replace("/./",'X',$data_temp);
		}
		if (strlen($row["state"]) > 0) {
		    $data_temp = $row["state"];
		    $row["state"] = preg_replace("/./",'X',$data_temp);
		}
		if (strlen($row["province"]) > 0) {
		    $data_temp = $row["province"];
		    $row["province"] = preg_replace("/./",'X',$data_temp);
		}
		if (strlen($row["postal_code"]) > 0) {
		    $data_temp = $row["postal_code"];
		    $row["postal_code"] = preg_replace("/./",'X',$data_temp);
		}
		if (strlen($row["alt_phone"]) > 0) {
		    $data_temp = $row["alt_phone"];
		    $row["alt_phone"] = preg_replace("/./",'X',$data_temp);
		}
		if (strlen($row["email"]) > 0) {
		    $data_temp = $row["email"];
		    $row["email"] = preg_replace("/./",'X',$data_temp);
		}
		if (strlen($row["security_phrase"]) > 0)
			{$data_temp = $row["security_phrase"];   $row["security_phrase"] = preg_replace("/./",'X',$data_temp);}
		}

    if (strlen($row["lead_id"]) > 0) {
	   $lead_id	= $row["lead_id"];
    }
    $dispo                     = $row["status"];
	$tsr                       = $row["user"];
	$vendor_id                 = $row["vendor_lead_code"];
	$source_id                 = $row["source_id"];
	$list_id                   = $row["list_id"];
	$gmt_offset_now            = $row["gmt_offset_now"];
	$called_since_last_reset   = $row["called_since_last_reset"];
	$phone_code                = $row["phone_code"];
	$phone_number              = $row["phone_number"];
	$title                     = $row["title"];
	$first_name                = $row["first_name"];
	$middle_initial            = $row["middle_initial"];
	$last_name                 = $row["last_name"];
	$address1                  = $row["address1"];
	$address2                  = $row["address2"];
	$address3                  = $row["address3"];
	$city                      = $row["city"];
	$state                     = $row["state"];
	$province                  = $row["province"];
	$postal_code               = $row["postal_code"];
	$country_code              = $row["country_code"];
	$gender                    = $row["gender"];
	$date_of_birth             = $row["date_of_birth"];
	$alt_phone                 = $row["alt_phone"];
	$email                     = $row["email"];
	$security                  = $row["security_phrase"];
	$comments                  = $row["comments"];
	$called_count              = $row["called_count"];
	$last_local_call_time      = $row["last_local_call_time"];
	$rank                      = $row["rank"];
	$owner			  	       = $row["owner"];
	$entry_list_id		       = $row["entry_list_id"];
	$housenr1                  = $row["housenr1"];
	$BlockStatus               = $row["block_status"];
	$selection                 = $row["selection"];
	$CustStatus                = $row["customer_status"];
	$phone_code_alt1           = $row["phone_code_alt1"];
	$phone_code_alt2           = $row["phone_code_alt2"];
	$phone_code_alt3           = $row["phone_code_alt3"];

	$comments = preg_replace("/!N/","\n",$comments);

	$DisableSel = "disabled";
	if($LOGuser_level == 9) {
	    $DisableSel = "";
	}
	
	$BlockStr = FillBlockStatus($BlockStatus, $DisableSel);
	$CustStr  = FillCustStatus($CustStatus);
		
	if ($lead_id == 'NEW')
		{
		##### create a select list of lists if a NEW lead_id #####
		$stmt="SELECT list_id,campaign_id,list_name from vicidial_lists $whereLOGallowed_campaignsSQL order by list_id limit 5000;";
		if ($DB) {sd_debug_log($stmt);}
		$rslt=mysqli_query($link, $stmt);
		$lists_to_print = mysqli_num_rows($rslt);

		$Lc=0;
		$select_list = '<select size=1 name=list_id>';
		while ($lists_to_print > $Lc)
			{
			$row=mysqli_fetch_row($rslt);
			$select_list .= "<option value='$row[0]'>$row[0] - $row[1] - $row[2]</option>";

			$Lc++;
			}
		$select_list .= "</select>";

		$list_id=$select_list;
		}

	if ($lead_id == 'NEW')
		{echo "<br><b>"._QXZ("Add A New Lead")."</B>\n";}
	else
		{echo "<br>"._QXZ("Lead information").": $first_name $last_name - $phone_number\n";}

	echo "<br><br><form action=$PHP_SELF method=POST>\n";
	echo "<input type=hidden name=end_call value=1>\n";
	echo "<input type=hidden name=DB value=\"$DB\">\n";
	echo "<input type=hidden name=lead_id value=\"$lead_id\">\n";
	echo "<input type=hidden name=dispo value=\"$dispo\">\n";
	echo "<input type=hidden name=list_id value=\"$list_id\">\n";
	echo "<input type=hidden name=campaign_id value=\"$campaign_id\">\n";
	echo "<input type=hidden name=old_phone value=\"$phone_number\">\n";
	echo "<input type=hidden name=server_ip value=\"$server_ip\">\n";
	echo "<input type=hidden name=extension value=\"$extension\">\n";
	echo "<input type=hidden name=channel value=\"$channel\">\n";
	echo "<input type=hidden name=call_began value=\"$call_began\">\n";
	echo "<input type=hidden name=parked_time value=\"$parked_time\">\n";
	echo "<input type=hidden name=FORM_LOADED id=FORM_LOADED value=\"0\" />\n";
	echo "<table cellpadding=1 cellspacing=0>\n";
	if($ExtLink_admin_modify_lead == "") {
		echo "<tr><td colspan=2>"._QXZ("Lead ID").": $lead_id &nbsp; &nbsp; "._QXZ("List ID").":  $list_id &nbsp; &nbsp; <font size=2>"._QXZ("GMT offset").": $gmt_offset_now &nbsp; &nbsp; "._QXZ("CSLR").": $called_since_last_reset &nbsp; &nbsp; <a href=\"javascript:launch_list_log($lead_id);\">"._QXZ("Lead change Log")."</a></td></tr>\n";
	} else {
		echo "<tr><td colspan=2>"._QXZ("Lead ID").": <A target= \"_blank\" HREF=\"".$ExtLink_admin_modify_lead."$lead_id\">$lead_id</A> &nbsp; &nbsp; "._QXZ("List ID").":  $list_id &nbsp; &nbsp; <font size=2>"._QXZ("GMT offset").": $gmt_offset_now &nbsp; &nbsp; "._QXZ("CSLR").": $called_since_last_reset  &nbsp; &nbsp; <a href=\"javascript:launch_list_log($lead_id);\">"._QXZ("Lead change Log")."</a></td></tr>\n";
	}
	echo "<tr><td colspan=2>"._QXZ("Fronter").": <A HREF=\"user_stats.php?user=$tsr\">$tsr</A> &nbsp; &nbsp; "._QXZ("Called Count").": $called_count &nbsp; &nbsp; <font size=2>"._QXZ("Last Local Call").": $last_local_call_time</td></tr>\n";
	if ($archive_search=="Yes")
		{
		echo "<tr><td colspan=2 align='center'>";
		echo "<B><font color='#FF0000'>*** "._QXZ("ARCHIVED LEAD")." ***</font></B>";
		echo "<input type='hidden' name='archive_search' value='Yes'>";
		echo "</td></tr>\n";
		}
	if ($archive_log=="Yes")
		{
		echo "<tr><td colspan=2 align='center'>";
		echo "<B><font color='#FF0000' size='1'>*** "._QXZ("ARCHIVED LOG SEARCH ENABLED")." ***</font></B> <a href=\"$PHP_SELF?lead_id=$lead_id&archive_search=$archive_search&archive_log=No&CIDdisplay=$CIDdisplay\">"._QXZ("Turn off archived logs display")."</a><BR>";
		echo "<B><font color='#FF0000' size='1'>*** "._QXZ("ARCHIVED LOGS SHOWN IN RED, THERE MAY BE DUPLICATES WITH NON-ARCHIVED LOG ENTRIES")." ***</font></B>";
		echo "<input type='hidden' name='archive_log' value='Yes'>";
		echo "</td></tr>\n";
		}
	else
		{
		echo "<tr><td colspan=2 align='center'>";
		echo "<a href=\"$PHP_SELF?lead_id=$lead_id&archive_search=$archive_search&archive_log=Yes&CIDdisplay=$CIDdisplay\">"._QXZ("Turn on archived logs display")."</a>";
		echo "</td></tr>\n";
		}

	if ($lead_id == 'NEW') {$list_id='';}

	if ($LOGadmin_hide_lead_data != '0')
		{
		echo "<tr><td align=right>$label_title: </td><td align=left>$title &nbsp; \n";
		echo "$label_first_name: $first_name </td></tr>\n";
		echo "<tr><td align=right>$label_middle_initial:  </td><td align=left>$middle_initial &nbsp; \n";
		echo " $label_last_name: $last_name </td></tr>\n";
		echo "<tr><td align=right>$label_address1 : </td><td align=left>$address1</td></tr>\n";
		echo "<tr><td align=right>$label_address2 : </td><td align=left>$address2</td></tr>\n";
		echo "<tr><td align=right>$label_address3 : </td><td align=left>$address3</td></tr>\n";
		echo "<tr><td align=right>$label_city : </td><td align=left>$city</td></tr>\n";
		echo "<tr><td align=right>$label_state: </td><td align=left>$state &nbsp; \n";
		echo " $label_postal_code: $postal_code </td></tr>\n";

		echo "<tr><td align=right>$label_province : </td><td align=left>$province</td></tr>\n";
		echo "<tr><td align=right>"._QXZ("Country")." : </td><td align=left>$country_code &nbsp; \n";
		echo " "._QXZ("Date of Birth").": $date_of_birth </td></tr>\n";
		echo "<tr><td align=right>$label_phone_number : </td><td align=left>$phone_number</td></tr>\n";
		echo "<tr><td align=right>$label_phone_code : </td><td align=left>$phone_code</td></tr>\n";
		echo "<tr><td align=right>$label_alt_phone : </td><td align=left>$alt_phone</td></tr>\n";
		echo "<tr><td align=right>$label_email : </td><td align=left>$email</td></tr>\n";
		echo "<tr><td align=right>$label_security_phrase : </td><td align=left>$security</td></tr>\n";
		echo "<tr><td align=right>$label_vendor_lead_code : </td><td align=left>$vendor_id></td></tr>\n";
		if ($SSsource_id_display > 0)
			{echo "<tr><td align=right>$label_source_id : </td><td align=left>$source_id></td></tr>\n";}
		echo "<tr><td align=right>"._QXZ("Rank")." : </td><td align=left>$rank</td></tr>\n";
		echo "<tr><td align=right>"._QXZ("Owner")." : </td><td align=left>$owner</td></tr>\n";
		echo "<tr><td align=right>$label_comments : </td><td align=left>$comments</td></tr>\n";
		}
	else
		{
		if($BlockStatus == "free") {
		  echo "<tr style=\"background-color:#00FF00\";><td align=right>$label_BlockStatus: </td><td align=left>".$BlockStr."</td></tr>\n";
		} else {
		    if($BlockStatus == "blocked") {
        	  echo "<tr style=\"background-color:#FF0000\";><td align=right>$label_BlockStatus: </td><td align=left>".$BlockStr."</td></tr>\n";
		    } else {
	          echo "<tr style=\"background-color:#FFAA00\";><td align=right>$label_BlockStatus: </td><td align=left>".$BlockStr."</td></tr>\n";
		    }
		}
		echo "<tr style=\"background-color:#FFAA00\";><td align=right>$label_CustStatus: </td><td align=left>".$CustStr ."</td></tr>\n";
		echo "<tr style=\"background-color:#FFAA00\";><td align=right>$label_Selection: </td><td align=left>".FillSelection($selection, $link) ."</td></tr>\n";
		echo "<tr><td align=right>$label_title: </td><td align=left><input type=text name=title size=4 maxlength=$MAXtitle value=\"$title\"> &nbsp; \n";
		echo "$label_first_name: <input type=text name=first_name size=15 maxlength=$MAXfirst_name value=\"".htmlparse($first_name)."\"> </td></tr>\n";
		echo "<tr><td align=right>$label_middle_initial:  </td><td align=left><input type=text name=middle_initial size=4 maxlength=$MAXmiddle_initial value=\"".htmlparse($middle_initial)."\"> &nbsp; \n";
		echo " $label_last_name: <input type=text name=last_name size=15 maxlength=$MAXlast_name value=\"".htmlparse($last_name)."\"> </td></tr>\n";
		echo "<tr><td align=right>$label_address1 : </td><td align=left><input type=text name=address1 size=30 maxlength=$MAXaddress1 value=\"".htmlparse($address1)."\">\n";
		echo "<input type=text name=housenr1 size=10 maxlength=$MAXhousenr1  value=\"".htmlparse($housenr1)."\"></td></tr>\n";
		
		echo "<tr><td align=right>"._QXZ("Country")." / $label_postal_code / $label_city : </td><td align=left><input type=text name=country_code size=3 maxlength=$MAXcountry_code value=\"".htmlparse($country_code)."\"> &nbsp; \n";
		echo "<input type=text name=postal_code size=7 maxlength=$MAXpostal_code value=\"".htmlparse($postal_code)."\">\n";
		echo "<input type=text name=city size=40 maxlength=$MAXcity value=\"".htmlparse($city)."\"></td></tr>\n";
		
		echo "<tr><td align=right>$label_address2 : </td><td align=left><input type=text name=address2 size=40 maxlength=$MAXaddress2 value=\"".htmlparse($address2)."\"></td></tr>\n";
		echo "<tr><td align=right>$label_address3 : </td><td align=left><input type=text name=address3 size=40 maxlength=$MAXaddress3 value=\"".htmlparse($address3)."\"></td></tr>\n";
	#	echo "<tr><td align=right>$label_city : </td><td align=left><input type=text name=city size=40 maxlength=$MAXcity value=\"".htmlparse($city)."\"></td></tr>\n";
		echo "<tr><td align=right>$label_state: </td><td align=left><input type=text name=state size=2 maxlength=$MAXstate value=\"".htmlparse($state)."\"></td></tr> \n";
		
		echo "<tr><td align=right>$label_province : </td><td align=left><input type=text name=province size=40 maxlength=$MAXprovince value=\"".htmlparse($province)."\"></td></tr>\n";
	#	echo "<tr><td align=right>"._QXZ("Country")." : </td><td align=left><input type=text name=country_code size=3 maxlength=$MAXcountry_code value=\"".htmlparse($country_code)."\"> &nbsp; \n";
		echo "<tr><td align=right>"._QXZ("Date of Birth").": </td><td align=left><input type=text name=date_of_birth size=12 maxlength=10 value=\"".htmlparse($date_of_birth)."\"></td></tr>\n";
		echo "<tr><td align=right>$label_phone_number : </td><td align=left><input type=text name=phone_number size=18 maxlength=$MAXphone_number value=\"".htmlparse($phone_number)."\"></td></tr>\n";
		
		echo "<tr><td align=right>$label_phone_code / $label_phone_number: </td><td align=left><input type=text name=phone_code size=4 maxlength=$MAXphone_code value=\"".htmlparse($phone_code)."\">\n";
		echo "<input type=text name=phone_number size=15 maxlength=$MAXphone_number value=\"".htmlparse($phone_number)."\"></td></tr>\n";
		
		echo "<tr><td align=right>$label_phone_code / $label_alt_phone : </td><td align=left><input type=text name=phone_code_alt1 size=4 maxlength=$MAXphone_code value=\"".htmlparse($phone_code_alt1)."\">\n";
        echo "<input type=text name=alt_phone size=15 maxlength=$MAXalt_phone value=\"".htmlparse($alt_phone)."\"></td></tr>\n";
        
        echo "<tr><td align=right>$label_phone_code / $label_alt_phone2 : </td><td align=left><input type=text name=phone_code_alt2 size=4 maxlength=$MAXphone_code value=\"".htmlparse($phone_code_alt2)."\">\n";
        echo "<input type=text name=alt_phone2 size=15 maxlength=$MAXalt_phone2 value=\"".htmlparse($alt_phone2)."\"></td></tr>\n";
        
		echo "<tr><td align=right>$label_email : </td><td align=left><input type=text name=email size=40 maxlength=$MAXemail value=\"".htmlparse($email)."\"></td></tr>\n";
		echo "<tr><td align=right>$label_security_phrase : </td><td align=left><input type=text name=security size=30 maxlength=$MAXsecurity_phrase value=\"".htmlparse($security)."\"></td></tr>\n";
		echo "<tr><td align=right>$label_vendor_lead_code : </td><td align=left><input type=text name=vendor_id size=30 maxlength=$MAXvendor_lead_code value=\"".htmlparse($vendor_id)."\"></td></tr>\n";
		if ($SSsource_id_display > 0)
			{echo "<tr><td align=right>$label_source_id : </td><td align=left><input type=text name=source_id size=30 maxlength=$MAXsource_id value=\"".htmlparse($source_id)."\"></td></tr>\n";}
		echo "<tr><td align=right>"._QXZ("Rank")." : </td><td align=left><input type=text name=rank size=7 maxlength=5 value=\"".htmlparse($rank)."\"></td></tr>\n";
		echo "<tr><td align=right>"._QXZ("Owner")." : </td><td align=left><input type=text name=owner size=22 maxlength=$MAXowner value=\"".htmlparse($owner)."\"></td></tr>\n";
		echo "<tr><td align=right>$label_comments : </td><td align=left><TEXTAREA name=comments ROWS=3 COLS=65>".htmlparse($comments)."</TEXTAREA></td></tr>\n";

		}

	if ($lead_id != 'NEW')
		{
		$stmt="SELECT user_id, timestamp, list_id, campaign_id, comment from vicidial_comments where lead_id='$lead_id' order by timestamp;";
		$rslt=mysqli_query($link, $stmt);
		$row_count = mysqli_num_rows($rslt);
		$audit_comments=false;
		$o=0;
		while ($row_count > $o)
			{
			if (!$audit_comments)
				{
				echo "<tr><td colspan='2' align=center><b>"._QXZ("Comment History")."</b></td></tr>\n";
				$audit_comments=true;
				}
			$rowx=mysqli_fetch_row($rslt);
			$Auser[$o] =		$rowx[0];
			$Atimestamp[$o] =	$rowx[1];
			$Acomment[$o] =		$rowx[4];
			$o++;
			}
		$o=0;
		while ($row_count > $o)
			{
			$Afull_name='';
			$stmt="SELECT full_name from vicidial_users where user='$Auser[$o]';";
			$rslt=mysqli_query($link, $stmt);
			$FNrow_count = mysqli_num_rows($rslt);
			if ($FNrow_count > 0)
				{
				$rowx=mysqli_fetch_row($rslt);
				$Afull_name = $rowx[0];
				}
			echo "<tr><td align=right><font size=2>$Atimestamp[$o]: </td><td align=left><font size=2><hr> &nbsp; $Acomment[$o]<br> &nbsp; </font><font size=1><i>by user: $Auser[$o] - $Afull_name</i></td></tr>\n";
			$o++;
			}

		if ($audit_comments)
			{
			echo "<tr><td align=center></td><td><hr></td></tr>\n";
			}

		echo "<tr bgcolor=#".$SSstd_row4_background."><td align=right>"._QXZ("Disposition").": </td><td align=left><select size=1 name=status>\n";

		### find out if status(dispo) is a scheduled callback status
		$scheduled_callback='';
		$stmt="SELECT scheduled_callback from vicidial_statuses where status='$dispo';";
		$rslt=mysqli_query($link, $stmt);
		$scb_count_to_print = mysqli_num_rows($rslt);
		if ($scb_count_to_print > 0)
			{
			$row=mysqli_fetch_row($rslt);
			if (strlen($row[0])>0)	{$scheduled_callback =	$row[0];}
			}
		$stmt="SELECT scheduled_callback from vicidial_campaign_statuses where status='$dispo';";
		$rslt=mysqli_query($link, $stmt);
		$scb_count_to_print = mysqli_num_rows($rslt);
		if ($scb_count_to_print > 0)
			{
			$row=mysqli_fetch_row($rslt);
			if (strlen($row[0])>0)	{$scheduled_callback =	$row[0];}
			}

		$list_campaign='';
		$stmt="SELECT campaign_id from vicidial_lists where list_id='$list_id'";
		$rslt=mysqli_query($link, $stmt);
		if ($DB) {sd_debug_log($stmt);}
		$Cstatuses_to_print = mysqli_num_rows($rslt);
		if ($Cstatuses_to_print > 0)
			{
			$row=mysqli_fetch_row($rslt);
			$list_campaign = $row[0];
			}

		$stmt="SELECT status,status_name,selectable,human_answered,category,sale,dnc,customer_contact,not_interested,unworkable from vicidial_statuses $selectableSQL order by status";
		$rslt=mysqli_query($link, $stmt);
		$statuses_to_print = mysqli_num_rows($rslt);
		$statuses_list='';

		$o=0;
		$DS=0;
		while ($statuses_to_print > $o)
			{
			$rowx=mysqli_fetch_row($rslt);
			if ( (strlen($dispo) ==  strlen($rowx[0])) and (preg_match("/$dispo/i",$rowx[0])) )
				{$statuses_list .= "<option SELECTED value=\"$rowx[0]\">$rowx[0] - $rowx[1]</option>\n"; $DS++;}
			else
				{$statuses_list .= "<option value=\"$rowx[0]\">$rowx[0] - $rowx[1]</option>\n";}
			$o++;
			}

		$stmt="SELECT status,status_name,selectable,campaign_id,human_answered,category,sale,dnc,customer_contact,not_interested,unworkable from vicidial_campaign_statuses where campaign_id='$list_campaign' $selectableSQLand order by status";
		$rslt=mysqli_query($link, $stmt);
		$CAMPstatuses_to_print = mysqli_num_rows($rslt);

		$o=0;
		$CBhold_set=0;
		while ($CAMPstatuses_to_print > $o)
			{
			$rowx=mysqli_fetch_row($rslt);
			if ( (strlen($dispo) ==  strlen($rowx[0])) and (preg_match("/$dispo/i",$rowx[0])) )
				{$statuses_list .= "<option SELECTED value=\"$rowx[0]\">$rowx[0] - $rowx[1]</option>\n"; $DS++;}
			else
				{$statuses_list .= "<option value=\"$rowx[0]\">$rowx[0] - $rowx[1]</option>\n";}
			if ($rowx[0] == 'CBHOLD') {$CBhold_set++;}
			$o++;
			}

		if ($dispo == 'CBHOLD') {$CBhold_set++;}

		if ($DS < 1)
			{$statuses_list .= "<option SELECTED value=\"$dispo\">$dispo</option>\n";}
		if ($CBhold_set < 1)
			{$statuses_list .= "<option value=\"CBHOLD\">CBHOLD - "._QXZ("Scheduled Callback")."</option>\n";}
		echo "$statuses_list";
		echo "</select> <i>("._QXZ("with")." $list_campaign "._QXZ("statuses").")</i></td></tr>\n";


		echo "<tr bgcolor=#".$SSstd_row4_background."><td align=left>"._QXZ("Modify vicidial log")." </td><td align=left><input type=checkbox name=modify_logs value=\"1\"></td></tr>\n";
		echo "<tr bgcolor=#".$SSstd_row4_background."><td align=left>"._QXZ("Modify agent log")." </td><td align=left><input type=checkbox name=modify_agent_logs value=\"1\"></td></tr>\n";
		echo "<tr bgcolor=#".$SSstd_row4_background."><td align=left>"._QXZ("Modify closer log")." </td><td align=left><input type=checkbox name=modify_closer_logs value=\"1\"></td></tr>\n";
		echo "<tr bgcolor=#".$SSstd_row4_background."><td align=left>"._QXZ("Add closer log record")." </td><td align=left><input type=checkbox name=add_closer_record value=\"1\"></td></tr>\n";
		}
	else
		{
		echo "<input type=hidden name=status value=\"NEW\">\n";
		}

	if ( ($LOGadmin_hide_lead_data == '0') or ($lead_id == 'NEW') )
		{
		echo "<tr><td colspan=2 align=center><input type=submit name=submit value=\""._QXZ("SUBMIT")."\"></td></tr>\n";
		}
	echo "</table></form>\n";
#	echo GetDistributorNr($lead_id);
	echo "<BR><BR><BR>\n";

	if ($lead_id != 'NEW')
		{
		echo "<TABLE BGCOLOR=#".$SSstd_row4_background." WIDTH=750><TR><TD>\n";
		echo _QXZ("Callback Details").":<BR>\n";
		if ( ($dispo == 'CALLBK') or ($dispo == 'CBHOLD') or ($scheduled_callback == 'Y') )
			{
			### find any vicidial_callback records for this lead
			$cb_stmt="SELECT callback_id,lead_id,list_id,campaign_id,status,entry_time,callback_time,modify_date,user,recipient,comments,user_group,lead_status from vicidial_callbacks where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' and status IN('ACTIVE','LIVE') order by callback_id desc limit 1000;";
			if ($DB) {sd_debug_log($stmt);}
			$cb_rslt=mysqli_query($link, $cb_stmt);
			$CB_to_print = mysqli_num_rows($cb_rslt);

			if ($CB_to_print>0)
				{
				echo "<form action='$PHP_SELF' method='POST' name='vsn' id='vsn'>";
				echo "<TABLE BGCOLOR=#".$SSstd_row4_background." WIDTH=800>";
				echo "<tr>";
				echo "<td><font size=2>"._QXZ("CallBack Date/Time").":</font></td>";
				echo "<td><font size=2>"._QXZ("CallBack Disposition").":</font></td>";
				echo "<td><font size=2>"._QXZ("Owner").":</font></td>";
				echo "<td><font size=2>"._QXZ("Comments").":</font></td>";
				echo "<td>&nbsp;</td>";
				echo "</tr>";

				$u=0;
				while ($cb_row=mysqli_fetch_row($cb_rslt)) {
					$callback_id = $cb_row[0];
					$CBcomments = $cb_row[10];
					$lead_status = $cb_row[12];
					$appointment_datetimeARRAY = explode(" ",$cb_row[6]);
					$appointment_date = $appointment_datetimeARRAY[0];
					$appointment_timeARRAY = explode(":",$appointment_datetimeARRAY[1]);
					$appointment_hour = $appointment_timeARRAY[0];
					$appointment_min = $appointment_timeARRAY[1];

					$stmt="SELECT status,status_name from vicidial_statuses where scheduled_callback='Y' $selectableSQLand and status NOT IN('CBHOLD') order by status";
					$rslt=mysqli_query($link, $stmt);
					$statuses_to_print = mysqli_num_rows($rslt);
					$statuses_list='';

					$o=0;
					$DS=0;
					while ($statuses_to_print > $o)
						{
						$rowx=mysqli_fetch_row($rslt);
						if ( (strlen($lead_status) == strlen($rowx[0])) and (preg_match("/$lead_status/i",$rowx[0])) )
							{$statuses_list .= "<option SELECTED value=\"$rowx[0]\">$rowx[0] - $rowx[1]</option>\n"; $DS++;}
						else
							{$statuses_list .= "<option value=\"$rowx[0]\">$rowx[0] - $rowx[1]</option>\n";}
						$o++;
						}

					$stmt="SELECT status,status_name from vicidial_campaign_statuses where scheduled_callback='Y' $selectableSQLand and status NOT IN('CBHOLD') and campaign_id='$list_campaign' order by status";
					$rslt=mysqli_query($link, $stmt);
					$CAMPstatuses_to_print = mysqli_num_rows($rslt);

					$o=0;
					$CBhold_set=0;
					while ($CAMPstatuses_to_print > $o)
						{
						$rowx=mysqli_fetch_row($rslt);
						if ( (strlen($lead_status) ==  strlen($rowx[0])) and (preg_match("/$lead_status/i",$rowx[0])) )
							{$statuses_list .= "<option SELECTED value=\"$rowx[0]\">$rowx[0] - $rowx[1]</option>\n"; $DS++;}
						else
							{$statuses_list .= "<option value=\"$rowx[0]\">$rowx[0] - $rowx[1]</option>\n";}
						$o++;
						}

					if ($DS < 1)
						{$statuses_list .= "<option SELECTED value=\"$lead_status\">$lead_status</option>\n";}

					if ($u%2==0)
						{$bgcolor="bgcolor=\"#$SSstd_row2_background\"";}
					else
						{$bgcolor="bgcolor=\"#$SSstd_row1_background\"";}
					$u++;

					echo "<tr $bgcolor>";
					echo "<td><input class='form_field' name='appointment_date_".$callback_id."' id='appointment_date_".$callback_id."' size=10 maxlength=10 value='$appointment_date'>";
					echo "					<script language=\"JavaScript\">
					var o_cal = new tcal ({
						// form name
						'formname': 'vsn',
						// input name
						'controlname': 'appointment_date_".$callback_id."'
					});
					o_cal.a_tpl.yearscroll = false;
					// o_cal.a_tpl.weekstart = 1; // Monday week start
					</script>";
					echo "<BR>";
					echo "<SELECT class='form_field' name='appointment_hour_".$callback_id."' id='appointment_hour_".$callback_id."'>\n";
					for ($i=0; $i<=23; $i++) {
						$hr=substr("0$i", -2);
						echo "<OPTION value='$hr'>$hr</option>\n";
					}
					echo "<OPTION value='$appointment_hour' selected>$appointment_hour</OPTION>";
					echo "</SELECT>:";
					echo "<SELECT class='form_field' name='appointment_min_".$callback_id."' id='appointment_min_".$callback_id."'>";
					for ($i=0; $i<=55; $i+=5) {
						$min=substr("0$i", -2);
						echo "<OPTION value='$min'>$min</option>\n";
					}
					echo "<OPTION value='$appointment_min' selected>$appointment_min</OPTION>";
					echo "</SELECT>";
					echo "</td>";
					echo "<td><FONT FACE='ARIAL,HELVETICA'><select class='form_field' size=1 name='CBstatus_".$callback_id."' id='CBstatus_".$callback_id."'>\n";
					echo "$statuses_list";
					echo "</td>";
					echo "<td><font size='2'>";
					if ($cb_row[9] == 'USERONLY') {$ucheck="checked"; $acheck="";} else {$acheck="checked"; $ucheck="";}

					echo "<input type='radio' name='CBchangeRecipient_".$callback_id."' id='CBchangeRecipient_".$callback_id."A' value=\"A\" $acheck>Anyone<BR>";
					echo "<input type='radio' name='CBchangeRecipient_".$callback_id."' id='CBchangeRecipient_".$callback_id."U' value=\"U\" $ucheck>Useronly<BR><BR>";
					echo _QXZ("New CB Owner UserID").":<BR><input type=text class='form_field' name='CBuser_".$callback_id."' id='CBuser_".$callback_id."' size=6 maxlength=20 value=\"$cb_row[8]\"> \n";
					echo "<input type=hidden id='recipient_".$callback_id."' name='recipient_".$callback_id."' value=\"YES\">";
					echo "</font></td>";
					echo "<td><TEXTAREA class='form_field' name='comments_".$callback_id."' id='comments_".$callback_id."' ROWS=6 COLS=50>$CBcomments</TEXTAREA></td>";
					echo "<td><input type='button' value='UPDATE' onClick='UpdateCallback($callback_id)'></td>";
					echo "</tr>";

					}
				}
			else
				{
				echo "<BR>"._QXZ("No Callback records found")."<BR>\n";
				}
			echo "</TABLE>";
			echo "<input type=hidden name=DB value=\"$DB\">\n";
			echo "<input type=hidden id=lead_id name=lead_id value=\"$lead_id\">\n";
			echo "<input type=hidden id=CBchangeDATE name=CBchangeDATE value=\"YES\">";
			echo "</form>\n";

			echo "</TD></TR></table>\n";
            
			
#			echo GetDistributorNr($lead_id);
			
			### find any vicidial_callback records for this lead
			$cb_stmt="SELECT entry_time,callback_time,user,recipient,lead_status,status,list_id,campaign_id,comments,user_group,lead_status from vicidial_callbacks where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' and status NOT IN('ACTIVE','LIVE') order by callback_id desc limit 1000;";
			if ($DB) {sd_debug_log($stmt);}
			$cb_rslt=mysqli_query($link, $cb_stmt);
			$CB_to_print = mysqli_num_rows($cb_rslt);

			$cb=0;
			$callbacks_log='';
			while ($CB_to_print > $cb)
				{
				if (preg_match("/1$|3$|5$|7$|9$/i", $cb))
					{$bgcolor="bgcolor=\"#$SSstd_row2_background\"";}
				else
					{$bgcolor="bgcolor=\"#$SSstd_row1_background\"";}
				$rowx=mysqli_fetch_row($cb_rslt);
				$cb++;
				$callbacks_log .= "<tr $bgcolor>";
				$callbacks_log .= "<td><font size=1>$cb &nbsp; </td>";
				$callbacks_log .= "<td><font size=2>$rowx[0]</font></td>";
				$callbacks_log .= "<td><font size=2>$rowx[1]</font></td>";
				$callbacks_log .= "<td><font size=2>$rowx[2]</font></td>";
				$callbacks_log .= "<td><font size=2>$rowx[3]</font></td>";
				$callbacks_log .= "<td><font size=2>$rowx[4]</font></td>";
				$callbacks_log .= "<td><font size=2>$rowx[5]</font></td>";
				$callbacks_log .= "<td><font size=2>$rowx[6]</font></td>";
				$callbacks_log .= "<td><font size=2>$rowx[7]</font></td>";
				$callbacks_log .= "</tr><tr>";
				$callbacks_log .= "<td><font size=1> &nbsp; </td>";
				$callbacks_log .= "<td colspan=8 align=left $bgcolor><font size=1>"._QXZ("comments").": </font><font size=2>$rowx[8]</font></td>";
				$callbacks_log .= "</tr>\n";
				}

			if ($archive_log=="Yes")
				{
				### find any vicidial_callbacks_archive records for this lead
				$cb_stmt="SELECT entry_time,callback_time,user,recipient,lead_status,status,list_id,campaign_id,comments,user_group,lead_status from vicidial_callbacks_archive where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' and status NOT IN('ACTIVE','LIVE') order by callback_id desc limit 1000;";
				if ($DB) {sd_debug_log($stmt);}
				$cb_rslt=mysqli_query($link, $cb_stmt);
				$CBA_to_print = mysqli_num_rows($cb_rslt);

				$cba=0;
				while ($CBA_to_print > $cba)
					{
					if (preg_match("/1$|3$|5$|7$|9$/i", $cb))
						{$bgcolor="bgcolor=\"#$SSstd_row2_background\"";}
					else
						{$bgcolor="bgcolor=\"#$SSstd_row1_background\"";}
					$rowx=mysqli_fetch_row($cb_rslt);
					$cb++;
					$cba++;
					$callbacks_log .= "<tr $bgcolor>";
					$callbacks_log .= "<td><font size=1>$cb &nbsp; </td>";
					$callbacks_log .= "<td><font size=2 color='#FF0000'>$rowx[0]</font></td>";
					$callbacks_log .= "<td><font size=2>$rowx[1]</font></td>";
					$callbacks_log .= "<td><font size=2>$rowx[2]</font></td>";
					$callbacks_log .= "<td><font size=2>$rowx[3]</font></td>";
					$callbacks_log .= "<td><font size=2>$rowx[4]</font></td>";
					$callbacks_log .= "<td><font size=2>$rowx[5]</font></td>";
					$callbacks_log .= "<td><font size=2>$rowx[6]</font></td>";
					$callbacks_log .= "<td><font size=2>$rowx[7]</font></td>";
					$callbacks_log .= "</tr><tr>";
					$callbacks_log .= "<td><font size=1> &nbsp; </td>";
					$callbacks_log .= "<td colspan=8 align=left $bgcolor><font size=1>"._QXZ("comments").": </font><font size=2>$rowx[8]</font></td>";
					$callbacks_log .= "</tr>\n";
					}
				}

#			if ($cb > 0)
#				{
#				echo "<B>"._QXZ("CALLBACKS LOG").":</B>\n";
#				echo "<TABLE width=750 cellspacing=0 cellpadding=1>\n";
#				echo "<tr><td><font size=1># </td><td><font size=2>"._QXZ("ENTRY TIME")." </td><td><font size=2>"._QXZ("CALLBACK TIME")." </td><td align=left><font size=2>"._QXZ("USER")."</td><td align=left><font size=2> "._QXZ("RECIPIENT")."</td><td align=left><font size=2> "._QXZ("LEAD STATUS")."</td><td align=left><font size=2> "._QXZ("STATUS")."</td><td align=left><font size=2> "._QXZ("LIST")."</td><td align=left><font size=2> "._QXZ("CAMPAIGN")."</td></tr>\n";
#
#				echo "$callbacks_log";
#
#				echo "</TABLE>\n";
#				}
			echo "<BR><BR>\n";
			}
		else
			{
			echo "<BR>"._QXZ("If you want to change this lead to a scheduled callback, first change the Disposition to CBHOLD, then submit and you will be able to set the callback date and time").".<BR>\n";
			echo "</TD></TR></table>\n";

			echo "<br><br>\n";

			### find any vicidial_callback records for this lead
			$cb_stmt="SELECT entry_time,callback_time,user,recipient,lead_status,status,list_id,campaign_id,comments,user_group,lead_status from vicidial_callbacks where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' order by callback_id desc limit 1000;";
			if ($DB) {sd_debug_log($stmt);}
			$cb_rslt=mysqli_query($link, $cb_stmt);
			$CB_to_print = mysqli_num_rows($cb_rslt);

			$cb=0;
			$callbacks_log='';
			while ($CB_to_print > $cb)
				{
				if (preg_match("/1$|3$|5$|7$|9$/i", $cb))
					{$bgcolor="bgcolor=\"#$SSstd_row2_background\"";}
				else
					{$bgcolor="bgcolor=\"#$SSstd_row1_background\"";}
				$rowx=mysqli_fetch_row($cb_rslt);
				$cb++;
				$callbacks_log .= "<tr $bgcolor>";
				$callbacks_log .= "<td><font size=1>$cb &nbsp; </td>";
				$callbacks_log .= "<td><font size=2>$rowx[0]</font></td>";
				$callbacks_log .= "<td><font size=2>$rowx[1]</font></td>";
				$callbacks_log .= "<td><font size=2>$rowx[2]</font></td>";
				$callbacks_log .= "<td><font size=2>$rowx[3]</font></td>";
				$callbacks_log .= "<td><font size=2>$rowx[4]</font></td>";
				$callbacks_log .= "<td><font size=2>$rowx[5]</font></td>";
				$callbacks_log .= "<td><font size=2>$rowx[6]</font></td>";
				$callbacks_log .= "<td><font size=2>$rowx[7]</font></td>";
				$callbacks_log .= "</tr><tr>";
				$callbacks_log .= "<td><font size=1> &nbsp; </td>";
				$callbacks_log .= "<td colspan=8 align=left $bgcolor><font size=1>"._QXZ("comments").": </font><font size=2>$rowx[8]</font></td>";
				$callbacks_log .= "</tr>\n";
				}

			if ($archive_log=="Yes")
				{
				### find any vicidial_callbacks_archive records for this lead
				$cb_stmt="SELECT entry_time,callback_time,user,recipient,lead_status,status,list_id,campaign_id,comments,user_group,lead_status from vicidial_callbacks_archive where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' order by callback_id desc limit 1000;";
				if ($DB) {sd_debug_log($stmt);}
				$cb_rslt=mysqli_query($link, $cb_stmt);
				$CBA_to_print = mysqli_num_rows($cb_rslt);

				$cba=0;
				while ($CBA_to_print > $cba)
					{
					if (preg_match("/1$|3$|5$|7$|9$/i", $cb))
						{$bgcolor="bgcolor=\"#$SSstd_row2_background\"";}
					else
						{$bgcolor="bgcolor=\"#$SSstd_row1_background\"";}
					$rowx=mysqli_fetch_row($cb_rslt);
					$cb++;
					$cba++;
					$callbacks_log .= "<tr $bgcolor>";
					$callbacks_log .= "<td><font size=1>$cb &nbsp; </td>";
					$callbacks_log .= "<td><font size=2 color='#FF0000'>$rowx[0]</font></td>";
					$callbacks_log .= "<td><font size=2>$rowx[1]</font></td>";
					$callbacks_log .= "<td><font size=2>$rowx[2]</font></td>";
					$callbacks_log .= "<td><font size=2>$rowx[3]</font></td>";
					$callbacks_log .= "<td><font size=2>$rowx[4]</font></td>";
					$callbacks_log .= "<td><font size=2>$rowx[5]</font></td>";
					$callbacks_log .= "<td><font size=2>$rowx[6]</font></td>";
					$callbacks_log .= "<td><font size=2>$rowx[7]</font></td>";
					$callbacks_log .= "</tr><tr>";
					$callbacks_log .= "<td><font size=1> &nbsp; </td>";
					$callbacks_log .= "<td colspan=8 align=left $bgcolor><font size=1>"._QXZ("comments").": </font><font size=2>$rowx[8]</font></td>";
					$callbacks_log .= "</tr>\n";
					}
				}

#			if ($cb > 0)
#				{
#				echo "<B>"._QXZ("CALLBACKS LOG").":</B>\n";
#				echo "<TABLE width=750 cellspacing=0 cellpadding=1>\n";
#				echo "<tr><td><font size=1># </td><td><font size=2>"._QXZ("ENTRY TIME")." </td><td><font size=2>"._QXZ("CALLBACK TIME")." </td><td align=left><font size=2>"._QXZ("USER")."</td><td align=left><font size=2> "._QXZ("RECIPIENT")."</td><td align=left><font size=2> "._QXZ("LEAD STATUS")."</td><td align=left><font size=2> "._QXZ("STATUS")."</td><td align=left><font size=2> "._QXZ("LIST")."</td><td align=left><font size=2> "._QXZ("CAMPAIGN")."</td></tr>\n";
#
#				echo "$callbacks_log";
#
#				echo "</TABLE>\n";
#				}
			echo "<BR><BR>\n";
			}


		if ($c > 0)
			{
			echo "<B>"._QXZ("EXTENDED ALTERNATE PHONE NUMBERS FOR THIS LEAD").":</B>\n";
			echo "<TABLE width=550 cellspacing=0 cellpadding=1>\n";
			echo "<tr><td><font size=1># </td><td><font size=2>"._QXZ("ALT PHONE")." </td><td align=left><font size=2>"._QXZ("ALT NOTE")."</td><td align=left><font size=2> "._QXZ("ALT COUNT")."</td><td align=left><font size=2> "._QXZ("ACTIVE")."</td></tr>\n";

			echo "$alts_output\n";

			echo "</TABLE>\n";
			echo "<BR><BR>\n";
			}



		### iframe for custom fields display/editing
		if ($custom_fields_enabled > 0)
			{
			$CLlist_id = $list_id;
			if (strlen($entry_list_id) > 2)
				{$CLlist_id = $entry_list_id;}
			$stmt="SHOW TABLES LIKE \"custom_$CLlist_id\";";
			if ($DB>0) {sd_debug_log($stmt);}
			$rslt=mysqli_query($link, $stmt);
			$tablecount_to_print = mysqli_num_rows($rslt);
			if ($tablecount_to_print > 0)
				{
				$stmt="SELECT count(*) from custom_$CLlist_id where lead_id='$lead_id';";
				if ($DB>0) {sd_debug_log($stmt);}
				$rslt=mysqli_query($link, $stmt);
				$fieldscount_to_print = mysqli_num_rows($rslt);
				if ($fieldscount_to_print > 0)
					{
					$rowx=mysqli_fetch_row($rslt);
					$custom_records_count =	$rowx[0];

					echo "<B>"._QXZ("CUSTOM FIELDS FOR THIS LEAD").":</B><BR>\n";
					echo "<iframe src=\"../agc/$vdc_form_display?lead_id=$lead_id&list_id=$CLlist_id&stage=DISPLAY&submit_button=YES&user=$PHP_AUTH_USER&pass=$PHP_AUTH_PW&bcrypt=OFF&bgcolor=E6E6E6\" style=\"background-color:transparent;\" scrolling=\"auto\" frameborder=\"2\" allowtransparency=\"true\" id=\"vcFormIFrame\" name=\"vcFormIFrame\" width=\"740\" height=\"300\" STYLE=\"z-index:18\"> </iframe>\n";
					echo "<BR><BR>";
					}
				}
			}

			
		echo GetDistributorNr($lead_id);
			
		echo "<B>"._QXZ("CALLS TO THIS LEAD").":</B>\n";
		if ($CIDdisplay == "Yes")
			{
			$out_log_width=1100;
			if ($AMDcount > 0) {$out_log_width=1300;}
			echo "<TABLE width=$out_log_width cellspacing=0 cellpadding=1>\n";
			echo "<tr><td><font size=1># </td><td><font size=2>"._QXZ("DATE/TIME")." </td><td align=left><font size=2>"._QXZ("LENGTH")."</td><td align=left><font size=2> "._QXZ("STATUS")."</td><td align=left><font size=2> "._QXZ("TSR")."</td><td align=right><font size=2> "._QXZ("CAMPAIGN")."</td><td align=right><font size=2> "._QXZ("LIST")."</td><td align=right><font size=2> "._QXZ("LEAD")."</td><td align=right><font size=2> "._QXZ("HANGUP REASON")."</td><td align=right><font size=2> "._QXZ("PHONE")."</td><td align=center><font size=2> <a href=\"$PHP_SELF?lead_id=$lead_id&archive_search=$archive_search&archive_log=$archive_log&CIDdisplay=$altCIDdisplay\">"._QXZ("CALLER ID")."</a></td><td align=right><font size=2> <a href=\"$PHP_SELF?lead_id=$lead_id&archive_search=$archive_search&archive_log=$archive_log&CIDdisplay=$altCIDdisplay\">"._QXZ("UNIQUEID")."</a></td>";
			if ($AMDcount > 0)
				{echo "<td align=right><font size=2> "._QXZ("AMD STATUS")."</td><td align=right><font size=2> "._QXZ("AMD RESPONSE")."</td>";}
			echo "</tr>\n";
			}
		else
			{
			echo "<TABLE width=850 cellspacing=0 cellpadding=1>\n";
			echo "<tr><td><font size=1># </td><td><font size=2>"._QXZ("DATE/TIME")." </td><td align=left><font size=2>"._QXZ("LENGTH")."</td><td align=left><font size=2> "._QXZ("STATUS")."</td><td align=left><font size=2> "._QXZ("TSR")."</td><td align=right><font size=2> "._QXZ("CAMPAIGN")."</td><td align=right><font size=2> "._QXZ("LIST")."</td><td align=right><font size=2> "._QXZ("LEAD")."</td><td align=right><font size=2> "._QXZ("HANGUP REASON")."</td><td align=right><font size=2> "._QXZ("PHONE")."</td><td align=right><font size=2> <a href=\"$PHP_SELF?lead_id=$lead_id&archive_search=$archive_search&archive_log=$archive_log&CIDdisplay=$altCIDdisplay\">"._QXZ("CALLER ID")."</a></td></tr>\n";
			}

		echo "$call_log\n";

		echo "</TABLE>\n";
		echo "<BR><BR>\n";

		echo "<B>"._QXZ("CLOSER RECORDS FOR THIS LEAD").":</B>\n";
		echo "<TABLE width=750 cellspacing=0 cellpadding=1>\n";
		echo "<tr><td><font size=1># </td><td><font size=2>"._QXZ("DATE/TIME")." </td><td align=left><font size=2>"._QXZ("LENGTH")."</td><td align=left><font size=2> "._QXZ("STATUS")."</td><td align=left><font size=2> "._QXZ("TSR")."</td><td align=right><font size=2> "._QXZ("CAMPAIGN")."</td><td align=right><font size=2> "._QXZ("LIST")."</td><td align=right><font size=2> "._QXZ("LEAD")."</td><td align=right><font size=2> "._QXZ("WAIT")."</td><td align=right><font size=2> "._QXZ("HANGUP REASON")."</td></tr>\n";

		echo "$closer_log\n";

		echo "</TABLE>\n";
		echo "<BR><BR>\n";


		echo "<B>"._QXZ("AGENT LOG RECORDS FOR THIS LEAD").":</B>\n";
		echo "<TABLE width=750 cellspacing=0 cellpadding=1>\n";
		echo "<tr><td><font size=1># </td><td><font size=2>"._QXZ("DATE/TIME")." </td><td align=left><font size=2>"._QXZ("CAMPAIGN")."</td><td align=left><font size=2> "._QXZ("TSR")."</td><td align=left><font size=2> "._QXZ("PAUSE")."</td><td align=right><font size=2> "._QXZ("WAIT")."</td><td align=right><font size=2> "._QXZ("TALK")."</td><td align=right><font size=2> "._QXZ("DISPO")."</td><td align=right><font size=2> "._QXZ("STATUS")."</td><td align=right><font size=2> "._QXZ("GROUP")."</td><td align=right><font size=2> "._QXZ("SUB")."</td></tr>\n";

			echo "$agent_log\n";

		echo "</TABLE>\n";
		echo "<BR><BR>\n";


		echo "<B>"._QXZ("PARK LOGS FOR THIS LEAD").":</B>\n";
		echo "<TABLE width=750 cellspacing=1 cellpadding=1>\n";
		echo "<tr><td><font size=1># </td><td align=left><font size=2> "._QXZ("PARK TIME")."</td><td><font size=2>"._QXZ("CHANNEL GROUP")." </td><td align=left><font size=2>"._QXZ("TSR")." </td><td align=left><font size=2> &nbsp; "._QXZ("STATUS")."</td><td align=left><font size=2> "._QXZ("GRAB TIME")."</td><td align=left><font size=2> "._QXZ("HANGUP TIME")."</td><td align=left><font size=2> "._QXZ("PARK SEC")."</td><td align=left><font size=2> "._QXZ("TALK SEC")."</td><td align=left><font size=2> "._QXZ("EXTENSION")."</td></tr>\n";

		$stmt="SELECT * from park_log where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' order by parked_time, grab_time, hangup_time desc limit 500;";
		$rslt=mysqli_query($link, $stmt);
		$logs_to_print = mysqli_num_rows($rslt);
		if ($DB) {sd_debug_log("$logs_to_print|$stmt|");}

		$u=0;
		while ($logs_to_print > $u)
			{
			$row=mysqli_fetch_array($rslt);
			if (preg_match("/1$|3$|5$|7$|9$/i", $u))
				{$bgcolor="bgcolor=\"#$SSstd_row2_background\"";}
			else
				{$bgcolor="bgcolor=\"#$SSstd_row1_background\"";}

			$u++;
			echo "<tr $bgcolor>";
			echo "<td><font size=1>$u</td>";
			echo "<td align=left><font size=1> $row[parked_time] </td>";
			echo "<td align=left><font size=1> $row[channel_group] </td>\n";
			echo "<td align=left><font size=2> $row[user] </td>\n";
			echo "<td align=left><font size=2> $row[status] </td>\n";
			echo "<td align=left><font size=1> $row[grab_time] </td>\n";
			echo "<td align=left><font size=1> $row[hangup_time] </td>\n";
			echo "<td align=left><font size=2> $row[parked_sec] </td>\n";
			echo "<td align=left><font size=2> $row[talked_sec] </td>\n";
			echo "<td align=left><font size=1> $row[extension] </td>\n";
			echo "</tr>\n";
			}

		echo "</TABLE><BR><BR>\n";


		echo "<B>"._QXZ("IVR LOGS FOR THIS LEAD").":</B>\n";
		echo "<TABLE width=750 cellspacing=1 cellpadding=1>\n";
		echo "<tr><td><font size=1># </td><td align=left><font size=2> "._QXZ("CAMPAIGN")."</td><td><font size=2>"._QXZ("DATE/TIME")." </td><td align=left><font size=2>"._QXZ("CALL MENU")." </td><td align=left><font size=2> &nbsp; "._QXZ("ACTION")."</td></tr>\n";

		$stmt="SELECT campaign_id,event_date,menu_id,menu_action from vicidial_outbound_ivr_log where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' order by uniqueid,event_date,menu_action desc limit 500;";
		$rslt=mysqli_query($link, $stmt);
		$logs_to_print = mysqli_num_rows($rslt);
		if ($DB) {sd_debug_log("$logs_to_print|$stmt|");}

		$u=0;
		while ($logs_to_print > $u)
			{
			$row=mysqli_fetch_row($rslt);
			if (preg_match("/1$|3$|5$|7$|9$/i", $u))
				{$bgcolor="bgcolor=\"#$SSstd_row2_background\"";}
			else
				{$bgcolor="bgcolor=\"#$SSstd_row1_background\"";}

			$u++;
			echo "<tr $bgcolor>";
			echo "<td><font size=1>$u</td>";
			echo "<td align=left><font size=2> $row[0] </td>";
			echo "<td align=left><font size=1> $row[1] </td>\n";
			echo "<td align=left><font size=2> $row[2] </td>\n";
			echo "<td align=left><font size=2> $row[3] &nbsp;</td>\n";
			echo "</tr>\n";
			}

		echo "</TABLE><BR><BR>\n";


	##### BEGIN switch lead log entries #####
		$stmt="SELECT * from vicidial_agent_function_log where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' and function='switch_lead' order by event_time desc limit 500;";
		$rslt=mysqli_query($link, $stmt);
		$logs_to_print = mysqli_num_rows($rslt);
		if ($DB) {sd_debug_log("$logs_to_print|$stmt|");}

		if ($logs_to_print > 0)
			{
			echo "<B>"._QXZ("AGENT FROM SWITCH-LEADS FOR THIS LEAD").":</B>\n";
			echo "<TABLE width=750 cellspacing=1 cellpadding=1>\n";
			echo "<tr><td><font size=1># </td><td align=left><font size=2> "._QXZ("SWITCH TIME")."</td><td><font size=2>"._QXZ("CAMPAIGN")." </td><td align=left><font size=2>"._QXZ("TSR")." </td><td align=left><font size=2> &nbsp; "._QXZ("TO LEAD ID")."</td><td align=left><font size=2> "._QXZ("CALL ID")."</td><td align=left><font size=2> "._QXZ("UNIQUEID")."</td><td align=left><font size=2> "._QXZ("PHONE NUMBER")."</td></tr>\n";


			$u=0;
			while ($logs_to_print > $u)
				{
				$row=mysqli_fetch_array($rslt);
				if (preg_match("/1$|3$|5$|7$|9$/i", $u))
					{$bgcolor="bgcolor=\"#$SSstd_row2_background\"";}
				else
					{$bgcolor="bgcolor=\"#$SSstd_row1_background\"";}

				$u++;
				echo "<tr $bgcolor>";
				echo "<td><font size=1>$u</td>";
				echo "<td align=left><font size=1> $row[event_time] </td>";
				echo "<td align=left><font size=1> $row[campaign_id] </td>\n";
				echo "<td align=left><font size=2> $row[user] </td>\n";
				echo "<td align=left><font size=2> <a href=\"$PHP_SELF?lead_id=$row[stage]\">$row[stage]</a> </td>\n";
				echo "<td align=left><font size=1> $row[caller_code] </td>\n";
				echo "<td align=left><font size=1> $row[uniqueid] </td>\n";
				echo "<td align=left><font size=2> $row[comments] </td>\n";
				echo "</tr>\n";
				}

			echo "</TABLE><BR><BR>\n";
			}

		$stmt="SELECT * from vicidial_agent_function_log where stage='" . mysqli_real_escape_string($link, $lead_id) . "' and function='switch_lead' order by event_time desc limit 500;";
		$rslt=mysqli_query($link, $stmt);
		$logs_to_print = mysqli_num_rows($rslt);
		if ($DB) {sd_debug_log("$logs_to_print|$stmt|");}

		if ($logs_to_print > 0)
			{
			echo "<B>"._QXZ("AGENT TO SWITCH-LEADS FOR THIS LEAD").":</B>\n";
			echo "<TABLE width=750 cellspacing=1 cellpadding=1>\n";
			echo "<tr><td><font size=1># </td><td align=left><font size=2> "._QXZ("SWITCH TIME")."</td><td><font size=2>"._QXZ("CAMPAIGN")." </td><td align=left><font size=2>"._QXZ("TSR")." </td><td align=left><font size=2> &nbsp; "._QXZ("FROM LEAD ID")."</td><td align=left><font size=2> "._QXZ("CALL ID")."</td><td align=left><font size=2> "._QXZ("UNIQUEID")."</td><td align=left><font size=2> "._QXZ("PHONE NUMBER")."</td></tr>\n";


			$u=0;
			while ($logs_to_print > $u)
				{
				$row=mysqli_fetch_array($rslt);
				if (preg_match("/1$|3$|5$|7$|9$/i", $u))
					{$bgcolor="bgcolor=\"#$SSstd_row2_background\"";}
				else
					{$bgcolor="bgcolor=\"#$SSstd_row1_background\"";}

				$u++;
				echo "<tr $bgcolor>";
				echo "<td><font size=1>$u</td>";
				echo "<td align=left><font size=1> $row[event_time] </td>";
				echo "<td align=left><font size=1> $row[campaign_id] </td>\n";
				echo "<td align=left><font size=2> $row[user] </td>\n";
				echo "<td align=left><font size=2> <a href=\"$PHP_SELF?lead_id=$row[lead_id]\">$row[lead_id]</a> </td>\n";
				echo "<td align=left><font size=1> $row[caller_code] </td>\n";
				echo "<td align=left><font size=1> $row[uniqueid] </td>\n";
				echo "<td align=left><font size=2> $row[comments] </td>\n";
				echo "</tr>\n";
				}

			echo "</TABLE><BR><BR>\n";
			}
	##### END switch lead log entries #####


	##### BEGIN switch list(for custom fields) log entries #####
		$stmt="SELECT * from vicidial_agent_function_log where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' and function='switch_list' order by event_time desc limit 500;";
		$rslt=mysqli_query($link, $stmt);
		$logs_to_print = mysqli_num_rows($rslt);
		if ($DB) {sd_debug_log("$logs_to_print|$stmt|");}

		if ($logs_to_print > 0)
			{
			echo "<B>"._QXZ("AGENT CUSTOM FIELDS SWITCH-LISTS FOR THIS LEAD").":</B>\n";
			echo "<TABLE width=750 cellspacing=1 cellpadding=1>\n";
			echo "<tr><td><font size=1># </td><td align=left><font size=2> "._QXZ("SWITCH TIME")."</td><td><font size=2>"._QXZ("CAMPAIGN")." </td><td align=left><font size=2>"._QXZ("TSR")." </td><td align=left><font size=2> &nbsp; "._QXZ("TO LIST ID")."</td><td align=left><font size=2> "._QXZ("FROM LIST ID")."</td><td align=left><font size=2> "._QXZ("CALL ID")."</td></tr>\n";


			$u=0;
			while ($logs_to_print > $u)
				{
				$row=mysqli_fetch_array($rslt);
				if (preg_match("/1$|3$|5$|7$|9$/i", $u))
					{$bgcolor="bgcolor=\"#$SSstd_row2_background\"";}
				else
					{$bgcolor="bgcolor=\"#$SSstd_row1_background\"";}

				$u++;
				echo "<tr $bgcolor>";
				echo "<td><font size=1>$u</td>";
				echo "<td align=left><font size=1> $row[event_time] </td>";
				echo "<td align=left><font size=1> $row[campaign_id] </td>\n";
				echo "<td align=left><font size=2> $row[user] </td>\n";
				echo "<td align=left><font size=2> <a href=\"$PHP_SELF?ADD=311&list_id=$row[stage]\">$row[stage]</a> </td>\n";
				echo "<td align=left><font size=2> <a href=\"$PHP_SELF?ADD=311&list_id=$row[stage]\">$row[comments]</a> </td>\n";
				echo "<td align=left><font size=1> $row[caller_code] </td>\n";
				echo "</tr>\n";
				}

			echo "</TABLE><BR><BR>\n";
			}
	##### END switch list log entries #####


	##### vicidial agent outbound calls for this time period #####
		if ($allow_emails>0)
			{
			echo "<B>"._QXZ("OUTBOUND EMAILS FOR THIS LEAD").":</B>\n";
			echo "<TABLE width=750 cellspacing=1 cellpadding=1>\n";
			echo "<tr><td><font size=1># </td><td><font size=2>"._QXZ("DATE/TIME")." </td><td align=right><font size=2> "._QXZ("USER")."</td><td align=right><font size=2> "._QXZ("CAMPAIGN")."</td><td align=left><font size=2>"._QXZ("EMAIL TO")."</td><td align=left><font size=2> "._QXZ("MESSAGE")."</td><td align=right><font size=2> "._QXZ("ATTACHMENTS")."</td></tr>\n";

			$stmt="SELECT * from vicidial_email_log where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' order by email_date desc limit 500;";
			$rslt=mysqli_query($link, $stmt);
			$logs_to_print = mysqli_num_rows($rslt);

			$u=0;
			while ($logs_to_print > $u)
				{
				$row=mysqli_fetch_row($rslt);
				if (preg_match("/1$|3$|5$|7$|9$/i", $u))
					{$bgcolor="bgcolor=\"#$SSstd_row2_background\"";}
				else
					{$bgcolor="bgcolor=\"#$SSstd_row1_background\"";}
				if (strlen($row[6])>100) {$row[6]=substr($row[6],0,100)."...";}
				$row[8]=preg_replace('/\|/', ', ', $row[8]);
				$row[8]=preg_replace('/,\s+$/', '', $row[8]);
				$u++;

				echo "<tr $bgcolor>";
				echo "<td><font size=1>$u</td>";
				echo "<td><font size=1>$row[3]</td>";
				echo "<td align=right><font size=2> <A HREF=\"user_stats.php?lead_id=$row[4]\" target=\"_blank\">$row[4]</A> </td>\n";
				echo "<td align=left><font size=2> $row[7]</td>\n";
				echo "<td align=left><font size=1> $row[5]</td>\n";
				echo "<td align=left><font size=1> $row[6] </td>\n";
				echo "<td align=right><font size=1> $row[8] </td></tr>\n";
				}


			echo "</TABLE><BR><BR>\n";
			}


		$mute_column='';
		if ($SSmute_recordings > 0)
			{
			$mute_column = "<td align=left><font size=2>"._QXZ("MUTE")."</td>";
			}

		echo "<B>"._QXZ("RECORDINGS FOR THIS LEAD").":</B>\n";
		echo "<TABLE width=800 cellspacing=1 cellpadding=1>\n";
		echo "<tr><td><font size=1># </td><td align=left><font size=2> "._QXZ("LEAD")."</td><td><font size=2>"._QXZ("DATE/TIME")." </td><td align=left><font size=2>"._QXZ("SECONDS")." </td><td align=left><font size=2> &nbsp; "._QXZ("RECID")."</td><td align=center><font size=2>"._QXZ("FILENAME")."</td><td align=left><font size=2>"._QXZ("LOCATION")."</td><td align=left><font size=2>"._QXZ("TSR")."</td>$mute_column<td align=left><font size=2> </td></tr>\n";

		$sqlUser = "";
		if($LOGuser_level < 9) {
			$sqlUser = " AND " .GetViewUsr($LOGuser_group);
		}

		$stmt="SELECT recording_id,channel,server_ip,extension,start_time,start_epoch,end_time,end_epoch,length_in_sec,length_in_min,filename,location,lead_id,user,vicidial_id from recording_log where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' $sqlUser order by recording_id desc limit 500;";
		$rslt=mysqli_query($link, $stmt);
		$logs_to_print = mysqli_num_rows($rslt);
		if ($DB) {sd_debug_log("$logs_to_print|$stmt|");}

		$u=0;   $rec_ids="''";
		while ($logs_to_print > $u)
			{
			$row=mysqli_fetch_row($rslt);
			if (preg_match("/1$|3$|5$|7$|9$/i", $u))
				{$bgcolor="bgcolor=\"#$SSstd_row2_background\"";}
			else
				{$bgcolor="bgcolor=\"#$SSstd_row1_background\"";}

			$location = $row[11];

			if (strlen($location)>2)
				{
				$location = GetRealRecordingsURL($location, $link);
				}

			if ($SSmute_recordings > 0)
				{
				$mute_events=0;
				$stmt="SELECT count(*) from vicidial_agent_function_log where user='$row[13]' and event_time >= '$row[4]'  and event_time <= '$row[6]' and function='mute_rec' and lead_id='$row[12]' and stage='on';";
				$rsltx=mysqli_query($link, $stmt);
				$flogs_to_print = mysqli_num_rows($rsltx);
				if ($flogs_to_print > 0)
					{
					$rowx=mysqli_fetch_row($rsltx);
					$mute_events = $rowx[0];
					}
				}

			if (strlen($location)>30)
				{$locat = substr($location,0,27);  $locat = "$locat...";}
			else
				{$locat = $location;}
			$play_audio='<td align=left><font size=2> </font></td>';
			if ( (preg_match('/ftp/i',$location)) or (preg_match('/http/i',$location)) )
				{
				if ($log_recording_access<1)
					{
					$play_audio = "<td align=left><font size=2> <audio controls preload=\"none\"> <source src ='$location' type='audio/wav' > <source src ='$location' type='audio/mpeg' >"._QXZ("No browser audio playback support")."</audio> </td>\n";
					$location = "<a href=\"$location\">$locat</a>";
					}
				else
					{
					$location = "<a href=\"recording_log_redirect.php?recording_id=$row[0]&lead_id=$row[12]&search_archived_data=0\">$locat</a>";
					}
				}
			else
				{$location = $locat;}
			$u++;
			echo "<tr $bgcolor>";
			echo "<td><font size=1>$u</td>";
			echo "<td align=left><font size=2> $row[12] </td>";
			echo "<td align=left><font size=1> $row[4] </td>\n";
			echo "<td align=left><font size=2> $row[8] </td>\n";
			echo "<td align=left><font size=2> $row[0] &nbsp;</td>\n";
			echo "<td align=center><font size=1> $row[10] </td>\n";
			echo "<td align=left><font size=2> $location </td>\n";
			echo "<td align=left><font size=2> <A HREF=\"user_stats.php?user=$row[13]\" target=\"_blank\">$row[13]</A> </td>";
			if ($SSmute_recordings > 0)
				{
				if ($mute_events < 1) {$mute_events='';}
				echo "<td align=center><font size=2> $mute_events &nbsp; </td>\n";
				}
			echo "$play_audio";
			echo "</tr>\n";
			$rec_ids .= ",'$row[0]'";
			}


		if ($archive_log == 'Yes') {
		$stmt="SELECT recording_id,channel,server_ip,extension,start_time,start_epoch,end_time,end_epoch,length_in_sec,length_in_min,filename,location,lead_id,user,vicidial_id from recording_log_archive where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' and recording_id NOT IN($rec_ids) $sqlUser order by recording_id desc limit 500;";
		$rslt=mysqli_query($link, $stmt);
		$logs_to_print = mysqli_num_rows($rslt);
		if ($DB) {sd_debug_log("$logs_to_print|$stmt|");}

		$v=0;
		$u=0;
		while ($logs_to_print > $v)
			{
			$row=mysqli_fetch_row($rslt);
			if (preg_match("/1$|3$|5$|7$|9$/i", $u))
				{$bgcolor="bgcolor=\"#$SSstd_row2_background\"";}
			else
				{$bgcolor="bgcolor=\"#$SSstd_row1_background\"";}

			$location = $row[11];

			if (strlen($location)>2)
				{
				$URLserver_ip = $location;
				$URLserver_ip = preg_replace('/http:\/\//i', '',$URLserver_ip);
				$URLserver_ip = preg_replace('/https:\/\//i', '',$URLserver_ip);
				$URLserver_ip = preg_replace('/\/.*/i', '',$URLserver_ip);
				$stmt="SELECT count(*) from servers where server_ip='$URLserver_ip';";
				$rsltx=mysqli_query($link, $stmt);
				$rowx=mysqli_fetch_row($rsltx);

				if ($rowx[0] > 0)
					{
					$stmt="SELECT recording_web_link,alt_server_ip,external_server_ip from servers where server_ip='$URLserver_ip';";
					$rsltx=mysqli_query($link, $stmt);
					$rowx=mysqli_fetch_row($rsltx);

					if (preg_match("/ALT_IP/i",$rowx[0]))
						{
						$location = preg_replace("/$URLserver_ip/i", "$rowx[1]", $location);
						}
					if (preg_match("/EXTERNAL_IP/i",$rowx[0]))
						{
						$location = preg_replace("/$URLserver_ip/i", "$rowx[2]", $location);
						}
					}
				}

			if ($SSmute_recordings > 0)
				{
				$mute_events=0;
				$stmt="SELECT count(*) from vicidial_agent_function_log where user='$row[13]' and event_time >= '$row[4]'  and event_time <= '$row[6]' and function='mute_rec' and lead_id='$row[12]' and stage='on';";
				$rsltx=mysqli_query($link, $stmt);
				$flogs_to_print = mysqli_num_rows($rsltx);
				if ($flogs_to_print > 0)
					{
					$rowx=mysqli_fetch_row($rsltx);
					$mute_events = $rowx[0];
					}
				}

			if (strlen($location)>30)
				{$locat = substr($location,0,27);  $locat = "$locat...";}
			else
				{$locat = $location;}
			$play_audio='<td align=left><font size=2> </font></td>';
			if ( (preg_match('/ftp/i',$location)) or (preg_match('/http/i',$location)) )
				{
				if ($log_recording_access<1)
					{
					$play_audio = "<td align=left><font size=2> <audio controls preload=\"none\"> <source src ='$location' type='audio/wav' > <source src ='$location' type='audio/mpeg' >"._QXZ("No browser audio playback support")."</audio> </td>\n";
					$location = "<a href=\"$location\">$locat</a>";
					}
				else
					{
					$location = "<a href=\"recording_log_redirect.php?recording_id=$row[0]&lead_id=$row[12]&search_archived_data=1\">$locat</a>";
					}
				}
			else
				{$location = $locat;}
			$u++;
			$v++;

			echo "<tr $bgcolor>";
			echo "<td><font size=1 color='#FF0000'>$u</font></td>";
			echo "<td align=left><font size=2 color='#FF0000'> $row[12] </font></td>";
			echo "<td align=left><font size=1 color='#FF0000'> $row[4] </font></td>\n";
			echo "<td align=left><font size=2> $row[8] </td>\n";
			echo "<td align=left><font size=2> $row[0] &nbsp;</td>\n";
			echo "<td align=center><font size=1> $row[10] </td>\n";
			echo "<td align=left><font size=2> $location *</td>\n";
			echo "<td align=left><font size=2> <A HREF=\"user_stats.php?user=$row[13]\" target=\"_blank\">$row[13]</A> </td>";
			if ($SSmute_recordings > 0)
				{
				if ($mute_events < 1) {$mute_events='';}
				echo "<td align=center><font size=2> $mute_events &nbsp; </td>\n";
				}
			echo "$play_audio";
			echo "</tr>\n";
			}
		}

		echo "</TABLE><BR><BR>\n";
		
		if ($cb > 0)
		{
			echo "<B>"._QXZ("CALLBACKS LOG").":</B>\n";
			echo "<TABLE width=750 cellspacing=0 cellpadding=1>\n";
			echo "<tr><td><font size=1># </td><td><font size=2>"._QXZ("ENTRY TIME")." </td><td><font size=2>"._QXZ("CALLBACK TIME")." </td><td align=left><font size=2>"._QXZ("USER")."</td><td align=left><font size=2> "._QXZ("RECIPIENT")."</td><td align=left><font size=2> "._QXZ("LEAD STATUS")."</td><td align=left><font size=2> "._QXZ("STATUS")."</td><td align=left><font size=2> "._QXZ("LIST")."</td><td align=left><font size=2> "._QXZ("CAMPAIGN")."</td></tr>\n";
			
			echo "$callbacks_log";
			
			echo "</TABLE><BR><BR>\n";
		}

	if ($log_recording_access > 0)
		{
		echo "<B>"._QXZ("RECORDING ACCESS LOG FOR THIS LEAD").":</B>\n";
		echo "<TABLE width=750 cellspacing=1 cellpadding=1>\n";
		echo "<tr><td><font size=1># </td><td align=left><font size=2> "._QXZ("LEAD")."</td><td><font size=2>"._QXZ("DATE/TIME")." </td><td align=left><font size=2>"._QXZ("RECORDING ID")."</td><td align=left><font size=2>"._QXZ("USER")."</td><td align=left><font size=2>"._QXZ("RESULT")." </td><td align=left><font size=2>"._QXZ("IP")." </td></tr>\n";

		$stmt="SELECT recording_id,lead_id,user,access_datetime,access_result,ip from vicidial_recording_access_log where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' order by recording_access_log_id desc limit 500;";
		$rslt=mysqli_query($link, $stmt);
		$logs_to_print = mysqli_num_rows($rslt);
		if ($DB) {sd_debug_log("$logs_to_print|$stmt|");}

		$u=0;
		while ($logs_to_print > $u)
			{
			$row=mysqli_fetch_row($rslt);
			if (preg_match("/1$|3$|5$|7$|9$/i", $u))
				{$bgcolor="bgcolor=\"#$SSstd_row2_background\"";}
			else
				{$bgcolor="bgcolor=\"#$SSstd_row1_background\"";}

			$u++;
			echo "<tr $bgcolor>";
			echo "<td><font size=1>$u</td>";
			echo "<td align=left><font size=2> $row[1] </td>";
			echo "<td align=left><font size=2> $row[3] </td>\n";
			echo "<td align=left><font size=2> $row[0] </td>\n";
			echo "<td align=left><font size=2> $row[2] </td>\n";
			echo "<td align=left><font size=2> $row[4] </td>\n";
			echo "<td align=left><font size=2> $row[5] </td>\n";
			echo "</tr>\n";
			}

		echo "</TABLE><BR><BR>\n";
		}

		$stmt="SELECT count(*) from vicidial_users where user='$PHP_AUTH_USER' and user_level >= 9 and modify_leads='1';";
		if ($DB) {sd_debug_log($stmt);}
		$rslt=mysqli_query($link, $stmt);
		$row=mysqli_fetch_row($rslt);
		$admin_display=$row[0];
		if ($admin_display > 0)
			{
			echo "<a href=\"./admin.php?ADD=720000000000000&stage=$lead_id&category=LEADS\">"._QXZ("Click here to see Lead Modify changes to this lead")."</a><br>\n";
			}
		//Display link to QC if user has QC permissions
		//Get QC User permissions
		$stmt="SELECT qc_enabled,qc_user_level,qc_pass,qc_finish,qc_commit from vicidial_users where user='$PHP_AUTH_USER' and user_level > 1 and active='Y' and qc_enabled='1';";
		if ($DB) {sd_debug_log($stmt);}
		$rslt=mysqli_query($link, $stmt);
		$row=mysqli_fetch_row($rslt);
		$qc_auth=$row[0];
		//Not "qc_" as it will interfere with ADD=4A storage of modified user.
		if ($qc_auth=='1')
			{
			$qcuser_level=$row[1];
			$qcpass=$row[2];
			$qcfinish=$row[3];
			$qccommit=$row[4];
			}
		//Modify menuing to allow qc users into the system (if they have no permission otherwise)
		//Copied Reports-Only user setup for QC-Only user (Poundteam QC setup)
		$qc_only_user=0;
		if ( ($qc_auth > 0) and ($auth < 1) )
			{
			if ($ADD != '881')
				{
				$ADD=100000000000000;
				}
			$qc_only_user=1;
			}

		if ($qcuser_level > 0)
			{
			echo "<br><br><a href=\"qc_modify_lead.php?lead_id=$lead_id\">"._QXZ("Click here to QC Modify this lead")."</a>\n";
			}
		echo "\n";
		}
	}

	if ($enable_gdpr_download_deletion > 0)
		{
		if ($gdpr_display>=1)
			{
			echo "<br><br><br>";
			echo "<B>"._QXZ("GDPR compliance").":</B>\n";
			echo "<TABLE width=750 cellspacing=2 cellpadding=5>\n";
			echo "<tr bgcolor='#$SSstd_row2_background'>";
			echo "<td><font size=2>";
			echo "<a href=\"admin_modify_lead.php?lead_id=$lead_id&gdpr_action=download\">"._QXZ("Click here to download GDPR-formatted data for this lead")."</a><BR>\n";
			echo "</font></td>";
			echo "<tr bgcolor='#$SSstd_row1_background'>";
			echo "<td><font size=2>";
			if ($gdpr_display>=2)
				{
				echo "<a href=\"admin_modify_lead.php?lead_id=$lead_id&gdpr_action=purge\">"._QXZ("Click here to review and purge customer data on lead")."</a>\n";
				}
			echo "</font></td>";
			echo "</tr>";
			echo "</table>";
			}
		}
	echo "\n";


$ENDtime = date("U");

$RUNtime = ($ENDtime - $STARTtime);

echo "\n\n\n<br><br>\n\n";


echo "<font size=0>\n\n\n\n"._("script runtime").": $RUNtime "._("seconds")."<br>".("Version").": ".$admin_modify_lead_version."|".$admin_modify_lead_build."</font>";
echo "</span>\n";


function GetRealRecordingsURL($location, $link) {

    $URLserver_ip = $location;
    $URLserver_ip = preg_replace('/http:\/\//i', '',$URLserver_ip);
    $URLserver_ip = preg_replace('/https:\/\//i', '',$URLserver_ip);
    $URLserver_ip = preg_replace('/\/.*/i', '',$URLserver_ip);
    $stmt="SELECT count(*) from servers where server_ip='$URLserver_ip';";
    $rsltx=mysqli_query($link, $stmt);
    $rowx=mysqli_fetch_row($rsltx);

    if ($rowx[0] > 0) {
        $stmt="SELECT recording_web_link,alt_server_ip,external_server_ip from servers where server_ip='$URLserver_ip';";
        $rsltx=mysqli_query($link, $stmt);
        $rowx=mysqli_fetch_row($rsltx);

        if (preg_match("/ALT_IP/i",$rowx[0])) {
            $location = preg_replace("/$URLserver_ip/i", "$rowx[1]", $location);
        }
        if (preg_match("/EXTERNAL_IP/i",$rowx[0])) {
            $location = preg_replace("/$URLserver_ip/i", "$rowx[2]", $location);
        }
    }
    return $location;
}

function FillSelection($sel, $link) {

    $FSel = "";
    $FSel .= "<select name=\"selection\" size=\"1\">" . PHP_EOL;
    if($sel == "") {
        $FSel .= "<option SELECTED value=\"\">"."</option>" . PHP_EOL;
    } else {
        $FSel .= "<option value=\"\">"."</option>" . PHP_EOL;
    }
    $stmt="SELECT * FROM `snctdialer_lead_selection`;";
    $reslt = mysqli_query($link, $stmt);
    while ($row = mysqli_fetch_array($reslt, MYSQLI_BOTH)) {
        if($sel == $row["selection"]) {
            $FSel .= "<option SELECTED value=\"".$row["selection"]."\">".$row["selection"]."</option>" . PHP_EOL;
        } else {
            $FSel .= "<option value=\"".$row["selection"]."\">".$row["selection"]."</option>" . PHP_EOL;
        }
    }
    $FSel .= "</select>". PHP_EOL;
    
    return $FSel;
}

function FillBlockStatus($BlkSts, $DisStat) {
    
    $ArrBlock = array("free" => _("free to use"), "temporary" => _("temporary blocked"), "blocked" => _("use prohibited"), "full" => _("full blocked"));
    
    $BlockStr = "<select name=\"block_status\" size=\"1\" $DisStat>";
    
    foreach ($ArrBlock as $BlockTest => $v) {
        if($BlockTest == $BlkSts) {
            $BlockStr .= "<option SELECTED value=\"".$BlockTest."\">".$v. "</option>\n";
        } else {
            $BlockStr .= "<option value=\"".$BlockTest."\">".$v. "</option>\n";
        }
    }
    $BlockStr .= "</select>";
    
    return $BlockStr;

}

function FillCustStatus($CustSts) {
    
    $ArrCustSts = array("unknown" => _("unknown"), "privat" => _("privat"), "business" => _("business"));
    
    $RetStr = "<select name=\"customer_status\" size=\"1\">";
    
    foreach ($ArrCustSts as $CustTest => $v) {
        if($CustTest == $CustSts) {
            $RetStr .= "<option SELECTED value=\"".$CustTest."\">".$v. "</option>\n";
        } else {
            $RetStr .= "<option value=\"".$CustTest."\">".$v. "</option>\n";
        }
    }
    $RetStr .= "</select>";
    
    return $RetStr;
    
}



?>


</body>
</html>

<?php

exit;

function htmlparse($text)
	{
	global $htmlconvert;
	if ($htmlconvert > 0)
		{
		return htmlentities($text);
		}
	else
		{
		return $text;
		}
	}



?>
