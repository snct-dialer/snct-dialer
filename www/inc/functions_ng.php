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




#curl_post_url("https://mosel-lug.de/", "");


?>