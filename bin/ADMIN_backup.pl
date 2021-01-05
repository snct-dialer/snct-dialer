#!/usr/bin/perl
#
# ADMIN_backup.pl    version 2.12
#
# DESCRIPTION:
# Backs-up the asterisk database, conf/agi/sounds/bin files
#
# LICENSE: AGPLv3
#
# Copyright (C) 2016  Matt Florell <vicidial@gmail.com>
# Copyright (c) 2017-2018 flyingpenguin.de UG <info@flyingpenguin.de>
#               2017-2019 Jörg Frings-Fürst <open_source@jff.email>
#               2019      SNTC GmbH <info@snct-gmbh.de>
#
# CHANGELOG
#
# 80316-2211 - First Build
# 80317-1609 - Added Sangoma conf file backup and changed FTP settings
# 80328-0135 - Do not attempt to archive /etc/my.cnf is --without-db flag is set
# 80611-0549 - Added DB option to backup all tables except for log tables
# 90620-1851 - Moved mysqldump bin lookup to database backup section
# 100211-0910 - Added crontab backup and voicemail backup option
# 100817-1202 - Fixed test option bug
# 101208-0452 - Added checks for zaptel and dahdi conf files
# 141103-1505 - Added option to export without leads, logs, servers or phones
# 141124-2309 - Fixed Fhour variable bug
# 150418-1801 - Added --db_raw_files_copy flag, issue #839
# 151006-1337 - Added archive_path flag, issue #896
# 160510-2249 - Added --db-without-archives flag, issue #945
# 160719-1415 - Added --dbs-selected=XXX---YYY option
# 161030-0847 - Added CLI ftp options, Issue #442
# 171008-1235 - Fix sounds backup.
#               Add --routines to backup PROZEDURES too.
#               Add VARDB_backup_user, VARDB_backup_pass access parts with
#                 no cron access.
#               Switch temp directory to /tmp/vicibackup.
#               Add prompt_count.txt to linux backup.
# 180227-0658 - Add /etc/flyingpenguin
#               Change license from AGPLv2 to AGPLv3
# 180507-1612 - Remove prompt_count.txt from backup
# 180616-1825 - Add sniplet into perl scripts to run only once a time
# 180626-1030 - Split mysqldump and packing.
# 181223-1820 - Use tar | xy for packing
#             - Pack database tables in own files
#             - Remove passwords from logging
# 181216-1210 - Add PrgVersion
#             - Add tests for file exists
# 181227-1030 - Allow table names with whitespaces
# 181228-1210 - Correct typo
# 190521-0555 - Add sep. backup for trigger and routines
# 190531-1422 - Change all db backups to one file per table.
#

$PrgVersion = "2.9.4";

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

$secT = time();
$secX = time();
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
$year = ($year + 1900);
$mon++;
if ($mon < 10) {$mon = "0$mon";}
if ($mday < 10) {$mday = "0$mday";}
if ($hour < 10) {$hour = "0$hour";}
if ($min < 10) {$min = "0$min";}
if ($sec < 10) {$sec = "0$sec";}
$file_date = "$year-$mon-$mday";
$now_date = "$year-$mon-$mday $hour:$min:$sec";
$VDL_date = "$year-$mon-$mday 00:00:01";
$db_raw_files_copy=0;


print "$0 Version: $PrgVersion \n";


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
	if ( ($line =~ /^VARDB_backup_user/) && ($CLIDB_backup_user < 1) )
		{$VARDB_backup_user = $line;   $VARDB_backup_user =~ s/.*=//gi;}
	if ( ($line =~ /^VARDB_backup_pass/) && ($CLIDB_backup_pass < 1) )
		{$VARDB_backup_pass = $line;   $VARDB_backup_pass =~ s/.*=//gi;}
	if ( ($line =~ /^VARDB_port/) && ($CLIDB_port < 1) )
		{$VARDB_port = $line;   $VARDB_port =~ s/.*=//gi;}
	if ( ($line =~ /^VARREPORT_host/) && ($CLIREPORT_host < 1) )
		{$VARREPORT_host = $line;   $VARREPORT_host =~ s/.*=//gi;}
	if ( ($line =~ /^VARREPORT_user/) && ($CLIREPORT_user < 1) )
		{$VARREPORT_user = $line;   $VARREPORT_user =~ s/.*=//gi;}
	if ( ($line =~ /^VARREPORT_pass/) && ($CLIREPORT_pass < 1) )
		{$VARREPORT_pass = $line;   $VARREPORT_pass =~ s/.*=//gi;}
	if ( ($line =~ /^VARREPORT_port/) && ($CLIREPORT_port < 1) )
		{$VARREPORT_port = $line;   $VARREPORT_port =~ s/.*=//gi;}
	if ( ($line =~ /^VARREPORT_dir/) && ($CLIREPORT_dir < 1) )
		{$VARREPORT_dir = $line;   $VARREPORT_dir =~ s/.*=//gi;}

	$i++;
	}

### set dbuser ###
if(!$VARDB_backup_user) {
	$VARDB_backup_user = $VARDB_user;
	$VARDB_backup_pass = $VARDB_pass;
}


### begin parsing run-time options ###
if (length($ARGV[0])>1)
	{
	$i=0;
	while ($#ARGV >= $i)
		{
		$args = "$args $ARGV[$i]";
		$i++;
		}

	if ($args =~ /--help/i)
		{
		print "allowed run time options:\n";
		print "  [--db-only] = only backup the database\n";
		print "  [--db-settings-only] = only backup the database without leads, logs, servers or phones\n";
		print "  [--db-without-logs] = do not backup the log tables in the database\n";
		print "  [--db-without-archives] = do not backup the archive tables in the database\n";
		print "  [--dbs-selected=X] = backup only selected databases, default uses conf file db only\n";
		print "                       to backup databases X and Y, use X---Y, can use --ALL-- for all dbs on server\n";
		print "                       you can use --ALLNS-- for all non-mysql dbs(will ignore 'test', 'mysql','information_schema')\n";
		print "                       This feature will NOT work with '--db_raw_files_copy' option\n";
		print "  [--conf-only] = only backup the asterisk conf files\n";
		print "  [--without-db] = do not backup the database\n";
		print "  [--without-conf] = do not backup the conf files\n";
		print "  [--without-web] = do not backup web files\n";
		print "  [--without-sounds] = do not backup asterisk sounds\n";
		print "  [--without-voicemail] = do not backup asterisk voicemail\n";
		print "  [--without-crontab] = do not backup crontab\n";
		print "  [--ftp-transfer] = Transfer backup to the 'REPORTS' FTP server\n";
		print "  [--ftp-server=XXXXXXXX] = OVERRIDE FTP server to send file to\n";
		print "  [--ftp-login=XXXXXXXX] = OVERRIDE FTP user\n";
		print "  [--ftp-pass=XXXXXXXX] = OVERRIDE FTP pass\n";
		print "  [--ftp-dir=XXXXXXXX] = OVERRIDE remote FTP server directory to post files to\n";
		print "  [--debugX] = super debug\n";
		print "  [--debug] = debug\n";
		print "  [--test] = test\n";
		print "  [--db_raw_files_copy] = if set the backup won't be a mysql dump. It will tar the /var/lib/mysql folder. WARNING, THIS OPTION WILL STOP THE MYSQL SERVER!\n";
		print "  [--archive_path=/PATH/FROM/ROOT] = absolute path to store the resulting backup\n";
		exit;
		}
	else
		{
		if ($args =~ /--debug/i)
			{
			$DB=1; $FTPdebug=1;
			print "\n----- DEBUG -----\n\n";
			}
		if ($args =~ /--debugX/i)
			{
			$DBX=1;
			print "\n----- SUPER DEBUG -----\n\n";
			}
		if ($args =~ /--test/i)
			{
			$T=1;   $TEST=1;
			print "\n-----TESTING -----\n\n";
			}
		if ($args =~ /--db-settings-only/i)
			{
			$db_settings_only=1;
			print "\n----- Backup Database Settings Only -----\n\n";
			}
		if ($args =~ /--db-only/i)
			{
			$db_only=1;
			print "\n----- Backup Database Only -----\n\n";
			}
		if ($args =~ /--db-without-logs/i)
			{
			$db_without_logs=1;
			print "\n----- Backup Database Without Logs -----\n\n";
			}
		if ($args =~ /--db-without-archives/i)
			{
			$db_without_archives=1;
			print "\n----- Backup Database Without Archives -----\n\n";
			}
		if ($args =~ /--dbs-selected=/i)
			{
			@data_in = split(/--dbs-selected=/,$args);
			$dbs_selected = $data_in[1];
			$dbs_selected =~ s/ .*//gi;
			if ($q < 1) {print "\n----- DATABASES SELECTED: $dbs_selected -----\n\n";}
			}
		else
			{$dbs_selected = '';}
		if ($args =~ /--conf-only/i)
			{
			$conf_only=1;
			print "\n----- Conf Files Backup Only -----\n\n";
			}
		if ($args =~ /--without-db/i)
			{
			$without_db=1;
			print "\n----- No Database Backup -----\n\n";
			}
		if ($args =~ /--without-conf/i)
			{
			$without_conf=1;
			print "\n----- No Conf Files Backup -----\n\n";
			}
		if ($args =~ /--without-sounds/i)
			{
			$without_sounds=1;
			print "\n----- No Sounds Backup -----\n\n";
			}
		if ($args =~ /--without-web/i)
			{
			$without_web=1;
			print "\n----- No web files Backup -----\n\n";
			}
		if ($args =~ /--without-voicemail/i)
			{
			$without_voicemail=1;
			print "\n----- No voicemail files Backup -----\n\n";
			}
		if ($args =~ /--without-crontab/i)
			{
			$without_crontab=1;
			print "\n----- No crontab Backup -----\n\n";
			}
		if ($args =~ /--ftp-transfer/i)
			{
			$ftp_transfer=1;
			print "\n----- FTP transfer -----\n\n";
			}
		if ($args =~ /--db_raw_files_copy/i)
			{
			$db_raw_files_copy = 1;
			print "\n----- DB raw files copy -----\n\n";
			}
		if ($args =~ /--archive_path=/i)
			{
			@data_in = split(/--archive_path=/,$args);
			$ARCHIVEpath = $data_in[1];
			$ARCHIVEpath =~ s/ .*$//gi;
			print "\n----- Archive path set to $ARCHIVEpath -----\n\n";
			}
		if ($args =~ /--ftp-server=/i)
			{
			@data_in = split(/--ftp-server=/,$args);
			$VARREPORT_host = $data_in[1];
			$VARREPORT_host =~ s/ .*//gi;
			$VARREPORT_host =~ s/:/,/gi;
			if ($DB > 0) {print "\n----- FTP SERVER: $VARREPORT_host -----\n\n";}
			}
		if ($args =~ /--ftp-login=/i)
			{
			@data_in = split(/--ftp-login=/,$args);
			$VARREPORT_user = $data_in[1];
			$VARREPORT_user =~ s/ .*//gi;
			$VARREPORT_user =~ s/:/,/gi;
			if ($DB > 0) {print "\n----- FTP LOGIN: $VARREPORT_user -----\n\n";}
			}
		if ($args =~ /--ftp-pass=/i)
			{
			@data_in = split(/--ftp-pass=/,$args);
			$VARREPORT_pass = $data_in[1];
			$VARREPORT_pass =~ s/ .*//gi;
			$VARREPORT_pass =~ s/:/,/gi;
			if ($DB > 0) {print "\n----- FTP PASS: <SET> -----\n\n";}
			}
		if ($args =~ /--ftp-dir=/i)
			{
			@data_in = split(/--ftp-dir=/,$args);
			$VARREPORT_dir = $data_in[1];
			$VARREPORT_dir =~ s/ .*//gi;
			$VARREPORT_dir =~ s/:/,/gi;
			if ($DB > 0) {print "\n----- FTP DIR: $VARREPORT_dir -----\n\n";}
			}
		}
	}
#else
#	{
#	print "no command line options set\n";
#	}


# Customized Variables
$server_ip = $VARserver_ip;		# Asterisk server IP

if (!$ARCHIVEpath) {$ARCHIVEpath = "$PATHlogs/archive";}
if (!$TEMPpath) {$TEMPpath = "/tmp/vicibackup";}
if (!$TEMPpathComp) {$TEMPpathComp = "/tmp";}
if (!$VARDB_port) {$VARDB_port='3306';}

$LOCALpath="";

### find tar binary to do the archiving
$tarbin = '';
if ( -e ('/usr/bin/tar')) {$tarbin = '/usr/bin/tar';}
else
	{
	if ( -e ('/usr/local/bin/tar')) {$tarbin = '/usr/local/bin/tar';}
	else
		{
		if ( -e ('/bin/tar')) {$tarbin = '/bin/tar';}
		else
			{
			print "Can't find tar binary! Exiting...\n";
			exit;
			}
		}
	}

### find xz binary to do the archiving
$xzbin = '';
if ( -e ('/usr/bin/xz')) {$xzbin = '/usr/bin/xz';}
else
	{
	if ( -e ('/usr/local/bin/xz')) {$xzbin = '/usr/local/bin/xz';}
	else
		{
		if ( -e ('/bin/xz')) {$xzbin = '/bin/xz';}
		else
			{
			print "Can't find xz binary! Exiting...\n";
			exit;
			}
		}
	}

$conf='_CONF_';
$sangoma='_SANGOMA_';
$linux='_LINUX_';
$bin='_BIN_';
$web='_WEB_';
$sounds='_SOUNDS_';
$voicemail='_VOICEMAIL_';
$all='_ALL_';
$tar='.tar';
$gz='.gz';
$xz='.xz';
$txz='.txz';
$sgSTRING='';
$underl='_';

`cd $ARCHIVEpath`;
`mkdir $TEMPpath`;

if ( ($without_db < 1) && ($conf_only < 1) )
	{
	if ($db_raw_files_copy < 1)
		{
		### find mysqldump binary to do the database dump
		print "\n----- Mysql dump -----\n\n";
		$mysqldumpbin = '';
		if ( -e ('/usr/bin/mysqldump')) {$mysqldumpbin = '/usr/bin/mysqldump';}
		else
			{
			if ( -e ('/usr/local/mysql/bin/mysqldump')) {$mysqldumpbin = '/usr/local/mysql/bin/mysqldump';}
			else
				{
				if ( -e ('/bin/mysqldump')) {$mysqldumpbin = '/bin/mysqldump';}
				else
					{
					print "Can't find mysqldump binary! MySQL backups will not work...\n";
					}
				}
			}

		use DBI;

		$dbs_to_backup[0]="$VARDB_database";
		if (length($dbs_selected)> 0)
			{
			if ($dbs_selected =~ /--ALL--|--ALLNS--/)
				{
				if ($DBX > 0) {print "DBX-  ALL DATABASES OPTION ENABLED! GATHERING DBS...\n";}
				### connect to MySQL database defined in the conf file so we can get database list
				$dbhA = DBI->connect("DBI:mysql:$VARDB_database:$VARDB_server:$VARDB_port", "$VARDB_user", "$VARDB_pass", { mysql_enable_utf8 => 1 })
				or die "Couldn't connect to database: " . DBI->errstr;

				$stmtA = "show databases;";
				$sthA = $dbhA->prepare($stmtA) or die "preparing: ",$dbhA->errstr;
				$sthA->execute or die "executing: $stmtA ", $dbhA->errstr;
				$dbArows=$sthA->rows;
				$db_ct=0;
				$db_s_ct=0;

				while ($dbArows > $db_ct)
					{
					@aryA = $sthA->fetchrow_array;
					if ($dbs_selected =~ /--ALLNS--/)
						{
						if ($aryA[0] !~ /^test$|^mysql$|^information_schema$/)
							{
							$dbs_to_backup[$db_s_ct] = $aryA[0];
							$db_s_ct++;
							if ($DBX > 0) {print "DBX-  database $db_ct($db_s_ct): $aryA[0]\n";}
							}
						}
					else
						{
						$dbs_to_backup[$db_s_ct] = $aryA[0];
						$db_s_ct++;
						if ($DBX > 0) {print "DBX-  database $db_ct($db_s_ct): $aryA[0]\n";}
						}
					$db_ct++;
					}

				$sthA->finish;
				$dbhA->disconnect;
				}
			else
				{
				if ($dbs_selected =~ /---/)
					{
					@dbs_to_backup = split(/---/,$dbs_selected);
					if ($DBX > 0) {printf "DBX-  databases %d\n", $#dbs_to_backup + 1;}
					}
				else
					{$dbs_to_backup[0]="$dbs_selected";}
				}
			}

		$c=0;
		while ($c <= $#dbs_to_backup)
			{
			$temp_dbname = $dbs_to_backup[$c];
			if ($DBX > 0) {print "DBX-  starting to backup database $c: $temp_dbname\n";}
			### BACKUP THE MYSQL FILES ON THE DB SERVER ###

			### connect to MySQL database defined in the conf file
			$dbhA = DBI->connect("DBI:mysql:$temp_dbname:$VARDB_server:$VARDB_port", "$VARDB_user", "$VARDB_pass", { mysql_enable_utf8 => 1 })
			or die "Couldn't connect to database: " . DBI->errstr;

			$stmtA = "show tables;";
			$sthA = $dbhA->prepare($stmtA) or die "preparing: ",$dbhA->errstr;
			$sthA->execute or die "executing: $stmtA ", $dbhA->errstr;
			$sthArows=$sthA->rows;
			$rec_count=0;
			$log_tables='';
			$archive_tables='';
			$regular_tables='';
			my @all_tables = ();

			while ($sthArows > $rec_count)
				{
				@aryA = $sthA->fetchrow_array;
				push(@all_tables, $aryA[0]);
				if ($aryA[0] =~ /_archive/)
					{
					$archive_tables .= " $aryA[0]";
					}
				elsif ($aryA[0] =~ /_log|server_performance|vicidial_ivr|vicidial_hopper|vicidial_manager|web_client_sessions|imm_outcomes/)
					{
					$log_tables .= " $aryA[0]";
					}
				elsif ($aryA[0] =~ /server|^phones|conferences|stats|vicidial_list$|^custom/)
					{
					$regular_tables .= " $aryA[0]";
					}
				else
					{
					$conf_tables .= " $aryA[0]";
					}
				$rec_count++;
				}
			$sthA->finish();


			if ($db_without_logs)
				{
				$dump_non_log_command = "$mysqldumpbin --user=$VARDB_backup_user --password=$VARDB_backup_pass --lock-tables --flush-logs --routines $temp_dbname $regular_tables $conf_tables | $xzbin -9 > $TEMPpath/LOGS_$VARserver_ip$underl$temp_dbname$underl$wday$xz";
				$dump_non_log_commandOP = "$mysqldumpbin --user=$VARDB_backup_user --password=XXXX --lock-tables --flush-logs --routines $temp_dbname $regular_tables $conf_tables | $xzbin -9 > $TEMPpath/LOGS_$VARserver_ip$underl$temp_dbname$underl$wday$xz";
				$dump_log_command = "$mysqldumpbin --user=$VARDB_backup_user --password=XXXX --lock-tables --flush-logs --no-data --no-create-db --routines $temp_dbname $log_tables $archive_tables | $xzbin -9 > $TEMPpath/LOGS_$VARserver_ip$underl$temp_dbname$underl$wday$xz";

				if ($DBX) {print "$dump_non_log_commandOP\nDEBUG: LOG EXPORT COMMAND(not run): $dump_log_command\n";}
				`$dump_non_log_command`;
				}

			elsif ($db_without_archives)
				{
				$dump_non_archive_command = "$mysqldumpbin --user=$VARDB_backup_user --password=$VARDB_backup_pass --lock-tables --flush-logs --routines $temp_dbname $regular_tables $conf_tables $log_tables | $xzbin -9 > $TEMPEpath/ARCHIVES_$VARserver_ip_$underl$temp_dbname$underl$wday$xz";
				$dump_non_archive_commandOP = "$mysqldumpbin --user=$VARDB_backup_user --password=XXXX --lock-tables --flush-logs --routines $temp_dbname $regular_tables $conf_tables $log_tables | $xzbin -9 > $TEMPEpath/ARCHIVES_$VARserver_ip_$underl$temp_dbname$underl$wday$xz";
				$dump_archive_command = "$mysqldumpbin --user=$VARDB_backup_user --password=XXXX --lock-tables --flush-logs --no-data --no-create-db --routines $temp_dbname $archive_tables | $xzbin -9 > $TEMPpath/ARCHIVES_$VARserver_ip$underl$temp_dbname$underl$wday$xz";

				if ($DBX) {print "$dump_non_archive_commandOP\nDEBUG: ARCHIVE EXPORT COMMAND(not run): $dump_archive_command\n";}
				`$dump_non_archive_command`;
				}

			elsif ($db_settings_only)
				{
				$dump_non_log_command = "$mysqldumpbin --user=$VARDB_backup_user --password=$VARDB_backup_pass --lock-tables --flush-logs --routines $temp_dbname $conf_tables | $zxbin -9 > $TEMPpath/SETTINGSONLY_$VARserver_ip$underl$temp_dbname$underl$wday$xz";
				$dump_non_log_commandOP = "$mysqldumpbin --user=$VARDB_backup_user --password=XXXX --lock-tables --flush-logs --routines $temp_dbname $conf_tables | $zxbin -9 > $TEMPpath/SETTINGSONLY_$VARserver_ip$underl$temp_dbname$underl$wday$xz";
				$dump_log_command = "$mysqldumpbin --user=$VARDB_backup_user --password=XXXX --lock-tables --flush-logs --no-data --no-create-db --routines $temp_dbname $log_tables $archive_tables $regular_tables | $xzbin -9 > $TEMPpath/SETTINGSONLY_$VARserver_ip$underl$temp_dbname$underl$wday$xz";

				if ($DBX) {print "$dump_non_log_commandOP\nNOT ARCHIVED: $dump_log_command\n";}
				`$dump_non_log_command`;
				}
			else {
				foreach ( @all_tables ){
					if ($DBX) {
						print "$mysqldumpbin --user=$VARDB_backup_user --password=XXXX --lock-tables --flush-logs --routines --triggers $temp_dbname '$_' | $xzbin -3 -T0 - > '$TEMPpath/$VARserver_ip$underl$temp_dbname$underl$_$underl$wday.sql.xz'\n";
					}
					`$mysqldumpbin --user=$VARDB_backup_user --password=$VARDB_backup_pass --lock-tables --flush-logs --routines --triggers $temp_dbname '$_' | $xzbin -3 -T0 - > '$TEMPpath/$VARserver_ip$underl$temp_dbname$underl$_$underl$wday.sql.xz'`;
				}
				$triggers = "triggers";
				if ($DBX) {
				    print "$mysqldumpbin --user=$VARDB_backup_user --password=XXXX --no-data --triggers $temp_dbname | $xzbin -3 -T0 - > '$TEMPpath/$VARserver_ip$underl$temp_dbname$underl$triggers$underl$wday.txt.xz'\n";
				}
				`$mysqldumpbin --user=$VARDB_backup_user --password=$VARDB_backup_pass --no-data --triggers $temp_dbname  | $xzbin -3 -T0 - > '$TEMPpath/$VARserver_ip$underl$temp_dbname$underl$triggers$underl$wday.txt.xz'`;

				$routines = "routines";
				if ($DBX) {
				    print "$mysqldumpbin --user=$VARDB_backup_user --password=XXXX --no-data --no-create-info --routines $temp_dbname | $xzbin -3 -T0 - > '$TEMPpath/$VARserver_ip$underl$temp_dbname$underl$routines$underl$wday.txt.xz'\n";
				}
				`$mysqldumpbin --user=$VARDB_backup_user --password=$VARDB_backup_pass --no-data --no-create-info --routines $temp_dbname  | $xzbin -3 -T0 - > '$TEMPpath/$VARserver_ip$underl$temp_dbname$underl$routines$underl$wday.txt.xz'`;
				if ($DBX) {
					print "$tarbin -cf $TEMPpath/$VARserver_ip$underl$temp_dbname$underl$wday$tar $TEMPpath/*.txt.xz`\n";
				}
				`$tarbin -cf $TEMPpath/$VARserver_ip$underl$temp_dbname$underl$wday$tar $TEMPpath/*.sql.xz $TEMPpath/*.txt.xz`;
				`rm $TEMPpath/*.sql.xz`;
				`rm $TEMPpath/*.txt.xz`;
			}
			$c++;
			}
		}
	else
		{
		print "\n----- Mysql Raw Copy -----\n\n";
		`systemctl stop mysql`;
		`$tarbin -Jcvf $TEMPpath/"$VARserver_ip$underl"mysql_raw_"$wday"$txz /var/lib/mysql/test /var/lib/mysql/mysql /var/lib/mysql/performance_schema /var/lib/mysql/asterisk`;
		`systemctl start mysql`;
		}
	}

if ( ($without_conf < 1) && ($db_only < 1) )
	{
	### BACKUP THE ASTERISK CONF FILES ON THE SERVER ###
	$zapdahdi='';
	if (-e "/etc/zaptel.conf") {$zapdahdi .= " /etc/zaptel.conf";}
	if (-e "/etc/dahdi/system.conf") {$zapdahdi .= " /etc/dahdi";}
	if (-e "/etc/apache2") {$zapdahdi .= " /etc/apache2";}
	if (-e "/etc/letsencrypt") {$zapdahdi .= " /etc/letsencrypt";}
	if (-e "/usr/share/astguiclient/AST_DB_lead_status_change.pl") {$zapdahdi .= " /usr/share/astguiclient/AST_DB_lead_status_change.pl";}
	if (-e "/usr/local/sbin") {$zapdahdi .= " /usr/local/sbin";}
	if (-e ("/etc/flyingpenguin")) {$zapdahdi .= " /etc/flyingpenguin";}
	if ($DBX) {print "$tarbin -cf - /etc/astguiclient.conf $zapdahdi /etc/asterisk | $xzbin -1 -T0 - > $TEMPpath/$VARserver_ip$conf$wday$txz \n";}
	`$tarbin -cf - /etc/astguiclient.conf $zapdahdi /etc/asterisk | $xzbin -1 -T0 - > $TEMPpath/$VARserver_ip$conf$wday$txz`;


	### BACKUP THE WANPIPE CONF FILES(if there are any) ###
	if ( -e ('/etc/wanpipe/wanpipe1.conf'))
		{
		$sgSTRING = '/etc/wanpipe/wanpipe1.conf ';
		if ( -e ('/etc/wanpipe/wanpipe2.conf')) {$sgSTRING .= '/etc/wanpipe/wanpipe2.conf ';}
		if ( -e ('/etc/wanpipe/wanpipe3.conf')) {$sgSTRING .= '/etc/wanpipe/wanpipe3.conf ';}
		if ( -e ('/etc/wanpipe/wanpipe4.conf')) {$sgSTRING .= '/etc/wanpipe/wanpipe4.conf ';}
		if ( -e ('/etc/wanpipe/wanpipe5.conf')) {$sgSTRING .= '/etc/wanpipe/wanpipe5.conf ';}
		if ( -e ('/etc/wanpipe/wanpipe6.conf')) {$sgSTRING .= '/etc/wanpipe/wanpipe6.conf ';}
		if ( -e ('/etc/wanpipe/wanpipe7.conf')) {$sgSTRING .= '/etc/wanpipe/wanpipe7.conf ';}
		if ( -e ('/etc/wanpipe/wanpipe8.conf')) {$sgSTRING .= '/etc/wanpipe/wanpipe8.conf ';}
		if ( -e ('/etc/wanpipe/wanrouter.rc')) {$sgSTRING .= '/etc/wanpipe/wanrouter.rc ';}

		if ($DBX) {print "$tarbin -cf -  $sgSTRING | $xzbin -1 -T0 - >  $TEMPpath/$VARserver_ip$sangoma$wday$txz\n";}
		`$tarbin -cf -  $sgSTRING | $xzbin -1 -T0 - >  $TEMPpath/$VARserver_ip$sangoma$wday$txz`;
		}

	### BACKUP OTHER CONF FILES ON THE SERVER ###
	$files = "";

	if ($without_db < 1)
		{
		if ( -e ('/etc/my.cnf')) {$files .= "/etc/my.cnf ";}
		}
	if ($without_crontab < 1)
		{
		`crontab -l > /etc/crontab_snapshot`;
		if ( -e ('/etc/crontab_snapshot')) {$files .= "/etc/crontab_snapshot ";}
		}

	if ( -e ('/etc/hosts')) {$files .= "/etc/hosts ";}
	if ( -e ('/etc/rc.d/rc.local')) {$files .= "/etc/rc.d/rc.local ";}
	if ( -e ('/etc/resolv.conf')) {$files .= "/etc/resolv.conf ";}
	if ( -e ('/prompt_count.txt')) {$files .= "/prompt_count.txt ";}

	if ($DBX) {print "$tarbin -cf - $files | $xzbin -1 -T0 - >  $TEMPpath/$VARserver_ip$linux$wday$txz\n";}
	`$tarbin -cf - $files | $xzbin -1 -T0 - >  $TEMPpath/$VARserver_ip$linux$wday$txz`;
	}

if ( ($conf_only < 1) && ($db_only < 1) && ($without_web < 1) )
	{
	### BACKUP THE WEB FILES ON THE SERVER ###
	if ($DBX) {print "$tarbin -cf - $PATHweb |  $xzbin -1 -T0 - > $TEMPpath/$VARserver_ip$web$wday$txz\n";}
	`$tarbin -cf - $PATHweb | $xzbin -1 -T0 - > $TEMPpath/$VARserver_ip$web$wday$txz`;
	}

if ( ($conf_only < 1) && ($db_only < 1) )
	{
	### BACKUP THE ASTGUICLIENT AND AGI FILES ON THE SERVER ###
	if ($DBX) {print "$tarbin -cf - $PATHagi $PATHhome | $xzbin -1 -T0 - > $TEMPpath/$VARserver_ip$bin$wday$txz\n";}
	`$tarbin -cf - $PATHagi $PATHhome | $xzbin -1 -T0 - > $TEMPpath/$VARserver_ip$bin$wday$txz`;
	}

if ( ($conf_only < 1) && ($db_only < 1) && ($without_sounds < 1) )
	{
	### BACKUP THE ASTERISK SOUNDS ON THE SERVER ###
	if ($DBX) {print "$tarbin -hcf - $PATHsounds | $xzbin -1 -T0 - > $TEMPpath/$VARserver_ip$sounds$wday$txz\n";}
	`$tarbin -hcf - $PATHsounds | $xzbin -1 -T0 - > $TEMPpath/$VARserver_ip$sounds$wday$txz`;
	}

if ( ($conf_only < 1) && ($db_only < 1) && ($without_voicemail < 1) )
	{
	### BACKUP THE ASTERISK VOICEMAIL ON THE SERVER ###
	if ($DBX) {print "$tarbin -cf - /var/spool/asterisk/voicemail | $xzbin -1 -T0 - > $TEMPpath/$VARserver_ip$voicemail$wday$txz\n";}
	`$tarbin -cf - /var/spool/asterisk/voicemail | $xzbin -1 -T0 - > $TEMPpath/$VARserver_ip$voicemail$wday$txz`;
	}

### REMOVE OLD GZ, xz and tar FILE
 if ( -e "$ARCHIVEpath/$VARserver_ip$all$wday$tar$gz" ) {
	if ($DBX) {print "rm -f $ARCHIVEpath/$VARserver_ip$all$wday$tar$gz\n";}
	`rm -f $ARCHIVEpath/$VARserver_ip$all$wday$tar$gz`;
}

 if ( -e "$ARCHIVEpath/$VARserver_ip$all$wday.old$txz" ) {
	if ($DBX) {print "rm -f $ARCHIVEpath/$VARserver_ip$all$wday.old$txz\n";}
	`rm -f $ARCHIVEpath/$VARserver_ip$all$wday.old$txz`;
}
if ( -e "$ARCHIVEpath/$VARserver_ip$all$wday.old$tar" ) {
	if ($DBX) {print "rm -f $ARCHIVEpath/$VARserver_ip$all$wday.old$tar\n";}
	`rm -f $ARCHIVEpath/$VARserver_ip$all$wday.old$tar`;
}

if ( -e "$ARCHIVEpath/$VARserver_ip$all$wday$txz" ) {
	if ($DBX) {print "mv $ARCHIVEpath/$VARserver_ip$all$wday$txz $ARCHIVEpath/$VARserver_ip$all$wday.old$txz\n";}
	`mv $ARCHIVEpath/$VARserver_ip$all$wday$txz $ARCHIVEpath/$VARserver_ip$all$wday.old$txz`;
}
if ( -e "$ARCHIVEpath/$VARserver_ip$all$wday$tar" ) {
	if ($DBX) {print "mv $ARCHIVEpath/$VARserver_ip$all$wday$tar $ARCHIVEpath/$VARserver_ip$all$wday.old$tar\n";}
	`mv $ARCHIVEpath/$VARserver_ip$all$wday$tar $ARCHIVEpath/$VARserver_ip$all$wday.old$tar`;
}

### PUT EVERYTHING TOGETHER TO BE COMPRESSED ###
if ($DBX) {print "$tarbin -Jcf $TEMPpathComp/$VARserver_ip$all$wday$tar $TEMPpath\n";}
`$tarbin -cf $TEMPpathComp/$VARserver_ip$all$wday$tar $TEMPpath`;

### Copy to ArchivePath ###
if ($DBX) {print "cp $TEMPpathComp/$VARserver_ip$all$wday$tar $ARCHIVEpath/\n";}
`cp $TEMPpathComp/$VARserver_ip$all$wday$tar $ARCHIVEpath/`;

### Move to LocalPath ###
if($LOCALpath) {
	if ($DBX) {print "mv -f $TEMPpathComp/$VARserver_ip$all$wday$tar $LOCALpath/\n";}
	`mv -f $TEMPpathComp/$VARserver_ip$all$wday$tar $LOCALpath/`;
}


### COMPRESS THE ALL FILE ###
#if ($DBX) {print "$gzipbin -9 $ARCHIVEpath/$VARserver_ip$all$wday$tar\n";}
#`$gzipbin -9 $ARCHIVEpath/$VARserver_ip$all$wday$tar`;

### REMOVE TEMP FILES ###
#if ($DBX) {print "rm -fR $ARCHIVEpath/temp\n";}
#`rm -fR $ARCHIVEpath/temp`;

if ($DBX) {print "rm -fR $TEMPpath\n";}
`rm -fR $TEMPpath`;


#### FTP to the Backup server and upload the final file
if ($ftp_transfer > 0)
	{
	if ($DBX) {print "Starting FTP transfer...($VARREPORT_user at $VARREPORT_host dir: $VARREPORT_dir)\n";}
	use Net::FTP;
	$ftp = Net::FTP->new("$VARREPORT_host", Port => "$VARREPORT_port", Debug => "$FTPdebug");
	$ftp->login("$VARREPORT_user","$VARREPORT_pass");
	$ftp->cwd("$VARREPORT_dir");
	$ftp->binary();
	$ftp->put("$ARCHIVEpath/$VARserver_ip$all$wday$tar$gz", "$VARserver_ip$all$wday$tar$gz");
	$ftp->quit;
	}

# remove temp tar file
if ( -e "$TEMPpathComp/$VARserver_ip$all$wday$tar") {
	if ($DBX) {print "rm -f $TEMPpathComp/$VARserver_ip$all$wday$tar\n";}
	`rm -f $TEMPpathComp/$VARserver_ip$all$wday$tar`;
}

### calculate time to run script ###
$secY = time();
$secZ = ($secY - $secX);
$secZm = ($secZ /60);

if (!$Q) {print "script execution time in seconds: $secZ     minutes: $secZm\n";}


if ($DBX) {print "DONE, Exiting...\n";}

exit;


__DATA__
This exists so flock() code above works.
DO NOT REMOVE THIS DATA SECTION.
