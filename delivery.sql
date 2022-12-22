/*
SQLyog Professional v13.1.1 (64 bit)
MySQL - 10.4.22-MariaDB : Database - delivery_tour
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`delivery_tour` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `delivery_tour`;

/*Table structure for table `driver2vehicle` */

DROP TABLE IF EXISTS `driver2vehicle`;

CREATE TABLE `driver2vehicle` (
  `drv2vhc_id` int(255) NOT NULL AUTO_INCREMENT,
  `drv_id` int(11) DEFAULT NULL,
  `vhc_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`drv2vhc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

/*Data for the table `driver2vehicle` */

insert  into `driver2vehicle`(`drv2vhc_id`,`drv_id`,`vhc_id`) values 
(1,1,1),
(2,2,2),
(3,3,3),
(4,4,4);

/*Table structure for table `drivers` */

DROP TABLE IF EXISTS `drivers`;

CREATE TABLE `drivers` (
  `rt_drv_id` int(255) NOT NULL AUTO_INCREMENT,
  `drv_name` char(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `wt_from` time DEFAULT NULL,
  `wt_to` time DEFAULT NULL,
  `wt_duration` float DEFAULT NULL,
  `drv_email` char(32) CHARACTER SET utf8mb4 DEFAULT NULL,
  `drv_phone` char(32) CHARACTER SET utf8mb4 DEFAULT NULL,
  `drv_status` int(16) DEFAULT NULL,
  PRIMARY KEY (`rt_drv_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `drivers` */

insert  into `drivers`(`rt_drv_id`,`drv_name`,`wt_from`,`wt_to`,`wt_duration`,`drv_email`,`drv_phone`,`drv_status`) values 
(1,'Driver 001','08:00:00','16:00:00',8,NULL,NULL,1),
(2,'Driver 002','08:00:00','16:00:00',8,NULL,NULL,1),
(3,'Driver 003','08:00:00','16:00:00',8,NULL,NULL,1),
(4,'Driver 004','08:00:00','16:00:00',8,NULL,NULL,1);

/*Table structure for table `nodes` */

DROP TABLE IF EXISTS `nodes`;

CREATE TABLE `nodes` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `node` int(16) DEFAULT NULL,
  `zip` int(16) DEFAULT NULL,
  `city` varchar(16) DEFAULT NULL,
  `country` varchar(16) DEFAULT NULL,
  `visited` varchar(16) DEFAULT NULL,
  `priority` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8;

/*Data for the table `nodes` */

insert  into `nodes`(`id`,`node`,`zip`,`city`,`country`,`visited`,`priority`) values 
(2,0,8258,'Vogtlandkreis','Germany','yes','high'),
(3,1,8258,'Markneukirchen','Germany','no','low'),
(4,2,13589,'Berlin','Germany','no','low'),
(5,3,80939,'Munchen','Germany','yes','low'),
(6,4,86156,'Augsburg','Germany','yes','low'),
(7,5,92421,'Schwandorf','Germany','yes','low'),
(8,6,8258,'Markneukirchen','Germany','yes','low'),
(9,7,8258,'Markneukirchen','Germany','yes','high'),
(10,8,12205,'Berlin','Germany','yes','high'),
(11,9,8258,'Markneukirchen','Germany','yes','medium'),
(12,10,12207,'Berlin','Germany','yes','medium'),
(13,11,8258,'Markneukirchen','Germany','yes','medium'),
(14,12,14979,'Grobeeren','Germany','yes','medium'),
(15,13,20149,'Hamburg','Germany','yes','medium'),
(16,14,8258,'Markneukirchen','Germany','yes','medium'),
(17,15,8258,'Markneukirchen','Germany','yes','medium'),
(18,16,80995,'','Germany','yes','medium'),
(19,17,80939,'Munchen','Germany','yes','medium'),
(20,18,60326,'','Germany','yes','medium'),
(21,19,8258,'Markneukirchen','Germany','yes','medium'),
(22,20,50737,'Koln','Germany','yes','medium'),
(23,21,8258,'Markneukirchen','Germany','yes','medium'),
(24,22,50737,'Koln','Germany','yes','medium'),
(25,23,8258,'Markneukirchen','Germany','yes','medium'),
(26,24,50737,'Koln','Germany','yes','medium'),
(27,25,50737,'Koln','Germany','yes','medium'),
(28,26,8258,'Markneukirchen','Germany','yes','medium'),
(29,27,50737,'Koln','Germany','yes','medium'),
(30,28,8258,'Markneukirchen','Germany','yes','medium'),
(31,29,50737,'Koln','Germany','yes','medium'),
(32,30,8258,'Markneukirchen','Germany','yes','medium'),
(33,31,50737,'Koln','Germany','yes','medium'),
(34,32,8258,'Markneukirchen','Germany','yes','medium'),
(35,33,44263,'Dortmund','Germany','yes','medium'),
(36,34,8258,'Markneukirchen','Germany','yes','medium'),
(37,35,8258,'Markneukirchen','Germany','yes','medium'),
(38,36,92436,'Oberpfalz','Germany','yes','medium'),
(39,37,8258,'Markneukirchen','Germany','yes','high'),
(40,38,1010,'Wien','Austria','yes','high'),
(41,39,14469,'Potsdam','Germany','yes','medium'),
(42,40,8258,'Markneukirchen','Germany','yes','medium'),
(43,41,8258,'Markneukirchen','Germany','yes','medium'),
(44,42,45130,'Essen','Germany','yes','medium'),
(45,43,8258,'Markneukirchen','Germany','yes','medium'),
(46,44,45130,'Essen','Germany','yes','medium'),
(47,45,80939,'Munchen','Germany','yes','medium'),
(48,46,90409,'Nurnberg','Germany','yes','medium'),
(49,47,51105,'Koln','Germany','yes','medium'),
(50,48,80939,'Munchen','Germany','yes','medium'),
(51,49,51105,'Koln','Germany','yes','medium'),
(52,50,80939,'Munchen','Germany','yes','medium'),
(53,51,8258,'Markneukirchen','Germany','yes','medium'),
(54,52,1187,'Dresden','Germany','yes','medium'),
(55,53,8258,'Markneukirchen','Germany','yes','medium'),
(56,54,12203,'','Germany','yes','medium'),
(57,55,70188,'','Germany','yes','medium'),
(58,56,8258,'Markneukirchen','Germany','yes','medium'),
(59,57,26123,'Oldenburg','Germany','yes','medium'),
(60,58,8258,'Markneukirchen','Germany','yes','medium'),
(61,59,26123,'Oldenburg','Germany','yes','medium'),
(62,60,8258,'Markneukirchen','Germany','yes','medium'),
(63,61,26123,'Oldenburg','Germany','yes','medium'),
(64,62,8258,'Markneukirchen','Germany','yes','medium'),
(65,63,26123,'Oldenburg','Germany','yes','medium'),
(66,64,8258,'Markneukirchen','Germany','yes','medium'),
(67,65,53129,'Bonn','Germany','yes','medium'),
(68,66,8258,'Markneukirchen','Germany','yes','medium'),
(69,67,8258,'Markneukirchen','Germany','yes','medium'),
(70,68,53129,'Bonn','Germany','yes','medium'),
(71,69,8258,'Markneukirchen','Germany','yes','medium'),
(72,70,92353,'Postbauer-Heng','Germany','yes','medium'),
(73,71,8258,'Markneukirchen','Germany','yes','medium'),
(74,72,92358,'Oberpfalz','Germany','yes','medium'),
(75,73,8258,'Markneukirchen','Germany','yes','medium'),
(76,74,92358,'Oberpfalz','Germany','yes','medium'),
(77,75,8258,'Markneukirchen','Germany','yes','medium'),
(78,76,92358,'Oberpfalz','Germany','yes','medium'),
(79,77,8258,'Markneukirchen','Germany','yes','medium'),
(80,78,81543,'','Germany','yes','medium'),
(81,79,8020,'Graz','Austria','yes','medium'),
(82,80,8258,'Markneukirchen','Germany','yes','medium'),
(83,81,8258,'Markneukirchen','Germany','yes','medium'),
(84,82,22305,'Hamburg','Germany','yes','medium'),
(85,83,8258,'Markneukirchen','Germany','yes','medium'),
(86,84,25813,'Husum','Germany','yes','medium'),
(87,85,8258,'Markneukirchen','Germany','yes','medium'),
(88,86,13589,'Berlin','Germany','yes','medium'),
(89,87,8258,'Markneukirchen','Germany','yes','medium'),
(90,88,13435,'Berlin','Germany','yes','medium'),
(91,89,8258,'Markneukirchen','Germany','yes','medium'),
(92,90,13125,'Berlin','Germany','yes','medium'),
(93,91,8258,'Markneukirchen','Germany','yes','medium'),
(94,92,16341,'Panketal','Germany','yes','medium'),
(95,93,8258,'Markneukirchen','Germany','yes','medium'),
(96,94,12557,'Berlin','Germany','yes','medium');

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `vehicle` int(16) DEFAULT NULL,
  `node` int(18) DEFAULT NULL,
  `zip` int(18) DEFAULT NULL,
  `city` varchar(14) DEFAULT NULL,
  `country` varchar(7) DEFAULT NULL,
  `order` int(16) DEFAULT NULL,
  `time` float DEFAULT NULL COMMENT 'h',
  `distance` float DEFAULT NULL COMMENT 'km',
  `demand` float DEFAULT NULL,
  `type` varchar(8) DEFAULT NULL,
  `load` float DEFAULT NULL,
  `capacity` float DEFAULT NULL COMMENT '%',
  `petrol` float DEFAULT NULL COMMENT 'L',
  `petrol_cost` float DEFAULT NULL COMMENT 'EUR',
  `scheduled_at` char(16) DEFAULT NULL,
  `order_date` char(16) DEFAULT NULL,
  `note` char(255) DEFAULT NULL,
  `email` char(16) DEFAULT NULL,
  `phone_num` char(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8;

/*Data for the table `orders` */

insert  into `orders`(`id`,`vehicle`,`node`,`zip`,`city`,`country`,`order`,`time`,`distance`,`demand`,`type`,`load`,`capacity`,`petrol`,`petrol_cost`,`scheduled_at`,`order_date`,`note`,`email`,`phone_num`) values 
(2,0,0,8258,'Vogtlandkreis','Germany',0,0,0,0,'depot',0,0,0,0,NULL,NULL,NULL,NULL,NULL),
(3,0,71,8258,'Markneukirchen','Germany',1,0,0,1,'pick-up',1,10.5,0,0,NULL,NULL,NULL,NULL,NULL),
(4,0,35,8258,'Markneukirchen','Germany',2,0,0,0.25,'pick-up',1.2,13.2,0,0,NULL,NULL,NULL,NULL,NULL),
(5,0,37,8258,'Markneukirchen','Germany',3,0,0,1,'pick-up',2.2,23.7,0,0,NULL,NULL,NULL,NULL,NULL),
(6,0,69,8258,'Markneukirchen','Germany',4,0,0,1,'pick-up',3.2,34.2,0,0,NULL,NULL,NULL,NULL,NULL),
(7,0,75,8258,'Markneukirchen','Germany',5,0,0,0.75,'pick-up',4,42.1,0,0,NULL,NULL,NULL,NULL,NULL),
(8,0,73,8258,'Markneukirchen','Germany',6,0,0,0.75,'pick-up',4.8,50,0,0,NULL,NULL,NULL,NULL,NULL),
(9,0,70,92353,'Postbauer-Heng','Germany',7,2.3,193.3,1,'delivery',3.8,39.5,17.4,38.3,NULL,NULL,NULL,NULL,NULL),
(10,0,72,92358,'Oberpfalz','Germany',8,3.2,224.3,1,'delivery',2.8,28.9,20.2,44.4,NULL,NULL,NULL,NULL,NULL),
(11,0,76,92358,'Oberpfalz','Germany',9,3.2,224.3,0.75,'delivery',2,21.1,20.2,44.4,NULL,NULL,NULL,NULL,NULL),
(12,0,74,92358,'Oberpfalz','Germany',10,3.2,224.3,0.75,'delivery',1.2,13.2,20.2,44.4,NULL,NULL,NULL,NULL,NULL),
(13,0,79,8020,'Graz','Austria',11,8.1,689.1,1,'pick-up',2.2,23.7,62,136.5,NULL,NULL,NULL,NULL,NULL),
(14,0,38,1010,'Wien','Austria',12,10.6,884.8,1,'delivery',1.2,13.2,79.6,175.2,NULL,NULL,NULL,NULL,NULL),
(15,0,36,92436,'Oberpfalz','Germany',13,15,1294.1,0.25,'delivery',1,10.5,116.5,256.2,NULL,NULL,NULL,NULL,NULL),
(16,0,80,8258,'Markneukirchen','Germany',14,17.1,1465,1,'delivery',0,0,131.8,290.1,NULL,NULL,NULL,NULL,NULL),
(17,0,53,8258,'Markneukirchen','Germany',15,17.1,1465,1,'pick-up',1,10.5,131.8,290.1,NULL,NULL,NULL,NULL,NULL),
(18,0,9,8258,'Markneukirchen','Germany',16,17.1,1465,3,'pick-up',4,42.1,131.8,290.1,NULL,NULL,NULL,NULL,NULL),
(19,0,7,8258,'Markneukirchen','Germany',17,17.1,1465,3,'pick-up',7,73.7,131.8,290.1,NULL,NULL,NULL,NULL,NULL),
(20,0,8,12205,'Berlin','Germany',18,20.6,1808.2,3,'delivery',4,42.1,162.7,358,NULL,NULL,NULL,NULL,NULL),
(21,0,54,12203,'','Germany',19,21,1810.2,1,'delivery',3,31.6,162.9,358.4,NULL,NULL,NULL,NULL,NULL),
(22,0,10,12207,'Berlin','Germany',20,21.4,1813.8,3,'delivery',0,0,163.2,359.1,NULL,NULL,NULL,NULL,NULL),
(23,0,0,8258,'Vogtlandkreis','Germany',21,24.6,2162.4,0,'depot',0,0,194.6,428.2,NULL,NULL,NULL,NULL,NULL),
(24,1,0,8258,'Vogtlandkreis','Germany',0,0,0,0,'depot',0,0,0,0,NULL,NULL,NULL,NULL,NULL),
(25,1,15,8258,'Markneukirchen','Germany',1,0,0,1.25,'pick-up',1.2,13.2,0,0,NULL,NULL,NULL,NULL,NULL),
(26,1,43,8258,'Markneukirchen','Germany',2,0,0,0.75,'pick-up',2,21.1,0,0,NULL,NULL,NULL,NULL,NULL),
(27,1,41,8258,'Markneukirchen','Germany',3,0,0,1,'pick-up',3,31.6,0,0,NULL,NULL,NULL,NULL,NULL),
(28,1,23,8258,'Markneukirchen','Germany',4,0,0,0.5,'pick-up',3.5,36.8,0,0,NULL,NULL,NULL,NULL,NULL),
(29,1,21,8258,'Markneukirchen','Germany',5,0,0,1,'pick-up',4.5,47.4,0,0,NULL,NULL,NULL,NULL,NULL),
(30,1,19,8258,'Markneukirchen','Germany',6,0,0,1,'pick-up',5.5,57.9,0,0,NULL,NULL,NULL,NULL,NULL),
(31,1,67,8258,'Markneukirchen','Germany',7,0,0,1,'pick-up',6.5,68.4,0,0,NULL,NULL,NULL,NULL,NULL),
(32,1,77,8258,'Markneukirchen','Germany',8,0,0,0.5,'pick-up',7,73.7,0,0,NULL,NULL,NULL,NULL,NULL),
(33,1,5,92421,'Schwandorf','Germany',9,1.9,157.9,1,'pick-up',8,84.2,14.2,31.3,NULL,NULL,NULL,NULL,NULL),
(34,1,3,80939,'Munchen','Germany',10,3.8,312.3,1,'pick-up',9,94.7,28.1,61.8,NULL,NULL,NULL,NULL,NULL),
(35,1,17,80939,'Munchen','Germany',11,3.8,312.3,0.25,'pick-up',9.2,97.4,28.1,61.8,NULL,NULL,NULL,NULL,NULL),
(36,1,78,81543,'','Germany',12,4.5,325.3,0.5,'delivery',8.8,92.1,29.3,64.4,NULL,NULL,NULL,NULL,NULL),
(37,1,16,80995,'','Germany',13,5.2,337.4,1.25,'delivery',7.5,78.9,30.4,66.8,NULL,NULL,NULL,NULL,NULL),
(38,1,4,86156,'Augsburg','Germany',14,6.3,403.2,1,'delivery',6.5,68.4,36.3,79.8,NULL,NULL,NULL,NULL,NULL),
(39,1,55,70188,'','Germany',15,8.1,555.7,0.75,'pick-up',7.2,76.3,50,110,NULL,NULL,NULL,NULL,NULL),
(40,1,18,60326,'','Germany',16,10.5,769.7,0.25,'delivery',7,73.7,69.3,152.4,NULL,NULL,NULL,NULL,NULL),
(41,1,44,45130,'Essen','Germany',17,13.2,1012.1,0.75,'delivery',6.2,65.8,91.1,200.4,NULL,NULL,NULL,NULL,NULL),
(42,1,42,45130,'Essen','Germany',18,13.2,1012.1,1,'delivery',5.2,55.3,91.1,200.4,NULL,NULL,NULL,NULL,NULL),
(43,1,20,50737,'Koln','Germany',19,14.3,1081,1,'delivery',4.2,44.7,97.3,214,NULL,NULL,NULL,NULL,NULL),
(44,1,31,50737,'Koln','Germany',20,14.3,1081,1,'pick-up',5.2,55.3,97.3,214,NULL,NULL,NULL,NULL,NULL),
(45,1,29,50737,'Koln','Germany',21,14.3,1081,1,'pick-up',6.2,65.8,97.3,214,NULL,NULL,NULL,NULL,NULL),
(46,1,27,50737,'Koln','Germany',22,14.3,1081,1,'pick-up',7.2,76.3,97.3,214,NULL,NULL,NULL,NULL,NULL),
(47,1,25,50737,'Koln','Germany',23,14.3,1081,1,'pick-up',8.2,86.8,97.3,214,NULL,NULL,NULL,NULL,NULL),
(48,1,24,50737,'Koln','Germany',24,14.3,1081,0.5,'delivery',7.8,81.6,97.3,214,NULL,NULL,NULL,NULL,NULL),
(49,1,22,50737,'Koln','Germany',25,14.3,1081,1,'delivery',6.8,71.1,97.3,214,NULL,NULL,NULL,NULL,NULL),
(50,1,49,51105,'Koln','Germany',26,15,1093.5,0.5,'pick-up',7.2,76.3,98.4,216.5,NULL,NULL,NULL,NULL,NULL),
(51,1,47,51105,'Koln','Germany',27,15,1093.5,1,'pick-up',8.2,86.8,98.4,216.5,NULL,NULL,NULL,NULL,NULL),
(52,1,65,53129,'Bonn','Germany',28,15.7,1122.4,0.75,'pick-up',9,94.7,101,222.2,NULL,NULL,NULL,NULL,NULL),
(53,1,68,53129,'Bonn','Germany',29,15.7,1122.4,1,'delivery',8,84.2,101,222.2,NULL,NULL,NULL,NULL,NULL),
(54,1,45,80939,'Munchen','Germany',30,20.8,1675.3,1,'pick-up',9,94.7,150.8,331.7,NULL,NULL,NULL,NULL,NULL),
(55,1,50,80939,'Munchen','Germany',31,20.8,1675.3,0.5,'delivery',8.5,89.5,150.8,331.7,NULL,NULL,NULL,NULL,NULL),
(56,1,48,80939,'Munchen','Germany',32,20.8,1675.3,1,'delivery',7.5,78.9,150.8,331.7,NULL,NULL,NULL,NULL,NULL),
(57,1,46,90409,'Nurnberg','Germany',33,22.6,1834.3,1,'delivery',6.5,68.4,165.1,363.2,NULL,NULL,NULL,NULL,NULL),
(58,1,6,8258,'Markneukirchen','Germany',34,24.9,2019.1,1,'delivery',5.5,57.9,181.7,399.8,NULL,NULL,NULL,NULL,NULL),
(59,1,56,8258,'Markneukirchen','Germany',35,24.9,2019.1,0.75,'delivery',4.8,50,181.7,399.8,NULL,NULL,NULL,NULL,NULL),
(60,1,32,8258,'Markneukirchen','Germany',36,24.9,2019.1,1,'delivery',3.8,39.5,181.7,399.8,NULL,NULL,NULL,NULL,NULL),
(61,1,30,8258,'Markneukirchen','Germany',37,24.9,2019.1,1,'delivery',2.8,28.9,181.7,399.8,NULL,NULL,NULL,NULL,NULL),
(62,1,28,8258,'Markneukirchen','Germany',38,24.9,2019.1,1,'delivery',1.8,18.4,181.7,399.8,NULL,NULL,NULL,NULL,NULL),
(63,1,26,8258,'Markneukirchen','Germany',39,24.9,2019.1,1,'delivery',0.8,7.9,181.7,399.8,NULL,NULL,NULL,NULL,NULL),
(64,1,66,8258,'Markneukirchen','Germany',40,24.9,2019.1,0.75,'delivery',0,0,181.7,399.8,NULL,NULL,NULL,NULL,NULL),
(65,1,0,8258,'Vogtlandkreis','Germany',41,24.9,2019.1,0,'depot',0,0,181.7,399.8,NULL,NULL,NULL,NULL,NULL),
(66,2,0,8258,'Vogtlandkreis','Germany',0,0,0,0,'depot',0,0,0,0,NULL,NULL,NULL,NULL,NULL),
(67,2,11,8258,'Markneukirchen','Germany',1,0,0,5,'pick-up',5,52.6,0,0,NULL,NULL,NULL,NULL,NULL),
(68,2,85,8258,'Markneukirchen','Germany',2,0,0,4,'pick-up',9,94.7,0,0,NULL,NULL,NULL,NULL,NULL),
(69,2,93,8258,'Markneukirchen','Germany',3,0,0,0.5,'pick-up',9.5,100,0,0,NULL,NULL,NULL,NULL,NULL),
(70,2,94,12557,'Berlin','Germany',4,3.8,370.5,0.5,'delivery',9,94.7,33.3,73.4,NULL,NULL,NULL,NULL,NULL),
(71,2,12,14979,'Grobeeren','Germany',5,4.9,398.2,5,'delivery',4,42.1,35.8,78.8,NULL,NULL,NULL,NULL,NULL),
(72,2,39,14469,'Potsdam','Germany',6,5.8,424.7,1,'pick-up',5,52.6,38.2,84.1,NULL,NULL,NULL,NULL,NULL),
(73,2,86,13589,'Berlin','Germany',7,6.8,452.1,4,'delivery',1,10.5,40.7,89.5,NULL,NULL,NULL,NULL,NULL),
(74,2,63,26123,'Oldenburg','Germany',8,10.9,876.1,0.75,'pick-up',1.8,18.4,78.8,173.5,NULL,NULL,NULL,NULL,NULL),
(75,2,61,26123,'Oldenburg','Germany',9,10.9,876.1,0.75,'pick-up',2.5,26.3,78.8,173.5,NULL,NULL,NULL,NULL,NULL),
(76,2,59,26123,'Oldenburg','Germany',10,10.9,876.1,1,'pick-up',3.5,36.8,78.8,173.5,NULL,NULL,NULL,NULL,NULL),
(77,2,57,26123,'Oldenburg','Germany',11,10.9,876.1,1,'pick-up',4.5,47.4,78.8,173.5,NULL,NULL,NULL,NULL,NULL),
(78,2,33,44263,'Dortmund','Germany',12,13.2,1101.6,0.25,'pick-up',4.8,50,99.1,218.1,NULL,NULL,NULL,NULL,NULL),
(79,2,51,8258,'Markneukirchen','Germany',13,18.2,1621.6,0.25,'pick-up',5,52.6,145.9,321.1,NULL,NULL,NULL,NULL,NULL),
(80,2,34,8258,'Markneukirchen','Germany',14,18.2,1621.6,0.25,'delivery',4.8,50,145.9,321.1,NULL,NULL,NULL,NULL,NULL),
(81,2,64,8258,'Markneukirchen','Germany',15,18.2,1621.6,0.75,'delivery',4,42.1,145.9,321.1,NULL,NULL,NULL,NULL,NULL),
(82,2,62,8258,'Markneukirchen','Germany',16,18.2,1621.6,0.75,'delivery',3.2,34.2,145.9,321.1,NULL,NULL,NULL,NULL,NULL),
(83,2,60,8258,'Markneukirchen','Germany',17,18.2,1621.6,1,'delivery',2.2,23.7,145.9,321.1,NULL,NULL,NULL,NULL,NULL),
(84,2,58,8258,'Markneukirchen','Germany',18,18.2,1621.6,1,'delivery',1.2,13.2,145.9,321.1,NULL,NULL,NULL,NULL,NULL),
(85,2,40,8258,'Markneukirchen','Germany',19,18.2,1621.6,1,'delivery',0.2,2.6,145.9,321.1,NULL,NULL,NULL,NULL,NULL),
(86,2,52,1187,'Dresden','Germany',20,20.4,1793.7,0.25,'delivery',0,0,161.4,355.2,NULL,NULL,NULL,NULL,NULL),
(87,2,0,8258,'Vogtlandkreis','Germany',21,22.4,1966.4,0,'depot',0,0,177,389.4,NULL,NULL,NULL,NULL,NULL),
(88,3,0,8258,'Vogtlandkreis','Germany',0,0,0,0,'depot',0,0,0,0,NULL,NULL,NULL,NULL,NULL),
(89,3,81,8258,'Markneukirchen','Germany',1,0,0,1,'pick-up',1,11.1,0,0,NULL,NULL,NULL,NULL,NULL),
(90,3,83,8258,'Markneukirchen','Germany',2,0,0,1,'pick-up',2,22.2,0,0,NULL,NULL,NULL,NULL,NULL),
(91,3,91,8258,'Markneukirchen','Germany',3,0,0,7,'pick-up',9,100,0,0,NULL,NULL,NULL,NULL,NULL),
(92,3,92,16341,'Panketal','Germany',4,4,412.6,7,'delivery',2,22.2,37.1,81.7,NULL,NULL,NULL,NULL,NULL),
(93,3,82,22305,'Hamburg','Germany',5,6.9,699.9,1,'delivery',1,11.1,63,138.6,NULL,NULL,NULL,NULL,NULL),
(94,3,13,20149,'Hamburg','Germany',6,7.4,704.1,1,'pick-up',2,22.2,63.4,139.4,NULL,NULL,NULL,NULL,NULL),
(95,3,84,25813,'Husum','Germany',7,9.2,838.5,1,'delivery',1,11.1,75.5,166,NULL,NULL,NULL,NULL,NULL),
(96,3,14,8258,'Markneukirchen','Germany',8,15.8,1537.3,1,'delivery',0,0,138.4,304.4,NULL,NULL,NULL,NULL,NULL),
(97,3,87,8258,'Markneukirchen','Germany',9,15.8,1537.3,6,'pick-up',6,66.7,138.4,304.4,NULL,NULL,NULL,NULL,NULL),
(98,3,89,8258,'Markneukirchen','Germany',10,15.8,1537.3,3,'pick-up',9,100,138.4,304.4,NULL,NULL,NULL,NULL,NULL),
(99,3,90,13125,'Berlin','Germany',11,19.9,1951.9,3,'delivery',6,66.7,175.7,386.5,NULL,NULL,NULL,NULL,NULL),
(100,3,88,13435,'Berlin','Germany',12,20.6,1967.8,6,'delivery',0,0,177.1,389.6,NULL,NULL,NULL,NULL,NULL),
(101,3,0,8258,'Vogtlandkreis','Germany',13,24.1,2328.1,0,'depot',0,0,209.5,461,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `pending_shipments` */

DROP TABLE IF EXISTS `pending_shipments`;

CREATE TABLE `pending_shipments` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `company` char(255) DEFAULT NULL,
  `customer` char(255) DEFAULT NULL,
  `customer_address` char(255) DEFAULT NULL,
  `document_number` char(255) DEFAULT NULL,
  `document_type` char(255) DEFAULT NULL,
  `priority` int(18) DEFAULT NULL,
  `stop_number` int(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/*Data for the table `pending_shipments` */

insert  into `pending_shipments`(`id`,`company`,`customer`,`customer_address`,`document_number`,`document_type`,`priority`,`stop_number`) values 
(1,'Streichinstrumente-Verleih Nestler GmbH','Rammstein','','MAT-DN-2022-00040','Delivery Note',8,3),
(2,'Mastri GmbH','Sebastian Mortimer','Teststraße 1<br>\n\n    83022 Rosenheim\n','MAT-DN-2022-00003','Delivery Note',8,3),
(3,'Mastri GmbH','Oskar-von Miller-Gymnasium','Ungererstr. 191<br>\n\n    80805 München\n','MAT-DN-2022-00037','Delivery Note',8,3),
(4,'Streichinstrumente-Verleih Nestler GmbH','Rammstein','','MAT-DN-2022-00036','Delivery Note',8,3),
(5,'Streichinstrumente-Verleih Nestler GmbH','Sudhir','','MAT-DN-2022-00034','Delivery Note',8,3),
(6,'Streichinstrumente-Verleih Nestler GmbH','Sudhir','','MAT-DN-2022-00033','Delivery Note',8,3),
(7,'Streichinstrumente-Verleih Nestler GmbH','Sudhir','','MAT-DN-2022-00029','Delivery Note',8,3),
(8,'Streichinstrumente-Verleih Nestler GmbH','Sudhir','','MAT-DN-2022-00027','Delivery Note',8,3),
(9,'Streichinstrumente-Verleih Nestler GmbH','Felix Henke','Talstrassse 49<br>\n\n    08248 Klingenthal\n','MAT-DN-2022-00026','Delivery Note',8,3),
(10,'Streichinstrumente-Verleih Nestler GmbH','Rammstein','','MAT-DN-2022-00025','Delivery Note',8,3),
(11,'Mastri GmbH','Rammstein','','MAT-DN-2022-00017','Delivery Note',8,3),
(12,'Streichinstrumente-Verleih Nestler GmbH','Felix Henke','Talstrassse 49<br>\n\n    08248 Klingenthal\n','MAT-DN-2022-00011','Delivery Note',8,3),
(13,'Streichinstrumente-Verleih Nestler GmbH','Hubert Mayer','Hubertusstr. 15<br>\n\n    59556 Lippstadt\n','MAT-DN-2022-00009','Delivery Note',8,3),
(14,'Mastri GmbH','Sebastian Mortimer','Teststraße 1<br>\n\n    83022 Rosenheim\n','MAT-DN-2022-00004','Delivery Note',8,3),
(15,'Mastri GmbH','Sebastian Mortimer','Teststraße 1<br>\n\n    83022 Rosenheim\n','MAT-DN-2022-00002','Delivery Note',8,3);

/*Table structure for table `pending_shipments_items` */

DROP TABLE IF EXISTS `pending_shipments_items`;

CREATE TABLE `pending_shipments_items` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `shipment_id` int(255) DEFAULT NULL,
  `item_name` char(255) DEFAULT NULL,
  `package_size` char(8) DEFAULT NULL,
  `package_volume` float DEFAULT NULL,
  `qty` int(255) DEFAULT NULL,
  `serial_number` char(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;

/*Data for the table `pending_shipments_items` */

insert  into `pending_shipments_items`(`id`,`shipment_id`,`item_name`,`package_size`,`package_volume`,`qty`,`serial_number`) values 
(1,1,'Guitar Model 2015 (AS)','L',1.3,1,'ACC-ASS-2022-00035'),
(2,2,'Guitar Model 2019 (AS)','L',1.3,1,''),
(3,3,'Guitar Model 2016 (AS)','L',1.3,1,'ACC-ASS-2022-00039'),
(4,4,'Guitar Model 2015 (AS)','L',1.3,1,'ACC-ASS-2022-00034'),
(5,5,'Guitar Model 2016 (AS)','L',1.3,1,'ACC-ASS-2022-00041'),
(6,6,'Guitar Model 2015 (AS)','L',1.3,1,'ACC-ASS-2022-00040'),
(7,7,'Guitar Model 2015 (AS)','L',1.3,1,'ACC-ASS-2022-00034'),
(8,7,'Guitar Model 2016 (AS)','L',1.3,1,'ACC-ASS-2022-00003'),
(9,8,'Guitar Model 2015 (AS)','L',1.3,1,'ACC-ASS-2022-00020'),
(10,9,'Guitar Model 2015 (AS)','L',1.3,1,'ACC-ASS-2022-00019'),
(11,10,'Guitar Model 2015 (AS)','L',1.3,1,'ACC-ASS-2022-00007'),
(12,11,'Guitar Model 2016 (AS)','L',1.3,1,''),
(13,11,'Bow','L',1.3,2,''),
(14,12,'Guitar Model 2016 (AS)','L',1.3,1,'ACC-ASS-2022-00003'),
(15,13,'Guitar Model 2016 (AS)','L',1.3,1,'ACC-ASS-2022-00003'),
(16,14,'Guitar Model 2019 (AS)','L',1.3,1,''),
(17,15,'Guitar Model 2019 (RI)','L',1.3,1,'');

/*Table structure for table `routes` */

DROP TABLE IF EXISTS `routes`;

CREATE TABLE `routes` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `drv_id` int(255) DEFAULT NULL,
  `distance` float DEFAULT NULL,
  `duration` float DEFAULT NULL,
  `stops` int(11) DEFAULT NULL,
  `days` int(11) DEFAULT NULL,
  `volume` float DEFAULT NULL,
  `rt_status` int(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `routes` */

insert  into `routes`(`id`,`drv_id`,`distance`,`duration`,`stops`,`days`,`volume`,`rt_status`) values 
(1,1,2162.4,25,21,2,0,1),
(2,2,2019.1,25,41,2,0,0),
(3,3,1966.4,22,21,1,0,1),
(4,4,2328.1,24,13,1,0,1);

/*Table structure for table `vehicles` */

DROP TABLE IF EXISTS `vehicles`;

CREATE TABLE `vehicles` (
  `drv2vhc_vhc_id` int(11) NOT NULL AUTO_INCREMENT,
  `lisence` char(64) DEFAULT NULL,
  `vhc_name` char(64) DEFAULT NULL,
  `capacity` float DEFAULT NULL,
  `vhc_status` int(16) DEFAULT NULL,
  PRIMARY KEY (`drv2vhc_vhc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `vehicles` */

insert  into `vehicles`(`drv2vhc_vhc_id`,`lisence`,`vhc_name`,`capacity`,`vhc_status`) values 
(1,'3A-678398','volvo',5,1),
(2,'3A-678582','gmt',9.5,1),
(3,'C2-552323','benz',9,1),
(4,'EU-763331','ford',9,1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
