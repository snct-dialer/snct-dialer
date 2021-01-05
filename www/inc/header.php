<?php 

#
# header.php
#
# License AGPLv3
#
# Copyright 2020      Jörg Frings-Fürst <open_source@jff.email>
#           2020      SNCT GmbH <info@snct-gmbh.de>
#
# Version 0.0.1
#
# changelog
#
# 2020-06-11	0.0.1	jff	first work
#
#


$version="0.0.1";

#
# $DB
# set to 1 to enable debug messages
#
#$DB=0;
#$Debug=0;
#$mel=0;
#$LOG=1;
#

function PrintHeader($Titel) {
	
	echo '<!DOCTYPE html>' . PHP_EOL;
	echo '<html lang="de">' . PHP_EOL;
	echo '<head>' . PHP_EOL;
	echo '  <meta charset="utf-8"/>' . PHP_EOL;
	echo '  <title>'.$Titel .'</title>' . PHP_EOL;
	echo '  <link href="css/standart.css" rel="stylesheet" type="text/css" />' . PHP_EOL;
	echo '  <link rel="stylesheet" type="text/css" href="../inc/js/easyui/themes/default/easyui.css">' . PHP_EOL;
	echo '  <link rel="stylesheet" type="text/css" href="../inc/js/easyui/themes/icon.css">' . PHP_EOL;
	echo '  <link rel="stylesheet" type="text/css" href="../inc/js/easyui/demo/demo.css">' . PHP_EOL;
	echo '  <script type="text/javascript" src="../inc/js/jquery/jquery-3.5.1.min.js"></script>' . PHP_EOL;
	echo '  <script type="text/javascript" src="../inc/js/easyui/jquery.easyui.min.js"></script>' . PHP_EOL;
	echo '</head>' . PHP_EOL;
	echo '<body>' . PHP_EOL;
}

?>