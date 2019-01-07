/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50553
Source Host           : 127.0.0.1:3306
Source Database       : demo

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-11-24 18:25:46
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for guanli_banji
-- ----------------------------
DROP TABLE IF EXISTS `guanli_banji`;
CREATE TABLE `guanli_banji` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `bname` varchar(255) DEFAULT NULL COMMENT '班级名称',
  `zid` int(10) unsigned DEFAULT NULL COMMENT '外键关联专业id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of guanli_banji
-- ----------------------------
INSERT INTO `guanli_banji` VALUES ('1', '快乐1101', '1');
INSERT INTO `guanli_banji` VALUES ('2', '峡谷101', '2');

-- ----------------------------
-- Table structure for guanli_chengji
-- ----------------------------
DROP TABLE IF EXISTS `guanli_chengji`;
CREATE TABLE `guanli_chengji` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `uid` int(10) unsigned DEFAULT NULL COMMENT '管理userid',
  `kaoid` int(10) unsigned DEFAULT NULL COMMENT '关联考试id',
  `chengji` varchar(255) DEFAULT NULL COMMENT '学生成绩',
  `type` varchar(255) DEFAULT NULL COMMENT '学生状态：1为已完成，2为缺考，3为作弊',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of guanli_chengji
-- ----------------------------
INSERT INTO `guanli_chengji` VALUES ('1', '1', '1', '22', '1');
INSERT INTO `guanli_chengji` VALUES ('2', '4', '1', '90', '1');

-- ----------------------------
-- Table structure for guanli_error
-- ----------------------------
DROP TABLE IF EXISTS `guanli_error`;
CREATE TABLE `guanli_error` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `uid` int(10) unsigned DEFAULT NULL COMMENT '关联用户的id',
  `ip` varchar(255) DEFAULT NULL COMMENT '用户登录的ip地址',
  `logintime` datetime DEFAULT NULL COMMENT '用户第一次登录时间',
  `error` varchar(255) DEFAULT NULL COMMENT '用户登录错误次数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of guanli_error
-- ----------------------------
INSERT INTO `guanli_error` VALUES ('1', '3', '127.0.0.1', '2018-11-24 15:59:24', '0');
INSERT INTO `guanli_error` VALUES ('6', null, '127.0.0.1', '2018-11-20 09:44:56', '0');
INSERT INTO `guanli_error` VALUES ('7', '2', '127.0.0.1', '2018-11-20 17:45:04', '0');
INSERT INTO `guanli_error` VALUES ('8', '1', '127.0.0.1', '2018-11-20 17:38:36', '0');
INSERT INTO `guanli_error` VALUES ('9', '4', '127.0.0.1', '2018-11-20 17:07:02', '0');

-- ----------------------------
-- Table structure for guanli_jiaoshi
-- ----------------------------
DROP TABLE IF EXISTS `guanli_jiaoshi`;
CREATE TABLE `guanli_jiaoshi` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `xid` int(10) unsigned DEFAULT NULL COMMENT '关联学院id',
  `jname` varchar(255) DEFAULT NULL COMMENT '教师姓名',
  `job` varchar(255) DEFAULT NULL COMMENT '教师职称',
  `kid` int(10) unsigned DEFAULT NULL COMMENT '关联课程id',
  `jian` text COMMENT '简介',
  `jpg` varchar(255) DEFAULT NULL COMMENT '头像',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of guanli_jiaoshi
-- ----------------------------
INSERT INTO `guanli_jiaoshi` VALUES ('1', '1', '詹姆斯', '辅导员', '1', '我教书贼6', '20181116\\751c4a2c6311e25df438058f19680954.jpg');
INSERT INTO `guanli_jiaoshi` VALUES ('2', '2', '大帝', '磨铁老师', '1', '磨铁贼厉害', '20181116\\c59e0579022e63c9eaf1a9cd5c65917f.jpg');

-- ----------------------------
-- Table structure for guanli_kaoshi
-- ----------------------------
DROP TABLE IF EXISTS `guanli_kaoshi`;
CREATE TABLE `guanli_kaoshi` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `uid` int(10) unsigned DEFAULT NULL COMMENT '关联user的id',
  `timu` text COMMENT '考试题目id',
  `kaitime` datetime DEFAULT NULL COMMENT '开始时间',
  `jietime` datetime DEFAULT NULL COMMENT '结束时间',
  `state` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '考试状态：1为考试进行中，2为考试已结束',
  `del` varchar(255) NOT NULL DEFAULT '1' COMMENT '状态：1为显示，2为删除',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of guanli_kaoshi
-- ----------------------------
INSERT INTO `guanli_kaoshi` VALUES ('1', '2', 'a:4:{s:4:\"dans\";a:20:{i:0;i:27;i:1;i:26;i:2;i:24;i:3;i:23;i:4;i:22;i:5;i:21;i:6;i:20;i:7;i:18;i:8;i:17;i:9;i:15;i:10;i:14;i:11;i:12;i:12;i:11;i:13;i:10;i:14;i:9;i:15;i:8;i:16;i:7;i:17;i:6;i:18;i:5;i:19;i:4;}s:4:\"duos\";a:10:{i:0;i:46;i:1;i:45;i:2;i:44;i:3;i:43;i:4;i:40;i:5;i:39;i:6;i:37;i:7;i:36;i:8;i:34;i:9;i:33;}s:4:\"pans\";a:5:{i:0;i:58;i:1;i:56;i:2;i:54;i:3;i:51;i:4;i:50;}s:5:\"tians\";a:5:{i:0;i:68;i:1;i:67;i:2;i:65;i:3;i:64;i:4;i:63;}}', '2018-11-20 14:35:39', '2018-11-20 16:05:39', '2', '1');
INSERT INTO `guanli_kaoshi` VALUES ('2', '2', 'a:4:{s:4:\"dans\";a:20:{i:0;i:31;i:1;i:29;i:2;i:28;i:3;i:25;i:4;i:24;i:5;i:22;i:6;i:21;i:7;i:19;i:8;i:17;i:9;i:16;i:10;i:15;i:11;i:14;i:12;i:11;i:13;i:10;i:14;i:9;i:15;i:8;i:16;i:7;i:17;i:6;i:18;i:5;i:19;i:2;}s:4:\"duos\";a:10:{i:0;i:47;i:1;i:45;i:2;i:43;i:3;i:42;i:4;i:41;i:5;i:40;i:6;i:39;i:7;i:38;i:8;i:34;i:9;i:33;}s:4:\"pans\";a:5:{i:0;i:59;i:1;i:57;i:2;i:55;i:3;i:53;i:4;i:50;}s:5:\"tians\";a:5:{i:0;i:68;i:1;i:67;i:2;i:64;i:3;i:63;i:4;i:62;}}', '2018-11-20 17:14:04', '2018-11-21 10:35:04', '2', '1');

-- ----------------------------
-- Table structure for guanli_kecheng
-- ----------------------------
DROP TABLE IF EXISTS `guanli_kecheng`;
CREATE TABLE `guanli_kecheng` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `zid` int(10) unsigned DEFAULT NULL COMMENT '关联的专业id',
  `kname` varchar(255) DEFAULT NULL COMMENT '课程名称',
  `kshuoming` varchar(255) DEFAULT NULL COMMENT '课程说明',
  `kmust` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否必修；0为必修，1为不必修',
  `kcom` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否公共课：0为公共课，1为非公共课',
  `kfen` varchar(255) DEFAULT NULL COMMENT '课程学分',
  `kshi` varchar(255) DEFAULT NULL COMMENT '课程学时',
  `kmian` varchar(255) DEFAULT NULL COMMENT '封面教材',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of guanli_kecheng
-- ----------------------------
INSERT INTO `guanli_kecheng` VALUES ('1', '1', '车床', '这门课很好', '0', '0', '20', '5', '20181116\\751c4a2c6311e25df438058f19680954.jpg');
INSERT INTO `guanli_kecheng` VALUES ('2', '2', '补刀', '最基本才最重要', '0', '0', '50', '5', '20181116\\fce6c248c08d80204eed63fce4dccd58.jpeg');

-- ----------------------------
-- Table structure for guanli_lianxi
-- ----------------------------
DROP TABLE IF EXISTS `guanli_lianxi`;
CREATE TABLE `guanli_lianxi` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `uid` int(10) unsigned DEFAULT NULL COMMENT '管理用户id',
  `dans` varchar(255) DEFAULT NULL COMMENT '单选题',
  `duos` varchar(255) DEFAULT NULL COMMENT '多选题',
  `pans` varchar(255) DEFAULT NULL COMMENT '判断题',
  `tians` varchar(255) DEFAULT NULL COMMENT '填空题',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of guanli_lianxi
-- ----------------------------
INSERT INTO `guanli_lianxi` VALUES ('1', '1', 'a:10:{i:0;i:93;i:1;i:91;i:2;i:89;i:3;i:88;i:4;i:86;i:5;i:84;i:6;i:83;i:7;i:80;i:8;i:79;i:9;i:74;}', 'a:5:{i:0;i:104;i:1;i:103;i:2;i:100;i:3;i:99;i:4;i:98;}', 'a:5:{i:0;i:114;i:1;i:113;i:2;i:111;i:3;i:110;i:4;i:107;}', 'a:5:{i:0;i:123;i:1;i:122;i:2;i:121;i:3;i:119;i:4;i:118;}');
INSERT INTO `guanli_lianxi` VALUES ('2', '3', 'a:10:{i:0;i:91;i:1;i:89;i:2;i:88;i:3;i:87;i:4;i:86;i:5;i:85;i:6;i:84;i:7;i:81;i:8;i:80;i:9;i:74;}', 'a:5:{i:0;i:104;i:1;i:100;i:2;i:99;i:3;i:98;i:4;i:97;}', 'a:5:{i:0;i:115;i:1;i:114;i:2;i:112;i:3;i:111;i:4;i:109;}', 'a:5:{i:0;i:124;i:1;i:123;i:2;i:122;i:3;i:121;i:4;i:119;}');
INSERT INTO `guanli_lianxi` VALUES ('3', '2', 'a:10:{i:0;i:92;i:1;i:90;i:2;i:89;i:3;i:88;i:4;i:86;i:5;i:80;i:6;i:76;i:7;i:75;i:8;i:74;i:9;i:1;}', 'a:5:{i:0;i:103;i:1;i:101;i:2;i:100;i:3;i:97;i:4;i:96;}', 'a:5:{i:0;i:115;i:1;i:112;i:2;i:111;i:3;i:110;i:4;i:107;}', 'a:5:{i:0;i:125;i:1;i:122;i:2;i:121;i:3;i:120;i:4;i:118;}');
INSERT INTO `guanli_lianxi` VALUES ('4', '4', 'a:10:{i:0;i:91;i:1;i:90;i:2;i:89;i:3;i:88;i:4;i:87;i:5;i:86;i:6;i:85;i:7;i:82;i:8;i:78;i:9;i:77;}', 'a:5:{i:0;i:102;i:1;i:101;i:2;i:99;i:3;i:97;i:4;i:96;}', 'a:5:{i:0;i:115;i:1;i:113;i:2;i:110;i:3;i:108;i:4;i:107;}', 'a:5:{i:0;i:125;i:1;i:122;i:2;i:121;i:3;i:120;i:4;i:119;}');

-- ----------------------------
-- Table structure for guanli_question
-- ----------------------------
DROP TABLE IF EXISTS `guanli_question`;
CREATE TABLE `guanli_question` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `keid` int(10) unsigned NOT NULL COMMENT '关联课程id',
  `question` varchar(255) DEFAULT NULL COMMENT '题目',
  `option` varchar(255) DEFAULT NULL COMMENT '选项',
  `answer` varchar(255) DEFAULT NULL COMMENT '答案',
  `type` int(10) unsigned DEFAULT NULL COMMENT '题目类型：1为单选，2为多选，3为判断，4为填空',
  `style` int(10) unsigned DEFAULT NULL COMMENT '题目种类：1为日常练习及作业，2为仅供考试',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=128 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of guanli_question
-- ----------------------------
INSERT INTO `guanli_question` VALUES ('1', '2', '10分钟一般补多少刀？', 'A.10 B.20 C.30 D.40', 'D', '1', '1');
INSERT INTO `guanli_question` VALUES ('2', '2', '下路一般有几个人？', 'A.1 B.2 C.3 D.4', 'B', '1', '2');
INSERT INTO `guanli_question` VALUES ('3', '1', '磨铁的时间是多久？', '', '1个小时', '4', '2');
INSERT INTO `guanli_question` VALUES ('4', '2', '召唤师峡谷有多少英雄？', 'A.1 B.2 C.3 D.很多', 'D', '1', '2');
INSERT INTO `guanli_question` VALUES ('5', '2', '召唤师峡谷有多少英雄1？', 'A.1 B.2 C.3 D.很多', 'D', '1', '2');
INSERT INTO `guanli_question` VALUES ('6', '2', '召唤师峡谷有多少英雄2？', 'A.1 B.2 C.3 D.很多', 'D', '1', '2');
INSERT INTO `guanli_question` VALUES ('7', '2', '召唤师峡谷有多少英雄3？', 'A.1 B.2 C.3 D.很多', 'D', '1', '2');
INSERT INTO `guanli_question` VALUES ('8', '2', '召唤师峡谷有多少英雄4？', 'A.1 B.2 C.3 D.很多', 'D', '1', '2');
INSERT INTO `guanli_question` VALUES ('9', '2', '召唤师峡谷有多少英雄7？', 'A.1 B.很多 C.3 D.0', 'B', '1', '2');
INSERT INTO `guanli_question` VALUES ('10', '2', '召唤师峡谷有多少英雄8？', 'A.1 B.很多 C.3 D.0', 'B', '1', '2');
INSERT INTO `guanli_question` VALUES ('11', '2', '召唤师峡谷有多少英雄9？', 'A.1 B.2 C.很多 D.0', 'C', '1', '2');
INSERT INTO `guanli_question` VALUES ('12', '2', '召唤师峡谷有多少英雄10？', 'A.很多 B.2 C.3 D.0', 'A', '1', '2');
INSERT INTO `guanli_question` VALUES ('13', '2', '召唤师峡谷有多少英雄11？', 'A.1 B.2 C.很多 D.0', 'C', '1', '2');
INSERT INTO `guanli_question` VALUES ('14', '2', '召唤师峡谷有多少英雄12？', 'A.1 B.很多 C.3 D.0', 'B', '1', '2');
INSERT INTO `guanli_question` VALUES ('15', '2', '召唤师峡谷有多少英雄13？', 'A.1 B.很多 C.3 D.0', 'B', '1', '2');
INSERT INTO `guanli_question` VALUES ('16', '2', '召唤师峡谷有多少英雄14？', 'A.1 B.2 C.很多 D.0', 'C', '1', '2');
INSERT INTO `guanli_question` VALUES ('17', '2', '召唤师峡谷有多少英雄15？', 'A.1 B.很多 C.3 D.0', 'B', '1', '2');
INSERT INTO `guanli_question` VALUES ('18', '2', '召唤师峡谷有多少英雄16？', 'A.1 B.2 C.3 D.很多', 'D', '1', '2');
INSERT INTO `guanli_question` VALUES ('19', '2', '召唤师峡谷有多少英雄17？', 'A.1 B.很多 C.3 D.0', 'B', '1', '2');
INSERT INTO `guanli_question` VALUES ('20', '2', '召唤师峡谷有多少英雄18？', 'A.1 B.很多 C.3 D.0', 'B', '1', '2');
INSERT INTO `guanli_question` VALUES ('21', '2', '召唤师峡谷有多少英雄19？', 'A.1 B.2 C.3 D.很多', 'D', '1', '2');
INSERT INTO `guanli_question` VALUES ('22', '2', '召唤师峡谷有多少英雄20？', 'A.1 B.2 C.很多 D.0', 'C', '1', '2');
INSERT INTO `guanli_question` VALUES ('23', '1', '很多车子有几个轮子？', 'A.1 B.2 C.3 D.很多', 'D', '1', '2');
INSERT INTO `guanli_question` VALUES ('24', '1', '很多车子有几个轮子2？', 'A.1 B.很多 C.3 D.0', 'B', '1', '2');
INSERT INTO `guanli_question` VALUES ('25', '1', '很多车子有几个轮子3？', 'A.1 B.2 C.3 D.很多', 'D', '1', '2');
INSERT INTO `guanli_question` VALUES ('26', '1', '很多车子有几个轮子4？', 'A.很多 B.2 C.3 D.0', 'A', '1', '2');
INSERT INTO `guanli_question` VALUES ('27', '1', '很多车子有几个轮子5？', 'A.1 B.很多 C.3 D.0', 'B', '1', '2');
INSERT INTO `guanli_question` VALUES ('28', '1', '很多车子有几个轮子6？', 'A.1 B.很多 C.3 D.0', 'B', '1', '2');
INSERT INTO `guanli_question` VALUES ('29', '1', '很多车子有几个轮子7？', 'A.1 B.很多 C.3 D.0', 'B', '1', '2');
INSERT INTO `guanli_question` VALUES ('30', '1', '很多车子有几个轮子8？', 'A.1 B.2 C.很多 D.0', 'C', '1', '2');
INSERT INTO `guanli_question` VALUES ('31', '1', '很多车子有几个轮子9？', 'A.1 B.2 C.3 D.很多', 'D', '1', '2');
INSERT INTO `guanli_question` VALUES ('32', '1', '很多车子有几个轮子10？', 'A.1 B.2 C.3 D.很多', 'D', '1', '2');
INSERT INTO `guanli_question` VALUES ('33', '1', '打铁需要什么？', 'A.锤子 B.铁 C.棒子 D.很多', 'A/B/C', '2', '2');
INSERT INTO `guanli_question` VALUES ('34', '1', '打铁需要什么2？', 'A.锤子 B.铁 C.棒子 D.很多', 'A/B/C', '2', '2');
INSERT INTO `guanli_question` VALUES ('35', '1', '打铁需要什么3？', 'A.锤子 B.铁 C.0 D.棒子 ', 'A/B/D', '2', '2');
INSERT INTO `guanli_question` VALUES ('36', '1', '打铁需要什么4？', 'A.锤子 B.铁 C.棒子 D.很多', 'A/B/C', '2', '2');
INSERT INTO `guanli_question` VALUES ('37', '1', '打铁需要什么5？', 'A.锤子 B.铁 C.0 D.棒子 ', 'A/B/D', '2', '2');
INSERT INTO `guanli_question` VALUES ('38', '1', '打铁需要什么6？', 'A.锤子 B.铁 C.棒子 D.很多', 'A/B/C', '2', '2');
INSERT INTO `guanli_question` VALUES ('39', '1', '打铁需要什么7？', 'A.锤子 B.铁 C.棒子 D.很多', 'A/B/D', '2', '2');
INSERT INTO `guanli_question` VALUES ('40', '1', '打铁需要什么8？', 'A.锤子 B.铁 C.棒子 D.很多', 'A/B/C', '2', '2');
INSERT INTO `guanli_question` VALUES ('41', '2', '下列哪个是1.2.3？', 'A.1 B.2 C.3 D.很多', 'A/B/C', '2', '2');
INSERT INTO `guanli_question` VALUES ('42', '2', '下列哪个是1.2.3a？', 'A.1 B.很多 C.3 D.0', 'A/C', '2', '2');
INSERT INTO `guanli_question` VALUES ('43', '2', '下列哪个是1.2.3B？', 'A.1 B.2 C.3 D.很多', 'A/B/C', '2', '2');
INSERT INTO `guanli_question` VALUES ('44', '2', '下列哪个是1.2.3c？', 'A.1 B.2 C.很多 D.0', 'A/B', '2', '2');
INSERT INTO `guanli_question` VALUES ('45', '2', '下列哪个是1.2.3d？', 'A.1 B.2 C.很多 D.0', 'A/B', '2', '2');
INSERT INTO `guanli_question` VALUES ('46', '2', '下列哪个是1.2.3e？', 'A.1 B.2 C.很多 D.0', 'A/B', '2', '2');
INSERT INTO `guanli_question` VALUES ('47', '2', '下列哪个是1.2.3f？', 'A.1 B.很多 C.3 D.0', 'A/C', '2', '2');
INSERT INTO `guanli_question` VALUES ('48', '2', '下列哪个是1.2.3g？', 'A.1 B.2 C.很多 D.0', 'A/B/C', '2', '2');
INSERT INTO `guanli_question` VALUES ('49', '2', '下列哪个是1.2.3h？', 'A.1 B.很多 C.3 D.0', 'A/C', '2', '2');
INSERT INTO `guanli_question` VALUES ('50', '2', 'ig是冠军？', '', '对', '3', '2');
INSERT INTO `guanli_question` VALUES ('51', '2', 'ig是冠军1？', '', '对', '3', '2');
INSERT INTO `guanli_question` VALUES ('52', '2', 'ig是冠军3？', '', '对', '1', '2');
INSERT INTO `guanli_question` VALUES ('53', '2', 'ig是冠军4？', '', '对', '3', '2');
INSERT INTO `guanli_question` VALUES ('54', '2', 'ig是冠军5？', '', '对', '3', '2');
INSERT INTO `guanli_question` VALUES ('55', '2', 'ig不是冠军？', '', '错', '3', '2');
INSERT INTO `guanli_question` VALUES ('56', '1', '车子能跑？', '', '对', '3', '2');
INSERT INTO `guanli_question` VALUES ('57', '1', '车子能跑2？', '', '对', '3', '2');
INSERT INTO `guanli_question` VALUES ('58', '1', '车子能跑3？', '', '对', '3', '2');
INSERT INTO `guanli_question` VALUES ('59', '1', '车子能跑4？', '', '对', '3', '2');
INSERT INTO `guanli_question` VALUES ('60', '1', '车子不能跑5？', '', '错', '3', '2');
INSERT INTO `guanli_question` VALUES ('61', '1', '车子不能跑666？', '', '错', '3', '2');
INSERT INTO `guanli_question` VALUES ('62', '2', '你是___人？', '', '好', '4', '2');
INSERT INTO `guanli_question` VALUES ('63', '2', '你是___人2？', '', '好', '4', '2');
INSERT INTO `guanli_question` VALUES ('64', '2', '你是___人3？', '', '好', '4', '2');
INSERT INTO `guanli_question` VALUES ('65', '2', '你是___人4？', '', '好', '4', '2');
INSERT INTO `guanli_question` VALUES ('66', '2', '你是___人5？', '', '坏', '4', '2');
INSERT INTO `guanli_question` VALUES ('67', '2', '你是___人6？', '', '坏', '4', '2');
INSERT INTO `guanli_question` VALUES ('68', '1', '我们不能不遵守____规则？', '', '交通', '4', '2');
INSERT INTO `guanli_question` VALUES ('69', '1', '我们不能不遵守____规则2？', '', '交通', '4', '2');
INSERT INTO `guanli_question` VALUES ('70', '1', '我们不能不遵守____规则3？', '', '交通', '4', '2');
INSERT INTO `guanli_question` VALUES ('71', '1', '我们不能不遵守____规则4？', '', '公共', '4', '2');
INSERT INTO `guanli_question` VALUES ('72', '1', '我们不能不遵守____规则5？', '', '公共', '4', '2');
INSERT INTO `guanli_question` VALUES ('73', '1', '我们不能不遵守____规则6？', '', '交通', '4', '2');
INSERT INTO `guanli_question` VALUES ('74', '2', '开黑一般多少人？', 'A.1 B.2 C.3 D.很多', 'D', '1', '1');
INSERT INTO `guanli_question` VALUES ('75', '2', '开黑一般多少人2？', 'A.1 B.很多 C.3 D.0', 'B', '1', '1');
INSERT INTO `guanli_question` VALUES ('76', '2', '开黑一般多少人3？', 'A.1 B.很多 C.3 D.0', 'B', '1', '1');
INSERT INTO `guanli_question` VALUES ('77', '2', '开黑一般多少人4？', 'A.1 B.2 C.很多 D.0', 'C', '1', '1');
INSERT INTO `guanli_question` VALUES ('78', '2', '开黑一般多少人5？', 'A.1 B.2 C.3 D.很多', 'D', '1', '1');
INSERT INTO `guanli_question` VALUES ('79', '2', '开黑一般多少人6？', 'A.1 B.2 C.3 D.很多', 'D', '1', '1');
INSERT INTO `guanli_question` VALUES ('80', '2', '开黑一般多少人7？', 'A.1 B.2 C.很多 D.0', 'C', '1', '1');
INSERT INTO `guanli_question` VALUES ('81', '2', '开黑一般多少人8？', 'A.1 B.很多 C.3 D.0', 'B', '1', '1');
INSERT INTO `guanli_question` VALUES ('82', '2', '开黑一般多少人8？', 'A.1 B.2 C.3 D.很多', 'D', '1', '1');
INSERT INTO `guanli_question` VALUES ('83', '2', '开黑一般多少人9？', 'A.1 B.很多 C.3 D.0', 'B', '1', '1');
INSERT INTO `guanli_question` VALUES ('84', '2', '开黑一般多少人10？', 'A.1 B.2 C.很多 D.0', 'C', '1', '1');
INSERT INTO `guanli_question` VALUES ('85', '1', '世界车床有多少个？', 'A.1 B.2 C.3 D.很多', 'D', '1', '1');
INSERT INTO `guanli_question` VALUES ('86', '1', '世界车床有多少个2？', 'A.1 B.很多 C.3 D.0', 'B', '1', '1');
INSERT INTO `guanli_question` VALUES ('87', '1', '世界车床有多少个3？', 'A.1 B.很多 C.3 D.0', 'B', '1', '1');
INSERT INTO `guanli_question` VALUES ('88', '1', '世界车床有多少个4？', 'A.1 B.很多 C.3 D.0', 'B', '1', '1');
INSERT INTO `guanli_question` VALUES ('89', '1', '世界车床有多少个5？', 'A.1 B.2 C.3 D.很多', 'D', '1', '1');
INSERT INTO `guanli_question` VALUES ('90', '1', '世界车床有多少个6？', 'A.1 B.2 C.3 D.很多', 'D', '1', '1');
INSERT INTO `guanli_question` VALUES ('91', '1', '世界车床有多少个7？', 'A.1 B.2 C.很多 D.0', 'C', '1', '1');
INSERT INTO `guanli_question` VALUES ('92', '1', '世界车床有多少个8？', 'A.1 B.很多 C.3 D.0', 'B', '1', '1');
INSERT INTO `guanli_question` VALUES ('93', '1', '世界车床有多少个8？', 'A.1 B.2 C.很多 D.0', 'C', '1', '1');
INSERT INTO `guanli_question` VALUES ('94', '1', '世界车床有多少个9？', 'A.1 B.2 C.很多 D.0', 'C', '1', '1');
INSERT INTO `guanli_question` VALUES ('95', '1', '世界车床有多少个10？', 'A.1 B.很多 C.3 D.0', 'B', '1', '1');
INSERT INTO `guanli_question` VALUES ('96', '2', '第一，第二，第三分别用什么代表？', 'A.1 B.2 C.3 D.0', 'A/B/C', '2', '1');
INSERT INTO `guanli_question` VALUES ('97', '2', '第一，第二，第三分别用什么代表2？', 'A.1 B.2 C.很多 D.3', 'A/B/D', '2', '1');
INSERT INTO `guanli_question` VALUES ('98', '2', '第一，第二，第三分别用什么代表3？', 'A.很多 B.2 C.3 D.1', 'B/C/D', '2', '1');
INSERT INTO `guanli_question` VALUES ('99', '2', '第一，第二，第三分别用什么代表4？', 'A.1 B.2 C.3 D.很多', 'A/B/C', '2', '1');
INSERT INTO `guanli_question` VALUES ('100', '2', '第一，第二，第三分别用什么代表5？', 'A.1 B.2 C.3 D.很多', 'A/B/C', '2', '1');
INSERT INTO `guanli_question` VALUES ('101', '2', '第一，第二，第三分别用什么代表6？', 'A.1 B.2 C.3 D.很多', 'A/B/C', '2', '1');
INSERT INTO `guanli_question` VALUES ('102', '1', '比车子轮胎数少的数是？', 'A.1 B.2 C.3 D.很多', 'A/B/C', '2', '1');
INSERT INTO `guanli_question` VALUES ('103', '1', '比车子轮胎数少的数是2？', 'A.1 B.2 C.3 D.很多', 'A/B/C', '2', '1');
INSERT INTO `guanli_question` VALUES ('104', '1', '比车子轮胎数少的数是3？', 'A.1 B.2 C.3 D.很多', 'A/B/C', '2', '1');
INSERT INTO `guanli_question` VALUES ('105', '1', '比车子轮胎数少的数是4？', 'A.1 B.很多 C.3 D.0', 'A/C/D', '2', '1');
INSERT INTO `guanli_question` VALUES ('106', '1', '比车子轮胎数少的数是5？', 'A.1 B.很多 C.3 D.0', 'A/C/D', '2', '1');
INSERT INTO `guanli_question` VALUES ('107', '2', 'uiz很胖？', '', '对', '3', '1');
INSERT INTO `guanli_question` VALUES ('108', '2', 'uiz很胖2？', '', '对', '3', '1');
INSERT INTO `guanli_question` VALUES ('109', '2', 'uiz很胖3？', '', '对', '3', '1');
INSERT INTO `guanli_question` VALUES ('110', '2', 'uiz不胖4？', '', '错', '3', '1');
INSERT INTO `guanli_question` VALUES ('111', '2', 'uiz不胖5？', '', '错', '3', '1');
INSERT INTO `guanli_question` VALUES ('112', '2', 'uiz很胖6666？', '', '对', '3', '1');
INSERT INTO `guanli_question` VALUES ('113', '1', '车子没有轮子？', '', '错', '3', '1');
INSERT INTO `guanli_question` VALUES ('114', '1', '车子没有轮子2？', '', '错', '3', '1');
INSERT INTO `guanli_question` VALUES ('115', '1', '车子没有轮子4？', '', '错', '3', '1');
INSERT INTO `guanli_question` VALUES ('116', '1', '车子有轮子？', '', '对', '3', '1');
INSERT INTO `guanli_question` VALUES ('117', '1', '车子有轮子2？', '', '对', '3', '1');
INSERT INTO `guanli_question` VALUES ('118', '2', '谁是今年的冠军？', '', 'ig', '4', '1');
INSERT INTO `guanli_question` VALUES ('119', '2', '谁是今年的冠军2？', '', 'ig', '4', '1');
INSERT INTO `guanli_question` VALUES ('120', '2', '谁是今年的冠军3？', '', 'ig', '4', '1');
INSERT INTO `guanli_question` VALUES ('121', '2', '谁不是今年的冠军4？', '', 'rng', '4', '1');
INSERT INTO `guanli_question` VALUES ('122', '2', '谁不是今年的冠军5？', '', 'edg', '4', '1');
INSERT INTO `guanli_question` VALUES ('123', '1', '车子有几个轮子？', '', '4', '4', '1');
INSERT INTO `guanli_question` VALUES ('124', '1', '车子有几个轮子2？', '', '4', '4', '1');
INSERT INTO `guanli_question` VALUES ('125', '1', '人有几个手？', '', '2', '4', '1');
INSERT INTO `guanli_question` VALUES ('126', '1', '人有几个手4？', '', '2', '4', '1');
INSERT INTO `guanli_question` VALUES ('127', '1', '人有几个手5？', '', '2', '4', '1');

-- ----------------------------
-- Table structure for guanli_student
-- ----------------------------
DROP TABLE IF EXISTS `guanli_student`;
CREATE TABLE `guanli_student` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `bid` int(10) unsigned DEFAULT NULL COMMENT '关联班级id',
  `xuehao` varchar(255) DEFAULT NULL COMMENT '学号',
  `sname` varchar(255) DEFAULT NULL COMMENT '学生姓名',
  `brithday` varchar(255) DEFAULT NULL COMMENT '出身年月',
  `adds` varchar(255) DEFAULT NULL COMMENT '家庭住址',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of guanli_student
-- ----------------------------
INSERT INTO `guanli_student` VALUES ('1', '1', '007', '亚索', '1996年2月18', '召唤师峡谷');
INSERT INTO `guanli_student` VALUES ('2', '2', '003', '蛮王', '1998.02.16', '召唤师峡谷');

-- ----------------------------
-- Table structure for guanli_user
-- ----------------------------
DROP TABLE IF EXISTS `guanli_user`;
CREATE TABLE `guanli_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `xjid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关联学生和教师的id',
  `uersname` varchar(255) DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) DEFAULT NULL COMMENT '用户密码',
  `type` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '用户类型',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uersname` (`uersname`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of guanli_user
-- ----------------------------
INSERT INTO `guanli_user` VALUES ('1', '1', 'xuesheng', '123456', '1');
INSERT INTO `guanli_user` VALUES ('2', '1', 'jiaoshi', '123456', '2');
INSERT INTO `guanli_user` VALUES ('3', '0', 'root', 'root', '3');
INSERT INTO `guanli_user` VALUES ('4', '2', 'xuesehng1', '123456', '1');
INSERT INTO `guanli_user` VALUES ('5', '2', 'jiaoshi1', '123456', '2');

-- ----------------------------
-- Table structure for guanli_xueyuan
-- ----------------------------
DROP TABLE IF EXISTS `guanli_xueyuan`;
CREATE TABLE `guanli_xueyuan` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `xiname` varchar(255) DEFAULT NULL COMMENT '院系名称',
  `xishuoming` varchar(255) DEFAULT NULL COMMENT '学院说明',
  `xiroot` varchar(255) DEFAULT NULL COMMENT '院长或主任',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of guanli_xueyuan
-- ----------------------------
INSERT INTO `guanli_xueyuan` VALUES ('1', '机车车辆', '这是机车学院', '科比');
INSERT INTO `guanli_xueyuan` VALUES ('2', 'nba', '欢迎来到NBA', '乔丹');
INSERT INTO `guanli_xueyuan` VALUES ('3', '召唤师峡谷', '欢迎来到召唤师峡谷', 'uzi');

-- ----------------------------
-- Table structure for guanli_zhuanye
-- ----------------------------
DROP TABLE IF EXISTS `guanli_zhuanye`;
CREATE TABLE `guanli_zhuanye` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `uid` int(10) unsigned DEFAULT NULL COMMENT '关联学院表的id',
  `yename` varchar(255) DEFAULT NULL COMMENT '专业名称',
  `yeshuoming` varchar(255) DEFAULT NULL COMMENT '专业说明',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of guanli_zhuanye
-- ----------------------------
INSERT INTO `guanli_zhuanye` VALUES ('1', '1', '机电一体化', '这是机电专业');
INSERT INTO `guanli_zhuanye` VALUES ('2', '3', 'ADC', '这是一个需要技术的活');

-- ----------------------------
-- Table structure for guanli_zuoye
-- ----------------------------
DROP TABLE IF EXISTS `guanli_zuoye`;
CREATE TABLE `guanli_zuoye` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `uid` int(10) unsigned NOT NULL COMMENT '关联用户id',
  `timu` text COMMENT '作业题目',
  `daan` varchar(255) DEFAULT NULL COMMENT '学生提交答案',
  `have` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '作业完成：0为无作业，1为未完成，2为已完成',
  `nowtime` datetime DEFAULT NULL COMMENT '当前时间',
  `guitime` datetime DEFAULT NULL COMMENT '规定时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of guanli_zuoye
-- ----------------------------
INSERT INTO `guanli_zuoye` VALUES ('1', '1', 'a:4:{s:4:\"dans\";a:5:{i:0;i:92;i:1;i:85;i:2;i:26;i:3;i:16;i:4;i:15;}s:4:\"duos\";a:5:{i:0;i:104;i:1;i:103;i:2;i:98;i:3;i:45;i:4;i:39;}s:4:\"pans\";a:3:{i:0;i:115;i:1;i:61;i:2;i:51;}s:5:\"tians\";a:3:{i:0;i:121;i:1;i:120;i:2;i:73;}}', null, '1', '2018-11-20 09:41:10', '2018-11-21 09:41:10');
INSERT INTO `guanli_zuoye` VALUES ('3', '4', 'a:4:{s:4:\"dans\";a:5:{i:0;i:90;i:1;i:82;i:2;i:20;i:3;i:19;i:4;i:16;}s:4:\"duos\";a:5:{i:0;i:102;i:1;i:97;i:2;i:48;i:3;i:43;i:4;i:38;}s:4:\"pans\";a:3:{i:0;i:114;i:1;i:109;i:2;i:108;}s:5:\"tians\";a:3:{i:0;i:118;i:1;i:70;i:2;i:66;}}', 'a:16:{s:4:\"dan1\";s:1:\"A\";s:4:\"dan2\";s:1:\"B\";s:4:\"dan3\";s:1:\"A\";s:4:\"dan4\";s:1:\"B\";s:4:\"dan5\";s:1:\"A\";s:4:\"duo1\";a:3:{i:0;s:1:\"A\";i:1;s:1:\"B\";i:2;s:1:\"C\";}s:4:\"duo2\";a:3:{i:0;s:1:\"A\";i:1;s:1:\"B\";i:2;s:1:\"C\";}s:4:\"duo3\";a:4:{i:0;s:1:\"A\";i:1;s:1:\"B\";i:2;s:1:', '2', '2018-11-20 09:41:17', '2018-11-21 09:41:17');
