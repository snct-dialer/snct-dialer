<?php
#
# Copyright (c) 2017 Jörg Frings-Fürst <jff@flyingpenguin.de>   LICENSE: AGPLv3
#               2017 flyingpenguin UG <info@flyingpenguin.de>
#
# Generation of Statistics Mail
#
# 20171128-0000 - first release
# 20171130-1235 - Use CompanyName from System_settings
#               - Use WallBoard3_mail_conf.php to setup $mail_to.

$version="1.0.1";
$build = "20171130-1235";


####  collect wallboard data should only be active on a single server
#*/1 * * * * php /usr/share/astguiclient/WallBoard3_mail.php


$DB=0;


$file= "Auswertung.ods";
$Comp_Name = "ViciDial";

$mail_to = "jff@flyingpenguin.de";

if(file_exists('WallBoard3_mail_conf.php')) {
    require_once('WallBoard3_mail_conf.php');
}

require("/srv/www/htdocs/vicidial/dbconnect_mysqli.php");
require("/srv/www/htdocs/vicidial/functions.php");

require_once 'odsPhpGen/ods_load.php';

use odsPhpGenerator\ods;
use odsPhpGenerator\odsTableRow;
use odsPhpGenerator\odsTable;
use odsPhpGenerator\odsTableCellString;
use odsPhpGenerator\odsTableCellEmpty;
use odsPhpGenerator\odsTableCellStringEmail;
use odsPhpGenerator\odsTableCellStringUrl;
use odsPhpGenerator\odsTableCellFloat;
use odsPhpGenerator\odsTableCellDate;
use odsPhpGenerator\odsTableCellTime;
use odsPhpGenerator\odsTableCellDateTime;
use odsPhpGenerator\odsTableCellCurrency;
use odsPhpGenerator\odsTableCellImage;
use odsPhpGenerator\odsStyleTableCell;
use odsPhpGenerator\odsStyleTableColumn;
use odsPhpGenerator\odsTableColumn;


$style_end = new odsStyleTableCell();
$style_end -> setTextAlign('end');

$IBGroupsArray = array ();


function GenIBGroups() {
	global $DB, $link, $IBGroupsArray;

	$time_start = microtime(true);
#	LogWB("--Start GetIBGroups--");

	$statement="SELECT Datum, Gruppe FROM WallBoardStat GROUP BY Gruppe;";
//	$statement="SELECT * FROM vicidial_inbound_groups GROUP BY group_id;";
	if ($DB)
		print "$statement\n";
	$result=mysql_to_mysqli($statement, $link);
	$Anz=mysqli_num_rows($result);
	$i=0;
	while($i < $Anz) {
		$row = mysqli_fetch_array($result, MYSQLI_BOTH);
		$Grp = $row["Gruppe"];
		if($Grp == "") {
			$Grp = "Rest";
		}
		#		$Grp = str_replace(' ', '_', $Grp);
		$IBGroupsArray[] = $Grp;
		$i++;
	}
	if ($DB)
		var_dump($IBGroupsArray);

	$time_end = microtime(true);
	$time = $time_end - $time_start;

#	LogWB("--Ende GenIBGroups-- nach " . $time . " Sek.");
}

function GenTable($Gruppe, $ods, $Date) {
	global $DB, $link, $IBGroupsArray;

	$statement="SELECT `Datum`, `Calls`, `Agent`, `waittime`, `ebk`, `SL1`, `SL2`, `maxwaittime`, `TCalls` FROM `WallBoardStat` WHERE `Gruppe` = '$Gruppe' AND `Calls` > 0 AND `Datum` >= '$Date' ORDER BY `Datum`;";
	if ($DB)
	    print "$statement\n";
	$result = mysql_to_mysqli($statement, $link);

	$Anz=mysqli_num_rows($result);
	if($Anz == 0) {
	    return;
	}
	// Create table named 'Cells'
	$table = new odsTable($Gruppe);

	$styleColumn = new odsStyleTableColumn();
	$styleColumn->setColumnWidth("3cm");
	$column1 = new odsTableColumn($styleColumn);

	$table->addTableColumn($column1);
	$table->addTableColumn($column1);
	$table->addTableColumn($column1);
	$table->addTableColumn($column1);
	$table->addTableColumn($column1);
	$table->addTableColumn($column1);
	$table->addTableColumn($column1);
	$table->addTableColumn($column1);
	$table->addTableColumn($column1);
	$table->addTableColumn($column1);

	$row   = new odsTableRow();
	$row->addCell( new odsTableCellString("Datum") );
	$row->addCell( new odsTableCellString("Anrufe"), $style_end );
	$row->addCell( new odsTableCellString("Gespräche"), $style_end  );
	$row->addCell( new odsTableCellString("Wartezeit"), $style_end  );
	$row->addCell( new odsTableCellString("Erreichbarkeit"), $style_end  );
	$row->addCell( new odsTableCellString("Servicelevel 1"), $style_end  );
	$row->addCell( new odsTableCellString("Servicelevel 2"), $style_end  );
	$row->addCell( new odsTableCellString("Verlorene Anrufe"), $style_end  );
	$row->addCell( new odsTableCellString("längste WarteZeit"), $style_end  );
	$row->addCell( new odsTableCellString("ausserhalb GZ"), $style_end  );
	$table->addRow($row);

	$rows = 1;

	while($erg = mysqli_fetch_assoc($result)) {
	    $row   = new odsTableRow();

	    $datum = $erg['Datum'];
	    $phpdate = strtotime( $datum );
	    $mysqldate = date( 'd.m.Y', $phpdate );
	    $row->addCell( new odsTableCellString($mysqldate));

	    $calls = $erg['Calls'];
	    $row->addCell( new odsTableCellFloat($calls, $style_end ) );

	    $agent = $erg['Agent'];
	    $row->addCell( new odsTableCellFloat($agent, $style_end ) );

	    $waitt = $erg['waittime'];
	    $sec = $waitt % 60;
	    $min = ((($waitt - $sec) / 60) % 60);
	    $Strwait= sprintf("%02d:%02d", $min, $sec);
	    $row->addCell( new odsTableCellString($Strwait, $style_end ) );

	    $ebk = $erg['ebk'];
	    $Erbk= sprintf("%.1f%%", $ebk);
	    $row->addCell( new odsTableCellString($Erbk, $style_end ) );

	    $sl1 = $erg['SL1'];
	    $SL1 = sprintf("%.1f%%", ($sl1 * 100.0 / $calls));
	    $row->addCell( new odsTableCellString($SL1, $style_end ) );

	    $sl2 = $erg['SL2'];
	    $SL2 = sprintf("%.1f%%", ($sl2 * 100.0 / $calls));
	    $row->addCell( new odsTableCellString($SL2, $style_end ) );

	    $verl = $calls - $agent;
	    $row->addCell( new odsTableCellFloat($verl, $style_end ) );

	    $mwaitt = $erg['maxwaittime'];
	    $sec = $mwaitt % 60;
	    $min = ((($mwaitt - $sec) / 60) % 60);
	    $Strmwait= sprintf("%02d:%02d", $min, $sec);
	    $row->addCell( new odsTableCellString($Strmwait, $style_end ) );

	    $Tcalls = $calls - $erg['TCalls'];
	    if (($Tcalls > 0) && ($erg['TCalls'] > 0)) {
	        $row->addCell( new odsTableCellFloat($Tcalls, $style_end ) );
	    } else {
		$row->addCell( new odsTableCellEmpty());
	    }


	    $table->addRow($row);
	    $rows += 1;
	}


	$row   = new odsTableRow();
	$table->addRow($row);


	$row   = new odsTableRow();
	$row->addCell( new odsTableCellString('Gesamt') );

	$cell = new odsTableCellFloat(0);
	$cell->setFormula("SUM([.B2:.B$rows])");
	$row->addCell( $cell, $style_end  );

	$cell = new odsTableCellFloat(0);
	$cell->setFormula("SUM([.C2:.C$rows])");
	$row->addCell( $cell, $style_end  );

	$row->addCell( new odsTableCellEmpty());
	$row->addCell( new odsTableCellEmpty());
	$row->addCell( new odsTableCellEmpty());
	$row->addCell( new odsTableCellEmpty());

	$cell = new odsTableCellFloat(0);
	$cell->setFormula("SUM([.H2:.H$rows])");
	$row->addCell( $cell, $style_end  );


	$table->addRow($row);

	$row   = new odsTableRow();

	$Days = $rows - 1;

	$row->addCell( new odsTableCellString('Im Schnitt') );

	$cell = new odsTableCellFloat(0);
	$cell->setFormula("SUM([.B2:.B$rows])/$Days");
	$row->addCell( $cell, $style_end  );

	$cell = new odsTableCellFloat(0);
	$cell->setFormula("SUM([.C2:.C$rows])/$Days");
	$row->addCell( $cell, $style_end  );

	$row->addCell( new odsTableCellEmpty());
	$row->addCell( new odsTableCellEmpty());
	$row->addCell( new odsTableCellEmpty());
	$row->addCell( new odsTableCellEmpty());

	$cell = new odsTableCellFloat(0);
	$cell->setFormula("SUM([.H2:.H$rows])/$Days");
	$row->addCell( $cell );


	$table->addRow($row);



	$ods->addTable($table);

}



###
### main
###

date_default_timezone_set("Europe/Berlin");
$Date=date("Y-m-01");


$Comp_Name = "ViciDial";

$stmt="SELECT company_name from system_settings;";
$rslt=mysql_to_mysqli($stmt, $link);
$sl_ct = mysqli_num_rows($rslt);
if ($sl_ct > 0)
{
    $row=mysqli_fetch_row($rslt);
    $Comp_Name =		$row[0];
}

$file="Auswertung " . $Comp_Name ."ods";

GenIBGroups();


// Create Ods object
$ods  = new ods();


$count = count($IBGroupsArray);
for ($i = 0; $i < $count; $i++) {
#	print "$IBGroupsArray[$i]\n";
	GenTable($IBGroupsArray[$i], $ods, $Date);
}




// Download the file
$ods->genOdsFile($file);


print "$file\n";

/* Email Detials */
#$mail_to = "jff@flyingpenguin.de";

$from_mail = "support@flyingpenguin.de";
$from_name = $Comp_Name . " Server";
$reply_to = "support@flyingpenguin.de";
$subject = "Wallboard3 Auswertung";
$message = "siehe Anlage";

/* Attachment File */
// Attachment location
//$file_name = "<attachment file name>";
//$path = "<relative path/absolute path which contains the attachment>";

// Read the file content
//$file = $path.$file_name;
$file_size = filesize($file);
$handle = fopen($file, "r");
$content = fread($handle, $file_size);
fclose($handle);
$content = chunk_split(base64_encode($content));

/* Set the email header */
// Generate a boundary
$boundary = md5(uniqid(time()));

// Email header
$header = "From: ".$from_name." <".$from_mail.">".PHP_EOL;
$header .= "Reply-To: ".$reply_to.PHP_EOL;
$header .= "Bcc: support@flyingpenguin.de".PHP_EOL;
$header .= "MIME-Version: 1.0".PHP_EOL;
$header .= "X-Mailer: script WallBoard3_mail.php ".$version .PHP_EOL;

// Multipart wraps the Email Content and Attachment
$header .= "Content-Type: multipart/mixed; boundary=\"".$boundary."\"".PHP_EOL;
$header .= "This is a multi-part message in MIME format.".PHP_EOL;
$header .= "--".$boundary.PHP_EOL;

// Email content
// Content-type can be text/plain or text/html
$header .= "Content-type:text/plain; charset=iso-8859-1".PHP_EOL;
$header .= "Content-Transfer-Encoding: 7bit".PHP_EOL.PHP_EOL;
$header .= "$message".PHP_EOL;
$header .= "--".$boundary.PHP_EOL;

// Attachment
// Edit content type for different file extensions
$header .= "Content-Type: application/vnd.oasis.opendocument.spreadsheet; name=\"".$file."\"".PHP_EOL;
$header .= "Content-Transfer-Encoding: base64".PHP_EOL;
$header .= "Content-Disposition: attachment; filename=\"".$file."\"".PHP_EOL.PHP_EOL;
$header .= $content.PHP_EOL;
$header .= "--".$boundary."--";

// Send email
if (mail($mail_to, $subject, "", $header)) {
	echo "Sent";
} else {
	echo "Error";
}


?>