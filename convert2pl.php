#!/usr/bin/php
<?php

require "FlyInclude.php";

$fh = fopen("./FlyInclude.pl", "w");
fwrite ($fh, "\n");
fwrite ($fh, "\$FLY_patch_level = '$FLY_patch_level';\n");
fclose($fh);


?>

