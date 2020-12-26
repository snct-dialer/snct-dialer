<?php 
###############################################################################
#
# Modul admin_function.php
#
# SNCT-Dialer™ new functions for the admin interface
#
# Copyright (©) 2020      SNCT GmbH <info@snct-gmbh.de>
#               2020      Jörg Frings-Fürst <open_source@jff.email>
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
$admin_function_version = '3.0.1-1';
$admin_function_build = '20201226-1';
#
###############################################################################
#
# Changelog
#
# 2020-12-26 jff	First build
#
#
#


###############################################################################
#
# GetViewUsr
#
# Returns valid users for given User Group with name contains ADMIN
#
###############################################################################
#
# Parameter:
# 
# $UsrGrp
#
###############################################################################
#
# Return
#
# sql statement with all valid users for User Group
#
###############################################################################
function GetViewUsr($UsrGrp) {
	global $DB, $link;
	
	$ret = "";
	$TestAdm = strncasecmp ($UsrGrp , "ADMIN" , 5);
	if($TestAdm === 0) {
		$sql = "SELECT allowed_campaigns,admin_viewable_groups from vicidial_user_groups where user_group='$UsrGrp';";
		if($DB) {
			print $sql . "<br>" . PHP_EOL;
		}
		if($res = mysqli_query($link, $sql)) {
			$rights_row=mysqli_fetch_row($res);
			$LOGallowed_campaigns =			$rights_row[0];
			$LOGadmin_viewable_groups =		$rights_row[1];
		}
		
		
		$adm_viewable_groupsSQL='';
		if  (!preg_match('/\-\-ALL\-\-/i',$LOGadmin_viewable_groups))
		{
			$rawLOGadmin_viewable_groupsSQL = preg_replace("/ -/",'',$LOGadmin_viewable_groups);
			$rawLOGadmin_viewable_groupsSQL = preg_replace("/ /","','",$rawLOGadmin_viewable_groupsSQL);
			$adm_viewable_groupsSQL = "user_group IN('$rawLOGadmin_viewable_groupsSQL')";
		} else {
			$adm_viewable_groupsSQL= $admin_viewable_groupsSQL;
		}
		$sql1 = "SELECT user FROM `vicidial_users` WHERE $adm_viewable_groupsSQL;";
		if($DB) {
			print $sql1 . "<br>" . PHP_EOL;
		}
		$ret = "user IN (";
		if($res1 = mysqli_query($link, $sql1)) {
			$first = 1;
			while ($row1=mysqli_fetch_assoc($res1)) {
				if ($first == 1) {
					$ret .= $row1["user"];
					$first = 0;
				} else {
					$ret .= ", " . $row1["user"];
				}
			}
			$ret .= ")";
		}
		
		
	} else {
		$ret = " 1 ";
	}
	return $ret;
}

?>

