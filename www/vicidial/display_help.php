<?php
# display_help.php
#
# Copyright (C) 2018  Matt Florell <vicidial@gmail.com>, Joe Johnson <freewermadmin@gmail.com>    LICENSE: AGPLv2
#
# pulls help text to display on the screen when the appropriate help link is clicked
#
# CHANGELOG:
# 180501-0045 - First build
#

$startMS = microtime();

require("dbconnect_mysqli.php");
require("functions.php");

if (isset($_GET["help_id"]))			{$help_id=$_GET["help_id"];}
	elseif (isset($_POST["help_id"]))	{$help_id=$_POST["help_id"];}

$help_id = preg_replace('/[^-\_0-9a-zA-Z]/', '',$help_id);

$help_stmt="select help_title, help_text from help_documentation where help_id='$help_id'";
$help_rslt=mysql_to_mysqli($help_stmt, $link);
while ($help_row=mysqli_fetch_row($help_rslt)) {
	preg_match_all("/<QXZ>(.*?)<\/QXZ>/", $help_row[1], $QXZ_matches);

	$qxz_match=$QXZ_matches[0];
	$qxz_replace=$QXZ_matches[1];
	for ($q=0; $q<count($qxz_replace); $q++) {
		# $qxz_match[$q]=preg_replace("/\//", '\\\/', $qxz_match[$q]);
		$qxz_match[$q]=preg_quote($qxz_match[$q], '/');
		$qxz_match[$q]="/".$qxz_match[$q]."/";
		$qxz_replace[$q]=_QXZ($qxz_replace[$q]);
	}
	$help_row[1]=preg_replace($qxz_match, $qxz_replace, $help_row[1]);

	# preg_replace('/"/', '\\"', $help_row[1]);
	echo "<TABLE CELLPADDING=2 CELLSPACING=0 border='0' class='help_td' width='300'>";
	echo "<TR><TD VALIGN='TOP' width='280'><FONT class='help_bold'>"._QXZ("$help_row[0]")."</font></td><TD VALIGN='TOP' align='right' width='20' onClick='ClearAndHideHelpDiv()'><B>[X]</B></tr>";
	echo "<TR><TD VALIGN='TOP' colspan='2'>$help_row[1]</td></tr>";
	echo "</TABLE>";
}
?>
