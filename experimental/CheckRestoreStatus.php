<?php


# Copyright (c) 2018-2019 Jörg Frings-Fürst <jff@flyingpenguin.de>   LICENSE: AGPLv3
#               2018-2019 flyingpenguin UG <info@flyingpenguin.de>
#
# Check and restore Status
#
# 20190104-0000 - first work
# 20190104-2253 - first release
#

$version="1.0.1";
$build = "20190104-2253";

#
#Globale Settings
#
$DB = 0;
date_default_timezone_set("Europe/Berlin");


#
# Read config
#
$defcfg = [];
$newcfg = [];
$loccfg = [];
$cfglog = [];

if(file_exists("/etc/flyingpenguin/vicidial.conf")) {
    $defcfg = parse_ini_file("/etc/flyingpenguin/vicidial.conf", TRUE);
}
if(file_exists("/etc/flyingpenguin/vicidial.ini")) {
    $newcfg = parse_ini_file("/etc/flyingpenguin/vicidial.ini", TRUE);
}
if(file_exists("/etc/flyingpenguin/vicidial.local")) {
    $loccfg = parse_ini_file("/etc/flyingpenguin/vicidial.local", TRUE);
}

if(file_exists("/etc/flyingpenguin/CheckRestoreStatus.ini")) {
    $cfgloc = parse_ini_file("/etc/flyingpenguin/CheckRestoreStatus.ini", TRUE);
} else {
    print ("Missing /etc/flyingpenguin/CheckRestoreStatus.ini" . PHP_EOL);
    exit(1);
}

$cfg =  array_replace($defcfg, $newcfg, $loccfg);

#print_r($cfgloc);

$Anz = count($cfgloc["RestoreStatus"]["Status"],  COUNT_RECURSIVE);
$EmailTo   = $cfgloc["Email"]["To"];
$EmailFrom = $cfgloc["Email"]["From"];
$EmailReply = $cfgloc["Email"]["Reply"];
$EmailBCC = $cfgloc["Email"]["BCC"];

$WebServerRoot  = $cfg["Path"]["PATHweb"];
$VARDB_server   = $cfg["Database"]["VARDB_server"];
$VARDB_database = $cfg["Database"]["VARDB_database"];
$VARDB_user     = $cfg["Database"]["VARDB_user"];
$VARDB_pass     = $cfg["Database"]["VARDB_pass"];
$VARDB_port     = $cfg["Database"]["VARDB_port"];


require_once($WebServerRoot . "/vicidial/dbconnect_mysqli.php");
require_once($WebServerRoot . "/vicidial/functions.php");

$strlog = "";

for($n = 0; $n != $Anz; $n++) {
    #    print_r ($cfgloc[RestoreStatus][Status][$n] . PHP_EOL);

    $search = $cfgloc["RestoreStatus"]["Status"][$n];
    $statement = "SELECT * FROM `vicidial_agent_log` WHERE `status` = '$search';";
    if ($DB) { print ($statement . PHP_EOL); }
    if(!($result=mysqli_query($link, $statement))) {
        printf("Error: %s\n", $mysqli_error($link));
    } else {
        while($row = mysqli_fetch_array($result, MYSQLI_BOTH)) {
            $statement2 = "SELECT * FROM `vicidial_list` WHERE `lead_id` = '". $row["lead_id"] ."' AND `status` != '".$search."';";
            if ($DB) { print ($statement2 . PHP_EOL); }
            if(!($result2=mysqli_query($link, $statement2))) {
                printf("Error: %s\n", $mysqli_error($link));
            } else {
                $AnzRec=mysqli_num_rows($result2);
                if($AnzRec > 0) {
                    $row2 = mysqli_fetch_array($result2, MYSQLI_BOTH);
                    if ($row2["status"] != $search) {
#                        print ($statement2 . PHP_EOL);
#                        print $row["lead_id"] . "|" . $row2["status"] . PHP_EOL;
                        $strlog .= "Lead found! LeadID:". $row["lead_id"] ." Liste: ".$row2["list_id"]." Ist-Status:". $row2["status"]." Soll-Status:".$search . PHP_EOL;
                        $statement3 = "UPDATE `vicidial_list` SET `status` = '". $search . "' WHERE `lead_id` = '" . $row["lead_id"] . "';";
                        $strlog .= " " . $statement3 . PHP_EOL;
                        if(!mysqli_query($link, $statement3)) {
                            printf("Error: %s\n", mysqli_error($link));
                        }
                    }
                }
            }
        }
    }
}


if((strlen($EmailFrom) > 3) && (strlen($EmailTo) > 3) && (strlen($strlog) > 1)) {

    $header = 'From: ' . $EmailFrom . "\r\n" .
        'Reply-To: ' . $EmailReply . "\r\n" .
        'Bcc: ' . $EmailBCC . "\r\n" .
        'X-Mailer: Script CheckRestoreStatus.php /' . $version;
    $date = date("Y-m-d H:i:s");
    $betreff = "Restore Leadstatus vom " . $date;

    mail($EmailTo, $betreff, $strlog, $header);
}

?>
