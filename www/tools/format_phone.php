<?php 


require_once('vendor/autoload.php');

use PHPMailer\PHPMailer\PHPMailer;


function FormatPhoneNr($LK, $Phone) {
	
	$phoneNumberUtil = \libphonenumber\PhoneNumberUtil::getInstance();
	$ParseNr = "+".$LK . $Phone;
	$phoneNumberObject = $phoneNumberUtil->parse($ParseNr, "");
	
	return $phoneNumberUtil->format($phoneNumberObject, \libphonenumber\PhoneNumberFormat::INTERNATIONAL);
}





?>