<?php
###############################################################################
#
# Modul language_header.php
#
# SNCT-Dialer™ Global Settings for translate into other languages
#
# Copyright (©) 2019-2020 SNCT GmbH <info@snct-gmbh.de>
#               2019-2020 Jörg Frings-Fürst <open_source@jff.email>
#
# LICENSE: AGPLv3
#
###############################################################################

#
# requested Module:
#
#
#
###############################################################################
#
# Version / Build
#
$lang_header_version = '3.0.1-1';
$lang_header_build = '20201021-1';
#
###############################################################################
#
# Changelog
#
# 2019-12-15 jff	First build
# 2020-10-21 jff	Change header
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