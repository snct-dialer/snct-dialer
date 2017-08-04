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
	echo $line . "<br>" . PHP_EOL; 
    }

    fclose($handle);
} else {
    echo "changelog not found!";
}

?>
</font>

</body>
</html>