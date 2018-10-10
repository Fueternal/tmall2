/*
SQLyog 企业版 - MySQL GUI v8.14 
MySQL - 5.5.40 : Database - tmall
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`tmall` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `tmall`;

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `categoryId` int(11) NOT NULL AUTO_INCREMENT COMMENT '类别ID',
  `categoryName` varchar(20) DEFAULT NULL COMMENT '类别名',
  PRIMARY KEY (`categoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

/*Data for the table `category` */

insert  into `category`(`categoryId`,`categoryName`) values (1,'智能手机'),(2,'男装'),(3,'测试分类3'),(6,'测试分类6'),(7,'测试分类7'),(8,'测试分类8'),(9,'测试分类9'),(11,'手机'),(12,'手机2'),(13,'手机3'),(14,'手机4'),(15,'手机5'),(16,'手机6'),(17,'手机7');

/*Table structure for table `orderitem` */

DROP TABLE IF EXISTS `orderitem`;

CREATE TABLE `orderitem` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `userId` int(11) DEFAULT NULL COMMENT '对应的用户ID',
  `orderId` int(11) DEFAULT NULL COMMENT '对应的订单ID',
  `productId` int(11) DEFAULT NULL COMMENT '对应的产品ID',
  `number` int(11) DEFAULT NULL COMMENT '购买数量',
  PRIMARY KEY (`itemId`),
  KEY `fk_orderitem_users` (`userId`),
  KEY `fk_orderitem_orders` (`orderId`),
  KEY `fk_orderitem_product` (`productId`),
  CONSTRAINT `fk_orderitem_orders` FOREIGN KEY (`orderId`) REFERENCES `orders` (`orderId`),
  CONSTRAINT `fk_orderitem_product` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`),
  CONSTRAINT `fk_orderitem_users` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `orderitem` */

insert  into `orderitem`(`itemId`,`userId`,`orderId`,`productId`,`number`) values (1,1,1,1,3),(2,1,2,5,2),(3,7,3,5,3);

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `orderId` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `orderCode` varchar(255) DEFAULT NULL COMMENT '订单编号',
  `userId` int(11) DEFAULT NULL COMMENT '对应的用户ID',
  `receiver` varchar(20) DEFAULT NULL COMMENT '收件人姓名',
  `address` varchar(255) DEFAULT NULL COMMENT '收件人地址',
  `phone` varchar(255) DEFAULT NULL COMMENT '收件人电话',
  `post` varchar(255) DEFAULT NULL COMMENT '收件人邮编',
  `userMessage` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `createDate` datetime DEFAULT NULL COMMENT '订单创建时间',
  `payDate` datetime DEFAULT NULL COMMENT '支付时间',
  `deliveryDate` datetime DEFAULT NULL COMMENT '发货时间',
  `confirmDate` datetime DEFAULT NULL COMMENT '确认收货时间',
  `status` varchar(255) DEFAULT NULL COMMENT '订单状态',
  PRIMARY KEY (`orderId`),
  KEY `fk_orders_users` (`userId`),
  CONSTRAINT `fk_orders_users` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `orders` */

insert  into `orders`(`orderId`,`orderCode`,`userId`,`receiver`,`address`,`phone`,`post`,`userMessage`,`createDate`,`payDate`,`deliveryDate`,`confirmDate`,`status`) values (1,'A0000001',1,'李琴','河北省衡水市桃城区宝云街88号','13333334217','322300','备注备注备注备注备注','2018-09-10 00:00:00',NULL,NULL,NULL,'waitDelivery'),(2,'A0000002',1,'李沁','浙江省杭州市江干区','18888889632','322311','请小心运输','2018-09-09 00:00:00',NULL,NULL,NULL,'waitDelivery'),(3,'201810081020387363727',7,NULL,'浙江省杭州市',NULL,'310000','','2018-10-08 10:20:38','2018-10-08 10:20:42','2018-10-08 14:22:16','2018-10-09 15:26:45','finish');

/*Table structure for table `product` */

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `productId` int(11) NOT NULL AUTO_INCREMENT COMMENT '产品ID',
  `categoryId` int(11) DEFAULT NULL COMMENT '产品所属类别ID',
  `productName` varchar(255) DEFAULT NULL COMMENT '产品名',
  `subTitle` varchar(255) DEFAULT NULL COMMENT '产品小标题',
  `originalPrice` float DEFAULT NULL COMMENT '原始价格',
  `promotePrice` float DEFAULT NULL COMMENT '优惠价格',
  `stock` int(11) DEFAULT NULL COMMENT '库存数量',
  `createDate` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`productId`),
  KEY `fk_product_category` (`categoryId`),
  CONSTRAINT `fk_product_category` FOREIGN KEY (`categoryId`) REFERENCES `category` (`categoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `product` */

insert  into `product`(`productId`,`categoryId`,`productName`,`subTitle`,`originalPrice`,`promotePrice`,`stock`,`createDate`) values (1,1,'华为honor/荣耀10手机','全网通荣耀10 全网最低2399',2599,2399,888,'2018-09-06 18:39:21'),(2,1,'iPhone X','iPhone X 刘海屏 苹果最新一代手机',7999,7993.99,111,'2018-09-06 18:40:08'),(3,1,'HTC one8','曾经的王者归来zzzzz',1999,1799,99,'2018-09-06 18:43:16'),(5,1,'小米8 高通骁龙845 全面屏旗舰 2018新款','高通骁龙845 全面屏旗舰',2799,2699,33,'2018-09-07 08:58:48');

/*Table structure for table `productimage` */

DROP TABLE IF EXISTS `productimage`;

CREATE TABLE `productimage` (
  `imageId` int(11) NOT NULL AUTO_INCREMENT COMMENT '产品图片ID',
  `productId` int(11) DEFAULT NULL COMMENT '对应的产品ID',
  `type` varchar(255) DEFAULT NULL COMMENT '产品图片类型',
  PRIMARY KEY (`imageId`),
  KEY `fk_productImage_product` (`productId`),
  CONSTRAINT `fk_productImage_product` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `productimage` */

insert  into `productimage`(`imageId`,`productId`,`type`) values (11,5,'type_single'),(12,5,'type_single'),(13,5,'type_detail');

/*Table structure for table `productproperty` */

DROP TABLE IF EXISTS `productproperty`;

CREATE TABLE `productproperty` (
  `productPropertyId` int(11) NOT NULL AUTO_INCREMENT COMMENT '产品属性ID',
  `productId` int(11) DEFAULT NULL COMMENT '对应的产品ID',
  `propertyId` int(11) DEFAULT NULL COMMENT '对应类别的属性ID',
  `value` varchar(255) DEFAULT NULL COMMENT '产品描述',
  PRIMARY KEY (`productPropertyId`),
  KEY `fk_productProperty_product` (`productId`),
  KEY `fk_productProperty_property` (`propertyId`),
  CONSTRAINT `fk_productProperty_product` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`),
  CONSTRAINT `fk_productProperty_property` FOREIGN KEY (`propertyId`) REFERENCES `property` (`propertyId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `productproperty` */

insert  into `productproperty`(`productPropertyId`,`productId`,`propertyId`,`value`) values (1,5,1,NULL),(2,5,6,NULL),(3,5,7,NULL),(4,5,8,NULL);

/*Table structure for table `property` */

DROP TABLE IF EXISTS `property`;

CREATE TABLE `property` (
  `propertyId` int(11) NOT NULL AUTO_INCREMENT COMMENT '类别属性ID',
  `categoryId` int(11) DEFAULT NULL COMMENT '类别ID',
  `propertyName` varchar(20) DEFAULT NULL COMMENT '类别属性名',
  PRIMARY KEY (`propertyId`),
  KEY `fk_property_category` (`categoryId`),
  CONSTRAINT `fk_property_category` FOREIGN KEY (`categoryId`) REFERENCES `category` (`categoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `property` */

insert  into `property`(`propertyId`,`categoryId`,`propertyName`) values (1,1,'品牌'),(2,3,'等级'),(3,2,'品牌'),(4,2,'材质'),(6,1,'屏幕尺寸'),(7,1,'操作系统'),(8,1,'型号');

/*Table structure for table `review` */

DROP TABLE IF EXISTS `review`;

CREATE TABLE `review` (
  `reviewId` int(11) NOT NULL AUTO_INCREMENT COMMENT '评价ID',
  `productId` int(11) DEFAULT NULL COMMENT '对应的产品ID',
  `userId` int(11) DEFAULT NULL COMMENT '评价人即用户ID',
  `content` varchar(4000) DEFAULT NULL COMMENT '评价内容',
  `createDate` datetime DEFAULT NULL COMMENT '评价时间',
  PRIMARY KEY (`reviewId`),
  KEY `fk_review_product` (`productId`),
  KEY `fk_review_users` (`userId`),
  CONSTRAINT `fk_review_product` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`),
  CONSTRAINT `fk_review_users` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `review` */

insert  into `review`(`reviewId`,`productId`,`userId`,`content`,`createDate`) values (1,5,7,'小米8还是非常不错的，这次做的很是给力啊！','2018-10-09 15:27:22');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `userId` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `userName` varchar(20) DEFAULT NULL COMMENT '用户名',
  `password` varchar(20) DEFAULT NULL COMMENT '用户密码',
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `users` */

insert  into `users`(`userId`,`userName`,`password`) values (1,'一号','123456'),(2,'二号','123456'),(3,'fhf','147258369'),(4,'测试账户','111111'),(5,'test','222222'),(6,'aaa','aaa'),(7,'111','111');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
