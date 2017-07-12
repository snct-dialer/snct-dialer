#!/usr/bin/php
<?php

require "FlyInclude.php";

$fh = fopen("./FlyInclude.pl", "w");
fwrite ($fh, "\n");
fwrite ($fh, "\$FLY_patch_level = '$FLY_patch_level';\n");
fwrite ($fh, "\$Fly_old_svn = '$FLY_SVN_base';\n");
fwrite ($fh, "\$Fly_version = '$FLY_version';\n");
fclose($fh);


?>

