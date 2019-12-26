-- MySQL dump 10.13  Distrib 8.0.13, for Linux (x86_64)
--
-- Host: localhost    Database: borna
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bans`
--

DROP TABLE IF EXISTS `bans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `bans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bannable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bannable_id` bigint(20) unsigned NOT NULL,
  `created_by_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` bigint(20) unsigned DEFAULT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci,
  `expired_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bans_bannable_type_bannable_id_index` (`bannable_type`,`bannable_id`),
  KEY `bans_created_by_type_created_by_id_index` (`created_by_type`,`created_by_id`),
  KEY `bans_expired_at_index` (`expired_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bans`
--

LOCK TABLES `bans` WRITE;
/*!40000 ALTER TABLE `bans` DISABLE KEYS */;
/*!40000 ALTER TABLE `bans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `order` int(11) DEFAULT '1',
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hash` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categories_parent_id_foreign` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,0,1,'General','',NULL,'2018-10-27 05:27:59','2018-10-27 05:27:59');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_pricing_model`
--

DROP TABLE IF EXISTS `category_pricing_model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `category_pricing_model` (
  `category_id` int(11) DEFAULT NULL,
  `pricing_model_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_pricing_model`
--

LOCK TABLES `category_pricing_model` WRITE;
/*!40000 ALTER TABLE `category_pricing_model` DISABLE KEYS */;
INSERT INTO `category_pricing_model` VALUES (1,1);
/*!40000 ALTER TABLE `category_pricing_model` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `comments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `listing_id` int(11) DEFAULT NULL,
  `seller_id` int(11) DEFAULT NULL,
  `commenter_id` int(11) DEFAULT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `approved` tinyint(1) NOT NULL DEFAULT '1',
  `rate` double(15,8) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_commentable_id_commentable_type_index` (`listing_id`),
  KEY `comments_commented_id_commented_type_index` (`commenter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conversations`
--

DROP TABLE IF EXISTS `conversations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `conversations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_one` int(11) NOT NULL,
  `user_two` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversations`
--

LOCK TABLES `conversations` WRITE;
/*!40000 ALTER TABLE `conversations` DISABLE KEYS */;
INSERT INTO `conversations` VALUES (1,1,2,1,'2018-11-02 17:53:07','2018-11-02 17:53:08');
/*!40000 ALTER TABLE `conversations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_files`
--

DROP TABLE IF EXISTS `custom_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `custom_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `contents` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_files`
--

LOCK TABLES `custom_files` WRITE;
/*!40000 ALTER TABLE `custom_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `favorites` (
  `user_id` int(10) unsigned NOT NULL,
  `favoriteable_id` int(10) unsigned NOT NULL,
  `favoriteable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`,`favoriteable_id`,`favoriteable_type`),
  KEY `favorites_favoriteable_id_favoriteable_type_index` (`favoriteable_id`,`favoriteable_type`),
  KEY `favorites_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
INSERT INTO `favorites` VALUES (2,1,'App\\Models\\Listing','2018-11-02 17:55:06','2018-11-02 17:55:06');
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filters`
--

DROP TABLE IF EXISTS `filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `filters` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `position` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `search_ui` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `form_input_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `form_input_meta` text COLLATE utf8mb4_unicode_ci,
  `is_category_specific` tinyint(1) DEFAULT '0',
  `is_searchable` tinyint(1) DEFAULT '0',
  `is_hidden` tinyint(1) DEFAULT '0',
  `is_default` tinyint(1) DEFAULT '0',
  `categories` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filters`
--

LOCK TABLES `filters` WRITE;
/*!40000 ALTER TABLE `filters` DISABLE KEYS */;
INSERT INTO `filters` VALUES (1,3,'Price','price','priceRange',NULL,NULL,0,1,0,1,NULL,'2018-10-27 05:27:59','2018-10-27 05:27:59'),(2,2,'Categories','category_id','category',NULL,NULL,NULL,1,0,1,'[]','2018-10-27 05:27:59','2018-10-27 05:27:59'),(3,1,'Distance','distance','distance',NULL,NULL,0,1,0,1,NULL,'2018-10-27 05:27:59','2018-10-27 05:27:59');
/*!40000 ALTER TABLE `filters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `followables`
--

DROP TABLE IF EXISTS `followables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `followables` (
  `user_id` int(10) unsigned NOT NULL,
  `followable_id` int(10) unsigned NOT NULL,
  `followable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `relation` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'follow' COMMENT 'follow/like/subscribe/favorite/upvote/downvote',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `followables_user_id_foreign` (`user_id`),
  KEY `followables_followable_type_index` (`followable_type`),
  CONSTRAINT `followables_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `followables`
--

LOCK TABLES `followables` WRITE;
/*!40000 ALTER TABLE `followables` DISABLE KEYS */;
/*!40000 ALTER TABLE `followables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listing_additional_options`
--

DROP TABLE IF EXISTS `listing_additional_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `listing_additional_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `listing_id` int(11) DEFAULT NULL,
  `price` decimal(11,2) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` int(11) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listing_additional_options`
--

LOCK TABLES `listing_additional_options` WRITE;
/*!40000 ALTER TABLE `listing_additional_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `listing_additional_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listing_booked_dates`
--

DROP TABLE IF EXISTS `listing_booked_dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `listing_booked_dates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `listing_id` int(11) DEFAULT NULL,
  `booked_date` date DEFAULT NULL,
  `quantity` int(11) DEFAULT '0',
  `available_units` int(11) DEFAULT NULL,
  `is_available` tinyint(1) DEFAULT NULL,
  `price` decimal(11,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listing_booked_dates`
--

LOCK TABLES `listing_booked_dates` WRITE;
/*!40000 ALTER TABLE `listing_booked_dates` DISABLE KEYS */;
/*!40000 ALTER TABLE `listing_booked_dates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listing_booked_times`
--

DROP TABLE IF EXISTS `listing_booked_times`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `listing_booked_times` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `listing_id` int(11) DEFAULT NULL,
  `booked_date` datetime DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `duration` int(11) DEFAULT '0',
  `quantity` int(11) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listing_booked_times`
--

LOCK TABLES `listing_booked_times` WRITE;
/*!40000 ALTER TABLE `listing_booked_times` DISABLE KEYS */;
/*!40000 ALTER TABLE `listing_booked_times` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listing_plan_payments`
--

DROP TABLE IF EXISTS `listing_plan_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `listing_plan_payments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `listing_id` int(11) DEFAULT NULL,
  `listing_plan_id` int(11) DEFAULT NULL,
  `started_at` datetime DEFAULT NULL,
  `ends_at` datetime DEFAULT NULL,
  `meta` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listing_plan_payments`
--

LOCK TABLES `listing_plan_payments` WRITE;
/*!40000 ALTER TABLE `listing_plan_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `listing_plan_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listing_plans`
--

DROP TABLE IF EXISTS `listing_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `listing_plans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `group` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `price` decimal(11,2) DEFAULT NULL,
  `credits` int(11) DEFAULT NULL,
  `duration_units` int(11) DEFAULT '1',
  `duration_period` enum('hour','day','week','month','year') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'week',
  `images` int(11) DEFAULT '1',
  `spotlight` tinyint(1) DEFAULT '1',
  `priority` tinyint(1) DEFAULT '1',
  `bold` tinyint(1) DEFAULT '1',
  `category_id` int(11) DEFAULT '1',
  `min_price` int(11) DEFAULT '1',
  `max_price` int(11) DEFAULT '1',
  `meta` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listing_plans`
--

LOCK TABLES `listing_plans` WRITE;
/*!40000 ALTER TABLE `listing_plans` DISABLE KEYS */;
INSERT INTO `listing_plans` VALUES (1,'Free',NULL,NULL,0.00,0,1,'week',1,1,1,0,NULL,NULL,NULL,NULL,'2018-09-10 15:39:04','2018-09-19 15:14:32',NULL),(2,'Standard',NULL,'2x more views than Basic adverts',9.95,90,3,'week',20,1,0,0,NULL,NULL,NULL,NULL,'2018-09-10 15:40:49','2018-09-19 15:02:35',NULL),(3,'Premium',NULL,'4x more views than Basic adverts',19.95,180,6,'week',20,1,1,0,NULL,NULL,NULL,NULL,'2018-09-19 10:35:56','2018-09-19 15:03:43',NULL);
/*!40000 ALTER TABLE `listing_plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listing_services`
--

DROP TABLE IF EXISTS `listing_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `listing_services` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `listing_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `duration` int(11) DEFAULT '0',
  `price` decimal(11,2) DEFAULT '0.00',
  `stock` int(11) DEFAULT '0',
  `position` int(11) DEFAULT '0',
  `meta` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listing_services`
--

LOCK TABLES `listing_services` WRITE;
/*!40000 ALTER TABLE `listing_services` DISABLE KEYS */;
/*!40000 ALTER TABLE `listing_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listing_shipping_options`
--

DROP TABLE IF EXISTS `listing_shipping_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `listing_shipping_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `listing_id` int(11) DEFAULT NULL,
  `price` decimal(11,2) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` int(11) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listing_shipping_options`
--

LOCK TABLES `listing_shipping_options` WRITE;
/*!40000 ALTER TABLE `listing_shipping_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `listing_shipping_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listing_variants`
--

DROP TABLE IF EXISTS `listing_variants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `listing_variants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `listing_id` int(11) DEFAULT NULL,
  `price` decimal(11,2) DEFAULT '0.00',
  `stock` int(11) DEFAULT '0',
  `meta` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listing_variants`
--

LOCK TABLES `listing_variants` WRITE;
/*!40000 ALTER TABLE `listing_variants` DISABLE KEYS */;
/*!40000 ALTER TABLE `listing_variants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listings`
--

DROP TABLE IF EXISTS `listings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `listings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `pricing_model_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `blurb` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int(11) DEFAULT '0',
  `stock` int(11) DEFAULT '1',
  `photos` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `spotlight` datetime DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `priority_until` datetime DEFAULT NULL,
  `bold_until` datetime DEFAULT NULL,
  `staff_pick` tinyint(1) DEFAULT NULL,
  `views_count` int(11) DEFAULT NULL,
  `unit` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `min_units` int(11) DEFAULT '1',
  `max_units` int(11) DEFAULT NULL,
  `min_duration` int(11) DEFAULT NULL,
  `max_duration` int(11) DEFAULT NULL,
  `session_duration` int(11) DEFAULT NULL,
  `pricing_models` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(11,2) DEFAULT NULL,
  `price_ex_vat` decimal(11,2) DEFAULT NULL,
  `currency` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` point DEFAULT NULL,
  `lat` decimal(10,8) DEFAULT NULL,
  `lng` decimal(11,8) DEFAULT NULL,
  `meta` text COLLATE utf8mb4_unicode_ci,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seller_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `variant_options` text COLLATE utf8mb4_unicode_ci,
  `vendor` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timeslots` text COLLATE utf8mb4_unicode_ci,
  `photos_limit` int(11) DEFAULT NULL,
  `tags` text COLLATE utf8mb4_unicode_ci,
  `tags_string` text COLLATE utf8mb4_unicode_ci,
  `units_in_product_display` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_per_unit_display` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `locale` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT 'en',
  `is_private` tinyint(1) DEFAULT '0',
  `is_published` tinyint(1) DEFAULT '0',
  `is_draft` tinyint(1) NOT NULL DEFAULT '0',
  `is_admin_verified` datetime DEFAULT NULL,
  `is_disabled` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listings`
--

LOCK TABLES `listings` WRITE;
/*!40000 ALTER TABLE `listings` DISABLE KEYS */;
INSERT INTO `listings` VALUES (1,NULL,1,1,'1','My First Listing',NULL,NULL,0,1,'{\"1\":\"https://marketplace-kit.s3.amazonaws.com/default_listing.jpg\"}','<p>Welcome to MarketPlaceKit. This is your first listing. Edit or delete it, then start add listings!</p><p><br></p><p class=\"ql-align-justify\">\"The buyer is entitled to a bargain. The seller is entitled to a profit. So there is a fine margin in between where the price is right. I have found this to be true to this day whether dealing in paper hats, winter underwear or hotels.\"</p><p class=\"ql-align-justify\">-  <span>Conrad Hilton</span></p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'buy',15.00,NULL,'GBP',_binary '\0\0\0\0\0\0\0\�oN\�u%��0�AC�I@',51.61100420,-0.10213410,'[]','London','UK',NULL,'{\"Primary colour\": [\"Blue\", \"Red\", \"Green\"], \"Size\": [\"XL\", \"XS\", \"SM\"]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',0,1,0,'2018-10-27 05:27:58',NULL,'2018-10-27 05:27:58','2018-10-27 12:55:42',NULL),(2,NULL,3,1,'1','swssa',NULL,NULL,0,1,NULL,'<p>asasasas</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'GBP',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',0.00000000,0.00000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',0,0,0,NULL,NULL,'2018-11-04 20:07:53','2018-11-04 20:07:53',NULL),(3,NULL,8,1,'1','ttttjnkjknnjknkj',NULL,NULL,0,1,NULL,'<p>tdsdfsdfsdfdsf</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'GBP',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',0.00000000,0.00000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',0,0,0,NULL,NULL,'2018-12-04 21:53:02','2018-12-04 21:53:02',NULL),(4,NULL,8,NULL,NULL,'بییبیبیب',NULL,NULL,0,1,NULL,'<p>یییییییییییییییییییییییییییییییییی</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'GBP',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',0.00000000,0.00000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',0,0,0,NULL,NULL,'2018-12-04 22:06:03','2018-12-04 22:06:03',NULL),(5,NULL,8,NULL,NULL,'بییبیبیب',NULL,NULL,0,1,NULL,'<p>یییییییییییییییییییییییییییییییییی</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'GBP',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',0.00000000,0.00000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',0,0,0,NULL,NULL,'2018-12-04 22:06:07','2018-12-04 22:06:07',NULL),(6,NULL,8,NULL,NULL,'بییبیبیب',NULL,NULL,0,1,NULL,'<p>یییییییییییییییییییییییییییییییییی</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'GBP',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',0.00000000,0.00000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',0,0,0,NULL,NULL,'2018-12-04 22:06:12','2018-12-04 22:06:12',NULL),(7,NULL,8,NULL,NULL,'بلبلبی',NULL,NULL,0,1,NULL,'<p>یبلیبلیبلیبلی</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'GBP',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',0.00000000,0.00000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',0,0,0,NULL,NULL,'2018-12-04 22:06:29','2018-12-04 22:06:29',NULL),(8,NULL,8,NULL,NULL,'بلبلبی',NULL,NULL,0,1,NULL,'<p>یبلیبلیبلیبلی</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'GBP',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',0.00000000,0.00000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',0,0,0,NULL,NULL,'2018-12-04 22:06:32','2018-12-04 22:06:32',NULL),(9,NULL,8,NULL,NULL,'یللیبل',NULL,NULL,0,1,NULL,'<p>یللییللیبیلیل</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'GBP',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',0.00000000,0.00000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',0,0,0,NULL,NULL,'2018-12-04 22:06:47','2018-12-04 22:06:47',NULL),(10,NULL,8,NULL,NULL,'یللیبل',NULL,NULL,0,1,NULL,'<p>یللییللیبیلیل</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'GBP',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',0.00000000,0.00000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',0,0,0,NULL,NULL,'2018-12-04 22:06:49','2018-12-04 22:06:49',NULL),(11,NULL,8,1,'1','شیسشسیشیس',NULL,NULL,0,1,NULL,'<p>شیسشسیشیس</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'GBP',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',0.00000000,0.00000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',0,0,0,NULL,NULL,'2018-12-04 22:07:37','2018-12-04 22:07:37',NULL),(12,NULL,8,1,'1','سبیسبیبس',NULL,NULL,0,1,NULL,'<p>سبیسبسبی</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'GBP',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',0.00000000,0.00000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',0,0,0,NULL,NULL,'2018-12-04 22:09:22','2018-12-04 22:09:22',NULL),(13,NULL,8,1,'1','شسیشیشیسیشس',NULL,NULL,0,1,NULL,'<p>شیسشیسشیسسسسس</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,0.00,NULL,'GBP',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',0.00000000,0.00000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',0,1,0,'2018-12-04 22:12:54',NULL,'2018-12-04 22:11:14','2018-12-04 22:12:54',NULL),(14,NULL,8,1,'1','dsdffsd',NULL,NULL,0,1,NULL,'<p>fsdsfdsdffsd</p>',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'GBP',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',0.00000000,0.00000000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'en',0,1,0,'2018-12-04 22:35:53',NULL,'2018-12-04 22:15:22','2018-12-04 22:35:53',NULL);
/*!40000 ALTER TABLE `listings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ltm_translations`
--

DROP TABLE IF EXISTS `ltm_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ltm_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` int(11) NOT NULL DEFAULT '0',
  `locale` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `group` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ltm_translations`
--

LOCK TABLES `ltm_translations` WRITE;
/*!40000 ALTER TABLE `ltm_translations` DISABLE KEYS */;
INSERT INTO `ltm_translations` VALUES (1,0,'en','_json','List something',NULL,'2018-11-19 17:16:20','2018-11-19 17:16:20'),(2,0,'en','_json','Post an announcement',NULL,'2018-11-19 17:16:20','2018-11-19 17:16:20'),(3,0,'en','_json','unit',NULL,'2018-11-19 17:16:20','2018-11-19 17:16:20'),(4,0,'en','_json','unit_plural',NULL,'2018-11-19 17:16:20','2018-11-19 17:16:20'),(5,0,'en','_json','_plural',NULL,'2018-11-19 17:16:20','2018-11-19 17:16:20'),(6,0,'en','_json','Buy',NULL,'2018-11-19 17:16:20','2018-11-19 17:16:20'),(7,0,'en','_json','Sell something',NULL,'2018-11-19 17:16:20','2018-11-19 17:16:20'),(8,0,'en','_json','item',NULL,'2018-11-19 17:16:21','2018-11-19 17:16:21'),(9,0,'en','_json','item_plural',NULL,'2018-11-19 17:16:21','2018-11-19 17:16:21'),(10,0,'en','_json','Book Room',NULL,'2018-11-19 17:16:21','2018-11-19 17:16:21'),(11,0,'en','_json','Rent room',NULL,'2018-11-19 17:16:21','2018-11-19 17:16:21'),(12,0,'en','_json','room',NULL,'2018-11-19 17:16:21','2018-11-19 17:16:21'),(13,0,'en','_json','room_plural',NULL,'2018-11-19 17:16:21','2018-11-19 17:16:21'),(14,0,'en','_json','night',NULL,'2018-11-19 17:16:21','2018-11-19 17:16:21'),(15,0,'en','_json','night_plural',NULL,'2018-11-19 17:16:21','2018-11-19 17:16:21'),(16,0,'en','_json','Book Session',NULL,'2018-11-19 17:16:22','2018-11-19 17:16:22'),(17,0,'en','_json','List your service',NULL,'2018-11-19 17:16:22','2018-11-19 17:16:22'),(18,0,'en','_json','place',NULL,'2018-11-19 17:16:22','2018-11-19 17:16:22'),(19,0,'en','_json','place_plural',NULL,'2018-11-19 17:16:22','2018-11-19 17:16:22'),(20,0,'en','_json','session',NULL,'2018-11-19 17:16:23','2018-11-19 17:16:23'),(21,0,'en','_json','session_plural',NULL,'2018-11-19 17:16:23','2018-11-19 17:16:23'),(22,0,'en','_json','Rent Item',NULL,'2018-11-19 17:16:23','2018-11-19 17:16:23'),(23,0,'en','_json','Rent an item',NULL,'2018-11-19 17:16:23','2018-11-19 17:16:23'),(24,0,'en','_json','day',NULL,'2018-11-19 17:16:24','2018-11-19 17:16:24'),(25,0,'en','_json','day_plural',NULL,'2018-11-19 17:16:24','2018-11-19 17:16:24'),(26,0,'en','_json','Request',NULL,'2018-11-19 17:16:24','2018-11-19 17:16:24');
/*!40000 ALTER TABLE `ltm_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `menus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `locale` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `items` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES (3,'en','top','[{\"url\":\"\\/pages\\/about\",\"title\":\"About\",\"position\":2},{\"url\":\"\\/pages\\/help\",\"title\":\"Help\",\"position\":3},{\"url\":\"\\/contact\",\"title\":\"Contact\",\"position\":4}]','2018-10-27 05:27:59','2018-10-27 05:27:59');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_seen` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_from_sender` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_from_receiver` tinyint(1) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL,
  `conversation_id` int(11) NOT NULL,
  `attachments` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,'test',1,0,0,2,1,NULL,'2018-11-02 17:53:08','2018-11-02 21:03:27');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meta_attributes`
--

DROP TABLE IF EXISTS `meta_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `meta_attributes` (
  `meta_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `meta_key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'string',
  `meta_group` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `metable_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`meta_id`),
  KEY `meta_attributes_metable_type_metable_id_index` (`metable_type`,`metable_id`),
  KEY `meta_attributes_meta_key_index` (`meta_key`),
  KEY `meta_attributes_index_value` (`meta_key`,`meta_value`(20))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meta_attributes`
--

LOCK TABLES `meta_attributes` WRITE;
/*!40000 ALTER TABLE `meta_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `meta_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2016_08_15_185912_create_plans_table',1),(2,'2016_08_15_190000_create_plan_features_table',1),(3,'2016_08_15_190033_create_plan_subscriptions_table',1),(4,'2016_08_15_190045_create_plan_subscription_usages_table',1),(5,'2017_03_04_000000_create_bans_table',1),(6,'2018_05_03_154820_create_categories_table',1),(7,'2018_05_03_154820_create_category_pricing_model_table',1),(8,'2018_05_03_154820_create_comments_table',1),(9,'2018_05_03_154820_create_conversations_table',1),(10,'2018_05_03_154820_create_favorites_table',1),(11,'2018_05_03_154820_create_filters_table',1),(12,'2018_05_03_154820_create_listing_additional_options_table',1),(13,'2018_05_03_154820_create_listing_booked_dates_table',1),(14,'2018_05_03_154820_create_listing_booked_times_table',1),(15,'2018_05_03_154820_create_listing_shipping_options_table',1),(16,'2018_05_03_154820_create_listing_variants_table',1),(17,'2018_05_03_154820_create_listings_table',1),(18,'2018_05_03_154820_create_ltm_translations_table',1),(19,'2018_05_03_154820_create_menus_table',1),(20,'2018_05_03_154820_create_messages_table',1),(21,'2018_05_03_154820_create_meta_attributes_table',1),(22,'2018_05_03_154820_create_orders_meta_table',1),(23,'2018_05_03_154820_create_orders_table',1),(24,'2018_05_03_154820_create_page_translations_table',1),(25,'2018_05_03_154820_create_pages_table',1),(26,'2018_05_03_154820_create_password_resets_table',1),(27,'2018_05_03_154820_create_payment_gateways_table',1),(28,'2018_05_03_154820_create_pricing_models_table',1),(29,'2018_05_03_154820_create_settings_table',1),(30,'2018_05_03_154820_create_users_meta_table',1),(31,'2018_05_03_154820_create_users_table',1),(32,'2018_05_03_154820_create_widgets_table',1),(33,'2018_05_03_154821_add_foreign_keys_to_users_meta_table',1),(34,'2018_06_29_032244_create_laravel_follow_tables',1),(35,'2018_07_05_090301_create_permission_tables',1),(36,'2018_07_05_152234_create_reported_listings_table',1),(37,'2018_07_21_151624_create_sessions_table',1),(38,'2018_07_23_123320_add_multiple_services_to_pricing_models',1),(39,'2018_07_23_144840_create_listing_services_table',1),(40,'2018_07_24_121759_add_duration_to_listing_booked_times',1),(41,'2018_08_28_160404_create_custom_files_table',1),(42,'2018_09_07_114850_add_trader_type_to_users_table',1),(43,'2018_09_07_114913_create_listing_plans',1),(44,'2018_09_07_114919_create_listing_plan_payments',1),(45,'2018_09_07_114926_create_payments',1),(46,'2018_09_10_145759_add_priority_to_listings_table',1),(47,'2018_09_19_192916_add_ip_to_orders_table',1),(48,'2018_09_20_113000_create_wallets_table',1),(49,'2018_09_20_113500_create_wallet_transactions_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `model_has_permissions` (
  `permission_id` int(10) unsigned NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_type_model_id_index` (`model_type`,`model_id`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_permissions`
--

LOCK TABLES `model_has_permissions` WRITE;
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `model_has_roles` (
  `role_id` int(10) unsigned NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_type_model_id_index` (`model_type`,`model_id`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_roles`
--

LOCK TABLES `model_has_roles` WRITE;
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
INSERT INTO `model_has_roles` VALUES (4,'App\\Models\\User',1),(1,'App\\Models\\User',2),(1,'App\\Models\\User',3),(1,'App\\Models\\User',4),(1,'App\\Models\\User',5),(1,'App\\Models\\User',6),(1,'App\\Models\\User',7),(1,'App\\Models\\User',8),(1,'App\\Models\\User',9),(1,'App\\Models\\User',10);
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `listing_id` int(11) DEFAULT NULL,
  `seller_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'open',
  `amount` decimal(11,2) DEFAULT NULL,
  `service_fee` decimal(11,2) DEFAULT '0.00',
  `currency` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `units` int(11) DEFAULT NULL,
  `payment_gateway_id` int(11) DEFAULT NULL,
  `processor` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `authorization_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `capture_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `refund_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token` text COLLATE utf8mb4_unicode_ci,
  `listing_options` text COLLATE utf8mb4_unicode_ci,
  `choices` text COLLATE utf8mb4_unicode_ci,
  `customer_details` text COLLATE utf8mb4_unicode_ci,
  `accepted_at` datetime DEFAULT NULL,
  `declined_at` datetime DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `ip_address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_meta`
--

DROP TABLE IF EXISTS `orders_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `orders_meta` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'null',
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_meta`
--

LOCK TABLES `orders_meta` WRITE;
/*!40000 ALTER TABLE `orders_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_translations`
--

DROP TABLE IF EXISTS `page_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `page_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `locale` char(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `seo_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seo_meta_description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seo_meta_keywords` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `published_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_translations`
--

LOCK TABLES `page_translations` WRITE;
/*!40000 ALTER TABLE `page_translations` DISABLE KEYS */;
INSERT INTO `page_translations` VALUES (1,'en','Home','',NULL,'Home',NULL,NULL,1,NULL,'2018-10-27 05:27:58','2018-10-27 05:27:58',NULL),(2,'en','Help','help','<h4>What is this marketplace about?</h4>\n<p>Tell the user what the website is about</p>\n<h4>What can I sell?</h4>\n<p>Tell sellers what how they can use the website</p>\n<h4>What can I buy?</h4>\n<p>Tell buyers how they can use the website</p>','For sale','For sale meta','houses for sale, yes',1,NULL,'2018-10-27 05:27:58','2018-10-27 05:27:58',NULL),(3,'en','About us','about','<p>Enter your about us text here</p>',NULL,NULL,NULL,1,NULL,'2018-10-27 05:27:58','2018-10-27 05:27:58',NULL),(4,'en','Terms and conditions','terms-and-conditions','<p>Enter your terms and conditions here.</p>','Terms and conditions',NULL,NULL,1,NULL,'2018-10-27 05:27:58','2018-10-27 05:27:58',NULL),(5,'en','Privacy policy','privacy-policy','<p>Enter your privacy policy here</p>','Privacy policy',NULL,NULL,1,NULL,'2018-10-27 05:27:58','2018-10-27 05:27:58',NULL);
/*!40000 ALTER TABLE `page_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `template` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_gateways`
--

DROP TABLE IF EXISTS `payment_gateways`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `payment_gateways` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metadata` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_gateways`
--

LOCK TABLES `payment_gateways` WRITE;
/*!40000 ALTER TABLE `payment_gateways` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_gateways` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `payments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `processor` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `currency` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payable_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payments_payable_type_payable_id_index` (`payable_type`,`payable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'edit listing','web','2018-10-27 05:27:54','2018-10-27 05:27:54'),(2,'publish listing','web','2018-10-27 05:27:54','2018-10-27 05:27:54'),(3,'unpublish listing','web','2018-10-27 05:27:54','2018-10-27 05:27:54'),(4,'disable listing','web','2018-10-27 05:27:55','2018-10-27 05:27:55'),(5,'ban user','web','2018-10-27 05:27:55','2018-10-27 05:27:55');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plan_features`
--

DROP TABLE IF EXISTS `plan_features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `plan_features` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `plan_id` int(10) unsigned NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_order` smallint(6) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plan_features_plan_id_code_unique` (`plan_id`,`code`),
  CONSTRAINT `plan_features_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan_features`
--

LOCK TABLES `plan_features` WRITE;
/*!40000 ALTER TABLE `plan_features` DISABLE KEYS */;
INSERT INTO `plan_features` VALUES (1,1,'listings','1',1,'2018-09-11 15:28:59','2018-09-11 15:28:59'),(2,1,'images','1',5,'2018-09-11 15:28:59','2018-09-11 15:28:59'),(3,1,'featured_listings','0',15,'2018-09-11 15:28:59','2018-09-11 15:28:59'),(4,1,'messages','3',20,'2018-09-11 15:28:59','2018-09-11 15:28:59'),(5,1,'bold_listings','0',25,'2018-09-11 15:28:59','2018-09-11 15:28:59'),(6,2,'listings','10',1,'2018-09-11 15:29:28','2018-09-11 15:29:28'),(7,2,'images','10',5,'2018-09-11 15:29:28','2018-09-11 15:29:28'),(8,2,'featured_listings','2',15,'2018-09-11 15:29:28','2018-09-11 15:29:28'),(9,2,'messages','30',20,'2018-09-11 15:29:28','2018-09-11 15:29:28'),(10,2,'bold_listings','2',25,'2018-09-11 15:29:28','2018-09-11 15:29:28'),(11,3,'listings','100',1,'2018-09-11 15:29:52','2018-09-11 15:30:03'),(12,3,'images','20',5,'2018-09-11 15:29:52','2018-09-11 15:29:52'),(13,3,'featured_listings','10',15,'2018-09-11 15:29:52','2018-09-11 15:29:52'),(14,3,'messages','300',20,'2018-09-11 15:29:52','2018-09-11 15:29:52'),(15,3,'bold_listings','10',25,'2018-09-11 15:29:52','2018-09-11 15:29:52');
/*!40000 ALTER TABLE `plan_features` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plan_subscription_usages`
--

DROP TABLE IF EXISTS `plan_subscription_usages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `plan_subscription_usages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `subscription_id` int(10) unsigned NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `used` smallint(5) unsigned NOT NULL,
  `valid_until` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plan_subscription_usages_subscription_id_code_unique` (`subscription_id`,`code`),
  CONSTRAINT `plan_subscription_usages_subscription_id_foreign` FOREIGN KEY (`subscription_id`) REFERENCES `plan_subscriptions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan_subscription_usages`
--

LOCK TABLES `plan_subscription_usages` WRITE;
/*!40000 ALTER TABLE `plan_subscription_usages` DISABLE KEYS */;
/*!40000 ALTER TABLE `plan_subscription_usages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plan_subscriptions`
--

DROP TABLE IF EXISTS `plan_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `plan_subscriptions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `subscribable_id` int(10) unsigned NOT NULL,
  `subscribable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `plan_id` int(10) unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `canceled_immediately` tinyint(1) DEFAULT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `starts_at` timestamp NULL DEFAULT NULL,
  `ends_at` timestamp NULL DEFAULT NULL,
  `canceled_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plan_subscriptions_plan_id_foreign` (`plan_id`),
  KEY `plan_subscriptions_subscribable_id_index` (`subscribable_id`),
  KEY `plan_subscriptions_subscribable_type_index` (`subscribable_type`),
  CONSTRAINT `plan_subscriptions_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan_subscriptions`
--

LOCK TABLES `plan_subscriptions` WRITE;
/*!40000 ALTER TABLE `plan_subscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `plan_subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plans`
--

DROP TABLE IF EXISTS `plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `plans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `price` decimal(7,2) NOT NULL DEFAULT '0.00',
  `interval` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'month',
  `interval_count` smallint(6) NOT NULL DEFAULT '1',
  `trial_period_days` smallint(6) DEFAULT NULL,
  `sort_order` smallint(6) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plans`
--

LOCK TABLES `plans` WRITE;
/*!40000 ALTER TABLE `plans` DISABLE KEYS */;
INSERT INTO `plans` VALUES (1,'Free',NULL,0.00,'month',1,0,NULL,'2018-09-11 15:28:59','2018-09-19 19:55:48'),(2,'Standard',NULL,14.99,'month',1,0,NULL,'2018-09-11 15:29:28','2018-09-11 15:29:28'),(3,'Business',NULL,49.99,'month',1,0,NULL,'2018-09-11 15:29:52','2018-09-11 15:29:52');
/*!40000 ALTER TABLE `plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pricing_models`
--

DROP TABLE IF EXISTS `pricing_models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `pricing_models` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seller_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `widget` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unit_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `duration_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price_display` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'unit' COMMENT 'unit/duration',
  `breakdown_display` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'unit' COMMENT 'unit/duration',
  `quantity_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'quantity',
  `can_accept_payments` tinyint(1) DEFAULT '0',
  `can_add_variants` tinyint(1) DEFAULT '0',
  `can_add_shipping` tinyint(1) DEFAULT '0',
  `can_add_pricing` tinyint(1) DEFAULT '0',
  `can_add_additional_pricing` tinyint(1) DEFAULT '0',
  `requires_shipping_address` tinyint(1) DEFAULT '0',
  `requires_billing_address` tinyint(1) DEFAULT '0',
  `meta` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `can_list_multiple_services` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pricing_models`
--

LOCK TABLES `pricing_models` WRITE;
/*!40000 ALTER TABLE `pricing_models` DISABLE KEYS */;
INSERT INTO `pricing_models` VALUES (1,'List something','Post an announcement','request','unit',NULL,'unit','unit','quantity',0,0,0,0,0,0,0,NULL,'2018-10-27 05:27:59','2018-10-27 05:27:59',0),(2,'Buy','Sell something','buy','item',NULL,'unit','unit','quantity',1,1,1,1,1,0,0,NULL,'2018-10-27 05:27:59','2018-10-27 05:27:59',0),(3,'Book Room','Rent room','book_date','room','night','unit','unit','Rooms',1,0,0,1,1,0,0,NULL,'2018-10-27 05:27:59','2018-10-27 05:27:59',0),(4,'Book Session','List your service','book_time','place','session','duration','unit','Spaces per session',0,0,0,0,0,0,0,NULL,'2018-10-27 05:27:59','2018-10-27 05:27:59',0),(5,'Rent Item','Rent an item','book_date','item','day','duration','unit','inventory',1,0,0,1,1,0,0,NULL,'2018-10-27 05:27:59','2018-10-27 05:27:59',0),(6,'Request','Request','request',NULL,NULL,'unit','unit','quantity',0,0,0,0,0,0,0,NULL,'2018-10-27 05:27:59','2018-10-27 05:27:59',0);
/*!40000 ALTER TABLE `pricing_models` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reported_listings`
--

DROP TABLE IF EXISTS `reported_listings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `reported_listings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `listing_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `reason` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `moderator_id` int(11) DEFAULT NULL,
  `moderator_message` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reported_listings`
--

LOCK TABLES `reported_listings` WRITE;
/*!40000 ALTER TABLE `reported_listings` DISABLE KEYS */;
/*!40000 ALTER TABLE `reported_listings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `role_has_permissions` (
  `permission_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_has_permissions`
--

LOCK TABLES `role_has_permissions` WRITE;
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
INSERT INTO `role_has_permissions` VALUES (1,2),(2,2),(3,2),(1,3),(2,3),(3,3),(4,3),(5,3),(1,4),(2,4),(3,4),(4,4),(5,4);
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'member','web','2018-10-27 05:27:55','2018-10-27 05:27:55'),(2,'editor','web','2018-10-27 05:27:55','2018-10-27 05:27:55'),(3,'moderator','web','2018-10-27 05:27:56','2018-10-27 05:27:56'),(4,'admin','web','2018-10-27 05:27:57','2018-10-27 05:27:57');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sessions` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL,
  UNIQUE KEY `sessions_id_unique` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `settings_key_index` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (3,'site_name','MarketplaceKit'),(5,'theme','default'),(6,'currency','GBP'),(7,'name','Request'),(8,'widget','buy'),(9,'unit_name','property'),(10,'duration_name',''),(11,'can_add_pricing','1'),(13,'default_pricing_model','4'),(14,'home_title','Home'),(15,'home_description',''),(16,'site_title','Title'),(19,'show_map','0'),(20,'show_list','1'),(21,'show_grid','1'),(22,'default_view','grid'),(23,'site_description','Description'),(29,'distance_unit','miles'),(30,'default_locale','fa'),(31,'supported_locales.0','en'),(35,'listings_require_verification','0'),(36,'site_url','/'),(37,'enable_geo_search','0'),(38,'marketplace_transaction_fee','3'),(39,'marketplace_percentage_fee','20'),(42,'paypal_username',''),(45,'paypal_mode','sandbox'),(64,'custom_homepage','0'),(65,'show_search_sidebar','0'),(67,'moderatelistings.report_types.0.value','Inappropriate'),(68,'moderatelistings.report_types.1.value','Duplicate'),(69,'moderatelistings.report_types.2.value','Spam'),(70,'supported_locales.1','fa'),(71,'marketplace_index','home'),(72,'googlmapper.key',''),(92,'paypal_enabled','0'),(93,'single_listing_per_user','0'),(102,'site_logo',NULL),(103,'email_address',NULL),(104,'paypal_email',NULL),(105,'paypal_password',NULL),(106,'paypal_signature',NULL),(107,'google_analytics_key',NULL),(108,'google_maps_key',NULL),(109,'stripe_publishable_key',NULL),(110,'facebook_key',NULL),(111,'facebook_secret',NULL),(112,'stripe_secret_key',NULL);
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bio` text COLLATE utf8mb4_unicode_ci,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trader_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'individual',
  `business_vat_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `region` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` char(3) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `locale` char(5) COLLATE utf8mb4_unicode_ci DEFAULT 'en',
  `unread_messages` int(11) DEFAULT '0',
  `is_admin` tinyint(1) DEFAULT '0',
  `ip_address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL,
  `last_login_ip` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `blocked_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `can_accept_payments` tinyint(1) DEFAULT '0',
  `verified` tinyint(1) NOT NULL DEFAULT '0',
  `verification_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `banned_at` datetime DEFAULT NULL,
  `provider` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin',NULL,'admin','admin',NULL,'0901212122','admin@example.com','individual',NULL,NULL,'$2y$10$92oc0R2XxEgt0SwvvxA7SeoMdh6UaLb49kiQzZOoHXI7cGNSoud0e','iTtUy7RKZUq4OPP7V3gAPhsS3zZUYanM1oyN74QonXtxo0wbVzMltILtxZlP',NULL,NULL,NULL,NULL,NULL,'fa',0,1,NULL,'2018-12-12 11:44:07','172.30.0.1',NULL,'2018-10-27 05:27:54','2018-12-12 11:44:08',NULL,0,1,NULL,NULL,NULL,NULL),(2,'mreza',NULL,'mreza','mreza',NULL,NULL,'bawetechco@gmail.com','individual',NULL,NULL,'$2y$10$5B4CxlJMVjQvM/aqJqN9fezaXPQpB9m71dcAeuPhitpsLCA0CLDDK','9656vZhwQABvAj3FT5lfPOBwSypXDiKG5U5gISxe9xPaOxecEGfpxzZFFIbx',NULL,NULL,NULL,NULL,NULL,'fa',0,0,NULL,'2018-11-02 19:38:50','172.22.0.1',NULL,'2018-11-02 16:00:41','2018-11-02 19:38:51',NULL,0,1,NULL,NULL,NULL,NULL),(3,'reza','reza','reza','reza',NULL,NULL,'reza@yahoo.com','individual',NULL,'http://localhost//storage/avatars/7/9/9/b/3.jpg','$2y$10$FaqPmo1.NjAm755Zky35luxi3zI.H/wddBfVi.TPG1eNOJoxHikpS','WLwb2IiXSQnjUBHKQemg9PwIC3UqaYuvMioE6mYfXvuK2OWTIMRgF4Ej6s23',NULL,NULL,NULL,NULL,NULL,'fa',0,0,NULL,'2018-11-19 17:36:05','172.22.0.1',NULL,'2018-11-02 19:45:58','2018-11-19 17:36:05',NULL,0,1,NULL,NULL,NULL,NULL),(4,'test',NULL,'test','test',NULL,'09031212121','tes@yahoo.com','individual',NULL,NULL,'$2y$10$iaJKvDDBJI0JLzC5HuRLf.Hbzae5QOixBtUb9VAEvPgrK9mLYguLu','rBSRuVr2emFKoOya7kziTzsU3A9CnRcL1LXWWGn64tUybcyc5HQrZ592DwbC',NULL,NULL,NULL,NULL,NULL,'fa',0,0,NULL,'2018-12-04 10:54:14','172.23.0.1',NULL,'2018-12-04 10:54:13','2018-12-04 10:54:15',NULL,0,0,NULL,NULL,NULL,NULL),(5,'testi',NULL,'testi','testi',NULL,'2323233','tes@aa.com','individual',NULL,NULL,'$2y$10$Xai5xjy6NVHwGycYn5w3luMAo51qPWKNZF7cb5aHOngyhQdcuPTeK','ivlgScUMqqVq9espN7VDZNFheNOrgKBinxtBUdgStf8gtMN7QEMl1ULMiSrM',NULL,NULL,NULL,NULL,NULL,'fa',0,0,NULL,'2018-12-04 11:01:05','172.23.0.1',NULL,'2018-12-04 11:01:05','2018-12-04 11:01:06',NULL,0,0,NULL,NULL,NULL,NULL),(6,'testii',NULL,'testii','testii',NULL,'09031212321','testa@hao.com','individual',NULL,NULL,'$2y$10$DOHD5WcesKVLKFrDx6X1x.kcYudHtpNORB7WZDGuHcGFFes8Zu5de','OVnf09lCZ2vnKwBlr6dQadv6ImWKlyOdP0tIsoYkUIVAKBcT25NUnuEbQkEz',NULL,NULL,NULL,NULL,NULL,'fa',0,0,NULL,'2018-12-04 11:12:13','172.23.0.1',NULL,'2018-12-04 11:12:13','2018-12-04 11:12:14',NULL,0,0,NULL,NULL,NULL,NULL),(7,'asd',NULL,'asd','asd',NULL,'2323232323','dfdf@yaho.com','individual',NULL,NULL,'$2y$10$NejBVBLtRynx90NiAg.InuUDN45B2H/pDMnJM/PrXkPhPKd7AeQi2','ZwzblAG8aRM4qrEYPCYUWHSp3QM9SMyFk2oTgMlUBgccRQKZ2kU5I2kpm3nr',NULL,NULL,NULL,NULL,NULL,'fa',0,0,NULL,'2018-12-04 11:16:54','172.23.0.1',NULL,'2018-12-04 11:16:54','2018-12-04 11:16:55',NULL,0,1,NULL,NULL,NULL,NULL),(8,'mreza',NULL,'mreza','mreza-1',NULL,'09033606734','mreza@yahoo.com','individual',NULL,NULL,'$2y$10$OMjaEk30HleKDoag9Rd8LOA7aeI6.YEhxAofppUf18GXDmsycsJKW','5g7IQp6bCubfFO92EOvfmuXFKMHQFQpdb7xk8TgWVDpQt4FsdgmAiUkrdWNQ',NULL,NULL,NULL,NULL,NULL,'fa',0,0,NULL,'2018-12-04 21:09:46','172.23.0.1',NULL,'2018-12-04 20:20:57','2018-12-04 21:09:46',NULL,0,1,NULL,NULL,NULL,NULL),(9,'rezaa',NULL,'rezaa','rezaa',NULL,'\'09036262622\'','rezaa@yahoo.com','individual',NULL,NULL,'$2y$10$2tbMNtF2fIX7DH9eZPzgNeJVERuEmw2S9iOhihmqVeYGqqIwQedty','AvHDxgxzQMMvCrDqR6DZTFFnR1ZZK7L1Q6X3hgvBL1aExRsmrYVbudqcoeVj',NULL,NULL,NULL,NULL,NULL,'fa',0,0,NULL,'2018-12-12 11:34:55','172.30.0.1',NULL,'2018-12-12 11:34:55','2018-12-12 11:34:56',NULL,0,0,NULL,NULL,NULL,NULL),(10,'aaa',NULL,'aaa','aaa',NULL,'\"0912331313\"','sdsdsd@sd.com','individual',NULL,NULL,'$2y$10$MaY32Ni11y55qnmTHgFtru8mccyXUGW1FHnh.nzNUv8B4CWQU0./i','BVlXkKgzA81gxEG0vMgQpJQVQpe7DqBj55WgqShxKnVss0BG5Iyb05XaGYkS',NULL,NULL,NULL,NULL,NULL,'fa',0,0,NULL,'2018-12-12 11:35:57','172.30.0.1',NULL,'2018-12-12 11:35:57','2018-12-12 11:35:57',NULL,0,0,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_meta`
--

DROP TABLE IF EXISTS `users_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `users_meta` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'null',
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `users_meta_user_id_index` (`user_id`),
  KEY `users_meta_key_index` (`key`),
  CONSTRAINT `users_meta_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_meta`
--

LOCK TABLES `users_meta` WRITE;
/*!40000 ALTER TABLE `users_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallet_transactions`
--

DROP TABLE IF EXISTS `wallet_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wallet_transactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `wallet_id` int(10) unsigned NOT NULL,
  `amount` int(11) NOT NULL,
  `hash` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `accepted` tinyint(1) NOT NULL,
  `meta` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wallet_transactions_wallet_id_foreign` (`wallet_id`),
  CONSTRAINT `wallet_transactions_wallet_id_foreign` FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallet_transactions`
--

LOCK TABLES `wallet_transactions` WRITE;
/*!40000 ALTER TABLE `wallet_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `wallet_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallets`
--

DROP TABLE IF EXISTS `wallets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wallets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `balance` bigint(20) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wallets_user_id_foreign` (`user_id`),
  CONSTRAINT `wallets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallets`
--

LOCK TABLES `wallets` WRITE;
/*!40000 ALTER TABLE `wallets` DISABLE KEYS */;
/*!40000 ALTER TABLE `wallets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alignment` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `locale` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metadata` text COLLATE utf8mb4_unicode_ci,
  `background` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `style` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
INSERT INTO `widgets` VALUES (1,'Buy, Sell & Explore','center','hero','en','\"What are you searching for? Start your search below, and don\'t forget, it\'s free to place a listing for sale with us!\"','white',0,NULL,'2018-10-27 05:27:58','2018-10-27 05:27:58'),(2,'Latest listings',NULL,'latest_listings','en',NULL,'light',1,NULL,'2018-10-27 05:27:58','2018-10-27 05:27:58'),(3,'Categories','center','category_listing','en',NULL,'white',2,NULL,'2018-10-27 05:27:58','2018-10-27 05:27:58'),(4,'Popular listings',NULL,'popular_listings','en',NULL,'light',3,NULL,'2018-10-27 05:27:58','2018-10-27 05:27:58'),(5,'Why should you join us?','center','paragraph','en','[{\"title\":\"For Sellers & Renters\",\"icon\":\"store\",\"blurb\":\"If you have anything to sell, equipment or even space to rent - list it with us for free and get some extra exposure\",\"link\":\"\\/create\",\"link_text\":\"Sell something\"},{\"title\":\"For Buyers\",\"icon\":\"cart\",\"blurb\":\"Explore a range of products from smartphones to rental properties and dog walking services\",\"link\":\"\\/browse\",\"link_text\":\"Browse products & services\"},{\"title\":\"For Professionals & Workers\",\"icon\":\"axe\",\"blurb\":\"Fitness instructor, dog walker? Advertise your services to our community and earn a little extra\",\"link\":\"\\/create\",\"link_text\":\"List your service\"}]','white',4,NULL,'2018-10-27 05:27:58','2018-10-27 05:27:58'),(6,'Featured categories','left','image_gallery','en','[{\"title\":\"Nature\",\"image\":\"https:\\/\\/source.unsplash.com\\/618x221\\/?nature\",\"link\":\"\\/browse\",\"columns\":\"8\"},{\"image\":\"https:\\/\\/source.unsplash.com\\/400x300\\/?water\",\"link\":\"\\/browse?view=grid&distance=0&category=1\",\"columns\":\"4\"},{\"image\":\"https:\\/\\/source.unsplash.com\\/400x300\\/?garden\",\"link\":\"\\/browse?view=list&distance=0&category=1\",\"columns\":\"4\"},{\"image\":\"https:\\/\\/source.unsplash.com\\/400x300\\/?car\",\"link\":\"\\/browse?view=map&distance=0&category=1\",\"columns\":\"4\"},{\"image\":\"https:\\/\\/source.unsplash.com\\/400x300\\/?bicycle\",\"link\":\"\\/listing\\/Q81KoWKz3V\\/my-first-listing\",\"columns\":\"4\"}]','light',5,NULL,'2018-10-27 05:27:58','2018-10-27 05:27:58'),(7,'Featured listings\n',NULL,'featured_listings','en',NULL,'white',6,NULL,'2018-10-27 05:27:58','2018-10-27 05:27:58'),(8,'Video','center','video','en','\"https:\\/\\/www.youtube.com\\/watch?v=B7wkzmZ4GBw\"','light',7,NULL,'2018-10-27 05:27:58','2018-10-27 05:27:58');
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-12-18 19:44:30
