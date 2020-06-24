<?php 

#
# token.php
#
# License AGPLv3
#
# Copyright 2018-2019 by Jörg Frings-Fürst <open_source@jff.email>
#           2018-2019 by SNCT GmbH <info@snct-gmbh.de>
#
# Version 0.0.2
#
# changelog
#
# 2018-08-31 jff first work
# 2019-05-13 jff Add json web token 
#
#


#$version="0.0.2";
#$build = "20190513-0935";

#
# $DB
# set to 1 to enable debug messages
#
#$DB=1;
#$Debug=0;
#$mel=0;
#$LOG=1;


use \Firebase\JWT\JWT;
use \setup;



if (file_exists('../inc/vendor/autoload.php')) {
    require_once '../inc/vendor/autoload.php';
} elseif (file_exists('./inc/vendor/autoload.php')) {
    require_once './inc/vendor/autoload.php';
} else {
    require_once 'om/inc/vendor/autoload.php';
}
#require_once('inc/vendor/autoload.php');



function ReadLoginToken() {
    global $SetUp;
    
    $jwt =  $_COOKIE[$SetUp->GetData("Login", "Name")];
    
    if(!isset($jwt)) {
        return 4;
    }
    $key = '12345678901234567890123456789012';
    try {
        $decoded = JWT::decode($jwt, $SetUp->GetData("Login", "Key"), array('HS512'));
        $decoded_array = (array) $decoded;
        if($decoded_array['loggedInBrowser'] != getenv("HTTP_USER_AGENT")) {
            return 3;
        }
    } catch (Exception  $e) {
        return 2;
    }
    $_SERVER['PHP_AUTH_USER'] = $decoded_array["loggedInAs"];
    $_SERVER['PHP_AUTH_PW'] = $decoded_array["loggedInPW"];

//    print_r($decoded_array);
    return 0;

}

function SetLoginToken($User, $Pass, $Level, $Group) {
    global $SetUp;
        
    $key = '12345678901234567890123456789012';
    $maxTime = time() + $SetUp->GetData("Login", "Time");
    $now = time();
    
    $token = array(
        "iss" => "snct-dialer.de",
        "jti" => "47114711",
        "aud" => "4711",
        "exp" => $maxTime,
        "iat" => $now,
        "loggedInAs" => $User,
        "loggedInLevel" => $Level,
        "loggedInGroup" => $Group,
        "loggedInPW" => $Pass, 
        "loggedInIP" => getenv("REMOTE_ADDR"),
        "loggedInBrowser" => getenv("HTTP_USER_AGENT")
    );
    
    $jwt = JWT::encode($token, $SetUp->GetData("Login", "Key"), 'HS512');
    
    setcookie($SetUp->GetData("Login", "Name"), $jwt, 0);
    
}

?>