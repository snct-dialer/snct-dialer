<!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8" />
<title>Changelog from flyingpenguin.de UG</title>
</head>
<body>

<font face="Courier New"> 
<?php


$handle = fopen("changelog", "r");
if ($handle) {
    while (($line = fgets($handle)) !== false) {
	$line1 = str_replace( " ", "&nbsp;", $line );
	echo $line1 . "<br>" . PHP_EOL; 
    }

    fclose($handle);
} else {
    echo "changelog not found!";
}

?>
</font>

</body>
</html>