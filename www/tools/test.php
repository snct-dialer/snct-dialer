<?php


require_once ("format_phone.php");

$tmp=(SplitPhoneNr("004917167409000"));

if(isset($tmp[0])) { echo "$tmp[0]" . PHP_EOL;}

if(!isset($tmp[5])) { echo "tmp[5] not set" . PHP_EOL;}

?>