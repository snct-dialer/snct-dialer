<?php

###############################################################################
#
# Modul tools/login.php
#
# SNCT-Dialer™ global Login Handling class
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
# dbconnect_mysqli.php
# functions.php
# SNCTVersion.inc
# ../tools/system_wide_settings.php
# options.php
# callback_footer.php
#
# vdc_db_query.php
# vdc_db_query_ng.php
# manager_send.php
# conf_exten_check.php
# vdc_script_display.php
# vdc_form_display.php
# vdc_email_display.php
# vdc_chat_display.php
# agc_agent_manager_chat_interface.php
#
###############################################################################
#
# Version  / Build
#
$tool_login_version = '3.2.0-1';
$tool_login_build = '20210126-1';
#
###############################################################################
#
# Global settings
#
$mel=1;					# Mysql Error Log enabled = 1
$mysql_log_count=91;
$one_mysql_log=0;
$DB=0;
#
###############################################################################
#
# Changelog
#
# 2021-01-26 jff	First build
#
#
#

class login {
	
	protected string $UserName;
	protected string $UserPw;
	
	public function __construct(string $Name, string $Password ) {
	
	    $this->UserName = $Name;
	    $this->UserPw   = $Password;
	}
}

?>