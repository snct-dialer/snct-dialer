<?php

#
# db_ng.php
#
# License AGPLv3
#
# Copyright 2017-2020 by Jörg Frings-Fürst <open_source@jff.email>
#           2019-2020 by SNCT GmbH <info@snct-gmbh.de>
#
# Version 1.0.2
#
# changelog
#
# 2018-07-11 jff Change to mysqli
# 2018-07-21 jff Simplify connect_mysqli()
# 2018-10-29 jff Remove not db stuff
#            jff Switch to class
# 2020-09-15 jff Rename to db_ng.php


class DB {
    private $db_server;
    private $db_name;
    private $db_user;
    private $db_pass;
    private $db_port;
    private $db_persist;

    private $db_server_res;
    private $db_name_res;
    private $db_user_res;
    private $db_pass_res;
    private $db_port_res;

    private $db_server_ro;
    private $db_name_ro;
    private $db_user_ro;
    private $db_pass_ro;
    private $db_port_ro;

	private $Selected_Server;
	
	public mysqli $MySqlHdl;

	function __construct($Server, $Name, $User, $Pass, $Port="3306", $Persist = true, $ServerRes = "") {
		global $Log;

		$this->db_server = $Server;
		$this->db_name   = $Name;
		$this->db_user   = $User;
		$this->db_pass   = $Pass;
		$this->db_port   = $Port;
		$this->db_persist = $Persist;
		
		$this->db_server_res = $ServerRes;
		$this->db_name_res   = $Name;
		$this->db_user_res   = $User;
		$this->db_pass_res   = $Pass;
		$this->db_port_res   = $Port;
		

		$Log->Log("Init DB");

		parent::init();
		parent::options(MYSQLI_OPT_CONNECT_TIMEOUT, 1);
		$this->Selected_Server = 1;
		@parent::real_connect(($this->db_persist ? 'p:' : '') . $this->db_host, $this->db_user, $this->db_pass, $this->db_name, $this->db_port);
		
		if ($this->connect_error) {
			die('Connect Error (' . $this->connect_errno . ') '
				. $this->connect_error);
		}

	}

    function __destruct() {
        $this->close();
    }
    
    function CheckConnection() {
    	return $this->ping();
    }
}


function connect($use_mysqli=true) {
    if($use_mysqli)	{
	   return connect_mysqli();
	} else {
	   return false;
	}
}
	
function connect_mysqli() {
	    
    global $db, $db_name, $db_user, $db_pass;
    
	$mysqli = new mysqli($db,  $db_user, $db_pass, $db_name);
	if($mysqli->connect_error) {
	    edump("Konnte Verbindung zum Datenbankserver ". $db ." nicht herstellen: ". $mysqli->connect_error);
        exit(10);
	}
	return $mysqli;
}

function CheckConnectition() {
	
}
?>
