<?php
# DNCcom_inbound_filter.php
# 
# Copyright (C) 2017  Matt Florell <vicidial@gmail.com>    LICENSE: AGPLv2
#
# This script searches DNC.COM's scrub service for incoming DID phone numbers
# and returns a blocking match of '1' that will send the call to the Filter route
# DID Filter URL feature in the URL search type with the following URL:
#  VARhttp://server/vicidial/DNCcom_inbound_filter.php?phone=--A--phone_number--B--
#
# This script REQUIRES a Settings Container in the system with ID of: DNCDOTCOM
# For inbound filtering, use the below variable in the settings container:
# USADNC will block federal DNC numbers
# LITIGATOR will block the litigator list, if subscribed
# INVALID will block invalid numbers
#
#INBOUND_FILTER => USADNC,LITIGATOR,INVALID
#
# This code is tested against DNC.COM scrub utility version 2.12
#
# CHANGES
# 170923-1905 - First Build
#

header ("Content-type: text/html; charset=utf-8");

require("dbconnect_mysqli.php");
require("functions.php");

if (isset($_GET["phone"]))				{$phone=$_GET["phone"];}
	elseif (isset($_POST["phone"]))		{$phone=$_POST["phone"];}
if (isset($_GET["DB"]))					{$DB=$_GET["DB"];}
	elseif (isset($_POST["DB"]))		{$DB=$_POST["DB"];}

#############################################
##### START SYSTEM_SETTINGS LOOKUP #####
$stmt = "SELECT use_non_latin,webroot_writable FROM system_settings;";
$rslt=mysql_to_mysqli($stmt, $link);
if ($DB) {echo "$stmt\n";}
$qm_conf_ct = mysqli_num_rows($rslt);
if ($qm_conf_ct > 0)
	{
	$row=mysqli_fetch_row($rslt);
	$non_latin =				$row[0];
	$webroot_writable =			$row[1];
	}
##### END SETTINGS LOOKUP #####
###########################################

if ($non_latin < 1)
	{
	$phone=preg_replace('/[^-_0-9a-zA-Z]/','',$phone);
	}
else
	{
	$phone = preg_replace("/'|\"|\\\\|;/","",$phone);
	}
$filter_count=0;
$ENTRYdate = date("mdHis");

$stmt = "SELECT count(*) FROM vicidial_settings_containers where container_id='DNCDOTCOM';";
$rslt=mysql_to_mysqli($stmt, $link);
if ($DB) {echo "$stmt\n";}
$sc_ct = mysqli_num_rows($rslt);
if ($sc_ct > 0)
	{
	$row=mysqli_fetch_row($rslt);
	$SC_count = $row[0];
	}

if ($SC_count > 0)
	{
	$stmt = "SELECT container_entry FROM vicidial_settings_containers where container_id='DNCDOTCOM';";
	$rslt=mysql_to_mysqli($stmt, $link);
	if ($DB) {echo "$stmt\n";}
	$sc_ct = mysqli_num_rows($rslt);
	if ($sc_ct > 0)
		{
		$row=mysqli_fetch_row($rslt);
		$container_entry =	$row[0];
		$container_ARY = explode("\n",$container_entry);
		$p=0;
		$scrub_url='';
		$flag_invalid=0;
		$flag_dnc=0;
		$flag_litigator=0;
		$container_ct = count($container_ARY);
		while ($p <= $container_ct)
			{
			$line = $container_ARY[$p];
			$line = preg_replace("/\n|\r|\t|\#.*|;.*/",'',$line);
			if (preg_match("/^DNC_DOT_COM_URL/",$line))
				{$scrub_url = $line;   $scrub_url = trim(preg_replace("/.*=>/",'',$scrub_url));}
			if (preg_match("/^LOGIN_ID/",$line))
				{$login_id = $line;   $login_id = trim(preg_replace("/.*=>/",'',$login_id));}
			if (preg_match("/^PROJ_ID/",$line))
				{$project_id = $line;   $project_id = trim(preg_replace("/.*=>/",'',$project_id));}
			if (preg_match("/^CAMPAIGN_ID/",$line))
				{$campaign_id = $line;   $campaign_id = trim(preg_replace("/.*=>/",'',$campaign_id));}
			if (preg_match("/^INBOUND_FILTER/",$line))
				{$in_filter = $line;   $in_filter = trim(preg_replace("/.*=>/",'',$in_filter));}

			$p++;
			}

		$scrub_url .= "?version=2&loginId=" . $login_id . "&phoneList=" . $phone;
		if (strlen($project_id)>0) {$scrub_url .= "&projId=" . $project_id;}
		if (strlen($campaign_id)>0) {$scrub_url .= "&campaignId=" . $campaign_id;}

		### insert a new url log entry
		$uniqueid = $ENTRYdate . '.' . $phone;
		$SQL_log = "$scrub_url";
		$SQL_log = preg_replace('/;|\n/','',$SQL_log);
		$SQL_log = addslashes($SQL_log);
		$stmt = "INSERT INTO vicidial_url_log SET uniqueid='$uniqueid',url_date=NOW(),url_type='DNCcom',url='$SQL_log',url_response='';";
		if ($DB) {echo "$stmt\n";}
		$rslt=mysql_to_mysqli($stmt, $link);
		$affected_rows = mysqli_affected_rows($link);
		$url_id = mysqli_insert_id($link);

		$URLstart_sec = date("U");

		if ($DB > 0) {echo "$scrub_url<BR>\n";}
		$SCUfile = file("$scrub_url");
		if ( !($SCUfile) )
			{
			$error_array = error_get_last();
			$error_type = $error_array["type"];
			$error_message = $error_array["message"];
			$error_line = $error_array["line"];
			$error_file = $error_array["file"];
			}

		if ($DB > 0) {echo "$SCUfile[0]<BR>\n";}

		### update url log entry
		$URLend_sec = date("U");
		$URLdiff_sec = ($URLend_sec - $URLstart_sec);
		if ($SCUfile)
			{
			$SCUfile_contents = implode("", $SCUfile);
			$SCUfile_contents = preg_replace("/;|\n/",'',$SCUfile_contents);
			$SCUfile_contents = addslashes($SCUfile_contents);
			}
		else
			{
			$SCUfile_contents = "PHP ERROR: Type=$error_type - Message=$error_message - Line=$error_line - File=$error_file";
			}
		$stmt = "UPDATE vicidial_url_log SET response_sec='$URLdiff_sec',url_response='$SCUfile_contents' where url_log_id='$url_id';";
		if ($DB) {echo "$stmt\n";}
		$rslt=mysql_to_mysqli($stmt, $link);
		$affected_rows = mysqli_affected_rows($link);

		$result_details = explode(',',$SCUfile_contents);
		if ($result_details[1] == 'D')
			{
			if ( (preg_match("/National \(USA\)/",$SCUfile_contents)) and (preg_match("/USADNC/",$in_filter)) ) 
				{
				$flag_dnc++;
				$filter_count++;
				}
			if ( (preg_match("/Litigator/",$SCUfile_contents)) and (preg_match("/LITIGATOR/",$in_filter)) ) 
				{
				$flag_litigator++;
				$filter_count++;
				}
			}
		if ( ($result_details[1] == 'I') or ( (preg_match("/not a valid number/",$SCUfile_contents)) and (preg_match("/INVALID/",$in_filter)) ) ) 
			{
			$flag_invalid++;
			$filter_count++;
			}

		$stmt = "INSERT INTO vicidial_dnccom_scrub_log SET phone_number='$phone',scrub_date=NOW(),flag_invalid='$flag_invalid',flag_dnc='$flag_dnc',flag_litigator='$flag_litigator',full_response='$SCUfile_contents';";
		if ($DB) {echo "$stmt\n";}
		$rslt=mysql_to_mysqli($stmt, $link);
		$affected_rows = mysqli_affected_rows($link);
		if ($DB) {echo "$affected_rows|$stmt\n";}
		}
	}

echo "$filter_count\n";

?>
