<?php 

#
# start_head.php
#
# License AGPLv3
#
# Copyright 2020      Jörg Frings-Fürst <open_source@jff.email>
#           2020      SNCT GmbH <info@snct-gmbh.de>
#
# Version 0.0.1
#
# changelog
#
# 2020-06-11	0.0.1	jff	first work
#
#


$version="0.0.1";

#
# $DB
# set to 1 to enable debug messages
#
#$DB=0;
#$Debug=0;
#$mel=0;
#$LOG=1;


#
# first part: Login
#
$non_latin = 1;

if((isset($Source)) && ($Source == "logout")) {
	
	Header("WWW-Authenticate: Basic realm=\"SNCT-Dialer\"");
	Header("HTTP/1.0 401 Unauthorized");
	$Source = "";
	$PHP_AUTH_USER="";
	$_SERVER['PHP_AUTH_USER'] = "";
	$PHP_AUTH_PW="";
	$_SERVER['PHP_AUTH_PW'] = "";
	$PHP_SELF=$_SERVER['PHP_SELF'];
	
	print "<center>Klick <a href=\"".$PHP_SELF."\">here</a> zum Login</center>";
	exit;
}


if (file_exists('../inc/include.php')) {
	require_once '../inc/include.php';
} elseif (file_exists('./inc/include.php')) {
	require_once './inc/include.php';
} else {
	require_once 'om/inc/include.php';
}


$SetupDir = "/etc/snct-dialer/";
$SetupFiles = array ("snct-dialer.conf", "snct-dialer.ini", "snct-dialer.local");

$SetUp = setup::MakeWithArray($SetupDir, $SetupFiles);

require_once '../inc/token.php';

$Log = new Log($SetUp->GetData("Log", "File"), $version);

$Log->Log("Start");

$mysql = new DB($SetUp->GetData("Database", "Server"),
	$SetUp->GetData("Database", "Database"),
	$SetUp->GetData("Database", "User"),
	$SetUp->GetData("Database", "Pass"),
	$SetUp->GetData("Database", "Port"));

$Log->Log("Before Login");

#require_once 'om/inc/token.php';

$ret = ReadLoginToken();
$Log->Log("Test token |" . $ret . "|");

if($ret != 0) {
	$Log->Log("wrong token |" . $ret . "|");
	
	//    $_SERVER['PHP_AUTH_USER'] = "";
	//    $_SERVER['PHP_AUTH_PW'] = "";
	//    $PHP_AUTH_USER="";
	//    $PHP_AUTH_PW="";
	require_once '../inc/login_admin.php';
	if($auth == 1) {
		$Log->Log("Login ok");
		SetLoginToken($_SERVER['PHP_AUTH_USER'], $_SERVER['PHP_AUTH_PW'], $user_level, $user_group);
	}
	
} else {
	$Log->Log("Token ok");
	require_once '../inc/login_admin.php';
	$auth_message = user_authorization($PHP_AUTH_USER,$PHP_AUTH_PW,'',1,0);
}

$Log->Log("After Login");



?>