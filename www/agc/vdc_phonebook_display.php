<?php
#
# Copyright (c) 2015-2019 Jörg Frings-Fürst <open_source@jff.email>   LICENSE: AGPLv3
#		        2015-2017 flyingpenguin UG <info@flyingpenguin.de>
#               2019      SNCT GmbH <info@snct-gmbh.de>
#
# Display module for table contact_information
#
# required variables:
#  - $first_row
#  - $server_ip
#  - $user
#  - $pass
#  - $clickAt
#  - $direction
#  - $searchTag
#  - $SearchField
#
#
# 20151130-0000 first release
# 20151220-0000 activate dispColum to display only colums with contains data
# 20151222-0000 new function checkPhoneNumber
# 20160112-1347 add $HTTPprotocol
# 20160115-1242 Correct GenAPIforAgent
# 20160119-1325 Rewrite GenAPIforAgent to use javascript for dialout
# 20160121-1658 Test Agentstatus on CallConf and CallandPark
# 20160122-1600 New function PBLog
# 20160222-1413 Add seperate conffile (phonebook_config.php)
# 20160222-1420 Add PreDial String to conffile
# 20160222-1430 Add group_alias to set the CID
# 20160223-1607 Add new function to check group_alias entries
# 20160224-1014 Add parameter to enabel CIDFromPhone
# 20160224-1016 Add parameter to test the global alias
# 20171130-1159 Add fields *_phone_code
# 20171130-1439 Change to $_SERVER['SERVER_NAME'];
# 20180423-1335 Remove Protokol and Server-IP from links
# 20190429-1000 Change License to AGPLv3
# 20190429-1002 Add system_wide_settings.php
#

#
# needs:
# ./images/arrow_left32.png
# ./images/arrow_right32.png
# ./images/phone32.png
# ./images/conf-32.png
#

#
# Todo:
#
#
#

$version = '0.1.8';
$build = '20190429-1005';


require_once("phonebook_setup.php");

#
# Max rows to display
#
$MAX_ANZ=20;

#
# Set the global table attributes
#
$TABLE_COLOR1 = "#2EFEF7";
$TABLE_COLOR2 = "#81F7F3";
$TABLE_PARA="style=\"border:1px solid black;\"  bgcolor=\"#5882FA\"";

#
# image size
#
$IMAGE_SIZE = "16px";
$IMAGE_SIZE2 = 32;

#
# $DB
# set to 1 to enable debug messages
#
$DB=0;
$mel=0;
$LOG=0;
$LogFile = "./PhoneBook.log";

#
# counter display rows
#
$count_disp_row=0;


header ("Content-type: text/html; charset=utf-8");
header ("Cache-Control: no-cache, must-revalidate");  // HTTP/1.1
header ("Pragma: no-cache");                          // HTTP/1.0
echo '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
';

if (isset($_GET["first_row"]))                          {$first=$_GET["first_row"];}
        elseif (isset($_POST["first_row"]))             {$first=$_POST["first_row"];}
if (isset($_GET["user"]))                               {$user=$_GET["user"];}
        elseif (isset($_POST["user"]))                  {$user=$_POST["user"];}
if (isset($_GET["pass"]))                               {$pass=$_GET["pass"];}
        elseif (isset($_POST["pass"]))                  {$pass=$_POST["pass"];}
if (isset($_GET["clickat"]))                            {$clickAt=$_GET["clickat"];}
        elseif (isset($_POST["clickat"]))               {$clickAt=$_POST["clickat"];}
if (isset($_GET["direction"]))                          {$direction=$_GET["direction"];}
        elseif (isset($_POST["direction"]))             {$direction=$_POST["direction"];}
if (isset($_GET["searchtag"]))                          {$searchTag=$_GET["searchtag"];}
        elseif (isset($_POST["searchtag"]))             {$searchTag=$_POST["searchtag"];}
if (isset($_GET["searchfield"]))                        {$searchField=$_GET["searchfield"];}
        elseif (isset($_POST["searchfield"]))           {$searchField=$_POST["searchfield"];}

require_once("../tools/system_wide_settings.php");

$Server_ip_ext = $_SERVER['SERVER_NAME'];
if ($DB) { print $Server_ip_ext; }

$server_port = getenv("SERVER_PORT");
if (preg_match("/80/i",$server_port)) {$HTTPprotocol = 'http:';}
  else {$HTTPprotocol = 'https:';}

# print "$HTTPprotocol$Server_ip_ext";

#
# test required variables
#
if ($DB) {
    if (!isset($first)) {print "Variable First not set\n";$first=0; }
    if (!isset($user)) {print "Variable user not set\n";$user="2000"; }
    if (!isset($pass)) {print "Variable pass not set\n";$pass="1234";}
    if (!isset($Server_ip_ext)) {print "Variable Server_ip_ext not set\n";$Server_ip_ext="10.11.1.165";}
}

#
# Set $first if not set
#
if (!isset($first)) { $first=0; }
if (!isset($direction)) { $direction=1; }



if($DB) { print "Search12: $searchTag\n"; }


require_once("dbconnect_mysqli.php");
require_once("functions.php");

if (!isset($Server_ip_ext))  { $Server_ip_ext = $WEBserver_ip; }


#
# display Colums
# Index:
# 0 office_num
# 1 cell_num
# 2 other_num1
# 3 other_num2
# 4 bu_name
# 5 department
# 6 group_name
# 7 job_title
# 8 location
#
$dispColum = array (1,1,1,1,1,1,1,1,1,1,1);

#
# function GetAgentStatus
# Parameter: %user_id
# Return: -1 --> nothing to call
#          0 --> set paused and call
#          1 --> Call
#          2 --> Conference or park & call
#
function GetAgentStatus($user_id) {
    global $link, $DB;

    $ret = -1;

    $statement = "Select user, status from vicidial_live_agents where user = '$user_id'";
    if ($DB) print "$statement\n";
    $result=mysql_to_mysqli($statement, $link);
    $count=mysqli_num_rows($result);
    if($count > 0) {
        $row = mysqli_fetch_row($result);
        $status = $row[1];
        if ($DB) print "AgentStatus: $status\n";
        if ($status == 'READY') {$ret = 0;}
        if ($status == 'QUEUE') {$ret = -1;}
        if ($status == 'INCALL') {$ret = 2;}
        if ($status == 'PAUSED') {$ret = 1;}
        if ($status == 'CLOSER') {$ret = -2;}
    }
    return $ret;
}

function GetGroupAlias($user_id) {
    global $link, $DB, $pb_cid_phone_enable, $pb_cid_test_req;

    if ( $pb_cid_phone_enable == "N") { return 0; }
    if ( $pb_cid_test_req == "N" ) { return 1; }
    $statement = "Select caller_id_name, active from groups_alias where caller_id_name = '$user_id'";
    if ($DB) print "$statement\n";
    $ret = 0;
    $result=mysql_to_mysqli($statement, $link);
    $count=mysqli_num_rows($result);
    if($count > 0) {
        $row = mysqli_fetch_row($result);
        $active = $row[1];
        if ($DB) print "GroupAlias: $active\n";
        if ($active == 'Y') {$ret = 1;}
    }
    return $ret;
}

function PBLog($LogStr) {
    global $LogFile, $LOG, $version, $build, $user;

    if ($LOG == 1 ) {
	$date = date(DATE_RFC822);
	$CLIP = $_SERVER['REMOTE_ADDR'];
	$AStat = GetAgentStatus($user);

	$str = "$date $version, $build, RemoteIP: $CLIP, Status: $AStat, $LogStr";
	$fh = fopen($LogFile, "a");

	$iRet = fwrite ($fh, $str);

	fclose($fh);
    }
}

$GAlias = GetGroupAlias($user);

?>

<script type="text/javascript">


var User = '<?php echo $user ?>';
var Pass = '<?php echo $pass ?>';
var Server_ip_ext = '<?php echo $Server_ip_ext ?>';
var PreDial = '<?php echo $pb_predial ?>';
var Warn_GA = '<?php echo $pb_warn_group_alias ?>';
var Alias = '<?php echo $GAlias ?>';
var CIDPhoneEnable = '<?php echo $pb_cid_phone_enable ?>';

//
// function CallandPark
// Parameter: Phone (phone number to call)
// Return: ./.
//
// Park the activ call and dial to other
//
function CallandPark(Phone, PhoneCode) {

    var xmlhttp=false;
    var AStatus = '<?php GetAgentStatus($user); ?>';

    var DialPhone = PhoneCode + Phone;

    if (CIDPhoneEnable == "N") { Alias = 0; }
    
    if (Alias == 0 && Warn_GA == "Y" && CIDPhoneEnable == "Y") {
        alert("Der Eintrag in der \"Group Alias\" fehlt oder ist nicht aktiv. \nBitte informieren Sie Ihren Systenm - Administrator!");
    }    
    if (AStatus == 2) {
	if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
	    xmlhttp = new XMLHttpRequest();
	}
	if (xmlhttp==null) {
	    alert("Script Fehler!");
	}
	else {
            if (Alias == 0) {
                html_query = "source=PBookCall" + "&user=" + User + "&pass=" + Pass + "&agent_user=" + User + "&function=transfer_conference" + "&value=DIAL_WITH_CUSTOMER" + "&phone_number=" + DialPhone;
            }
            else {
                html_query = "source=PBookCall" + "&user=" + User + "&pass=" + Pass + "&group_alias=" + User + "&agent_user=" + User + "&function=transfer_conference" + "&value=DIAL_WITH_CUSTOMER" + "&phone_number=" + DialPhone;
            }
	    xmlhttp.open('POST', 'api.php');
	    xmlhttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded; charset=UTF-8');
	    xmlhttp.send(html_query);
	    xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState != 4 || xmlhttp.status != 200) {
		    Nactiveext = null;
		    Nactiveext = xmlhttp.responseText;
//		    alert(xmlhttp.responseText);
		}
	    }
        }
	delete xmlhttp;
    }
    if ((AStatus == 1) || ( AStatus == 0)) {
	CallExtern(Phone);
    }
}

//
// function CallExtern
// Parameter: Phone (phone number to call)
// Return: ./.
//
// Dial to phone number
//
function CallExtern(Phone, PhoneCode) {

    var xmlhttp=false;

    var DialPhone = PreDial + Phone;
//    alert("Extern test");
//    alert("Alias: " + Alias );

    if (CIDPhoneEnable == "N") { Alias = 0; }
    
    if (Alias == 0 && Warn_GA == "Y" && CIDPhoneEnable == "Y") {
        alert("Der Eintrag in der \"Group Alias\" fehlt. \nBitte informieren Sie Ihren System - Administrator!");
    }
    if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
	xmlhttp = new XMLHttpRequest();
    }
    if (xmlhttp==null) {
	alert("Script Fehler!");
    }
    else {
        if (Alias == 0) {
            html_query = "source=PBookCall" + "&user=" + User + "&pass=" + Pass + "&agent_user=" + User + "&function=external_dial" + "&value=" + DialPhone + "&phone_code=" + PhoneCode +"&search=YES&preview=NO&focus=YES";
        }
        else {
            html_query = "source=PBookCall" + "&user=" + User + "&pass=" + Pass + "&group_alias=" + User + "&agent_user=" + User + "&function=external_dial" + "&value=" + DialPhone + "&phone_code=" + PhoneCode + "&search=YES&preview=NO&focus=YES";
        }
	xmlhttp.open('POST', 'api.php');
	xmlhttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded; charset=UTF-8');
	xmlhttp.send(html_query);
	xmlhttp.onreadystatechange = function() {
	    if ((xmlhttp.readyState != 4) || (xmlhttp.status != 200)) {
		Nactiveext = null;
		Nactiveext = xmlhttp.responseText;
//		alert(xmlhttp.responseText);
	    }
	}
    }
    delete xmlhttp;
}

//
// function CallConf
// Parameter: Phone (phone number to call)
// Return: ./.
//
// Conference with the activ call and other phone number
//
function CallConf(Phone, PhoneCode) {

    var xmlhttp=false;
    var AStatus = '<?php GetAgentStatus($user); ?>';
    var DialPhone = PreDial + Phone;
    
    if (CIDPhoneEnable == "N") { Alias = 0; }
    
    if (Alias == 0 && Warn_GA == "Y" && CIDPhoneEnable == "Y") {
        alert("Der Eintrag in der \"Group Alias\" fehlt. \nBitte informieren Sie Ihren System - Administrator!");
    }
    if (AStatus == 2) {
	if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
	    xmlhttp = new XMLHttpRequest();
	}
        if (xmlhttp==null) {
	    alert("Script Fehler!");
	}
	else {
            if (Alias == 0) { 
                html_query = "source=PBookCall" + "&user=" + User + "&pass=" + Pass + "&agent_user=" + User + "&function=external_dial" + "&value=" + DialPhone + "&phone_code=" + PhoneCode + "&search=YES&preview=NO&focus=YES";
            }
            else {
                html_query = "source=PBookCall" + "&user=" + User + "&pass=" + Pass + "&group_alias=" + User + "&agent_user=" + User + "&function=external_dial" + "&value=" + DialPhone + "&phone_code=" + PhoneCode + "&search=YES&preview=NO&focus=YES";
            }
	    xmlhttp.open('POST', 'api.php');
	    xmlhttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded; charset=UTF-8');
	    xmlhttp.send(html_query);
	    xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState != 4 || xmlhttp.status != 200) {
		    Nactiveext = null;
		    Nactiveext = xmlhttp.responseText;
//			alert(xmlhttp.responseText);
		}
	    }
	    delete xmlhttp;
        }
    }
    if ((AStatus == 1) || ( AStatus == 0)) {
	CallExtern(Phone);
    }
}

// function myFunction() { var x = window.document.documentElement. document.scripts.namedItem("PhoneBookPanelToFront").text; window.document.getElementById("demo").innerHTML = x; }

//
// function SetAgentToPause
// Parameter: ./.
// Return: ./.
//
// Set the agent status to "PAUSED"
//
function SetAgentToPause() {

    var xmlhttp=false;

    if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
	xmlhttp = new XMLHttpRequest();
    }
    if (xmlhttp==null) {
	alert("Script Fehler!");
    }
    else {
	html_query = "source=PBookCall" + "&user=" + User + "&pass=" + Pass + "&agent_user=" + User + "&function=external_pause" + "&value=PAUSE";
	xmlhttp.open('POST', 'api.php');
	xmlhttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded; charset=UTF-8');
	xmlhttp.send(html_query);
	xmlhttp.onreadystatechange = function() {
	    if (xmlhttp.readyState != 4 || xmlhttp.status != 200) {
		Nactiveext = null;
		Nactiveext = xmlhttp.responseText;
//		alert(xmlhttp.responseText);
	    }
	}
    }
    delete xmlhttp;
//    myFunction();
//  window.PhoneBookPanelToFront("yes");
}

</script>
<?php


#
# function checkPhoneNumber
# Parameter: $phone_nr (phone number to trim)
# Return: $return (trimed phone_nr)
# Remove ' ' und leading '0'
#
#
function CheckPhoneNumber($phone_nr) {

    $return = "";

    # remove ' '
    $return = str_replace(" ", "", $phone_nr);
    $phone_nr = $return;

    # remove '+'
    $return = str_replace("+", "", $phone_nr);
    $phone_nr = $return;

    # remove leading 0
    $return = ltrim($phone_nr, '0');

    if($DB) print "Str: >$phone_nr< >$return<\n";

    #$return = $phone_nr;
    return $return;
}


#
# function GetPhonebookEntry
# Parameter: $first_row (first row to display)
#            $max   (max rows)
# Return: if ok $result
#       : if fails false
# Get MAX_ANZ rows beginning at $first
#
#
function GetPhonebookEntry($first_row) {
    global $DB, $link, $MAX_ANZ;
    global $user, $pass, $Server_ip_ext, $clickAt, $direction, $searchTag;


    $orderF = "last_name";
    $strSearch1 = "";
    $strSearch2 = "";

    $strSearch = "";
    $dir    = $direction;

    $orderDir = "ASC";
    if ($dir == 0) { $orderDir = "DESC"; }

    if($clickAt == 1) { $orderF = "last_name"; }
    if($clickAt == 2) { $orderF = "first_name"; }
    if($clickAt == 3) { $orderF = "group_name"; }
    if($clickAt == 4) { $orderF = "bu_name"; }
    if($clickAt == 5) { $orderF = "department"; }
    if($clickAt == 6) { $orderF = "location"; }

    if (strlen($searchTag) > 0) {
	$strSearch = " WHERE last_name LIKE \"%$searchTag%\" or first_name LIKE \"%$searchTag%\" or group_name LIKE \"%$searchTag%\" or bu_name LIKE \"%$searchTag%\" or department LIKE \"%$searchTag%\" or location LIKE \"%$searchTag%\" ";
	if ($DB) { print "str: $strSearch\n"; }
    }
    $statement="SELECT first_name,last_name,office_num,cell_num,other_num1,other_num2,bu_name,department,group_name,job_title,location,office_num_phone_code,cell_num_phone_code,other_num1_phone_code,other_num2_phone_code from contact_information $strSearch ORDER BY $orderF $orderDir LIMIT $MAX_ANZ OFFSET $first_row;";
    if ($DB) print "$statement\n";
    $result=mysql_to_mysqli($statement, $link);
    return $result;
}

#
# function CountColum
# Parameter: ./.
# Return: ./.
# Fill dispColum with count of data fields
#
function CountColum() {
    global $DB, $link, $dispColum, $mel;

    $Anz = 0;

    $statement="SELECT count(*) from contact_information WHERE office_num > '';";
    if ($DB) print "$statement\n";
    $result=mysql_to_mysqli($statement, $link);
    $Anz=mysqli_fetch_row($result);
    $dispColum[0] = $Anz[0];
 
    $statement="SELECT COUNT(*) from contact_information WHERE cell_num > '';";
    if ($DB) print "$statement\n";
    $result=mysql_to_mysqli($statement, $link);
    $Anz=mysqli_fetch_row($result);
    $dispColum[1] = $Anz[0];

    $statement="SELECT COUNT(*) from contact_information WHERE other_num1 > '';";
    if ($DB) print "$statement\n";
    $result=mysql_to_mysqli($statement, $link);
    $Anz=mysqli_fetch_row($result);
    $dispColum[2] = $Anz[0];

    $statement="SELECT COUNT(*) from contact_information WHERE other_num2 > '';";
    if ($DB) print "$statement\n";
    $result=mysql_to_mysqli($statement, $link);
    $Anz=mysqli_fetch_row($result);
    $dispColum[3] = $Anz[0];

    $statement="SELECT COUNT(*) from contact_information WHERE bu_name > '';";
    if ($DB) print "$statement\n";
    $result=mysql_to_mysqli($statement, $link);
    $Anz=mysqli_fetch_row($result);
    $dispColum[4] = $Anz[0];

    $statement="SELECT COUNT(*) from contact_information WHERE department > '';";
    if ($DB) print "$statement\n";
    $result=mysql_to_mysqli($statement, $link);
    $Anz=mysqli_fetch_row($result);
    $dispColum[5] = $Anz[0];

    $statement="SELECT count(*) from contact_information WHERE group_name > '';";
    if ($DB) print "$statement\n";
    $result=mysql_to_mysqli($statement, $link);
    $Anz=mysqli_fetch_row($result);
    $dispColum[6] = $Anz[0];

    $statement="SELECT COUNT(*) from contact_information WHERE job_title > '';";
    if ($DB) print "$statement\n";
    $result=mysql_to_mysqli($statement, $link);
    $Anz=mysqli_fetch_row($result);
    $dispColum[7] = $Anz[0];

    $statement="SELECT COUNT(*) from contact_information WHERE location > '';";
    if ($DB) print "$statement\n";
    $result=mysql_to_mysqli($statement, $link);
    $Anz=mysqli_fetch_row($result);
    $dispColum[8] = $Anz[0];
}



#
# GenAPIforAgent
# Parameter: $phone (phone nummber to call)
# Return: ./.
#
# api call not tested!
#
function GenAPIforAgent($phone, $a_status, $pc) {
    global $Server_ip_ext, $pass, $user, $IMAGE_SIZE;

    $CallStr="";
    $CallStr1="";
    $phone_1="";

    $phone_1 = CheckPhoneNumber($phone);
    $phone = $phone_1;

    print "  <TD nowrap>\n";
    if (strlen($phone) > 0) {
	#
	# Incall activ -> conference
	# or
	# call to hold and new call
	#
        if ($a_status == 2) {
	    print "<input type=\"image\" id=\"Call3\" onClick=\"CallandPark($phone, $pc)\" src=\"./images/phone32.png\" style=\"width: $IMAGE_SIZE; height: $IMAGE_SIZE;\" alt=\"Call\" border=\"0\"> </input>\n";
	    print "<input type=\"image\" id=\"Call2\" onClick=\"CallConf($phone, $pc)\" src=\"./images/conf-32.png\" style=\"width: $IMAGE_SIZE; height: $IMAGE_SIZE;\" alt=\"Call\" border=\"0\"> </input>\n";
        }
        # paused -> call
        elseif ($a_status == 1) {
    	    print "<input type=\"image\" id=\"Call1\" onClick=\"CallExtern($phone, $pc)\" src=\"./images/phone32.png\" style=\"width: $IMAGE_SIZE; height: $IMAGE_SIZE;\" alt=\"Call\" border=\"0\"> </input>\n";
        }
        # ready -> call
        elseif ($a_status == 0) {
    	    print "<input type=\"image\" id=\"Call1\" onClick=\"CallExtern($phone, $pc)\" src=\"./images/phone32.png\" style=\"width: $IMAGE_SIZE; height: $IMAGE_SIZE;\" alt=\"Call\" border=\"0\"> </input>\n";
        }
    }
    print "  </TD>\n";
}


#
# function PrintTableHeader
# Parameter: ./.
# Return: ./.
# Output the title and set the attributes.
# Display the table header.
#
function PrintTableHeader() {
    global $TABLE_PARA, $count_disp_row, $IMAGE_SIZE, $dispColum;
    global $first, $user, $pass, $Server_ip_ext, $clickAt, $direction;
    
    $dir = $direction;
    $AnzDir = array (1, 1, 1, 1, 1, 1, 1);
    
    if($clickAt > 0) {
        if($dir == 0) {
	    $AnzDir[$clickAt] = 1;
	}
	else
	{
	    $AnzDir[$clickAt] = 0;
	}
    }
    print "<TABLE $TABLE_PARA>\n";
    print "<TR>\n";
    print "  <TH nowrap>"._QXZ("Last Name")."<a href=\"./vdc_phonebook_display.php?first_row=0&user=$user&pass=$pass&Server_ip_ext=$Server_ip_ext&clickat=1&direction=$AnzDir[1]\"><img src=\"./images/up-down-arrow32.png\" width=\"$IMAGE_SIZE\" height=\"$IMAGE_SIZE\" alt=\"up/down\" /></a> </TH>\n";
    print "  <TH nowrap>"._QXZ("First Name")."<a href=\"./vdc_phonebook_display.php?first_row=0&user=$user&pass=$pass&server_ip=$Server_ip_ext&clickat=2&direction=$AnzDir[2]\"><img src=\"./images/up-down-arrow32.png\" width=\"$IMAGE_SIZE\" height=\"$IMAGE_SIZE\" alt=\"up/down\" /></a></TH>\n";
    if($dispColum[0]) {
	print "  <TH nowrap colspan=\"2\">"._QXZ("Office")."</TH>\n";
    }
    if($dispColum[1]) {
        print "  <TH nowrap colspan=\"2\">"._QXZ("Cell")."</TH>\n";
    }
    if($dispColum[2]) {
        print "  <TH nowrap colspan=\"2\">"._QXZ("Other 1")."</TH>\n";
    }
    if($dispColum[3]) {
        print "  <TH nowrap colspan=\"2\">"._QXZ("Other 2")."</TH>\n";
    }
    if($dispColum[6]) {
        print "  <TH nowrap>"._QXZ("Group")."<a href=\"./vdc_phonebook_display.php?first_row=0&user=$user&pass=$pass&server_ip=$Server_ip_ext&clickat=3&direction=$AnzDir[3]\"><img src=\"./images/up-down-arrow32.png\" width=\"$IMAGE_SIZE\" height=\"$IMAGE_SIZE\" alt=\"up/down\" /></a></TH>\n";
    }
    if($dispColum[4]) {
        print "  <TH nowrap>"._QXZ("BU")."<a href=\"./vdc_phonebook_display.php?first_row=0&user=$user&pass=$pass&server_ip=$Server_ip_ext&clickat=4&direction=$AnzDir[4]\"><img src=\"./images/up-down-arrow32.png\" width=\"$IMAGE_SIZE\" height=\"$IMAGE_SIZE\" alt=\"up/down\" /></a></TH>\n";
    }
    if($dispColum[5]) {
        print "  <TH nowrap>"._QXZ("Department")."<a href=\"./vdc_phonebook_display.php?first_row=0&user=$user&pass=$pass&server_ip=$Server_ip_ext&clickat=5&direction=$AnzDir[5]\"><img src=\"./images/up-down-arrow32.png\" width=\"$IMAGE_SIZE\" height=\"$IMAGE_SIZE\" alt=\"up/down\" /></a></TH>\n";
    }
    if($dispColum[8]) {
	print "  <TH nowrap>"._QXZ("Location")."<a href=\"./vdc_phonebook_display.php?first_row=0&user=$user&pass=$pass&server_ip=$Server_ip_ext&clickat=6&direction=$AnzDir[6]\"><img src=\"./images/up-down-arrow32.png\" width=\"$IMAGE_SIZE\" height=\"$IMAGE_SIZE\" alt=\"up/down\" /></a></TH>\n";
    }
    if($dispColum[7]) {
	print "  <TH nowrap>"._QXZ("Job Title")."</TH>\n";
    }
    print "</TR>\n";

    $count_disp_row = 0;

}

#
# function PrintTableLast
# Parameter: $first (first displayed row)
#            $anz   (count displayed rows)
# Return: ./.
# Close the Table and display next and or prev, if required
#
function PrintTableLast($first, $anz) {
    global $MAX_ANZ, $user, $pass, $Server_ip_ext;
    global $clickAt, $direction;

    print "</TABLE>\n";
    $next = $first + $anz;
    $prev = $first - $MAX_ANZ;
    # row can not lesser 0
    if ($prev < 0) $prev = 0;
    if($first > 0) print "<a href=\"./vdc_phonebook_display.php?first_row=$prev&user=$user&pass=$pass&server_ip=$Server_ip_ext&clickat=$clickAt&direction=$direction\"><img src=\"./images/arrow_left32.png\" width=\"$IMAGE_SIZE2\" height=\"$IMAGE_SIZE2\" alt=\"Prev\" /></a> ";
    if($anz == $MAX_ANZ) print "<a href=\"./vdc_phonebook_display.php?first_row=$next&user=$user&pass=$pass&server_ip=$Server_ip_ext&clickat=$clickAt&direction=$direction\"><img src=\"./images/arrow_right32.png\" width=\"$IMAGE_SIZE2\" height=\"$IMAGE_SIZE2\" alt=\"Next\" /></a>\n";
}

#
# function PrintTableRow
# Parameter $row_i (array with the phonebook data)
# Retrun: ./.
# Display a phonebook data row.
#
#
function PrintTableRow($row_i, $AgentStat) {
    global $user, $TABLE_COLOR1, $TABLE_COLOR2, $count_disp_row, $dispColum;

    $count_disp_row++;
    if ( $count_disp_row % 2 == 0) {
	print "<TR bgcolor=\"$TABLE_COLOR1\">\n";
    }
    else {
	print "<TR bgcolor=\"$TABLE_COLOR2\">\n";
    }
    print "  <TD nowrap>$row_i[1]</TD>\n";
    print "  <TD nowrap>$row_i[0]</TD>\n";
    if($dispColum[0]) {
	print "  <TD nowrap>$row_i[2]</TD>\n";
	GenAPIforAgent($row_i[2], $AgentStat, $row_i[11]);
    }
    if($dispColum[1]) {
	print "  <TD nowrap>$row_i[3]</TD>\n";
	GenAPIforAgent($row_i[3], $AgentStat, $row_i[12]);
    }
    if($dispColum[2]) {
	print "  <TD nowrap>$row_i[4]</TD>\n";
	GenAPIforAgent($row_i[4], $AgentStat, $row_i[13]);
    }
    if($dispColum[3]) {
	print "  <TD nowrap>$row_i[5]</TD>\n";
	GenAPIforAgent($row_i[5], $AgentStat, $row_i[14]);
    }
    if($dispColum[6]) {
	print "  <TD nowrap>$row_i[8]</TD>\n";
    }
    if($dispColum[4]) {
	print "  <TD nowrap>$row_i[6]</TD>\n";
    }
    if($dispColum[5]) {
	print "  <TD nowrap>$row_i[7]</TD>\n";
    }
    if($dispColum[8]) {
	print "  <TD nowrap>$row_i[10]</TD>\n";
    }
    if($dispColum[7]) {
	print "  <TD nowrap>$row_i[9]</TD>\n";
    }
    print "</TR>\n";
}


$result=GetPhoneBookEntry($first);

$count=mysqli_num_rows($result);
if ($DB) {
    print "Count: $count\n first: $first\n";
}

if ($LOG == 1) {
    print "(Debug aktiv) ";
}

PBLog("<start>User: $user, IP: $Server_ip_ext; Proto: $HTTPprotocol\n");


if(($count == 0) && ($first > 0)) {
    $first = $first - $MAX_ANZ;
    if($first < 0) { $first = 0; }

    $result=GetPhoneBookEntry($first);
    $count=mysqli_num_rows($result);
    if ($DB) {
	print "After Count: $count\n first: $first\n";
    }
}
    $al=GetGroupAlias($user);
    print ("Group Alias: $al");
    $AgentStat = GetAgentStatus($user);
    if ($AgentStat == -2) {
	echo "<script type=\"text/javascript\">SetAgentToPause();</script>\n";
	print "Status wird überprüft. Bitte warten!\n";
	PBLog("<ch_status1>User: $user, IP: $Server_ip_ext; Proto: $HTTPprotocol\n");
    	sleep(1);
	PBLog("<ch_status2>User: $user, IP: $Server_ip_ext; Proto: $HTTPprotocol\n");
    }
    
    print "<form action=\"./vdc_phonebook_display.php\" method=\"post\" autocomplete=\"off\">\n";
    print "  <label for \"searchtag\">"._QXZ("Search:")."\n";
    print "    <input id=\"searchtag\" name=\"searchtag\" value=\"$searchTag\">\n";
    print "  </label>\n";
    print "  <input type=\"hidden\" name=\"first\" value=\"$frist\">\n";
    print "  <input type=\"hidden\" name=\"user\" value=\"$user\">\n";
    print "  <input type=\"hidden\" name=\"pass\" value=\"$pass\">\n";
    print "  <input type=\"hidden\" name=\"server_ip\" value=\"$Server_ip_ext\">\n";
    print "  <input type=\"hidden\" name=\"clickat\" value=\"$clickAt\">\n";

    print "  <input type=\"submit\" value=\""._QXZ("search")."\">\n";
    print "</form>\n";

$AgentStat = GetAgentStatus($user);

if($AgentStat < 0) {
    echo "<script type=\"text/javascript\">SetAgentToPause();</script>\n";
    print "Agenten Status: $AgentStat\n";
    print "Bitte warten.\n";  
}
else {
    if($count > 0) {

        CountColum();

	PrintTableHeader();
        $i = 0;
	while ($count > $i) {
    	    PrintTableRow(mysqli_fetch_row($result), $AgentStat);
    	    $i++;
	}
	PrintTableLast($first, $i);
    }
    else {
	print "no Data to display\n";
    }
}

?>
