<?php 

###############################################################################
#
# Modul admin_dsgvo_download.php
#
# SNCT-Dialer™ DSGVO download data
#
# Copyright (©) 2021 SNCT GmbH <info@snct-gmbh.de>
#               2021 Jörg Frings-Fürst <open_source@jff.email>
#
# LICENSE: AGPLv3
#
###############################################################################
#
# requested Module:
#
# dbconnect_mysqli.php
# functions.php
# admin_functions.php
# admin_header.php
# options.php
# ../tools/system_wide_settings.php
# ../inc/get_system_settings.php
# ../inc/funtions_ng.php
# language_header.php
#
###############################################################################
#
# Version  / Build
#
$admin_dsgvo_download_version = '3.1.1-0';
$admin_dsgvo_download_build = '20210505-1';
#
###############################################################################
#
# Changelog#
#
# 2021-05-05 jff    First work
#
#
#

#
# Settings for download zip files via readfile
#
apache_setenv('no-gzip', 1);
ini_set('zlib.output_compression', 0);

function GenDSGVOcvs($LeadID) {
    global $link, $DB;
    
    
    $table_array=array("vicidial_list", "recording_log", "vicidial_log", "vicidial_xfer_log", "vicidial_closer_log", "vicidial_carrier_log", "vicidial_agent_log");
    $date_field_array=array("entry_date", "start_time", "call_date", "call_date", "call_date", "call_date", "event_time");
    $purge_field_array=array(
        "vicidial_list" => array("phone_code", "phone_number", "title", "first_name", "middle_initial", "last_name", "address1", "address2", "address3", "city", "state", "province", "postal_code", "country_code", "gender", "date_of_birth", "alt_phone", "email", "security_phrase", "comments"),
        "vicidial_log" => array(),
        "vicidial_xfer_log" => array(),
        "vicidial_closer_log" => array(),
        "vicidial_carrier_log" => array(),
        "vicidial_agent_log" => array(),
        "recording_log" => array("filename", "location")
    );
    $table_count=count($table_array);
    
    $CSV_text="";
    $HTML_text="";
    $SQL_log = "";
    
    for ($t=0; $t<$table_count; $t++) {
        $table_name=$table_array[$t];
        $archive_table_name=use_archive_table($table_name);
        $mysql_stmt="(select * from ".$table_name." where lead_id='$LeadID'";
        if ($archive_table_name!=$table_name) {$mysql_stmt.=" UNION (select * from ".$archive_table_name." where lead_id='$LeadID')";}
        $list_id=""; $HTML_header=""; $CSV_header=""; $HTML_body=""; $CSV_body="";
        
        $mysql_stmt.=" order by ".$date_field_array[$t]." desc";
        $mysql_rslt=mysqli_query($link, $mysql_stmt);
        if ($DB) {sd_debug_log($mysql_stmt);}
        if (mysqli_num_rows($mysql_rslt)>0)
        {
            $CSV_text.="\""._QXZ("TABLE NAME").":\",\"$table_name\"\n";
            $HTML_text.="<B>"._QXZ("TABLE NAME").": $table_name</B><BR>\n";
            $HTML_text.="<TABLE width=1000 cellspacing=1 cellpadding=5>\n";
            
            $j=0;
            while($row=mysqli_fetch_array($mysql_rslt,MYSQLI_ASSOC))
            {
                if ($j%2==0)
                {
                    $bgcolor=$SSstd_row2_background;
                }
                else
                {
                    $bgcolor=$SSstd_row3_background;
                }
                
                if ($j==0)
                {
                    $HTML_header.="<tr>\n";
                }
                $HTML_body.="<tr>\n";
                while (list($key, $val)=each($row))
                {
                    if ($key=="entry_list_id") {$list_id=$val;}
                    if (in_array($key, $purge_field_array["$table_name"]) || (preg_match("/^custom_/", $table_name) && $key!="lead_id"))
                    {
                        $bgcolor="bgcolor='#999999'";
                        $sb="<B>";
                        $eb="</B>";
                    }
                    else
                    {
                        $bgcolor="bgcolor='#$SSstd_row1_background'";
                        $sb="";
                        $eb="";
                    }
                    if ($j==0)
                    {
                        $CSV_header.="\"".$key."\",";
                        $HTML_header.="\t<td $bgcolor>$sb<font size='2'>".$key."</font>$eb</td>\n";
                    }
                    $CSV_body.="\"$val\",";
                    $HTML_body.="\t<td $bgcolor>$sb<font size='2'>".$val."</font>$eb</td>\n";
                }
                if ($j==0)
                {
                    $CSV_header=substr($CSV_header, 0, -1)."\n";
                    $HTML_header.="</tr>\n";
                }
                $CSV_body=substr($CSV_body, 0, -1)."\n";
                $HTML_body.="</tr>\n";
                $j++;
            }
            
            $CSV_text.=$CSV_header.$CSV_body;
            $HTML_text.=$HTML_header.$HTML_body;
            
            $CSV_text.="\n";
            $HTML_text.="</table><BR><BR>";
            
        }
        
        if ($list_id && $table_name=="vicidial_list" && table_exists("custom_$list_id") && !in_array("custom_$list_id", $table_array))
        {
            array_splice($table_array, 1, 0, "custom_$list_id");
            array_splice($date_field_array, 1, 0, "lead_id");
            $custom_table_array=array("custom_$list_id" => array());
            $purge_field_array=array_merge($purge_field_array, $custom_table_array);
            $table_count++;
        }
    }
}

function DSGVODownload($LeadID) {
    global $link, $DB;
    
    if ($enable_gdpr_download_deletion>0)
    {
        $stmt="SELECT export_gdpr_leads from vicidial_users where user='$PHP_AUTH_USER' and export_gdpr_leads >= 1;";
        $rslt=mysqli_query($link, $stmt);
        $row=mysqli_fetch_row($rslt);
        $gdpr_display=$row[0];
        
        if ($gdpr_display>=1 && $gdpr_action && $LeadID)
        {
            $table_array=array("vicidial_list", "recording_log", "vicidial_log", "vicidial_xfer_log", "vicidial_closer_log", "vicidial_carrier_log", "vicidial_agent_log");
            $date_field_array=array("entry_date", "start_time", "call_date", "call_date", "call_date", "call_date", "event_time");
            $purge_field_array=array(
                "vicidial_list" => array("phone_code", "phone_number", "title", "first_name", "middle_initial", "last_name", "address1", "address2", "address3", "city", "state", "province", "postal_code", "country_code", "gender", "date_of_birth", "alt_phone", "email", "security_phrase", "comments"),
                "vicidial_log" => array(),
                "vicidial_xfer_log" => array(),
                "vicidial_closer_log" => array(),
                "vicidial_carrier_log" => array(),
                "vicidial_agent_log" => array(),
                "recording_log" => array("filename", "location")
            );
            $table_count=count($table_array);
            
            $CSV_text="";
            $HTML_text="";
            $SQL_log = "";
            
            if ($gdpr_action=="confirm_purge")
            {
                $archive_table_name=use_archive_table("vicidial_list");
                $mysql_stmt="(select list_id from vicidial_list where lead_id='$LeadID')";
                if ($archive_table_name!="vicidial_list") {$mysql_stmt.=" UNION (select list_id from ".$archive_table_name." where lead_id='$LeadID')";}
                $mysql_rslt=mysqli_query($link, $mysql_stmt);
                if(mysqli_num_rows($mysql_rslt)>0)
                {
                    $mysql_row=mysqli_fetch_row($mysql_rslt);
                    $list_id=$mysql_row[0];
                }
                
                for ($t=0; $t<$table_count; $t++)
                {
                    $table_name=$table_array[$t];
                    $archive_table_name=use_archive_table($table_name);
                    
                    if ($list_id && $table_name=="vicidial_list" && table_exists("custom_$list_id"))
                    {
                        array_splice($table_array, 1, 0, "custom_$list_id");
                        array_splice($date_field_array, 1, 0, "lead_id");
                        $custom_table_array=array("custom_$list_id" => array());
                        $purge_field_array=array_merge($purge_field_array, $custom_table_array);
                        $table_count++;
                        
                        $custom_stmt="SHOW COLUMNS FROM custom_".$list_id."";
                        $custom_rslt=mysqli_query($link, $custom_stmt);
                        while($custom_row=mysqli_fetch_row($custom_rslt))
                        {
                            if ($custom_row[0]!="lead_id")
                            {
                                array_push($purge_field_array["custom_$list_id"], $custom_row[0]);
                            }
                        }
                    }
                    
                    if(count($purge_field_array["$table_name"])>0)
                    {
                        if ($table_name=="recording_log")
                        {
                            $ins_stmt="insert ignore into recording_log_deletion_queue(recording_id,lead_id, filename, location, date_queued) (select recording_id,lead_id, filename, location, now() from recording_log where lead_id='$LeadID') UNION (select recording_id,lead_id, filename, location, now() from recording_log_archive where lead_id='$LeadID')";
                            $ins_rslt=mysqli_query($link, $ins_stmt);
                        }
                        
                        $upd_clause=implode("=null, ", $purge_field_array["$table_name"])."=null ";
                        $upd_stmt="update $table_name set $upd_clause where lead_id='$LeadID'";
                        $upd_rslt=mysql_query($link, $upd_stmt, $link);
                        $SQL_log.="$upd_stmt|";
                        if ($archive_table_name!=$table_name)
                        {
                            $upd_stmt="update $archive_table_name set $upd_clause where lead_id='$LeadID'";
                            $upd_rslt=mysqli_query($link, $upd_stmt);
                            $SQL_log.="$upd_stmt|";
                        }
                    }
                }
                
                $SQL_log = addslashes($SQL_log);
                $stmt="INSERT INTO vicidial_admin_log set event_date='$NOW_TIME', user='$PHP_AUTH_USER', ip_address='$ip', event_section='LEADS', event_type='DELETE', record_id='$LeadID', event_code='GDPR PURGE LEAD DATA', event_sql=\"$SQL_log\", event_notes='';";
                if ($DB) {sd_debug_log($stmt);}
                $rslt=mysqli_query($link, $stmt);
                
            }
            
            $HTML_text.="<BR><BR>";
            $HTML_text.="<TABLE width=1000 cellspacing=1 cellpadding=5>\n";
            $HTML_text.="<tr>\n";
            $HTML_text.="\t<td align='left'><B>"._QXZ("GDPR DATA PURGE PREVIEW")."</B> <I>("._QXZ("greyed fields will be emptied").")</I>:</td>";
            $HTML_text.="\t<th><a href=\"admin_modify_lead.php?lead_id=$LeadID&gdpr_action=download\">"._QXZ("DOWNLOAD")."</a></th>";
            $HTML_text.="\t<th><a href=\"admin_modify_lead.php?lead_id=$LeadID&gdpr_action=confirm_purge\">"._QXZ("CONFIRM PURGE")."</a></th>";
            $HTML_text.="</tr>";
            $HTML_text.="</table><BR><BR>";
            
            for ($t=0; $t<$table_count; $t++)
            {
                $table_name=$table_array[$t];
                $archive_table_name=use_archive_table($table_name);
                $mysql_stmt="(select * from ".$table_name." where lead_id='$LeadID')";
                if ($archive_table_name!=$table_name) {$mysql_stmt.=" UNION (select * from ".$archive_table_name." where lead_id='$LeadID')";}
                $list_id=""; $HTML_header=""; $CSV_header=""; $HTML_body=""; $CSV_body="";
                
                $mysql_stmt.=" order by ".$date_field_array[$t]." desc";
                $mysql_rslt=mysqli_query($link, $mysql_stmt);
                if ($DB) {sd_debug_log($mysql_stmt);}
                if (mysqli_num_rows($mysql_rslt)>0)
                {
                    $CSV_text.="\""._QXZ("TABLE NAME").":\",\"$table_name\"\n";
                    $HTML_text.="<B>"._QXZ("TABLE NAME").": $table_name</B><BR>\n";
                    $HTML_text.="<TABLE width=1000 cellspacing=1 cellpadding=5>\n";
                    
                    $j=0;
                    while($row=mysqli_fetch_array($mysql_rslt,MYSQLI_ASSOC))
                    {
                        if ($j%2==0)
                        {
                            $bgcolor=$SSstd_row2_background;
                        }
                        else
                        {
                            $bgcolor=$SSstd_row3_background;
                        }
                        
                        if ($j==0)
                        {
                            $HTML_header.="<tr>\n";
                        }
                        $HTML_body.="<tr>\n";
                        while (list($key, $val)=each($row))
                        {
                            if ($key=="entry_list_id") {$list_id=$val;}
                            if (in_array($key, $purge_field_array["$table_name"]) || (preg_match("/^custom_/", $table_name) && $key!="lead_id"))
                            {
                                $bgcolor="bgcolor='#999999'";
                                $sb="<B>";
                                $eb="</B>";
                            }
                            else
                            {
                                $bgcolor="bgcolor='#$SSstd_row1_background'";
                                $sb="";
                                $eb="";
                            }
                            if ($j==0)
                            {
                                $CSV_header.="\"".$key."\",";
                                $HTML_header.="\t<td $bgcolor>$sb<font size='2'>".$key."</font>$eb</td>\n";
                            }
                            $CSV_body.="\"$val\",";
                            $HTML_body.="\t<td $bgcolor>$sb<font size='2'>".$val."</font>$eb</td>\n";
                        }
                        if ($j==0)
                        {
                            $CSV_header=substr($CSV_header, 0, -1)."\n";
                            $HTML_header.="</tr>\n";
                        }
                        $CSV_body=substr($CSV_body, 0, -1)."\n";
                        $HTML_body.="</tr>\n";
                        $j++;
                    }
                    
                    $CSV_text.=$CSV_header.$CSV_body;
                    $HTML_text.=$HTML_header.$HTML_body;
                    
                    $CSV_text.="\n";
                    $HTML_text.="</table><BR><BR>";
                    
                }
                
                if ($list_id && $table_name=="vicidial_list" && table_exists("custom_$list_id") && !in_array("custom_$list_id", $table_array))
                {
                    array_splice($table_array, 1, 0, "custom_$list_id");
                    array_splice($date_field_array, 1, 0, "lead_id");
                    $custom_table_array=array("custom_$list_id" => array());
                    $purge_field_array=array_merge($purge_field_array, $custom_table_array);
                    $table_count++;
                }
            }
            
            if (strlen($CSV_text)>0 && $gdpr_action=="download")
            {
                $files_to_zip=array();
                
                $rec_stmt="select start_time, location, filename from recording_log where lead_id='$LeadID' AND location LIKE 'http%' order by start_time asc";
                $rec_rslt=mysqli_query($link, $rec_stmt);
                while ($rec_row=mysqli_fetch_row($rec_rslt)) {
                    $start_time=$rec_row[0];
                    $start_date=substr($start_time, 1, 10);
                    $location=$rec_row[1];
                    $filename=$rec_row[2];
                    preg_match("/$filename.*$/", $location, $matches);
                    
                    $location = GetRealRecordingsURL($location, $link);
                    
                    $destination_filename=$matches[0];
                    set_time_limit(0);
                    
                    $fp = fopen("/tmp/$destination_filename", 'w+');
                    $ch = curl_init(str_replace(" ","%20",$location));
                    curl_setopt($ch, CURLOPT_TIMEOUT, 50);
                    curl_setopt($ch, CURLOPT_FILE, $fp);
                    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
                    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
                    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
                    curl_exec($ch);
                    curl_close($ch);
                    fclose($fp);
                    
                    array_push($files_to_zip, "$destination_filename");
                }
                
                $rec_stmt="select start_time, location, filename from recording_log_archive where lead_id='$LeadID' AND location LIKE 'http%' order by start_time asc";
                $rec_rslt=mysqli_query($link, $rec_stmt);
                while ($rec_row=mysqli_fetch_row($rec_rslt)) {
                    $start_time=$rec_row[0];
                    $start_date=substr($start_time, 1, 10);
                    $location=$rec_row[1];
                    $filename=$rec_row[2];
                    preg_match("/$filename.*$/", $location, $matches);
                    
                    $location = GetRealRecordingsURL($location, $link);
                    
                    $destination_filename=$matches[0];
                    set_time_limit(0);
                    
                    $fp = fopen("/tmp/$destination_filename", 'w+');
                    $ch = curl_init(str_replace(" ","%20",$location));
                    curl_setopt($ch, CURLOPT_TIMEOUT, 50);
                    curl_setopt($ch, CURLOPT_FILE, $fp);
                    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
                    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
                    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
                    curl_exec($ch);
                    curl_close($ch);
                    fclose($fp);
                    
                    array_push($files_to_zip, "$destination_filename");
                }
                
                $stmt="INSERT INTO vicidial_admin_log set event_date='$NOW_TIME', user='$PHP_AUTH_USER', ip_address='$ip', event_section='LEADS', event_type='EXPORT', record_id='$LeadID', event_code='GDPR EXPORT LEAD DATA', event_sql=\"$SQL_log\", event_notes='';";
                if ($DB) {sd_debug_log($stmt);}
                $rslt=mysqli_query($link, $stmt);
                
                
                $FILE_TIME = date("Ymd-His");
                $CSVfilename = "GDPR_export_$US$FILE_TIME.csv";
                $CSV_text=preg_replace('/^\s+/', '', $CSV_text);
                $CSV_text=preg_replace('/ +\"/', '"', $CSV_text);
                $CSV_text=preg_replace('/\" +/', '"', $CSV_text);
                
                array_push($files_to_zip, "$CSVfilename");
                $fp = fopen("/tmp/$CSVfilename", 'w+');
                fwrite($fp, $CSV_text);
                fclose($fp);
                
                $zipname = "$LeadID.zip";
                $zip = new ZipArchive;
                $zip->open($zipname, ZipArchive::CREATE|ZipArchive::OVERWRITE);
                foreach ($files_to_zip as $file) {
                    $tempfile="/tmp/$file";
                    if (file_exists($tempfile)) {
                        $zip->addFile($tempfile);
                    }
                }
                $zip->close();
                
                if (!headers_sent()) {
                    header('Content-Description: File Transfer');
                    header("Pragma: public");
                    header("Expires: 0");
                    header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
                    header("Cache-Control: private",false);
                    header('Content-Type: application/zip');
                    header('Content-disposition: attachment; filename='.$zipname);
                    header('Content-Length:' . filesize($zipname));
                    header('Content-Transfer-Encoding: binary');
                    ob_clean();
                    readfile($zipname);
                    unlink($zipname);
                } else {
                    echo _("Header sent before upload");
                }
                
                /*
                 // We'll be outputting a TXT file
                 header('Content-type: application/octet-stream');
                 
                 // It will be called LIST_101_20090209-121212.txt
                 header("Content-Disposition: attachment; filename=\"$CSVfilename\"");
                 header('Expires: 0');
                 header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
                 header('Pragma: public');
                 ob_clean();
                 flush();
                 
                 echo "$CSV_text";
                 */
                
                exit;
            }
        }
        
        
    }
 
}




?>