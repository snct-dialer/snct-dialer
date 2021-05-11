<?php

###############################################################################
#
# Modul tools/login.php
#
# SNCT-Dialer™ global Login Handling class
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
# dbconnect_mysqli.php
# functions.php
# SNCTVersion.inc
# ../tools/system_wide_settings.php
# options.php
# callback_footer.php
#
# vdc_db_query.php
# vdc_db_query_ng.php
# manager_send.php
# conf_exten_check.php
# vdc_script_display.php
# vdc_form_display.php
# vdc_email_display.php
# vdc_chat_display.php
# agc_agent_manager_chat_interface.php
#
###############################################################################
#
# Version  / Build
#
$tool_login_version = '3.2.0-1';
$tool_login_build = '20210126-1';
#
###############################################################################
#
# Global settings
#
$mel=1;					# Mysql Error Log enabled = 1
$mysql_log_count=91;
$one_mysql_log=0;
$DB=0;
#
###############################################################################
#
# Changelog
#
# 2021-01-26 jff	First build
#
#
#



if (file_exists('../inc/include_ext.php')) {
    require_once '../inc/include_ext.php';
} elseif (file_exists('./inc/include_ext.php')) {
    require_once './inc/include_ext.php';
} else {
    require_once '/inc/include_ext.php';
}


$SetupDir = "/etc/snct-dialer/";
$SetupFiles = array ("snct-dialer.conf", "snct-dialer.ini", "snct-dialer.local");

$SetUp = setup::MakeWithArray($SetupDir, $SetupFiles);

$LoG = new Log($SetUp->GetData("Log", "Login_NG"), $tool_login_version);


$mysqldb = new DB($SetUp->GetData("Database", "Server"),
    $SetUp->GetData("Database", "Database"),
    $SetUp->GetData("Database", "User"),
    $SetUp->GetData("Database", "Pass"),
    $SetUp->GetData("Database", "Port"));

#$MySqlLink = $mysqldb->MySqlHdl;



class login {
    
    protected setup $SetuP;
    protected Log $Log;
    protected DB $dB;
    protected mysqli $mysql;
    
	protected string $UserName;
	protected string $UserPw;
	protected bool $Debug = TRUE;
	public string $User;
	private string $PassWD;
	
	public function TestLogin($TestUser, $Pass) {
	    
	    $this->User = $TestUser;
	    $this->PassWD = $Pass;
	    if($this->CheckUser($this->User) === TRUE ) {
	       $tmpHash =  $this->GetHashDb($this->User);
	       if(password_verify($this->PassWD, $tmpHash) === TRUE) {
	           if(password_needs_rehash($tmpHash, PASSWORD_DEFAULT)) {
	               $this->SavePassword($this->User, $this->PassWD);
	               $this->Log->Log("User Password rehashed");
	           }
	           if($this->Debug) {
	               $this->Log->Log("User Login ok");
	           }
	           return TRUE;
	       }
	       $tmpHas = "";
	    }
	    $this->Log->Log("User Login (".$this->User.") failed");
	    return FALSE;
	}
	
	private function CheckUser() {
	    
	    $sql = "SELECT `active` FROM `vicidial_users` WHERE `user` = ?;";
	    $preStmt = $this->mysql->prepare($sql);
	    if($this->Debug) {
	        $this->Log->Log($sql);
	    }
	    $preStmt->bind_param("s", $this->User);
	    $preStmt->execute();
	    $result = $preStmt->get_result();
	    
	    $row = $result->fetch_assoc();
	    
	    if($row["active"] == "Y") {
	        return TRUE;
	    }
	    return FALSE;
	    
	}
	private function GetHashDb() {
	    
	    $sql = "SELECT `password_sec` FROM `vicidial_users` WHERE `user` = ?;";
	    $preStmt = $this->mysql->prepare($sql);
	    if($this->Debug) {
	        $this->Log->Log($sql);
	    }
	    $preStmt->bind_param("s", $this->User);
	    $preStmt->execute();
	    $result = $preStmt->get_result();
	    
	    $row = $result->fetch_assoc();
	    
	    return $row["password_sec"];
	    
	}
	
	public function CheckPassword($User, $Pass) {
	    
	}
	
	public function SavePassword($User, $Pass) {
	    
	    $Pashhh =  password_hash($Pass, PASSWORD_DEFAULT);
	    $sql = "UPDATE `vicidial_users` SET `password_sec` = ? WHERE `user` = ?;";
	    $preStmt = $this->mysql->prepare($sql);
	    $this->Log->Log($sql);
	    $preStmt->bind_param("ss", $Pashhh, $User);
	    $preStmt->execute();
	    #$result = $preStmt->get_result();
	    
	    #$row = $result->fetch_assoc();
	    
	}
	
	
	function __construct() {
	    
	    global $tool_login_version, $LoG, $mysqldb;
	    
	    $this->Log = $LoG;
	    $this->mysql  = $mysqldb;
	    	    
	    $this->UserName = "";
	    $this->UserPw   = "";
	}
}

$Login = new Login();
#$Login->SavePassword("6699", "Test");
$Login->TestLogin("6699", "Test");

?>