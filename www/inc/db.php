<?php

#
# db.php
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
#


class DB {
    private $db_server;
    private $db_name;
    private $db_user;
    private $db_pass;
    private $db_port;

    public mysqli $MySqlHdl;

    function __construct($Server, $Name, $User, $Pass, $Port="3306") {
        global $Log;

        $this->db_server = $Server;
        $this->db_name   = $Name;
        $this->db_user   = $User;
        $this->db_pass   = $Pass;
        $this->db_port   = $Port;

        $Log->Log("Init DB");

        $this->MySqlHdl = new mysqli($this->db_server, $this->db_user, $this->db_pass, $this->db_name, $this->db_port);
        if ($this->MySqlHdl->connect_error) {
            die('Connect Error (' . $this->MySqlHdl->connect_errno . ') '
                . $this->MySqlHdl->connect_error);
        }
    }

    function __destruct() {
        $this->MySqlHdl->close();
    }
    
    function CheckConnection() {
    	return $this->MySqlHdl->ping();
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
