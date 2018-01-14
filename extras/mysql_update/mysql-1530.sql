ALTER TABLE vicidial_campaigns ADD next_dial_my_callbacks ENUM('DISABLED','ENABLED') default 'DISABLED';
ALTER TABLE system_settings ADD anyone_callback_inactive_lists ENUM('default','NO_ADD_TO_HOPPER','KEEP_IN_HOPPER') default 'default';

UPDATE system_settings SET db_schema_version='1530',db_schema_update_date=NOW() where db_schema_version < 1530;

