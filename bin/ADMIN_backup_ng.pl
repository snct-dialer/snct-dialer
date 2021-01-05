#!/usr/bin/perl
#
# ADMIN_backup_ng.pl
#
# DESCRIPTION:
# Backs-up the asterisk database, conf/agi/sounds/bin files
#
# LICENSE: AGPLv3
#
# Copyright (©) 2016      Matt Florell <vicidial@gmail.com>
#
# Copyright (©) 2017-2020 flyingpenguin.de UG <info@flyingpenguin.de>
#               2019      SNCT GmbH <info@snct-gmbh.de>
#               2017-2020 Jörg Frings-Fürst <open_source@jff.email>
#
# CHANGELOG
#
# based on ADMIN_backup.pl from Matt Florell.
#
# 181226-1400 - 3.0.0 - jff First work on ADMIN_backup_ng.pl, based on ADMIN_backup.pl.
# 181226-1810 - 3.0.0 - jff Switch to new config file.
#                     - jff Use FTPBACKUP_* instead $VARREPORT_* for ftp backup.
# 181227-1030 - 3.0.1 - jff Allow table names with whitespaces
# 181228-1215 - 3.0.2 - jff Correct typo
# 190531-1422 - 3.1.0 - jff Change all db backups to one file per table.
#                           Change setupfile location.
#                           Switch from service to systemctl
#                           Change the directory for Backup files.
#                           Create backuppath if not exists.
# 190601-1008 - 3.1.1 - jff Add KW and hour to archive filename.
# 190601-1556 - 3.1.2 - jff Add WebPath2
# 190602-0953 - 3.1.3 - jff Use YYYY-MM-DD[-HH] for backup file name.
# 200601-1132 - 3.1.4 - jff Use YYYY-MM-DD[-HH]_DOW for backup file name.
#

$PrgVersion = "3.1.4";

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
$DateTag = "$year-$mon-${mday}_$wday";


print "$0 Version: $PrgVersion \n";

use Config::IniFiles;

my $defcfg = Config::IniFiles->new( -file => "/etc/snct-dialer/snct-dialer.conf" );
my $newcfg = Config::IniFiles->new( -file => "/etc/snct-dialer/dialer/backup.conf", -import => $defcfg  );
my $cfg    = Config::IniFiles->new( -file => "/etc/snct-dialer/dialer/backup.local", -import => $newcfg );

$PATHhome   = $cfg->val( 'Path', 'PATHhome' );
$PATHlogs   = $cfg->val( 'Path', 'PATHlogs' );
$PATHagi    = $cfg->val( 'Path', 'PATHagi' );
$PATHweb    = $cfg->val( 'Path', 'PATHweb' );
$PATHsounds = $cfg->val( 'Path', 'PATHsounds' );
$PATHbackup = $cfg->val( 'Path', 'PATHbackup' );

$Server_name = $cfg->val( 'Server', 'Server_name' );
$VARserver_ip = $cfg->val( 'Server', 'Server_ip' );

$VARDB_server      = $cfg->val( 'Database', 'VARDB_server' );
$VARDB_database    = $cfg->val( 'Database', 'VARDB_database' );
$VARDB_user        = $cfg->val( 'Database', 'VARDB_user' );
$VARDB_pass        = $cfg->val( 'Database', 'VARDB_pass' );
$VARDB_backup_user = $cfg->val( 'Database', 'VARDB_backup_user' );
$VARDB_backup_pass = $cfg->val( 'Database', 'VARDB_backup_pass' );
$VARDB_port        = $cfg->val( 'Database', 'VARDB_port' );

$BackupUseHour    = $cfg->val( 'Backup', 'BackupHour' );
$BackupWebPath2   = $cfg->val( 'Backup', 'WebPath2' );

$FTPBACKUP_enable = $cfg->val( 'Backup', 'FTPBACKUP_enable' );
$FTPBACKUP_host   = $cfg->val( 'Backup', 'FTPBACKUP_host' );
$FTPBACKUP_user   = $cfg->val( 'Backup', 'FTPBACKUP_user' );
$FTPBACKUP_pass   = $cfg->val( 'Backup', 'FTPBACKUP_pass' );
$FTPBACKUP_port   = $cfg->val( 'Backup', 'FTPBACKUP_port' );
$FTPBACKUP_dir    = $cfg->val( 'Backup', 'FTPBACKUP_dir' );


### set dbuser ###
if(!$VARDB_backup_user) {
	$VARDB_backup_user = $VARDB_user;
	$VARDB_backup_pass = $VARDB_pass;
}

if ($BackupUseHour = "1") {
	$DateTag .= "-";
	$DateTag .= $hour;
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
		print "  [--backup_path=/PATH/FROM/ROOT] = absolute path to store the resulting backup\n";
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
			$FTPBACKUP_enable=1;
			print "\n----- FTP transfer -----\n\n";
			}
		if ($args =~ /--db_raw_files_copy/i)
			{
			$db_raw_files_copy = 1;
			print "\n----- DB raw files copy -----\n\n";
			}
		if ($args =~ /--backup_path=/i)
			{
			@data_in = split(/--backup_path=/,$args);
			$PATHbackup = $data_in[1];
			$PATHbackup =~ s/ .*$//gi;
			print "\n----- Backup path set to $PATHbackup -----\n\n";
			}
		if ($args =~ /--ftp-server=/i)
			{
			@data_in = split(/--ftp-server=/,$args);
			$FTPBACKUP_host = $data_in[1];
			$FTPBACKUP_host =~ s/ .*//gi;
			$FTPBACKUP_host =~ s/:/,/gi;
			if ($DB > 0) {print "\n----- FTP SERVER: $FTPBACKUP_host -----\n\n";}
			}
		if ($args =~ /--ftp-login=/i)
			{
			@data_in = split(/--ftp-login=/,$args);
			$FTPBACKUP_user = $data_in[1];
			$FTPBACKUP_user =~ s/ .*//gi;
			$FTPBACKUP_user =~ s/:/,/gi;
			if ($DB > 0) {print "\n----- FTP LOGIN: $FTPBACKUP_user -----\n\n";}
			}
		if ($args =~ /--ftp-pass=/i)
			{
			@data_in = split(/--ftp-pass=/,$args);
			$FTPBACKUP_pass = $data_in[1];
			$FTPBACKUP_pass =~ s/ .*//gi;
			$FTPBACKUP_pass =~ s/:/,/gi;
			if ($DB > 0) {print "\n----- FTP PASS: <SET> -----\n\n";}
			}
		if ($args =~ /--ftp-dir=/i)
			{
			@data_in = split(/--ftp-dir=/,$args);
			$FTPBACKUP_dir = $data_in[1];
			$FTPBACKUP_dir =~ s/ .*//gi;
			$FTPBACKUP_dir =~ s/:/,/gi;
			if ($DB > 0) {print "\n----- FTP DIR: $FTPBACKUP_dir -----\n\n";}
			}
		}
	}
#else
#	{
#	print "no command line options set\n";
#	}

if (!$PATHbackup) { $PATHbackup = "/var/backups/SNCT-dialer";}
if (!$TEMPpath) {$TEMPpath = "/tmp/snctbackup";}
if (!$TEMPpathComp) {$TEMPpathComp = "/tmp";}
if (!$VARDB_port) {$VARDB_port='3306';}

$LOCALpath="";

### find tar binary to do the archiving
$tarbin = '';
if ( -e ('/usr/bin/tar')) {$tarbin = '/usr/bin/tar';}
else {
	if ( -e ('/usr/local/bin/tar')) {$tarbin = '/usr/local/bin/tar';}
	else {
		if ( -e ('/bin/tar')) {$tarbin = '/bin/tar';}
		else {
			print "Can't find tar binary! Exiting...\n";
			exit;
		}
	}
}

### find xz binary to do the archiving
$xzbin = '';
if ( -e ('/usr/bin/xz')) {$xzbin = '/usr/bin/xz';}
else {
	if ( -e ('/usr/local/bin/xz')) {$xzbin = '/usr/local/bin/xz';}
	else {
		if ( -e ('/bin/xz')) {$xzbin = '/bin/xz';}
		else {
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
$all='_';
$tar='.tar';
$gz='.gz';
$xz='.xz';
$txz='.txz';
$sgSTRING='';
$underl='_';

#
# Create backup path
#
if ( !-d $PATHbackup ) {
    `mkdir $PATHbackup`;
}

`cd $PATHbackup`;
`mkdir $TEMPpath`;

if ( ($without_db < 1) && ($conf_only < 1) ) {
	if ($db_raw_files_copy < 1) {
		### find mysqldump binary to do the database dump
		print "\n----- Mysql dump -----\n\n";
		$mysqldumpbin = '';
		if ( -e ('/usr/bin/mysqldump')) {$mysqldumpbin = '/usr/bin/mysqldump';}
		else {
			if ( -e ('/usr/local/mysql/bin/mysqldump')) {$mysqldumpbin = '/usr/local/mysql/bin/mysqldump';}
			else {
				if ( -e ('/bin/mysqldump')) {$mysqldumpbin = '/bin/mysqldump';}
				else {
					print "Can't find mysqldump binary! MySQL backups will not work...\n";
				}
			}
		}

		use DBI;

		$dbs_to_backup[0]="$VARDB_database";
		if (length($dbs_selected)> 0) {
			if ($dbs_selected =~ /--ALL--|--ALLNS--/) {
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

				while ($dbArows > $db_ct) {
					@aryA = $sthA->fetchrow_array;
					if ($dbs_selected =~ /--ALLNS--/) {
						if ($aryA[0] !~ /^test$|^mysql$|^information_schema$/) {
							$dbs_to_backup[$db_s_ct] = $aryA[0];
							$db_s_ct++;
							if ($DBX > 0) {print "DBX-  database $db_ct($db_s_ct): $aryA[0]\n";}
						}
					} else {
						$dbs_to_backup[$db_s_ct] = $aryA[0];
						$db_s_ct++;
						if ($DBX > 0) {print "DBX-  database $db_ct($db_s_ct): $aryA[0]\n";}
					}
					$db_ct++;
				}

				$sthA->finish;
				$dbhA->disconnect;
			} else {
				if ($dbs_selected =~ /---/) {
					@dbs_to_backup = split(/---/,$dbs_selected);
					if ($DBX > 0) {printf "DBX-  databases %d\n", $#dbs_to_backup + 1;}
				} else {
					$dbs_to_backup[0]="$dbs_selected";
				}
			}
		}

		$c=0;
		while ($c <= $#dbs_to_backup) {
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
			my @log_tables = ();
			my @archive_tables = ();
			my @regular_tables = ();
			my @all_tables = ();
			my @wo_archive_tables = ();
			my @wo_log_tables = ();

			while ($sthArows > $rec_count) {
				@aryA = $sthA->fetchrow_array;
				push(@all_tables, $aryA[0]);
				if (! ($aryA[0] =~ /_archive/)) {
					push(@wo_archive_tables, $aryA[0]);
				}
				if ((!($aryA[0] =~ /_archive/)) && (!($aryA[0] =~ /_log/))) {
					push(@wo_log_tables, $aryA[0]);
				}
				if ($aryA[0] =~ /_archive/) {
					push(@archive_tables, $aryA[0]);
				}
				elsif ($aryA[0] =~ /_log|server_performance|vicidial_ivr|vicidial_hopper|vicidial_manager|web_client_sessions|imm_outcomes/) {
					push(@log_tables, $aryA[0]);
				}
				elsif ($aryA[0] =~ /server|^phones|conferences|stats|vicidial_list$|^custom/) {
					push(@regular_tables, $aryA[0]);
				} else {
					push(@conf_tables, $aryA[0]);
				}
				$rec_count++;
			}
			$sthA->finish();

			if ($db_without_logs) {
				foreach ( @wo_log_tables ){
					if ($DBX) {
						print "$mysqldumpbin --user=$VARDB_backup_user --password=XXXX --lock-tables --flush-logs --routines $temp_dbname '$_' | $xzbin -3 -T0 - > '$TEMPpath/$Server_name$underl$temp_dbname$underl$_$underl$wday.sql.xz'\n";
					}
					`$mysqldumpbin --user=$VARDB_backup_user --password=$VARDB_backup_pass --lock-tables --flush-logs --routines $temp_dbname '$_' | $xzbin -3 -T0 - > '$TEMPpath/$Server_name$underl$temp_dbname$underl$_$underl$wday.sql.xz'`;
				}
			} elsif ($db_without_archives) {

				foreach ( @wo_archive_tables ){
					if ($DBX) {
						print "$mysqldumpbin --user=$VARDB_backup_user --password=XXXX --lock-tables --flush-logs --routines $temp_dbname '$_' | $xzbin -3 -T0 - > '$TEMPpath/$Server_name$underl$temp_dbname$underl$_$underl$wday.sql.xz'\n";
					}
					`$mysqldumpbin --user=$VARDB_backup_user --password=$VARDB_backup_pass --lock-tables --flush-logs --routines $temp_dbname '$_' | $xzbin -3 -T0 - > '$TEMPpath/$Server_name$underl$temp_dbname$underl$_$underl$wday.sql.xz'`;
				}
			} elsif ($db_settings_only) {
				foreach ( @conf_tables ){
					if ($DBX) {
						print "$mysqldumpbin --user=$VARDB_backup_user --password=XXXX --lock-tables --flush-logs --routines $temp_dbname '$_' | $xzbin -3 -T0 - > '$TEMPpath/$Server_name$underl$temp_dbname$underl$_$underl$wday.sql.xz'\n";
					}
					`$mysqldumpbin --user=$VARDB_backup_user --password=$VARDB_backup_pass --lock-tables --flush-logs --routines $temp_dbname '$_' | $xzbin -3 -T0 - > '$TEMPpath/$Server_name$underl$temp_dbname$underl$_$underl$wday.sql.xz'`;
				}
			} else {
				foreach ( @all_tables ){
					if ($DBX) {
						print "$mysqldumpbin --user=$VARDB_backup_user --password=XXXX --lock-tables --flush-logs --routines $temp_dbname '$_' | $xzbin -3 -T0 - > '$TEMPpath/$Server_name$underl$temp_dbname$underl$_$underl$wday.sql.xz'\n";
					}
					`$mysqldumpbin --user=$VARDB_backup_user --password=$VARDB_backup_pass --lock-tables --flush-logs --routines $temp_dbname '$_' | $xzbin -3 -T0 - > '$TEMPpath/$Server_name$underl$temp_dbname$underl$_$underl$wday.sql.xz'`;
				}
				if ($DBX) {
					print "$tarbin -cf $TEMPpath/$Server_name$underl$temp_dbname$underl$wday$tar $TEMPpath/*.sql.xz`\n";
				}
			}
			$routines = "routines";
			if ($DBX) {
			    print "$mysqldumpbin --user=$VARDB_backup_user --password=XXXX --no-data --no-create-info --routines $temp_dbname | $xzbin -3 -T0 - > '$TEMPpath/$Server_name$underl$temp_dbname$underl$routines$underl$wday.txt.xz'\n";
			}
			`$mysqldumpbin --user=$VARDB_backup_user --password=$VARDB_backup_pass --no-data --no-create-info --routines $temp_dbname  | $xzbin -3 -T0 - > '$TEMPpath/$Server_name$underl$temp_dbname$underl$routines$underl$wday.txt.xz'`;

			$triggers = "triggers";
			if ($DBX) {
			    print "$mysqldumpbin --user=$VARDB_backup_user --password=XXXX --no-data --triggers $temp_dbname | $xzbin -3 -T0 - > '$TEMPpath/$Server_name$underl$temp_dbname$underl$triggers$underl$wday.txt.xz'\n";
			}
			`$mysqldumpbin --user=$VARDB_backup_user --password=$VARDB_backup_pass --no-data --triggers $temp_dbname  | $xzbin -3 -T0 - > '$TEMPpath/$Server_name$underl$temp_dbname$underl$triggers$underl$wday.txt.xz'`;

			if ($DBX) {
				print "$tarbin -cf $TEMPpath/$Server_name$underl$temp_dbname$underl$wday$tar '$TEMPpath/*.sql.xz' '$TEMPpath/*.txt.xz'\n";
			}
			`$tarbin -cf $TEMPpath/$Server_name$underl$temp_dbname$underl$wday$tar $TEMPpath/*.sql.xz $TEMPpath/*.txt.xz`;
			`rm $TEMPpath/*.sql.xz`;
			`rm $TEMPpath/*.txt.xz`;

			$c++;
		}
	} else {
		print "\n----- Mysql Raw Copy -----\n\n";
		`systemctl stop mysql`;
		`$tarbin -Jcvf $TEMPpath/"$Server_name$underl"mysql_raw_"$wday"$txz /var/lib/mysql/test /var/lib/mysql/mysql /var/lib/mysql/performance_schema /var/lib/mysql/asterisk`;
		`systemctl stop mysql`;
	}
}

if ( ($without_conf < 1) && ($db_only < 1) )
	{
	### BACKUP THE ASTERISK CONF FILES ON THE SERVER ###
	$zapdahdi='';
	if (-e "/etc/zaptel.conf") {$zapdahdi .= " /etc/zaptel.conf";}
	if (-e "/etc/dahdi/system.conf") {$zapdahdi .= " /etc/dahdi";}
	if (-e "/etc/apache2") {$zapdahdi .= " /etc/apache2";}
	if (-e "/etc/mysql") {$zapdahdi .= " /etc/mysql";}
	if (-e "/etc/letsencrypt") {$zapdahdi .= " /etc/letsencrypt";}
	if (-e "/usr/share/astguiclient/AST_DB_lead_status_change.pl") {$zapdahdi .= " /usr/share/astguiclient/AST_DB_lead_status_change.pl";}
	if (-e "/usr/local/sbin") {$zapdahdi .= " /usr/local/sbin";}
	if (-e ("/etc/flyingpenguin")) {$zapdahdi .= " /etc/flyingpenguin";}
	if (-e ("/etc/snct-dialer")) {$zapdahdi .= " /etc/snct-dialer";}
	if ($DBX) {print "$tarbin -cf - /etc/astguiclient.conf $zapdahdi /etc/asterisk | $xzbin -1 -T0 - > $TEMPpath/$Server_name$conf$wday$txz \n";}
	`$tarbin -cf - /etc/astguiclient.conf $zapdahdi /etc/asterisk | $xzbin -1 -T0 - > $TEMPpath/$Server_name$conf$wday$txz`;


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

		if ($DBX) {print "$tarbin -cf -  $sgSTRING | $xzbin -1 -T0 - >  $TEMPpath/$Server_name$sangoma$wday$txz\n";}
		`$tarbin -cf -  $sgSTRING | $xzbin -1 -T0 - >  $TEMPpath/$Server_name$sangoma$wday$txz`;
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

	if ($DBX) {print "$tarbin -cf - $files | $xzbin -1 -T0 - >  $TEMPpath/$Server_name$linux$wday$txz\n";}
	`$tarbin -cf - $files | $xzbin -1 -T0 - >  $TEMPpath/$Server_name$linux$wday$txz`;
	}

if ( ($conf_only < 1) && ($db_only < 1) && ($without_web < 1) )
	{
	### BACKUP THE WEB FILES ON THE SERVER ###
	if ($DBX) {print "$tarbin -cf - $PATHweb $BackupWebPath2 |  $xzbin -1 -T0 - > $TEMPpath/$Server_name$web$wday$txz\n";}
	`$tarbin -cf - $PATHweb $BackupWebPath2 | $xzbin -1 -T0 - > $TEMPpath/$Server_name$web$wday$txz`;
	}

if ( ($conf_only < 1) && ($db_only < 1) )
	{
	### BACKUP THE ASTGUICLIENT AND AGI FILES ON THE SERVER ###
	if ($DBX) {print "$tarbin -cf - $PATHagi $PATHhome | $xzbin -1 -T0 - > $TEMPpath/$Server_name$bin$wday$txz\n";}
	`$tarbin -cf - $PATHagi $PATHhome | $xzbin -1 -T0 - > $TEMPpath/$Server_name$bin$wday$txz`;
	}

if ( ($conf_only < 1) && ($db_only < 1) && ($without_sounds < 1) )
	{
	### BACKUP THE ASTERISK SOUNDS ON THE SERVER ###
	if ($DBX) {print "$tarbin -hcf - $PATHsounds | $xzbin -1 -T0 - > $TEMPpath/$Server_name$sounds$wday$txz\n";}
	`$tarbin -hcf - $PATHsounds | $xzbin -1 -T0 - > $TEMPpath/$Server_name$sounds$wday$txz`;
	}

if ( ($conf_only < 1) && ($db_only < 1) && ($without_voicemail < 1) )
	{
	### BACKUP THE ASTERISK VOICEMAIL ON THE SERVER ###
	if ($DBX) {print "$tarbin -cf - /var/spool/asterisk/voicemail | $xzbin -1 -T0 - > $TEMPpath/$Server_name$voicemail$wday$txz\n";}
	`$tarbin -cf - /var/spool/asterisk/voicemail | $xzbin -1 -T0 - > $TEMPpath/$Server_name$voicemail$wday$txz`;
	}

### PUT EVERYTHING TOGETHER TO BE COMPRESSED ###
if ($DBX) {print "$tarbin -Jcf $TEMPpathComp/$Server_name$all$DateTag$tar $TEMPpath\n";}
`$tarbin -cf $TEMPpathComp/$Server_name$all$DateTag$tar $TEMPpath`;

### Copy to ArchivePath ###
if ($DBX) {print "cp $TEMPpathComp/$Server_name$all$DateTag$tar $PATHbackup/\n";}
`cp $TEMPpathComp/$Server_name$all$DateTag$tar $PATHbackup/`;

### Move to LocalPath ###
if($LOCALpath) {
	if ($DBX) {print "mv -f $TEMPpathComp/$Server_name$all$DateTag$tar $LOCALpath/\n";}
	`mv -f $TEMPpathComp/$Server_name$all$DateTag$tar $LOCALpath/`;
}


### COMPRESS THE ALL FILE ###
#if ($DBX) {print "$gzipbin -9 $PATHbackup/$Server_name$all$wday$tar\n";}
#`$gzipbin -9 $PATHbackup/$Server_name$all$wday$tar`;

### REMOVE TEMP FILES ###
#if ($DBX) {print "rm -fR $PATHbackup/temp\n";}
#`rm -fR $PATHbackup/temp`;

if ($DBX) {print "rm -fR $TEMPpath\n";}
`rm -fR $TEMPpath`;


#### FTP to the Backup server and upload the final file
if ($FTPBACKUP_enable > 0) {
	if ($DBX) {print "Starting FTP transfer...($FTPBACKUP_user at $FTPBACKUP_host dir: $FTPBACKUP_dir)\n";}
	use Net::FTP;
	$ftp = Net::FTP->new("$FTPBACKUP_host", Port => "$FTPBACKUP_port", Debug => "$FTPdebug");
	$ftp->login("$FTPBACKUP_user","$FTPBACKUP_pass");
	$ftp->cwd("$FTPBACKUP_dir");
	$ftp->binary();
	$ftp->put("$TEMPpathComp/$Server_name$all$DateTag$tar", "$Server_name$all$DateTag$tar");
	$ftp->quit;
}

# remove temp tar file
if ( -e "$TEMPpathComp/$Server_name$all$DateTag$tar") {
	if ($DBX) {print "rm -f $TEMPpathComp/$Server_name$all$DateTag$tar\n";}
	`rm -f $TEMPpathComp/$Server_name$all$DateTag$tar`;
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

