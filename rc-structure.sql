-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 08, 2016 at 03:09 PM
-- Server version: 5.5.47-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `rchc`
--

-- --------------------------------------------------------

--
-- Table structure for table `av_articles`
--

CREATE TABLE IF NOT EXISTS `av_articles` (
  `at_id` int(11) NOT NULL AUTO_INCREMENT,
  `at_title` varchar(255) NOT NULL,
  `at_segment` varchar(255) NOT NULL,
  `at_permalink` tinyint(1) NOT NULL DEFAULT '0',
  `at_image` varchar(255) NOT NULL DEFAULT '',
  `at_show_main_image` tinyint(1) NOT NULL DEFAULT '0',
  `at_summary` varchar(500) NOT NULL,
  `at_keywords` varchar(255) NOT NULL,
  `at_text` text NOT NULL,
  `at_section` int(11) NOT NULL DEFAULT '1',
  `at_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `at_featured` tinyint(1) NOT NULL DEFAULT '0',
  `at_show_author` tinyint(1) NOT NULL DEFAULT '0',
  `at_author` int(11) NOT NULL,
  `at_date_posted` varchar(15) NOT NULL,
  `at_date_updated` varchar(15) NOT NULL,
  `at_private` tinyint(1) NOT NULL DEFAULT '0',
  `at_hits` int(11) NOT NULL,
  PRIMARY KEY (`at_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=101 ;

-- --------------------------------------------------------

--
-- Table structure for table `av_gallery_images`
--

CREATE TABLE IF NOT EXISTS `av_gallery_images` (
  `gi_id` int(11) NOT NULL AUTO_INCREMENT,
  `gi_file` varchar(255) NOT NULL,
  `gi_at_id` int(11) NOT NULL,
  `gi_private` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`gi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `av_rotary_themes`
--

CREATE TABLE IF NOT EXISTS `av_rotary_themes` (
  `mt_id` int(11) NOT NULL AUTO_INCREMENT,
  `mt_name` varchar(100) NOT NULL,
  `mt_description` varchar(255) NOT NULL,
  PRIMARY KEY (`mt_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

-- --------------------------------------------------------

--
-- Table structure for table `av_sections`
--

CREATE TABLE IF NOT EXISTS `av_sections` (
  `sc_id` int(11) NOT NULL AUTO_INCREMENT,
  `sc_name` varchar(255) NOT NULL,
  `sc_value` varchar(255) NOT NULL,
  PRIMARY KEY (`sc_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

-- --------------------------------------------------------

--
-- Table structure for table `av_sessions`
--

CREATE TABLE IF NOT EXISTS `av_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(16) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) DEFAULT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `last_activity` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `av_user_accounts`
--

CREATE TABLE IF NOT EXISTS `av_user_accounts` (
  `uacc_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uacc_group_fk` smallint(5) unsigned NOT NULL DEFAULT '0',
  `uacc_email` varchar(100) NOT NULL DEFAULT '',
  `uacc_username` varchar(15) NOT NULL DEFAULT '',
  `uacc_password` varchar(60) NOT NULL DEFAULT '',
  `uacc_ip_address` varchar(40) NOT NULL DEFAULT '',
  `uacc_salt` varchar(40) NOT NULL DEFAULT '',
  `uacc_activation_token` varchar(40) NOT NULL DEFAULT '',
  `uacc_forgotten_password_token` varchar(40) NOT NULL DEFAULT '',
  `uacc_forgotten_password_expire` varchar(15) NOT NULL DEFAULT '1441283705',
  `uacc_update_email_token` varchar(40) NOT NULL DEFAULT '',
  `uacc_update_email` varchar(100) NOT NULL DEFAULT '',
  `uacc_active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `uacc_suspend` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `uacc_fail_login_attempts` smallint(5) NOT NULL DEFAULT '0',
  `uacc_fail_login_ip_address` varchar(40) NOT NULL DEFAULT '',
  `uacc_date_fail_login_ban` varchar(15) NOT NULL DEFAULT '1441283705' COMMENT 'Time user is banned until due to repeated failed logins',
  `uacc_date_last_login` varchar(15) NOT NULL DEFAULT '1441283705',
  `uacc_date_added` varchar(15) NOT NULL DEFAULT '1441283705',
  PRIMARY KEY (`uacc_id`),
  UNIQUE KEY `uacc_id` (`uacc_id`),
  KEY `uacc_group_fk` (`uacc_group_fk`),
  KEY `uacc_email` (`uacc_email`),
  KEY `uacc_username` (`uacc_username`),
  KEY `uacc_fail_login_ip_address` (`uacc_fail_login_ip_address`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `av_user_address`
--

CREATE TABLE IF NOT EXISTS `av_user_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uacc_fk` int(11) NOT NULL DEFAULT '0',
  `alias` varchar(50) NOT NULL DEFAULT '',
  `recipient` varchar(100) NOT NULL DEFAULT '',
  `phone` varchar(25) NOT NULL DEFAULT '',
  `company` varchar(75) NOT NULL DEFAULT '',
  `address_01` varchar(100) NOT NULL DEFAULT '',
  `address_02` varchar(100) NOT NULL DEFAULT '',
  `city` varchar(50) NOT NULL DEFAULT '',
  `county` varchar(50) NOT NULL DEFAULT '',
  `post_code` varchar(25) NOT NULL DEFAULT '',
  `country` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `uacc_fk` (`uacc_fk`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Table structure for table `av_user_groups`
--

CREATE TABLE IF NOT EXISTS `av_user_groups` (
  `ugrp_id` smallint(5) NOT NULL AUTO_INCREMENT,
  `ugrp_name` varchar(20) NOT NULL DEFAULT '',
  `ugrp_desc` varchar(255) NOT NULL DEFAULT '',
  `ugrp_admin` tinyint(1) NOT NULL DEFAULT '0',
  `l` int(5) NOT NULL,
  `r` int(5) NOT NULL,
  `ugrp_parent` int(11) NOT NULL,
  PRIMARY KEY (`ugrp_id`),
  UNIQUE KEY `ugrp_id` (`ugrp_id`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- Table structure for table `av_user_login_sessions`
--

CREATE TABLE IF NOT EXISTS `av_user_login_sessions` (
  `usess_uacc_fk` int(11) NOT NULL DEFAULT '0',
  `usess_series` varchar(40) NOT NULL DEFAULT '',
  `usess_token` varchar(40) NOT NULL DEFAULT '',
  `usess_login_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`usess_token`),
  UNIQUE KEY `usess_token` (`usess_token`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `av_user_privileges`
--

CREATE TABLE IF NOT EXISTS `av_user_privileges` (
  `upriv_id` smallint(5) NOT NULL AUTO_INCREMENT,
  `upriv_name` varchar(20) NOT NULL DEFAULT '',
  `upriv_desc` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`upriv_id`),
  UNIQUE KEY `upriv_id` (`upriv_id`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

-- --------------------------------------------------------

--
-- Table structure for table `av_user_privilege_groups`
--

CREATE TABLE IF NOT EXISTS `av_user_privilege_groups` (
  `upriv_groups_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `upriv_groups_ugrp_fk` smallint(5) unsigned NOT NULL DEFAULT '0',
  `upriv_groups_upriv_fk` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`upriv_groups_id`),
  UNIQUE KEY `upriv_groups_id` (`upriv_groups_id`) USING BTREE,
  KEY `upriv_groups_ugrp_fk` (`upriv_groups_ugrp_fk`),
  KEY `upriv_groups_upriv_fk` (`upriv_groups_upriv_fk`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=30 ;

-- --------------------------------------------------------

--
-- Table structure for table `av_user_privilege_users`
--

CREATE TABLE IF NOT EXISTS `av_user_privilege_users` (
  `upriv_users_id` smallint(5) NOT NULL AUTO_INCREMENT,
  `upriv_users_uacc_fk` int(11) NOT NULL DEFAULT '0',
  `upriv_users_upriv_fk` smallint(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`upriv_users_id`),
  UNIQUE KEY `upriv_users_id` (`upriv_users_id`) USING BTREE,
  KEY `upriv_users_uacc_fk` (`upriv_users_uacc_fk`),
  KEY `upriv_users_upriv_fk` (`upriv_users_upriv_fk`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

-- --------------------------------------------------------

--
-- Table structure for table `av_user_profiles`
--

CREATE TABLE IF NOT EXISTS `av_user_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uacc_fk` int(11) NOT NULL DEFAULT '0',
  `company` varchar(50) NOT NULL DEFAULT '',
  `first_name` varchar(50) NOT NULL DEFAULT '',
  `last_name` varchar(50) NOT NULL DEFAULT '',
  `phone` varchar(25) NOT NULL DEFAULT '',
  `newsletter` tinyint(1) NOT NULL DEFAULT '0',
  `photo` varchar(255) NOT NULL DEFAULT 'noimage.png',
  `bio` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `uacc_fk` (`uacc_fk`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
