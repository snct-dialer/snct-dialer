<?php
###############################################################################
#
# Modul admin_search_lead.php
#
# SNCT-Dialer™ Search Leads
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
#../tools/format_phone.php
#
###############################################################################
#
# Version  / Build
#
$admin_search_lead_version = '3.0.2-1';
$admin_search_lead_build = '20210110-1';
#
###############################################################################
#
# Changelog#
#
# 2021-01-10 jff	Replace alt_phone_search with a checkbox
# 2020-05-06 jff	Add strlen of $list_id into if clause to search from
#					interal.
# 2020-03-18 jff	Add Global Search
#					Add new Field address1_no
#					Change translation from database to po file
#					Add tool to format phone numbers
#					Reformat result tables
#

require("dbconnect_mysqli.php");
require("functions.php");
require("language_header.php");

require_once ("../tools/format_phone.php");
require_once ("../inc/functions_ng.php");

$PHP_AUTH_USER=$_SERVER['PHP_AUTH_USER'];
$PHP_AUTH_PW=$_SERVER['PHP_AUTH_PW'];
$PHP_SELF=$_SERVER['PHP_SELF'];
if (isset($_GET["vendor_id"]))			{$vendor_id=$_GET["vendor_id"];}
	elseif (isset($_POST["vendor_id"]))	{$vendor_id=$_POST["vendor_id"];}
if (isset($_GET["first_name"]))				{$first_name=$_GET["first_name"];}
	elseif (isset($_POST["first_name"]))	{$first_name=$_POST["first_name"];}
if (isset($_GET["last_name"]))			{$last_name=$_GET["last_name"];}
    elseif (isset($_POST["last_name"]))	{$last_name=$_POST["last_name"];}
if (isset($_GET["address1"]))			{$address1=$_GET["address1"];}
	elseif (isset($_POST["address1"]))	{$address1=$_POST["address1"];}
if (isset($_GET["address1_no"]))			{$address1_no=$_GET["address1_no"];}
	elseif (isset($_POST["address1_no"]))	{$address1_no=$_POST["address1_no"];}
if (isset($_GET["city"]))	      		{$city=$_GET["city"];}
    elseif (isset($_POST["city"]))      {$city=$_POST["city"];}
if (isset($_GET["email"]))			{$email=$_GET["email"];}
	elseif (isset($_POST["email"]))	{$email=$_POST["email"];}
if (isset($_GET["phone"]))				{$phone=$_GET["phone"];}
	elseif (isset($_POST["phone"]))		{$phone=$_POST["phone"];}
if (isset($_GET["lead_id"]))			{$lead_id=$_GET["lead_id"];}
	elseif (isset($_POST["lead_id"]))	{$lead_id=$_POST["lead_id"];}
if (isset($_GET["log_phone"]))				{$log_phone=$_GET["log_phone"];}
	elseif (isset($_POST["log_phone"]))		{$log_phone=$_POST["log_phone"];}
if (isset($_GET["log_lead_id"]))			{$log_lead_id=$_GET["log_lead_id"];}
	elseif (isset($_POST["log_lead_id"]))   {$log_lead_id=$_POST["log_lead_id"];}
if (isset($_GET["log_phone_archive"]))			  {$log_phone_archive=$_GET["log_phone_archive"];}
	elseif (isset($_POST["log_phone_archive"]))	     {$log_phone_archive=$_POST["log_phone_archive"];}
if (isset($_GET["log_lead_id_archive"]))			{$log_lead_id_archive=$_GET["log_lead_id_archive"];}
	elseif (isset($_POST["log_lead_id_archive"]))   {$log_lead_id_archive=$_POST["log_lead_id_archive"];}
if (isset($_GET["submit"]))			     {$submit=$_GET["submit"];}
	elseif (isset($_POST["submit"]))	{$submit=$_POST["submit"];}
if (isset($_GET["SUBMIT"]))				{$SUBMIT=$_GET["SUBMIT"];}
	elseif (isset($_POST["SUBMIT"]))	{$SUBMIT=$_POST["SUBMIT"];}
if (isset($_GET["Global_SUBMIT"]))				{$GLBSUBMIT=$_GET["Global_SUBMIT"];}
	elseif (isset($_POST["Global_SUBMIT"]))	{$GLBSUBMIT=$_POST["Global_SUBMIT"];}
if (isset($_GET["DB"]))					{$DB=$_GET["DB"];}
	elseif (isset($_POST["DB"]))		{$DB=$_POST["DB"];}
if (isset($_GET["status"]))				{$status=$_GET["status"];}
	elseif (isset($_POST["status"]))	{$status=$_POST["status"];}
if (isset($_GET["user"]))				{$user=$_GET["user"];}
	elseif (isset($_POST["user"]))		{$user=$_POST["user"];}
if (isset($_GET["owner"]))				{$owner=$_GET["owner"];}
	elseif (isset($_POST["owner"]))		{$owner=$_POST["owner"];}
if (isset($_GET["list_id"]))			{$list_id=$_GET["list_id"];}
	elseif (isset($_POST["list_id"]))	{$list_id=$_POST["list_id"];}
if (isset($_GET["alt_phone_search"]))			{$alt_phone_search=$_GET["alt_phone_search"];}
	elseif (isset($_POST["alt_phone_search"]))	{$alt_phone_search=$_POST["alt_phone_search"];}
if (isset($_GET["archive_search"]))			{$archive_search=$_GET["archive_search"];}
	elseif (isset($_POST["archive_search"]))	{$archive_search=$_POST["archive_search"];}
if (isset($_GET["called_count"]))			{$called_count=$_GET["called_count"];}
	elseif (isset($_POST["called_count"]))	{$called_count=$_POST["called_count"];}


#############################################
##### START SYSTEM_SETTINGS LOOKUP #####
#$stmt = "SELECT use_non_latin,webroot_writable,outbound_autodial_active,user_territories_active,slave_db_server,reports_use_slave_db,enable_languages,language_method,db_schema_version FROM system_settings;";
$stmt = "SELECT * FROM system_settings;";
$rslt=mysql_to_mysqli($stmt, $link);
if ($DB) {echo "$stmt\n";}
$qm_conf_ct = mysqli_num_rows($rslt);
if ($qm_conf_ct > 0)
	{
	$row=mysqli_fetch_array($rslt);
	$non_latin =					$row["non_latin"];
	$webroot_writable =				$row["webroot_writable"];
	$SSoutbound_autodial_active =	$row["outbound_autodial_active"];
	$user_territories_active =		$row["user_territories_active"];
	$slave_db_server =				$row["slave_db_server"];
	$reports_use_slave_db =			$row["reports_use_slave_db"];
	$SSenable_languages =			$row["enable_languages"];
	$SSlanguage_method =			$row["language_method"];
	$SSdb_schema =					$row["db_schema_version"];
	}
##### END SETTINGS LOOKUP #####
###########################################

$report_name = 'Search Leads Logs';

$DisHousNo = "";
if($SSdb_schema < 1579) {
	$DisHousNo = "disabled";
}

if ($archive_search=="Yes") {$vl_table="vicidial_list_archive";}
else {$vl_table="vicidial_list"; $archive_search="No";}

$vicidial_list_fields = 'lead_id,entry_date,modify_date,status,user,vendor_lead_code,source_id,list_id,gmt_offset_now,called_since_last_reset,phone_code,phone_number,title,first_name,middle_initial,last_name,address1,address2,address3,city,state,province,postal_code,country_code,gender,date_of_birth,alt_phone,email,security_phrase,comments,called_count,last_local_call_time,rank,owner';

$STARTtime = date("U");
$TODAY = date("Y-m-d");
$NOW_TIME = date("Y-m-d H:i:s");
$date = date("r");
$ip = getenv("REMOTE_ADDR");
$browser = getenv("HTTP_USER_AGENT");
$log_archive_link=0;

#if (strlen($alt_phone_search) < 2) {$alt_phone_search='No';}

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
$phone = preg_replace('/[^0-9]/','',$phone);

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
	$VDdisplayMESSAGE = _("Login incorrect, please try again");
	if ($auth_message == 'LOCK')
		{
		$VDdisplayMESSAGE = _("Too many login attempts, try again in 15 minutes");
		Header ("Content-type: text/html; charset=utf-8");
		echo "$VDdisplayMESSAGE: |$PHP_AUTH_USER|$auth_message|\n";
		exit;
		}
	if ($auth_message == 'IPBLOCK')
		{
		$VDdisplayMESSAGE = _("Your IP Address is not allowed") . ": $ip";
		Header ("Content-type: text/html; charset=utf-8");
		echo "$VDdisplayMESSAGE: |$PHP_AUTH_USER|$auth_message|\n";
		exit;
		}
	Header("WWW-Authenticate: Basic realm=\"CONTACT-CENTER-ADMIN\"");
	Header("HTTP/1.0 401 Unauthorized");
	echo "$VDdisplayMESSAGE: |$PHP_AUTH_USER|XXXX|$auth_message|\n";
	exit;
	}

$rights_stmt = "SELECT modify_leads, user_level from vicidial_users where user='$PHP_AUTH_USER';";
if ($DB) {echo "|$stmt|\n";}
$rights_rslt=mysql_to_mysqli($rights_stmt, $link);
$rights_row=mysqli_fetch_row($rights_rslt);
$modify_leads = $rights_row[0];
$AdminLevel   = $rights_row[1];

# check their permissions
if ( $modify_leads < 1 )
	{
	header ("Content-type: text/html; charset=utf-8");
	echo _("You do not have permissions to search leads")."\n";
	exit;
	}

$stmt="SELECT full_name,modify_leads,admin_hide_lead_data,admin_hide_phone_data,user_group,ignore_group_on_search from vicidial_users where user='$PHP_AUTH_USER';";
$rslt=mysql_to_mysqli($stmt, $link);
$row=mysqli_fetch_row($rslt);
$LOGfullname =					$row[0];
$LOGmodify_leads =				$row[1];
$LOGadmin_hide_lead_data =		$row[2];
$LOGadmin_hide_phone_data =		$row[3];
$LOGuser_group =				$row[4];
$LOGignore_group_on_search =	$row[5];

$stmt="SELECT allowed_campaigns,allowed_reports,admin_viewable_groups,admin_viewable_call_times from vicidial_user_groups where user_group='$LOGuser_group';";
if ($DB) {echo "|$stmt|\n";}
$rslt=mysql_to_mysqli($stmt, $link);
$row=mysqli_fetch_row($rslt);
$LOGallowed_campaigns =			$row[0];
$LOGallowed_reports =			$row[1];
$LOGadmin_viewable_groups =		$row[2];
$LOGadmin_viewable_call_times =	$row[3];

$camp_lists='';
$LOGallowed_campaignsSQL='';
$whereLOGallowed_campaignsSQL='';
$LOGallowed_listsSQL='';
$whereLOGallowed_listsSQL='';
if ( (!preg_match('/\-ALL/i', $LOGallowed_campaigns)) and ($LOGignore_group_on_search != '1') )
	{
	$rawLOGallowed_campaignsSQL = preg_replace("/ -/",'',$LOGallowed_campaigns);
	$rawLOGallowed_campaignsSQL = preg_replace("/ /","','",$rawLOGallowed_campaignsSQL);
	$LOGallowed_campaignsSQL = "and campaign_id IN('$rawLOGallowed_campaignsSQL')";
	$whereLOGallowed_campaignsSQL = "where campaign_id IN('$rawLOGallowed_campaignsSQL')";

	$stmt="SELECT list_id from vicidial_lists $whereLOGallowed_campaignsSQL;";
	$rslt=mysql_to_mysqli($stmt, $link);
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
$regexLOGallowed_campaigns = " $LOGallowed_campaigns ";


?>
<html>
<head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
<title>
<?php echo _("ADMINISTRATION: Lead Search");
?>
<script>
var CurlClick = function(URL, Param) {
    object.innerHTML= value;
};
</script>
<?php 

##### BEGIN Set variables to make header show properly #####
$ADD =					'100';
$hh =					'lists';
$sh =					'search';
$LOGast_admin_access =	'1';
$SSoutbound_autodial_active = '1';
$ADMIN =				'admin.php';
$page_width='770';
$section_width='750';
$header_font_size='3';
$subheader_font_size='2';
$subcamp_font_size='2';
$header_selected_bold='<b>';
$header_nonselected_bold='';
$lists_color =		'#FFFF99';
$lists_font =		'BLACK';
$lists_color =		'#E6E6E6';
$subcamp_color =	'#C6C6C6';
##### END Set variables to make header show properly #####

require("admin_header.php");

$label_title =				_("Title");
$label_first_name =			_("First");
$label_middle_initial =		_("MI");
$label_last_name =			_("Last");
$label_address1 =			_("Address1");
$label_address1_no =		_("Address1_No");
$label_address2 =			_("Address2");
$label_address3 =			_("Address3");
$label_city =				_("City");
$label_state =				_("State");
$label_province =			_("Province");
$label_postal_code =		_("Postal Code");
$label_vendor_lead_code =	_("Vendor ID");
$label_gender =				_("Gender");
$label_phone_number =		_("Phone");
$label_phone_code =			_("DialCode");
$label_alt_phone =			_("Alt. Phone");
$label_security_phrase =	_("Show");
$label_email =				_("Email");
$label_comments =			_("Comments");

### find any custom field labels
$stmt="SELECT label_title,label_first_name,label_middle_initial,label_last_name,label_address1,label_address2,label_address3,label_city,label_state,label_province,label_postal_code,label_vendor_lead_code,label_gender,label_phone_number,label_phone_code,label_alt_phone,label_security_phrase,label_email,label_comments from system_settings;";
$rslt=mysql_to_mysqli($stmt, $link);
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


echo " "._("Lead search").": $vendor_id $phone $lead_id $status $list_id $user\n";
#echo date("l F j, Y G:i:s A"). "<br>";
echo strftime("%c");
echo "<BR>\n";

if ( (!$vendor_id) and (!$phone)  and (!$lead_id) and (!$log_phone)  and (!$log_lead_id) and (!$log_phone_archive)  and (!$log_lead_id_archive) and ( (strlen($status)<1) and (strlen($list_id)<1) and (strlen($user)<1) and (strlen($owner)<1) ) and ( (strlen($first_name)<1) and (strlen($last_name)<1) and (strlen($address1)<1) and (strlen($city)<1) and (strlen($email)<1) and (strlen($address1_no)<1) ))
	{
	### Lead search
	echo "<br><center>\n";
	echo "<form method=post name=search action=\"$PHP_SELF\">\n";
	echo "<input type=hidden name=DB value=\"$DB\">\n";
	echo "<TABLE CELLPADDING=3 CELLSPACING=3>";
	echo "<TR bgcolor=#$SSmenu_background>";
	echo "<TD colspan=3 align=center><font color=#FFFFFF><b>"._("Lead Search Options").":</b></font></TD>";
	echo "</TR>";

	$archive_stmt="SHOW TABLES LIKE '%vicidial_list_archive%'";
	$archive_rslt=mysql_to_mysqli($archive_stmt, $link);
	if (mysqli_num_rows($archive_rslt)>0)
		{
		echo "<TR bgcolor=#$SSstd_row2_background>";
		echo "<TD ALIGN=right>"._("Archive search").": &nbsp; </TD><TD ALIGN=left><select size=1 name=archive_search><option value='No'>"._("No")."</option><option value='Yes'>"._("Yes")."</option><option	SELECTED value='$archive_search'>"._("$archive_search")."</option></select></TD>";
		echo "<TD> &nbsp; </TD>\n";
		echo "</TR><TR bgcolor=#$SSmenu_background>";
		echo "<TD colspan=3 align=center height=1></TD></TR>";
		}

	echo "<TR bgcolor=#$SSstd_row2_background>";
	echo "<TD ALIGN=right>$label_vendor_lead_code("._("vendor lead code")."): &nbsp; </TD><TD ALIGN=left><input type=text name=vendor_id size=10 maxlength=20></TD>";
	echo "<TD><INPUT TYPE=SUBMIT NAME=SUBMIT VALUE='"._("SUBMIT")."'></TD>\n";
	echo "</TR><TR bgcolor=#$SSmenu_background>";
	echo "<TD colspan=3 align=center height=1></TD>";
	echo "</TR><TR bgcolor=#$SSstd_row2_background>";

	echo "<TD ALIGN=right>$label_phone_number: &nbsp; </TD><TD ALIGN=left><input type=text name=phone size=14 maxlength=18></TD>";
	echo "<TD rowspan=2><INPUT TYPE=SUBMIT NAME=SUBMIT VALUE='"._("SUBMIT")."'></TD>\n";
	echo "</TR><TR bgcolor=#$SSstd_row2_background>";
	
	$CLSta = "";
	if($alt_phone_search != "") {
		$CLSta = "checked=\"checked\"";
	}
	echo "<TD ALIGN=right>$label_alt_phone "._("search").": &nbsp; </TD><TD ALIGN=left><input type='checkbox' name='alt_phone_search' value='AltPhoneSearch' ". $CLSta ."></TD>";

	echo "</TR><TR bgcolor=#$SSmenu_background>";
	echo "<TD colspan=3 align=center height=1></TD>";
	echo "</TR><TR bgcolor=#$SSstd_row2_background>";

	echo "<TD ALIGN=right>"._("Lead ID").": &nbsp; </TD><TD ALIGN=left><input type=text name=lead_id size=10 maxlength=10></TD>";
	echo "<TD><INPUT TYPE=SUBMIT NAME=SUBMIT VALUE='"._("SUBMIT")."'></TD>\n";
	echo "</TR><TR bgcolor=#$SSmenu_background>";
	echo "<TD colspan=3 align=center height=3></TD>";
	echo "</TR><TR bgcolor=#$SSstd_row2_background>";

	echo "<TD ALIGN=right>* "._("Status").": &nbsp; </TD><TD ALIGN=left><input type=text name=status size=7 maxlength=6></TD>";
#	echo "<TD rowspan=4><INPUT TYPE=SUBMIT NAME=SUBMIT VALUE='"._("SUBMIT")."'></TD>\n";
	echo "</TR><TR bgcolor=#$SSstd_row2_background>";
	echo "<TD ALIGN=right>* "._("List ID").": &nbsp; </TD><TD ALIGN=left><input type=text name=list_id size=15 maxlength=14></TD>";
	echo "</TR><TR bgcolor=#$SSstd_row2_background>";
	echo "<TD ALIGN=right>* "._("User").": &nbsp; </TD><TD ALIGN=left><input type=text name=user size=15 maxlength=20></TD>";
	echo "</TR><TR bgcolor=#$SSstd_row2_background>";
	echo "<TD ALIGN=right>* "._("Owner").": &nbsp; </TD><TD ALIGN=left><input type=text name=owner size=15 maxlength=50></TD>";
	echo "</TR><TR bgcolor=#$SSmenu_background>";
	echo "<TD colspan=3 align=center height=1></TD>";
	echo "</TR><TR bgcolor=#$SSstd_row2_background>";

	echo "<TD ALIGN=right>* $label_first_name: &nbsp;</TD><TD ALIGN=left><input type=text name=first_name size=15 maxlength=30></TD>";
#	echo "<TD rowspan=5><INPUT TYPE=SUBMIT NAME=SUBMIT VALUE='"._("SUBMIT")."'></TD>\n";
	echo "</TR><TR bgcolor=#$SSstd_row2_background>";
	echo "<TD ALIGN=right>* $label_last_name: &nbsp; </TD><TD ALIGN=left><input type=text name=last_name size=15 maxlength=30></TD>";
	echo "</TR><TR bgcolor=#$SSstd_row2_background>";
	echo "<TD ALIGN=right>* $label_address1: &nbsp; </TD><TD ALIGN=left><input type=text name=address1 size=15 maxlength=30></TD>";
	echo "</TR><TR bgcolor=#$SSstd_row2_background>";
	echo "<TD ALIGN=right>* $label_address1_no: &nbsp; </TD><TD ALIGN=left><input type=text name=address1_no size=10 maxlength=10 $DisHousNo ></TD>";
	echo "</TR><TR bgcolor=#$SSstd_row2_background>";
	echo "<TD ALIGN=right>* $label_city: &nbsp; </TD><TD ALIGN=left><input type=text name=city size=15 maxlength=30></TD>";
	echo "</TR><TR bgcolor=#$SSmenu_background>";

	echo "<TD colspan=3 align=center height=1></TD>";
	echo "</TR><TR bgcolor=#$SSstd_row2_background>";
	echo "<TD ALIGN=right>* $label_email: &nbsp; </TD><TD ALIGN=left><input type=text name=email size=15 maxlength=255></TD>";
#	echo "<TD><INPUT TYPE=SUBMIT NAME=SUBMIT VALUE='"._("SUBMIT")."'></TD>\n";
	echo "</TR><TR bgcolor=#$SSstd_row2_background>";
	
	echo "</TR><TR bgcolor=#$SSmenu_background>";
	echo "<TD colspan=3 align=center height=1></TD>";
	echo "</TR><TR><TD colspan=2 >"._("All fields marked with * are evaluated,")."<br>"._("if 2 or more fields are filled in.")."</TD>";
	echo "<TD><INPUT TYPE=SUBMIT NAME=Global_SUBMIT VALUE='"._("Global-SUBMIT")."'></TD>\n";
	echo "</TR><TR bgcolor=#$SSstd_row2_background>";
	echo "</TR>";


	### Log search
	echo "<br><center>\n";
	echo "<TD colspan=3 align=center> &nbsp; </TD>";
	echo "</TR><TR bgcolor=#$SSmenu_background>";
	echo "<TD colspan=3 align=center><font color=#FFFFFF><b>"._("Log Search Options").":</b></font></TD>";
	echo "</TR><TR bgcolor=#$SSstd_row2_background>";

	echo "<TD ALIGN=right>"._("Lead ID").": &nbsp; </TD><TD ALIGN=left><input type=text name=log_lead_id size=10 maxlength=10></TD>";
	echo "<TD><INPUT TYPE=SUBMIT NAME=SUBMIT VALUE='"._("SUBMIT")."'></TD>\n";
	echo "</TR><TR bgcolor=#$SSmenu_background>";
	echo "<TD colspan=3 align=cente height=1></TD>";
	echo "</TR><TR bgcolor=#$SSstd_row2_background>";

	echo "<TD ALIGN=right>$label_phone_number "._("Dialed").": &nbsp; </TD><TD ALIGN=left><input type=text name=log_phone size=18 maxlength=18></TD>";
	echo "<TD><INPUT TYPE=SUBMIT NAME=SUBMIT VALUE='"._("SUBMIT")."'></TD>\n";
	echo "</TR><TR>";
	echo "<TD colspan=3 align=center> &nbsp; </TD>";
	echo "</TR>";
	echo "<TR bgcolor=#$SSmenu_background>";
	echo "<TD colspan=3 align=center><font color=#FFFFFF><b>"._("Archived Log Search Options").":</b></font></TD>";
	echo "</TR><TR bgcolor=#$SSstd_row2_background>";

	echo "<TD ALIGN=right>"._("Lead ID").": &nbsp; </TD><TD ALIGN=left><input type=text name=log_lead_id_archive size=10 maxlength=10></TD>";
	echo "<TD><INPUT TYPE=SUBMIT NAME=SUBMIT VALUE='"._("SUBMIT")."'></TD>\n";
	echo "</TR><TR bgcolor=#$SSmenu_background>";
	echo "<TD colspan=3 align=center height=1></TD>";
	echo "</TR><TR bgcolor=#$SSstd_row2_background>";

	echo "<TD ALIGN=right>$label_phone_number "._("Dialed").": &nbsp; </TD><TD ALIGN=left><input type=text name=log_phone_archive size=18 maxlength=18></TD>";
	echo "<TD><INPUT TYPE=SUBMIT NAME=SUBMIT VALUE='"._("SUBMIT")."'></TD>\n";
	echo "</TR><TR>";
	echo "<TD colspan=3 align=center> &nbsp; </TD>";
	echo "</TR><TR bgcolor=#$SSstd_row2_background>";


	echo "</TABLE>\n";
	echo "</form>\n</center>\n";
	echo "</body></html>\n";
	exit;
	}

else
	if ((strlen($GLBSUBMIT) > 1) || (strlen($list_id) > 0)) {
		
		$AnzPara = 0;
		$first_nameSQL = "";
		if(strlen($first_name) > 0) {
			$AnzPara++;
			$first_nameSQL = "first_name LIKE '" . mysqli_real_escape_string($link, $first_name) . "'";
		}
		$CCQL = "";
		if(strlen($called_count) > 0) {
			$AnzPara++;
			$CCSQL = "called_count = '" . mysqli_real_escape_string($link, $called_count) . "'";
		}
		$last_nameSQL = "";
		if(strlen($last_name) > 0) {
			if($AnzPara > 0) { 
				$tmpSQL = " AND ";
			}
			$last_nameSQL = "$tmpSQL last_name LIKE '" . mysqli_real_escape_string($link, $last_name) . "'";
			$AnzPara++;
		}
		$address1SQL = "";
		if(strlen($address1) > 0) {
			if($AnzPara > 0) {
				$tmpSQL = " AND ";
			}
			$address1SQL = "$tmpSQL address1 LIKE '" . mysqli_real_escape_string($link, $address1) . "'";
			$AnzPara++;
		}
		$address1_noSQL = "";
		if(strlen($address1_no) > 0) {
			if($AnzPara > 0) {
				$tmpSQL = " AND ";
			}
			$address1_noSQL = "$tmpSQL address1_no LIKE '" . mysqli_real_escape_string($link, $address1_no) . "'";
			$AnzPara++;
		}
		$citySQL = "";
		if(strlen($city) > 0) {
			if($AnzPara > 0) {
				$tmpSQL = " AND ";
			}
			$citySQL = "$tmpSQL city LIKE '" . mysqli_real_escape_string($link, $city) . "'";
			$AnzPara++;
		}
		$userSQL = "";
		if(strlen($user) > 0) {
			if($AnzPara > 0) {
				$tmpSQL = " AND ";
			}
			$userSQL = "$tmpSQL user =  '" . mysqli_real_escape_string($link, $user) . "'";
			$AnzPara++;
		}
		$ownerSQL = "";
		if(strlen($owner) > 0) {
			if($AnzPara > 0) {
				$tmpSQL = " AND ";
			}
			$ownerSQL = "$tmpSQL owner =  '" . mysqli_real_escape_string($link, $owner) . "'";
			$AnzPara++;
		}
		$list_idSQL = "";
		if(strlen($list_id) > 0) {
			if($AnzPara > 0) {
				$tmpSQL = " AND ";
			}
			$list_idSQL = "$tmpSQL list_id =  '" . mysqli_real_escape_string($link, $list_id) . "'";
			$AnzPara++;
		}
		$emailSQL = "";
		if(strlen($email) > 0) {
			if($AnzPara > 0) {
				$tmpSQL = " AND ";
			}
			$list_idSQL = "$tmpSQL email LIKE  '" . mysqli_real_escape_string($link, $email) . "'";
			$AnzPara++;
			$AnzPara++;
		}
		$statusSQL = "";
		if(strlen($status) > 0) {
			if($AnzPara > 0) {
				$tmpSQL = " AND ";
			}
			$statusSQL = "$tmpSQL status =  '" . mysqli_real_escape_string($link, $status) . "'";
			$AnzPara++;
		}
		if(($AnzPara < 2) && ($AdminLevel < 9)) {
			echo "\n<br><br><center>\n";
			echo "<b>"._("You must use 2 or more fields for this function!")."</b><br><br>\n";
			echo "</center>\n";
			echo "\n\n\n<br><br><br>\n<a href=\"$PHP_SELF\">"._("NEW SEARCH")."</a>";
			echo "</body></html>\n";
			exit;
		} else {
			$stmt = "";
			if($AdminLevel < 9) {
				$stmt = "SET STATEMENT max_statement_time=15 FOR ";
			}
			$stmt .= "SELECT $vicidial_list_fields from $vl_table where $first_nameSQL $CCSQL $last_nameSQL $address1SQL $address1_noSQL $citySQL $userSQL $ownerSQL $list_idSQL $email_SQL $statusSQL $LOGallowed_listsSQL LIMIT 5000;";
			if($DB) {
				echo $stmt;
			}
			### LOG INSERTION Search Log Table ###
			$SQL_log = "$stmt|";
			$SQL_log = preg_replace('/;/', '', $SQL_log);
			$SQL_log = addslashes($SQL_log);
			$stmtL="INSERT INTO vicidial_lead_search_log set event_date='$NOW_TIME', user='$PHP_AUTH_USER', source='admin', results='0', search_query=\"$SQL_log\";";
			if ($DB) {echo "|$stmtL|\n";}
			$rslt=mysql_to_mysqli($stmtL, $link);
			$search_log_id = mysqli_insert_id($link);
			
			if ( (strlen($slave_db_server)>5) and (preg_match("/$report_name/",$reports_use_slave_db)) )
			{
				mysqli_close($link);
				$use_slave_server=1;
				$db_source = 'S';
				require("dbconnect_mysqli.php");
				echo "<!-- Using slave server $slave_db_server $db_source -->\n";
			}
			
			if($rslt=mysql_to_mysqli("$stmt", $link)) {
				$results_to_print = mysqli_num_rows($rslt);
				if ( ($results_to_print < 1) and ($results_to_printX < 1) )
				{
					echo strftime("%c");
					echo "\n<br><br><center>\n";
					echo "<b>"._("The search variables you entered are not active in the system")."</b><br><br>\n";
					echo "<b>"._("Please go back and double check the information you entered and submit again")."</b>\n";
					echo "</center>\n";
					echo "</body></html>\n";
					exit;
				}
				else
				{
					echo "<b>"._("RESULTS").": $results_to_print</b><BR><BR>\n";
					echo "<TABLE BGCOLOR=WHITE CELLPADDING=1 CELLSPACING=0 WIDTH=770>\n";
					echo "<TR BGCOLOR=BLACK>\n";
					echo "<TD ALIGN=LEFT VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>#</B></FONT></TD>\n";
					echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("LEAD ID")."</B> &nbsp;</FONT></TD>\n";
					echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("STATUS")."</B> &nbsp;</FONT></TD>\n";
					echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("VENDOR ID")."</B> &nbsp;</FONT></TD>\n";
					echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("LAST AGENT")."</B> &nbsp;</FONT></TD>\n";
					echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("LIST ID")."</B> &nbsp;</FONT></TD>\n";
					echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("PHONE")."</B> &nbsp;</FONT></TD>\n";
					echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("NAME")."</B> &nbsp;</FONT></TD>\n";
					echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("CITY")."</B> &nbsp;</FONT></TD>\n";
					echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("SECURITY")."</B> &nbsp;</FONT></TD>\n";
					echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("LAST CALL")."</B></FONT></TD>\n";
					echo "</TR>\n";
					$o=0;
					while ($results_to_print > $o)
					{
						$row=mysqli_fetch_row($rslt);
						if ($LOGadmin_hide_phone_data != '0')
						{
							if ($DB > 0) {echo "HIDEPHONEDATA|$row[11]|$LOGadmin_hide_phone_data|\n";}
							$phone_temp = $row[11];
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
							if ($DB > 0) {echo "HIDELEADDATA|$row[5]|$row[6]|$row[12]|$row[13]|$row[14]|$row[15]|$row[16]|$row[17]|$row[18]|$row[19]|$row[20]|$row[21]|$row[22]|$row[26]|$row[27]|$row[28]|$LOGadmin_hide_lead_data|\n";}
							if (strlen($row[5]) > 0)
							{$data_temp = $row[5];   $row[5] = preg_replace("/./",'X',$data_temp);}
							if (strlen($row[6]) > 0)
							{$data_temp = $row[6];   $row[6] = preg_replace("/./",'X',$data_temp);}
							if (strlen($row[12]) > 0)
							{$data_temp = $row[12];   $row[12] = preg_replace("/./",'X',$data_temp);}
							if (strlen($row[13]) > 0)
							{$data_temp = $row[13];   $row[13] = preg_replace("/./",'X',$data_temp);}
							if (strlen($row[14]) > 0)
							{$data_temp = $row[14];   $row[14] = preg_replace("/./",'X',$data_temp);}
							if (strlen($row[15]) > 0)
							{$data_temp = $row[15];   $row[15] = preg_replace("/./",'X',$data_temp);}
							if (strlen($row[16]) > 0)
							{$data_temp = $row[16];   $row[16] = preg_replace("/./",'X',$data_temp);}
							if (strlen($row[17]) > 0)
							{$data_temp = $row[17];   $row[17] = preg_replace("/./",'X',$data_temp);}
							if (strlen($row[18]) > 0)
							{$data_temp = $row[18];   $row[18] = preg_replace("/./",'X',$data_temp);}
							if (strlen($row[19]) > 0)
							{$data_temp = $row[19];   $row[19] = preg_replace("/./",'X',$data_temp);}
							if (strlen($row[20]) > 0)
							{$data_temp = $row[20];   $row[20] = preg_replace("/./",'X',$data_temp);}
							if (strlen($row[21]) > 0)
							{$data_temp = $row[21];   $row[21] = preg_replace("/./",'X',$data_temp);}
							if (strlen($row[22]) > 0)
							{$data_temp = $row[22];   $row[22] = preg_replace("/./",'X',$data_temp);}
							if (strlen($row[26]) > 0)
							{$data_temp = $row[26];   $row[26] = preg_replace("/./",'X',$data_temp);}
							if (strlen($row[27]) > 0)
							{$data_temp = $row[27];   $row[27] = preg_replace("/./",'X',$data_temp);}
							if (strlen($row[28]) > 0)
							{$data_temp = $row[28];   $row[28] = preg_replace("/./",'X',$data_temp);}
						}
						
						$o++;
						$search_lead = $row[0];
						if (preg_match('/1$|3$|5$|7$|9$/i', $o))
						{$bgcolor='bgcolor="#'. $SSstd_row2_background .'"';}
						else
						{$bgcolor='bgcolor="#'. $SSstd_row1_background .'"';}
						echo "<TR $bgcolor>\n";
						echo "<TD ALIGN=LEFT><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$o</FONT></TD>\n";
						echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1><a href=\"admin_modify_lead.php?lead_id=$row[0]&archive_search=$archive_search&archive_log=$log_archive_link\" target=\"_blank\">$row[0]</a></FONT></TD>\n";
#						echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1><a href=\"".curl_post_url("admin_modify_lead.php", "lead_id=$row[0]&archive_search=$archive_search&archive_log=$log_archive_link"). "\" target=\"_blank\">$row[0]</a></FONT></TD>\n";
						echo "<TD ALIGN=RIGHT><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[3]</FONT></TD>\n";
						echo "<TD ALIGN=RIGHT><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[5]</FONT></TD>\n";
						echo "<TD ALIGN=RIGHT><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[4]</FONT></TD>\n";
						echo "<TD ALIGN=RIGHT><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[7]</FONT></TD>\n";
						$phTemp = FormatPhoneNr($row[10], $row[11]);
						echo "<TD ALIGN=RIGHT nowrap><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$phTemp</FONT></TD>\n";
						echo "<TD ALIGN=RIGHT nowrap><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[13] $row[15]</FONT></TD>\n";
						echo "<TD ALIGN=RIGHT><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[19]</FONT></TD>\n";
						echo "<TD ALIGN=RIGHT><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[28]</FONT></TD>\n";
						echo "<TD ALIGN=LEFT nowrap><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>".strftime("%c", strtotime($row[31]))."</FONT></TD>\n";
						echo "</TR>\n";
					}
					echo "</TABLE>\n";
				}
			} else {
				
				if($err = mysqli_error($link)) {
					echo date("l F j, Y G:i:s A");
					echo strftime("%c");
					echo "\n<br><br><center>\n";
					echo "<b>"._("The search was terminated with the following error").":</b><br><br>\n";
					$pos = strpos($err, "max_statement_time");
					if ($pos !== false) { 
						echo "<b>"._("The maximum search time was exceeded. Please refine your search").".</b>\n";
					} else {
						echo "<b>".$err."</b>\n";
					}
					echo "</center>\n";
					echo "</body></html>\n";
					exit;
				}
			}
			
			if ($db_source == 'S')
			{
				mysqli_close($link);
				$use_slave_server=0;
				$db_source = 'M';
				require("dbconnect_mysqli.php");
			}
			
			### LOG INSERTION Admin Log Table ###
			$SQL_log = "$stmt|";
			$SQL_log = preg_replace('/;/', '', $SQL_log);
			$SQL_log = addslashes($SQL_log);
			$stmt="INSERT INTO vicidial_admin_log set event_date='$NOW_TIME', user='$PHP_AUTH_USER', ip_address='$ip', event_section='LEADS', event_type='SEARCH', record_id='$search_lead', event_code='ADMIN SEARCH LEAD', event_sql=\"$SQL_log\", event_notes='';";
			if ($DB) {echo "|$stmt|\n";}
			$rslt=mysql_to_mysqli($stmt, $link);
			
			$end_process_time = date("U");
			$search_seconds = ($end_process_time - $STARTtime);
			
			$stmtL="UPDATE vicidial_lead_search_log set results='$o', seconds='$search_seconds' where search_log_id='$search_log_id';";
			if ($DB) {echo "|$stmtL|\n";}
			$rslt=mysql_to_mysqli($stmtL, $link);
		}
	} else 
	{
	##### BEGIN Log search #####
	if ( (strlen($log_lead_id)>0) or (strlen($log_phone)>0) )
		{
		if (strlen($log_lead_id)>0)
			{
			$stmtA="SELECT lead_id,phone_number,campaign_id,call_date,status,user,list_id,length_in_sec,alt_dial,phone_code from vicidial_log where lead_id='" . mysqli_real_escape_string($link, $log_lead_id) . "' $LOGallowed_listsSQL";
			$stmtB="SELECT lead_id,phone_number,campaign_id,call_date,status,user,list_id,length_in_sec,phone_code from vicidial_closer_log where lead_id='" . mysqli_real_escape_string($link, $log_lead_id) . "' $LOGallowed_listsSQL";
			}
		if (strlen($log_phone)>0)
			{
			$stmtA="SELECT lead_id,phone_number,campaign_id,call_date,status,user,list_id,length_in_sec,alt_dial,phone_code from vicidial_log where phone_number='" . mysqli_real_escape_string($link, $log_phone) . "' $LOGallowed_listsSQL";
			$stmtB="SELECT lead_id,phone_number,campaign_id,call_date,status,user,list_id,length_in_sec,phone_code from vicidial_closer_log where phone_number='" . mysqli_real_escape_string($link, $log_phone) . "' $LOGallowed_listsSQL";
			$stmtC="SELECT extension,caller_id_number,did_id,call_date,caller_id_name from vicidial_did_log where caller_id_number='" . mysqli_real_escape_string($link, $log_phone) . "'";
			}

		if ( (strlen($slave_db_server)>5) and (preg_match("/$report_name/",$reports_use_slave_db)) )
			{
			mysqli_close($link);
			$use_slave_server=1;
			$db_source = 'S';
			require("dbconnect_mysqli.php");
			echo "<!-- Using slave server $slave_db_server $db_source -->\n";
			}

		$rslt=mysql_to_mysqli("$stmtA", $link);
		$results_to_print = mysqli_num_rows($rslt);
		if ( ($results_to_print < 1) and ($results_to_printX < 1) )
			{
			echo "\n<br><br><center>\n";
			echo "<b>There are no outbound calls matching your search criteria</b><br><br>\n";
			echo "</center>\n";
			}
		else
			{
			echo "<BR><b>"._("OUTBOUND LOG RESULTS").": $results_to_print</b><BR>\n";
			echo "<TABLE BGCOLOR=WHITE CELLPADDING=1 CELLSPACING=0 WIDTH=770>\n";
			echo "<TR BGCOLOR=BLACK>\n";
			echo "<TD ALIGN=LEFT VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>#</B></FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("LEAD ID")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("PHONE")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("CAMPAIGN")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("CALL DATE")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("STATUS")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("USER")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("LIST ID")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("LENGTH")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("DIAL")."</B></FONT></TD>\n";
			echo "</TR>\n";
			$o=0;
			while ($results_to_print > $o)
				{
				$row=mysqli_fetch_row($rslt);
				if ($LOGadmin_hide_phone_data != '0')
					{
					if ($DB > 0) {echo "HIDEPHONEDATA|$row[1]|$LOGadmin_hide_phone_data|\n";}
					$phone_temp = $row[1];
					if (strlen($phone_temp) > 0)
						{
						if ($LOGadmin_hide_phone_data == '4_DIGITS')
							{$row[1] = str_repeat("X", (strlen($phone_temp) - 4)) . substr($phone_temp,-4,4);}
						elseif ($LOGadmin_hide_phone_data == '3_DIGITS')
							{$row[1] = str_repeat("X", (strlen($phone_temp) - 3)) . substr($phone_temp,-3,3);}
						elseif ($LOGadmin_hide_phone_data == '2_DIGITS')
							{$row[1] = str_repeat("X", (strlen($phone_temp) - 2)) . substr($phone_temp,-2,2);}
						else
							{$row[1] = preg_replace("/./",'X',$phone_temp);}
						}
					}
				$o++;
				$search_lead = $row[0];
				if (preg_match('/1$|3$|5$|7$|9$/i', $o))
					{$bgcolor='bgcolor="#'. $SSstd_row2_background .'"';}
				else
					{$bgcolor='bgcolor="#'. $SSstd_row1_background .'"';}
				echo "<TR $bgcolor>\n";
				echo "<TD ALIGN=LEFT><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$o</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1><a href=\"admin_modify_lead.php?lead_id=$row[0]&archive_search=$archive_search\" target=\"_blank\">$row[0]</a></FONT></TD>\n";				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1><a href=\"admin_modify_lead.php?lead_id=$row[0]&archive_search=$archive_search\" target=\"_blank\">$row[0]</a></FONT></TD>\n";
#				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1><a href=\"".curl_post_url("admin_modify_lead.php", "lead_id=$row[0]&archive_search=$archive_search")."\" target=\"_blank\">$row[0]</a></FONT></TD>\n";		
				$phTemp = FormatPhoneNr($row[9], $row[1]);
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$phTemp</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[2]</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>".strftime("%c", strtotime($row[3]))."</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[4]</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[5]</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[6]</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[7]</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[8]</FONT></TD>\n";
				echo "</TR>\n";
				}
			echo "</TABLE>\n";
			}

		$rslt=mysql_to_mysqli("$stmtB", $link);
		$results_to_print = mysqli_num_rows($rslt);
		if ( ($results_to_print < 1) and ($results_to_printX < 1) )
			{
			echo "\n<br><br><center>\n";
			echo "<b>"._("There are no inbound calls matching your search criteria")."</b><br><br>\n";
			echo "</center>\n";
			}
		else
			{
			echo "<BR><b>INBOUND LOG RESULTS: $results_to_print</b><BR>\n";
			echo "<TABLE BGCOLOR=WHITE CELLPADDING=1 CELLSPACING=0 WIDTH=770>\n";
			echo "<TR BGCOLOR=BLACK>\n";
			echo "<TD ALIGN=LEFT VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>#</B></FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("LEAD ID")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("PHONE")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("INGROUP")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("CALL DATE")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("STATUS")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("USER")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("LIST ID")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("LENGTH")."</B> &nbsp;</FONT></TD>\n";
			echo "</TR>\n";
			$o=0;
			while ($results_to_print > $o)
				{
				$row=mysqli_fetch_row($rslt);
				if ($LOGadmin_hide_phone_data != '0')
					{
					if ($DB > 0) {echo "HIDEPHONEDATA|$row[1]|$LOGadmin_hide_phone_data|\n";}
					$phone_temp = $row[1];
					if (strlen($phone_temp) > 0)
						{
						if ($LOGadmin_hide_phone_data == '4_DIGITS')
							{$row[1] = str_repeat("X", (strlen($phone_temp) - 4)) . substr($phone_temp,-4,4);}
						elseif ($LOGadmin_hide_phone_data == '3_DIGITS')
							{$row[1] = str_repeat("X", (strlen($phone_temp) - 3)) . substr($phone_temp,-3,3);}
						elseif ($LOGadmin_hide_phone_data == '2_DIGITS')
							{$row[1] = str_repeat("X", (strlen($phone_temp) - 2)) . substr($phone_temp,-2,2);}
						else
							{$row[1] = preg_replace("/./",'X',$phone_temp);}
						}
					}
				$o++;
				$search_lead = $row[0];
				if (preg_match('/1$|3$|5$|7$|9$/i', $o))
					{$bgcolor='bgcolor="#'. $SSstd_row2_background .'"';}
				else
					{$bgcolor='bgcolor="#'. $SSstd_row1_background .'"';}
				echo "<TR $bgcolor>\n";
				echo "<TD ALIGN=LEFT><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$o</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1><a href=\"admin_modify_lead.php?lead_id=$row[0]&archive_search=$archive_search\" target=\"_blank\">$row[0]</a></FONT></TD>\n";
#				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1><a href=\"".curl_post_url("admin_modify_lead.php","lead_id=$row[0]&archive_search=$archive_search")."\" target=\"_blank\">$row[0]</a></FONT></TD>\n";
				$phTemp = FormatPhoneNr($row[8], $row[1]);
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$phTemp</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[2]</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>".strftime("%c", strtotime($row[3]))."</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[4]</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[5]</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[6]</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[7]</FONT></TD>\n";
				echo "</TR>\n";
				}
			echo "</TABLE>\n";
			}

		if (strlen($stmtC) > 10)
			{
			$rslt=mysql_to_mysqli("$stmtC", $link);
			$results_to_print = mysqli_num_rows($rslt);
			if ( ($results_to_print < 1) and ($results_to_printX < 1) )
				{
				echo "\n<br><br><center>\n";
				echo "<b>"._("There are no inbound did calls matching your search criteria")."</b><br><br>\n";
				echo "</center>\n";
				}
			else
				{
				echo "<BR><b>"._("INBOUND DID LOG RESULTS").": $results_to_print</b><BR>\n";
				echo "<TABLE BGCOLOR=WHITE CELLPADDING=1 CELLSPACING=0 WIDTH=770>\n";
				echo "<TR BGCOLOR=BLACK>\n";
				echo "<TD ALIGN=LEFT VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>#</B></FONT></TD>\n";
				echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("DID")."</B> &nbsp;</FONT></TD>\n";
				echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("PHONE")."</B> &nbsp;</FONT></TD>\n";
				echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("DID ID")."</B> &nbsp;</FONT></TD>\n";
				echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("CALL DATE")."</B> &nbsp;</FONT></TD>\n";
				echo "</TR>\n";
				$o=0;
				while ($results_to_print > $o)
					{
					$row=mysqli_fetch_row($rslt);
					if ($LOGadmin_hide_phone_data != '0')
						{
						if ($DB > 0) {echo "HIDEPHONEDATA|$row[1]|$LOGadmin_hide_phone_data|\n";}
						$phone_temp = $row[1];
						if (strlen($phone_temp) > 0)
							{
							if ($LOGadmin_hide_phone_data == '4_DIGITS')
								{$row[1] = str_repeat("X", (strlen($phone_temp) - 4)) . substr($phone_temp,-4,4);}
							elseif ($LOGadmin_hide_phone_data == '3_DIGITS')
								{$row[1] = str_repeat("X", (strlen($phone_temp) - 3)) . substr($phone_temp,-3,3);}
							elseif ($LOGadmin_hide_phone_data == '2_DIGITS')
								{$row[1] = str_repeat("X", (strlen($phone_temp) - 2)) . substr($phone_temp,-2,2);}
							else
								{$row[1] = preg_replace("/./",'X',$phone_temp);}
							}
						}
					$o++;
					$search_lead = $row[0];
					if (preg_match('/1$|3$|5$|7$|9$/i', $o))
						{$bgcolor='bgcolor="#'. $SSstd_row2_background .'"';}
					else
						{$bgcolor='bgcolor="#'. $SSstd_row1_background .'"';}
					echo "<TR $bgcolor>\n";
					echo "<TD ALIGN=LEFT><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$o</FONT></TD>\n";
					echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[0]</FONT></TD>\n";
					$phTemp = FormatPhoneNr($row[4], "");
					echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$phTemp</FONT></TD>\n";
					echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[2]</FONT></TD>\n";
					echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>".strftime("%c", strtotime($row[3]))."</FONT></TD>\n";
					echo "</TR>\n";
					}
				echo "</TABLE>\n";
				}
			}

		if ($db_source == 'S')
			{
			mysqli_close($link);
			$use_slave_server=0;
			$db_source = 'M';
			require("dbconnect_mysqli.php");
			}

		### LOG INSERTION Admin Log Table ###
		$SQL_log = "$stmtA|$stmtB|$stmtC|";
		$SQL_log = preg_replace('/;/', '', $SQL_log);
		$SQL_log = addslashes($SQL_log);
		$stmt="INSERT INTO vicidial_admin_log set event_date='$NOW_TIME', user='$PHP_AUTH_USER', ip_address='$ip', event_section='LEADS', event_type='SEARCH', record_id='$search_lead', event_code='ADMIN SEARCH LEAD', event_sql=\"$SQL_log\", event_notes=\"$DB|$SUBMIT|$alt_phone_search|$archive_search|$first_name|$last_name|$address1|$city|$lead_id|$list_id|$log_lead_id|$log_lead_id_archive|$log_phone|$log_phone_archive|$owner|$phone|$status|$submit|$user|$vendor_id|$called_count\";";
		if ($DB) {echo "|$stmt|\n";}
		$rslt=mysql_to_mysqli($stmt, $link);

		$ENDtime = date("U");

		$RUNtime = ($ENDtime - $STARTtime);

		echo "\n\n\n<br><br><br>\n<a href=\"$PHP_SELF\">NEW SEARCH</a>";

		echo "\n\n\n<br><br><br>\n"._("script runtime").": $RUNtime "._("seconds");

		echo "\n\n\n</body></html>";

		exit;
		}
	##### END Log search #####


	##### BEGIN Log archive search #####
	if ( (strlen($log_lead_id_archive)>0) or (strlen($log_phone_archive)>0) )
		{
		if (strlen($log_lead_id_archive)>0)
			{
			$stmtA="SELECT lead_id,phone_number,campaign_id,call_date,status,user,list_id,length_in_sec,alt_dial,phone_code from vicidial_log_archive where lead_id='" . mysqli_real_escape_string($link, $log_lead_id_archive) . "' $LOGallowed_listsSQL";
			$stmtB="SELECT lead_id,phone_number,campaign_id,call_date,status,user,list_id,length_in_sec,phone_code from vicidial_closer_log_archive where lead_id='" . mysqli_real_escape_string($link, $log_lead_id_archive) . "' $LOGallowed_listsSQL";
			$log_archive_link='Yes';
			}
		if (strlen($log_phone_archive)>0)
			{
			$stmtA="SELECT lead_id,phone_number,campaign_id,call_date,status,user,list_id,length_in_sec,alt_dial,phone_code from vicidial_log_archive where phone_number='" . mysqli_real_escape_string($link, $log_phone_archive) . "' $LOGallowed_listsSQL";
			$stmtB="SELECT lead_id,phone_number,campaign_id,call_date,status,user,list_id,length_in_sec,phone_code from vicidial_closer_log_archive where phone_number='" . mysqli_real_escape_string($link, $log_phone_archive) . "' $LOGallowed_listsSQL";
			$stmtC="SELECT extension,caller_id_number,did_id,call_date,caller_id_name from vicidial_did_log where caller_id_number='" . mysqli_real_escape_string($link, $log_phone_archive) . "'";
			$log_archive_link='Yes';
			}

		if ( (strlen($slave_db_server)>5) and (preg_match("/$report_name/",$reports_use_slave_db)) )
			{
			mysqli_close($link);
			$use_slave_server=1;
			$db_source = 'S';
			require("dbconnect_mysqli.php");
			echo "<!-- Using slave server $slave_db_server $db_source -->\n";
			}

		$rslt=mysql_to_mysqli("$stmtA", $link);
		$results_to_print = mysqli_num_rows($rslt);
		if ( ($results_to_print < 1) and ($results_to_printX < 1) )
			{
			echo "\n<br><br><center>\n";
			echo "<b>"._("There are no outbound calls matching your search criteria")."</b><br><br>\n";
			echo "</center>\n";
			}
		else
			{
			echo "<BR><b>"._("OUTBOUND LOG RESULTS").": $results_to_print</b><BR>\n";
			echo "<TABLE BGCOLOR=WHITE CELLPADDING=1 CELLSPACING=0 WIDTH=770>\n";
			echo "<TR BGCOLOR=BLACK>\n";
			echo "<TD ALIGN=LEFT VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>#</B></FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("LEAD ID")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("PHONE")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("CAMPAIGN")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("CALL DATE")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("STATUS")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("USER")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("LIST ID")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("LENGTH")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("DIAL")."</B></FONT></TD>\n";
			echo "</TR>\n";
			$o=0;
			while ($results_to_print > $o)
				{
				$row=mysqli_fetch_row($rslt);
				if ($LOGadmin_hide_phone_data != '0')
					{
					if ($DB > 0) {echo "HIDEPHONEDATA|$row[1]|$LOGadmin_hide_phone_data|\n";}
					$phone_temp = $row[1];
					if (strlen($phone_temp) > 0)
						{
						if ($LOGadmin_hide_phone_data == '4_DIGITS')
							{$row[1] = str_repeat("X", (strlen($phone_temp) - 4)) . substr($phone_temp,-4,4);}
						elseif ($LOGadmin_hide_phone_data == '3_DIGITS')
							{$row[1] = str_repeat("X", (strlen($phone_temp) - 3)) . substr($phone_temp,-3,3);}
						elseif ($LOGadmin_hide_phone_data == '2_DIGITS')
							{$row[1] = str_repeat("X", (strlen($phone_temp) - 2)) . substr($phone_temp,-2,2);}
						else
							{$row[1] = preg_replace("/./",'X',$phone_temp);}
						}
					}
				$o++;
				$search_lead = $row[0];
				if (preg_match('/1$|3$|5$|7$|9$/i', $o))
					{$bgcolor='bgcolor="#'. $SSstd_row2_background .'"';}
				else
					{$bgcolor='bgcolor="#'. $SSstd_row1_background .'"';}
				echo "<TR $bgcolor>\n";
				echo "<TD ALIGN=LEFT><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$o</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1><a href=\"admin_modify_lead.php?lead_id=$row[0]&archive_search=$archive_search&archive_log=$log_archive_link\" target=\"_blank\">$row[0]</a></FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1><a href=\"".curl_post_url("admin_modify_lead.php", "lead_id=$row[0]&archive_search=$archive_search&archive_log=$log_archive_link")."\" target=\"_blank\">$row[0]</a></FONT></TD>\n";
				$phTemp = FormatPhoneNr($row[9], $row[1]);
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$phTemp</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[2]</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>".strftime("%c", strtotime($row[3]))."</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[4]</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[5]</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[6]</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[7]</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[8]</FONT></TD>\n";
				echo "</TR>\n";
				}
			echo "</TABLE>\n";
			}

		$rslt=mysql_to_mysqli("$stmtB", $link);
		$results_to_print = mysqli_num_rows($rslt);
		if ( ($results_to_print < 1) and ($results_to_printX < 1) )
			{
			echo "\n<br><br><center>\n";
			echo "<b>"._("There are no inbound calls matching your search criteria")."</b><br><br>\n";
			echo "</center>\n";
			}
		else
			{
			echo "<BR><b>"._("INBOUND LOG RESULTS").": $results_to_print</b><BR>\n";
			echo "<TABLE BGCOLOR=WHITE CELLPADDING=1 CELLSPACING=0 WIDTH=770>\n";
			echo "<TR BGCOLOR=BLACK>\n";
			echo "<TD ALIGN=LEFT VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>#</B></FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("LEAD ID")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("PHONE")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("INGROUP")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("CALL DATE")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("STATUS")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("USER")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("LIST ID")."</B> &nbsp;</FONT></TD>\n";
			echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("LENGTH")."</B> &nbsp;</FONT></TD>\n";
			echo "</TR>\n";
			$o=0;
			while ($results_to_print > $o)
				{
				$row=mysqli_fetch_row($rslt);
				if ($LOGadmin_hide_phone_data != '0')
					{
					if ($DB > 0) {echo "HIDEPHONEDATA|$row[1]|$LOGadmin_hide_phone_data|\n";}
					$phone_temp = $row[1];
					if (strlen($phone_temp) > 0)
						{
						if ($LOGadmin_hide_phone_data == '4_DIGITS')
							{$row[1] = str_repeat("X", (strlen($phone_temp) - 4)) . substr($phone_temp,-4,4);}
						elseif ($LOGadmin_hide_phone_data == '3_DIGITS')
							{$row[1] = str_repeat("X", (strlen($phone_temp) - 3)) . substr($phone_temp,-3,3);}
						elseif ($LOGadmin_hide_phone_data == '2_DIGITS')
							{$row[1] = str_repeat("X", (strlen($phone_temp) - 2)) . substr($phone_temp,-2,2);}
						else
							{$row[1] = preg_replace("/./",'X',$phone_temp);}
						}
					}
				$o++;
				$search_lead = $row[0];
				if (preg_match('/1$|3$|5$|7$|9$/i', $o))
					{$bgcolor='bgcolor="#'. $SSstd_row2_background .'"';}
				else
					{$bgcolor='bgcolor="#'. $SSstd_row1_background .'"';}
				echo "<TR $bgcolor>\n";
				echo "<TD ALIGN=LEFT><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$o</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1><a href=\"admin_modify_lead.php?lead_id=$row[0]&archive_search=$archive_search&archive_log=$log_archive_link\" target=\"_blank\">$row[0]</a></FONT></TD>\n";
#				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1><a href=\"".curl_post_url("admin_modify_lead.php", "lead_id=$row[0]&archive_search=$archive_search&archive_log=$log_archive_link")."\" target=\"_blank\">$row[0]</a></FONT></TD>\n";
				$phTemp = FormatPhoneNr($row[8], $row[1]);
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$phTemp</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[2]</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>".strftime("%c", strtotime($row[3]))."</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[4]</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[5]</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[6]</FONT></TD>\n";
				echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[7]</FONT></TD>\n";
				echo "</TR>\n";
				}
			echo "</TABLE>\n";
			}

		if (strlen($stmtC) > 10)
			{
			$rslt=mysql_to_mysqli("$stmtC", $link);
			$results_to_print = mysqli_num_rows($rslt);
			if ( ($results_to_print < 1) and ($results_to_printX < 1) )
				{
				echo "\n<br><br><center>\n";
				echo "<b>"._("There are no inbound did calls matching your search criteria")."</b><br><br>\n";
				echo "</center>\n";
				}
			else
				{
				echo "<BR><b>"._("INBOUND DID LOG RESULTS").": $results_to_print</b><BR>\n";
				echo "<TABLE BGCOLOR=WHITE CELLPADDING=1 CELLSPACING=0 WIDTH=770>\n";
				echo "<TR BGCOLOR=BLACK>\n";
				echo "<TD ALIGN=LEFT VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>#</B></FONT></TD>\n";
				echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("DID")."</B> &nbsp;</FONT></TD>\n";
				echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("PHONE")."</B> &nbsp;</FONT></TD>\n";
				echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("DID ID")."</B> &nbsp;</FONT></TD>\n";
				echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("CALL DATE")."</B> &nbsp;</FONT></TD>\n";
				echo "</TR>\n";
				$o=0;
				while ($results_to_print > $o)
					{
					$row=mysqli_fetch_row($rslt);
					if ($LOGadmin_hide_phone_data != '0')
						{
						if ($DB > 0) {echo "HIDEPHONEDATA|$row[1]|$LOGadmin_hide_phone_data|\n";}
						$phone_temp = $row[1];
						if (strlen($phone_temp) > 0)
							{
							if ($LOGadmin_hide_phone_data == '4_DIGITS')
								{$row[1] = str_repeat("X", (strlen($phone_temp) - 4)) . substr($phone_temp,-4,4);}
							elseif ($LOGadmin_hide_phone_data == '3_DIGITS')
								{$row[1] = str_repeat("X", (strlen($phone_temp) - 3)) . substr($phone_temp,-3,3);}
							elseif ($LOGadmin_hide_phone_data == '2_DIGITS')
								{$row[1] = str_repeat("X", (strlen($phone_temp) - 2)) . substr($phone_temp,-2,2);}
							else
								{$row[1] = preg_replace("/./",'X',$phone_temp);}
							}
						}
					$o++;
					$search_lead = $row[0];
					if (preg_match('/1$|3$|5$|7$|9$/i', $o))
						{$bgcolor='bgcolor="#'. $SSstd_row2_background .'"';}
					else
						{$bgcolor='bgcolor="#'. $SSstd_row1_background .'"';}
					echo "<TR $bgcolor>\n";
					echo "<TD ALIGN=LEFT><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$o</FONT></TD>\n";
					echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[0]</FONT></TD>\n";
					$phTemp = FormatPhoneNr($row[4], "");
					echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$phTemp</FONT></TD>\n";
					echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[2]</FONT></TD>\n";
					echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>".strftime("%c", strtotime($row[3]))."</FONT></TD>\n";
					echo "</TR>\n";
					}
				echo "</TABLE>\n";
				}
			}

		if ($db_source == 'S')
			{
			mysqli_close($link);
			$use_slave_server=0;
			$db_source = 'M';
			require("dbconnect_mysqli.php");
			}

		### LOG INSERTION Admin Log Table ###
		$SQL_log = "$stmtA|$stmtB|$stmtC|";
		$SQL_log = preg_replace('/;/', '', $SQL_log);
		$SQL_log = addslashes($SQL_log);
		$stmt="INSERT INTO vicidial_admin_log set event_date='$NOW_TIME', user='$PHP_AUTH_USER', ip_address='$ip', event_section='LEADS', event_type='SEARCH', record_id='$search_lead', event_code='ADMIN SEARCH LEAD', event_sql=\"$SQL_log\", event_notes=\"ARCHIVE   $DB|$SUBMIT|$alt_phone_search|$archive_search|$first_name|$last_name|$address1|$city|$lead_id|$list_id|$log_lead_id|$log_lead_id_archive|$log_phone|$log_phone_archive|$owner|$phone|$status|$submit|$user|$vendor_id|$called_count\";";
		if ($DB) {echo "|$stmt|\n";}
		$rslt=mysql_to_mysqli($stmt, $link);

		$ENDtime = date("U");

		$RUNtime = ($ENDtime - $STARTtime);

		echo "\n\n\n<br><br><br>\n<a href=\"$PHP_SELF\">NEW SEARCH</a>";

		echo "\n\n\n<br><br><br>\n"._("script runtime").": $RUNtime "._("seconds");

		echo "\n\n\n</body></html>";

		exit;
		}
	##### END Log search #####


	##### BEGIN Lead search #####
	if ($vendor_id)
		{
		$stmt="SELECT $vicidial_list_fields from $vl_table where vendor_lead_code='" . mysqli_real_escape_string($link, $vendor_id) . "' $LOGallowed_listsSQL";
		}
	else
		{
		if ($phone)
			{
			if (isset($alt_phone_search))
				{
				$stmt="SELECT $vicidial_list_fields from $vl_table where phone_number='" . mysqli_real_escape_string($link, $phone) . "' or alt_phone='" . mysqli_real_escape_string($link, $phone) . "' or address3='" . mysqli_real_escape_string($link, $phone) . "' $LOGallowed_listsSQL";
				}
			else
				{
				$stmt="SELECT $vicidial_list_fields from $vl_table where phone_number='" . mysqli_real_escape_string($link, $phone) . "' $LOGallowed_listsSQL";
				}
			}
		else
			{
			if ($lead_id)
				{
				$stmt="SELECT $vicidial_list_fields from $vl_table where lead_id='" . mysqli_real_escape_string($link, $lead_id) . "' $LOGallowed_listsSQL";
				}
			else
				{
				print _("ERROR: you must search for something! Go back and search for something");
				exit;
				}
			}
		}

    if ( (strlen($slave_db_server)>5) and (preg_match("/$report_name/",$reports_use_slave_db)) )
      {
      mysqli_close($link);
      $use_slave_server=1;
      $db_source = 'S';
      require("dbconnect_mysqli.php");
      echo "<!-- Using slave server $slave_db_server $db_source -->\n";
      }

	$stmt_alt='';
	$results_to_printX=0;
	if ( ($alt_phone_search=="Yes") and (strlen($phone) > 4) )
		{
		$stmtX="SELECT lead_id from vicidial_list_alt_phones where phone_number='" . mysqli_real_escape_string($link, $phone) . "' $LOGallowed_listsSQL limit 10000;";
		$rsltX=mysql_to_mysqli($stmtX, $link);
		$results_to_printX = mysqli_num_rows($rsltX);
		if ($DB)
			{echo "\n\n$results_to_printX|$stmtX\n\n";}
		$o=0;
		while ($results_to_printX > $o)
			{
			$row=mysqli_fetch_row($rsltX);
			if ($o > 0) {$stmt_alt .= ",";}
			$stmt_alt .= "'$row[0]'";
			$o++;
			}
		if (strlen($stmt_alt) > 2)
			{$stmt_alt = "or lead_id IN($stmt_alt)";}
		}

	$stmt = "$stmt$stmt_alt order by modify_date desc limit 1000;";

	if ($DB)
		{
		echo "\n\n$stmt\n\n";
		}

	if ($db_source == 'S')
		{
		mysqli_close($link);
		$use_slave_server=0;
		$db_source = 'M';
		require("dbconnect_mysqli.php");
		}

	### LOG INSERTION Search Log Table ###
	$SQL_log = "$stmt|";
	$SQL_log = preg_replace('/;/', '', $SQL_log);
	$SQL_log = addslashes($SQL_log);
	$stmtL="INSERT INTO vicidial_lead_search_log set event_date='$NOW_TIME', user='$PHP_AUTH_USER', source='admin', results='0', search_query=\"$SQL_log\";";
	if ($DB) {echo "|$stmtL|\n";}
	$rslt=mysql_to_mysqli($stmtL, $link);
	$search_log_id = mysqli_insert_id($link);

	if ( (strlen($slave_db_server)>5) and (preg_match("/$report_name/",$reports_use_slave_db)) )
		{
		mysqli_close($link);
		$use_slave_server=1;
		$db_source = 'S';
		require("dbconnect_mysqli.php");
		echo "<!-- Using slave server $slave_db_server $db_source -->\n";
		}

	$rslt=mysql_to_mysqli("$stmt", $link);
	$results_to_print = mysqli_num_rows($rslt);
	if ( ($results_to_print < 1) and ($results_to_printX < 1) )
		{
		echo date("l F j, Y G:i:s A");
		echo "\n<br><br><center>\n";
		echo "<b>"._("The search variables you entered are not active in the system")."</b><br><br>\n";
		echo "<b>"._("Please go back and double check the information you entered and submit again")."</b>\n";
		echo "</center>\n";
		echo "</body></html>\n";
		exit;
		}
	else
		{
		echo "<b>"._("RESULTS").": $results_to_print</b><BR><BR>\n";
		echo "<TABLE BGCOLOR=WHITE CELLPADDING=1 CELLSPACING=0 WIDTH=770>\n";
		echo "<TR BGCOLOR=BLACK>\n";
		echo "<TD ALIGN=LEFT VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>#</B></FONT></TD>\n";
		echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("LEAD ID")."</B> &nbsp;</FONT></TD>\n";
		echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("STATUS")."</B> &nbsp;</FONT></TD>\n";
		echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("VENDOR ID")."</B> &nbsp;</FONT></TD>\n";
		echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("LAST AGENT")."</B> &nbsp;</FONT></TD>\n";
		echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("LIST ID")."</B> &nbsp;</FONT></TD>\n";
		echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("PHONE")."</B> &nbsp;</FONT></TD>\n";
		echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("NAME")."</B> &nbsp;</FONT></TD>\n";
		echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("CITY")."</B> &nbsp;</FONT></TD>\n";
		echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("SECURITY")."</B> &nbsp;</FONT></TD>\n";
		echo "<TD ALIGN=CENTER VALIGN=TOP><FONT FACE=\"ARIAL,HELVETICA\" COLOR=WHITE><B>"._("LAST CALL")."</B></FONT></TD>\n";
		echo "</TR>\n";
		$o=0;
		while ($results_to_print > $o)
			{
			$row=mysqli_fetch_row($rslt);
			if ($LOGadmin_hide_phone_data != '0')
				{
				if ($DB > 0) {echo "HIDEPHONEDATA|$row[11]|$LOGadmin_hide_phone_data|\n";}
				$phone_temp = $row[11];
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
				if ($DB > 0) {echo "HIDELEADDATA|$row[5]|$row[6]|$row[12]|$row[13]|$row[14]|$row[15]|$row[16]|$row[17]|$row[18]|$row[19]|$row[20]|$row[21]|$row[22]|$row[26]|$row[27]|$row[28]|$LOGadmin_hide_lead_data|\n";}
				if (strlen($row[5]) > 0)
					{$data_temp = $row[5];   $row[5] = preg_replace("/./",'X',$data_temp);}
				if (strlen($row[6]) > 0)
					{$data_temp = $row[6];   $row[6] = preg_replace("/./",'X',$data_temp);}
				if (strlen($row[12]) > 0)
					{$data_temp = $row[12];   $row[12] = preg_replace("/./",'X',$data_temp);}
				if (strlen($row[13]) > 0)
					{$data_temp = $row[13];   $row[13] = preg_replace("/./",'X',$data_temp);}
				if (strlen($row[14]) > 0)
					{$data_temp = $row[14];   $row[14] = preg_replace("/./",'X',$data_temp);}
				if (strlen($row[15]) > 0)
					{$data_temp = $row[15];   $row[15] = preg_replace("/./",'X',$data_temp);}
				if (strlen($row[16]) > 0)
					{$data_temp = $row[16];   $row[16] = preg_replace("/./",'X',$data_temp);}
				if (strlen($row[17]) > 0)
					{$data_temp = $row[17];   $row[17] = preg_replace("/./",'X',$data_temp);}
				if (strlen($row[18]) > 0)
					{$data_temp = $row[18];   $row[18] = preg_replace("/./",'X',$data_temp);}
				if (strlen($row[19]) > 0)
					{$data_temp = $row[19];   $row[19] = preg_replace("/./",'X',$data_temp);}
				if (strlen($row[20]) > 0)
					{$data_temp = $row[20];   $row[20] = preg_replace("/./",'X',$data_temp);}
				if (strlen($row[21]) > 0)
					{$data_temp = $row[21];   $row[21] = preg_replace("/./",'X',$data_temp);}
				if (strlen($row[22]) > 0)
					{$data_temp = $row[22];   $row[22] = preg_replace("/./",'X',$data_temp);}
				if (strlen($row[26]) > 0)
					{$data_temp = $row[26];   $row[26] = preg_replace("/./",'X',$data_temp);}
				if (strlen($row[27]) > 0)
					{$data_temp = $row[27];   $row[27] = preg_replace("/./",'X',$data_temp);}
				if (strlen($row[28]) > 0)
					{$data_temp = $row[28];   $row[28] = preg_replace("/./",'X',$data_temp);}
				}

			$o++;
			$search_lead = $row[0];
			if (preg_match('/1$|3$|5$|7$|9$/i', $o))
				{$bgcolor='bgcolor="#'. $SSstd_row2_background .'"';}
			else
				{$bgcolor='bgcolor="#'. $SSstd_row1_background .'"';}
			echo "<TR $bgcolor>\n";
			echo "<TD ALIGN=LEFT><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$o</FONT></TD>\n";
			echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1><a href=\"admin_modify_lead.php?lead_id=$row[0]&archive_search=$archive_search&archive_log=$log_archive_link\" target=\"_blank\">$row[0]</a></FONT></TD>\n";
#			echo "<TD ALIGN=CENTER><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1><a href=\"".curl_post_url("admin_modify_lead.php", "lead_id=$row[0]&archive_search=$archive_search&archive_log=$log_archive_link")."\" target=\"_blank\">$row[0]</a></FONT></TD>\n";
			echo "<TD ALIGN=RIGHT><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[3]</FONT></TD>\n";
			echo "<TD ALIGN=RIGHT><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[5]</FONT></TD>\n";
			echo "<TD ALIGN=RIGHT><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[4]</FONT></TD>\n";
			echo "<TD ALIGN=RIGHT><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[7]</FONT></TD>\n";
			$phTemp = FormatPhoneNr($row[10], $row[11]);
			echo "<TD ALIGN=RIGHT nowrap><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$phTemp</FONT></TD>\n";
			echo "<TD ALIGN=RIGHT nowrap><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[13] $row[15]</FONT></TD>\n";
			echo "<TD ALIGN=RIGHT><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[19]</FONT></TD>\n";
			echo "<TD ALIGN=RIGHT><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>$row[28]</FONT></TD>\n";
			echo "<TD ALIGN=LEFT nowrap><FONT FACE=\"ARIAL,HELVETICA\" SIZE=1>".strftime("%c", strtotime($row[31]))."</FONT></TD>\n";
			echo "</TR>\n";
			}
		echo "</TABLE>\n";
		}

	if ($db_source == 'S')
		{
		mysqli_close($link);
		$use_slave_server=0;
		$db_source = 'M';
		require("dbconnect_mysqli.php");
		}

	### LOG INSERTION Admin Log Table ###
	$SQL_log = "$stmt|";
	$SQL_log = preg_replace('/;/', '', $SQL_log);
	$SQL_log = addslashes($SQL_log);
	$stmt="INSERT INTO vicidial_admin_log set event_date='$NOW_TIME', user='$PHP_AUTH_USER', ip_address='$ip', event_section='LEADS', event_type='SEARCH', record_id='$search_lead', event_code='ADMIN SEARCH LEAD', event_sql=\"$SQL_log\", event_notes='';";
	if ($DB) {echo "|$stmt|\n";}
	$rslt=mysql_to_mysqli($stmt, $link);

	$end_process_time = date("U");
	$search_seconds = ($end_process_time - $STARTtime);

	$stmtL="UPDATE vicidial_lead_search_log set results='$o', seconds='$search_seconds' where search_log_id='$search_log_id';";
	if ($DB) {echo "|$stmtL|\n";}
	$rslt=mysql_to_mysqli($stmtL, $link);
	}
	##### END Lead search #####




$ENDtime = date("U");

$RUNtime = ($ENDtime - $STARTtime);

echo "\n\n\n<br><br><br>\n<a href=\"$PHP_SELF\">"._("NEW SEARCH")."</a>";

echo "\n\n\n<br><br><br>\n"._("script runtime").": $RUNtime "._("seconds");

?>

</body>
</html>
