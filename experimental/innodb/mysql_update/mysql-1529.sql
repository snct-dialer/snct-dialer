
CREATE TABLE vicidial_ingroup_hour_counts (
group_id VARCHAR(20),
date_hour DATETIME,
next_hour DATETIME,
last_update DATETIME,
type VARCHAR(22) default 'CALLS',
calls INT(9) UNSIGNED default '0',
hr TINYINT(2) default '0',
index (group_id),
index (date_hour),
unique index vihc_ingr_hour (group_id, date_hour, type)
) ENGINE=InnoDB;

CREATE TABLE vicidial_ingroup_hour_counts_archive LIKE vicidial_ingroup_hour_counts;

ALTER TABLE vicidial_lists ADD default_xfer_group VARCHAR(20) default '---NONE---';

UPDATE system_settings SET db_schema_version='1529',db_schema_update_date=NOW() where db_schema_version < 1529;
