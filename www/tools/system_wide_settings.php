<?php


# Copyright (©) 2018-2019 Jörg Frings-Fürst <open_source@jff.email>   LICENSE: AGPLv3
#               2018-2019 SNCT GmbH <info@snct.de>
#
# global code snipplets.
#
# 20181204-0000 - first work
# 20190429-2253 - first release
#

$version="1.0.1";
$build = "20190429-2253";

#
# set error reporting level E_NOTICE only if $DB is set
#
if(!isset($DB)) {
    $DB=0;
}
if($DB) {
    error_reporting(E_ERROR | E_WARNING | E_PARSE | E_NOTICE);
} else {
    error_reporting(E_ERROR | E_WARNING | E_PARSE);
}



?>