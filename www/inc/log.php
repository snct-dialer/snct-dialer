<?php 



class Log {
    private $LogFile;
    private $File;
    private $Version;
    
    function __construct($File, $Vers = "unbk.") {
        
        $this->LogFile = $File;
        $this->Version = $Vers;
        $this->File = fopen($this->LogFile,"a");
        
    }
    
    function Log($LText) {
        $Time=date("Y-m-d H:i:s ");
        $str = $Time . "(Version: " . $this->Version ."): ". $LText . PHP_EOL;
        fputs($this->File, $str );
    }
    
    function __destruct() {
        fclose($this->File);
    }
    
}


?>