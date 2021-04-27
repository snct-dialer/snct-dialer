ALTER TABLE `vicidial_campaigns` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL;
ALTER TABLE `dialable_inventory_snapshots` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `twoday_vicidial_agent_log` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `twoday_vicidial_log` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_agent_function_log` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_agent_function_log_archive` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_agent_log` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_agent_log_archive` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_callbacks` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_callbacks_archive` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_callbacks_log` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_campaign_dnc` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL;
ALTER TABLE `vicidial_campaign_hotkeys` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_campaign_hour_counts` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_campaign_hour_counts_archive` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_campaigns_list_mix` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_comments` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL;
ALTER TABLE `vicidial_custom_cid` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT '--ALL--';
ALTER TABLE `vicidial_dnc_log` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL;
ALTER TABLE `vicidial_email_accounts` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_email_log` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_hopper` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_inbound_dids` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_inbound_dids` CHANGE `filter_campaign_id` `filter_campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_lead_recycle` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_lists` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_live_agents` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_log` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_log_archive` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_log_noanswer` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_log_noanswer_archive` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_monitor_log` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_pause_codes` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_pause_codes_gratis` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_qc_agent_log` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL;
ALTER TABLE `vicidial_remote_agents` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_rt_monitor_log` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_rt_monitor_log_archive` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_session_data` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_user_log` CHANGE `campaign_id` `campaign_id` VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL;
ALTER TABLE `vicidial_users` ADD `password_sec` VARCHAR(256) NOT NULL;
ALTER TABLE `vicidial_users` ADD `2FA_enable` ENUM('Y','N') NOT NULL DEFAULT 'N';
ALTER TABLE `vicidial_users` ADD `2FA_type` ENUM('SMS','EMail','TOTP') NOT NULL DEFAULT 'TOTP';
ALTER TABLE `vicidial_users` ADD `2FA_Email` VARCHAR(50) NOT NULL;
ALTER TABLE `vicidial_users` ADD `2FA_SMS` VARCHAR(20) NOT NULL;
ALTER TABLE `vicidial_users` ADD `2FA_secret` VARCHAR(250) NOT NULL;
