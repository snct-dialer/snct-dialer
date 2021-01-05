ALTER TABLE vicidial_automated_reports ADD filename_override VARCHAR(255) default '';
ALTER TABLE vicidial_automated_reports MODIFY report_times VARCHAR(255) default '';

UPDATE system_settings SET db_schema_version='1515',db_schema_update_date=NOW() where db_schema_version < 1515;
