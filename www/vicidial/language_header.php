<?php

# language_header.php   version 1.0.1
#
# LICENSE: AGPLv3
#
# Copyright (©) 2019-2020 SNCT GmbH <info@snct-dialer.de>
#               2019-2020 Jörg Frings-Fürst <open_source@jff.email>
#
#
# SNCT - Changelog
#
# 2020-03-18 13:30 jff	Add Global Search
#						Add new Field address1_no
#
#
# Global Settings for translate into other languages
#
#
#

$localePreferences = explode(",",$_SERVER['HTTP_ACCEPT_LANGUAGE']);
if(is_array($localePreferences) && count($localePreferences) > 0) {
    $browserLocale = $localePreferences[0];
    if(($browserLocale ==  "de") || ($browserLocale ==  "de-DE") || ($browserLocale ==  "de-de")) {
        $browserLocale = "de_DE.UTF-8";
    }
}
 

if (!function_exists("gettext")){ echo "gettext is not installed\n"; }


#echo $browserLocale ."<br>";

putenv("LANG=$browserLocale");
setlocale(LC_ALL, $browserLocale);
bindtextdomain('snctdialer', './locale');
bind_textdomain_codeset('snctdialer', 'UTF-8');
textdomain('snctdialer');

?>