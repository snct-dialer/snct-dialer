<?php 


use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;


require_once('/usr/share/php/libphp-phpmailer/autoload.php');


class Email extends PHPMailer {
        
    private $Turnus;
    private $EmailForm;
    private $EmailTo;
    private $EmailCC;
    private $EmailBCC;
    private $EmailReply;
    private $Name;
    private $DateText;
    private $DateVor;
    
    function __construct($Name, $Turnus, $EmailFrom, $EmailTo, $EmailCC, $EmailBCC, $EmailReply, $VendorID, $delta, $File= "") {
          
        $this->Turnus     = $Turnus;
        $this->EmailFrom  = $EmailFrom;
        $this->EmailTo    = $EmailTo;
        $this->EmailCC    = $EmailCC;
        $this->EmailBCC   = $EmailBCC;
        $this->EmailReply = $EmailReply;
        $this->Name       = $Name;
        
        $this->CharSet = 'UTF-8';
        
        if($this->Turnus == "W") {
            
            $startDate = date('d.m.Y', time() - ((6 - $delta) * 24 * 60 * 60));
            $endDate   = date('d.m.Y', time() - ((0 - $delta) * 24 * 60 * 60));
            
            $this->DateText = $startDate . " bis " . $endDate; 
            
            $this->DateVor = " den Zeitraum vom ";
        } else {
            $this->DateText = date("d.m.Y", time() - ((0 - $delta) * 24 * 60 * 60));
            $this->DateVor = " den ";
        }
        
        $this->SetFrom($this->EmailFrom); //Name is optional
        $this->Subject   = 'Umsätze ' .$this->Name . ' für '. $this->DateVor . $this->DateText;
#        $this->Body      = "Test Test Test Test Test" . PHP_EOL . PHP_EOL . PHP_EOL;
        $this->Body     .= "Sehr geehrte Damen und Herren," .PHP_EOL . PHP_EOL;
        $this->Body     .= "anbei die Umsatzdaten für" . $this->DateVor . $this->DateText . "." .PHP_EOL . PHP_EOL;
        $this->Body     .= "Mit freundlichen Grüßen" . PHP_EOL;
#        $this->Body     .= "Test Test Test Test Test" . PHP_EOL . PHP_EOL . PHP_EOL;
        
        $ToList = explode(',', $this->EmailTo);
        $arr_length = count($ToList);
        for($i=0;$i<$arr_length;$i++) {
            $this->addAddress( $ToList[$i]);
        }
        $CCList = explode(',', $this->EmailCC);
        $arr_length = count($CCList);
        for($i=0;$i<$arr_length;$i++) {
            $this->addCC( $CCList[$i]);
        }
        $BCCList = explode(',', $this->EmailBCC);
        $arr_length = count($BCCList);
        for($i=0;$i<$arr_length;$i++) {
            $this->addBCC( $BCCList[$i]);
        }
        $this->addReplyTo($this->EmailReply);
        $this->AddAttachment( $File , $this->Name.'_'.$this->DateText.'.xml' );
    }
    
    function __destruct() {
        
    }
    
    function SendMail() {
        $this->Send();
    }
}


?>