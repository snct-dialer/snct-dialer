<?php 

class setup {
    private $ini_file1, $ini_file2, $ini_file3;
    private $SetUp = array();
    
    private function __construct() {
        $ini_file1 = "";
        $ini_file2 = "";
        $ini_file3 = "";
    }
    
    
    public static function MakeWithFile($file) {
        
        $obj = new setup(); 
        
        $obj->ini_file1 = $file;
        $obj->SetUp = parse_ini_file($obj->ini_file1, TRUE);
        
        return $obj;
    }
    
    public static function MakeWithArray($Dir, $FileArray) {
        
        $obj = new setup();
        
        
        $obj->ini_file1 = $Dir . $FileArray[0];
        $obj->ini_file2 = $Dir . $FileArray[1];
        $obj->ini_file3 = $Dir . $FileArray[2];
        
 #       print $obj->ini_file1 . "|" . $obj->ini_file3 . "|" . $obj->ini_file3 . PHP_EOL;
        
        if(file_exists($obj->ini_file1)) {
            $defcfg = parse_ini_file($obj->ini_file1, TRUE);
        }
        if(file_exists($obj->ini_file2)) {
            $newcfg = parse_ini_file($obj->ini_file2, TRUE);
        }
        if(file_exists($obj->ini_file3)) {
            $loccfg = parse_ini_file($obj->ini_file3, TRUE);
        }
        $obj->SetUp = array_replace($defcfg, $newcfg, $loccfg);
        
        return $obj;
    }
    
    function GetData($Section, $Para) {
        
        try {
            $section =& $this->SetUp[$Section];
        } 
        catch (Exception $e) {
            return "";
        }
                
        return  $section[$Para];
    }
    
    function TestData($Section, $Para) {
        
        $section =& $this->SetUp[$Section];
        
        return  isset($section[$Para]);
    }
    
}


?>