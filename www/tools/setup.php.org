<?php

# setup.php - VICIDIAL handle setup interface
#
# LICENSE: AGPLv3
#
# Copyright (©) 2018 flyingpenguin.de UG <info@flyingpenguin.de>
#               2018 Jörg Frings-Fürst <j.fringsfuerst@flyingpenguin.de>

#
# FP - Changelog
#
# 2018-06-07 09:53 jff First Release.
#                      getData return false if key not exists.
#
$module="tools/setup.php";
$Version="0.0.2";


class fp_setup {

	private $ConfFile = '/etc/flyingpenguin/vicidial.conf';
	private $ArrIni = [];
	private $DB = 0;

	function __construct($Debug = false) {

		if ($Debug == true) {
			$this->DB = 1;
		}
		if (!file_exists($this->ConfFile)) {
			throw new Exception($this->ConfFile . ' not Found');
		}
		$this->ArrIni = parse_ini_file($this->ConfFile, true);
		if($this->DB) {
			print_r($this->ArrIni);
		}
	}


	function getData($Group, $Item) {
		if (isset($this->ArrIni[$Group][$Item])) {
			return $this->ArrIni[$Group][$Item];
		} else {
			if($this->DB) {
				throw new Exception($Group . "/" . $Item . ' not Found');
			}
			return false;
		}
	}
}


//$fdSet = new fp_setup();
//print ($fdSet->getData("Setup", "ExpectedDBSchema") . PHP_EOL);

?>