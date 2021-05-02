<?php 

###############################################################################
#
# Modul get_system_settings.php
#
# SNCT-Dialer™ global functions
#
# Copyright (©) 2021      SNCT GmbH <info@snct-gmbh.de>
#               2021      Jörg Frings-Fürst <open_source@jff.email>
#
# LICENSE: AGPLv3
#
###############################################################################
#
# requested Module:
#
# ./.
#
###############################################################################
#
# Version  / Build
#
$get_system_setting_version = '3.1.1-1';
$get_system_setting_build = '20210430-1';
#
###############################################################################
#
# Changelog#
#
# 2021-04-30 jff    First work
#
#
#


$non_latin =				1;
$custom_fields_enabled =	"";
$webroot_writable =			"";
$allow_emails =				"";
$SSenable_languages =		"";
$SSlanguage_method =		"";
$active_modules =			"";
$log_recording_access =		"";
$SSadmin_screen_colors =	"";
$enable_gdpr_download_deletion = "";
$SSsource_id_display =		"";
$SSmute_recordings =		"";
$SSsip_event_logging =		"";
$ShowArchive = 				"";


$stmt = "SELECT * FROM system_settings;";
if($rslt=mysqli_query($link, $stmt)) {
    if ($DB) {
        sd_debug_log($stmt);
    }
    $qm_conf_ct = mysqli_num_rows($rslt);
    if ($qm_conf_ct > 0) {
        $row=mysqli_fetch_array($rslt);
        
        $custom_fields_enabled =	$row["custom_fields_enabled"];
        $webroot_writable =			$row["webroot_writable"];
        $allow_emails =				$row["allow_emails"];
        $SSenable_languages =		$row["enable_languages"];
        $SSlanguage_method =		$row["language_method"];
        $active_modules =			$row["active_modules"];
        $log_recording_access =		$row["log_recording_access"];
        $SSadmin_screen_colors =	$row["admin_screen_colors"];
        $enable_gdpr_download_deletion = $row["enable_gdpr_download_deletion"];
        $SSsource_id_display =		$row["source_id_display"];
        $SSmute_recordings =		$row["mute_recordings"];
        $SSsip_event_logging =		$row["sip_event_logging"];
        $ShowArchive = 				$row["show_archive"];
    }
    mysqli_free_result($rslt);
} else {
    sd_error_log($stmt. "|" . mysqli_error($link));
}

?>