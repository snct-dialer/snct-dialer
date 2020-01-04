<?php

# vdc_db_query_ng.php
#
# based on vdc_db_query.php
#
# LICENSE: AGPLv3
#
# Copyright (©) 2019-2020 SNCT GmbH <info@snct-gmbh.de>
#               2017-2020 Jörg Frings-Fürst <open_source@jff.email>.

# Changelog
#
# 2019-12-07 10:10 First work
#
#



#
# This script is designed to exchange information between vicidial.php and the database server for various actions
#
# required variables:
#  - $server_ip
#  - $session_name
#  - $user
#  - $pass
# optional variables:
#  - $format - ('text','debug')
#  - $ACTION - ('regCLOSER','regTERRITORY','manDiaLnextCALL','manDiaLskip','manDiaLonly','manDiaLlookCaLL','manDiaLlogCALL','userLOGout','updateDISPO','updateLEAD','VDADpause','VDADready','VDADcheckINCOMING','UpdatEFavoritEs','CalLBacKLisT','CalLBacKCounT','PauseCodeSubmit','LogiNCamPaigns','alt_phone_change','AlertControl','AGENTSview','CALLSINQUEUEview','CALLSINQUEUEgrab','DiaLableLeaDsCounT','UpdateFields','CALLLOGview','LEADINFOview','customer_3way_hangup_process')
#  - $stage - ('start','finish','lookup','new')
#  - $closer_choice - ('CL_TESTCAMP_L CL_OUT123_L -')
#  - $conf_exten - ('8600011',...)
#  - $exten - ('123test',...)
#  - $ext_context - ('default','demo',...)
#  - $ext_priority - ('1','2',...)
#  - $campaign - ('testcamp',...)
#  - $dial_timeout - ('60','26',...)
#  - $dial_prefix - ('9','8',...)
#  - $campaign_cid - ('3125551212','0000000000',...)
#  - $MDnextCID - ('M06301413000000002',...)
#  - $uniqueid - ('1120232758.2406800',...)
#  - $lead_id - ('36524',...)
#  - $list_id - ('101','123456',...)
#  - $length_in_sec - ('12',...)
#  - $phone_code - ('1',...)
#  - $phone_number - ('3125551212',...)
#  - $channel - ('Zap/12-1',...)
#  - $start_epoch - ('1120236911',...)
#  - $vendor_lead_code - ('1234test',...)
#  - $title - ('Mr.',...)
#  - $first_name - ('Bob',...)
#  - $middle_initial - ('L',...)
#  - $last_name - ('Wilson',...)
#  - $address1 - ('1324 Main St.',...)
#  - $address2 - ('Apt. 12',...)
#  - $address3 - ('co Robert Wilson',...)
#  - $city - ('Chicago',...)
#  - $state - ('IL',...)
#  - $province - ('NA',...)
#  - $postal_code - ('60054',...)
#  - $country_code - ('USA',...)
#  - $gender - ('M',...)
#  - $date_of_birth - ('1970-01-01',...)
#  - $alt_phone - ('3125551213',...)
#  - $email - ('bob@bob.com',...)
#  - $security_phrase - ('Hello',...)
#  - $comments - ('Good Customer',...)
#  - $auto_dial_level - ('0','1','1.2',...)
#  - $VDstop_rec_after_each_call - ('0','1')
#  - $conf_silent_prefix - ('7','8','5',...)
#  - $extension - ('123','user123','25-1',...)
#  - $protocol - ('Zap','SIP','IAX2',...)
#  - $user_abb - ('1234','6666',...)
#  - $preview - ('YES','NO',...)
#  - $called_count - ('0','1','2',...)
#  - $agent_log_id - ('123456',...)
#  - $agent_log - ('NO',...)
#  - $favorites_list - (",'cc160','cc100'",...)
#  - $CallBackDatETimE - ('2006-04-21 14:30:00',...)
#  - $recipient - ('ANYONE,'USERONLY')
#  - $callback_id - ('12345','12346',...)
#  - $use_internal_dnc - ('Y','N')
#  - $use_campaign_dnc - ('Y','N')
#  - $omit_phone_code - ('Y','N')
#  - $no_delete_sessions - ('0','1')
#  - $LogouTKicKAlL - ('0','1');
#  - $closer_blended = ('0','1');
#  - $inOUT = ('IN','OUT');
#  - $manual_dial_filter = ('NONE','CAMPLISTS','DNC','CAMPLISTS_DNC')
#  - $agentchannel = ('Zap/1-1','SIP/testing-6ry4i3',...)
#  - $conf_dialed = ('0','1')
#  - $leaving_threeway = ('0','1')
#  - $blind_transfer = ('0','1')
#  - $usegroupalias - ('0','1')
#  - $account - ('DEFAULT',...)
#  - $agent_dialed_number - ('1','')
#  - $agent_dialed_type - ('MANUAL_OVERRIDE','MANUAL_DIALNOW','MANUAL_PREVIEW',...)
#  - $wrapup - ('WRAPUP','')
#  - $vtiger_callback_id - ('16534'...)
#  - $nodeletevdac - ('0','1')
#  - $agent_territories - ('ABC001','ABC002'...)
#  - $alt_num_status - ('0','1')
#  - $DiaL_SecondS - ('0','1','2',...)
#  - $date - ('2010-02-19')
#  - $custom_field_names - ('|start_date|finish_date|favorite_color|')
#  - $call_notes
#  - $disable_alter_custphone = ('N','Y','HIDE')
#  - $old_CID = ('M06301413000000002',...)
#  - $qm_dispo_code
#  - $dial_ingroup
#  - $nocall_dial_flag
#  - $cid_lock = ('0','1')
#  - $pause_trigger = ('','PAUSE')
#
# 
#

$version = '2.14-377';
$build = '191107-1010';
$php_script = 'vdc_db_query_ng.php';
$mel=1;					# Mysql Error Log enabled = 1
$mysql_log_count=824;
$one_mysql_log=0;
$DB=0;
$VD_login=0;
$SSagent_debug_logging=0;
$pause_to_code_jump=0;
$startMS = microtime();

require_once("dbconnect_mysqli.php");
require_once("functions.php");


### If you have globals turned off uncomment these lines
if (isset($_GET["user"]))						{$user=$_GET["user"];}
	elseif (isset($_POST["user"]))				{$user=$_POST["user"];}
if (isset($_GET["pass"]))						{$pass=$_GET["pass"];}
	elseif (isset($_POST["pass"]))				{$pass=$_POST["pass"];}
if (isset($_GET["server_ip"]))					{$server_ip=$_GET["server_ip"];}
	elseif (isset($_POST["server_ip"]))			{$server_ip=$_POST["server_ip"];}
if (isset($_GET["session_name"]))				{$session_name=$_GET["session_name"];}
	elseif (isset($_POST["session_name"]))		{$session_name=$_POST["session_name"];}
if (isset($_GET["format"]))						{$format=$_GET["format"];}
	elseif (isset($_POST["format"]))			{$format=$_POST["format"];}
if (isset($_GET["ACTION"]))						{$ACTION=$_GET["ACTION"];}
	elseif (isset($_POST["ACTION"]))			{$ACTION=$_POST["ACTION"];}
if (isset($_GET["stage"]))						{$stage=$_GET["stage"];}
	elseif (isset($_POST["stage"]))				{$stage=$_POST["stage"];}
if (isset($_GET["closer_choice"]))				{$closer_choice=$_GET["closer_choice"];}
	elseif (isset($_POST["closer_choice"]))		{$closer_choice=$_POST["closer_choice"];}
if (isset($_GET["conf_exten"]))					{$conf_exten=$_GET["conf_exten"];}
	elseif (isset($_POST["conf_exten"]))		{$conf_exten=$_POST["conf_exten"];}
if (isset($_GET["exten"]))						{$exten=$_GET["exten"];}
	elseif (isset($_POST["exten"]))				{$exten=$_POST["exten"];}
if (isset($_GET["ext_context"]))				{$ext_context=$_GET["ext_context"];}
	elseif (isset($_POST["ext_context"]))		{$ext_context=$_POST["ext_context"];}
if (isset($_GET["ext_priority"]))				{$ext_priority=$_GET["ext_priority"];}
	elseif (isset($_POST["ext_priority"]))		{$ext_priority=$_POST["ext_priority"];}
if (isset($_GET["campaign"]))					{$campaign=$_GET["campaign"];}
	elseif (isset($_POST["campaign"]))			{$campaign=$_POST["campaign"];}
if (isset($_GET["dial_timeout"]))				{$dial_timeout=$_GET["dial_timeout"];}
	elseif (isset($_POST["dial_timeout"]))		{$dial_timeout=$_POST["dial_timeout"];}
if (isset($_GET["dial_prefix"]))				{$dial_prefix=$_GET["dial_prefix"];}
	elseif (isset($_POST["dial_prefix"]))		{$dial_prefix=$_POST["dial_prefix"];}
if (isset($_GET["campaign_cid"]))				{$campaign_cid=$_GET["campaign_cid"];}
	elseif (isset($_POST["campaign_cid"]))		{$campaign_cid=$_POST["campaign_cid"];}
if (isset($_GET["MDnextCID"]))					{$MDnextCID=$_GET["MDnextCID"];}
	elseif (isset($_POST["MDnextCID"]))			{$MDnextCID=$_POST["MDnextCID"];}
if (isset($_GET["uniqueid"]))					{$uniqueid=$_GET["uniqueid"];}
	elseif (isset($_POST["uniqueid"]))			{$uniqueid=$_POST["uniqueid"];}
if (isset($_GET["lead_id"]))					{$lead_id=$_GET["lead_id"];}
	elseif (isset($_POST["lead_id"]))			{$lead_id=$_POST["lead_id"];}
if (isset($_GET["list_id"]))					{$list_id=$_GET["list_id"];}
	elseif (isset($_POST["list_id"]))			{$list_id=$_POST["list_id"];}
if (isset($_GET["length_in_sec"]))				{$length_in_sec=$_GET["length_in_sec"];}
	elseif (isset($_POST["length_in_sec"]))		{$length_in_sec=$_POST["length_in_sec"];}
if (isset($_GET["phone_code"]))					{$phone_code=$_GET["phone_code"];}
	elseif (isset($_POST["phone_code"]))		{$phone_code=$_POST["phone_code"];}
if (isset($_GET["phone_number"]))				{$phone_number=$_GET["phone_number"];}
	elseif (isset($_POST["phone_number"]))		{$phone_number=$_POST["phone_number"];}
if (isset($_GET["channel"]))					{$channel=$_GET["channel"];}
	elseif (isset($_POST["channel"]))			{$channel=$_POST["channel"];}
if (isset($_GET["start_epoch"]))				{$start_epoch=$_GET["start_epoch"];}
	elseif (isset($_POST["start_epoch"]))		{$start_epoch=$_POST["start_epoch"];}
if (isset($_GET["dispo_choice"]))				{$dispo_choice=$_GET["dispo_choice"];}
	elseif (isset($_POST["dispo_choice"]))		{$dispo_choice=$_POST["dispo_choice"];}
if (isset($_GET["vendor_lead_code"]))			{$vendor_lead_code=$_GET["vendor_lead_code"];}
	elseif (isset($_POST["vendor_lead_code"]))	{$vendor_lead_code=$_POST["vendor_lead_code"];}
if (isset($_GET["title"]))						{$title=$_GET["title"];}
	elseif (isset($_POST["title"]))				{$title=$_POST["title"];}
if (isset($_GET["first_name"]))					{$first_name=$_GET["first_name"];}
	elseif (isset($_POST["first_name"]))		{$first_name=$_POST["first_name"];}
if (isset($_GET["middle_initial"]))				{$middle_initial=$_GET["middle_initial"];}
	elseif (isset($_POST["middle_initial"]))	{$middle_initial=$_POST["middle_initial"];}
if (isset($_GET["last_name"]))					{$last_name=$_GET["last_name"];}
	elseif (isset($_POST["last_name"]))			{$last_name=$_POST["last_name"];}
if (isset($_GET["address1"]))					{$address1=$_GET["address1"];}
	elseif (isset($_POST["address1"]))			{$address1=$_POST["address1"];}
if (isset($_GET["address2"]))					{$address2=$_GET["address2"];}
	elseif (isset($_POST["address2"]))			{$address2=$_POST["address2"];}
if (isset($_GET["address3"]))					{$address3=$_GET["address3"];}
	elseif (isset($_POST["address3"]))			{$address3=$_POST["address3"];}
if (isset($_GET["city"]))						{$city=$_GET["city"];}
	elseif (isset($_POST["city"]))				{$city=$_POST["city"];}
if (isset($_GET["state"]))						{$state=$_GET["state"];}
	elseif (isset($_POST["state"]))				{$state=$_POST["state"];}
if (isset($_GET["province"]))					{$province=$_GET["province"];}
	elseif (isset($_POST["province"]))			{$province=$_POST["province"];}
if (isset($_GET["postal_code"]))				{$postal_code=$_GET["postal_code"];}
	elseif (isset($_POST["postal_code"]))		{$postal_code=$_POST["postal_code"];}
if (isset($_GET["country_code"]))				{$country_code=$_GET["country_code"];}
	elseif (isset($_POST["country_code"]))		{$country_code=$_POST["country_code"];}
if (isset($_GET["gender"]))						{$gender=$_GET["gender"];}
	elseif (isset($_POST["gender"]))			{$gender=$_POST["gender"];}
if (isset($_GET["date_of_birth"]))				{$date_of_birth=$_GET["date_of_birth"];}
	elseif (isset($_POST["date_of_birth"]))		{$date_of_birth=$_POST["date_of_birth"];}
if (isset($_GET["alt_phone"]))					{$alt_phone=$_GET["alt_phone"];}
	elseif (isset($_POST["alt_phone"]))			{$alt_phone=$_POST["alt_phone"];}
if (isset($_GET["email"]))						{$email=$_GET["email"];}
	elseif (isset($_POST["email"]))				{$email=$_POST["email"];}
if (isset($_GET["security_phrase"]))			{$security_phrase=$_GET["security_phrase"];}
	elseif (isset($_POST["security_phrase"]))	{$security_phrase=$_POST["security_phrase"];}
if (isset($_GET["comments"]))					{$comments=$_GET["comments"];}
	elseif (isset($_POST["comments"]))			{$comments=$_POST["comments"];}
if (isset($_GET["auto_dial_level"]))			{$auto_dial_level=$_GET["auto_dial_level"];}
	elseif (isset($_POST["auto_dial_level"]))	{$auto_dial_level=$_POST["auto_dial_level"];}
if (isset($_GET["VDstop_rec_after_each_call"]))				{$VDstop_rec_after_each_call=$_GET["VDstop_rec_after_each_call"];}
	elseif (isset($_POST["VDstop_rec_after_each_call"]))		{$VDstop_rec_after_each_call=$_POST["VDstop_rec_after_each_call"];}
if (isset($_GET["conf_silent_prefix"]))				{$conf_silent_prefix=$_GET["conf_silent_prefix"];}
	elseif (isset($_POST["conf_silent_prefix"]))	{$conf_silent_prefix=$_POST["conf_silent_prefix"];}
if (isset($_GET["extension"]))					{$extension=$_GET["extension"];}
	elseif (isset($_POST["extension"]))			{$extension=$_POST["extension"];}
if (isset($_GET["protocol"]))					{$protocol=$_GET["protocol"];}
	elseif (isset($_POST["protocol"]))			{$protocol=$_POST["protocol"];}
if (isset($_GET["user_abb"]))					{$user_abb=$_GET["user_abb"];}
	elseif (isset($_POST["user_abb"]))			{$user_abb=$_POST["user_abb"];}
if (isset($_GET["preview"]))					{$preview=$_GET["preview"];}
	elseif (isset($_POST["preview"]))			{$preview=$_POST["preview"];}
if (isset($_GET["called_count"]))				{$called_count=$_GET["called_count"];}
	elseif (isset($_POST["called_count"]))		{$called_count=$_POST["called_count"];}
if (isset($_GET["agent_log_id"]))				{$agent_log_id=$_GET["agent_log_id"];}
	elseif (isset($_POST["agent_log_id"]))		{$agent_log_id=$_POST["agent_log_id"];}
if (isset($_GET["agent_log"]))					{$agent_log=$_GET["agent_log"];}
	elseif (isset($_POST["agent_log"]))			{$agent_log=$_POST["agent_log"];}
if (isset($_GET["favorites_list"]))				{$favorites_list=$_GET["favorites_list"];}
	elseif (isset($_POST["favorites_list"]))	{$favorites_list=$_POST["favorites_list"];}
if (isset($_GET["CallBackDatETimE"]))			{$CallBackDatETimE=$_GET["CallBackDatETimE"];}
	elseif (isset($_POST["CallBackDatETimE"]))	{$CallBackDatETimE=$_POST["CallBackDatETimE"];}
if (isset($_GET["recipient"]))					{$recipient=$_GET["recipient"];}
	elseif (isset($_POST["recipient"]))			{$recipient=$_POST["recipient"];}
if (isset($_GET["callback_id"]))				{$callback_id=$_GET["callback_id"];}
	elseif (isset($_POST["callback_id"]))		{$callback_id=$_POST["callback_id"];}
if (isset($_GET["use_internal_dnc"]))			{$use_internal_dnc=$_GET["use_internal_dnc"];}
	elseif (isset($_POST["use_internal_dnc"]))	{$use_internal_dnc=$_POST["use_internal_dnc"];}
if (isset($_GET["use_campaign_dnc"]))			{$use_campaign_dnc=$_GET["use_campaign_dnc"];}
	elseif (isset($_POST["use_campaign_dnc"]))	{$use_campaign_dnc=$_POST["use_campaign_dnc"];}
if (isset($_GET["omit_phone_code"]))			{$omit_phone_code=$_GET["omit_phone_code"];}
	elseif (isset($_POST["omit_phone_code"]))	{$omit_phone_code=$_POST["omit_phone_code"];}
if (isset($_GET["phone_ip"]))				{$phone_ip=$_GET["phone_ip"];}
	elseif (isset($_POST["phone_ip"]))		{$phone_ip=$_POST["phone_ip"];}
if (isset($_GET["enable_sipsak_messages"]))				{$enable_sipsak_messages=$_GET["enable_sipsak_messages"];}
	elseif (isset($_POST["enable_sipsak_messages"]))	{$enable_sipsak_messages=$_POST["enable_sipsak_messages"];}
if (isset($_GET["status"]))						{$status=$_GET["status"];}
	elseif (isset($_POST["status"]))			{$status=$_POST["status"];}
if (isset($_GET["LogouTKicKAlL"]))				{$LogouTKicKAlL=$_GET["LogouTKicKAlL"];}
	elseif (isset($_POST["LogouTKicKAlL"]))		{$LogouTKicKAlL=$_POST["LogouTKicKAlL"];}
if (isset($_GET["closer_blended"]))				{$closer_blended=$_GET["closer_blended"];}
	elseif (isset($_POST["closer_blended"]))	{$closer_blended=$_POST["closer_blended"];}
if (isset($_GET["inOUT"]))						{$inOUT=$_GET["inOUT"];}
	elseif (isset($_POST["inOUT"]))				{$inOUT=$_POST["inOUT"];}
if (isset($_GET["manual_dial_filter"]))				{$manual_dial_filter=$_GET["manual_dial_filter"];}
	elseif (isset($_POST["manual_dial_filter"]))	{$manual_dial_filter=$_POST["manual_dial_filter"];}
if (isset($_GET["alt_dial"]))					{$alt_dial=$_GET["alt_dial"];}
	elseif (isset($_POST["alt_dial"]))			{$alt_dial=$_POST["alt_dial"];}
if (isset($_GET["agentchannel"]))				{$agentchannel=$_GET["agentchannel"];}
	elseif (isset($_POST["agentchannel"]))		{$agentchannel=$_POST["agentchannel"];}
if (isset($_GET["conf_dialed"]))				{$conf_dialed=$_GET["conf_dialed"];}
	elseif (isset($_POST["conf_dialed"]))		{$conf_dialed=$_POST["conf_dialed"];}
if (isset($_GET["leaving_threeway"]))			{$leaving_threeway=$_GET["leaving_threeway"];}
	elseif (isset($_POST["leaving_threeway"]))	{$leaving_threeway=$_POST["leaving_threeway"];}
if (isset($_GET["hangup_all_non_reserved"]))			{$hangup_all_non_reserved=$_GET["hangup_all_non_reserved"];}
	elseif (isset($_POST["hangup_all_non_reserved"]))	{$hangup_all_non_reserved=$_POST["hangup_all_non_reserved"];}
if (isset($_GET["blind_transfer"]))				{$blind_transfer=$_GET["blind_transfer"];}
	elseif (isset($_POST["blind_transfer"]))	{$blind_transfer=$_POST["blind_transfer"];}
if (isset($_GET["usegroupalias"]))			{$usegroupalias=$_GET["usegroupalias"];}
	elseif (isset($_POST["usegroupalias"]))	{$usegroupalias=$_POST["usegroupalias"];}
if (isset($_GET["account"]))				{$account=$_GET["account"];}
	elseif (isset($_POST["account"]))		{$account=$_POST["account"];}
if (isset($_GET["agent_dialed_number"]))			{$agent_dialed_number=$_GET["agent_dialed_number"];}
	elseif (isset($_POST["agent_dialed_number"]))	{$agent_dialed_number=$_POST["agent_dialed_number"];}
if (isset($_GET["agent_dialed_type"]))				{$agent_dialed_type=$_GET["agent_dialed_type"];}
	elseif (isset($_POST["agent_dialed_type"]))		{$agent_dialed_type=$_POST["agent_dialed_type"];}
if (isset($_GET["wrapup"]))					{$wrapup=$_GET["wrapup"];}
	elseif (isset($_POST["wrapup"]))		{$wrapup=$_POST["wrapup"];}
if (isset($_GET["vtiger_callback_id"]))				{$vtiger_callback_id=$_GET["vtiger_callback_id"];}
	elseif (isset($_POST["vtiger_callback_id"]))	{$vtiger_callback_id=$_POST["vtiger_callback_id"];}
if (isset($_GET["dial_method"]))				{$dial_method=$_GET["dial_method"];}
	elseif (isset($_POST["dial_method"]))		{$dial_method=$_POST["dial_method"];}
if (isset($_GET["no_delete_sessions"]))				{$no_delete_sessions=$_GET["no_delete_sessions"];}
	elseif (isset($_POST["no_delete_sessions"]))	{$no_delete_sessions=$_POST["no_delete_sessions"];}
if (isset($_GET["nodeletevdac"]))				{$nodeletevdac=$_GET["nodeletevdac"];}
	elseif (isset($_POST["nodeletevdac"]))		{$nodeletevdac=$_POST["nodeletevdac"];}
if (isset($_GET["agent_territories"]))			{$agent_territories=$_GET["agent_territories"];}
	elseif (isset($_POST["agent_territories"]))	{$agent_territories=$_POST["agent_territories"];}
if (isset($_GET["alt_num_status"]))				{$alt_num_status=$_GET["alt_num_status"];}
	elseif (isset($_POST["alt_num_status"]))	{$alt_num_status=$_POST["alt_num_status"];}
if (isset($_GET["DiaL_SecondS"]))				{$DiaL_SecondS=$_GET["DiaL_SecondS"];}
	elseif (isset($_POST["DiaL_SecondS"]))		{$DiaL_SecondS=$_POST["DiaL_SecondS"];}
if (isset($_GET["date"]))						{$date=$_GET["date"];}
	elseif (isset($_POST["date"]))				{$date=$_POST["date"];}
if (isset($_GET["custom_field_names"]))				{$FORMcustom_field_names=$_GET["custom_field_names"];}
	elseif (isset($_POST["custom_field_names"]))	{$FORMcustom_field_names=$_POST["custom_field_names"];}
if (isset($_GET["qm_phone"]))			{$qm_phone=$_GET["qm_phone"];}
	elseif (isset($_POST["qm_phone"]))	{$qm_phone=$_POST["qm_phone"];}
if (isset($_GET["manual_dial_call_time_check"]))			{$manual_dial_call_time_check=$_GET["manual_dial_call_time_check"];}
	elseif (isset($_POST["manual_dial_call_time_check"]))	{$manual_dial_call_time_check=$_POST["manual_dial_call_time_check"];}
if (isset($_GET["CallBackLeadStatus"]))				{$CallBackLeadStatus=$_GET["CallBackLeadStatus"];}
	elseif (isset($_POST["CallBackLeadStatus"]))	{$CallBackLeadStatus=$_POST["CallBackLeadStatus"];}
if (isset($_GET["call_notes"]))				{$call_notes=$_GET["call_notes"];}
	elseif (isset($_POST["call_notes"]))	{$call_notes=$_POST["call_notes"];}
if (isset($_GET["search"]))				{$search=$_GET["search"];}
	elseif (isset($_POST["search"]))	{$search=$_POST["search"];}
if (isset($_GET["sub_status"]))				{$sub_status=$_GET["sub_status"];}
	elseif (isset($_POST["sub_status"]))	{$sub_status=$_POST["sub_status"];}
if (isset($_GET["qm_extension"]))			{$qm_extension=$_GET["qm_extension"];}
	elseif (isset($_POST["qm_extension"]))	{$qm_extension=$_POST["qm_extension"];}
if (isset($_GET["disable_alter_custphone"]))			{$disable_alter_custphone=$_GET["disable_alter_custphone"];}
	elseif (isset($_POST["disable_alter_custphone"]))	{$disable_alter_custphone=$_POST["disable_alter_custphone"];}
if (isset($_GET["bu_name"]))			{$bu_name=$_GET["bu_name"];}
	elseif (isset($_POST["bu_name"]))	{$bu_name=$_POST["bu_name"];}
if (isset($_GET["department"]))				{$department=$_GET["department"];}
	elseif (isset($_POST["department"]))	{$department=$_POST["department"];}
if (isset($_GET["group_name"]))				{$group_name=$_GET["group_name"];}
	elseif (isset($_POST["group_name"]))	{$group_name=$_POST["group_name"];}
if (isset($_GET["job_title"]))			{$job_title=$_GET["job_title"];}
	elseif (isset($_POST["job_title"]))	{$job_title=$_POST["job_title"];}
if (isset($_GET["location"]))			{$location=$_GET["location"];}
	elseif (isset($_POST["location"]))	{$location=$_POST["location"];}
if (isset($_GET["old_CID"]))			{$old_CID=$_GET["old_CID"];}
	elseif (isset($_POST["old_CID"]))	{$old_CID=$_POST["old_CID"];}
if (isset($_GET["qm_dispo_code"]))			{$qm_dispo_code=$_GET["qm_dispo_code"];}
	elseif (isset($_POST["qm_dispo_code"]))	{$qm_dispo_code=$_POST["qm_dispo_code"];}
if (isset($_GET["dial_ingroup"]))			{$dial_ingroup=$_GET["dial_ingroup"];}
	elseif (isset($_POST["dial_ingroup"]))	{$dial_ingroup=$_POST["dial_ingroup"];}
if (isset($_GET["nocall_dial_flag"]))			{$nocall_dial_flag=$_GET["nocall_dial_flag"];}
	elseif (isset($_POST["nocall_dial_flag"]))	{$nocall_dial_flag=$_POST["nocall_dial_flag"];}
if (isset($_GET["inbound_lead_search"]))			{$inbound_lead_search=$_GET["inbound_lead_search"];}
	elseif (isset($_POST["inbound_lead_search"]))	{$inbound_lead_search=$_POST["inbound_lead_search"];}
if (isset($_GET["email_enabled"]))			{$email_enabled=$_GET["email_enabled"];}
	elseif (isset($_POST["email_enabled"]))	{$email_enabled=$_POST["email_enabled"];}
if (isset($_GET["email_row_id"]))			{$email_row_id=$_GET["email_row_id"];}
	elseif (isset($_POST["email_row_id"]))	{$email_row_id=$_POST["email_row_id"];}
if (isset($_GET["inbound_email_groups"]))			{$inbound_email_groups=$_GET["inbound_email_groups"];}
	elseif (isset($_POST["inbound_email_groups"]))	{$inbound_email_groups=$_POST["inbound_email_groups"];}
if (isset($_GET["inbound_chat_groups"]))			{$inbound_chat_groups=$_GET["inbound_chat_groups"];}
	elseif (isset($_POST["inbound_chat_groups"]))	{$inbound_chat_groups=$_POST["inbound_chat_groups"];}
if (isset($_GET["recording_id"]))			{$recording_id=$_GET["recording_id"];}
	elseif (isset($_POST["recording_id"]))	{$recording_id=$_POST["recording_id"];}
if (isset($_GET["recording_filename"]))				{$recording_filename=$_GET["recording_filename"];}
	elseif (isset($_POST["recording_filename"]))	{$recording_filename=$_POST["recording_filename"];}
if (isset($_GET["orig_pass"]))			{$orig_pass=$_GET["orig_pass"];}
	elseif (isset($_POST["orig_pass"]))	{$orig_pass=$_POST["orig_pass"];}
if (isset($_GET["cid_lock"]))			{$cid_lock=$_GET["cid_lock"];}
	elseif (isset($_POST["cid_lock"]))	{$cid_lock=$_POST["cid_lock"];}
if (isset($_GET["dispo_comments"]))				{$dispo_comments=$_GET["dispo_comments"];}
	elseif (isset($_POST["dispo_comments"]))	{$dispo_comments=$_POST["dispo_comments"];}
if (isset($_GET["cbcomment_comments"]))				{$cbcomment_comments=$_GET["cbcomment_comments"];}
	elseif (isset($_POST["cbcomment_comments"]))	{$cbcomment_comments=$_POST["cbcomment_comments"];}
if (isset($_GET["parked_hangup"]))			{$parked_hangup=$_GET["parked_hangup"];}
	elseif (isset($_POST["parked_hangup"]))	{$parked_hangup=$_POST["parked_hangup"];}
if (isset($_GET["pause_trigger"]))			{$pause_trigger=$_GET["pause_trigger"];}
	elseif (isset($_POST["pause_trigger"]))	{$pause_trigger=$_POST["pause_trigger"];}
if (isset($_GET["DB"]))					{$DB=$_GET["DB"];}
	elseif (isset($_POST["DB"]))		{$DB=$_POST["DB"];}
if (isset($_GET["in_script"]))			{$in_script=$_GET["in_script"];}
	elseif (isset($_POST["in_script"]))	{$in_script=$_POST["in_script"];}
if (isset($_GET["camp_script"]))			{$camp_script=$_GET["camp_script"];}
	elseif (isset($_POST["camp_script"]))	{$camp_script=$_POST["camp_script"];}
if (isset($_GET["manual_dial_search_filter"]))			{$manual_dial_search_filter=$_GET["manual_dial_search_filter"];}
	elseif (isset($_POST["manual_dial_search_filter"]))	{$manual_dial_search_filter=$_POST["manual_dial_search_filter"];}
if (isset($_GET["url_ids"]))			{$url_ids=$_GET["url_ids"];}
	elseif (isset($_POST["url_ids"]))	{$url_ids=$_POST["url_ids"];}
if (isset($_GET["phone_login"]))			{$phone_login=$_GET["phone_login"];}
	elseif (isset($_POST["phone_login"]))	{$phone_login=$_POST["phone_login"];}
if (isset($_GET["agent_email"]))	{$agent_email=$_GET["agent_email"];}
	elseif (isset($_POST["agent_email"]))	{$agent_email=$_POST["agent_email"];}
if (isset($_GET["original_phone_login"]))	{$original_phone_login=$_GET["original_phone_login"];}
	elseif (isset($_POST["original_phone_login"]))	{$original_phone_login=$_POST["original_phone_login"];}
if (isset($_GET["customer_zap_channel"]))	{$customer_zap_channel=$_GET["customer_zap_channel"];}
	elseif (isset($_POST["customer_zap_channel"]))	{$customer_zap_channel=$_POST["customer_zap_channel"];}
if (isset($_GET["customer_server_ip"]))	{$customer_server_ip=$_GET["customer_server_ip"];}
	elseif (isset($_POST["customer_server_ip"]))	{$customer_server_ip=$_POST["customer_server_ip"];}
if (isset($_GET["phone_pass"]))	{$phone_pass=$_GET["phone_pass"];}
	elseif (isset($_POST["phone_pass"]))	{$phone_pass=$_POST["phone_pass"];}
if (isset($_GET["VDRP_stage"]))	{$VDRP_stage=$_GET["VDRP_stage"];}
	elseif (isset($_POST["VDRP_stage"]))	{$VDRP_stage=$_POST["VDRP_stage"];}
if (isset($_GET["previous_agent_log_id"]))	{$previous_agent_log_id=$_GET["previous_agent_log_id"];}
	elseif (isset($_POST["previous_agent_log_id"]))	{$previous_agent_log_id=$_POST["previous_agent_log_id"];}
if (isset($_GET["last_VDRP_stage"]))	{$last_VDRP_stage=$_GET["last_VDRP_stage"];}
	elseif (isset($_POST["last_VDRP_stage"]))	{$last_VDRP_stage=$_POST["last_VDRP_stage"];}
if (isset($_GET["pause_campaign"]))		{$pause_campaign=$_GET["pause_campaign"];}
	elseif (isset($_POST["pause_campaign"]))	{$pause_campaign=$_POST["pause_campaign"];}
if (isset($_GET["url_link"]))			{$url_link=$_GET["url_link"];}
	elseif (isset($_POST["url_link"]))	{$url_link=$_POST["url_link"];}
if (isset($_GET["newPauseCode"]))		{$newpausecode=$_GET["newPauseCode"];}
	elseif (isset($_POST["newPauseCode"]))	{$newpausecode=$_POST["newPauseCode"];}
if (isset($_GET["user_group"]))				{$user_group=$_GET["user_group"];}
	elseif (isset($_POST["user_group"]))	{$user_group=$_POST["user_group"];}
if (isset($_GET["MgrApr_user"]))			{$MgrApr_user=$_GET["MgrApr_user"];}
	elseif (isset($_POST["MgrApr_user"]))	{$MgrApr_user=$_POST["MgrApr_user"];}
if (isset($_GET["MgrApr_pass"]))			{$MgrApr_pass=$_GET["MgrApr_pass"];}
	elseif (isset($_POST["MgrApr_pass"]))	{$MgrApr_pass=$_POST["MgrApr_pass"];}
if (isset($_GET["routing_initiated_recording"]))			{$routing_initiated_recording=$_GET["routing_initiated_recording"];}
	elseif (isset($_POST["routing_initiated_recording"]))	{$routing_initiated_recording=$_POST["routing_initiated_recording"];}
if (isset($_GET["dead_time"]))			{$dead_time=$_GET["dead_time"];}
	elseif (isset($_POST["dead_time"]))	{$dead_time=$_POST["dead_time"];}
if (isset($_GET["callback_gmt_offset"]))			{$callback_gmt_offset=$_GET["callback_gmt_offset"];}
	elseif (isset($_POST["callback_gmt_offset"]))	{$callback_gmt_offset=$_POST["callback_gmt_offset"];}
if (isset($_GET["callback_timezone"]))			{$callback_timezone=$_GET["callback_timezone"];}
	elseif (isset($_POST["callback_timezone"]))	{$callback_timezone=$_POST["callback_timezone"];}
if (isset($_GET["manual_dial_validation"]))				{$manual_dial_validation=$_GET["manual_dial_validation"];}
    elseif (isset($_POST["manual_dial_validation"]))	{$manual_dial_validation=$_POST["manual_dial_validation"];}
if (isset($_GET["OnlyInbounds"]))				{$OnlyInbounds=$_GET["OnlyInbounds"];}
    elseif (isset($_POST["OnlyInbounds"]))	    {$OnlyInbounds=$_POST["OnlyInbounds"];}
if (isset($_GET["start_date"]))			{$start_date=$_GET["start_date"];}
	elseif (isset($_POST["start_date"])){$start_date=$_POST["start_date"];}
if (isset($_GET["end_date"]))			{$end_date=$_GET["end_date"];}
	elseif (isset($_POST["end_date"]))	{$end_date=$_POST["end_date"];}
if (isset($_GET["customer_sec"]))			{$customer_sec=$_GET["customer_sec"];}
	elseif (isset($_POST["customer_sec"]))	{$customer_sec=$_POST["customer_sec"];}
if (isset($_GET["taskDSgrp"]))			{$taskDSgrp=$_GET["taskDSgrp"];}
	elseif (isset($_POST["taskDSgrp"]))	{$taskDSgrp=$_POST["taskDSgrp"];}

require_once("../tools/system_wide_settings.php");

if(file_exists("options.php")) {
	require_once("options.php");
}

header ("Content-type: text/html; charset=utf-8");
header ("Cache-Control: no-cache, must-revalidate");  // HTTP/1.1
header ("Pragma: no-cache");                          // HTTP/1.0


$txt = '.txt';
$StarTtime = date("U");
$NOW_DATE = date("Y-m-d");
$NOW_TIME = date("Y-m-d H:i:s");
$SQLdate = $NOW_TIME;
$CIDdate = date("mdHis");
$ENTRYdate = date("YmdHis");
$MT[0]='';
$agents='@agents';
$US='_';
while (strlen($CIDdate) > 9) {$CIDdate = substr("$CIDdate", 1);}
$check_time = ($StarTtime - 86400);

$secX = date("U");
$epoch = $secX;
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
$rslt=mysql_to_mysqli($stmt, $link);
	if ($mel > 0) {mysql_error_logging($NOW_TIME,$link,$mel,$stmt,'00545',$user,$server_ip,$session_name,$one_mysql_log);}
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

##### Hangup Cause Dictionary #####
$hangup_cause_dictionary = array(
0 => "Unspecified. No other cause codes applicable.",
1 => "Unallocated (unassigned) number.",
2 => "No route to specified transit network (national use).",
3 => "No route to destination.",
6 => "Channel unacceptable.",
7 => "Call awarded, being delivered in an established channel.",
16 => "Normal call clearing.",
17 => "User busy.",
18 => "No user responding.",
19 => "No answer from user (user alerted).",
20 => "Subscriber absent.",
21 => "Call rejected.",
22 => "Number changed.",
23 => "Redirection to new destination.",
25 => "Exchange routing error.",
27 => "Destination out of order.",
28 => "Invalid number format (address incomplete).",
29 => "Facilities rejected.",
30 => "Response to STATUS INQUIRY.",
31 => "Normal, unspecified.",
34 => "No circuit/channel available.",
38 => "Network out of order.",
41 => "Temporary failure.",
42 => "Switching equipment congestion.",
43 => "Access information discarded.",
44 => "Requested circuit/channel not available.",
50 => "Requested facility not subscribed.",
52 => "Outgoing calls barred.",
54 => "Incoming calls barred.",
57 => "Bearer capability not authorized.",
58 => "Bearer capability not presently available.",
63 => "Service or option not available, unspecified.",
65 => "Bearer capability not implemented.",
66 => "Channel type not implemented.",
69 => "Requested facility not implemented.",
79 => "Service or option not implemented, unspecified.",
81 => "Invalid call reference value.",
88 => "Incompatible destination.",
95 => "Invalid message, unspecified.",
96 => "Mandatory information element is missing.",
97 => "Message type non-existent or not implemented.",
98 => "Message not compatible with call state or message type non-existent or not implemented.",
99 => "Information element / parameter non-existent or not implemented.",
100 => "Invalid information element contents.",
101 => "Message not compatible with call state.",
102 => "Recovery on timer expiry.",
103 => "Parameter non-existent or not implemented - passed on (national use).",
111 => "Protocol error, unspecified.",
127 => "Interworking, unspecified."
);

##### SIP Hangup Cause Dictionary #####
$sip_hangup_cause_dictionary = array(
400 => "Bad Request.",
401 => "Unauthorized.",
402 => "Payment Required.",
403 => "Forbidden.",
404 => "Not Found.",
405 => "Method Not Allowed.",
406 => "Not Acceptable.",
407 => "Proxy Authentication Required.",
408 => "Request Timeout.",
409 => "Conflict.",
410 => "Gone.",
411 => "Length Required.",
412 => "Conditional Request Failed.",
413 => "Request Entity Too Large.",
414 => "Request-URI Too Long.",
415 => "Unsupported Media Type.",
416 => "Unsupported URI Scheme.",
417 => "Unknown Resource-Priority.",
420 => "Bad Extension.",
421 => "Extension Required.",
422 => "Session Interval Too Small.",
423 => "Interval Too Brief.",
424 => "Bad Location Information.",
428 => "Use Identity Header.",
429 => "Provide Referrer Identity.",
433 => "Anonymity Disallowed.",
436 => "Bad Identity-Info.",
437 => "Unsupported Certificate.",
438 => "Invalid Identity Header.",
470 => "Consent Needed.",
480 => "Temporarily Unavailable.",
481 => "Call/Transaction Does Not Exist.",
482 => "Loop Detected..",
483 => "Too Many Hops.",
484 => "Address Incomplete.",
485 => "Ambiguous.",
486 => "Busy Here.",
487 => "Request Terminated.",
488 => "Not Acceptable Here.",
489 => "Bad Event.",
491 => "Request Pending.",
493 => "Undecipherable.",
494 => "Security Agreement Required.",
500 => "Server Internal Error.",
501 => "Not Implemented.",
502 => "Bad Gateway.",
503 => "Service Unavailable.",
504 => "Server Time-out.",
505 => "Version Not Supported.",
513 => "Message Too Large.",
580 => "Precondition Failure.",
600 => "Busy Everywhere.",
603 => "Decline.",
604 => "Does Not Exist Anywhere.",
606 => "Not Acceptable."
);


#############################################
##### START SYSTEM_SETTINGS LOOKUP #####
$stmt = "SELECT use_non_latin,timeclock_end_of_day,agentonly_callback_campaign_lock,alt_log_server_ip,alt_log_dbname,alt_log_login,alt_log_pass,tables_use_alt_log_db,qc_features_active,allow_emails,callback_time_24hour,enable_languages,language_method,agent_debug_logging,default_language,active_modules,allow_chats,default_phone_code,user_new_lead_limit,sip_event_logging FROM system_settings;";
$rslt=mysql_to_mysqli($stmt, $link);
	if ($mel > 0) {mysql_error_logging($NOW_TIME,$link,$mel,$stmt,'00001',$user,$server_ip,$session_name,$one_mysql_log);}
if ($DB) {echo "$stmt\n";}
$qm_conf_ct = mysqli_num_rows($rslt);
if ($qm_conf_ct > 0)
	{
	$row=mysqli_fetch_row($rslt);
	$non_latin =							$row[0];
	$timeclock_end_of_day =					$row[1];
	$agentonly_callback_campaign_lock =		$row[2];
	$alt_log_server_ip =					$row[3];
	$alt_log_dbname =						$row[4];
	$alt_log_login =						$row[5];
	$alt_log_pass =							$row[6];
	$tables_use_alt_log_db =				$row[7];
	$qc_features_active =					$row[8];
	$allow_emails =							$row[9];
	$callback_time_24hour =					$row[10];
	$SSenable_languages =					$row[11];
	$SSlanguage_method =					$row[12];
	$SSagent_debug_logging =				$row[13];
	$SSdefault_language =					$row[14];
	$active_modules =						$row[15];
	$allow_chats =							$row[16];
	$default_phone_code =					$row[17];
	$SSuser_new_lead_limit =				$row[18];
	$SSsip_event_logging =					$row[19];
	$SScall_quota_lead_ranking =			$row[20];
	}
##### END SETTINGS LOOKUP #####
###########################################

if ($non_latin < 1)
	{
	$user=preg_replace("/[^-_0-9a-zA-Z]/","",$user);
	$pass=preg_replace("/\'|\"|\\\\|;| /","",$pass);
	$orig_pass=preg_replace("/[^-_0-9a-zA-Z]/","",$orig_pass);
	$phone_code = preg_replace("/[^0-9a-zA-Z]/","",$phone_code);
	$phone_number = preg_replace("/[^0-9a-zA-Z]/","",$phone_number);
	$status = preg_replace("/[^-_0-9a-zA-Z]/","",$status);
	$MgrApr_user = preg_replace("/[^-_0-9a-zA-Z]/","",$MgrApr_user);
	$MgrApr_pass = preg_replace("/[^-_0-9a-zA-Z]/","",$MgrApr_pass);
	}
else
	{
	$user = preg_replace("/\'|\"|\\\\|;/","",$user);
	$pass=preg_replace("/\'|\"|\\\\|;| /","",$pass);
	$orig_pass = preg_replace("/\'|\"|\\\\|;/","",$orig_pass);
	$status = preg_replace("/\'|\"|\\\\|;/","",$status);
	$MgrApr_user = preg_replace("/\'|\"|\\\\|;/","",$MgrApr_user);
	$MgrApr_pass = preg_replace("/\'|\"|\\\\|;/","",$MgrApr_pass);
	}

$session_name = preg_replace("/\'|\"|\\\\|;/","",$session_name);
$server_ip = preg_replace("/\'|\"|\\\\|;/","",$server_ip);
$alt_phone = preg_replace("/\s/","",$alt_phone);
$phone_code = preg_replace("/\s/","",$phone_code);
$phone_number = preg_replace("/\s/","",$phone_number);
$campaign = preg_replace("/\'|\"|\\\\|;/","",$campaign);
$closer_choice = preg_replace("/\'|\"|\\\\|;/","",$closer_choice);
$lead_id = preg_replace('/[^0-9]/','',$lead_id);
$list_id = preg_replace('/[^0-9]/','',$list_id);
$conf_exten = preg_replace('/[^-_\.0-9a-zA-Z]/','',$conf_exten);
$uniqueid = preg_replace('/[^-_\.0-9a-zA-Z]/','',$uniqueid);
$length_in_sec = preg_replace('/[^0-9]/','',$length_in_sec);
$CallBackDatETimE = preg_replace('/[^- \:_0-9a-zA-Z]/','',$CallBackDatETimE);
$CallBackLeadStatus = preg_replace('/[^-_0-9a-zA-Z]/','',$CallBackLeadStatus);
$DB = preg_replace('/[^0-9]/','',$DB);
$DiaL_SecondS = preg_replace('/[^0-9]/','',$DiaL_SecondS);
$LogouTKicKAlL = preg_replace('/[^0-9]/','',$LogouTKicKAlL);
$MDnextCID = preg_replace('/[^- _0-9a-zA-Z]/','',$MDnextCID);
$VDRP_stage = preg_replace('/[^-_0-9a-zA-Z]/','',$VDRP_stage);
$VDstop_rec_after_each_call = preg_replace('/[^-_0-9a-zA-Z]/','',$VDstop_rec_after_each_call);
$account = preg_replace('/[^-_0-9a-zA-Z]/','',$account);
$agent_dialed_number = preg_replace('/[^-_0-9a-zA-Z]/','',$agent_dialed_number);
$agent_dialed_type = preg_replace('/[^-_0-9a-zA-Z]/','',$agent_dialed_type);
$agent_email = preg_replace("/\'|\"|\\\\|;/","",$agent_email);
$agent_log = preg_replace('/[^-_0-9a-zA-Z]/','',$agent_log);
$agent_log_id = preg_replace('/[^-_0-9a-zA-Z]/','',$agent_log_id);
$agent_territories = preg_replace('/[^- _0-9a-zA-Z]/','',$agent_territories);
$agentchannel = preg_replace("/\'|\"|\\\\/","",$agentchannel);
$alt_dial = preg_replace('/[^-_0-9a-zA-Z]/','',$alt_dial);
$alt_num_status = preg_replace('/[^-_0-9a-zA-Z]/','',$alt_num_status);
$auto_dial_level = preg_replace('/[^-\._0-9a-zA-Z]/','',$auto_dial_level);
$blind_transfer = preg_replace('/[^-_0-9a-zA-Z]/','',$blind_transfer);
$callback_id = preg_replace('/[^-_0-9a-zA-Z]/','',$callback_id);
$called_count = preg_replace('/[^0-9]/','',$called_count);
$camp_script = preg_replace('/[^-_0-9a-zA-Z]/','',$camp_script);
$campaign_cid = preg_replace('/[^-_0-9a-zA-Z]/','',$campaign_cid);
$channel = preg_replace("/\'|\"|\\\\/","",$channel);
$cid_lock = preg_replace('/[^0-9]/','',$cid_lock);
$closer_blended = preg_replace('/[^-_0-9a-zA-Z]/','',$closer_blended);
$conf_dialed = preg_replace('/[^-_0-9a-zA-Z]/','',$conf_dialed);
$conf_silent_prefix = preg_replace('/[^-_0-9a-zA-Z]/','',$conf_silent_prefix);
$custom_field_names = preg_replace("/\'|\"|\\\\|;/","",$custom_field_names);
$customer_server_ip = preg_replace("/\'|\"|\\\\|;/","",$customer_server_ip);
$customer_zap_channel = preg_replace("/\'|\"|\\\\/","",$customer_zap_channel);
$date = preg_replace('/[^-_0-9]/','',$date);
$dial_ingroup = preg_replace('/[^-_0-9a-zA-Z]/','',$dial_ingroup);
$dial_method = preg_replace('/[^-_0-9a-zA-Z]/','',$dial_method);
$dial_prefix = preg_replace('/[^-_0-9a-zA-Z]/','',$dial_prefix);
$dial_timeout = preg_replace('/[^0-9]/','',$dial_timeout);
$disable_alter_custphone = preg_replace('/[^-_0-9a-zA-Z]/','',$disable_alter_custphone);
$dispo_choice = preg_replace('/[^-_0-9a-zA-Z]/','',$dispo_choice);
$email_enabled = preg_replace('/[^0-9]/','',$email_enabled);
$email_row_id = preg_replace('/[^-_0-9a-zA-Z]/','',$email_row_id);
$enable_sipsak_messages = preg_replace('/[^0-9]/','',$enable_sipsak_messages);
$ext_context = preg_replace('/[^-_0-9a-zA-Z]/','',$ext_context);
$ext_priority = preg_replace('/[^-_0-9a-zA-Z]/','',$ext_priority);
$exten = preg_replace("/\'|\"|\\\\|;/","",$exten);
$extension = preg_replace("/\'|\"|\\\\|;/","",$extension);
$favorites_list = preg_replace("/\"|\\\\|;/","",$favorites_list);
$format = preg_replace('/[^-_0-9a-zA-Z]/','',$format);
$gender = preg_replace('/[^-_0-9a-zA-Z]/','',$gender);
$group_name = preg_replace("/\'|\"|\\\\|;/","",$group_name);
$hangup_all_non_reserved = preg_replace('/[^0-9]/','',$hangup_all_non_reserved);
$inOUT = preg_replace('/[^-_0-9a-zA-Z]/','',$inOUT);
$in_script = preg_replace('/[^-_0-9a-zA-Z]/','',$in_script);
$inbound_lead_search = preg_replace('/[^0-9]/','',$inbound_lead_search);
$last_VDRP_stage = preg_replace('/[^-_0-9a-zA-Z]/','',$last_VDRP_stage);
$leaving_threeway = preg_replace('/[^0-9]/','',$leaving_threeway);
$manual_dial_call_time_check = preg_replace('/[^-_0-9a-zA-Z]/','',$manual_dial_call_time_check);
$manual_dial_filter = preg_replace('/[^-_0-9a-zA-Z]/','',$manual_dial_filter);
$manual_dial_search_filter = preg_replace('/[^-_0-9a-zA-Z]/','',$manual_dial_search_filter);
$no_delete_sessions = preg_replace('/[^0-9]/','',$no_delete_sessions);
$nocall_dial_flag = preg_replace('/[^-_0-9a-zA-Z]/','',$nocall_dial_flag);
$nodeletevdac = preg_replace('/[^0-9]/','',$nodeletevdac);
$old_CID = preg_replace('/[^- _0-9a-zA-Z]/','',$old_CID);
$omit_phone_code = preg_replace('/[^-_0-9a-zA-Z]/','',$omit_phone_code);
$original_phone_login = preg_replace("/\'|\"|\\\\|;/","",$original_phone_login);
$parked_hangup = preg_replace('/[^-_0-9a-zA-Z]/','',$parked_hangup);
$pause_trigger = preg_replace('/[^-_0-9a-zA-Z]/','',$pause_trigger);
$phone_login = preg_replace("/\'|\"|\\\\|;/","",$phone_login);
$phone_pass = preg_replace("/\'|\"|\\\\|;/","",$phone_pass);
$preview = preg_replace('/[^-_0-9a-zA-Z]/','',$preview);
$previous_agent_log_id = preg_replace('/[^-_0-9a-zA-Z]/','',$previous_agent_log_id);
$protocol = preg_replace('/[^-_0-9a-zA-Z]/','',$protocol);
$qm_dispo_code = preg_replace('/[^-_0-9a-zA-Z]/','',$qm_dispo_code);
$qm_extension = preg_replace("/\'|\"|\\\\|;/","",$qm_extension);
$qm_phone = preg_replace("/\'|\"|\\\\|;/","",$qm_phone);
$recipient = preg_replace('/[^-_0-9a-zA-Z]/','',$recipient);
$recording_filename = preg_replace("/\'|\"|\\\\|;/","",$recording_filename);
$recording_id = preg_replace('/[^0-9]/','',$recording_id);
$search = preg_replace('/[^-_0-9a-zA-Z]/','',$search);
$stage = preg_replace("/\'|\"|\\\\|;/","",$stage);
$start_epoch = preg_replace("/\'|\"|\\\\|;/","",$start_epoch);
$sub_status = preg_replace('/[^-_0-9a-zA-Z]/','',$sub_status);
$url_ids = preg_replace("/\'|\"|\\\\|;/","",$url_ids);
$use_campaign_dnc = preg_replace('/[^-_0-9a-zA-Z]/','',$use_campaign_dnc);
$use_internal_dnc = preg_replace('/[^-_0-9a-zA-Z]/','',$use_internal_dnc);
$usegroupalias = preg_replace('/[^0-9]/','',$usegroupalias);
$user_abb = preg_replace("/\'|\"|\\\\|;/","",$user_abb);
$vtiger_callback_id = preg_replace("/\'|\"|\\\\|;/","",$vtiger_callback_id);
$wrapup = preg_replace("/\'|\"|\\\\|;/","",$wrapup);
$url_link = preg_replace("/\'|\"|\\\\|;/","",$url_link);
$user_group = preg_replace('/[^-_0-9a-zA-Z]/','',$user_group);
$routing_initiated_recording = preg_replace('/[^-_0-9a-zA-Z]/','',$routing_initiated_recording);
$dead_time = preg_replace('/[^0-9]/','',$dead_time);
$callback_gmt_offset = preg_replace('/[^- \._0-9a-zA-Z]/','',$callback_gmt_offset);
$callback_timezone = preg_replace('/[^-, _0-9a-zA-Z]/','',$callback_timezone);
$manual_dial_validation = preg_replace('/[^-_0-9a-zA-Z]/','',$manual_dial_validation);
$start_date = preg_replace('/[^-_0-9]/','',$start_date);
$end_date = preg_replace('/[^-_0-9]/','',$end_date);
$customer_sec = preg_replace('/[^-_0-9]/','',$customer_sec);

# default optional vars if not set
if (!isset($format))   {$format="text";}
	if ($format == 'debug')	{$DB=1;}
if (!isset($ACTION))   {$ACTION="refresh";}
if (!isset($query_date)) {$query_date = $NOW_DATE;}
if (strlen($SSagent_debug_logging) > 1)
	{
	if ($SSagent_debug_logging == "$user")
		{$SSagent_debug_logging=1;}
	else
		{$SSagent_debug_logging=0;}
	}

$VUselected_language = $SSdefault_language;
$VUuser_new_lead_limit='-1';
$stmt="SELECT selected_language,user_new_lead_limit from vicidial_users where user='$user';";
if ($DB) {echo "|$stmt|\n";}
$rslt=mysql_to_mysqli($stmt, $link);
	if ($mel > 0) {mysql_error_logging($NOW_TIME,$link,$mel,$stmt,'00598',$user,$server_ip,$session_name,$one_mysql_log);}
$sl_ct = mysqli_num_rows($rslt);
if ($sl_ct > 0)
	{
	$row=mysqli_fetch_row($rslt);
	$VUselected_language =		$row[0];
	$VUuser_new_lead_limit =	$row[1];
	}

if ($ACTION == 'LogiNCamPaigns')
	{
	$skip_user_validation=1;
	}
else
	{
	$auth=0;
	$auth_message = user_authorization($user,$pass,'',0,1,0,0,'vdc_db_query');
	if ($auth_message == 'GOOD')
		{$auth=1;}

	if( (strlen($user)<2) or (strlen($pass)<2) or ($auth==0))
		{
		echo _QXZ("Invalid Username/Password:")." |$user|$pass|$auth_message|\n";
		exit;
		}
	else
		{
		if( (strlen($server_ip)<6) or (!isset($server_ip)) or ( (strlen($session_name)<12) or (!isset($session_name)) ) )
			{
			echo _QXZ("Invalid server_ip: %1s or Invalid session_name: %2s",0,'',$server_ip,$session_name)."\n";
			exit;
			}
		else
			{
			$stmt="SELECT count(*) from web_client_sessions where session_name='$session_name' and server_ip='$server_ip';";
			if ($DB) {echo "|$stmt|\n";}
			$rslt=mysql_to_mysqli($stmt, $link);
				if ($mel > 0) {mysql_error_logging($NOW_TIME,$link,$mel,$stmt,'00003',$user,$server_ip,$session_name,$one_mysql_log);}
			$row=mysqli_fetch_row($rslt);
			$SNauth=$row[0];
			  if($SNauth==0)
				{
				echo _QXZ("Invalid session_name:")." |$session_name|$server_ip|\n";
				exit;
				}
			  else
				{
				# do nothing for now
				}
			}
		}
	}

if ($format=='debug')
	{
	echo "<html>\n";
	echo "<head>\n";
	echo "<!-- VERSION: $version     BUILD: $build    USER: $user   server_ip: $server_ip-->\n";
	echo "<title>"._QXZ("VICIDiaL Database Query Script");
	echo "</title>\n";
	echo "</head>\n";
	echo "<BODY BGCOLOR=white marginheight=0 marginwidth=0 leftmargin=0 topmargin=0>\n";
	}


#
# Ab hier neu
#

$DB=0;

$AgentCB = 25;
$LeadCB  = 5;

function CheckCallbacks($User, $Lead) {
	global $link, $DB, $AgentCB, $LeadCB;
	
	$DateTemp = date("Y-m-d H:i:s", strtotime("-1 day", time())); 
	if($AgentCB != 0) {
		$sql = "SELECT COUNT(*) FROM `vicidial_agent_log` WHERE `status` = 'CALLBK' AND `user` = '". $User ."' AND `event_time` >= '". $DateTemp ."';";
		if($DB) { echo $sql; }
		$res = mysqli_query($link, $sql);
		$row = mysqli_fetch_row($res);
		$AnzUCB = $row[0];
		if($AnzUCB > $AgentCB) {
			return 0;
		}
	}
	$DateTemp = date("Y-m-d H:i:s", strtotime("-7 day", time()));
	if($LeadCB != 0) {
		$sql1 = "SELECT COUNT(*) FROM `vicidial_agent_log` WHERE `status` = 'CALLBK' AND `lead_id` = '". $Lead ."' AND `event_time` >= '". $DateTemp ."';";
		if($DB) { echo $sql1; }
		$res1 = mysqli_query($link, $sql1);
		$row1 = mysqli_fetch_row($res1);
		$AnzLCB = $row1[0];
		if($AnzLCB > $LeadCB) {
			return 0;
		}
	}
	return 1;
}

#
# Erzeuge DispoScreen
#
# benötigt:
#  - User
#  - LeadId
#  - customer_sec
#  - taskDSgrp
#

if ($ACTION == 'GenDispoScreen') {
	
	$StartTime = microtime();
	$Return = "";
	if ((isset($user)) && (isset($lead_id)) && (isset($customer_sec)))  {
		$CBAllow = CheckCallbacks($user, $lead_id);
		$Return = "<table cellpadding=\"5\" cellspacing=\"5\" width=\"760px\"><tr><td colspan=\"2\"><b> <?php echo _QXZ('CALL DISPOSITION'); ?></b></td></tr><tr><td bgcolor=\"#99FF99\" height=\"300px\" width=\"240px\" valign=\"top\"><font class=\"log_text\"><span id=\"DispoSelectA\">";
		$sql = "SELECT VLS.`campaign_id` from `vicidial_list` VL, `vicidial_lists` VLS WHERE VL.`lead_id` = '". $lead_id . "' AND VL.`list_id` = VLS.`list_id`;";
		$res = mysqli_query($link, $sql);
		$row = mysqli_fetch_row($res);
		$CampId = $row[0];
		
		if($DB) {
			echo "GDS: Campaign = " . $CampId . PHP_EOL;
		}
		$sql1 = "SELECT * FROM `vicidial_statuses` WHERE `selectable` = 'Y' ORDER BY `Pos` LIMIT 100;";
		$res1 = mysqli_query($link, $sql1);
		while($row1 = mysqli_fetch_array($res1, MYSQLI_BOTH)) {
#			echo $row1["status_name"] . PHP_EOL;
			$CBFlag = "";
			if($row1["scheduled_callback"] == "Y") {
				$CBFlag = "  *";
			}
			if((($row1["min_sec"] > 0) && ($customer_sec < $row1["min_sec"])) || (($row1["max_sec"] > 0) && ($customer_sec > $row1["max_sec"])) || (($CBAllow == 0) && ($row1["scheduled_callback"] == "Y"))) {
				$Return .= "<DEL>" . $row1["status"] . " - " . $row1["status_name"] . "</DEL> " . $CBFlag . "<br /><br />";
			} else {
				if($taskDSgrp == $row1["status"]) {
					$Return .= "<font size=\"3\" face=\"Arial, Helvetica, sans-serif\" style=\"BACKGROUND-COLOR: #FFFFCC\"><b><a href=\"#\" onclick=\"DispoSelect_submit('','','YES');return false;\">" . $row1["status"] . " - " . $row1["status_name"] . "</a> " . $CBFlag . "</b></font><br /><br />";
				} else {
					$Return .= "<font size=\"2\" face=\"Arial, Helvetica, sans-serif\"><a href=\"#\" onclick=\"DispoSelectContent_create('" . $row1["status"] . "','ADD','YES');return false;\" onMouseOver=\"this.style.backgroundColor = '#FFFFCC'\" onMouseOut=\"this.style.backgroundColor = 'transparent'\";>" . $row1["status"] . " - " . $row1["status_name"] . "</a></font> " . $CBFlag . "<br /><br />";
				}
			}
		}
		
		$sql2 = "SELECT * FROM `vicidial_campaign_statuses` WHERE `selectable` = 'Y' AND `campaign_id` = '".$CampId."' ORDER BY `Pos` LIMIT 100;";
		if($DB) { echo $sql2 . PHP_EOL; }
		$res2 = mysqli_query($link, $sql2);
		$Return  .= "</span></font></td><td bgcolor=\"#99FF99\" height=\"300px\" width=\"240px\" valign=\"top\"><font class=\"log_text\"><span id=\"DispoSelectB\">";
		$Pos2 = 10;
		while($row2 = mysqli_fetch_array($res2, MYSQLI_BOTH)) {
#			echo $row2["status_name"] . PHP_EOL;
			$CBFlag = "";
			if($row2["scheduled_callback"] == "Y") {
				$CBFlag = "  *";
			}
			if(($row2["Pos"] > $Pos2) && ($row2["Pos"] != 0)) {
				do {
					$Return .= "<DEL>-------</DEL> <br /><br />";
					$Pos2++;
					if($Pos2 == 20) {
						$Return .= "</span></font></td><td bgcolor=\"#99FF99\" height=\"300px\" width=\"240px\" valign=\"top\"><font class=\"log_text\"><span id=\"DispoSelectC\">";
					}
				} while($row2["Pos"] != $Pos2);
			}
			if((($row2["Pos"] == $Pos2) && ($row2["Pos"] != 0)) || ($row2["Pos"] == 0)) {
				if((($row1["min_sec"] > 0) && ($customer_sec < $row2["min_sec"])) || (($row2["max_sec"] > 0) && ($customer_sec > $row2["max_sec"])) || (($CBAllow == 0) && ($row1["scheduled_callback"] == "Y"))) {
					$Return .= "<DEL>" . $row2["status"] . " - " . $row2["status_name"] . "</DEL> " . $CBFlag . "<br /><br />";
				} else {
					if($taskDSgrp == $row2["status"]) {
						$Return .= "<font size=\"3\" face=\"Arial, Helvetica, sans-serif\" style=\"BACKGROUND-COLOR: #FFFFCC\"><b><a href=\"#\" onclick=\"DispoSelect_submit('','','YES');return false;\">" . $row2["status"] . " - " . $row2["status_name"] . "</a> " . $CBFlag . "</b></font><br /><br />";
					} else {
						$Return .= "<font size=\"2\" face=\"Arial, Helvetica, sans-serif\"><a href=\"#\" onclick=\"DispoSelectContent_create('" . $row2["status"] . "','ADD','YES');return false;\" onMouseOver=\"this.style.backgroundColor = '#FFFFCC'\" onMouseOut=\"this.style.backgroundColor = 'transparent'\";>" . $row2["status"] . " - " . $row2["status_name"] . "</a></font> " . $CBFlag . "<br /><br />";
					}
				}
			}
			$Pos2++;
			if($Pos2 == 20) {
				$Return .= "</span></font></td><td bgcolor=\"#99FF99\" height=\"300px\" width=\"240px\" valign=\"top\"><font class=\"log_text\"><span id=\"DispoSelectC\">";
			}
		}
		
	} else {
		echo "GenDispoScreen: Parameter not set";
#		$Return = "GenDispoScreen: Parameter not set";
	}
	$EndTime = microtime();
	$RunTime = $EndTime - $StartTime;
	
	if($DB) { echo "<br>Runtime: ".$RunTime . "<br>"; }
	echo $Return;
#	return $Return;
}
?>
