ALTER TABLE vicidial_campaigns ADD next_dial_my_callbacks ENUM('DISABLED','ENABLED') default 'DISABLED';

UPDATE system_settings SET db_schema_version='1530',db_schema_update_date=NOW() where db_schema_version < 1530;

