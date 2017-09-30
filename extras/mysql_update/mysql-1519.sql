ALTER TABLE system_settings ADD did_system_filter ENUM('0','1') default '0';

CREATE TABLE vicidial_dnccom_scrub_log (
phone_number VARCHAR(18),
scrub_date DATETIME NOT NULL,
flag_invalid ENUM('','0','1') default '',
flag_dnc ENUM('','0','1') default '',
flag_litigator ENUM('','0','1') default '',
full_response VARCHAR(255) default '',
index(phone_number),
index(scrub_date)
) ENGINE=MyISAM;

ALTER TABLE vicidial_dnccom_scrub_log ADD flag_projdnc ENUM('','0','1') default '' AFTER flag_dnc;

UPDATE system_settings SET db_schema_version='1519',db_schema_update_date=NOW() where db_schema_version < 1519;
