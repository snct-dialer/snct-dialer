<?php 
#
# Modul Block All Inbounds from list_id
#
# Copyright (©) 2019 Jörg Frings-Fürst (j.fringsfuerst@snct-dialer.de)
#               2019 SNCT Gmbh (info@snct-gmbh.de)
#
#  LICENSE: AGPLv3
#
# Changelog:
# 20190305 jff First work
# 20190308 jff if not set get phone_code from vicidial_inbound_dids
#
#

$mod_vd_block = '0.0.2';
$build = '171012-1157';


if (isset($_GET["DB"]))						{$DB=$_GET["DB"];}
    elseif (isset($_POST["DB"]))			{$DB=$_POST["DB"];}
if (isset($_GET["phone_number"]))			{$phone_number=$_GET["phone_number"];}
    elseif (isset($_POST["phone_number"]))	{$phone_number=$_POST["phone_number"];}
if (isset($_GET["did_pattern"]))    		{$did_pattern=$_GET["did_pattern"];}
    elseif (isset($_POST["did_pattern"]))	{$did_pattern=$_POST["did_pattern"];}
if (isset($_GET["list_id"]))                {$list_id=$_GET["list_id"];}
    elseif (isset($_POST["list_id"]))   	{$list_id=$_POST["list_id"];}
if (isset($_GET["phone_code"]))		       	{$phone_code=$_GET["phone_code"];}
    elseif (isset($_POST["phone_code"]))	{$phone_code=$_POST["phone_code"];}

if((!isset($list_id)) | (!isset($phone_code)) | (!isset($phone_number))) {
    exit(0);
}

require("dbconnect_mysqli.php");
require("functions.php");

if(!isset($phone_code)) {
    $sql = "SELECT `phone_code` FROM `vicidial_inbound_dids` WHERE `did_pattern` = '$did_pattern';";
    if ($DB) {echo "|$sql|\n";}
    $rslt1=mysql_to_mysqli($sql, $link);
    $row1=mysqli_fetch_row($rslt1);
    $phone_code=$row1[0];
}

$sql = "SELECT COUNT(*) FROM `vicidial_list` WHERE (`phone_number` = '$phone_number' OR `alt_phone` = '$phone_number') AND `list_id` = '$list_id' AND `phone_code` = '$phone_code';";
if ($DB) {echo "|$sql|\n";}
$rslt2=mysql_to_mysqli($sql, $link);
$row2=mysqli_fetch_row($rslt2);
$found=$row2[0];

exit($found);

?>