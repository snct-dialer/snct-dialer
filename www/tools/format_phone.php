<?php 


# format_phone.php   version 1.0.1
#
# LICENSE: AGPLv3
#
# Copyright (©) 2019-2020 SNCT GmbH <info@snct-dialer.de>
#               2019-2020 Jörg Frings-Fürst <open_source@jff.email>
#
#
# SNCT - Changelog
#
# 2020-03-18 13:30 jff	First work
#
# ToDo:
#
# Remove +
# Check format before use
#
#
# Some Functions to handel phone numbers
#
#
#


require_once('vendor/autoload.php');

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
	if(ctype_digit($Phone)) {
		try {
			$phoneNumberUtil = \libphonenumber\PhoneNumberUtil::getInstance();
			$ParseNr = "+".$LK . $Phone;
			$phoneNumberObject = $phoneNumberUtil->parse($ParseNr, "");
			$ret =  $phoneNumberUtil->format($phoneNumberObject, \libphonenumber\PhoneNumberFormat::INTERNATIONAL);
			if($type == true) {
				$tmpTyp = $phoneNumberUtil->getNumberType($phoneNumberObject);
				$geoCoder = \libphonenumber\geocoding\PhoneNumberOfflineGeocoder::getInstance();
				$TmpCity = $geoCoder->getDescriptionForNumber($phoneNumberObject, 'de');
				$ret .= " (".$NumberType[$tmpTyp]["Short"]." | ".$TmpCity.")";
			}
		} catch (Exception $e) {
#			echo 'Exception abgefangen: ',  $e->getMessage(), "\n";
			$file = 'format_phone.err';
			$Text  = $e->getMessage()."\n";
			$Text .= $Phone ."\n";
			file_put_contents($file, $Text, FILE_APPEND | LOCK_EX);
			$ret = $Phone;
		}
	} else {
		$ret = $Phone;
	}
	return $ret; 
}

function SplitPhoneNr($Phone) {
	global $NumberType;

	$ret = array();

	if(strncmp($Phone,"+", 1) == 0) {
	    $tmpPhone = substr($Phone, 1);
	    $Phone = $tmpPhone;
	}
		
	if(ctype_digit($Phone)) {
		if(strncmp($Phone,"00", 2) == 0) {
			$tmpPhone = substr($Phone, 2);
			$Phone = $tmpPhone;
		}
		
		$phoneNumberUtil = \libphonenumber\PhoneNumberUtil::getInstance();
		$geoCoder = \libphonenumber\geocoding\PhoneNumberOfflineGeocoder::getInstance();
		$ParseNr = "+".$Phone;
		$phoneNumberObject = $phoneNumberUtil->parse($ParseNr, "");
		$ret[0] = $phoneNumberObject->getCountryCode();
		$ret[1] = $phoneNumberObject->getNationalNumber();
		$tmpTyp = $phoneNumberUtil->getNumberType($phoneNumberObject);
		$ret[2] = $NumberType[$tmpTyp]["Short"];
		$ret[3] = $geoCoder->getDescriptionForNumber($phoneNumberObject, 'de');
	}
	return $ret;
}

?>