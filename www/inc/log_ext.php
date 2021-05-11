<?php 



class Log {
    private $LogFile;
    private $File;
    private $Version;
    private $Type;

    protected setup $Setup;
    
    function __construct($File, $Vers = "unbk.", $Type = "FILE") {
        
        $this->LogFile = $File;
        $this->Version = $Vers;
        $this->Type    = $Type;
        if($this->Type == "SYSLOG") {
        	openlog($this->LogFile, LOG_PID, LOG_LOCAL4);
        } else {
        	$this->File = fopen($this->LogFile,"a");
        }
        
    }
    
    function Log($LText, $LogLevel = LOG_WARNING) {
        if($this->Type == "SYSLOG") {
        	$str = "(Version: " . $this->Version ."): ". $LText;
        	syslog($LogLevel, $str);
        } else {
        	$Time=date("Y-m-d H:i:s ");
        	$str = $Time . "(Version: " . $this->Version ."): ". $LText . PHP_EOL;
        	fputs($this->File, $str );
        }
    }
    
    function __destruct() {
    	if($this->Type == "SYSLOG") {
    		closelog();
    	} else {
			fclose($this->File);
    	}
    }
}


?>