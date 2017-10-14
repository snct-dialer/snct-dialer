<?php 
#
# Modul Check Character Set
#
# Copyright (C) 2017 Jörg Frings-Fürst (j.fringsfuerst@flyingpenguin.de)
#               2017 flyingpenguin.de UG (info@flyingpenguin.de)
#
#  LICENSE: AGPLv3
#
# Changelog:
# 20171012 First release
#
#
#

$mod_check_character_set_version = '0.1.0';
$build = '171012-1157';


# function VDTrimStrings 
# Input: $Input string to Trim
#        $Type integer Standart 0. function list see below    
# Output: Trimed string.
#
# Type functions:
#   0 No changes
# 999 Remove semi-colons
#
function VDTrimStrings($Input, $Type = 0) : string {
	$Return = "";

	if($Type == 0) {
		return $Input;
	}

	if($Type == 2) {
		$Return = preg_replace('/[^[:print:]]/u','',$Input);
	}
	if($Type == 3) {
		$Return = preg_replace('/[^[:alpha:]]/u','',$Input);
	}
	if($Type == 4) {
		$Return = preg_replace('/[^[:digit:]]/u','',$Input);
	}
	if($Type == 999) {
		$Return = preg_replace('/;/','',$Input);
	}
	if($Return == "") {
		$Return = $Input;
	}
	return $Return;
}

$test = "Ĉ1 2 3 45667890AbDcFrE;:_ÄÖÜ!Âàáسجلو رواحكم للإنتخابات ß";
echo "0 : >" . VDTrimStrings($test) . PHP_EOL;
echo "1 : >" . VDTrimStrings($test, 1) . PHP_EOL;
echo "2 : >" . VDTrimStrings($test, 2) . PHP_EOL;
echo "3 : >" . VDTrimStrings($test, 3) . PHP_EOL;
echo "4 : >" . VDTrimStrings($test, 4) . PHP_EOL;
echo "999 : >" . VDTrimStrings($test, 999) . PHP_EOL;


?>