/*
  flexi_auth_database_dump.sql
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tmp_sessions`
-- ----------------------------
DROP TABLE IF EXISTS `tmp_sessions`;
CREATE TABLE `tmp_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(16) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) DEFAULT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text NOT NULL DEFAULT '',
  PRIMARY KEY (`session_id`),
  KEY `last_activity` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tmp_sessions
-- ----------------------------

-- ----------------------------
-- Table structure for `user_accounts`
-- ----------------------------
DROP TABLE IF EXISTS `tmp_user_accounts`;
CREATE TABLE `tmp_user_accounts` (
  `uacc_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uacc_group_fk` smallint(5) unsigned NOT NULL DEFAULT '0',
  `uacc_email` varchar(100) NOT NULL DEFAULT '',
  `uacc_username` varchar(15) NOT NULL DEFAULT '',
  `uacc_password` varchar(60) NOT NULL DEFAULT '',
  `uacc_ip_address` varchar(40) NOT NULL DEFAULT '',
  `uacc_salt` varchar(40) NOT NULL DEFAULT '',
  `uacc_activation_token` varchar(40) NOT NULL DEFAULT '',
  `uacc_forgotten_password_token` varchar(40) NOT NULL DEFAULT '',
  `uacc_forgotten_password_expire` varchar(20) NOT NULL DEFAULT '1358787579',
  `uacc_update_email_token` varchar(40) NOT NULL DEFAULT '',
  `uacc_update_email` varchar(100) NOT NULL DEFAULT '',
  `uacc_active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `uacc_suspend` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `uacc_fail_login_attempts` smallint(5) NOT NULL DEFAULT '0',
  `uacc_fail_login_ip_address` varchar(40) NOT NULL DEFAULT '',
  `uacc_date_fail_login_ban` varchar(20) NOT NULL DEFAULT '1358787579' COMMENT 'Time user is banned until due to repeated failed logins',
  `uacc_date_last_login` varchar(20) NOT NULL DEFAULT '1358787579',
  `uacc_date_added` varchar(20) NOT NULL DEFAULT '1358787579',
  PRIMARY KEY (`uacc_id`),
  UNIQUE KEY `uacc_id` (`uacc_id`),
  KEY `uacc_group_fk` (`uacc_group_fk`),
  KEY `uacc_email` (`uacc_email`),
  KEY `uacc_username` (`uacc_username`),
  KEY `uacc_fail_login_ip_address` (`uacc_fail_login_ip_address`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of user_accounts
-- ----------------------------

-- ----------------------------
-- Table structure for `user_groups`
-- ----------------------------
DROP TABLE IF EXISTS `tmp_user_groups`;
CREATE TABLE `tmp_user_groups` (
  `id` smallint(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '',
  `description` varchar(100) NOT NULL DEFAULT '',
  `admin` int(5) NOT NULL DEFAULT '0',
  `l` int(5) NOT NULL DEFAULT '0',
  `r` int(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for `user_login_sessions`
-- ----------------------------
DROP TABLE IF EXISTS `tmp_user_login_sessions`;
CREATE TABLE `tmp_user_login_sessions` (
  `usess_uacc_fk` int(11) NOT NULL DEFAULT '0',
  `usess_series` varchar(40) NOT NULL DEFAULT '',
  `usess_token` varchar(40) NOT NULL DEFAULT '',
  `usess_login_date` varchar(20) NOT NULL DEFAULT '1358787579',
  PRIMARY KEY (`usess_token`),
  UNIQUE KEY `usess_token` (`usess_token`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of user_login_sessions
-- ----------------------------

-- ----------------------------
-- Table structure for `user_privileges`
-- ----------------------------
DROP TABLE IF EXISTS `tmp_user_privileges`;
CREATE TABLE `tmp_user_privileges` (
  `id` smallint(5) NOT NULL AUTO_INCREMENT,
  `permission` varchar(20) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of user_privileges
-- ----------------------------

-- ----------------------------
-- Table structure for `user_privilege_users`
-- ----------------------------
DROP TABLE IF EXISTS `tmp_permissions`;
CREATE TABLE `tmp_permissions` (
  `id` smallint(5) NOT NULL AUTO_INCREMENT,
  `group` int(11) NOT NULL DEFAULT '0',
  `permission_id` smallint(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`) USING BTREE,
  KEY `group` (`group`),
  KEY `permission_id` (`permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of user_privilege_users
-- ----------------------------


-- ----------------------------
-- Table structure for `user_privilege_groups`
-- ----------------------------

DROP TABLE IF EXISTS `tmp_user_privilege_groups`;
CREATE TABLE `tmp_user_privilege_groups` (
  `upriv_groups_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `upriv_groups_ugrp_fk` smallint(5) unsigned NOT NULL DEFAULT '0',
  `upriv_groups_upriv_fk` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`upriv_groups_id`),
  UNIQUE KEY `upriv_groups_id` (`upriv_groups_id`) USING BTREE,
  KEY `upriv_groups_ugrp_fk` (`upriv_groups_ugrp_fk`),
  KEY `upriv_groups_upriv_fk` (`upriv_groups_upriv_fk`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

-- ----------------------------
-- Records of user_privilege_groups
-- ----------------------------
