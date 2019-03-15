ALTER TABLE vicidial_campaigns ADD max_inbound_calls_outcome ENUM('DEFAULT','ALLOW_AGENTDIRECT','ALLOW_MI_PAUSE','ALLOW_AGENTDIRECT_AND_MI_PAUSE') default 'DEFAULT';
ALTER TABLE vicidial_campaigns ADD manual_auto_next_options ENUM('DEFAULT','PAUSE_NO_COUNT') default 'DEFAULT';

ALTER TABLE contact_information ADD office_num_phone_code VARCHAR(10) COLLATE utf8_unicode_ci DEFAULT '';
ALTER TABLE contact_information ADD cell_num_phone_code VARCHAR(10) COLLATE utf8_unicode_ci DEFAULT '';
ALTER TABLE contact_information ADD other_num1_phone_code VARCHAR(10) COLLATE utf8_unicode_ci DEFAULT '';
ALTER TABLE contact_information ADD other_num2_phone_code VARCHAR(10) COLLATE utf8_unicode_ci DEFAULT '';

ALTER TABLE vicidial_campaigns ADD agent_screen_time_display ENUM('DISABLED','ENABLED_BASIC','ENABLED_FULL','ENABLED_BILL_BREAK_LUNCH_COACH') default 'DISABLED';

ALTER TABLE vicidial_campaigns MODIFY get_call_launch ENUM('NONE','SCRIPT','WEBFORM','WEBFORMTWO','WEBFORMTHREE','FORM','PREVIEW_WEBFORM','PREVIEW_WEBFORMTWO','PREVIEW_WEBFORMTHREE') default 'NONE';

UPDATE system_settings SET db_schema_version='1528',db_schema_update_date=NOW() where db_schema_version < 1528;
