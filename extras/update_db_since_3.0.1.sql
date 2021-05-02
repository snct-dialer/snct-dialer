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

ALTER TABLE `vicidial_list` ADD `selection` VARCHAR(150) NOT NULL;
ALTER TABLE `vicidial_list` ADD `housenr1` VARCHAR(20) NOT NULL;
ALTER TABLE `vicidial_list` ADD `phone_code_alt1` VARCHAR(10) NULL AFTER `ownnd_OptIn_Owner`, ADD `phone_code_alt2` VARCHAR(10) NULL AFTER `phone_code_alt1`, ADD `phone_code_alt3` VARCHAR(10) NULL AFTER `phone_code_alt2`, ADD `alt_phone3` VARCHAR(10) NULL AFTER `phone_code_alt3`, ADD `use_status` ENUM('free','blocked','temporary','full') NOT NULL DEFAULT 'free' AFTER `alt_phone3`, ADD `house_nr2` VARCHAR(20) NULL AFTER `block_status`, ADD `house_nr3` VARCHAR(20) NULL AFTER `house_nr2`;

ALTER TABLE `vicidial_users` ADD `password_sec` VARCHAR(256) NOT NULL;
ALTER TABLE `vicidial_users` ADD `2FA_enable` ENUM('Y','N') NOT NULL DEFAULT 'N';
ALTER TABLE `vicidial_users` ADD `2FA_type` ENUM('SMS','EMail','TOTP') NOT NULL DEFAULT 'TOTP';
ALTER TABLE `vicidial_users` ADD `2FA_Email` VARCHAR(50) NOT NULL;
ALTER TABLE `vicidial_users` ADD `2FA_SMS` VARCHAR(20) NOT NULL;
ALTER TABLE `vicidial_users` ADD `2FA_secret` VARCHAR(250) NOT NULL;

#ALTER TABLE `vicidial_lists` ADD `override_temp_block` ENUM('N','Y') NOT NULL DEFAULT 'N'; 

ALTER TABLE `vicidial_list` ADD INDEX `LastName` (`last_name`);
ALTER TABLE `vicidial_list` ADD INDEX `FirstName` (`first_name`);
ALTER TABLE `vicidial_list` ADD INDEX `City` (`city`); 

CREATE TABLE `snctdialer_lead_selection` ( `ID` BIGINT NOT NULL AUTO_INCREMENT , `selection` VARCHAR(25) NOT NULL , PRIMARY KEY (`ID`)) ENGINE=Aria DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci CHECKSUM=1 PAGE_CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=PAGE TRANSACTIONAL=1; 
ALTER TABLE `vicidial_list` ADD INDEX `address1` (`address1`);
ALTER TABLE `vicidial_list` ADD INDEX `housenr1` (`housenr1`);
ALTER TABLE `vicidial_list` ADD `customer_status` ENUM('unknown','privat','business') NOT NULL DEFAULT 'unknown';
ALTER TABLE `vicidial_list` ADD INDEX `CustStatus` (`customer_status`);
ALTER TABLE `vicidial_list` ADD INDEX `BlockStatus` (`block_status`);
