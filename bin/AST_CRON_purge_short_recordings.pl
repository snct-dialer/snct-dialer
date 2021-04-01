#!/usr/bin/perl
#
# AST_CRON_purge_recordings.pl   version 2.0.5
#
# IMPORTANT!!! used to delete recordings!!!
#
# runs every day, goes through recordings older than a certain number of days
# and deletes those recordings that are not of a certain status
# default is 30 days old to remove non-sales
#
# put an entry into the cron of of your asterisk machine to run this script
# every day or however often you desire
#
# This program assumes that recordings are saved as .wav
# should be easy to change this code if you use .gsm instead
#
# LICENSE: AGPLv3
# 
# Copyright (©) 2021-2018 SNCT GmbH <info@snct-gmbh.de>
#               2021      Jörg Frings-Fürst <open_source@jff.email>

#
# 2021-03-22 jff	first build
#


###### Test that the script is running only once a time
use Fcntl qw(:flock);
# print "start of program $0\n";
unless (flock(DATA, LOCK_EX|LOCK_NB)) {
    open my $fh, ">>", '/var/log/astguiclient/vicidial_lock.log'
    or print "Can't open the fscking file: $!";
    $datestring = localtime();
    print $fh "[$datestring] $0 is already running. Exiting.\n";
    exit(1);
}

$save_statuses = '|SALE|UPSALE|UPSELL|XFER|DNC|DROP|A1|A2|A3|A4|A5|A6|A7|A8|A9|';
$suffix = '-all.mp3';
$local_DIR = '/var/spool/asterisk/monitorDONE/MP3';
$use_date_DIRs = 1;
$min_duration = 10;
$older_days = 365;

# Customize variables for FTP
$FTP_host = '10.0.0.4';
$FTP_user = 'cron';
$FTP_pass = 'test';
$FTP_dir  = 'RECORDINGS';
$HTTP_path = 'http://10.0.0.4';


$secX = time();

$OldTarget = ($secX - ($older_days * 24 * 60 * 60));
($Tsec,$Tmin,$Thour,$Tmday,$Tmon,$Tyear,$Twday,$Tyday,$Tisdst) = localtime($OldTarget);
$Tyear = ($Tyear + 1900);
$Tmon++;
if ($Tmon < 10) {$Tmon = "0$Tmon";}
if ($Tmday < 10) {$Tmday = "0$Tmday";}
if ($Thour < 10) {$Thour = "0$Thour";}
if ($Tmin < 10) {$Tmin = "0$Tmin";}
if ($Tsec < 10) {$Tsec = "0$Tsec";}
$OldSQLDate = "$Tyear-$Tmon-$Tmday $Thour:$Tmin:$Tsec";

$TDtarget = ($secX - 2592000); # thirty days
($Tsec,$Tmin,$Thour,$Tmday,$Tmon,$Tyear,$Twday,$Tyday,$Tisdst) = localtime($TDtarget);
$Tyear = ($Tyear + 1900);
$Tmon++;
if ($Tmon < 10) {$Tmon = "0$Tmon";}
if ($Tmday < 10) {$Tmday = "0$Tmday";}
if ($Thour < 10) {$Thour = "0$Thour";}
if ($Tmin < 10) {$Tmin = "0$Tmin";}
if ($Tsec < 10) {$Tsec = "0$Tsec";}
	$TDSQLdate = "$Tyear-$Tmon-$Tmday $Thour:$Tmin:$Tsec";

$FDtarget = ($secX - 3456000); # forty-five days
($Fsec,$Fmin,$Fhour,$Fmday,$Fmon,$Fyear,$Fwday,$Fyday,$Fisdst) = localtime($FDtarget);
$Fyear = ($Fyear + 1900);
$Fmon++;
if ($Fmon < 10) {$Fmon = "0$Fmon";}
if ($Fmday < 10) {$Fmday = "0$Fmday";}
if ($Fhour < 10) {$Fhour = "0$Fhour";}
if ($Fmin < 10) {$Fmin = "0$Fmin";}
if ($Fsec < 10) {$Fsec = "0$Fsec";}
	$FDSQLdate = "$Fyear-$Fmon-$Fmday $Fhour:$Fmin:$Fsec";


# default path to astguiclient configuration file:
$PATHconf =		'/etc/astguiclient.conf';

open(conf, "$PATHconf") || die "can't open $PATHconf: $!\n";
@conf = <conf>;
close(conf);
$i=0;
foreach(@conf)
	{
	$line = $conf[$i];
	$line =~ s/ |>|\n|\r|\t|\#.*|;.*//gi;
	if ( ($line =~ /^PATHhome/) && ($CLIhome < 1) )
		{$PATHhome = $line;   $PATHhome =~ s/.*=//gi;}
	if ( ($line =~ /^PATHlogs/) && ($CLIlogs < 1) )
		{$PATHlogs = $line;   $PATHlogs =~ s/.*=//gi;}
	if ( ($line =~ /^PATHagi/) && ($CLIagi < 1) )
		{$PATHagi = $line;   $PATHagi =~ s/.*=//gi;}
	if ( ($line =~ /^PATHweb/) && ($CLIweb < 1) )
		{$PATHweb = $line;   $PATHweb =~ s/.*=//gi;}
	if ( ($line =~ /^PATHsounds/) && ($CLIsounds < 1) )
		{$PATHsounds = $line;   $PATHsounds =~ s/.*=//gi;}
	if ( ($line =~ /^PATHmonitor/) && ($CLImonitor < 1) )
		{$PATHmonitor = $line;   $PATHmonitor =~ s/.*=//gi;}
	if ( ($line =~ /^VARserver_ip/) && ($CLIserver_ip < 1) )
		{$VARserver_ip = $line;   $VARserver_ip =~ s/.*=//gi;}
	if ( ($line =~ /^VARDB_server/) && ($CLIDB_server < 1) )
		{$VARDB_server = $line;   $VARDB_server =~ s/.*=//gi;}
	if ( ($line =~ /^VARDB_database/) && ($CLIDB_database < 1) )
		{$VARDB_database = $line;   $VARDB_database =~ s/.*=//gi;}
	if ( ($line =~ /^VARDB_user/) && ($CLIDB_user < 1) )
		{$VARDB_user = $line;   $VARDB_user =~ s/.*=//gi;}
	if ( ($line =~ /^VARDB_pass/) && ($CLIDB_pass < 1) )
		{$VARDB_pass = $line;   $VARDB_pass =~ s/.*=//gi;}
	if ( ($line =~ /^VARDB_port/) && ($CLIDB_port < 1) )
		{$VARDB_port = $line;   $VARDB_port =~ s/.*=//gi;}
	$i++;
	}

# Customized Variables
$server_ip = $VARserver_ip;		# Asterisk server IP
if (!$VARDB_port) {$VARDB_port='3306';}

use DBI;

$dbhA = DBI->connect("DBI:mysql:$VARDB_database:$VARDB_server:$VARDB_port", "$VARDB_user", "$VARDB_pass", { mysql_enable_utf8 => 1 })
 or die "Couldn't connect to database: " . DBI->errstr;

### directory where in/out recordings are saved to by Asterisk
$dir1 = "$PATHmonitor";

#
# Find all not existing recording files 
#
$stmtA = "SELECT lead_id,recording_id,start_time,filename,location FROM recording_log_archive where start_time < '$OldSQLDate' and location IS NOT NULL and location NOT IN('','NOT_FOUND','NOT_FOUND_2','DELETED') LIMIT 5000;";
	print "$stmtA\n";
$sthA = $dbhA->prepare($stmtA) or die "preparing: ",$dbhA->errstr;
$sthA->execute or die "executing: $stmtA ", $dbhA->errstr;
$sthArows=$sthA->rows;
$i=0;
while ($sthArows > $i) {  
	@aryA = $sthA->fetchrow_array;
	$lead_ids[$i]	=			"$aryA[0]";
	$recording_ids[$i]	=		"$aryA[1]";
	$start_times[$i]	=		"$aryA[2]";
	$filenames[$i] =			"$aryA[3]";
	$locations[$i]	=			"$aryA[4]";
	$i++;
}
$sthA->finish();


##### Go through list of recordings and test if recording file exist  #####
$i=0;
$FOUND=0;
$NOTFOUND=0;
foreach(@recording_ids) { 
	if ($use_date_DIRs)	{
		$date_DIR = $start_times[$i];
		$date_DIR =~ s/ .*//gi;
		$date_DIR .= "/";
	} else {
		$date_DIR=''
	}
	$foundName = "$local_DIR/$date_DIR$filenames[$i]$suffix";
    print " Name: $foundName\n";
	if (-f $foundName) {

		print "Found- $filenames[$i]$suffix     |$statuses[$i]|$lead_ids[$i]|\n";
		$FOUND++;
	} else {
		print "Notfound- $filenames[$i]$suffix     |$statuses[$i]|$lead_ids[$i]|\n";
		$stmtA = "UPDATE recording_log_archive set location='NOT_FOUND' where recording_id='$recording_ids[$i]';";
		$affected_rows = $dbhA->do($stmtA); #  or die  "Couldn't execute query:|$stmtA|\n";
		$NOTFOUND++;
	} 
	$i++;
}
$ii = $i;

print "NotFound:  $NOTFOUND\n";
print "Found:     $FOUND\n";
print "--------------------\n";
print "TOTAL:     $i\n";




##### Get the lead_ids of all recordings that are not DELETED or NULL #####
$stmtA = "SELECT lead_id,recording_id,start_time,filename,location FROM recording_log_archive where start_time < '$OldSQLDate' AND length_in_sec <= '$min_duration' and location IS NOT NULL and location NOT IN('','NOT_FOUND','NOT_FOUND_2','DELETED') LIMIT 5000;";
	print "$stmtA\n";
$sthA = $dbhA->prepare($stmtA) or die "preparing: ",$dbhA->errstr;
$sthA->execute or die "executing: $stmtA ", $dbhA->errstr;
$sthArows=$sthA->rows;
$i=0;
while ($sthArows > $i)
	{
	 @aryA = $sthA->fetchrow_array;
		$dlead_ids[$i]	=			"$aryA[0]";
		$drecording_ids[$i]	=		"$aryA[1]";
		$dstart_times[$i]	=		"$aryA[2]";
		$dfilenames[$i] =			"$aryA[3]";
		$dlocations[$i]	=			"$aryA[4]";
	 $i++;
	}
$sthA->finish();


##### Go through list of recordings and delete all recordings older then 1 year and shorter then 10 sec #####
$i=0;
$KEEP=0;
$DELETE=0;
foreach(@drecording_ids) { 
	if ($use_date_DIRs)	{
		$date_DIR = $dstart_times[$i];
		$date_DIR =~ s/ .*//gi;
		$date_DIR .= "/";
	} else {
		$date_DIR=''
	}
	$delName = "$local_DIR/$date_DIR$dfilenames[$i]$suffix";
    print " Name: $delName\n";
	if (-f $delName) {

		`rm -f $delname`;
		print "rm -f $local_DIR/$date_DIR$dfilenames[$i]$suffix    |$dstatuses[$i]|$dlead_ids[$i]|\n";

		$stmtA = "UPDATE recording_log_archive set location='DELETED' where recording_id='$drecording_ids[$i]';";
		$affected_rows = $dbhA->do($stmtA); #  or die  "Couldn't execute query:|$stmtA|\n";
		$DELETE++;
	} else {
		print "Notfound- $dfilenames[$i]$suffix     |$dstatuses[$i]|$dlead_ids[$i]|\n";
		$KEEP++;
	}
	$i++;
}

print "NotFound:  $NOTFOUND\n";
print "Found:     $FOUND\n";
print "--------------------\n";
print "TOTAL:     $ii\n";

print "NotFound:  $KEEP\n";
print "DELETED:   $DELETE\n";
print "--------------------\n";
print "TOTAL:     $i\n";

if ($v) {print "DONE... EXITING\n\n";}

$dbhA->disconnect();


exit;

__DATA__
This exists so flock() code above works.
DO NOT REMOVE THIS DATA SECTION.
