<?php 


require_once('vendor/autoload.php');

use PHPMailer\PHPMailer\PHPMailer;

$NumberType[0] = array('Long' => _("Land Line"),
	'Short'   => _("LL"));
$NumberType[1] = array('Long' => _("Mobile"),
	'Short'   => _("Mo"));
$NumberType[2] = array('Long' => _("Land Lind or Mobile"),
		'Short'   => _("LM"));
$NumberType[3] = array('Long' => _("Toll free"),
	'Short'   => _("TF"));
$NumberType[4] = array('Long' => _("Premium Rate"),
	'Short'   => _("PR"));
$NumberType[5] = array('Long' => _("Shared Cost"),
	'Short'   => _("SC"));
$NumberType[6] = array('Long' => _("VoIP"),
	'Short'   => _("Vo"));
$NumberType[7] = array('Long' => _("Personal Number"),
	'Short'   => _("PN"));
$NumberType[8] = array('Long' => _("Pager"),
	'Short'   => _("Pa"));
$NumberType[9] = array('Long' => _("UAN"),
	'Short'   => _("UA"));
$NumberType[10] = array('Long' => _("Unkown"),
	'Short'   => _("Un"));
$NumberType[27] = array('Long' => _("Emergency"),
	'Short'   => _("Em"));
$NumberType[28] = array('Long' => _("Voice Mail"),
	'Short'   => _("VM"));
$NumberType[29] = array('Long' => _("Short Code"),
	'Short'   => _("SC"));
$NumberType[30] = array('Long' => _("Standart Rate"),
	'Short'   => _("SR"));




function FormatPhoneNr($LK, $Phone, $type = false) {
	global $NumberType;
	
	$ret = "";
	if($Phone != "Anonymous") {
		$phoneNumberUtil = \libphonenumber\PhoneNumberUtil::getInstance();
		$ParseNr = "+".$LK . $Phone;
		$phoneNumberObject = $phoneNumberUtil->parse($ParseNr, "");
		$ret =  $phoneNumberUtil->format($phoneNumberObject, \libphonenumber\PhoneNumberFormat::INTERNATIONAL);
		if($type == true) {
			$tmpTyp = $phoneNumberUtil->getNumberType($phoneNumberObject);
			$ret .= " (".$NumberType[$tmpTyp]["Short"].")";
		}
	} else {
		$ret = $Phone;
	}
	return $ret; 
}





?>