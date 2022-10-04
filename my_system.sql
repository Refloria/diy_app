CREATE DATABASE  IF NOT EXISTS `my_system` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `my_system`;
-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: localhost    Database: my_system
-- ------------------------------------------------------
-- Server version	5.7.28-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `introduction` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cover_pic` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `publish_time` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `last_edit_time` datetime DEFAULT NULL,
  `state` int(11) DEFAULT '0',
  `recommend` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `article_user_idx` (`user_id`),
  FULLTEXT KEY `title_index` (`title`),
  CONSTRAINT `article_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article`
--

LOCK TABLES `article` WRITE;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` VALUES (1,'烂漫樱花季，别忘了带上“她” ','<section style=\"\" powered-by=\"xiumi.us\"><section style=\"text-align: center;margin-top: 10px;margin-bottom: 10px;\"><section style=\"vertical-align: middle;display: inline-block;line-height: 0;\"><img class=\"\" data-ratio=\"0.5412262156448203\" data-src=\"https://mmbiz.qpic.cn/mmbiz_png/lF6gz3jag38RzOyASScRWSNWhogmATBEyjgmibtfHa5hGSLPfAib8noDacRGaHZ0l9rTt9IicpoY8QayXsmK1IWug/640?wx_fmt=png\" data-type=\"png\" data-w=\"473\" style=\"vertical-align: middle; width: 473px !important; height: auto !important; visibility: visible !important;\" _width=\"473px\" src=\"https://mmbiz.qpic.cn/mmbiz_png/lF6gz3jag38RzOyASScRWSNWhogmATBEyjgmibtfHa5hGSLPfAib8noDacRGaHZ0l9rTt9IicpoY8QayXsmK1IWug/640?wx_fmt=png&amp;tp=webp&amp;wxfrom=5&amp;wx_lazy=1&amp;wx_co=1\" crossorigin=\"anonymous\" alt=\"图片\" data-fail=\"0\"></section></section></section><p style=\"text-align: center;margin: 10px 0%;text-indent: 2em;\"><br></p><section style=\"display: inline-block;width: 95%;vertical-align: top;background-color: rgb(253, 233, 239);box-shadow: rgb(233, 120, 195) 0px 0px 8px inset;padding: 20px 10px 10px;border-width: 3px;border-radius: 0px;border-style: solid;border-color: rgb(255, 221, 219);\"><section powered-by=\"xiumi.us\"><section style=\"\"><section style=\"text-align: left;font-size: 15px;line-height: 1.8;\"><p>&nbsp; &nbsp; &nbsp; 各位小伙伴们，春回大地，樱花盛开，最近大家去赏樱了吗？樱花象征热烈、纯洁、高尚，也因此深受大家的喜爱。今天我们也在这樱花烂漫的季节，学做一款颜值与实用性并存的樱花包<img data-src=\"https://res.wx.qq.com/mpres/htmledition/images/icon/common/emotion_panel/emoji_wx/2_11.png\" data-ratio=\"1\" data-w=\"20\" style=\"color: rgb(110, 110, 110); white-space: normal; font-size: 16px; text-indent: 32px; background-color: rgb(245, 245, 245); display: inline-block; vertical-align: text-bottom; width: 20px !important; height: auto !important; visibility: visible !important;\" _width=\"20px\" src=\"https://res.wx.qq.com/mpres/htmledition/images/icon/common/emotion_panel/emoji_wx/2_11.png?tp=webp&amp;wxfrom=5&amp;wx_lazy=1&amp;wx_co=1\" crossorigin=\"anonymous\" alt=\"图片\" class=\"\" data-fail=\"0\"></p></section></section></section></section><p><br></p><section style=\"\" powered-by=\"xiumi.us\"><section style=\"text-align: center;margin-top: 10px;margin-bottom: 10px;\"><section style=\"vertical-align: middle;display: inline-block;line-height: 0;width: 80%;\"><img class=\"\" data-ratio=\"0.6666667\" data-src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBEhMR9lFichlazW0CgEQUFBSWCh3JT80oZOz5ytZQTnnZVkMuts9lrZPg/640?wx_fmt=jpeg\" data-type=\"jpeg\" data-w=\"1080\" style=\"vertical-align: middle; width: 100% !important; height: auto !important; visibility: visible !important;\" _width=\"100%\" src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBEhMR9lFichlazW0CgEQUFBSWCh3JT80oZOz5ytZQTnnZVkMuts9lrZPg/640?wx_fmt=jpeg&amp;tp=webp&amp;wxfrom=5&amp;wx_lazy=1&amp;wx_co=1\" crossorigin=\"anonymous\" alt=\"图片\" data-fail=\"0\"></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section style=\"text-align: center;font-size: 14px;color: rgb(160, 160, 160);\"><p>成品展示<br></p></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section><p><br></p></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section style=\"text-align: center;\"><p style=\"line-height: 1.75em;\">我们团队的95后女生看到后，</p><p style=\"line-height: 1.75em;\">表示第一眼就被惊艳到了呢</p><p style=\"line-height: 1.75em;\">如果身着和服，</p><p style=\"line-height: 1.75em;\">在樱花树下，</p><p style=\"line-height: 1.75em;\">提着这样一款浪漫樱花包，</p><p style=\"line-height: 1.75em;\">分分钟给你的写真增色不少</p><p><br></p><p style=\"text-align: center;\"><img class=\" __bg_gif\" data-ratio=\"1\" data-src=\"https://mmbiz.qpic.cn/mmbiz_gif/lF6gz3jag38RzOyASScRWSNWhogmATBEwH5rs0VkA9ic4GnnfyiaicWtImTjjWnveib7ZncXRJFdkgFKqjzIq1pnHQ/640?wx_fmt=gif\" data-type=\"gif\" data-w=\"270\" style=\"text-align: center; white-space: normal; width: 270px !important; height: auto !important; visibility: visible !important;\" _width=\"270px\" src=\"https://mmbiz.qpic.cn/mmbiz_gif/lF6gz3jag38RzOyASScRWSNWhogmATBEwH5rs0VkA9ic4GnnfyiaicWtImTjjWnveib7ZncXRJFdkgFKqjzIq1pnHQ/640?wx_fmt=gif&amp;tp=webp&amp;wxfrom=5&amp;wx_lazy=1\" data-order=\"0\" alt=\"图片\" data-fail=\"0\"></p><p><br></p><p>心动不如行动，</p><p>点开视频跟着老师一起学习吧</p></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section><p><br></p></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section><p><span data-ratio=\"1.7777777777777777\" id=\"js_tx_video_container_0.4918931618395186\" class=\"js_tx_video_container\" style=\"display: block; width: 677px; height: 393px;\"><iframe allow=\"autoplay; fullscreen\" allowfullscreen=\"true\" src=\"//v.qq.com/txp/iframe/player.html?origin=https%3A%2F%2Fmp.weixin.qq.com&amp;chid=17&amp;vid=q085205zr6j&amp;autoplay=false&amp;full=true&amp;show1080p=false&amp;isDebugIframe=false\" width=\"677\" height=\"380.8125\" frameborder=\"0\"></iframe></span></p><p><br></p><section powered-by=\"xiumi.us\" style=\"font-size: 16px;white-space: normal;\"><section style=\"margin-top: 10px;margin-bottom: 10px;text-align: center;\"><section style=\"vertical-align: middle;display: inline-block;line-height: 0;\"><img class=\" __bg_gif\" data-ratio=\"0.0984375\" data-src=\"https://mmbiz.qpic.cn/mmbiz_gif/lF6gz3jag382SibA41TMsvJoicJqVYXKaswkW30SYRRjWlicl9kPAVZo2k4pHA6WRYeibxTJDphLWGCRJTGq8GWLyQ/640?wx_fmt=gif\" data-type=\"gif\" data-w=\"640\" style=\"vertical-align: middle; width: 640px !important; height: auto !important; visibility: visible !important;\" _width=\"640px\" src=\"https://mmbiz.qpic.cn/mmbiz_gif/lF6gz3jag382SibA41TMsvJoicJqVYXKaswkW30SYRRjWlicl9kPAVZo2k4pHA6WRYeibxTJDphLWGCRJTGq8GWLyQ/640?wx_fmt=gif&amp;tp=webp&amp;wxfrom=5&amp;wx_lazy=1\" data-order=\"1\" alt=\"图片\" data-fail=\"0\"></section></section></section><section powered-by=\"xiumi.us\" style=\"font-size: 16px;white-space: normal;\"><section><section><p><br></p></section></section></section><section powered-by=\"xiumi.us\" style=\"font-size: 16px;white-space: normal;\"><section><section><section class=\"\" style=\"margin-top: 10px;margin-bottom: 10px;text-align: center;\"><section class=\"\" style=\"display: inline-block;vertical-align: middle;\"><section class=\"\" style=\"padding-right: 20px;padding-left: 20px;border-radius: 5px;display: inline-block;vertical-align: bottom;border-color: rgb(255, 202, 0);border-bottom-style: dashed;border-bottom-width: 1px;line-height: 1.2em;color: rgb(5, 5, 5);font-size: 18px;\"><p>图文详解</p></section><section class=\"\" style=\"margin-left: -0.8em;display: inline-block;vertical-align: bottom;width: 1.6em;overflow: hidden !important;\"><img data-ratio=\"1.6866667\" data-src=\"https://mmbiz.qpic.cn/mmbiz_gif/lF6gz3jag38tehyqFDyO8DYwlT89RllVwYrH1YJLFPic2WoIujceFSJqCT90kPozlXxzHCrUChyEHFdmKDTG0fA/640?wx_fmt=gif\" data-type=\"gif\" data-w=\"300\" style=\"vertical-align: middle; width: 25.6px !important; height: auto !important; visibility: visible !important;\" _width=\"25.6px\" src=\"https://mmbiz.qpic.cn/mmbiz_gif/lF6gz3jag38tehyqFDyO8DYwlT89RllVwYrH1YJLFPic2WoIujceFSJqCT90kPozlXxzHCrUChyEHFdmKDTG0fA/640?wx_fmt=gif&amp;tp=webp&amp;wxfrom=5&amp;wx_lazy=1\" class=\" __bg_gif\" data-order=\"2\" alt=\"图片\" data-fail=\"0\" width=\"100%\"></section></section></section><p><br></p><p>难度：★★☆☆☆</p><p>适合：零基础小白</p></section></section></section><p><br></p></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"margin-top: 10px;margin-bottom: 10px;text-align: center;\"><section style=\"display: inline-block;vertical-align: middle;\"><section style=\"background-color: rgb(254, 148, 131);width: 1.5em;height: 1.5em;font-size: 22px;line-height: 1.5em;color: rgb(255, 255, 255);\"><section>01</section></section><section style=\"width: 8px;height: 8px;margin-left: auto;margin-top: -8px;\"><section style=\"width: 0px;margin-left: auto;border-width: 4px;border-style: solid;border-color: rgb(107, 178, 171) rgb(255, 255, 255) rgb(255, 255, 255) rgb(107, 178, 171);\"></section></section></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"text-align: center;margin-top: 10px;margin-bottom: 10px;\"><section style=\"vertical-align: middle;display: inline-block;line-height: 0;width: 80%;\"><img class=\"\" data-ratio=\"0.562963\" data-src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBERtjQQAGlVY7tSFM3YmDtP9oThv0r5xIGy1OpGBReIWavYqzYP6yxzw/640?wx_fmt=jpeg\" data-type=\"jpeg\" data-w=\"1080\" style=\"vertical-align: middle; width: 100% !important; height: auto !important; visibility: visible !important;\" _width=\"100%\" src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBERtjQQAGlVY7tSFM3YmDtP9oThv0r5xIGy1OpGBReIWavYqzYP6yxzw/640?wx_fmt=jpeg&amp;tp=webp&amp;wxfrom=5&amp;wx_lazy=1&amp;wx_co=1\" crossorigin=\"anonymous\" alt=\"图片\" data-fail=\"0\"></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section><p style=\"white-space: normal;\">准备材料：两片正方形布片、两个纽扣、两朵樱花、两个木珠、绳子若干</p></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section><p><br></p></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"margin-top: 10px;margin-bottom: 10px;text-align: center;\"><section style=\"display: inline-block;vertical-align: middle;\"><section style=\"background-color: rgb(254, 148, 131);width: 1.5em;height: 1.5em;font-size: 22px;line-height: 1.5em;color: rgb(255, 255, 255);\"><p>02</p></section><section style=\"width: 8px;height: 8px;margin-left: auto;margin-top: -8px;\"><section style=\"width: 0px;margin-left: auto;border-width: 4px;border-style: solid;border-color: rgb(107, 178, 171) rgb(255, 255, 255) rgb(255, 255, 255) rgb(107, 178, 171);\"></section></section></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"text-align: center;margin-top: 10px;margin-bottom: 10px;\"><section style=\"vertical-align: middle;display: inline-block;line-height: 0;width: 80%;\"><img class=\"\" data-ratio=\"0.562963\" data-src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBE0FIpicoNlq8uY7N9Y75jSYUic3S7tagLicJibX8zrLtDc2XEJmFbmiaFMOQ/640?wx_fmt=jpeg\" data-type=\"jpeg\" data-w=\"1080\" style=\"vertical-align: middle; width: 100% !important; height: auto !important; visibility: visible !important;\" _width=\"100%\" src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBE0FIpicoNlq8uY7N9Y75jSYUic3S7tagLicJibX8zrLtDc2XEJmFbmiaFMOQ/640?wx_fmt=jpeg&amp;tp=webp&amp;wxfrom=5&amp;wx_lazy=1&amp;wx_co=1\" crossorigin=\"anonymous\" alt=\"图片\" data-fail=\"0\"></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section style=\"text-align: center;\"><p style=\"text-align: center;\">两片布片正面相对，留一个返口，缝合四边</p></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section><p><br></p></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"margin-top: 10px;margin-bottom: 10px;text-align: center;\"><section style=\"display: inline-block;vertical-align: middle;\"><section style=\"background-color: rgb(254, 148, 131);width: 1.5em;height: 1.5em;font-size: 22px;line-height: 1.5em;color: rgb(255, 255, 255);\"><p>03</p></section><section style=\"width: 8px;height: 8px;margin-left: auto;margin-top: -8px;\"><section style=\"width: 0px;margin-left: auto;border-width: 4px;border-style: solid;border-color: rgb(107, 178, 171) rgb(255, 255, 255) rgb(255, 255, 255) rgb(107, 178, 171);\"></section></section></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"text-align: center;margin-top: 10px;margin-bottom: 10px;\"><section style=\"vertical-align: middle;display: inline-block;line-height: 0;width: 80%;\"><img class=\"\" data-ratio=\"0.562963\" data-src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBE77bMJJIQGcGPu78m1ezBDGGlDBWSO6VVlicfplAjDJxNgLVTOxyGRNQ/640?wx_fmt=jpeg\" data-type=\"jpeg\" data-w=\"1080\" style=\"vertical-align: middle; width: 100% !important; height: auto !important; visibility: visible !important;\" _width=\"100%\" src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBE77bMJJIQGcGPu78m1ezBDGGlDBWSO6VVlicfplAjDJxNgLVTOxyGRNQ/640?wx_fmt=jpeg&amp;tp=webp&amp;wxfrom=5&amp;wx_lazy=1&amp;wx_co=1\" crossorigin=\"anonymous\" alt=\"图片\" data-fail=\"0\"></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section style=\"text-align: center;\"><p>翻到正面，藏针缝缝合返口</p></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section><p><br></p></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"margin-top: 10px;margin-bottom: 10px;text-align: center;\"><section style=\"display: inline-block;vertical-align: middle;\"><section style=\"background-color: rgb(254, 148, 131);width: 1.5em;height: 1.5em;font-size: 22px;line-height: 1.5em;color: rgb(255, 255, 255);\"><p>04</p></section><section style=\"width: 8px;height: 8px;margin-left: auto;margin-top: -8px;\"><section style=\"width: 0px;margin-left: auto;border-width: 4px;border-style: solid;border-color: rgb(107, 178, 171) rgb(255, 255, 255) rgb(255, 255, 255) rgb(107, 178, 171);\"></section></section></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"text-align: center;margin-top: 10px;margin-bottom: 10px;\"><section style=\"vertical-align: middle;display: inline-block;line-height: 0;width: 80%;\"><img class=\"\" data-ratio=\"0.562963\" data-src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBETia3ftVJIcIPmRUJNLgKeHwxUrkicE7tlBy4akfbibfMxPXGCTTlbRI0A/640?wx_fmt=jpeg\" data-type=\"jpeg\" data-w=\"1080\" style=\"vertical-align: middle; width: 100% !important; height: auto !important; visibility: visible !important;\" _width=\"100%\" src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBETia3ftVJIcIPmRUJNLgKeHwxUrkicE7tlBy4akfbibfMxPXGCTTlbRI0A/640?wx_fmt=jpeg&amp;tp=webp&amp;wxfrom=5&amp;wx_lazy=1&amp;wx_co=1\" crossorigin=\"anonymous\" alt=\"图片\" data-fail=\"0\"></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section style=\"text-align: center;\"><p>沿对角线对折</p></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section><p><br></p></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"margin-top: 10px;margin-bottom: 10px;text-align: center;\"><section style=\"display: inline-block;vertical-align: middle;\"><section style=\"background-color: rgb(254, 148, 131);width: 1.5em;height: 1.5em;font-size: 22px;line-height: 1.5em;color: rgb(255, 255, 255);\"><p>05</p></section><section style=\"width: 8px;height: 8px;margin-left: auto;margin-top: -8px;\"><section style=\"width: 0px;margin-left: auto;border-width: 4px;border-style: solid;border-color: rgb(107, 178, 171) rgb(255, 255, 255) rgb(255, 255, 255) rgb(107, 178, 171);\"></section></section></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"text-align: center;margin-top: 10px;margin-bottom: 10px;\"><section style=\"vertical-align: middle;display: inline-block;line-height: 0;width: 80%;\"><img class=\"\" data-ratio=\"0.562963\" data-src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBEVvwic9HNA89NnqHk4ibknz0UIoIjGDkFicrRDuvcfKzWQZ3klUMRdw4XQ/640?wx_fmt=jpeg\" data-type=\"jpeg\" data-w=\"1080\" style=\"vertical-align: middle; width: 100% !important; height: auto !important; visibility: visible !important;\" _width=\"100%\" src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBEVvwic9HNA89NnqHk4ibknz0UIoIjGDkFicrRDuvcfKzWQZ3klUMRdw4XQ/640?wx_fmt=jpeg&amp;tp=webp&amp;wxfrom=5&amp;wx_lazy=1&amp;wx_co=1\" crossorigin=\"anonymous\" alt=\"图片\" data-fail=\"0\"></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section style=\"text-align: center;\"><p>底边分成三等分，</p><p>往上画直线，<span style=\"letter-spacing: 0px;\">缝合所画直线</span></p></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section><p><br></p></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"margin-top: 10px;margin-bottom: 10px;text-align: center;\"><section style=\"display: inline-block;vertical-align: middle;\"><section style=\"background-color: rgb(254, 148, 131);width: 1.5em;height: 1.5em;font-size: 22px;line-height: 1.5em;color: rgb(255, 255, 255);\"><p>06</p></section><section style=\"width: 8px;height: 8px;margin-left: auto;margin-top: -8px;\"><section style=\"width: 0px;margin-left: auto;border-width: 4px;border-style: solid;border-color: rgb(107, 178, 171) rgb(255, 255, 255) rgb(255, 255, 255) rgb(107, 178, 171);\"></section></section></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"text-align: center;margin-top: 10px;margin-bottom: 10px;\"><section style=\"vertical-align: middle;display: inline-block;line-height: 0;width: 80%;\"><img class=\"\" data-ratio=\"0.562963\" data-src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBExrgDYdibFU2hianichBJRv2O4XyP9Tgz5265ovjS8kVJbHWlwFO1icW00g/640?wx_fmt=jpeg\" data-type=\"jpeg\" data-w=\"1080\" style=\"vertical-align: middle; width: 100% !important; height: auto !important; visibility: visible !important;\" _width=\"100%\" src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBExrgDYdibFU2hianichBJRv2O4XyP9Tgz5265ovjS8kVJbHWlwFO1icW00g/640?wx_fmt=jpeg&amp;tp=webp&amp;wxfrom=5&amp;wx_lazy=1&amp;wx_co=1\" crossorigin=\"anonymous\" alt=\"图片\" data-fail=\"0\"></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section style=\"text-align: center;\"><p>将左右两个三角形拉开成正方形，</p><p>顶部往下折</p></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section><p><br></p></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"margin-top: 10px;margin-bottom: 10px;text-align: center;\"><section style=\"display: inline-block;vertical-align: middle;\"><section style=\"background-color: rgb(254, 148, 131);width: 1.5em;height: 1.5em;font-size: 22px;line-height: 1.5em;color: rgb(255, 255, 255);\"><p>07</p></section><section style=\"width: 8px;height: 8px;margin-left: auto;margin-top: -8px;\"><section style=\"width: 0px;margin-left: auto;border-width: 4px;border-style: solid;border-color: rgb(107, 178, 171) rgb(255, 255, 255) rgb(255, 255, 255) rgb(107, 178, 171);\"></section></section></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"text-align: center;margin-top: 10px;margin-bottom: 10px;\"><section style=\"vertical-align: middle;display: inline-block;line-height: 0;width: 80%;\"><img class=\"\" data-ratio=\"0.562963\" data-src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBEUJBe90oYYQAagK89ibFHxeHAsInib0p6trJV0fYPLFt2723E6ziamCO3Q/640?wx_fmt=jpeg\" data-type=\"jpeg\" data-w=\"1080\" style=\"vertical-align: middle; width: 100% !important; height: auto !important; visibility: visible !important;\" _width=\"100%\" src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBEUJBe90oYYQAagK89ibFHxeHAsInib0p6trJV0fYPLFt2723E6ziamCO3Q/640?wx_fmt=jpeg&amp;tp=webp&amp;wxfrom=5&amp;wx_lazy=1&amp;wx_co=1\" crossorigin=\"anonymous\" alt=\"图片\" data-fail=\"0\"></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section style=\"text-align: center;\"><p>三个点缝在一起</p></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section><p><br></p></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"margin-top: 10px;margin-bottom: 10px;text-align: center;\"><section style=\"display: inline-block;vertical-align: middle;\"><section style=\"background-color: rgb(254, 148, 131);width: 1.5em;height: 1.5em;font-size: 22px;line-height: 1.5em;color: rgb(255, 255, 255);\"><p>08</p></section><section style=\"width: 8px;height: 8px;margin-left: auto;margin-top: -8px;\"><section style=\"width: 0px;margin-left: auto;border-width: 4px;border-style: solid;border-color: rgb(107, 178, 171) rgb(255, 255, 255) rgb(255, 255, 255) rgb(107, 178, 171);\"></section></section></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"text-align: center;margin-top: 10px;margin-bottom: 10px;\"><section style=\"vertical-align: middle;display: inline-block;line-height: 0;width: 80%;\"><img class=\"\" data-ratio=\"0.562963\" data-src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBEo3XolLZ24VxgibbXXIJAMaibV5T8IYhATKcQkxnJ48dRibELZVeuZk2Ew/640?wx_fmt=jpeg\" data-type=\"jpeg\" data-w=\"1080\" style=\"vertical-align: middle; width: 100% !important; height: auto !important; visibility: visible !important;\" _width=\"100%\" src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBEo3XolLZ24VxgibbXXIJAMaibV5T8IYhATKcQkxnJ48dRibELZVeuZk2Ew/640?wx_fmt=jpeg&amp;tp=webp&amp;wxfrom=5&amp;wx_lazy=1&amp;wx_co=1\" crossorigin=\"anonymous\" alt=\"图片\" data-fail=\"0\"></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section><p style=\"white-space: normal;text-align: center;\">左边的正方形往下折，</p><p style=\"white-space: normal;text-align: center;\">手缝固定并缝上纽扣，<span style=\"letter-spacing: 0px;\">右边同样操作</span></p></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section><p><br></p></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"margin-top: 10px;margin-bottom: 10px;text-align: center;\"><section style=\"display: inline-block;vertical-align: middle;\"><section style=\"background-color: rgb(254, 148, 131);width: 1.5em;height: 1.5em;font-size: 22px;line-height: 1.5em;color: rgb(255, 255, 255);\"><p>09</p></section><section style=\"width: 8px;height: 8px;margin-left: auto;margin-top: -8px;\"><section style=\"width: 0px;margin-left: auto;border-width: 4px;border-style: solid;border-color: rgb(107, 178, 171) rgb(255, 255, 255) rgb(255, 255, 255) rgb(107, 178, 171);\"></section></section></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"text-align: center;margin-top: 10px;margin-bottom: 10px;\"><section style=\"vertical-align: middle;display: inline-block;line-height: 0;width: 80%;\"><img class=\"\" data-ratio=\"0.562963\" data-src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBE9MkpEe4cANtJUVVKjhCsVBygXicbnOgOYLxlE06icjEWJ9icriaGozLOQQ/640?wx_fmt=jpeg\" data-type=\"jpeg\" data-w=\"1080\" style=\"vertical-align: middle; width: 100% !important; height: auto !important; visibility: visible !important;\" _width=\"100%\" src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBE9MkpEe4cANtJUVVKjhCsVBygXicbnOgOYLxlE06icjEWJ9icriaGozLOQQ/640?wx_fmt=jpeg&amp;tp=webp&amp;wxfrom=5&amp;wx_lazy=1&amp;wx_co=1\" crossorigin=\"anonymous\" alt=\"图片\" data-fail=\"0\"></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section style=\"text-align: center;\"><p>翻到背面，</p><p>左右和上部顶点往中间折，手缝固定</p></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section><p><br></p></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"margin-top: 10px;margin-bottom: 10px;text-align: center;\"><section style=\"display: inline-block;vertical-align: middle;\"><section style=\"background-color: rgb(254, 148, 131);width: 1.5em;height: 1.5em;font-size: 22px;line-height: 1.5em;color: rgb(255, 255, 255);\"><p>10</p></section><section style=\"width: 8px;height: 8px;margin-left: auto;margin-top: -8px;\"><section style=\"width: 0px;margin-left: auto;border-width: 4px;border-style: solid;border-color: rgb(107, 178, 171) rgb(255, 255, 255) rgb(255, 255, 255) rgb(107, 178, 171);\"></section></section></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"text-align: center;margin-top: 10px;margin-bottom: 10px;\"><section style=\"vertical-align: middle;display: inline-block;line-height: 0;width: 80%;\"><img class=\"\" data-ratio=\"0.562963\" data-src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBE0UU4eLErmYeA3XobN8qKt64oSk8v7nouwdPdqoAib8u4YvPzribRzpgQ/640?wx_fmt=jpeg\" data-type=\"jpeg\" data-w=\"1080\" style=\"vertical-align: middle; width: 100% !important; height: auto !important; visibility: visible !important;\" _width=\"100%\" src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBE0UU4eLErmYeA3XobN8qKt64oSk8v7nouwdPdqoAib8u4YvPzribRzpgQ/640?wx_fmt=jpeg&amp;tp=webp&amp;wxfrom=5&amp;wx_lazy=1&amp;wx_co=1\" crossorigin=\"anonymous\" alt=\"图片\" data-fail=\"0\"></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section style=\"text-align: center;\"><p>将内部翻出，折7cm的角，车缝</p></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section><p><br></p></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"margin-top: 10px;margin-bottom: 10px;text-align: center;\"><section style=\"display: inline-block;vertical-align: middle;\"><section style=\"background-color: rgb(254, 148, 131);width: 1.5em;height: 1.5em;font-size: 22px;line-height: 1.5em;color: rgb(255, 255, 255);\"><p>11</p></section><section style=\"width: 8px;height: 8px;margin-left: auto;margin-top: -8px;\"><section style=\"width: 0px;margin-left: auto;border-width: 4px;border-style: solid;border-color: rgb(107, 178, 171) rgb(255, 255, 255) rgb(255, 255, 255) rgb(107, 178, 171);\"></section></section></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"text-align: center;margin-top: 10px;margin-bottom: 10px;\"><section style=\"vertical-align: middle;display: inline-block;line-height: 0;width: 80%;\"><img class=\"\" data-ratio=\"0.562963\" data-src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBEt7gJMWmJs3u7ZYibbPP2TucAIbu0HrXfiaEHRxjxZpMNLcvt8X8SXnQg/640?wx_fmt=jpeg\" data-type=\"jpeg\" data-w=\"1080\" style=\"vertical-align: middle; width: 100% !important; height: auto !important; visibility: visible !important;\" _width=\"100%\" src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBEt7gJMWmJs3u7ZYibbPP2TucAIbu0HrXfiaEHRxjxZpMNLcvt8X8SXnQg/640?wx_fmt=jpeg&amp;tp=webp&amp;wxfrom=5&amp;wx_lazy=1&amp;wx_co=1\" crossorigin=\"anonymous\" alt=\"图片\" data-fail=\"0\"></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section style=\"text-align: center;\"><p>翻回外面，</p><p>离顶部数厘米车缝以留出串绳的通道</p></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section><p><br></p></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"margin-top: 10px;margin-bottom: 10px;text-align: center;\"><section style=\"display: inline-block;vertical-align: middle;\"><section style=\"background-color: rgb(254, 148, 131);width: 1.5em;height: 1.5em;font-size: 22px;line-height: 1.5em;color: rgb(255, 255, 255);\"><p>12</p></section><section style=\"width: 8px;height: 8px;margin-left: auto;margin-top: -8px;\"><section style=\"width: 0px;margin-left: auto;border-width: 4px;border-style: solid;border-color: rgb(107, 178, 171) rgb(255, 255, 255) rgb(255, 255, 255) rgb(107, 178, 171);\"></section></section></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"text-align: center;margin-top: 10px;margin-bottom: 10px;\"><section style=\"vertical-align: middle;display: inline-block;line-height: 0;width: 80%;\"><img class=\"\" data-ratio=\"0.562963\" data-src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBEeB4icCs7tCfrZnX8OkZln9nYMHzdDPzqr9r3Kn9O6TqibV9dDMKk7hEg/640?wx_fmt=jpeg\" data-type=\"jpeg\" data-w=\"1080\" style=\"vertical-align: middle; width: 100% !important; height: auto !important; visibility: visible !important;\" _width=\"100%\" src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBEeB4icCs7tCfrZnX8OkZln9nYMHzdDPzqr9r3Kn9O6TqibV9dDMKk7hEg/640?wx_fmt=jpeg&amp;tp=webp&amp;wxfrom=5&amp;wx_lazy=1&amp;wx_co=1\" crossorigin=\"anonymous\" alt=\"图片\" data-fail=\"0\"></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"text-align: center;margin-top: 10px;margin-bottom: 10px;\"><section style=\"vertical-align: middle;display: inline-block;line-height: 0;width: 80%;\"><img class=\"\" data-ratio=\"0.562963\" data-src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBE4OCicy2tSaPbef8HpSJexu2UBazXJfG0sxrGLswTYqHvGA9MTH0ia9bA/640?wx_fmt=jpeg\" data-type=\"jpeg\" data-w=\"1080\" style=\"vertical-align: middle; width: 100% !important; height: auto !important; visibility: visible !important;\" _width=\"100%\" src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBE4OCicy2tSaPbef8HpSJexu2UBazXJfG0sxrGLswTYqHvGA9MTH0ia9bA/640?wx_fmt=jpeg&amp;tp=webp&amp;wxfrom=5&amp;wx_lazy=1&amp;wx_co=1\" crossorigin=\"anonymous\" alt=\"图片\" data-fail=\"0\"></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"text-align: center;margin-top: 10px;margin-bottom: 10px;\"><section style=\"vertical-align: middle;display: inline-block;line-height: 0;width: 80%;\"><img class=\"\" data-ratio=\"0.562963\" data-src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBEQJZicJpaKG553zyeypqHZHiafhE5Yicts2ibAvKObeoP18yZzEIwxVkIoQ/640?wx_fmt=jpeg\" data-type=\"jpeg\" data-w=\"1080\" style=\"vertical-align: middle; width: 100% !important; height: auto !important; visibility: visible !important;\" _width=\"100%\" src=\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBEQJZicJpaKG553zyeypqHZHiafhE5Yicts2ibAvKObeoP18yZzEIwxVkIoQ/640?wx_fmt=jpeg&amp;tp=webp&amp;wxfrom=5&amp;wx_lazy=1&amp;wx_co=1\" crossorigin=\"anonymous\" alt=\"图片\" data-fail=\"0\"></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section style=\"text-align: center;\"><p>缝上花朵，穿绳后完成樱花包</p></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section><p><br></p></section></section></section><section powered-by=\"xiumi.us\"><section style=\"\"><section><p><br></p></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"text-align: center;margin-top: 10px;margin-bottom: 10px;\"><section style=\"vertical-align: middle;display: inline-block;line-height: 0;\"><img class=\"\" data-ratio=\"0.05421686746987952\" data-src=\"https://mmbiz.qpic.cn/mmbiz_png/lF6gz3jag38RzOyASScRWSNWhogmATBEFBAnQ8aonkCS6xA1xdbprHc1r77xnuY6YPb6xLDhea1p9XiaKdHAD3g/640?wx_fmt=png\" data-type=\"png\" data-w=\"664\" style=\"vertical-align: middle; width: 664px !important; height: auto !important; visibility: visible !important;\" _width=\"664px\" src=\"https://mmbiz.qpic.cn/mmbiz_png/lF6gz3jag38RzOyASScRWSNWhogmATBEFBAnQ8aonkCS6xA1xdbprHc1r77xnuY6YPb6xLDhea1p9XiaKdHAD3g/640?wx_fmt=png&amp;tp=webp&amp;wxfrom=5&amp;wx_lazy=1&amp;wx_co=1\" crossorigin=\"anonymous\" alt=\"图片\" data-fail=\"0\"></section></section></section><section style=\"\" powered-by=\"xiumi.us\"><section style=\"text-align: center;margin-top: 10px;margin-bottom: 10px;\"><br></section></section>',NULL,'http://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38RzOyASScRWSNWhogmATBEdE5pxZy8N6IjXVwnDnASfyn2HTDY3bJkB1aDOWxj1eWoRl9T3yzzgw/0','2019-03-22 00:00:00',0,'2019-03-22 00:00:00',1,0),(2,'手残党福音，一小时就能完成的春日“小清新”笔袋 ','',NULL,'http://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag38Ko6E0fctVxxBiaA9wIupX4lI2HP8mCgiahgHzAARsKfaIib7JICezfymLRdic93QqqoT8uAib8PFmtfw/0','2019-03-29 00:00:00',0,'2019-03-29 00:00:00',1,0),(3,'上新！低调奢华有内涵的复古风口金包也能亲手做了','',NULL,'http://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag3ibNH02VBhN9XwC4v1ZlwXUPM9lL8jnUic2IcRxrN2oqsS2hHkOBPA6PjME63wwm0GnggyeCFZcaicOg/0','2019-04-04 00:00:00',0,'2019-04-04 00:00:00',0,0),(4,'一方桌旗，万千国韵，快来彰显你的生活美学','',NULL,'http://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag3iby5icvViaFgdXlfbxzK2UeAWgeJmYzExictvrJUsUEeTvaPV5bvUtvEWmDu48pbXtLEvp6L16BWKKQQ/0','2019-04-12 00:00:00',0,'2019-04-12 00:00:00',0,0),(5,'清新夏日-森系简约风电脑包','',NULL,'http://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag3ib7tRq6vcm5Wlicr24YSAVSShhun2zQIFhGTOy1ZhNdG4SJeU2f0PzicAnLxPYLic6LkNUPzOy5pyicew/0','2019-04-26 00:00:00',0,'2019-04-26 00:00:00',0,0),(6,'手作体验 | 用双手的温度传递对妈妈的爱','',NULL,'http://mmbiz.qpic.cn/mmbiz_jpg/zicOib41CTCdTCiaicyGMe2lP4dI59RhLibYPFCDaE5M9OShoHtGsGOcNkdGiaBBjvBialQW7ZWLKXvd77wknR0kDYiarw/0','2019-05-10 00:00:00',0,'2019-05-10 00:00:00',0,0),(7,'带上日式和风便当包，从此做个精致社会人','',NULL,'http://mmbiz.qpic.cn/mmbiz_jpg/zicOib41CTCdRxfayPPxaCADzTnibnUIajfHUthQtPe7iaiaINvYcNfiaEF77ksAStqGXeicbwia3yiawFO4ia1HtLSGNdibg/0','2019-05-24 00:00:00',0,'2019-05-24 00:00:00',0,0),(8,'父爱如山，吉“象”如意','',NULL,'http://mmbiz.qpic.cn/mmbiz_jpg/zicOib41CTCdTxG2kiaF8CAcJf3GtYx1ofKrLdPibSMHYiaXxzuvianSv3I12dnUAzWSFV9wK2szURLorMmpP0Ldia3zA/0','2019-06-14 00:00:00',0,'2019-06-14 00:00:00',0,0),(9,'手作欣赏 | 这大概是每个热爱生活的人所向往的生活吧','',NULL,'http://mmbiz.qpic.cn/mmbiz_jpg/zicOib41CTCdQTjmFkJhZjone5AaeTicUUtUGgKSq06DsiczQFV59NSqNz3ViclQCFlS8puqlbWu6fhyxQcu69YsXbQ/0','2019-05-31 00:00:00',0,'2019-05-31 00:00:00',2,0),(10,'520，有你相伴，携手有喵一生(>^ω^<)','',NULL,'http://mmbiz.qpic.cn/mmbiz_jpg/zicOib41CTCdTUjicNaYyfZJupwyf2I5JM2C0AY3BEowlcuXLvibFeZ2Uz1kLLsxu9J6HuTbEPJthmAVpgiaN1jYkqA/0','2019-05-17 00:00:00',0,'2019-05-17 00:00:00',1,0),(11,'儿童节特辑 | 为你的小可爱做条经典格子裙吧?','',NULL,'http://mmbiz.qpic.cn/mmbiz_jpg/zicOib41CTCdQTjmFkJhZjone5AaeTicUUt1vbLgdTzGzGy4FuFUlIxLLgUbxnqnx2Rv0vpFG7qC3SRbfx7XEc3wg/0','2019-05-31 00:00:00',0,'2019-05-31 00:00:00',1,0),(12,'百搭森系零钱包，从此开启淑女范','',NULL,'http://mmbiz.qpic.cn/mmbiz_jpg/zicOib41CTCdTyS8SWUQLpMTycccN7XfBoekurdPRdibQRpiaiaxPa50vC1cdO67d6kCVEjibcQlGX4QFyfylkXjGJgQ/0','2019-06-21 00:00:00',0,'2019-06-21 00:00:00',1,1),(13,'呆萌喵星人笔袋，陪伴孩子每一天（附上期获奖名单）','',NULL,'http://mmbiz.qpic.cn/mmbiz_jpg/zicOib41CTCdTMibSVy4loJ2DoZujGfPWQY6Q55Tw5ic6JHia8Gz4yA26WqeIyPwUwRjnTDRshJR840efCW3pSNtbxw/0','2019-07-05 00:00:00',0,'2019-07-05 00:00:00',0,0),(14,'端午特辑 | “粽”情有新意，永远“包”容你','',NULL,'http://mmbiz.qpic.cn/mmbiz_jpg/zicOib41CTCdQp4RZw9j3TAiaK9klJjYel4GibLGhKIBcLrQgMvZeO5QptRWrHV4OTtKtxg6IWVtxbKMefXdXWXfDg/0','2019-06-06 00:00:00',0,'2019-06-06 00:00:00',2,0),(15,'七夕特辑 |  上新！实用性碾压LV口红包的帆布小方包','',NULL,'http://mmbiz.qpic.cn/mmbiz_jpg/zicOib41CTCdTqoiaA6GBAK9BFaUfZwo3qzMrn8L4uZFLz30QDvP4470j8gZ02UzdOx6EZq3FoP4ZzeU2I8y6FvGg/0','2019-08-06 00:00:00',0,'2019-08-06 00:00:00',1,0),(16,'简约，舒适，做一款“三心二意”的花朵靠枕','',NULL,'http://mmbiz.qpic.cn/mmbiz_jpg/zicOib41CTCdSVMmgA16uEaHnYjkuZRRUiaqhVsEVK2iaF4ZibXribQYUa9dfakN2VsTYPsb61k2HCNRskIaOhCIAYMQ/0','2019-07-19 00:00:00',0,'2019-07-19 00:00:00',0,0),(17,'憨态可掬小狮子包，孩子背上颜值高','',NULL,'http://mmbiz.qpic.cn/mmbiz_jpg/zicOib41CTCdRvhbXWuLiaicHibueCK3581KibSkIlLHJlCwOJ9FliccXACMbxhhrgG6Ocmsnlp3QjGmj86dLwpOOcl2A/0','2019-07-26 00:00:00',0,'2019-07-26 00:00:00',2,0),(18,'修身碎花连衣裙，清凉一夏做仙女（附上期获奖名单）','',NULL,'http://mmbiz.qpic.cn/mmbiz_jpg/zicOib41CTCdRN1dV9GicTj9N9kE81jbV7nRich4ib7qard17e0JicDq74ynpNvPUxMGVO94npSS3CJHwce4QCqlkW8w/0','2019-07-12 00:00:00',0,'2019-07-12 00:00:00',0,0),(19,'感受《哪吒》的火热，用手作回味《狮子王》的经典','',NULL,'http://mmbiz.qpic.cn/mmbiz_jpg/zicOib41CTCdSa35wicavMOJ8whZicnHxHWibKHeMyGWkvq3pnibX17CcG49zjLZ3YH3QiaynE3pKoEY61u8s29QRVYCA/0','2019-08-02 00:00:00',0,'2019-08-02 00:00:00',0,0),(20,'复古文艺风手提包，尽显优雅与自信','',NULL,'http://mmbiz.qpic.cn/mmbiz_jpg/zicOib41CTCdQbrzM3G8PRt4ttYGiaDZiatXPY6ibb7IK9a74QswUyylYRKlXqb5tSFW7kLQWUVRdfX7UAjAic9pS8jQ/0','2019-08-16 00:00:00',0,'2019-08-16 00:00:00',1,0),(21,'为爱豆打call！亲手制作明星同款娃衣','',NULL,'http://mmbiz.qpic.cn/mmbiz_jpg/zicOib41CTCdSSAjyNxibh26kxKiaG0PVeuMV8wujY3dGYCFOVL4YYxgTZcCnd8XFYvDYqtAicPfJOibygk7YGu8O0Yw/0','2019-08-23 00:00:00',0,'2019-08-23 00:00:00',1,0),(22,'出门必备！百搭又文艺的渔夫帽也能自己搞定啦（附尺寸图）','',NULL,'http://mmbiz.qpic.cn/mmbiz_jpg/zicOib41CTCdR4TpIAibYrNFNM3vrvUN5tK9CPU8icia6t2Cd7aDZVEv2KBuESsV6mSaRXFFLlF0ADs65uicV6ErFEqg/0','2019-09-12 00:00:00',0,'2019-09-12 00:00:00',1,1),(23,'日系单肩休闲包，尽显秋日的优雅','',NULL,'http://mmbiz.qpic.cn/mmbiz_jpg/zicOib41CTCdQhAH1XicpapGIib45b6qRtbicoSicW9DAehSMZhGfQW6QvzoEicKzJ68BoaiaPTHmwO0cfhicB5atichfSzA/0','2019-10-11 00:00:00',0,'2019-10-11 00:00:00',1,1),(24,'创意拼布果盘，彰显家居艺术品味','',NULL,'http://mmbiz.qpic.cn/mmbiz_jpg/zicOib41CTCdSwGWtdYMgjJLcvicqlATKSia1v1z3ehVkLDy0scblMqrR5Aqe10mvVKcoY2DiaYErTZnZRhBuaUl0dg/0','2019-11-21 00:00:00',0,'2019-11-21 00:00:00',1,0),(25,'优雅复古口金包，重温过去美好时光','[{\"insert\":\"测试一下❤️\\n\\n\"}]',NULL,'http://mmbiz.qpic.cn/sz_mmbiz_jpg/zicOib41CTCdTIOrM9AnIv3ZWH03cictOr0RoGenanuJFdamy9lwYJS34nB9DhSmNGHSA4AicR6dad8oWme61rBMBg/0','2019-12-06 00:00:00',0,'2021-02-23 16:38:21',1,0),(26,'新生婴儿软底鞋，呵护宝宝的小脚丫','',NULL,'http://mmbiz.qpic.cn/sz_mmbiz_jpg/zicOib41CTCdRiaPib6j76qb03XQLn4PsGDbtFicniaNceLKCicUf5Tv0DXTu6v5X18ic455jicvokX4c1dIyHfrnOYYvRQ/0','2019-11-29 00:00:00',0,'2019-11-29 00:00:00',1,0),(27,'上新！适合新手妈妈上手的婴儿裤来啦?','',NULL,'http://mmbiz.qpic.cn/mmbiz_jpg/zicOib41CTCdSZDKlt8l0uKbJk8URqlnO17ViaFdlLOm1MvRUbRbruiaxLY2gLNRy1n4xIdqt2fiawiaJ4ibCSRFIM56A/0','2019-11-12 00:00:00',0,'2019-11-12 00:00:00',1,0),(28,'宝妈必备！亲手为宝宝做件婴儿衫（附图纸）','',NULL,'http://mmbiz.qpic.cn/mmbiz_jpg/zicOib41CTCdQVucdhmrC4RF2AdAoXmTictsdkq3xvZczPDsJmiblMnsT5scSTyKzAicocibCpKSuZjlu3l3iaNZ0iaLHQ/0','2019-11-07 00:00:00',0,'2019-11-07 00:00:00',1,0),(29,'复古文艺风笔套，Apple Pencil的新衣裳','[{\"insert\":\"        各位小伙伴们，大家平时会怎么爱护自己心爱的钢笔或者Apple Pencil呢？这些文具都非常娇贵，需要我们的小心呵护?\\n        今天就教大家用15分钟制作属于自己的复古文艺风笔套，颜值与实用性都在线哟?\\n\\n成品展示\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":2}},{\"insert\":\"\\n\"},{\"insert\":{\"image\":\"https://mmbiz.qpic.cn/sz_mmbiz_jpg/zicOib41CTCdTkKic7ogojaVq4pMHt43gnp1huIFHgwl1rXiba8jJnGwo4qZ122NVtQCvc755auGFWZgaIne5BtdQQ/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1\"}},{\"insert\":\"\\n想要知道怎么做？\\n赶紧跟着教程学习吧\\n\\n图文详解\"},{\"insert\":\"\\n\",\"attributes\":{\"header\":2}},{\"insert\":\"\\n难度：★☆☆☆☆\\n适合：布艺初学者\\n\\n尺寸图\\n\"},{\"insert\":{\"image\":\"https://mmbiz.qpic.cn/sz_mmbiz_jpg/zicOib41CTCdS98yWhCP7VcBBE0fPSMwjTicZqicicBiblCfjyPo4pI57mGj6moqgdLAnkUmliaHgpMroMLMEtWZOHosw/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1\"}},{\"insert\":\"\\n\\n01  准备材料：布料，无纺衬\\n\"},{\"insert\":{\"image\":\"https://mmbiz.qpic.cn/sz_mmbiz_jpg/zicOib41CTCdTkKic7ogojaVq4pMHt43gnpyF4fW91v7qZic6BeATcR3VBDXQEcGV30M6j3zQmMRYZYLQ5NxllYFCQ/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1\"}},{\"insert\":\"\\n\\n02  按尺寸裁剪布料，表布一片，里布一片\\n\"},{\"insert\":{\"image\":\"https://mmbiz.qpic.cn/sz_mmbiz_jpg/zicOib41CTCdTkKic7ogojaVq4pMHt43gnpZAjviceErCG1oib3SfpPbiasG1nTToialpMoUK5Kt4hsrMNibuCJpsLLqJQ/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1\"}},{\"insert\":\"\\n\\n03  表布烫上无纺衬\\n\"},{\"insert\":{\"image\":\"https://mmbiz.qpic.cn/sz_mmbiz_jpg/zicOib41CTCdTkKic7ogojaVq4pMHt43gnpjDefMwmkvebWX6y1mu3rZjliaU7yNxOBKZhaT49WFL9vPA82zuibiaCUA/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1\"}},{\"insert\":\"\\n\\n04  表布里布正面相对反面朝外，车缝一圈，一边留返口\\n\"},{\"insert\":{\"image\":\"https://mmbiz.qpic.cn/sz_mmbiz_jpg/zicOib41CTCdTkKic7ogojaVq4pMHt43gnpJ0BAgcmqV939ibf1s5reW4YNJDNcyy7GuMiakfsE4nGU96S1ic6eF4LLQ/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1\"}},{\"insert\":\"\\n\\n05  翻到正面\\n\"},{\"insert\":{\"image\":\"https://mmbiz.qpic.cn/sz_mmbiz_jpg/zicOib41CTCdTkKic7ogojaVq4pMHt43gnp8WsnGWR33jeMl9zy7MrFduEo7qYp4JTchUfxga5CmMkqToaU89BHBw/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1\"}},{\"insert\":\"\\n\\n06  四周车缝0.1cm\\n\"},{\"insert\":{\"image\":\"https://mmbiz.qpic.cn/sz_mmbiz_jpg/zicOib41CTCdTkKic7ogojaVq4pMHt43gnpc850BgmUFtIsczv4ibb2z0RlGlUqvS6XfMjtN9B6U7IoOvvy9tFlkqQ/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1\"}},{\"insert\":\"\\n\\n07  长的一边对折，长边袋口处留3cm不缝，余下两边车缝\\n\"},{\"insert\":{\"image\":\"https://mmbiz.qpic.cn/sz_mmbiz_jpg/zicOib41CTCdTkKic7ogojaVq4pMHt43gnpUiakEG1ptXpTVMvq72C2K7SoFLbegKKG9VnOYrs7bMbAuq14EdYoAwQ/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1\"}},{\"insert\":\"\\n\\n08  完成\\n\"},{\"insert\":{\"image\":\"https://mmbiz.qpic.cn/sz_mmbiz_jpg/zicOib41CTCdTkKic7ogojaVq4pMHt43gnpPGD17H6ic6K6zGy5Fdz3ZeqYWQdWETrEH2ZXdsiaOA53DYsvYVQnRJAg/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1\"}},{\"insert\":\"\\n\\n\"},{\"insert\":\"———————————————————————————\",\"attributes\":{\"color\":\"#d6d6d6\"}},{\"insert\":\"\\n\\n        想要成为别人眼中的布艺达人吗？也许你和这个目标只有一台缝纫机的距离。制作此次呆萌小象的“蝴蝶牌”JD1197LB源自德国的设计，使它多了不同于其他机型的工业风。\\n\"},{\"insert\":{\"image\":\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag382SibA41TMsvJoicJqVYXKas9eEFiaQfM2rhyL6Y3vVpVvF5bqeicsU015gpGGVBeQyUzPYSxnPpJicmg/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1\"}},{\"insert\":\"\\n        内置的197种线迹，能够提供更大的创作空间，也让你的作品独一无二\\n\"},{\"insert\":{\"image\":\"https://mmbiz.qpic.cn/mmbiz_jpg/lF6gz3jag382SibA41TMsvJoicJqVYXKaslL75iajribGNPn0goaGdYygT7GjRqibxBcTlWguW6ZZnAYRojl1UmwCuQ/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1\"}},{\"insert\":\"\\n        该机型在京东、天猫平台都有售哟?\\n\\n\"}]',NULL,'http://mmbiz.qpic.cn/sz_mmbiz_jpg/zicOib41CTCdTkKic7ogojaVq4pMHt43gnp0D4tzlwOFpP4DmjLJfZ1J0OmfCRW83LErUuiaMwhib4et0otX2XfdC8A/0','2020-04-24 00:00:00',0,'2021-02-23 15:25:33',1,1),(32,'文章测试','[{\"insert\":\"测试用文章\\n\"},{\"insert\":{\"image\":\"https://gitee.com/huyc2020/images/raw/master/img/41326r-lz4ual-lkkxsb-1bb9wg.jpg\"}},{\"insert\":\"\\n\\n\\n\"}]',NULL,'http://photo.16pic.com/00/33/83/16pic_3383794_b.jpg','2021-03-04 10:36:21',8,'2021-04-01 10:22:32',1,0),(33,'测试一下','[{\"insert\":\"\\n\"}]',NULL,'https://gitee.com/huyc2020/images/raw/master/img/3jqcgl-7k4gpn-94uos6-cocip4.jpg','2021-03-15 18:24:15',8,'2021-03-15 18:24:15',2,0),(34,'布制包包','[{\"insert\":\"一起来学着做一下包包吧\\n\"}]',NULL,'https://gitee.com/huyc2020/images/raw/master/img/wt89k0-l2qig2-aj9ecb-textma.jpg','2021-03-29 09:40:34',8,'2021-03-29 09:36:13',0,0),(35,'日式拎包','[{\"insert\":\"准备材料\"},{\"insert\":\"\\n\",\"attributes\":{\"indent\":1}},{\"insert\":{\"image\":\"https://gitee.com/huyc2020/images/raw/master/img/mohu5n-5qgduo-s0cu3l-qjbchr.jpg\"}},{\"insert\":\"\\n剪裁\\n\"},{\"insert\":{\"image\":\"https://gitee.com/huyc2020/images/raw/master/img/avvm14-54dkck-wgseq0-hjfmbt.jpg\"}},{\"insert\":\"\\n\\n缝制\\n\"},{\"insert\":{\"image\":\"https://gitee.com/huyc2020/images/raw/master/img/7y69i5-i0v6qg-7wq1w5-xy1qaf.jpg\"}},{\"insert\":\"\\n\\n\"}]',NULL,'https://gitee.com/huyc2020/images/raw/master/img/p8h71v-a0dhiy-3kir2s-t4b03d.jpg','2021-04-07 18:32:53',9,'2021-04-07 18:33:40',1,0),(36,'布艺花','[{\"insert\":\"准备材料\"},{\"insert\":\"\\n\",\"attributes\":{\"indent\":1}},{\"insert\":{\"image\":\"https://gitee.com/huyc2020/images/raw/master/img/n3fpu5-xyyari-yknmvn-1mcuwzwebp\"}},{\"insert\":\"\\n剪裁\"},{\"insert\":\"\\n\",\"attributes\":{\"indent\":1}},{\"insert\":{\"image\":\"https://gitee.com/huyc2020/images/raw/master/img/6a0thn-jceves-l86l5k-zmijb7webp\"}},{\"insert\":\"\\n缝制\\n\"},{\"insert\":{\"image\":\"https://gitee.com/huyc2020/images/raw/master/img/u8ua2a-8a09bc-ynz8fi-i4bfsvwebp\"}},{\"insert\":\"\\n\\n\\n\"}]',NULL,'https://gitee.com/huyc2020/images/raw/master/img/kf0b05-4kqem0-lzpyu2-p7sqes.jpg','2021-04-14 12:15:14',8,'2021-04-14 12:16:29',0,0);
/*!40000 ALTER TABLE `article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authority`
--

DROP TABLE IF EXISTS `authority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authority` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authority`
--

LOCK TABLES `authority` WRITE;
/*!40000 ALTER TABLE `authority` DISABLE KEYS */;
INSERT INTO `authority` VALUES (1,'admin','管理员权限'),(2,'user','用户权限');
/*!40000 ALTER TABLE `authority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `article_id` int(11) DEFAULT NULL,
  `content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_idx` (`user_id`),
  KEY `article_id_idx` (`article_id`),
  CONSTRAINT `comment_article` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `comment_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,8,29,'真棒','2021-03-21 14:19:58'),(3,9,29,'nice','2021-03-21 14:51:20'),(4,0,32,'1','2021-03-23 15:31:46'),(5,0,32,'2','2021-03-23 15:32:05'),(6,0,32,'3','2021-03-23 15:32:10'),(7,0,32,'4','2021-03-23 15:35:19'),(8,0,32,'5','2021-03-23 15:35:24'),(9,0,32,'6','2021-03-23 15:35:29'),(10,0,32,'','2021-03-24 15:31:11'),(11,0,32,'上面那个怎么是空的','2021-03-24 16:22:46'),(12,8,11,'可爱','2021-03-28 00:02:09'),(13,8,1,'樱花快开了，赶紧学起来?','2021-03-28 00:13:27'),(18,8,29,'good','2021-04-14 12:12:46');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment_reply`
--

DROP TABLE IF EXISTS `comment_reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment_reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `quote_reply_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comment_reply_idx` (`comment_id`),
  KEY `comment_reply_user_idx` (`user_id`),
  KEY `comment_reply_quote_idx` (`quote_reply_id`),
  CONSTRAINT `comment_reply` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `comment_reply_quote` FOREIGN KEY (`quote_reply_id`) REFERENCES `comment_reply` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `comment_reply_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_reply`
--

LOCK TABLES `comment_reply` WRITE;
/*!40000 ALTER TABLE `comment_reply` DISABLE KEYS */;
INSERT INTO `comment_reply` VALUES (1,1,0,'谢谢，好开心~','2021-03-21 14:35:58',NULL),(2,1,8,'嘿嘿','2021-03-21 14:36:37',1),(3,3,0,'谢谢','2021-03-23 15:30:22',NULL),(4,4,0,'1.1','2021-03-24 14:30:55',NULL),(5,4,0,'1.1.1','2021-03-24 14:31:21',4),(6,4,0,'1.1.1.1','2021-03-24 14:41:22',NULL),(7,4,0,'啦啦啦','2021-03-24 14:41:47',5),(8,5,0,'2.1','2021-03-24 14:43:51',NULL),(9,4,0,'1.2','2021-03-24 14:45:18',NULL),(10,6,0,'3.1','2021-03-24 15:03:04',NULL),(11,5,0,'2.1.2','2021-03-24 15:04:38',8),(12,4,0,'1.2.1','2021-03-24 15:10:52',9),(13,4,0,'1.2.2','2021-03-24 15:11:50',9),(14,6,0,'3.2','2021-03-24 15:12:09',NULL),(15,7,0,'4.1','2021-03-24 15:13:24',NULL),(16,8,0,'5.1','2021-03-24 15:19:23',NULL),(21,4,0,'1.2.2.1','2021-03-24 15:24:37',13),(22,4,0,'1.3','2021-03-24 15:28:12',NULL),(23,9,0,'好难点中啊','2021-03-24 16:23:08',NULL),(24,7,0,'4.2','2021-03-24 16:31:26',NULL),(25,4,0,'再来一下','2021-03-24 16:41:06',4),(27,3,8,'very good','2021-04-14 12:12:57',NULL);
/*!40000 ALTER TABLE `comment_reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorite`
--

DROP TABLE IF EXISTS `favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `article_id` int(11) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_idx` (`user_id`),
  KEY `article_id_idx` (`article_id`),
  CONSTRAINT `favorite_article` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `favorite_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorite`
--

LOCK TABLES `favorite` WRITE;
/*!40000 ALTER TABLE `favorite` DISABLE KEYS */;
INSERT INTO `favorite` VALUES (9,8,24,'2021-03-09 14:58:46'),(10,0,25,'2021-03-15 18:11:11'),(11,0,32,'2021-03-18 10:31:34'),(13,0,29,'2021-03-22 23:19:50'),(14,8,10,'2021-03-29 14:15:08'),(15,8,25,'2021-03-29 14:15:57'),(16,8,20,'2021-04-01 10:53:19'),(21,9,29,'2021-04-07 18:30:57'),(22,8,29,'2021-04-14 12:12:35');
/*!40000 ALTER TABLE `favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follow`
--

DROP TABLE IF EXISTS `follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `follow_user_id` int(11) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_idx` (`user_id`),
  KEY `follow_user_id_idx` (`follow_user_id`),
  CONSTRAINT `follow_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `follow_user_followed` FOREIGN KEY (`follow_user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follow`
--

LOCK TABLES `follow` WRITE;
/*!40000 ALTER TABLE `follow` DISABLE KEYS */;
INSERT INTO `follow` VALUES (22,0,8,'2021-03-25 15:36:29'),(26,9,0,'2021-04-07 18:31:37'),(27,9,8,'2021-04-14 11:28:04'),(30,8,9,'2021-05-16 14:52:33');
/*!40000 ALTER TABLE `follow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'管理员','admin'),(2,'普通用户','user');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_authority`
--

DROP TABLE IF EXISTS `role_authority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_authority` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL,
  `authority_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `authority_idx` (`authority_id`),
  KEY `role_id_idx` (`role_id`),
  CONSTRAINT `role_authority_authority` FOREIGN KEY (`authority_id`) REFERENCES `authority` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `role_authority_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_authority`
--

LOCK TABLES `role_authority` WRITE;
/*!40000 ALTER TABLE `role_authority` DISABLE KEYS */;
INSERT INTO `role_authority` VALUES (1,1,1),(2,2,2);
/*!40000 ALTER TABLE `role_authority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `nickname` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `role_id` int(11) DEFAULT '2',
  `introduction` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `sex` char(1) CHARACTER SET utf8mb4 DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `picture` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `last_time` datetime DEFAULT NULL,
  `register_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  KEY `role_id_idx` (`role_id`),
  CONSTRAINT `user_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (0,'fxjy','$2a$10$xSgsIdQFnJIK3B1L5GPCdOr.xRmyZqJcTsdvgAZ6EyD.XodyPPb3S','缝绣小能手',2,NULL,NULL,NULL,'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3923955211,3442737639&fm=26&gp=0.jpg',NULL,NULL),(1,'admin','$2a$10$xSgsIdQFnJIK3B1L5GPCdOr.xRmyZqJcTsdvgAZ6EyD.XodyPPb3S','管理员',1,NULL,NULL,NULL,NULL,NULL,NULL),(2,'user','$2a$10$WEm7MYzwVEl2Q5MeflVz1.exqhaZp83/L66FrFeF10kT7/aKorm/G','测试用户',2,NULL,NULL,NULL,NULL,NULL,NULL),(3,'bander','$2a$10$7gT35cUujbuizyPeLLYWVebhpBMprTckrjjxEDgZ6N6Sc8kX7ISki','测试品牌',2,NULL,NULL,NULL,NULL,NULL,NULL),(8,'tailor','$2a$10$zPJfhRTiEXyVNUOFeKJkP.OiSMjSnglAJ6qTVVg1v2jErgzsImsmW','小裁缝',2,'啦啦啦啦～','男','2009-07-06','https://gitee.com/huyc2020/images/raw/master/img/1eo816-6956y8-vtdb0n-g4nv0z.jpg',NULL,'2021-03-01 16:23:41'),(9,'abcde','$2a$10$luiKEQiQJeyDEVEc/oAmoeg6Prf2QLh2ClDRKb/KsCfFmeHBmFaby','缝绣ABC',2,'大家好','男','2021-03-09','https://gitee.com/huyc2020/images/raw/master/img/dhvpeg-alm5jl-que0qx-18uehl.jpg',NULL,'2021-03-02 11:15:12'),(10,'LittleTrailor','$2a$10$7Zf9AZ/w6PblGyNfF6W1De/Ukr8StWvjosVpTBU//DD9POMNniLVy','LittleTrailor',2,NULL,NULL,NULL,NULL,NULL,'2021-03-04 09:32:43'),(11,'LitteTailor','$2a$10$MtrmD1hk1gkBlnHrLt3/9u9TZ//hD/hWNHaZCe.kF7x4AtB668NtW','LitteTailor',2,NULL,NULL,NULL,NULL,NULL,'2021-03-04 09:47:46');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'my_system'
--

--
-- Dumping routines for database 'my_system'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-29 12:51:35
