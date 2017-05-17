#!/usr/bin/perl
#
# ADMIN_restart_roll_logs.pl    version 2.12
#
# script to roll the Asterisk logs on machine restart
#
# have this run on the astersik server 
#
# Copyright (C) 2015  Matt Florell <vicidial@gmail.com>    LICENSE: AGPLv2
#
# CHANGES:
# 90311-0921 - Added /var/log/asterisk/screenlog log rolling
# 90508-0535 - Changes root screenlog to /var/log/astguiclient
# 130108-1715 - Changes for new log rolling script compatibility
# 141124-2309 - Fixed Fhour variable bug
# 151110-2005 - Added rolling of Asterisk cdr.db
#

($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
$year = ($year + 1900);
$mon++;
if ($mon < 10) {$mon = "0$mon";}
if ($mday < 10) {$mday = "0$mday";}
if ($hour < 10) {$hour = "0$hour";}
if ($min < 10) {$min = "0$min";}
if ($sec < 10) {$sec = "0$sec";}

$now_date_epoch = time();
$now_date = "$year-$mon-$mday---$hour$min$sec";


print "rolling Asterisk messages log...\n";
if ( -e '/var/log/asterisk/messages' )
	{
	`mv -f /var/log/asterisk/messages /var/log/asterisk/messages.$now_date`;
	}

print "rolling Asterisk event log...\n";
if ( -e '/var/log/asterisk/event_log' )
	{
	`mv -f /var/log/asterisk/event_log /var/log/asterisk/event_log.$now_date`;
	}

print "rolling Asterisk cdr.db...\n";
if ( -e '/var/log/asterisk/cdr.db' )
	{
	`mv -f /var/log/asterisk/cdr.db /var/log/asterisk/cdr.db.$now_date`;
	}

print "rolling Asterisk cdr logs...\n";
if ( -e '/var/log/asterisk/cdr-csv/Master.csv' )
	{
	`mv -f /var/log/asterisk/cdr-csv/Master.csv /var/log/asterisk/cdr-csv/Master.csv.$now_date`;
	}
if ( -e '/var/log/asterisk/cdr-custom/Master.csv' )
	{
	`mv -f /var/log/asterisk/cdr-custom/Master.csv /var/log/asterisk/cdr-custom/Master.csv.$now_date`;
	}

print "rolling Asterisk screen log...\n";
if ( -e '/var/log/astguiclient/screenlog.0' )
	{
	`mv -f /var/log/astguiclient/screenlog.0 /var/log/astguiclient/screenlog.0.$now_date`;
	}

if ( -e '/root/screenlog.0' )
	{
	`mv -f /root/screenlog.0 /var/log/astguiclient/screenlog.0.root.$now_date`;
	}

if ( -e '/var/log/asterisk/screenlog.0' )
	{
	`mv -f /var/log/asterisk/screenlog.0 /var/log/asterisk/screenlog.0.asterisk.$now_date`;
	}


print "FINISHED... EXITING\n";

exit;
