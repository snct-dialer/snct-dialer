<?php

require_once 'functions.php';

function makeDownload($file, $dir, $type) {

	header("Content-Type: $type");

	header("Content-Disposition: attachment; filename=\"$file\"");

	readfile($dir.$file);

}

$dir = GetGetTmpDownLoadDir() . "/";


$type = 'text/csv';

if(!empty($_GET['file'])) {
	$file = basename($_GET['file']);

	if(file_exists ($dir.$file))     {
		makeDownload($file, $dir, $type);
	}
}

?>
