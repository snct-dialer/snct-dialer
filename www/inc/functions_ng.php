<?php
###############################################################################
#
# Modul functions_ng.php
#
# SNCT-Dialer™ global functions
#
# Copyright (©) 2021      SNCT GmbH <info@snct-gmbh.de>
#               2021      Jörg Frings-Fürst <open_source@jff.email>
#
# LICENSE: AGPLv3
#
###############################################################################
#
# requested Module:
#
# ./.
#
###############################################################################
#
# Version  / Build
#
$functions_ng_version = '3.1.1-1';
$functions_ng_build = '20210429-1';
#
###############################################################################
#
# Changelog#
# 
# 2021-04-29 jff    New functions sd_error_log & sd_debug_log
# 2021-04-29 jff    First work
#
#
#

###############################################################################
#
# function sd_error_log
#
# function to write error data into a file including timestamp,
#   source file and source line
#
# Parameter: $data  Variable with the data  
#
# Return: NONE
#
#
# Version 1.0.0
#
###############################################################################
function sd_error_log($data) {
    $fDBName = "/var/log/snct-dialer/error.log";
    
    $bt = debug_backtrace();
    $caller = array_shift($bt);
    $line = $caller['line'];
    $file = array_pop(explode('/', $caller['file']));
    $date = date_create();
    $dateStr = date_format($date, 'Y.m.d H:i:s.u');
    $Output = "[".$dateStr . " " . $file . " Line " . $caller['line'] .  "]: " . json_encode($data);
    file_put_contents($fDBName, $Output . "\n", FILE_APPEND);
}

###############################################################################
#
# function sd_debug_log
#
# function to write error data into a file including timestamp,
#   source file and source line
#
# Parameter: $data  Variable with the data
#
# Return: NONE
#
#
# Version 1.0.0
#
###############################################################################
function sd_debug_log($data) {
    $fDBName = "/var/log/snct-dialer/debug.log";
    
    $bt = debug_backtrace();
    $caller = array_shift($bt);
    $line = $caller['line'];
    $file = array_pop(explode('/', $caller['file']));
    $date = date_create();
    $dateStr = date_format($date, 'Y.m.d H:i:s.u');
    $Output = "[".$dateStr . " " . $file . " Line " . $caller['line'] .  "]: " . json_encode($data);
    file_put_contents($fDBName, $Output . "\n", FILE_APPEND);
}

###############################################################################
#
# function curl_post_url
#
# function to write error data into a file including timestamp,
#   source file and source line
#
# Parameter: $Url       URL to call
#            $Param     Parameter for the url call
#
# Return: array[0]      return status of the call
#                       - OK if (status == 200 && readyState == 4)
#                       - FAIL if !(status == 200 && readyState == 4)
#         array[1]      responseText if array[0] == OK
#
#
# Version 1.0.0
#
###############################################################################
function curl_post_url($Url, $Param) {
    
#    sd_debug_log($Url."|".$Param);
    
    $cUrl = curl_init();
    curl_setopt($cUrl, CURLOPT_URL, $Url);
    curl_setopt($cUrl, CURLOPT_POST, TRUE);
    curl_setopt($cUrl, CURLOPT_POSTFIELDS, $Param);
    curl_setopt($cUrl, CURLOPT_HEADER, FALSE);
    curl_setopt($cUrl, CURLOPT_NOBODY, FALSE); // remove body
    curl_setopt($cUrl, CURLOPT_RETURNTRANSFER, TRUE); 
    
    $responseText = curl_exec($cUrl);
    echo $responseText;
#    sd_debug_log($responseText);
    
}

###############################################################################
#
# function GetEnumItems
#
# function to get the enum items from a field
#
# Parameter: $table     mysql Table
#            $field     mysql Field to check
#            $conn      mysqli Connection
#            $returnType    
#
# Return: array         with the enum items
#
#
# Version 1.0.0
#
###############################################################################
function GetEnumItems($table, $field, $conn, $returnType = "Array") {
       
    $stmt = "SHOW COLUMNS FROM `$table` LIKE '$field'";
    sd_debug_log($stmt);
    if(($res = mysqli_query($conn, $stmt)) === false) 
    {
        sd_debug_log("Invalid query: ". mysqli_error($link));
        return -1;
    }
    $it  = mysqli_fetch_array($res, MYSQLI_BOTH);
    $it = $it["Type"];
    mysqli_free_result($res);
    
    sd_debug_log($it);
    $rst = explode(",", $it);
    while ($elem = each($rst)) {
        $rst[$elem[0]] = str_replace("set('", "", $rst[$elem[0]]);
        $rst[$elem[0]] = str_replace("enum('", "", $rst[$elem[0]]);
        $rst[$elem[0]] = str_replace("')", "", $rst[$elem[0]]);
        $rst[$elem[0]] = str_replace("'", "", $rst[$elem[0]]);
    }
    $count = count($rst);
    for ($i = 0; $i < $count; $i++) {
        sd_debug_log("EnumArry[$i]: ".$rst[$i]);
    }
    if ($returnType == "Array") {
        return $rst;
    } else {
        return implode($returnType, $rst);
    }
}

###############################################################################
#
# function TestCallbacks
#
# function to get the enum items from a field
#
# Parameter: $status    status to test
#
# Return:  bool         true if callback
#                       false if not callback
#                       -1 on error
#
#
# Version 1.0.0
#
###############################################################################
function TestCallbacks($status) {
    global $link;
    
    $ret = false;
    
    $sql = "SELECT * FROM `vicidial_statuses` WHERE `status` = '".$status."' AND `scheduled_callback` = 'Y';";
    sd_debug_log($sql);
    if(($res = mysqli_query($link, $sql)) === false)
    {
        sd_debug_log("Invalid query: ". mysqli_error($link));
        return -1;
    }
    $count = mysqli_num_rows($res);
    if ($count == 1) {
        return true;
    }
    mysqli_free_result($res);
    
    $sql = "SELECT * FROM `vicidial_campaign_statuses` WHERE `status` = '".$status."' AND `scheduled_callback` = 'Y';";
    sd_debug_log($sql);
    if(($res = mysqli_query($link, $sql)) === false)
    {
        sd_debug_log("Invalid query: ". mysqli_error($link));
        return -1;
    }
    $count = mysqli_num_rows($res);
    if ($count == 1) {
        return true;
    }
    mysqli_free_result($res);
    return false;
    
}

###############################################################################
#
# function CheckEnumItems
#
# function to get the enum items from a field
#
# Parameter: $table     mysql Table
#            $field     mysql Field to check
#            $conn      mysqli Connection
#
# Return: bool          true, if field exists
#                       false, if field not exists
#
#
# Version 1.0.0
#
###############################################################################
function CheckField($table, $field, $conn) {
    
    $stmt = "SHOW COLUMNS FROM `$table` LIKE '$field'";
    sd_debug_log($stmt);
    if(($res = mysqli_query($conn, $stmt)) === false)
    {
        sd_debug_log("Invalid query: ". mysqli_error($link));
        return -1;
    }
    if(mysqli_num_rows($res) == 0) {
        return false;
    }
    return true;
}




?>