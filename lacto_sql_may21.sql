-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: lacto
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add batch',6,'add_batch'),(22,'Can change batch',6,'change_batch'),(23,'Can delete batch',6,'delete_batch'),(24,'Can view batch',6,'view_batch'),(25,'Can add session',7,'add_session'),(26,'Can change session',7,'change_session'),(27,'Can delete session',7,'delete_session'),(28,'Can view session',7,'view_session'),(29,'Can add doner',8,'add_doner'),(30,'Can change doner',8,'change_doner'),(31,'Can delete doner',8,'delete_doner'),(32,'Can view doner',8,'view_doner');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(28) NOT NULL,
  `username` varchar(150) NOT NULL, 
  `role` varchar(20),  
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL, 
  `email` varchar(254) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

insert into user (password, username, role, first_name, last_name, last_login, email, is_active, date_joined) values ('f', 'f', 'doner', 'Sudha', 'Gandhe', '2021-05-12','aaa@bbb.com', '1', '2020-03-10'); 

insert into user (password, username, role, first_name, last_name, last_login, email, is_active, date_joined) values ('sona', 'sona', 'doner', 'Sona', 'Rama', '2021-05-4','sba@cbb.com', '1', '2020-02-11');

DROP TABLE IF EXISTS `profile`;
CREATE TABLE `profile` (
  `profile_id` int NOT NULL AUTO_INCREMENT,
  `id` int,
  `birthdate` date,
  `address` varchar(255),
  `contact_no` varchar(12),
  `emailid` varchar(50),
  `aadhar_cd_no` varchar(20),
  PRIMARY KEY (`profile_id`)
);

insert into profile (id, birthdate, address, contact_no, aadhar_cd_no) values ('1','1999-01-20','21 Gunjan Apt no3, Karve Nagar, Pune 411003','9165784917','314333466716');
insert into profile (id, birthdate, address, contact_no, aadhar_cd_no) values ('2','1995-03-10','32 Anjanwadi, Sadashive Peth, Pune 411013','9868786947','324353436756');
insert into profile (id, birthdate, address, contact_no, aadhar_cd_no) values ('3','1985-08-16','2 Shanti, Narayan Peth, Pune 411011','9868784447','3243534367');
insert into profile (id, birthdate, address, contact_no, aadhar_cd_no) values ('3','1985-08-16','{name="Jana:, email="kaka@kkk.com"','9868784447','3243534367');

/* Doners declaration  */
DROP TABLE IF EXISTS `doner_info`;    
CREATE TABLE `doner_info` (
  `donerinfo_id` int NOT NULL AUTO_INCREMENT,
  `id` int,
  `birthdate` date,
  `blood_group` varchar(8),
  `acute_illness` varchar(255),
  `past_illness` varchar(255),
  `medication` varchar(126),
  `active_herps_Infection` boolean,
  `viral_vaccine` boolean,
  `vericella_vaccine` boolean,
  `rubella_vaccine` boolean,
  `first_child_DOB` date,
  `doner_motive` varchar(150),
  `doner_insured` boolean,
  `consent_obtained` boolean,
  `date_of_registration` date,
  `parameters` varchar(500),
  PRIMARY KEY (`donerinfo_id`)
);
 ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/* doctors examination ad results. Valid 120 days from doct_acceptance_date */
DROP TABLE IF EXISTS `doctor_examination`;
CREATE TABLE `doctor_examination` (
`doctor_exa_id` int NOT NULL AUTO_INCREMENT,
`id` int,
`HBsAg_result` boolean,
`HIV_result` boolean,
`MCV_result` boolean,
`VDRL_result` boolean,
`HBsAg_result_date` date,
`HIV_result_date`  date,
`MCV_result_date`  date,
`VDRL_result_date`  date,
`mastitis` boolean,
`local_skin_test` boolean,
`doctor_acceptance` boolean,
`doctor_name` varchar(50),
`doctor_acceptance_date` date,
`remark` varchar(355),
PRIMARY KEY (`doctor_exa_id`)
);

DROP TABLE IF EXISTS `schedule`;
CREATE TABLE `schedule` (
  `schedule_id` int NOT NULL AUTO_INCREMENT,
  `id` int,
  `date` datetime,
  `collection_req` boolean,
  `address_of_col` varchar(126),
  `special_instruction` varchar(255),
  PRIMARY KEY (`schedule_id`)
);

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'lactoApp','batch'),(8,'lactoApp','doner'),(7,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2020-06-18 03:10:02.301025'),(2,'auth','0001_initial','2020-06-18 03:10:02.685073'),(3,'admin','0001_initial','2020-06-18 03:10:05.117025'),(4,'admin','0002_logentry_remove_auto_add','2020-06-18 03:10:05.677033'),(5,'admin','0003_logentry_add_action_flag_choices','2020-06-18 03:10:05.733050'),(6,'contenttypes','0002_remove_content_type_name','2020-06-18 03:10:06.181073'),(7,'auth','0002_alter_permission_name_max_length','2020-06-18 03:10:06.429031'),(8,'auth','0003_alter_user_email_max_length','2020-06-18 03:10:06.549040'),(9,'auth','0004_alter_user_username_opts','2020-06-18 03:10:06.581029'),(10,'auth','0005_alter_user_last_login_null','2020-06-18 03:10:06.797032'),(11,'auth','0006_require_contenttypes_0002','2020-06-18 03:10:06.805067'),(12,'auth','0007_alter_validators_add_error_messages','2020-06-18 03:10:06.837044'),(13,'auth','0008_alter_user_username_max_length','2020-06-18 03:10:07.181030'),(14,'auth','0009_alter_user_last_name_max_length','2020-06-18 03:10:07.605031'),(15,'auth','0010_alter_group_name_max_length','2020-06-18 03:10:07.669026'),(16,'auth','0011_update_proxy_permissions','2020-06-18 03:10:07.693028'),(17,'lactoApp','0001_initial','2020-06-18 03:10:07.765023'),(18,'lactoApp','0002_auto_20200617_1820','2020-06-18 03:10:07.789027'),(19,'lactoApp','0003_auto_20200617_1826','2020-06-18 03:10:07.805022'),(20,'lactoApp','0004_auto_20200617_2140','2020-06-18 03:10:07.941023'),(21,'lactoApp','0005_auto_20200617_2158','2020-06-18 03:10:08.005022'),(22,'lactoApp','0006_auto_20200617_2211','2020-06-18 08:08:16.697382'),(23,'lactoApp','0007_remove_batch_test1_date','2020-06-18 08:08:16.705383'),(24,'lactoApp','0008_remove_batch_test_id','2020-06-18 08:08:16.713423'),(25,'lactoApp','0009_auto_20200617_2220','2020-06-18 08:08:16.721422'),(26,'lactoApp','0010_auto_20200617_2229','2020-06-18 08:08:16.729382'),(27,'lactoApp','0011_auto_20200617_2230','2020-06-18 08:08:16.737377'),(28,'lactoApp','0012_auto_20200617_2235','2020-06-18 08:08:16.753381'),(29,'lactoApp','0013_doner','2020-06-18 08:08:16.761421'),(30,'lactoApp','0014_auto_20200618_0855','2020-06-18 08:08:16.777374'),(31,'lactoApp','0015_auto_20200618_0855','2020-06-18 08:08:16.785465'),(32,'lactoApp','0016_batch_collection_date','2020-06-18 08:08:16.793415'),(33,'sessions','0001_initial','2020-06-18 08:08:16.809375'),(34,'lactoApp','0017_auto_20200618_1346','2020-06-18 08:17:16.632008'),(35,'lactoApp','0018_auto_20200618_1428','2020-06-18 08:58:32.437512'),(36,'lactoApp','0019_auto_20200618_1430','2020-06-18 09:00:09.498831'),(37,'lactoApp','0020_auto_20200618_2143','2020-06-18 16:13:36.420983'),(38,'lactoApp','0021_auto_20200618_2146','2020-06-18 16:16:59.943269'),(39,'lactoApp','0022_auto_20200618_2204','2020-06-18 16:34:58.380208'),(40,'lactoApp','0023_auto_20200618_2208','2020-06-18 16:38:51.249731'),(41,'lactoApp','0024_auto_20200618_2215','2020-06-18 16:56:57.128453'),(42,'lactoApp','0025_auto_20200618_2222','2020-06-18 16:56:57.144446'),(43,'lactoApp','0026_auto_20200618_2225','2020-06-18 16:56:57.152433'),(44,'lactoApp','0027_doner_l_name','2020-06-18 17:09:03.936632'),(45,'lactoApp','0028_delete_doner','2020-06-18 17:16:53.386437'),(46,'lactoApp','0029_doner','2020-06-18 17:19:33.605020'),(47,'lactoApp','0030_auto_20200618_2254','2020-06-18 17:24:25.173349'),(48,'lactoApp','0031_auto_20200618_2256','2020-06-18 17:26:08.224315'),(49,'lactoApp','0032_auto_20200618_2301','2020-06-18 17:31:50.866523'),(50,'lactoApp','0033_auto_20200618_2304','2020-06-18 17:34:48.409980'),(51,'lactoApp','0034_batch_pasteurizing_date','2020-06-19 12:21:03.160358');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lactoapp_batch`
--

DROP TABLE IF EXISTS `lactoapp_batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lactoapp_batch` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Batch_No` int NOT NULL,
  `collection_date` date NOT NULL,
  `batch_type` varchar(20) NOT NULL,
  `doner_id_homo` tinyint(1) NOT NULL,
  `self_other` varchar(20) NOT NULL,
  `exp_date` date NOT NULL,
  `Pasturing_process_id` varchar(10) NOT NULL,
  `content1` varchar(125) NOT NULL,
  `select_type` varchar(20) NOT NULL,
  `pasteurizing_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lactoapp_batch`
--

LOCK TABLES `lactoapp_batch` WRITE;
/*!40000 ALTER TABLE `lactoapp_batch` DISABLE KEYS */;
INSERT INTO `lactoapp_batch` VALUES (1,1,'2020-02-02','Self',1,'other','2020-01-02','02','ababcdcd','Homo','2020-06-07'),(2,1,'2020-02-02','Self',1,'other','2020-01-02','02','ababcdcd','Homo','2020-05-30'),(3,1,'2020-02-02','Self',1,'other','2020-01-02','02','ababcdcd','Homo',NULL);
/*!40000 ALTER TABLE `lactoapp_batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lactoapp_doner`
--

DROP TABLE IF EXISTS `lactoapp_doner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lactoapp_doner` (
  `id` int NOT NULL AUTO_INCREMENT,
  `doner_id` varchar(10) NOT NULL,
  `f_name` varchar(20) NOT NULL,
  `l_name` varchar(20) DEFAULT NULL,
  `HBS_test_date` date DEFAULT NULL,
  `HIV_test_date` date DEFAULT NULL,
  `VRDL_test` tinyint(1) DEFAULT NULL,
  `VRDL_test_date` date DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `consent` tinyint(1) DEFAULT NULL,
  `consent_date` date DEFAULT NULL,
  `last_child_birth_date` date DEFAULT NULL,
  `screening_test_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lactoapp_doner`
--

LOCK TABLES `lactoapp_doner` WRITE;
/*!40000 ALTER TABLE `lactoapp_doner` DISABLE KEYS */;
INSERT INTO `lactoapp_doner` VALUES (1,'AA-01','Sandhya','Kumar','2020-06-07','2020-06-15',1,'2020-06-13','Thane',35,0,NULL,NULL,NULL),(2,'AA-03','Sanjna','Gune','2020-05-28','2020-06-07',2,'2020-06-03','Mumbai',25,1,NULL,NULL,NULL),(3,'AA-02','Kishori','Mane','2020-04-22','2020-05-18',1,'2020-05-18','Shivaji Nagar, Ahmadnagar',28,1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `lactoapp_doner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persons`
--

DROP TABLE IF EXISTS `persons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `persons` (
  `PersonID` int DEFAULT NULL,
  `LastName` varchar(255) DEFAULT NULL,
  `FirstName` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persons`
--

LOCK TABLES `persons` WRITE;
/*!40000 ALTER TABLE `persons` DISABLE KEYS */;
INSERT INTO `persons` VALUES (NULL,'sada','jaju'),(NULL,'khada','wadu'),(12,'abcd','bedc'),(2,'dbad','teda'),(NULL,'Monore','Arvind'),(NULL,'twotwo','oneone');
/*!40000 ALTER TABLE `persons` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-27 15:37:15
