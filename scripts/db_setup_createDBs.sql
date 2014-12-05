-- MySQL dump 10.11
--
-- Host: vm-lnx-cpccfmysql.ncep.noaa.gov    Database: 
-- ------------------------------------------------------
-- Server version	5.0.95-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `anom_correl`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `anom_correl` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `anom_correl`;

--
-- Table structure for table `auto_500`
--

DROP TABLE IF EXISTS `auto_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auto_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auto_700`
--

DROP TABLE IF EXISTS `auto_700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auto_700` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmce_00_500`
--

DROP TABLE IF EXISTS `cmce_00_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmce_00_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmce_00_700`
--

DROP TABLE IF EXISTS `cmce_00_700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmce_00_700` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmce_12_500`
--

DROP TABLE IF EXISTS `cmce_12_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmce_12_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cmce_12_700`
--

DROP TABLE IF EXISTS `cmce_12_700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmce_12_700` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cdc_500`
--

DROP TABLE IF EXISTS `cdc_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cdc_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cdc_700`
--

DROP TABLE IF EXISTS `cdc_700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cdc_700` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cfs_500`
--

DROP TABLE IF EXISTS `cfs_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfs_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cfsgin_00_500`
--

DROP TABLE IF EXISTS `cfsgin_00_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfsgin_00_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cfsgin_06_500`
--

DROP TABLE IF EXISTS `cfsgin_06_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfsgin_06_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cfsgin_12_500`
--

DROP TABLE IF EXISTS `cfsgin_12_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfsgin_12_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cfsgin_18_500`
--

DROP TABLE IF EXISTS `cfsgin_18_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfsgin_18_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cfsv2_00_500`
--

DROP TABLE IF EXISTS `cfsv2_00_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfsv2_00_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cfsv2_06_500`
--

DROP TABLE IF EXISTS `cfsv2_06_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfsv2_06_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cfsv2_12_500`
--

DROP TABLE IF EXISTS `cfsv2_12_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfsv2_12_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cfsv2_18_500`
--

DROP TABLE IF EXISTS `cfsv2_18_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfsv2_18_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cfsv2bc_00_500`
--

DROP TABLE IF EXISTS `cfsv2bc_00_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfsv2bc_00_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cfsv2bc_06_500`
--

DROP TABLE IF EXISTS `cfsv2bc_06_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfsv2bc_06_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cfsv2bc_12_500`
--

DROP TABLE IF EXISTS `cfsv2bc_12_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfsv2bc_12_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cfsv2bc_18_500`
--

DROP TABLE IF EXISTS `cfsv2bc_18_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfsv2bc_18_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cfsv2bcwk34_00_500`
--

DROP TABLE IF EXISTS `cfsv2bcwk34_00_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfsv2bcwk34_00_500` (
  `date` date default NULL,
  `wk3_nh` float default NULL,
  `wk3_na` float default NULL,
  `wk3_us` float default NULL,
  `wk4_nh` float default NULL,
  `wk4_na` float default NULL,
  `wk4_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cfsv2bcwk34_06_500`
--

DROP TABLE IF EXISTS `cfsv2bcwk34_06_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfsv2bcwk34_06_500` (
  `date` date default NULL,
  `wk3_nh` float default NULL,
  `wk3_na` float default NULL,
  `wk3_us` float default NULL,
  `wk4_nh` float default NULL,
  `wk4_na` float default NULL,
  `wk4_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cfsv2bcwk34_12_500`
--

DROP TABLE IF EXISTS `cfsv2bcwk34_12_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfsv2bcwk34_12_500` (
  `date` date default NULL,
  `wk3_nh` float default NULL,
  `wk3_na` float default NULL,
  `wk3_us` float default NULL,
  `wk4_nh` float default NULL,
  `wk4_na` float default NULL,
  `wk4_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cfsv2bcwk34_18_500`
--

DROP TABLE IF EXISTS `cfsv2bcwk34_18_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfsv2bcwk34_18_500` (
  `date` date default NULL,
  `wk3_nh` float default NULL,
  `wk3_na` float default NULL,
  `wk3_us` float default NULL,
  `wk4_nh` float default NULL,
  `wk4_na` float default NULL,
  `wk4_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cfsv2ginwk34_00_500`
--

DROP TABLE IF EXISTS `cfsv2ginwk34_00_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfsv2ginwk34_00_500` (
  `date` date default NULL,
  `wk3_nh` float default NULL,
  `wk3_na` float default NULL,
  `wk3_us` float default NULL,
  `wk4_nh` float default NULL,
  `wk4_na` float default NULL,
  `wk4_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cfsv2ginwk34_06_500`
--

DROP TABLE IF EXISTS `cfsv2ginwk34_06_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfsv2ginwk34_06_500` (
  `date` date default NULL,
  `wk3_nh` float default NULL,
  `wk3_na` float default NULL,
  `wk3_us` float default NULL,
  `wk4_nh` float default NULL,
  `wk4_na` float default NULL,
  `wk4_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cfsv2ginwk34_12_500`
--

DROP TABLE IF EXISTS `cfsv2ginwk34_12_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfsv2ginwk34_12_500` (
  `date` date default NULL,
  `wk3_nh` float default NULL,
  `wk3_na` float default NULL,
  `wk3_us` float default NULL,
  `wk4_nh` float default NULL,
  `wk4_na` float default NULL,
  `wk4_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cfsv2ginwk34_18_500`
--

DROP TABLE IF EXISTS `cfsv2ginwk34_18_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfsv2ginwk34_18_500` (
  `date` date default NULL,
  `wk3_nh` float default NULL,
  `wk3_na` float default NULL,
  `wk3_us` float default NULL,
  `wk4_nh` float default NULL,
  `wk4_na` float default NULL,
  `wk4_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cfsv2wk34_00_500`
--

DROP TABLE IF EXISTS `cfsv2wk34_00_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfsv2wk34_00_500` (
  `date` date default NULL,
  `wk3_nh` float default NULL,
  `wk3_na` float default NULL,
  `wk3_us` float default NULL,
  `wk4_nh` float default NULL,
  `wk4_na` float default NULL,
  `wk4_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cfsv2wk34_06_500`
--

DROP TABLE IF EXISTS `cfsv2wk34_06_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfsv2wk34_06_500` (
  `date` date default NULL,
  `wk3_nh` float default NULL,
  `wk3_na` float default NULL,
  `wk3_us` float default NULL,
  `wk4_nh` float default NULL,
  `wk4_na` float default NULL,
  `wk4_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cfsv2wk34_12_500`
--

DROP TABLE IF EXISTS `cfsv2wk34_12_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfsv2wk34_12_500` (
  `date` date default NULL,
  `wk3_nh` float default NULL,
  `wk3_na` float default NULL,
  `wk3_us` float default NULL,
  `wk4_nh` float default NULL,
  `wk4_na` float default NULL,
  `wk4_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cfsv2wk34_18_500`
--

DROP TABLE IF EXISTS `cfsv2wk34_18_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfsv2wk34_18_500` (
  `date` date default NULL,
  `wk3_nh` float default NULL,
  `wk3_na` float default NULL,
  `wk3_us` float default NULL,
  `wk4_nh` float default NULL,
  `wk4_na` float default NULL,
  `wk4_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cfswk34_500`
--

DROP TABLE IF EXISTS `cfswk34_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cfswk34_500` (
  `date` date default NULL,
  `wk3_nh` float default NULL,
  `wk3_na` float default NULL,
  `wk3_us` float default NULL,
  `wk4_nh` float default NULL,
  `wk4_na` float default NULL,
  `wk4_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dav_500`
--

DROP TABLE IF EXISTS `dav_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dav_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dav_700`
--

DROP TABLE IF EXISTS `dav_700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dav_700` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eccm_12_500`
--

DROP TABLE IF EXISTS `eccm_12_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eccm_12_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eccm_12_700`
--

DROP TABLE IF EXISTS `eccm_12_700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eccm_12_700` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecm_00_500`
--

DROP TABLE IF EXISTS `ecm_00_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecm_00_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecm_00_700`
--

DROP TABLE IF EXISTS `ecm_00_700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecm_00_700` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecm_12_500`
--

DROP TABLE IF EXISTS `ecm_12_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecm_12_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecm_12_700`
--

DROP TABLE IF EXISTS `ecm_12_700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecm_12_700` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecm_500`
--

DROP TABLE IF EXISTS `ecm_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecm_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecm_700`
--

DROP TABLE IF EXISTS `ecm_700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecm_700` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecmm_00_500`
--

DROP TABLE IF EXISTS `ecmm_00_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecmm_00_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecmm_00_700`
--

DROP TABLE IF EXISTS `ecmm_00_700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecmm_00_700` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecmm_12_500`
--

DROP TABLE IF EXISTS `ecmm_12_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecmm_12_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecmm_12_700`
--

DROP TABLE IF EXISTS `ecmm_12_700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecmm_12_700` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecmm_500`
--

DROP TABLE IF EXISTS `ecmm_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecmm_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecmm_700`
--

DROP TABLE IF EXISTS `ecmm_700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecmm_700` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ensm_00_500`
--

DROP TABLE IF EXISTS `ensm_00_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ensm_00_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ensm_00_700`
--

DROP TABLE IF EXISTS `ensm_00_700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ensm_00_700` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ensm_00_par_500`
--

DROP TABLE IF EXISTS `ensm_00_par_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ensm_00_par_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ensm_06_500`
--

DROP TABLE IF EXISTS `ensm_06_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ensm_06_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ensm_06_700`
--

DROP TABLE IF EXISTS `ensm_06_700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ensm_06_700` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ensm_06_par_500`
--

DROP TABLE IF EXISTS `ensm_06_par_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ensm_06_par_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ensm_12_500`
--

DROP TABLE IF EXISTS `ensm_12_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ensm_12_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ensm_12_700`
--

DROP TABLE IF EXISTS `ensm_12_700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ensm_12_700` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ensm_18_500`
--

DROP TABLE IF EXISTS `ensm_18_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ensm_18_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ensm_18_700`
--

DROP TABLE IF EXISTS `ensm_18_700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ensm_18_700` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ensm_al_500`
--

DROP TABLE IF EXISTS `ensm_al_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ensm_al_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ensm_al_700`
--

DROP TABLE IF EXISTS `ensm_al_700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ensm_al_700` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ensm_al_par_500`
--

DROP TABLE IF EXISTS `ensm_al_par_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ensm_al_par_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gfs_00_500`
--

DROP TABLE IF EXISTS `gfs_00_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gfs_00_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gfs_00_700`
--

DROP TABLE IF EXISTS `gfs_00_700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gfs_00_700` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gfs_00_par_500`
--

DROP TABLE IF EXISTS `gfs_00_par_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gfs_00_par_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gfs_06_500`
--

DROP TABLE IF EXISTS `gfs_06_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gfs_06_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gfs_06_700`
--

DROP TABLE IF EXISTS `gfs_06_700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gfs_06_700` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gfs_06_par_500`
--

DROP TABLE IF EXISTS `gfs_06_par_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gfs_06_par_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gfs_12_500`
--

DROP TABLE IF EXISTS `gfs_12_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gfs_12_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gfs_12_700`
--

DROP TABLE IF EXISTS `gfs_12_700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gfs_12_700` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gfs_18_500`
--

DROP TABLE IF EXISTS `gfs_18_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gfs_18_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gfs_18_700`
--

DROP TABLE IF EXISTS `gfs_18_700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gfs_18_700` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `man_500`
--

DROP TABLE IF EXISTS `man_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `man_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `man_700`
--

DROP TABLE IF EXISTS `man_700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `man_700` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `off_500`
--

DROP TABLE IF EXISTS `off_500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `off_500` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `off_700`
--

DROP TABLE IF EXISTS `off_700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `off_700` (
  `date` date default NULL,
  `d3_nh` float default NULL,
  `d3_na` float default NULL,
  `d3_us` float default NULL,
  `d5_nh` float default NULL,
  `d5_na` float default NULL,
  `d5_us` float default NULL,
  `d8_nh` float default NULL,
  `d8_na` float default NULL,
  `d8_us` float default NULL,
  `d4_nh` float default NULL,
  `d4_na` float default NULL,
  `d4_us` float default NULL,
  `d7_nh` float default NULL,
  `d7_na` float default NULL,
  `d7_us` float default NULL,
  `d11_nh` float default NULL,
  `d11_na` float default NULL,
  `d11_us` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Current Database: `caltemp`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `caltemp` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `caltemp`;

--
-- Table structure for table `cal_d11fcst`
--

DROP TABLE IF EXISTS `cal_d11fcst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_d11fcst` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `temp` float default NULL,
  `std` float default NULL,
  `prbb` float default NULL,
  `prbn` float default NULL,
  `prba` float default NULL,
  `tcat` float default NULL,
  `tcdf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_d8fcst`
--

DROP TABLE IF EXISTS `cal_d8fcst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_d8fcst` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `temp` float default NULL,
  `std` float default NULL,
  `prbb` float default NULL,
  `prbn` float default NULL,
  `prba` float default NULL,
  `tcat` float default NULL,
  `tcdf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gec0000`
--

DROP TABLE IF EXISTS `cal_gec0000`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gec0000` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gec0006`
--

DROP TABLE IF EXISTS `cal_gec0006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gec0006` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0100`
--

DROP TABLE IF EXISTS `cal_gep0100`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0100` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0106`
--

DROP TABLE IF EXISTS `cal_gep0106`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0106` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0200`
--

DROP TABLE IF EXISTS `cal_gep0200`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0200` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0206`
--

DROP TABLE IF EXISTS `cal_gep0206`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0206` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0300`
--

DROP TABLE IF EXISTS `cal_gep0300`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0300` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0306`
--

DROP TABLE IF EXISTS `cal_gep0306`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0306` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0400`
--

DROP TABLE IF EXISTS `cal_gep0400`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0400` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0406`
--

DROP TABLE IF EXISTS `cal_gep0406`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0406` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0500`
--

DROP TABLE IF EXISTS `cal_gep0500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0500` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0506`
--

DROP TABLE IF EXISTS `cal_gep0506`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0506` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0600`
--

DROP TABLE IF EXISTS `cal_gep0600`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0600` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0606`
--

DROP TABLE IF EXISTS `cal_gep0606`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0606` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0700`
--

DROP TABLE IF EXISTS `cal_gep0700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0700` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0706`
--

DROP TABLE IF EXISTS `cal_gep0706`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0706` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0800`
--

DROP TABLE IF EXISTS `cal_gep0800`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0800` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0806`
--

DROP TABLE IF EXISTS `cal_gep0806`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0806` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0900`
--

DROP TABLE IF EXISTS `cal_gep0900`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0900` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0906`
--

DROP TABLE IF EXISTS `cal_gep0906`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0906` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1000`
--

DROP TABLE IF EXISTS `cal_gep1000`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1000` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1006`
--

DROP TABLE IF EXISTS `cal_gep1006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1006` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1100`
--

DROP TABLE IF EXISTS `cal_gep1100`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1100` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1106`
--

DROP TABLE IF EXISTS `cal_gep1106`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1106` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1200`
--

DROP TABLE IF EXISTS `cal_gep1200`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1200` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1206`
--

DROP TABLE IF EXISTS `cal_gep1206`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1206` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1300`
--

DROP TABLE IF EXISTS `cal_gep1300`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1300` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1306`
--

DROP TABLE IF EXISTS `cal_gep1306`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1306` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1400`
--

DROP TABLE IF EXISTS `cal_gep1400`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1400` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1406`
--

DROP TABLE IF EXISTS `cal_gep1406`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1406` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1500`
--

DROP TABLE IF EXISTS `cal_gep1500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1500` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1506`
--

DROP TABLE IF EXISTS `cal_gep1506`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1506` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1600`
--

DROP TABLE IF EXISTS `cal_gep1600`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1600` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1606`
--

DROP TABLE IF EXISTS `cal_gep1606`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1606` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1700`
--

DROP TABLE IF EXISTS `cal_gep1700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1700` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1706`
--

DROP TABLE IF EXISTS `cal_gep1706`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1706` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1800`
--

DROP TABLE IF EXISTS `cal_gep1800`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1800` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1806`
--

DROP TABLE IF EXISTS `cal_gep1806`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1806` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1900`
--

DROP TABLE IF EXISTS `cal_gep1900`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1900` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1906`
--

DROP TABLE IF EXISTS `cal_gep1906`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1906` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep2000`
--

DROP TABLE IF EXISTS `cal_gep2000`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep2000` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep2006`
--

DROP TABLE IF EXISTS `cal_gep2006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep2006` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d11_obs`
--

DROP TABLE IF EXISTS `d11_obs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d11_obs` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d11climo`
--

DROP TABLE IF EXISTS `d11climo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d11climo` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `tbel` float default NULL,
  `tnor` float default NULL,
  `tabv` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d8_obs`
--

DROP TABLE IF EXISTS `d8_obs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d8_obs` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d8climo`
--

DROP TABLE IF EXISTS `d8climo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d8climo` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `tbel` float default NULL,
  `tnor` float default NULL,
  `tabv` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_cal00_d11fcst`
--

DROP TABLE IF EXISTS `ec_cal00_d11fcst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_cal00_d11fcst` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `temp` float default NULL,
  `std` float default NULL,
  `prbb` float default NULL,
  `prbn` float default NULL,
  `prba` float default NULL,
  `tcat` float default NULL,
  `tcdf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_cal00_d8fcst`
--

DROP TABLE IF EXISTS `ec_cal00_d8fcst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_cal00_d8fcst` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `temp` float default NULL,
  `std` float default NULL,
  `prbb` float default NULL,
  `prbn` float default NULL,
  `prba` float default NULL,
  `tcat` float default NULL,
  `tcdf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_cal12_d11fcst`
--

DROP TABLE IF EXISTS `ec_cal12_d11fcst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_cal12_d11fcst` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `temp` float default NULL,
  `std` float default NULL,
  `prbb` float default NULL,
  `prbn` float default NULL,
  `prba` float default NULL,
  `tcat` float default NULL,
  `tcdf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_cal12_d8fcst`
--

DROP TABLE IF EXISTS `ec_cal12_d8fcst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_cal12_d8fcst` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `temp` float default NULL,
  `std` float default NULL,
  `prbb` float default NULL,
  `prbn` float default NULL,
  `prba` float default NULL,
  `tcat` float default NULL,
  `tcdf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_uncal00_d11fcst`
--

DROP TABLE IF EXISTS `ec_uncal00_d11fcst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_uncal00_d11fcst` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `temp` float default NULL,
  `std` float default NULL,
  `prbb` float default NULL,
  `prbn` float default NULL,
  `prba` float default NULL,
  `tcat` float default NULL,
  `tcdf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_uncal00_d8fcst`
--

DROP TABLE IF EXISTS `ec_uncal00_d8fcst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_uncal00_d8fcst` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `temp` float default NULL,
  `std` float default NULL,
  `prbb` float default NULL,
  `prbn` float default NULL,
  `prba` float default NULL,
  `tcat` float default NULL,
  `tcdf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_uncal12_d11fcst`
--

DROP TABLE IF EXISTS `ec_uncal12_d11fcst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_uncal12_d11fcst` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `temp` float default NULL,
  `std` float default NULL,
  `prbb` float default NULL,
  `prbn` float default NULL,
  `prba` float default NULL,
  `tcat` float default NULL,
  `tcdf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ec_uncal12_d8fcst`
--

DROP TABLE IF EXISTS `ec_uncal12_d8fcst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ec_uncal12_d8fcst` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `temp` float default NULL,
  `std` float default NULL,
  `prbb` float default NULL,
  `prbn` float default NULL,
  `prba` float default NULL,
  `tcat` float default NULL,
  `tcdf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens100`
--

DROP TABLE IF EXISTS `ecens100`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens100` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens1000`
--

DROP TABLE IF EXISTS `ecens1000`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens1000` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens1012`
--

DROP TABLE IF EXISTS `ecens1012`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens1012` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens1100`
--

DROP TABLE IF EXISTS `ecens1100`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens1100` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens1112`
--

DROP TABLE IF EXISTS `ecens1112`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens1112` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens112`
--

DROP TABLE IF EXISTS `ecens112`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens112` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens1200`
--

DROP TABLE IF EXISTS `ecens1200`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens1200` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens1212`
--

DROP TABLE IF EXISTS `ecens1212`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens1212` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens1300`
--

DROP TABLE IF EXISTS `ecens1300`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens1300` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens1312`
--

DROP TABLE IF EXISTS `ecens1312`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens1312` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens1400`
--

DROP TABLE IF EXISTS `ecens1400`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens1400` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens1412`
--

DROP TABLE IF EXISTS `ecens1412`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens1412` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens1500`
--

DROP TABLE IF EXISTS `ecens1500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens1500` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens1512`
--

DROP TABLE IF EXISTS `ecens1512`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens1512` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens1600`
--

DROP TABLE IF EXISTS `ecens1600`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens1600` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens1612`
--

DROP TABLE IF EXISTS `ecens1612`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens1612` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens1700`
--

DROP TABLE IF EXISTS `ecens1700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens1700` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens1712`
--

DROP TABLE IF EXISTS `ecens1712`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens1712` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens1800`
--

DROP TABLE IF EXISTS `ecens1800`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens1800` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens1812`
--

DROP TABLE IF EXISTS `ecens1812`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens1812` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens1900`
--

DROP TABLE IF EXISTS `ecens1900`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens1900` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens1912`
--

DROP TABLE IF EXISTS `ecens1912`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens1912` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens200`
--

DROP TABLE IF EXISTS `ecens200`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens200` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens2000`
--

DROP TABLE IF EXISTS `ecens2000`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens2000` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens2012`
--

DROP TABLE IF EXISTS `ecens2012`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens2012` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens2100`
--

DROP TABLE IF EXISTS `ecens2100`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens2100` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens2112`
--

DROP TABLE IF EXISTS `ecens2112`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens2112` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens212`
--

DROP TABLE IF EXISTS `ecens212`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens212` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens2200`
--

DROP TABLE IF EXISTS `ecens2200`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens2200` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens2212`
--

DROP TABLE IF EXISTS `ecens2212`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens2212` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens2300`
--

DROP TABLE IF EXISTS `ecens2300`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens2300` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens2312`
--

DROP TABLE IF EXISTS `ecens2312`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens2312` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens2400`
--

DROP TABLE IF EXISTS `ecens2400`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens2400` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens2412`
--

DROP TABLE IF EXISTS `ecens2412`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens2412` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens2500`
--

DROP TABLE IF EXISTS `ecens2500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens2500` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens2512`
--

DROP TABLE IF EXISTS `ecens2512`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens2512` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens2600`
--

DROP TABLE IF EXISTS `ecens2600`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens2600` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens2612`
--

DROP TABLE IF EXISTS `ecens2612`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens2612` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens2700`
--

DROP TABLE IF EXISTS `ecens2700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens2700` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens2712`
--

DROP TABLE IF EXISTS `ecens2712`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens2712` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens2800`
--

DROP TABLE IF EXISTS `ecens2800`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens2800` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens2812`
--

DROP TABLE IF EXISTS `ecens2812`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens2812` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens2900`
--

DROP TABLE IF EXISTS `ecens2900`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens2900` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens2912`
--

DROP TABLE IF EXISTS `ecens2912`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens2912` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens300`
--

DROP TABLE IF EXISTS `ecens300`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens300` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens3000`
--

DROP TABLE IF EXISTS `ecens3000`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens3000` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens3012`
--

DROP TABLE IF EXISTS `ecens3012`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens3012` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens3100`
--

DROP TABLE IF EXISTS `ecens3100`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens3100` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens3112`
--

DROP TABLE IF EXISTS `ecens3112`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens3112` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens312`
--

DROP TABLE IF EXISTS `ecens312`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens312` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens3200`
--

DROP TABLE IF EXISTS `ecens3200`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens3200` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens3212`
--

DROP TABLE IF EXISTS `ecens3212`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens3212` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens3300`
--

DROP TABLE IF EXISTS `ecens3300`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens3300` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens3312`
--

DROP TABLE IF EXISTS `ecens3312`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens3312` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens3400`
--

DROP TABLE IF EXISTS `ecens3400`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens3400` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens3412`
--

DROP TABLE IF EXISTS `ecens3412`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens3412` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens3500`
--

DROP TABLE IF EXISTS `ecens3500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens3500` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens3512`
--

DROP TABLE IF EXISTS `ecens3512`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens3512` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens3600`
--

DROP TABLE IF EXISTS `ecens3600`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens3600` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens3612`
--

DROP TABLE IF EXISTS `ecens3612`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens3612` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens3700`
--

DROP TABLE IF EXISTS `ecens3700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens3700` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens3712`
--

DROP TABLE IF EXISTS `ecens3712`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens3712` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens3800`
--

DROP TABLE IF EXISTS `ecens3800`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens3800` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens3812`
--

DROP TABLE IF EXISTS `ecens3812`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens3812` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens3900`
--

DROP TABLE IF EXISTS `ecens3900`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens3900` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens3912`
--

DROP TABLE IF EXISTS `ecens3912`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens3912` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens400`
--

DROP TABLE IF EXISTS `ecens400`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens400` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens4000`
--

DROP TABLE IF EXISTS `ecens4000`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens4000` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens4012`
--

DROP TABLE IF EXISTS `ecens4012`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens4012` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens4100`
--

DROP TABLE IF EXISTS `ecens4100`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens4100` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens4112`
--

DROP TABLE IF EXISTS `ecens4112`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens4112` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens412`
--

DROP TABLE IF EXISTS `ecens412`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens412` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens4200`
--

DROP TABLE IF EXISTS `ecens4200`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens4200` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens4212`
--

DROP TABLE IF EXISTS `ecens4212`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens4212` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens4300`
--

DROP TABLE IF EXISTS `ecens4300`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens4300` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens4312`
--

DROP TABLE IF EXISTS `ecens4312`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens4312` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens4400`
--

DROP TABLE IF EXISTS `ecens4400`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens4400` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens4412`
--

DROP TABLE IF EXISTS `ecens4412`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens4412` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens4500`
--

DROP TABLE IF EXISTS `ecens4500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens4500` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens4512`
--

DROP TABLE IF EXISTS `ecens4512`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens4512` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens4600`
--

DROP TABLE IF EXISTS `ecens4600`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens4600` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens4612`
--

DROP TABLE IF EXISTS `ecens4612`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens4612` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens4700`
--

DROP TABLE IF EXISTS `ecens4700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens4700` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens4712`
--

DROP TABLE IF EXISTS `ecens4712`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens4712` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens4800`
--

DROP TABLE IF EXISTS `ecens4800`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens4800` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens4812`
--

DROP TABLE IF EXISTS `ecens4812`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens4812` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens4900`
--

DROP TABLE IF EXISTS `ecens4900`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens4900` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens4912`
--

DROP TABLE IF EXISTS `ecens4912`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens4912` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens500`
--

DROP TABLE IF EXISTS `ecens500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens500` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens5000`
--

DROP TABLE IF EXISTS `ecens5000`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens5000` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens5012`
--

DROP TABLE IF EXISTS `ecens5012`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens5012` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens512`
--

DROP TABLE IF EXISTS `ecens512`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens512` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens600`
--

DROP TABLE IF EXISTS `ecens600`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens600` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens612`
--

DROP TABLE IF EXISTS `ecens612`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens612` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens700`
--

DROP TABLE IF EXISTS `ecens700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens700` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens712`
--

DROP TABLE IF EXISTS `ecens712`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens712` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens800`
--

DROP TABLE IF EXISTS `ecens800`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens800` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens812`
--

DROP TABLE IF EXISTS `ecens812`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens812` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens900`
--

DROP TABLE IF EXISTS `ecens900`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens900` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ecens912`
--

DROP TABLE IF EXISTS `ecens912`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ecens912` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gec0000`
--

DROP TABLE IF EXISTS `gec0000`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gec0000` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gec0006`
--

DROP TABLE IF EXISTS `gec0006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gec0006` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0100`
--

DROP TABLE IF EXISTS `gep0100`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0100` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0106`
--

DROP TABLE IF EXISTS `gep0106`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0106` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0200`
--

DROP TABLE IF EXISTS `gep0200`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0200` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0206`
--

DROP TABLE IF EXISTS `gep0206`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0206` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0300`
--

DROP TABLE IF EXISTS `gep0300`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0300` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0306`
--

DROP TABLE IF EXISTS `gep0306`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0306` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0400`
--

DROP TABLE IF EXISTS `gep0400`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0400` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0406`
--

DROP TABLE IF EXISTS `gep0406`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0406` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0500`
--

DROP TABLE IF EXISTS `gep0500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0500` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0506`
--

DROP TABLE IF EXISTS `gep0506`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0506` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0600`
--

DROP TABLE IF EXISTS `gep0600`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0600` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0606`
--

DROP TABLE IF EXISTS `gep0606`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0606` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0700`
--

DROP TABLE IF EXISTS `gep0700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0700` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0706`
--

DROP TABLE IF EXISTS `gep0706`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0706` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0800`
--

DROP TABLE IF EXISTS `gep0800`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0800` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0806`
--

DROP TABLE IF EXISTS `gep0806`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0806` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0900`
--

DROP TABLE IF EXISTS `gep0900`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0900` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0906`
--

DROP TABLE IF EXISTS `gep0906`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0906` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1000`
--

DROP TABLE IF EXISTS `gep1000`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1000` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1006`
--

DROP TABLE IF EXISTS `gep1006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1006` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1100`
--

DROP TABLE IF EXISTS `gep1100`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1100` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1106`
--

DROP TABLE IF EXISTS `gep1106`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1106` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1200`
--

DROP TABLE IF EXISTS `gep1200`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1200` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1206`
--

DROP TABLE IF EXISTS `gep1206`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1206` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1300`
--

DROP TABLE IF EXISTS `gep1300`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1300` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1306`
--

DROP TABLE IF EXISTS `gep1306`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1306` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1400`
--

DROP TABLE IF EXISTS `gep1400`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1400` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1406`
--

DROP TABLE IF EXISTS `gep1406`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1406` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1500`
--

DROP TABLE IF EXISTS `gep1500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1500` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1506`
--

DROP TABLE IF EXISTS `gep1506`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1506` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1600`
--

DROP TABLE IF EXISTS `gep1600`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1600` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1606`
--

DROP TABLE IF EXISTS `gep1606`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1606` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1700`
--

DROP TABLE IF EXISTS `gep1700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1700` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1706`
--

DROP TABLE IF EXISTS `gep1706`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1706` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1800`
--

DROP TABLE IF EXISTS `gep1800`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1800` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1806`
--

DROP TABLE IF EXISTS `gep1806`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1806` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1900`
--

DROP TABLE IF EXISTS `gep1900`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1900` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1906`
--

DROP TABLE IF EXISTS `gep1906`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1906` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep2000`
--

DROP TABLE IF EXISTS `gep2000`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep2000` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep2006`
--

DROP TABLE IF EXISTS `gep2006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep2006` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8temp` float default NULL,
  `d11temp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `station_list`
--

DROP TABLE IF EXISTS `station_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `station_list` (
  `wmo` int(11) default NULL,
  `lat` float default NULL,
  `lon` float default NULL,
  `city` text,
  `st` char(2) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `uncal_d11fcst`
--

DROP TABLE IF EXISTS `uncal_d11fcst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uncal_d11fcst` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `temp` float default NULL,
  `std` float default NULL,
  `prbb` float default NULL,
  `prbn` float default NULL,
  `prba` float default NULL,
  `tcat` float default NULL,
  `tcdf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `uncal_d8fcst`
--

DROP TABLE IF EXISTS `uncal_d8fcst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uncal_d8fcst` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `temp` float default NULL,
  `std` float default NULL,
  `prbb` float default NULL,
  `prbn` float default NULL,
  `prba` float default NULL,
  `tcat` float default NULL,
  `tcdf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Current Database: `climatologies`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `climatologies` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `climatologies`;

--
-- Table structure for table `prcp_1m_1961_1990_102cd`
--

DROP TABLE IF EXISTS `prcp_1m_1961_1990_102cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prcp_1m_1961_1990_102cd` (
  `id` int(11) default NULL,
  `seas` text,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `gamma_diff` float default NULL,
  `shift` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prcp_1m_1961_1990_344cd`
--

DROP TABLE IF EXISTS `prcp_1m_1961_1990_344cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prcp_1m_1961_1990_344cd` (
  `id` int(11) default NULL,
  `seas` text,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `gamma_diff` float default NULL,
  `shift` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prcp_1m_1971_2000_102cd`
--

DROP TABLE IF EXISTS `prcp_1m_1971_2000_102cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prcp_1m_1971_2000_102cd` (
  `id` int(11) default NULL,
  `seas` text,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `gamma_diff` float default NULL,
  `shift` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prcp_1m_1971_2000_344cd`
--

DROP TABLE IF EXISTS `prcp_1m_1971_2000_344cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prcp_1m_1971_2000_344cd` (
  `id` int(11) default NULL,
  `seas` text,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `gamma_diff` float default NULL,
  `shift` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prcp_1m_1981_2010_102cd`
--

DROP TABLE IF EXISTS `prcp_1m_1981_2010_102cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prcp_1m_1981_2010_102cd` (
  `id` int(11) default NULL,
  `seas` text,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `gamma_diff` float default NULL,
  `shift` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prcp_1m_1981_2010_344cd`
--

DROP TABLE IF EXISTS `prcp_1m_1981_2010_344cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prcp_1m_1981_2010_344cd` (
  `id` int(11) default NULL,
  `seas` text,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `gamma_diff` float default NULL,
  `shift` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prcp_3m_1961_1990_102cd`
--

DROP TABLE IF EXISTS `prcp_3m_1961_1990_102cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prcp_3m_1961_1990_102cd` (
  `id` int(11) default NULL,
  `seas` text,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `gamma_diff` float default NULL,
  `shift` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prcp_3m_1961_1990_344cd`
--

DROP TABLE IF EXISTS `prcp_3m_1961_1990_344cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prcp_3m_1961_1990_344cd` (
  `id` int(11) default NULL,
  `seas` text,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `gamma_diff` float default NULL,
  `shift` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prcp_3m_1971_2000_102cd`
--

DROP TABLE IF EXISTS `prcp_3m_1971_2000_102cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prcp_3m_1971_2000_102cd` (
  `id` int(11) default NULL,
  `seas` text,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `gamma_diff` float default NULL,
  `shift` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prcp_3m_1971_2000_344cd`
--

DROP TABLE IF EXISTS `prcp_3m_1971_2000_344cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prcp_3m_1971_2000_344cd` (
  `id` int(11) default NULL,
  `seas` text,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `gamma_diff` float default NULL,
  `shift` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prcp_3m_1981_2010_102cd`
--

DROP TABLE IF EXISTS `prcp_3m_1981_2010_102cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prcp_3m_1981_2010_102cd` (
  `id` int(11) default NULL,
  `seas` text,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `gamma_diff` float default NULL,
  `shift` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prcp_3m_1981_2010_344cd`
--

DROP TABLE IF EXISTS `prcp_3m_1981_2010_344cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prcp_3m_1981_2010_344cd` (
  `id` int(11) default NULL,
  `seas` text,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `gamma_diff` float default NULL,
  `shift` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prcp_5d_1981_2010_stn`
--

DROP TABLE IF EXISTS `prcp_5d_1981_2010_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prcp_5d_1981_2010_stn` (
  `id` int(11) default NULL,
  `date` date default NULL,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `gamma_diff` float default NULL,
  `shift` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prcp_7d_1981_2010_stn`
--

DROP TABLE IF EXISTS `prcp_7d_1981_2010_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prcp_7d_1981_2010_stn` (
  `id` int(11) default NULL,
  `date` date default NULL,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `gamma_diff` float default NULL,
  `shift` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ref_climateDivisions_102`
--

DROP TABLE IF EXISTS `ref_climateDivisions_102`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ref_climateDivisions_102` (
  `ID` int(11) default NULL,
  `Name` text,
  `WMO` int(11) default NULL,
  `Lat` float default NULL,
  `Lon` float default NULL,
  `Population` float default NULL,
  `Area` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ref_climateDivisions_344`
--

DROP TABLE IF EXISTS `ref_climateDivisions_344`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ref_climateDivisions_344` (
  `ID` int(11) default NULL,
  `ST_ID` int(11) default NULL,
  `Lat` float default NULL,
  `Lon` float default NULL,
  `Population` float default NULL,
  `Area` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `state_codes`
--

DROP TABLE IF EXISTS `state_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `state_codes` (
  `num` int(11) default NULL,
  `state` text
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_1m_1961_1990_102cd`
--

DROP TABLE IF EXISTS `temp_1m_1961_1990_102cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_1m_1961_1990_102cd` (
  `id` int(11) default NULL,
  `seas` text,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `shift` float default NULL,
  `gamma_diff` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_1m_1961_1990_344cd`
--

DROP TABLE IF EXISTS `temp_1m_1961_1990_344cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_1m_1961_1990_344cd` (
  `id` int(11) default NULL,
  `seas` text,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `shift` float default NULL,
  `gamma_diff` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_1m_1971_2000_102cd`
--

DROP TABLE IF EXISTS `temp_1m_1971_2000_102cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_1m_1971_2000_102cd` (
  `id` int(11) default NULL,
  `seas` text,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `shift` float default NULL,
  `gamma_diff` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_1m_1971_2000_344cd`
--

DROP TABLE IF EXISTS `temp_1m_1971_2000_344cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_1m_1971_2000_344cd` (
  `id` int(11) default NULL,
  `seas` text,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `shift` float default NULL,
  `gamma_diff` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_1m_1981_2010_102cd`
--

DROP TABLE IF EXISTS `temp_1m_1981_2010_102cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_1m_1981_2010_102cd` (
  `id` int(11) default NULL,
  `seas` text,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `shift` float default NULL,
  `gamma_diff` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_1m_1981_2010_344cd`
--

DROP TABLE IF EXISTS `temp_1m_1981_2010_344cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_1m_1981_2010_344cd` (
  `id` int(11) default NULL,
  `seas` text,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `shift` float default NULL,
  `gamma_diff` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_3m_1961_1990_102cd`
--

DROP TABLE IF EXISTS `temp_3m_1961_1990_102cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_3m_1961_1990_102cd` (
  `id` int(11) default NULL,
  `seas` text,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `shift` float default NULL,
  `gamma_diff` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_3m_1961_1990_344cd`
--

DROP TABLE IF EXISTS `temp_3m_1961_1990_344cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_3m_1961_1990_344cd` (
  `id` int(11) default NULL,
  `seas` text,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `shift` float default NULL,
  `gamma_diff` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_3m_1971_2000_102cd`
--

DROP TABLE IF EXISTS `temp_3m_1971_2000_102cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_3m_1971_2000_102cd` (
  `id` int(11) default NULL,
  `seas` text,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `shift` float default NULL,
  `gamma_diff` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_3m_1971_2000_344cd`
--

DROP TABLE IF EXISTS `temp_3m_1971_2000_344cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_3m_1971_2000_344cd` (
  `id` int(11) default NULL,
  `seas` text,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `shift` float default NULL,
  `gamma_diff` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_3m_1981_2010_102cd`
--

DROP TABLE IF EXISTS `temp_3m_1981_2010_102cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_3m_1981_2010_102cd` (
  `id` int(11) default NULL,
  `seas` text,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `shift` float default NULL,
  `gamma_diff` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_3m_1981_2010_344cd`
--

DROP TABLE IF EXISTS `temp_3m_1981_2010_344cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_3m_1981_2010_344cd` (
  `id` int(11) default NULL,
  `seas` text,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `shift` float default NULL,
  `gamma_diff` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_5d_1981_2010_stn`
--

DROP TABLE IF EXISTS `temp_5d_1981_2010_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_5d_1981_2010_stn` (
  `id` int(11) default NULL,
  `date` date default NULL,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `shift` float default NULL,
  `gamma_diff` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_7d_1981_2010_stn`
--

DROP TABLE IF EXISTS `temp_7d_1981_2010_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_7d_1981_2010_stn` (
  `id` int(11) default NULL,
  `date` date default NULL,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `Mean` float default NULL,
  `Stnd` float default NULL,
  `norm_diff` float default NULL,
  `shape` float default NULL,
  `scale` float default NULL,
  `shift` float default NULL,
  `gamma_diff` float default NULL,
  `pcnt_zero` float default NULL,
  `power_transform` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Current Database: `cpc_climatologies`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `cpc_climatologies` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `cpc_climatologies`;

--
-- Table structure for table `percentDry_05d_1971_2000_grid2deg`
--

DROP TABLE IF EXISTS `percentDry_05d_1971_2000_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `percentDry_05d_1971_2000_grid2deg` (
  `id` varchar(5) default NULL,
  `date_valid` date default NULL,
  `percentDry` float default NULL,
  UNIQUE KEY `index_date_id` (`date_valid`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_valid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `percentDry_05d_1971_2000_stn`
--

DROP TABLE IF EXISTS `percentDry_05d_1971_2000_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `percentDry_05d_1971_2000_stn` (
  `id` varchar(5) default NULL,
  `date_valid` date default NULL,
  `percentDry` float default NULL,
  UNIQUE KEY `index_date_id` (`date_valid`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_valid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `percentDry_05d_1981_2010_grid2deg`
--

DROP TABLE IF EXISTS `percentDry_05d_1981_2010_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `percentDry_05d_1981_2010_grid2deg` (
  `id` varchar(5) default NULL,
  `date_valid` date default NULL,
  `percentDry` float default NULL,
  UNIQUE KEY `index_date_id` (`date_valid`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_valid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `percentDry_05d_1981_2010_stn`
--

DROP TABLE IF EXISTS `percentDry_05d_1981_2010_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `percentDry_05d_1981_2010_stn` (
  `id` varchar(5) default NULL,
  `date_valid` date default NULL,
  `percentDry` float default NULL,
  UNIQUE KEY `index_date_id` (`date_valid`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_valid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `percentDry_07d_1971_2000_grid2deg`
--

DROP TABLE IF EXISTS `percentDry_07d_1971_2000_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `percentDry_07d_1971_2000_grid2deg` (
  `id` varchar(5) default NULL,
  `date_valid` date default NULL,
  `percentDry` float default NULL,
  UNIQUE KEY `index_date_id` (`date_valid`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_valid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `percentDry_07d_1971_2000_stn`
--

DROP TABLE IF EXISTS `percentDry_07d_1971_2000_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `percentDry_07d_1971_2000_stn` (
  `id` varchar(5) default NULL,
  `date_valid` date default NULL,
  `percentDry` float default NULL,
  UNIQUE KEY `index_date_id` (`date_valid`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_valid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `percentDry_07d_1981_2010_grid2deg`
--

DROP TABLE IF EXISTS `percentDry_07d_1981_2010_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `percentDry_07d_1981_2010_grid2deg` (
  `id` varchar(5) default NULL,
  `date_valid` date default NULL,
  `percentDry` float default NULL,
  UNIQUE KEY `index_date_id` (`date_valid`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_valid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `percentDry_07d_1981_2010_stn`
--

DROP TABLE IF EXISTS `percentDry_07d_1981_2010_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `percentDry_07d_1981_2010_stn` (
  `id` varchar(5) default NULL,
  `date_valid` date default NULL,
  `percentDry` float default NULL,
  UNIQUE KEY `index_date_id` (`date_valid`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_valid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Current Database: `cpc_forecasts`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `cpc_forecasts` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `cpc_forecasts`;

--
-- Table structure for table `precip_analog_cmce_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_analog_cmce_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_analog_cmce_00z_08d_05d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_analog_cmce_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_analog_cmce_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_analog_cmce_00z_11d_07d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_analog_ecm_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_analog_ecm_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_analog_ecm_00z_08d_05d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_analog_ecens_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_analog_ecens_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_analog_ecens_00z_08d_05d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_analog_ecens_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_analog_ecens_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_analog_ecens_00z_11d_07d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_analog_gfs_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_analog_gfs_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_analog_gfs_00z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_analog_gfs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_analog_gfs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_analog_gfs_00z_11d_07d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_analog_gfs_06z_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_analog_gfs_06z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_analog_gfs_06z_08d_05d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_analog_gfs_06z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_analog_gfs_06z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_analog_gfs_06z_11d_07d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_analog_gefs_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_analog_gefs_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_analog_gefs_00z_08d_05d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_analog_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_analog_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_analog_gefs_00z_11d_07d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_analog_gefs_06z_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_analog_gefs_06z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_analog_gefs_06z_08d_05d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_analog_gefs_06z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_analog_gefs_06z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_analog_gefs_06z_11d_07d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_analog_gefs_al_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_analog_gefs_al_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_analog_gefs_al_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_analog_gefs_al_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_analog_gefs_al_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_analog_gefs_al_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_auto_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_auto_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_auto_08d_05d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_auto_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_auto_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_auto_11d_07d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_calibratedCat_gfs_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_calibratedCat_gfs_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_calibratedCat_gfs_00z_08d_05d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_calibratedCat_gfs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_calibratedCat_gfs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_calibratedCat_gfs_00z_11d_07d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_calibratedCat_gfs_06z_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_calibratedCat_gfs_06z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_calibratedCat_gfs_06z_08d_05d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_calibratedCat_gfs_06z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_calibratedCat_gfs_06z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_calibratedCat_gfs_06z_11d_07d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_calibratedCat_gefs_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_calibratedCat_gefs_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_calibratedCat_gefs_00z_08d_05d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_calibratedCat_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_calibratedCat_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_calibratedCat_gefs_00z_11d_07d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_calibratedCat_gefs_06z_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_calibratedCat_gefs_06z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_calibratedCat_gefs_06z_08d_05d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_calibratedCat_gefs_06z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_calibratedCat_gefs_06z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_calibratedCat_gefs_06z_11d_07d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_calibratedProb_gefs_al_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_calibratedProb_gefs_al_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_calibratedProb_gefs_al_08d_05d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_calibratedProb_gefs_al_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_calibratedProb_gefs_al_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_calibratedProb_gefs_al_11d_07d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_calibratedProb_naefs_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_calibratedProb_naefs_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_calibratedProb_naefs_00z_08d_05d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_calibratedProb_naefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_calibratedProb_naefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_calibratedProb_naefs_00z_11d_07d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cca_02m_03m_cd`
--

DROP TABLE IF EXISTS `precip_cca_02m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cca_02m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cca_03m_03m_cd`
--

DROP TABLE IF EXISTS `precip_cca_03m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cca_03m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cca_04m_03m_cd`
--

DROP TABLE IF EXISTS `precip_cca_04m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cca_04m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cca_05m_03m_cd`
--

DROP TABLE IF EXISTS `precip_cca_05m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cca_05m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cca_06m_03m_cd`
--

DROP TABLE IF EXISTS `precip_cca_06m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cca_06m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cca_07m_03m_cd`
--

DROP TABLE IF EXISTS `precip_cca_07m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cca_07m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cca_08m_03m_cd`
--

DROP TABLE IF EXISTS `precip_cca_08m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cca_08m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cca_09m_03m_cd`
--

DROP TABLE IF EXISTS `precip_cca_09m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cca_09m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cca_10m_03m_cd`
--

DROP TABLE IF EXISTS `precip_cca_10m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cca_10m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cca_11m_03m_cd`
--

DROP TABLE IF EXISTS `precip_cca_11m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cca_11m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cca_12m_03m_cd`
--

DROP TABLE IF EXISTS `precip_cca_12m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cca_12m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cca_13m_03m_cd`
--

DROP TABLE IF EXISTS `precip_cca_13m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cca_13m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cca_14m_03m_cd`
--

DROP TABLE IF EXISTS `precip_cca_14m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cca_14m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cdc_cdcgfs_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_cdc_cdcgfs_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cdc_cdcgfs_08d_05d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cdc_cdcgfs_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_cdc_cdcgfs_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cdc_cdcgfs_11d_07d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cfs_02m_03m_cd`
--

DROP TABLE IF EXISTS `precip_cfs_02m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cfs_02m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cfs_03m_03m_cd`
--

DROP TABLE IF EXISTS `precip_cfs_03m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cfs_03m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cfs_04m_03m_cd`
--

DROP TABLE IF EXISTS `precip_cfs_04m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cfs_04m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cfs_05m_03m_cd`
--

DROP TABLE IF EXISTS `precip_cfs_05m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cfs_05m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cfs_06m_03m_cd`
--

DROP TABLE IF EXISTS `precip_cfs_06m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cfs_06m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cfs_07m_03m_cd`
--

DROP TABLE IF EXISTS `precip_cfs_07m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cfs_07m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cfs_08m_03m_cd`
--

DROP TABLE IF EXISTS `precip_cfs_08m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cfs_08m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cfs_09m_03m_cd`
--

DROP TABLE IF EXISTS `precip_cfs_09m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cfs_09m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cfs_10m_03m_cd`
--

DROP TABLE IF EXISTS `precip_cfs_10m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cfs_10m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cfs_11m_03m_cd`
--

DROP TABLE IF EXISTS `precip_cfs_11m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cfs_11m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cfs_12m_03m_cd`
--

DROP TABLE IF EXISTS `precip_cfs_12m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cfs_12m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cfs_13m_03m_cd`
--

DROP TABLE IF EXISTS `precip_cfs_13m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cfs_13m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_cfs_14m_03m_cd`
--

DROP TABLE IF EXISTS `precip_cfs_14m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_cfs_14m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_con_02m_03m_cd`
--

DROP TABLE IF EXISTS `precip_con_02m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_con_02m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_con_02m_03m_grid2deg`
--

DROP TABLE IF EXISTS `precip_con_02m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_con_02m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_con_03m_03m_cd`
--

DROP TABLE IF EXISTS `precip_con_03m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_con_03m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_con_03m_03m_grid2deg`
--

DROP TABLE IF EXISTS `precip_con_03m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_con_03m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_con_04m_03m_cd`
--

DROP TABLE IF EXISTS `precip_con_04m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_con_04m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_con_04m_03m_grid2deg`
--

DROP TABLE IF EXISTS `precip_con_04m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_con_04m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_con_05m_03m_cd`
--

DROP TABLE IF EXISTS `precip_con_05m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_con_05m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_con_05m_03m_grid2deg`
--

DROP TABLE IF EXISTS `precip_con_05m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_con_05m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_con_06m_03m_cd`
--

DROP TABLE IF EXISTS `precip_con_06m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_con_06m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_con_06m_03m_grid2deg`
--

DROP TABLE IF EXISTS `precip_con_06m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_con_06m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_con_07m_03m_cd`
--

DROP TABLE IF EXISTS `precip_con_07m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_con_07m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_con_07m_03m_grid2deg`
--

DROP TABLE IF EXISTS `precip_con_07m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_con_07m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_con_08m_03m_cd`
--

DROP TABLE IF EXISTS `precip_con_08m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_con_08m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_con_08m_03m_grid2deg`
--

DROP TABLE IF EXISTS `precip_con_08m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_con_08m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_con_09m_03m_cd`
--

DROP TABLE IF EXISTS `precip_con_09m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_con_09m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_con_09m_03m_grid2deg`
--

DROP TABLE IF EXISTS `precip_con_09m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_con_09m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_con_10m_03m_cd`
--

DROP TABLE IF EXISTS `precip_con_10m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_con_10m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_con_10m_03m_grid2deg`
--

DROP TABLE IF EXISTS `precip_con_10m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_con_10m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_con_11m_03m_cd`
--

DROP TABLE IF EXISTS `precip_con_11m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_con_11m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_con_11m_03m_grid2deg`
--

DROP TABLE IF EXISTS `precip_con_11m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_con_11m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_con_12m_03m_cd`
--

DROP TABLE IF EXISTS `precip_con_12m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_con_12m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_con_12m_03m_grid2deg`
--

DROP TABLE IF EXISTS `precip_con_12m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_con_12m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_con_13m_03m_cd`
--

DROP TABLE IF EXISTS `precip_con_13m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_con_13m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_con_13m_03m_grid2deg`
--

DROP TABLE IF EXISTS `precip_con_13m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_con_13m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_con_14m_03m_cd`
--

DROP TABLE IF EXISTS `precip_con_14m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_con_14m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_con_14m_03m_grid2deg`
--

DROP TABLE IF EXISTS `precip_con_14m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_con_14m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_manual_01m_01m_cd`
--

DROP TABLE IF EXISTS `precip_manual_01m_01m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_manual_01m_01m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_manual_01m_01m_grid2deg`
--

DROP TABLE IF EXISTS `precip_manual_01m_01m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_manual_01m_01m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_manual_02m_03m_cd`
--

DROP TABLE IF EXISTS `precip_manual_02m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_manual_02m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_manual_02m_03m_grid2deg`
--

DROP TABLE IF EXISTS `precip_manual_02m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_manual_02m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_manual_03m_03m_cd`
--

DROP TABLE IF EXISTS `precip_manual_03m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_manual_03m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_manual_04m_03m_cd`
--

DROP TABLE IF EXISTS `precip_manual_04m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_manual_04m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_manual_05m_03m_cd`
--

DROP TABLE IF EXISTS `precip_manual_05m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_manual_05m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_manual_06m_03m_cd`
--

DROP TABLE IF EXISTS `precip_manual_06m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_manual_06m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_manual_07m_03m_cd`
--

DROP TABLE IF EXISTS `precip_manual_07m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_manual_07m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_manual_08d_05d_grid2deg`
--

DROP TABLE IF EXISTS `precip_manual_08d_05d_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_manual_08d_05d_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_manual_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_manual_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_manual_08d_05d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_manual_08m_03m_cd`
--

DROP TABLE IF EXISTS `precip_manual_08m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_manual_08m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_manual_09m_03m_cd`
--

DROP TABLE IF EXISTS `precip_manual_09m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_manual_09m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_manual_0pt5m_01m_cd`
--

DROP TABLE IF EXISTS `precip_manual_0pt5m_01m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_manual_0pt5m_01m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_manual_0pt5m_01m_grid2deg`
--

DROP TABLE IF EXISTS `precip_manual_0pt5m_01m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_manual_0pt5m_01m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_manual_10m_03m_cd`
--

DROP TABLE IF EXISTS `precip_manual_10m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_manual_10m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_manual_11d_07d_grid2deg`
--

DROP TABLE IF EXISTS `precip_manual_11d_07d_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_manual_11d_07d_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_manual_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_manual_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_manual_11d_07d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_manual_11m_03m_cd`
--

DROP TABLE IF EXISTS `precip_manual_11m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_manual_11m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_manual_12m_03m_cd`
--

DROP TABLE IF EXISTS `precip_manual_12m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_manual_12m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_manual_13m_03m_cd`
--

DROP TABLE IF EXISTS `precip_manual_13m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_manual_13m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_manual_14m_03m_cd`
--

DROP TABLE IF EXISTS `precip_manual_14m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_manual_14m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_ocn_02m_03m_cd`
--

DROP TABLE IF EXISTS `precip_ocn_02m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_ocn_02m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_ocn_03m_03m_cd`
--

DROP TABLE IF EXISTS `precip_ocn_03m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_ocn_03m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_ocn_04m_03m_cd`
--

DROP TABLE IF EXISTS `precip_ocn_04m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_ocn_04m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_ocn_05m_03m_cd`
--

DROP TABLE IF EXISTS `precip_ocn_05m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_ocn_05m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_ocn_06m_03m_cd`
--

DROP TABLE IF EXISTS `precip_ocn_06m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_ocn_06m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_ocn_07m_03m_cd`
--

DROP TABLE IF EXISTS `precip_ocn_07m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_ocn_07m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_ocn_08m_03m_cd`
--

DROP TABLE IF EXISTS `precip_ocn_08m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_ocn_08m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_ocn_09m_03m_cd`
--

DROP TABLE IF EXISTS `precip_ocn_09m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_ocn_09m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_ocn_10m_03m_cd`
--

DROP TABLE IF EXISTS `precip_ocn_10m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_ocn_10m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_ocn_11m_03m_cd`
--

DROP TABLE IF EXISTS `precip_ocn_11m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_ocn_11m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_ocn_12m_03m_cd`
--

DROP TABLE IF EXISTS `precip_ocn_12m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_ocn_12m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_ocn_13m_03m_cd`
--

DROP TABLE IF EXISTS `precip_ocn_13m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_ocn_13m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_ocn_14m_03m_cd`
--

DROP TABLE IF EXISTS `precip_ocn_14m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_ocn_14m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_reforecastCalibratedProb0_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_reforecastCalibratedProb0_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_reforecastCalibratedProb0_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_reforecastCalibratedProb10_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_reforecastCalibratedProb10_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_reforecastCalibratedProb10_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_reforecastCalibratedProb11_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_reforecastCalibratedProb11_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_reforecastCalibratedProb11_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_reforecastCalibratedProb1_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_reforecastCalibratedProb1_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_reforecastCalibratedProb1_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_reforecastCalibratedProb2_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_reforecastCalibratedProb2_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_reforecastCalibratedProb2_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_reforecastCalibratedProb3_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_reforecastCalibratedProb3_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_reforecastCalibratedProb3_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_reforecastCalibratedProb4_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_reforecastCalibratedProb4_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_reforecastCalibratedProb4_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_reforecastCalibratedProb5_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_reforecastCalibratedProb5_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_reforecastCalibratedProb5_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_reforecastCalibratedProb6_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_reforecastCalibratedProb6_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_reforecastCalibratedProb6_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_reforecastCalibratedProb7_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_reforecastCalibratedProb7_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_reforecastCalibratedProb7_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_reforecastCalibratedProb8_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_reforecastCalibratedProb8_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_reforecastCalibratedProb8_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_reforecastCalibratedProb9_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_reforecastCalibratedProb9_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_reforecastCalibratedProb9_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_reforecastCalibratedProb_gefs_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_reforecastCalibratedProb_gefs_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_reforecastCalibratedProb_gefs_00z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_reforecastCalibratedProb_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_reforecastCalibratedProb_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_reforecastCalibratedProb_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_smlr_02m_03m_cd`
--

DROP TABLE IF EXISTS `precip_smlr_02m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_smlr_02m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_smlr_03m_03m_cd`
--

DROP TABLE IF EXISTS `precip_smlr_03m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_smlr_03m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_smlr_04m_03m_cd`
--

DROP TABLE IF EXISTS `precip_smlr_04m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_smlr_04m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_smlr_05m_03m_cd`
--

DROP TABLE IF EXISTS `precip_smlr_05m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_smlr_05m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_smlr_06m_03m_cd`
--

DROP TABLE IF EXISTS `precip_smlr_06m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_smlr_06m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_smlr_07m_03m_cd`
--

DROP TABLE IF EXISTS `precip_smlr_07m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_smlr_07m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_smlr_08m_03m_cd`
--

DROP TABLE IF EXISTS `precip_smlr_08m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_smlr_08m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_smlr_09m_03m_cd`
--

DROP TABLE IF EXISTS `precip_smlr_09m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_smlr_09m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_smlr_10m_03m_cd`
--

DROP TABLE IF EXISTS `precip_smlr_10m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_smlr_10m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_smlr_11m_03m_cd`
--

DROP TABLE IF EXISTS `precip_smlr_11m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_smlr_11m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_smlr_12m_03m_cd`
--

DROP TABLE IF EXISTS `precip_smlr_12m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_smlr_12m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_smlr_13m_03m_cd`
--

DROP TABLE IF EXISTS `precip_smlr_13m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_smlr_13m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_smlr_14m_03m_cd`
--

DROP TABLE IF EXISTS `precip_smlr_14m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_smlr_14m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_analog_cmce_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_analog_cmce_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_analog_cmce_00z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_analog_cmce_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_analog_cmce_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_analog_cmce_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_analog_ecm_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_analog_ecm_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_analog_ecm_00z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_analog_ecens_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_analog_ecens_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_analog_ecens_00z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_analog_ecens_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_analog_ecens_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_analog_ecens_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_analog_gfs_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_analog_gfs_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_analog_gfs_00z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_analog_gfs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_analog_gfs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_analog_gfs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_analog_gfs_06z_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_analog_gfs_06z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_analog_gfs_06z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_analog_gfs_06z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_analog_gfs_06z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_analog_gfs_06z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_analog_gefs_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_analog_gefs_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_analog_gefs_00z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_analog_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_analog_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_analog_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_analog_gefs_06z_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_analog_gefs_06z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_analog_gefs_06z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_analog_gefs_06z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_analog_gefs_06z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_analog_gefs_06z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_analog_gefs_al_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_analog_gefs_al_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_analog_gefs_al_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_analog_gefs_al_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_analog_gefs_al_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_analog_gefs_al_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_auto_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_auto_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_auto_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_auto_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_auto_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_auto_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_calibratedProb_gefs_al_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_calibratedProb_gefs_al_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_calibratedProb_gefs_al_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_calibratedProb_gefs_al_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_calibratedProb_gefs_al_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_calibratedProb_gefs_al_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_calibratedProb_naefs_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_calibratedProb_naefs_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_calibratedProb_naefs_00z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_calibratedProb_naefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_calibratedProb_naefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_calibratedProb_naefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_calibratedProb_naefs_06z_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_calibratedProb_naefs_06z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_calibratedProb_naefs_06z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_calibratedProb_naefs_06z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_calibratedProb_naefs_06z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_calibratedProb_naefs_06z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cca_02m_03m_cd`
--

DROP TABLE IF EXISTS `temp_cca_02m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cca_02m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cca_03m_03m_cd`
--

DROP TABLE IF EXISTS `temp_cca_03m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cca_03m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cca_04m_03m_cd`
--

DROP TABLE IF EXISTS `temp_cca_04m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cca_04m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cca_05m_03m_cd`
--

DROP TABLE IF EXISTS `temp_cca_05m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cca_05m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cca_06m_03m_cd`
--

DROP TABLE IF EXISTS `temp_cca_06m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cca_06m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cca_07m_03m_cd`
--

DROP TABLE IF EXISTS `temp_cca_07m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cca_07m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cca_08m_03m_cd`
--

DROP TABLE IF EXISTS `temp_cca_08m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cca_08m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cca_09m_03m_cd`
--

DROP TABLE IF EXISTS `temp_cca_09m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cca_09m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cca_10m_03m_cd`
--

DROP TABLE IF EXISTS `temp_cca_10m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cca_10m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cca_11m_03m_cd`
--

DROP TABLE IF EXISTS `temp_cca_11m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cca_11m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cca_12m_03m_cd`
--

DROP TABLE IF EXISTS `temp_cca_12m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cca_12m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cca_13m_03m_cd`
--

DROP TABLE IF EXISTS `temp_cca_13m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cca_13m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cca_14m_03m_cd`
--

DROP TABLE IF EXISTS `temp_cca_14m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cca_14m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cdc_cdcgfs_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_cdc_cdcgfs_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cdc_cdcgfs_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cdc_cdcgfs_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_cdc_cdcgfs_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cdc_cdcgfs_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cfs_02m_03m_cd`
--

DROP TABLE IF EXISTS `temp_cfs_02m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cfs_02m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cfs_03m_03m_cd`
--

DROP TABLE IF EXISTS `temp_cfs_03m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cfs_03m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cfs_04m_03m_cd`
--

DROP TABLE IF EXISTS `temp_cfs_04m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cfs_04m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cfs_05m_03m_cd`
--

DROP TABLE IF EXISTS `temp_cfs_05m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cfs_05m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cfs_06m_03m_cd`
--

DROP TABLE IF EXISTS `temp_cfs_06m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cfs_06m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cfs_07m_03m_cd`
--

DROP TABLE IF EXISTS `temp_cfs_07m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cfs_07m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cfs_08m_03m_cd`
--

DROP TABLE IF EXISTS `temp_cfs_08m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cfs_08m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cfs_09m_03m_cd`
--

DROP TABLE IF EXISTS `temp_cfs_09m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cfs_09m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cfs_10m_03m_cd`
--

DROP TABLE IF EXISTS `temp_cfs_10m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cfs_10m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cfs_11m_03m_cd`
--

DROP TABLE IF EXISTS `temp_cfs_11m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cfs_11m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cfs_12m_03m_cd`
--

DROP TABLE IF EXISTS `temp_cfs_12m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cfs_12m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cfs_13m_03m_cd`
--

DROP TABLE IF EXISTS `temp_cfs_13m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cfs_13m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_cfs_14m_03m_cd`
--

DROP TABLE IF EXISTS `temp_cfs_14m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_cfs_14m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_con_02m_03m_cd`
--

DROP TABLE IF EXISTS `temp_con_02m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_con_02m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_con_02m_03m_grid2deg`
--

DROP TABLE IF EXISTS `temp_con_02m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_con_02m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_con_03m_03m_cd`
--

DROP TABLE IF EXISTS `temp_con_03m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_con_03m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_con_03m_03m_grid2deg`
--

DROP TABLE IF EXISTS `temp_con_03m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_con_03m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_con_04m_03m_cd`
--

DROP TABLE IF EXISTS `temp_con_04m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_con_04m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_con_04m_03m_grid2deg`
--

DROP TABLE IF EXISTS `temp_con_04m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_con_04m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_con_05m_03m_cd`
--

DROP TABLE IF EXISTS `temp_con_05m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_con_05m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_con_05m_03m_grid2deg`
--

DROP TABLE IF EXISTS `temp_con_05m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_con_05m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_con_06m_03m_cd`
--

DROP TABLE IF EXISTS `temp_con_06m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_con_06m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_con_06m_03m_grid2deg`
--

DROP TABLE IF EXISTS `temp_con_06m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_con_06m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_con_07m_03m_cd`
--

DROP TABLE IF EXISTS `temp_con_07m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_con_07m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_con_07m_03m_grid2deg`
--

DROP TABLE IF EXISTS `temp_con_07m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_con_07m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_con_08m_03m_cd`
--

DROP TABLE IF EXISTS `temp_con_08m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_con_08m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_con_08m_03m_grid2deg`
--

DROP TABLE IF EXISTS `temp_con_08m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_con_08m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_con_09m_03m_cd`
--

DROP TABLE IF EXISTS `temp_con_09m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_con_09m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_con_09m_03m_grid2deg`
--

DROP TABLE IF EXISTS `temp_con_09m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_con_09m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_con_10m_03m_cd`
--

DROP TABLE IF EXISTS `temp_con_10m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_con_10m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_con_10m_03m_grid2deg`
--

DROP TABLE IF EXISTS `temp_con_10m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_con_10m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_con_11m_03m_cd`
--

DROP TABLE IF EXISTS `temp_con_11m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_con_11m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_con_11m_03m_grid2deg`
--

DROP TABLE IF EXISTS `temp_con_11m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_con_11m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_con_12m_03m_cd`
--

DROP TABLE IF EXISTS `temp_con_12m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_con_12m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_con_12m_03m_grid2deg`
--

DROP TABLE IF EXISTS `temp_con_12m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_con_12m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_con_13m_03m_cd`
--

DROP TABLE IF EXISTS `temp_con_13m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_con_13m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_con_13m_03m_grid2deg`
--

DROP TABLE IF EXISTS `temp_con_13m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_con_13m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_con_14m_03m_cd`
--

DROP TABLE IF EXISTS `temp_con_14m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_con_14m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_con_14m_03m_grid2deg`
--

DROP TABLE IF EXISTS `temp_con_14m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_con_14m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_kleinCat_auto_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_kleinCat_auto_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_kleinCat_auto_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_kleinCat_auto_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_kleinCat_auto_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_kleinCat_auto_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_kleinCat_cmce_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_kleinCat_cmce_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_kleinCat_cmce_00z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_kleinCat_cmce_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_kleinCat_cmce_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_kleinCat_cmce_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_kleinCat_ecm_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_kleinCat_ecm_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_kleinCat_ecm_00z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_kleinCat_ecens_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_kleinCat_ecens_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_kleinCat_ecens_00z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_kleinCat_ecens_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_kleinCat_ecens_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_kleinCat_ecens_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_kleinCat_gfs_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_kleinCat_gfs_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_kleinCat_gfs_00z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_kleinCat_gfs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_kleinCat_gfs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_kleinCat_gfs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_kleinCat_gfs_06z_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_kleinCat_gfs_06z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_kleinCat_gfs_06z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_kleinCat_gfs_06z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_kleinCat_gfs_06z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_kleinCat_gfs_06z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_kleinCat_gefs_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_kleinCat_gefs_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_kleinCat_gefs_00z_08d_05d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_kleinCat_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_kleinCat_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_kleinCat_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_kleinCat_gefs_06z_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_kleinCat_gefs_06z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_kleinCat_gefs_06z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_kleinCat_gefs_06z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_kleinCat_gefs_06z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_kleinCat_gefs_06z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_kleinCat_gefs_al_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_kleinCat_gefs_al_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_kleinCat_gefs_al_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_kleinCat_gefs_al_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_kleinCat_gefs_al_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_kleinCat_gefs_al_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_kleinCat_manual_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_kleinCat_manual_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_kleinCat_manual_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_kleinCat_manual_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_kleinCat_manual_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_kleinCat_manual_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_kleinProb_cmce_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_kleinProb_cmce_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_kleinProb_cmce_00z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_kleinProb_cmce_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_kleinProb_cmce_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_kleinProb_cmce_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_kleinProb_gefs_al_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_kleinProb_gefs_al_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_kleinProb_gefs_al_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_kleinProb_gefs_al_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_kleinProb_gefs_al_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_kleinProb_gefs_al_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_manual_01m_01m_cd`
--

DROP TABLE IF EXISTS `temp_manual_01m_01m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_manual_01m_01m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_manual_01m_01m_grid2deg`
--

DROP TABLE IF EXISTS `temp_manual_01m_01m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_manual_01m_01m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_manual_02m_03m_cd`
--

DROP TABLE IF EXISTS `temp_manual_02m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_manual_02m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_manual_02m_03m_grid2deg`
--

DROP TABLE IF EXISTS `temp_manual_02m_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_manual_02m_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_manual_03m_03m_cd`
--

DROP TABLE IF EXISTS `temp_manual_03m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_manual_03m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_manual_04m_03m_cd`
--

DROP TABLE IF EXISTS `temp_manual_04m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_manual_04m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_manual_05m_03m_cd`
--

DROP TABLE IF EXISTS `temp_manual_05m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_manual_05m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_manual_06m_03m_cd`
--

DROP TABLE IF EXISTS `temp_manual_06m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_manual_06m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_manual_07m_03m_cd`
--

DROP TABLE IF EXISTS `temp_manual_07m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_manual_07m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_manual_08d_05d_grid2deg`
--

DROP TABLE IF EXISTS `temp_manual_08d_05d_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_manual_08d_05d_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_manual_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_manual_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_manual_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_manual_08m_03m_cd`
--

DROP TABLE IF EXISTS `temp_manual_08m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_manual_08m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_manual_09m_03m_cd`
--

DROP TABLE IF EXISTS `temp_manual_09m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_manual_09m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_manual_0pt5m_01m_cd`
--

DROP TABLE IF EXISTS `temp_manual_0pt5m_01m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_manual_0pt5m_01m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_manual_0pt5m_01m_grid2deg`
--

DROP TABLE IF EXISTS `temp_manual_0pt5m_01m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_manual_0pt5m_01m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_manual_10m_03m_cd`
--

DROP TABLE IF EXISTS `temp_manual_10m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_manual_10m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_manual_11d_07d_grid2deg`
--

DROP TABLE IF EXISTS `temp_manual_11d_07d_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_manual_11d_07d_grid2deg` (
  `id` varchar(4) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_manual_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_manual_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_manual_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_manual_11m_03m_cd`
--

DROP TABLE IF EXISTS `temp_manual_11m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_manual_11m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_manual_12m_03m_cd`
--

DROP TABLE IF EXISTS `temp_manual_12m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_manual_12m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_manual_13m_03m_cd`
--

DROP TABLE IF EXISTS `temp_manual_13m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_manual_13m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_manual_14m_03m_cd`
--

DROP TABLE IF EXISTS `temp_manual_14m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_manual_14m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_ocn_02m_03m_cd`
--

DROP TABLE IF EXISTS `temp_ocn_02m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_ocn_02m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_ocn_03m_03m_cd`
--

DROP TABLE IF EXISTS `temp_ocn_03m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_ocn_03m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_ocn_04m_03m_cd`
--

DROP TABLE IF EXISTS `temp_ocn_04m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_ocn_04m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_ocn_05m_03m_cd`
--

DROP TABLE IF EXISTS `temp_ocn_05m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_ocn_05m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_ocn_06m_03m_cd`
--

DROP TABLE IF EXISTS `temp_ocn_06m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_ocn_06m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_ocn_07m_03m_cd`
--

DROP TABLE IF EXISTS `temp_ocn_07m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_ocn_07m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_ocn_08m_03m_cd`
--

DROP TABLE IF EXISTS `temp_ocn_08m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_ocn_08m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_ocn_09m_03m_cd`
--

DROP TABLE IF EXISTS `temp_ocn_09m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_ocn_09m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_ocn_10m_03m_cd`
--

DROP TABLE IF EXISTS `temp_ocn_10m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_ocn_10m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_ocn_11m_03m_cd`
--

DROP TABLE IF EXISTS `temp_ocn_11m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_ocn_11m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_ocn_12m_03m_cd`
--

DROP TABLE IF EXISTS `temp_ocn_12m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_ocn_12m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_ocn_13m_03m_cd`
--

DROP TABLE IF EXISTS `temp_ocn_13m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_ocn_13m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_ocn_14m_03m_cd`
--

DROP TABLE IF EXISTS `temp_ocn_14m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_ocn_14m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_reforecastCalibratedProb0_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_reforecastCalibratedProb0_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_reforecastCalibratedProb0_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_reforecastCalibratedProb10_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_reforecastCalibratedProb10_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_reforecastCalibratedProb10_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_reforecastCalibratedProb11_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_reforecastCalibratedProb11_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_reforecastCalibratedProb11_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_reforecastCalibratedProb1_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_reforecastCalibratedProb1_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_reforecastCalibratedProb1_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_reforecastCalibratedProb2_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_reforecastCalibratedProb2_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_reforecastCalibratedProb2_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_reforecastCalibratedProb3_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_reforecastCalibratedProb3_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_reforecastCalibratedProb3_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_reforecastCalibratedProb4_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_reforecastCalibratedProb4_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_reforecastCalibratedProb4_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_reforecastCalibratedProb5_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_reforecastCalibratedProb5_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_reforecastCalibratedProb5_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_reforecastCalibratedProb6_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_reforecastCalibratedProb6_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_reforecastCalibratedProb6_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_reforecastCalibratedProb7_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_reforecastCalibratedProb7_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_reforecastCalibratedProb7_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_reforecastCalibratedProb8_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_reforecastCalibratedProb8_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_reforecastCalibratedProb8_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_reforecastCalibratedProb9_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_reforecastCalibratedProb9_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_reforecastCalibratedProb9_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_reforecastCalibratedProbObs_gefs_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_reforecastCalibratedProbObs_gefs_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_reforecastCalibratedProbObs_gefs_00z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_reforecastCalibratedProbObs_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_reforecastCalibratedProbObs_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_reforecastCalibratedProbObs_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_reforecastCalibratedProb_gefs_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_reforecastCalibratedProb_gefs_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_reforecastCalibratedProb_gefs_00z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_reforecastCalibratedProb_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_reforecastCalibratedProb_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_reforecastCalibratedProb_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_smlr_02m_03m_cd`
--

DROP TABLE IF EXISTS `temp_smlr_02m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_smlr_02m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_smlr_03m_03m_cd`
--

DROP TABLE IF EXISTS `temp_smlr_03m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_smlr_03m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_smlr_04m_03m_cd`
--

DROP TABLE IF EXISTS `temp_smlr_04m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_smlr_04m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_smlr_05m_03m_cd`
--

DROP TABLE IF EXISTS `temp_smlr_05m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_smlr_05m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_smlr_06m_03m_cd`
--

DROP TABLE IF EXISTS `temp_smlr_06m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_smlr_06m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_smlr_07m_03m_cd`
--

DROP TABLE IF EXISTS `temp_smlr_07m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_smlr_07m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_smlr_08m_03m_cd`
--

DROP TABLE IF EXISTS `temp_smlr_08m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_smlr_08m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_smlr_09m_03m_cd`
--

DROP TABLE IF EXISTS `temp_smlr_09m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_smlr_09m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_smlr_10m_03m_cd`
--

DROP TABLE IF EXISTS `temp_smlr_10m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_smlr_10m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_smlr_11m_03m_cd`
--

DROP TABLE IF EXISTS `temp_smlr_11m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_smlr_11m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_smlr_12m_03m_cd`
--

DROP TABLE IF EXISTS `temp_smlr_12m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_smlr_12m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_smlr_13m_03m_cd`
--

DROP TABLE IF EXISTS `temp_smlr_13m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_smlr_13m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_smlr_14m_03m_cd`
--

DROP TABLE IF EXISTS `temp_smlr_14m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_smlr_14m_03m_cd` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  `skill` float default NULL,
  `standardAnomaly` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_uncalibratedProb_gefs_al_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_uncalibratedProb_gefs_al_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_uncalibratedProb_gefs_al_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_uncalibratedProb_gefs_al_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_uncalibratedProb_gefs_al_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_uncalibratedProb_gefs_al_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Current Database: `cpc_forecasts_backup`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `cpc_forecasts_backup` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `cpc_forecasts_backup`;

--
-- Table structure for table `precip_neuralCat_auto_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_neuralCat_auto_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_neuralCat_auto_08d_05d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_neuralCat_auto_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_neuralCat_auto_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_neuralCat_auto_11d_07d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_neuralCat_cmce_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_neuralCat_cmce_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_neuralCat_cmce_00z_08d_05d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_neuralCat_cmce_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_neuralCat_cmce_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_neuralCat_cmce_00z_11d_07d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_neuralCat_ecm_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_neuralCat_ecm_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_neuralCat_ecm_00z_08d_05d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_neuralCat_ecens_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_neuralCat_ecens_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_neuralCat_ecens_00z_08d_05d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_neuralCat_ecens_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_neuralCat_ecens_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_neuralCat_ecens_00z_11d_07d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_neuralCat_gfs_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_neuralCat_gfs_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_neuralCat_gfs_00z_08d_05d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_neuralCat_gfs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_neuralCat_gfs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_neuralCat_gfs_00z_11d_07d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_neuralCat_gfs_06z_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_neuralCat_gfs_06z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_neuralCat_gfs_06z_08d_05d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_neuralCat_gfs_06z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_neuralCat_gfs_06z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_neuralCat_gfs_06z_11d_07d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_neuralCat_gefs_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_neuralCat_gefs_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_neuralCat_gefs_00z_08d_05d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_neuralCat_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_neuralCat_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_neuralCat_gefs_00z_11d_07d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_neuralCat_gefs_06z_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_neuralCat_gefs_06z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_neuralCat_gefs_06z_08d_05d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_neuralCat_gefs_06z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_neuralCat_gefs_06z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_neuralCat_gefs_06z_11d_07d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_neuralCat_gefs_al_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_neuralCat_gefs_al_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_neuralCat_gefs_al_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_neuralCat_gefs_al_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_neuralCat_gefs_al_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_neuralCat_gefs_al_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_neuralCat_manual_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_neuralCat_manual_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_neuralCat_manual_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_neuralCat_manual_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_neuralCat_manual_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_neuralCat_manual_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_neuralProb_cmce_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_neuralProb_cmce_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_neuralProb_cmce_00z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_neuralProb_cmce_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_neuralProb_cmce_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_neuralProb_cmce_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_neuralProb_gefs_al_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_neuralProb_gefs_al_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_neuralProb_gefs_al_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_neuralProb_gefs_al_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_neuralProb_gefs_al_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_neuralProb_gefs_al_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_neuralCat_auto_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_neuralCat_auto_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_neuralCat_auto_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_neuralCat_auto_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_neuralCat_auto_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_neuralCat_auto_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_neuralCat_cmce_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_neuralCat_cmce_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_neuralCat_cmce_00z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_neuralCat_cmce_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_neuralCat_cmce_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_neuralCat_cmce_00z_11d_07d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_neuralCat_ecm_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_neuralCat_ecm_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_neuralCat_ecm_00z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_neuralCat_ecens_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_neuralCat_ecens_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_neuralCat_ecens_00z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_neuralCat_ecens_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_neuralCat_ecens_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_neuralCat_ecens_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_neuralCat_gfs_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_neuralCat_gfs_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_neuralCat_gfs_00z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_neuralCat_gfs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_neuralCat_gfs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_neuralCat_gfs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_neuralCat_gfs_06z_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_neuralCat_gfs_06z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_neuralCat_gfs_06z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_neuralCat_gfs_06z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_neuralCat_gfs_06z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_neuralCat_gfs_06z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_neuralCat_gefs_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_neuralCat_gefs_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_neuralCat_gefs_00z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_neuralCat_gefs_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_neuralCat_gefs_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_neuralCat_gefs_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_neuralCat_gefs_06z_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_neuralCat_gefs_06z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_neuralCat_gefs_06z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_neuralCat_gefs_06z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_neuralCat_gefs_06z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_neuralCat_gefs_06z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_neuralCat_gefs_al_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_neuralCat_gefs_al_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_neuralCat_gefs_al_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_neuralCat_gefs_al_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_neuralCat_gefs_al_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_neuralCat_gefs_al_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_neuralCat_manual_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_neuralCat_manual_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_neuralCat_manual_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_neuralCat_manual_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_neuralCat_manual_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_neuralCat_manual_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `cdf` float default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_neuralProb_cmce_00z_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_neuralProb_cmce_00z_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_neuralProb_cmce_00z_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_neuralProb_cmce_00z_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_neuralProb_cmce_00z_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_neuralProb_cmce_00z_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_neuralProb_gefs_al_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_neuralProb_gefs_al_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_neuralProb_gefs_al_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_neuralProb_gefs_al_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_neuralProb_gefs_al_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_neuralProb_gefs_al_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL,
  UNIQUE KEY `index_date_id` (`date_issued`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_issued`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Current Database: `cpc_forecasts_test`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `cpc_forecasts_test` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `cpc_forecasts_test`;

--
-- Table structure for table `precip_auto_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_auto_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_auto_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_auto_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_auto_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_auto_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_manual_08d_05d_stn`
--

DROP TABLE IF EXISTS `precip_manual_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_manual_08d_05d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_manual_11d_07d_stn`
--

DROP TABLE IF EXISTS `precip_manual_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_manual_11d_07d_stn` (
  `id` varchar(10) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_auto_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_auto_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_auto_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_auto_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_auto_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_auto_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_manual_08d_05d_stn`
--

DROP TABLE IF EXISTS `temp_manual_08d_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_manual_08d_05d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_manual_11d_07d_stn`
--

DROP TABLE IF EXISTS `temp_manual_11d_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_manual_11d_07d_stn` (
  `id` int(11) default NULL,
  `date_issued` date default NULL,
  `prob_below` float default NULL,
  `prob_normal` float default NULL,
  `prob_above` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Current Database: `cpc_observations`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `cpc_observations` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `cpc_observations`;

--
-- Table structure for table `precip_01m_cd`
--

DROP TABLE IF EXISTS `precip_01m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_01m_cd` (
  `id` char(3) default NULL,
  `date_valid` date default NULL,
  `category` tinyint(4) default NULL,
  UNIQUE KEY `index_date_id` (`date_valid`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_valid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_01m_grid2deg`
--

DROP TABLE IF EXISTS `precip_01m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_01m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_valid` date default NULL,
  `category` tinyint(4) default NULL,
  UNIQUE KEY `index_date_id` (`date_valid`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_valid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_03m_cd`
--

DROP TABLE IF EXISTS `precip_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_03m_cd` (
  `id` char(3) default NULL,
  `date_valid` date default NULL,
  `category` tinyint(4) default NULL,
  UNIQUE KEY `index_date_id` (`date_valid`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_valid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_03m_grid2deg`
--

DROP TABLE IF EXISTS `precip_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_valid` date default NULL,
  `category` tinyint(4) default NULL,
  UNIQUE KEY `index_date_id` (`date_valid`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_valid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_05d_grid2deg`
--

DROP TABLE IF EXISTS `precip_05d_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_05d_grid2deg` (
  `id` varchar(4) default NULL,
  `date_valid` date default NULL,
  `category` tinyint(4) default NULL,
  UNIQUE KEY `index_date_id` (`date_valid`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_valid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_05d_stn`
--

DROP TABLE IF EXISTS `precip_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_05d_stn` (
  `id` varchar(5) default NULL,
  `date_valid` date default NULL,
  `category` tinyint(4) default NULL,
  UNIQUE KEY `index_date_id` (`date_valid`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_valid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_07d_grid2deg`
--

DROP TABLE IF EXISTS `precip_07d_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_07d_grid2deg` (
  `id` varchar(4) default NULL,
  `date_valid` date default NULL,
  `category` tinyint(4) default NULL,
  UNIQUE KEY `index_date_id` (`date_valid`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_valid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `precip_07d_stn`
--

DROP TABLE IF EXISTS `precip_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `precip_07d_stn` (
  `id` varchar(5) default NULL,
  `date_valid` date default NULL,
  `category` tinyint(4) default NULL,
  UNIQUE KEY `index_date_id` (`date_valid`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_valid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_01m_cd`
--

DROP TABLE IF EXISTS `temp_01m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_01m_cd` (
  `id` char(3) default NULL,
  `date_valid` date default NULL,
  `category` tinyint(4) default NULL,
  UNIQUE KEY `index_date_id` (`date_valid`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_valid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_01m_grid2deg`
--

DROP TABLE IF EXISTS `temp_01m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_01m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_valid` date default NULL,
  `category` tinyint(4) default NULL,
  UNIQUE KEY `index_date_id` (`date_valid`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_valid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_03m_cd`
--

DROP TABLE IF EXISTS `temp_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_03m_cd` (
  `id` char(3) default NULL,
  `date_valid` date default NULL,
  `category` tinyint(4) default NULL,
  UNIQUE KEY `index_date_id` (`date_valid`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_valid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_03m_grid2deg`
--

DROP TABLE IF EXISTS `temp_03m_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_03m_grid2deg` (
  `id` varchar(4) default NULL,
  `date_valid` date default NULL,
  `category` tinyint(4) default NULL,
  UNIQUE KEY `index_date_id` (`date_valid`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_valid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_05d_grid2deg`
--

DROP TABLE IF EXISTS `temp_05d_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_05d_grid2deg` (
  `id` varchar(4) default NULL,
  `date_valid` date default NULL,
  `category` tinyint(4) default NULL,
  UNIQUE KEY `index_date_id` (`date_valid`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_valid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_05d_stn`
--

DROP TABLE IF EXISTS `temp_05d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_05d_stn` (
  `id` varchar(5) default NULL,
  `date_valid` date default NULL,
  `category` tinyint(4) default NULL,
  UNIQUE KEY `index_date_id` (`date_valid`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_valid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_07d_grid2deg`
--

DROP TABLE IF EXISTS `temp_07d_grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_07d_grid2deg` (
  `id` varchar(4) default NULL,
  `date_valid` date default NULL,
  `category` tinyint(4) default NULL,
  UNIQUE KEY `index_date_id` (`date_valid`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_valid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_07d_stn`
--

DROP TABLE IF EXISTS `temp_07d_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_07d_stn` (
  `id` varchar(5) default NULL,
  `date_valid` date default NULL,
  `category` tinyint(4) default NULL,
  UNIQUE KEY `index_date_id` (`date_valid`,`id`),
  KEY `index_id` (`id`),
  KEY `index_date` (`date_valid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Current Database: `cpc_poe`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `cpc_poe` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `cpc_poe`;

--
-- Table structure for table `fcst_precip_manual_02m_03m_cd`
--

DROP TABLE IF EXISTS `fcst_precip_manual_02m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fcst_precip_manual_02m_03m_cd` (
  `id` varchar(3) default NULL,
  `date_issued` date default NULL,
  `r` double default NULL,
  `02pcnt` double default NULL,
  `05pcnt` double default NULL,
  `10pcnt` double default NULL,
  `20pcnt` double default NULL,
  `30pcnt` double default NULL,
  `40pcnt` double default NULL,
  `50pcnt` double default NULL,
  `60pcnt` double default NULL,
  `70pcnt` double default NULL,
  `80pcnt` double default NULL,
  `90pcnt` double default NULL,
  `95pcnt` double default NULL,
  `98pcnt` double default NULL,
  `mean_fcst` double default NULL,
  `mean_clim` double default NULL,
  `median_clim` double default NULL,
  `stdDev_fcst` double default NULL,
  `stdDev_clim` double default NULL,
  `powerTrans` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fcst_precip_manual_03m_03m_cd`
--

DROP TABLE IF EXISTS `fcst_precip_manual_03m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fcst_precip_manual_03m_03m_cd` (
  `id` varchar(3) default NULL,
  `date_issued` date default NULL,
  `r` double default NULL,
  `02pcnt` double default NULL,
  `05pcnt` double default NULL,
  `10pcnt` double default NULL,
  `20pcnt` double default NULL,
  `30pcnt` double default NULL,
  `40pcnt` double default NULL,
  `50pcnt` double default NULL,
  `60pcnt` double default NULL,
  `70pcnt` double default NULL,
  `80pcnt` double default NULL,
  `90pcnt` double default NULL,
  `95pcnt` double default NULL,
  `98pcnt` double default NULL,
  `mean_fcst` double default NULL,
  `mean_clim` double default NULL,
  `median_clim` double default NULL,
  `stdDev_fcst` double default NULL,
  `stdDev_clim` double default NULL,
  `powerTrans` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fcst_precip_manual_04m_03m_cd`
--

DROP TABLE IF EXISTS `fcst_precip_manual_04m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fcst_precip_manual_04m_03m_cd` (
  `id` varchar(3) default NULL,
  `date_issued` date default NULL,
  `r` double default NULL,
  `02pcnt` double default NULL,
  `05pcnt` double default NULL,
  `10pcnt` double default NULL,
  `20pcnt` double default NULL,
  `30pcnt` double default NULL,
  `40pcnt` double default NULL,
  `50pcnt` double default NULL,
  `60pcnt` double default NULL,
  `70pcnt` double default NULL,
  `80pcnt` double default NULL,
  `90pcnt` double default NULL,
  `95pcnt` double default NULL,
  `98pcnt` double default NULL,
  `mean_fcst` double default NULL,
  `mean_clim` double default NULL,
  `median_clim` double default NULL,
  `stdDev_fcst` double default NULL,
  `stdDev_clim` double default NULL,
  `powerTrans` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fcst_precip_manual_05m_03m_cd`
--

DROP TABLE IF EXISTS `fcst_precip_manual_05m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fcst_precip_manual_05m_03m_cd` (
  `id` varchar(3) default NULL,
  `date_issued` date default NULL,
  `r` double default NULL,
  `02pcnt` double default NULL,
  `05pcnt` double default NULL,
  `10pcnt` double default NULL,
  `20pcnt` double default NULL,
  `30pcnt` double default NULL,
  `40pcnt` double default NULL,
  `50pcnt` double default NULL,
  `60pcnt` double default NULL,
  `70pcnt` double default NULL,
  `80pcnt` double default NULL,
  `90pcnt` double default NULL,
  `95pcnt` double default NULL,
  `98pcnt` double default NULL,
  `mean_fcst` double default NULL,
  `mean_clim` double default NULL,
  `median_clim` double default NULL,
  `stdDev_fcst` double default NULL,
  `stdDev_clim` double default NULL,
  `powerTrans` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fcst_precip_manual_06m_03m_cd`
--

DROP TABLE IF EXISTS `fcst_precip_manual_06m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fcst_precip_manual_06m_03m_cd` (
  `id` varchar(3) default NULL,
  `date_issued` date default NULL,
  `r` double default NULL,
  `02pcnt` double default NULL,
  `05pcnt` double default NULL,
  `10pcnt` double default NULL,
  `20pcnt` double default NULL,
  `30pcnt` double default NULL,
  `40pcnt` double default NULL,
  `50pcnt` double default NULL,
  `60pcnt` double default NULL,
  `70pcnt` double default NULL,
  `80pcnt` double default NULL,
  `90pcnt` double default NULL,
  `95pcnt` double default NULL,
  `98pcnt` double default NULL,
  `mean_fcst` double default NULL,
  `mean_clim` double default NULL,
  `median_clim` double default NULL,
  `stdDev_fcst` double default NULL,
  `stdDev_clim` double default NULL,
  `powerTrans` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fcst_precip_manual_07m_03m_cd`
--

DROP TABLE IF EXISTS `fcst_precip_manual_07m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fcst_precip_manual_07m_03m_cd` (
  `id` varchar(3) default NULL,
  `date_issued` date default NULL,
  `r` double default NULL,
  `02pcnt` double default NULL,
  `05pcnt` double default NULL,
  `10pcnt` double default NULL,
  `20pcnt` double default NULL,
  `30pcnt` double default NULL,
  `40pcnt` double default NULL,
  `50pcnt` double default NULL,
  `60pcnt` double default NULL,
  `70pcnt` double default NULL,
  `80pcnt` double default NULL,
  `90pcnt` double default NULL,
  `95pcnt` double default NULL,
  `98pcnt` double default NULL,
  `mean_fcst` double default NULL,
  `mean_clim` double default NULL,
  `median_clim` double default NULL,
  `stdDev_fcst` double default NULL,
  `stdDev_clim` double default NULL,
  `powerTrans` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fcst_precip_manual_08m_03m_cd`
--

DROP TABLE IF EXISTS `fcst_precip_manual_08m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fcst_precip_manual_08m_03m_cd` (
  `id` varchar(3) default NULL,
  `date_issued` date default NULL,
  `r` double default NULL,
  `02pcnt` double default NULL,
  `05pcnt` double default NULL,
  `10pcnt` double default NULL,
  `20pcnt` double default NULL,
  `30pcnt` double default NULL,
  `40pcnt` double default NULL,
  `50pcnt` double default NULL,
  `60pcnt` double default NULL,
  `70pcnt` double default NULL,
  `80pcnt` double default NULL,
  `90pcnt` double default NULL,
  `95pcnt` double default NULL,
  `98pcnt` double default NULL,
  `mean_fcst` double default NULL,
  `mean_clim` double default NULL,
  `median_clim` double default NULL,
  `stdDev_fcst` double default NULL,
  `stdDev_clim` double default NULL,
  `powerTrans` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fcst_precip_manual_09m_03m_cd`
--

DROP TABLE IF EXISTS `fcst_precip_manual_09m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fcst_precip_manual_09m_03m_cd` (
  `id` varchar(3) default NULL,
  `date_issued` date default NULL,
  `r` double default NULL,
  `02pcnt` double default NULL,
  `05pcnt` double default NULL,
  `10pcnt` double default NULL,
  `20pcnt` double default NULL,
  `30pcnt` double default NULL,
  `40pcnt` double default NULL,
  `50pcnt` double default NULL,
  `60pcnt` double default NULL,
  `70pcnt` double default NULL,
  `80pcnt` double default NULL,
  `90pcnt` double default NULL,
  `95pcnt` double default NULL,
  `98pcnt` double default NULL,
  `mean_fcst` double default NULL,
  `mean_clim` double default NULL,
  `median_clim` double default NULL,
  `stdDev_fcst` double default NULL,
  `stdDev_clim` double default NULL,
  `powerTrans` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fcst_precip_manual_10m_03m_cd`
--

DROP TABLE IF EXISTS `fcst_precip_manual_10m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fcst_precip_manual_10m_03m_cd` (
  `id` varchar(3) default NULL,
  `date_issued` date default NULL,
  `r` double default NULL,
  `02pcnt` double default NULL,
  `05pcnt` double default NULL,
  `10pcnt` double default NULL,
  `20pcnt` double default NULL,
  `30pcnt` double default NULL,
  `40pcnt` double default NULL,
  `50pcnt` double default NULL,
  `60pcnt` double default NULL,
  `70pcnt` double default NULL,
  `80pcnt` double default NULL,
  `90pcnt` double default NULL,
  `95pcnt` double default NULL,
  `98pcnt` double default NULL,
  `mean_fcst` double default NULL,
  `mean_clim` double default NULL,
  `median_clim` double default NULL,
  `stdDev_fcst` double default NULL,
  `stdDev_clim` double default NULL,
  `powerTrans` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fcst_precip_manual_11m_03m_cd`
--

DROP TABLE IF EXISTS `fcst_precip_manual_11m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fcst_precip_manual_11m_03m_cd` (
  `id` varchar(3) default NULL,
  `date_issued` date default NULL,
  `r` double default NULL,
  `02pcnt` double default NULL,
  `05pcnt` double default NULL,
  `10pcnt` double default NULL,
  `20pcnt` double default NULL,
  `30pcnt` double default NULL,
  `40pcnt` double default NULL,
  `50pcnt` double default NULL,
  `60pcnt` double default NULL,
  `70pcnt` double default NULL,
  `80pcnt` double default NULL,
  `90pcnt` double default NULL,
  `95pcnt` double default NULL,
  `98pcnt` double default NULL,
  `mean_fcst` double default NULL,
  `mean_clim` double default NULL,
  `median_clim` double default NULL,
  `stdDev_fcst` double default NULL,
  `stdDev_clim` double default NULL,
  `powerTrans` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fcst_precip_manual_12m_03m_cd`
--

DROP TABLE IF EXISTS `fcst_precip_manual_12m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fcst_precip_manual_12m_03m_cd` (
  `id` varchar(3) default NULL,
  `date_issued` date default NULL,
  `r` double default NULL,
  `02pcnt` double default NULL,
  `05pcnt` double default NULL,
  `10pcnt` double default NULL,
  `20pcnt` double default NULL,
  `30pcnt` double default NULL,
  `40pcnt` double default NULL,
  `50pcnt` double default NULL,
  `60pcnt` double default NULL,
  `70pcnt` double default NULL,
  `80pcnt` double default NULL,
  `90pcnt` double default NULL,
  `95pcnt` double default NULL,
  `98pcnt` double default NULL,
  `mean_fcst` double default NULL,
  `mean_clim` double default NULL,
  `median_clim` double default NULL,
  `stdDev_fcst` double default NULL,
  `stdDev_clim` double default NULL,
  `powerTrans` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fcst_precip_manual_13m_03m_cd`
--

DROP TABLE IF EXISTS `fcst_precip_manual_13m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fcst_precip_manual_13m_03m_cd` (
  `id` varchar(3) default NULL,
  `date_issued` date default NULL,
  `r` double default NULL,
  `02pcnt` double default NULL,
  `05pcnt` double default NULL,
  `10pcnt` double default NULL,
  `20pcnt` double default NULL,
  `30pcnt` double default NULL,
  `40pcnt` double default NULL,
  `50pcnt` double default NULL,
  `60pcnt` double default NULL,
  `70pcnt` double default NULL,
  `80pcnt` double default NULL,
  `90pcnt` double default NULL,
  `95pcnt` double default NULL,
  `98pcnt` double default NULL,
  `mean_fcst` double default NULL,
  `mean_clim` double default NULL,
  `median_clim` double default NULL,
  `stdDev_fcst` double default NULL,
  `stdDev_clim` double default NULL,
  `powerTrans` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fcst_precip_manual_14m_03m_cd`
--

DROP TABLE IF EXISTS `fcst_precip_manual_14m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fcst_precip_manual_14m_03m_cd` (
  `id` varchar(3) default NULL,
  `date_issued` date default NULL,
  `r` double default NULL,
  `02pcnt` double default NULL,
  `05pcnt` double default NULL,
  `10pcnt` double default NULL,
  `20pcnt` double default NULL,
  `30pcnt` double default NULL,
  `40pcnt` double default NULL,
  `50pcnt` double default NULL,
  `60pcnt` double default NULL,
  `70pcnt` double default NULL,
  `80pcnt` double default NULL,
  `90pcnt` double default NULL,
  `95pcnt` double default NULL,
  `98pcnt` double default NULL,
  `mean_fcst` double default NULL,
  `mean_clim` double default NULL,
  `median_clim` double default NULL,
  `stdDev_fcst` double default NULL,
  `stdDev_clim` double default NULL,
  `powerTrans` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fcst_temp_manual_02m_03m_cd`
--

DROP TABLE IF EXISTS `fcst_temp_manual_02m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fcst_temp_manual_02m_03m_cd` (
  `id` varchar(3) default NULL,
  `date_issued` date default NULL,
  `r` double default NULL,
  `02pcnt` double default NULL,
  `05pcnt` double default NULL,
  `10pcnt` double default NULL,
  `20pcnt` double default NULL,
  `30pcnt` double default NULL,
  `40pcnt` double default NULL,
  `50pcnt` double default NULL,
  `60pcnt` double default NULL,
  `70pcnt` double default NULL,
  `80pcnt` double default NULL,
  `90pcnt` double default NULL,
  `95pcnt` double default NULL,
  `98pcnt` double default NULL,
  `mean_fcst` double default NULL,
  `mean_clim` double default NULL,
  `stdDev_fcst` double default NULL,
  `stdDev_clim` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fcst_temp_manual_03m_03m_cd`
--

DROP TABLE IF EXISTS `fcst_temp_manual_03m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fcst_temp_manual_03m_03m_cd` (
  `id` varchar(3) default NULL,
  `date_issued` date default NULL,
  `r` double default NULL,
  `02pcnt` double default NULL,
  `05pcnt` double default NULL,
  `10pcnt` double default NULL,
  `20pcnt` double default NULL,
  `30pcnt` double default NULL,
  `40pcnt` double default NULL,
  `50pcnt` double default NULL,
  `60pcnt` double default NULL,
  `70pcnt` double default NULL,
  `80pcnt` double default NULL,
  `90pcnt` double default NULL,
  `95pcnt` double default NULL,
  `98pcnt` double default NULL,
  `mean_fcst` double default NULL,
  `mean_clim` double default NULL,
  `stdDev_fcst` double default NULL,
  `stdDev_clim` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fcst_temp_manual_04m_03m_cd`
--

DROP TABLE IF EXISTS `fcst_temp_manual_04m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fcst_temp_manual_04m_03m_cd` (
  `id` varchar(3) default NULL,
  `date_issued` date default NULL,
  `r` double default NULL,
  `02pcnt` double default NULL,
  `05pcnt` double default NULL,
  `10pcnt` double default NULL,
  `20pcnt` double default NULL,
  `30pcnt` double default NULL,
  `40pcnt` double default NULL,
  `50pcnt` double default NULL,
  `60pcnt` double default NULL,
  `70pcnt` double default NULL,
  `80pcnt` double default NULL,
  `90pcnt` double default NULL,
  `95pcnt` double default NULL,
  `98pcnt` double default NULL,
  `mean_fcst` double default NULL,
  `mean_clim` double default NULL,
  `stdDev_fcst` double default NULL,
  `stdDev_clim` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fcst_temp_manual_05m_03m_cd`
--

DROP TABLE IF EXISTS `fcst_temp_manual_05m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fcst_temp_manual_05m_03m_cd` (
  `id` varchar(3) default NULL,
  `date_issued` date default NULL,
  `r` double default NULL,
  `02pcnt` double default NULL,
  `05pcnt` double default NULL,
  `10pcnt` double default NULL,
  `20pcnt` double default NULL,
  `30pcnt` double default NULL,
  `40pcnt` double default NULL,
  `50pcnt` double default NULL,
  `60pcnt` double default NULL,
  `70pcnt` double default NULL,
  `80pcnt` double default NULL,
  `90pcnt` double default NULL,
  `95pcnt` double default NULL,
  `98pcnt` double default NULL,
  `mean_fcst` double default NULL,
  `mean_clim` double default NULL,
  `stdDev_fcst` double default NULL,
  `stdDev_clim` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fcst_temp_manual_06m_03m_cd`
--

DROP TABLE IF EXISTS `fcst_temp_manual_06m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fcst_temp_manual_06m_03m_cd` (
  `id` varchar(3) default NULL,
  `date_issued` date default NULL,
  `r` double default NULL,
  `02pcnt` double default NULL,
  `05pcnt` double default NULL,
  `10pcnt` double default NULL,
  `20pcnt` double default NULL,
  `30pcnt` double default NULL,
  `40pcnt` double default NULL,
  `50pcnt` double default NULL,
  `60pcnt` double default NULL,
  `70pcnt` double default NULL,
  `80pcnt` double default NULL,
  `90pcnt` double default NULL,
  `95pcnt` double default NULL,
  `98pcnt` double default NULL,
  `mean_fcst` double default NULL,
  `mean_clim` double default NULL,
  `stdDev_fcst` double default NULL,
  `stdDev_clim` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fcst_temp_manual_07m_03m_cd`
--

DROP TABLE IF EXISTS `fcst_temp_manual_07m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fcst_temp_manual_07m_03m_cd` (
  `id` varchar(3) default NULL,
  `date_issued` date default NULL,
  `r` double default NULL,
  `02pcnt` double default NULL,
  `05pcnt` double default NULL,
  `10pcnt` double default NULL,
  `20pcnt` double default NULL,
  `30pcnt` double default NULL,
  `40pcnt` double default NULL,
  `50pcnt` double default NULL,
  `60pcnt` double default NULL,
  `70pcnt` double default NULL,
  `80pcnt` double default NULL,
  `90pcnt` double default NULL,
  `95pcnt` double default NULL,
  `98pcnt` double default NULL,
  `mean_fcst` double default NULL,
  `mean_clim` double default NULL,
  `stdDev_fcst` double default NULL,
  `stdDev_clim` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fcst_temp_manual_08m_03m_cd`
--

DROP TABLE IF EXISTS `fcst_temp_manual_08m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fcst_temp_manual_08m_03m_cd` (
  `id` varchar(3) default NULL,
  `date_issued` date default NULL,
  `r` double default NULL,
  `02pcnt` double default NULL,
  `05pcnt` double default NULL,
  `10pcnt` double default NULL,
  `20pcnt` double default NULL,
  `30pcnt` double default NULL,
  `40pcnt` double default NULL,
  `50pcnt` double default NULL,
  `60pcnt` double default NULL,
  `70pcnt` double default NULL,
  `80pcnt` double default NULL,
  `90pcnt` double default NULL,
  `95pcnt` double default NULL,
  `98pcnt` double default NULL,
  `mean_fcst` double default NULL,
  `mean_clim` double default NULL,
  `stdDev_fcst` double default NULL,
  `stdDev_clim` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fcst_temp_manual_09m_03m_cd`
--

DROP TABLE IF EXISTS `fcst_temp_manual_09m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fcst_temp_manual_09m_03m_cd` (
  `id` varchar(3) default NULL,
  `date_issued` date default NULL,
  `r` double default NULL,
  `02pcnt` double default NULL,
  `05pcnt` double default NULL,
  `10pcnt` double default NULL,
  `20pcnt` double default NULL,
  `30pcnt` double default NULL,
  `40pcnt` double default NULL,
  `50pcnt` double default NULL,
  `60pcnt` double default NULL,
  `70pcnt` double default NULL,
  `80pcnt` double default NULL,
  `90pcnt` double default NULL,
  `95pcnt` double default NULL,
  `98pcnt` double default NULL,
  `mean_fcst` double default NULL,
  `mean_clim` double default NULL,
  `stdDev_fcst` double default NULL,
  `stdDev_clim` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fcst_temp_manual_10m_03m_cd`
--

DROP TABLE IF EXISTS `fcst_temp_manual_10m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fcst_temp_manual_10m_03m_cd` (
  `id` varchar(3) default NULL,
  `date_issued` date default NULL,
  `r` double default NULL,
  `02pcnt` double default NULL,
  `05pcnt` double default NULL,
  `10pcnt` double default NULL,
  `20pcnt` double default NULL,
  `30pcnt` double default NULL,
  `40pcnt` double default NULL,
  `50pcnt` double default NULL,
  `60pcnt` double default NULL,
  `70pcnt` double default NULL,
  `80pcnt` double default NULL,
  `90pcnt` double default NULL,
  `95pcnt` double default NULL,
  `98pcnt` double default NULL,
  `mean_fcst` double default NULL,
  `mean_clim` double default NULL,
  `stdDev_fcst` double default NULL,
  `stdDev_clim` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fcst_temp_manual_11m_03m_cd`
--

DROP TABLE IF EXISTS `fcst_temp_manual_11m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fcst_temp_manual_11m_03m_cd` (
  `id` varchar(3) default NULL,
  `date_issued` date default NULL,
  `r` double default NULL,
  `02pcnt` double default NULL,
  `05pcnt` double default NULL,
  `10pcnt` double default NULL,
  `20pcnt` double default NULL,
  `30pcnt` double default NULL,
  `40pcnt` double default NULL,
  `50pcnt` double default NULL,
  `60pcnt` double default NULL,
  `70pcnt` double default NULL,
  `80pcnt` double default NULL,
  `90pcnt` double default NULL,
  `95pcnt` double default NULL,
  `98pcnt` double default NULL,
  `mean_fcst` double default NULL,
  `mean_clim` double default NULL,
  `stdDev_fcst` double default NULL,
  `stdDev_clim` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fcst_temp_manual_12m_03m_cd`
--

DROP TABLE IF EXISTS `fcst_temp_manual_12m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fcst_temp_manual_12m_03m_cd` (
  `id` varchar(3) default NULL,
  `date_issued` date default NULL,
  `r` double default NULL,
  `02pcnt` double default NULL,
  `05pcnt` double default NULL,
  `10pcnt` double default NULL,
  `20pcnt` double default NULL,
  `30pcnt` double default NULL,
  `40pcnt` double default NULL,
  `50pcnt` double default NULL,
  `60pcnt` double default NULL,
  `70pcnt` double default NULL,
  `80pcnt` double default NULL,
  `90pcnt` double default NULL,
  `95pcnt` double default NULL,
  `98pcnt` double default NULL,
  `mean_fcst` double default NULL,
  `mean_clim` double default NULL,
  `stdDev_fcst` double default NULL,
  `stdDev_clim` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fcst_temp_manual_13m_03m_cd`
--

DROP TABLE IF EXISTS `fcst_temp_manual_13m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fcst_temp_manual_13m_03m_cd` (
  `id` varchar(3) default NULL,
  `date_issued` date default NULL,
  `r` double default NULL,
  `02pcnt` double default NULL,
  `05pcnt` double default NULL,
  `10pcnt` double default NULL,
  `20pcnt` double default NULL,
  `30pcnt` double default NULL,
  `40pcnt` double default NULL,
  `50pcnt` double default NULL,
  `60pcnt` double default NULL,
  `70pcnt` double default NULL,
  `80pcnt` double default NULL,
  `90pcnt` double default NULL,
  `95pcnt` double default NULL,
  `98pcnt` double default NULL,
  `mean_fcst` double default NULL,
  `mean_clim` double default NULL,
  `stdDev_fcst` double default NULL,
  `stdDev_clim` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fcst_temp_manual_14m_03m_cd`
--

DROP TABLE IF EXISTS `fcst_temp_manual_14m_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fcst_temp_manual_14m_03m_cd` (
  `id` varchar(3) default NULL,
  `date_issued` date default NULL,
  `r` double default NULL,
  `02pcnt` double default NULL,
  `05pcnt` double default NULL,
  `10pcnt` double default NULL,
  `20pcnt` double default NULL,
  `30pcnt` double default NULL,
  `40pcnt` double default NULL,
  `50pcnt` double default NULL,
  `60pcnt` double default NULL,
  `70pcnt` double default NULL,
  `80pcnt` double default NULL,
  `90pcnt` double default NULL,
  `95pcnt` double default NULL,
  `98pcnt` double default NULL,
  `mean_fcst` double default NULL,
  `mean_clim` double default NULL,
  `stdDev_fcst` double default NULL,
  `stdDev_clim` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `obs_precip_03m_cd`
--

DROP TABLE IF EXISTS `obs_precip_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obs_precip_03m_cd` (
  `id` varchar(3) default NULL,
  `date_valid` date default NULL,
  `value` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `obs_temp_03m_cd`
--

DROP TABLE IF EXISTS `obs_temp_03m_cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obs_temp_03m_cd` (
  `id` varchar(3) default NULL,
  `date_valid` date default NULL,
  `value` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Current Database: `cpc_reference`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `cpc_reference` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `cpc_reference`;

--
-- Table structure for table `cd`
--

DROP TABLE IF EXISTS `cd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cd` (
  `id` int(11) default NULL,
  `name` varchar(30) default NULL,
  `climateRegion` char(2) default NULL,
  `lat` float default NULL,
  `lon` float default NULL,
  `area` float default NULL,
  `shortName` varchar(20) default NULL,
  `centerId` int(11) default NULL,
  UNIQUE KEY `index_id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `climatePhenomena_monthly`
--

DROP TABLE IF EXISTS `climatePhenomena_monthly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `climatePhenomena_monthly` (
  `date_valid` date default NULL,
  `AO` varchar(20) default NULL,
  `NAO` varchar(20) default NULL,
  `PNA` varchar(20) default NULL,
  KEY `index_date` (`date_valid`),
  KEY `index_ao` (`AO`),
  KEY `index_nao` (`NAO`),
  KEY `index_pna` (`PNA`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `climatePhenomena_seasonal`
--

DROP TABLE IF EXISTS `climatePhenomena_seasonal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `climatePhenomena_seasonal` (
  `date_valid` date default NULL,
  `ENSO` varchar(20) default NULL,
  `AO` varchar(20) default NULL,
  KEY `index_enso` (`ENSO`),
  KEY `index_date` (`date_valid`),
  KEY `index_ao` (`AO`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `climatePhenomena_seasonal_backup`
--

DROP TABLE IF EXISTS `climatePhenomena_seasonal_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `climatePhenomena_seasonal_backup` (
  `date_valid` date default NULL,
  `ENSO` varchar(20) default NULL,
  `AO` varchar(20) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `climatePhenomena_seasonal_small`
--

DROP TABLE IF EXISTS `climatePhenomena_seasonal_small`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `climatePhenomena_seasonal_small` (
  `date_valid` date default NULL,
  `ENSO` varchar(20) default NULL,
  `AO` varchar(20) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dataSettings`
--

DROP TABLE IF EXISTS `dataSettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataSettings` (
  `dataType` varchar(20) default NULL,
  `variable` varchar(20) default NULL,
  `fcstSource` varchar(15) default NULL,
  `fcstType` varchar(20) default NULL,
  `tool` varchar(30) default NULL,
  `model` varchar(30) default NULL,
  `spatialType` varchar(10) default NULL,
  `owner` varchar(100) default NULL,
  `pathName` varchar(255) default NULL,
  `fileName` varchar(255) default NULL,
  `column_id` varchar(20) default NULL,
  `column_category` varchar(20) default NULL,
  `column_cdf` varchar(20) default NULL,
  `column_prob_below` varchar(20) default NULL,
  `column_prob_normal` varchar(20) default NULL,
  `column_prob_above` varchar(20) default NULL,
  `column_skill` varchar(20) default NULL,
  `column_standardAnomaly` varchar(20) default NULL,
  `probUnits` varchar(20) default NULL,
  `numExpectedLocations` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dataSettings_new`
--

DROP TABLE IF EXISTS `dataSettings_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataSettings_new` (
  `dataType` varchar(20) default NULL,
  `variable` varchar(20) default NULL,
  `fcstSource` varchar(15) default NULL,
  `fcstType` varchar(20) default NULL,
  `tool` varchar(30) default NULL,
  `model` varchar(30) default NULL,
  `spatialType` varchar(10) default NULL,
  `owner` varchar(100) default NULL,
  `pathName` varchar(255) default NULL,
  `fileName` varchar(255) default NULL,
  `column_id` varchar(4) default NULL,
  `column_category` varchar(4) default NULL,
  `column_cdf` varchar(4) default NULL,
  `column_prob_below` varchar(4) default NULL,
  `column_prob_normal` varchar(4) default NULL,
  `column_prob_above` varchar(4) default NULL,
  `column_skill` varchar(4) default NULL,
  `column_standardAnomaly` varchar(4) default NULL,
  `probUnits` varchar(20) default NULL,
  `numExpectedLocation` int(11) default NULL,
  `newColumn` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dataSettings_selectMonthsIssue`
--

DROP TABLE IF EXISTS `dataSettings_selectMonthsIssue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataSettings_selectMonthsIssue` (
  `dataType` varchar(20) default NULL,
  `variable` varchar(20) default NULL,
  `fcstSource` varchar(15) default NULL,
  `fcstType` varchar(20) default NULL,
  `tool` varchar(30) default NULL,
  `model` varchar(30) default NULL,
  `spatialType` varchar(10) default NULL,
  `owner` varchar(100) default NULL,
  `pathName` varchar(255) default NULL,
  `fileName` varchar(255) default NULL,
  `column_id` varchar(4) default NULL,
  `column_category` varchar(4) default NULL,
  `column_cdf` varchar(4) default NULL,
  `column_prob_below` varchar(4) default NULL,
  `column_prob_normal` varchar(4) default NULL,
  `column_prob_above` varchar(4) default NULL,
  `column_skill` varchar(4) default NULL,
  `column_standardAnomaly` varchar(4) default NULL,
  `probUnits` varchar(20) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dataSettings_testing`
--

DROP TABLE IF EXISTS `dataSettings_testing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataSettings_testing` (
  `dataType` varchar(20) default NULL,
  `variable` varchar(20) default NULL,
  `fcstSource` varchar(15) default NULL,
  `fcstType` varchar(20) default NULL,
  `tool` varchar(30) default NULL,
  `model` varchar(30) default NULL,
  `spatialType` varchar(10) default NULL,
  `pathName` varchar(255) default NULL,
  `fileName` varchar(255) default NULL,
  `column_id` varchar(4) default NULL,
  `column_category` varchar(4) default NULL,
  `column_cdf` varchar(4) default NULL,
  `column_prob_below` varchar(4) default NULL,
  `column_prob_normal` varchar(4) default NULL,
  `column_prob_above` varchar(4) default NULL,
  `probUnits` varchar(20) default NULL,
  `numExpectedLocations` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dates`
--

DROP TABLE IF EXISTS `dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dates` (
  `date` date default NULL,
  KEY `date_index` (`date`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `grid2deg`
--

DROP TABLE IF EXISTS `grid2deg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grid2deg` (
  `id` varchar(4) default NULL,
  `lat` float default NULL,
  `lon` float default NULL,
  `name` varchar(30) default NULL,
  `state` char(2) default NULL,
  `climateRegion` char(2) default NULL,
  `climateDivision` int(11) default NULL,
  `country` char(2) default NULL,
  UNIQUE KEY `index_id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `grid2deg_backup`
--

DROP TABLE IF EXISTS `grid2deg_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grid2deg_backup` (
  `id` varchar(4) default NULL,
  `name` varchar(30) default NULL,
  `state` char(2) default NULL,
  `climateRegion` char(2) default NULL,
  `climateDivision` int(11) default NULL,
  `country` char(2) default NULL,
  `lat` float default NULL,
  `lon` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `grid2deg_full`
--

DROP TABLE IF EXISTS `grid2deg_full`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grid2deg_full` (
  `id` varchar(4) default NULL,
  `lat` float default NULL,
  `lon` float default NULL,
  `name` varchar(30) default NULL,
  `state` char(2) default NULL,
  `climateRegion` char(2) default NULL,
  `climateDivision` int(11) default NULL,
  `country` char(2) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stations`
--

DROP TABLE IF EXISTS `stations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stations` (
  `id` int(11) default NULL,
  `name` varchar(30) default NULL,
  `state` char(2) default NULL,
  `climateRegion` char(2) default NULL,
  `climateDivision` int(11) default NULL,
  `country` char(2) default NULL,
  `lat` float default NULL,
  `lon` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stations_full`
--

DROP TABLE IF EXISTS `stations_full`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stations_full` (
  `id` int(11) default NULL,
  `name` varchar(30) default NULL,
  `state` char(2) default NULL,
  `climateRegion` char(2) default NULL,
  `climateDivision` int(11) default NULL,
  `country` char(2) default NULL,
  `lat` float default NULL,
  `lon` float default NULL,
  KEY `id_index` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stn`
--

DROP TABLE IF EXISTS `stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stn` (
  `id` int(11) default NULL,
  `name` varchar(30) default NULL,
  `state` char(2) default NULL,
  `climateRegion` char(2) default NULL,
  `climateDivision` int(11) default NULL,
  `country` char(2) default NULL,
  `lat` float default NULL,
  `lon` float default NULL,
  UNIQUE KEY `index_id` (`id`),
  KEY `index_climateRegion` (`climateRegion`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stn_106`
--

DROP TABLE IF EXISTS `stn_106`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stn_106` (
  `id` int(11) default NULL,
  `name` varchar(30) default NULL,
  `state` char(2) default NULL,
  `climateRegion` char(2) default NULL,
  `climateDivision` int(11) default NULL,
  `country` char(2) default NULL,
  `lat` float default NULL,
  `lon` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stn_117`
--

DROP TABLE IF EXISTS `stn_117`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stn_117` (
  `id` int(11) default NULL,
  `name` varchar(30) default NULL,
  `state` char(2) default NULL,
  `climateRegion` char(2) default NULL,
  `climateDivision` int(11) default NULL,
  `country` char(2) default NULL,
  `lat` float default NULL,
  `lon` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stn_362`
--

DROP TABLE IF EXISTS `stn_362`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stn_362` (
  `id` int(11) default NULL,
  `name` varchar(30) default NULL,
  `state` char(2) default NULL,
  `climateRegion` char(2) default NULL,
  `climateDivision` int(11) default NULL,
  `country` char(2) default NULL,
  `lat` float default NULL,
  `lon` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Current Database: `cpc_vwt`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `cpc_vwt` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `cpc_vwt`;

--
-- Current Database: `heat_climo`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `heat_climo` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `heat_climo`;

--
-- Table structure for table `heat_5d_1981_2010_stn`
--

DROP TABLE IF EXISTS `heat_5d_1981_2010_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `heat_5d_1981_2010_stn` (
  `id` int(11) default NULL,
  `date` char(4) default NULL,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `mean` float default NULL,
  `std` float default NULL,
  `prob_90thresh` float default NULL,
  `prob_95thresh` float default NULL,
  `prob_100thresh` float default NULL,
  `prob_105thresh` float default NULL,
  `prob_110thresh` float default NULL,
  `prob_115thresh` float default NULL,
  `prob_120thresh` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `heat_7d_1981_2010_stn`
--

DROP TABLE IF EXISTS `heat_7d_1981_2010_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `heat_7d_1981_2010_stn` (
  `id` int(11) default NULL,
  `date` char(4) default NULL,
  `prob_05pcnt` float default NULL,
  `prob_10pcnt` float default NULL,
  `prob_25pcnt` float default NULL,
  `prob_33pcnt` float default NULL,
  `prob_50pcnt` float default NULL,
  `prob_67pcnt` float default NULL,
  `prob_75pcnt` float default NULL,
  `prob_90pcnt` float default NULL,
  `prob_95pcnt` float default NULL,
  `mean` float default NULL,
  `std` float default NULL,
  `prob_90thresh` float default NULL,
  `prob_95thresh` float default NULL,
  `prob_100thresh` float default NULL,
  `prob_105thresh` float default NULL,
  `prob_110thresh` float default NULL,
  `prob_115thresh` float default NULL,
  `prob_120thresh` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `heatprob_5d_1981_2010_stn`
--

DROP TABLE IF EXISTS `heatprob_5d_1981_2010_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `heatprob_5d_1981_2010_stn` (
  `id` int(11) default NULL,
  `date` char(4) default NULL,
  `prob_mean85` float default NULL,
  `prob_mean90` float default NULL,
  `prob_mean95` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `heatprob_7d_1981_2010_stn`
--

DROP TABLE IF EXISTS `heatprob_7d_1981_2010_stn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `heatprob_7d_1981_2010_stn` (
  `id` int(11) default NULL,
  `date` char(4) default NULL,
  `prob_mean85` float default NULL,
  `prob_mean90` float default NULL,
  `prob_mean95` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Current Database: `heat_index`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `heat_index` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `heat_index`;

--
-- Table structure for table `cal_d11fcst`
--

DROP TABLE IF EXISTS `cal_d11fcst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_d11fcst` (
  `ID` int(11) default NULL,
  `Date` date default NULL,
  `HIDX` float default NULL,
  `PRBB` float default NULL,
  `PRBN` float default NULL,
  `PRBA` float default NULL,
  `T090` float default NULL,
  `T095` float default NULL,
  `T100` float default NULL,
  `T105` float default NULL,
  `T110` float default NULL,
  `T115` float default NULL,
  `T120` float default NULL,
  `D385` float default NULL,
  `D290` float default NULL,
  `D195` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_d8fcst`
--

DROP TABLE IF EXISTS `cal_d8fcst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_d8fcst` (
  `ID` int(11) default NULL,
  `Date` date default NULL,
  `HIDX` float default NULL,
  `PRBB` float default NULL,
  `PRBN` float default NULL,
  `PRBA` float default NULL,
  `T090` float default NULL,
  `T095` float default NULL,
  `T100` float default NULL,
  `T105` float default NULL,
  `T110` float default NULL,
  `T115` float default NULL,
  `T120` float default NULL,
  `D385` float default NULL,
  `D290` float default NULL,
  `D195` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgec00_00`
--

DROP TABLE IF EXISTS `calgec00_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgec00_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgec00_06`
--

DROP TABLE IF EXISTS `calgec00_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgec00_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep01_00`
--

DROP TABLE IF EXISTS `calgep01_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep01_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep01_06`
--

DROP TABLE IF EXISTS `calgep01_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep01_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep02_00`
--

DROP TABLE IF EXISTS `calgep02_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep02_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep02_06`
--

DROP TABLE IF EXISTS `calgep02_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep02_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep03_00`
--

DROP TABLE IF EXISTS `calgep03_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep03_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep03_06`
--

DROP TABLE IF EXISTS `calgep03_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep03_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep04_00`
--

DROP TABLE IF EXISTS `calgep04_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep04_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep04_06`
--

DROP TABLE IF EXISTS `calgep04_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep04_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep05_00`
--

DROP TABLE IF EXISTS `calgep05_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep05_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep05_06`
--

DROP TABLE IF EXISTS `calgep05_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep05_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep06_00`
--

DROP TABLE IF EXISTS `calgep06_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep06_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep06_06`
--

DROP TABLE IF EXISTS `calgep06_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep06_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep07_00`
--

DROP TABLE IF EXISTS `calgep07_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep07_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep07_06`
--

DROP TABLE IF EXISTS `calgep07_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep07_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep08_00`
--

DROP TABLE IF EXISTS `calgep08_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep08_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep08_06`
--

DROP TABLE IF EXISTS `calgep08_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep08_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep09_00`
--

DROP TABLE IF EXISTS `calgep09_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep09_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep09_06`
--

DROP TABLE IF EXISTS `calgep09_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep09_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep10_00`
--

DROP TABLE IF EXISTS `calgep10_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep10_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep10_06`
--

DROP TABLE IF EXISTS `calgep10_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep10_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep11_00`
--

DROP TABLE IF EXISTS `calgep11_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep11_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep11_06`
--

DROP TABLE IF EXISTS `calgep11_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep11_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep12_00`
--

DROP TABLE IF EXISTS `calgep12_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep12_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep12_06`
--

DROP TABLE IF EXISTS `calgep12_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep12_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep13_00`
--

DROP TABLE IF EXISTS `calgep13_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep13_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep13_06`
--

DROP TABLE IF EXISTS `calgep13_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep13_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep14_00`
--

DROP TABLE IF EXISTS `calgep14_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep14_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep14_06`
--

DROP TABLE IF EXISTS `calgep14_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep14_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep15_00`
--

DROP TABLE IF EXISTS `calgep15_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep15_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep15_06`
--

DROP TABLE IF EXISTS `calgep15_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep15_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep16_00`
--

DROP TABLE IF EXISTS `calgep16_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep16_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep16_06`
--

DROP TABLE IF EXISTS `calgep16_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep16_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep17_00`
--

DROP TABLE IF EXISTS `calgep17_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep17_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep17_06`
--

DROP TABLE IF EXISTS `calgep17_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep17_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep18_00`
--

DROP TABLE IF EXISTS `calgep18_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep18_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep18_06`
--

DROP TABLE IF EXISTS `calgep18_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep18_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep19_00`
--

DROP TABLE IF EXISTS `calgep19_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep19_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep19_06`
--

DROP TABLE IF EXISTS `calgep19_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep19_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep20_00`
--

DROP TABLE IF EXISTS `calgep20_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep20_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calgep20_06`
--

DROP TABLE IF EXISTS `calgep20_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calgep20_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d11_corfcsts`
--

DROP TABLE IF EXISTS `d11_corfcsts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d11_corfcsts` (
  `date` date default NULL,
  `id` int(11) default NULL,
  `numfcsts` int(11) default NULL,
  `corfcsts` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d8_corfcsts`
--

DROP TABLE IF EXISTS `d8_corfcsts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d8_corfcsts` (
  `date` date default NULL,
  `id` int(11) default NULL,
  `numfcsts` int(11) default NULL,
  `corfcsts` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gec00_00`
--

DROP TABLE IF EXISTS `gec00_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gec00_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gec00_06`
--

DROP TABLE IF EXISTS `gec00_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gec00_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep01_00`
--

DROP TABLE IF EXISTS `gep01_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep01_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep01_06`
--

DROP TABLE IF EXISTS `gep01_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep01_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep02_00`
--

DROP TABLE IF EXISTS `gep02_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep02_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep02_06`
--

DROP TABLE IF EXISTS `gep02_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep02_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep03_00`
--

DROP TABLE IF EXISTS `gep03_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep03_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep03_06`
--

DROP TABLE IF EXISTS `gep03_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep03_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep04_00`
--

DROP TABLE IF EXISTS `gep04_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep04_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep04_06`
--

DROP TABLE IF EXISTS `gep04_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep04_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep05_00`
--

DROP TABLE IF EXISTS `gep05_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep05_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep05_06`
--

DROP TABLE IF EXISTS `gep05_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep05_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep06_00`
--

DROP TABLE IF EXISTS `gep06_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep06_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep06_06`
--

DROP TABLE IF EXISTS `gep06_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep06_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep07_00`
--

DROP TABLE IF EXISTS `gep07_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep07_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep07_06`
--

DROP TABLE IF EXISTS `gep07_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep07_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep08_00`
--

DROP TABLE IF EXISTS `gep08_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep08_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep08_06`
--

DROP TABLE IF EXISTS `gep08_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep08_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep09_00`
--

DROP TABLE IF EXISTS `gep09_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep09_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep09_06`
--

DROP TABLE IF EXISTS `gep09_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep09_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep10_00`
--

DROP TABLE IF EXISTS `gep10_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep10_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep10_06`
--

DROP TABLE IF EXISTS `gep10_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep10_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep11_00`
--

DROP TABLE IF EXISTS `gep11_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep11_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep11_06`
--

DROP TABLE IF EXISTS `gep11_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep11_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep12_00`
--

DROP TABLE IF EXISTS `gep12_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep12_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep12_06`
--

DROP TABLE IF EXISTS `gep12_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep12_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep13_00`
--

DROP TABLE IF EXISTS `gep13_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep13_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep13_06`
--

DROP TABLE IF EXISTS `gep13_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep13_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep14_00`
--

DROP TABLE IF EXISTS `gep14_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep14_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep14_06`
--

DROP TABLE IF EXISTS `gep14_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep14_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep15_00`
--

DROP TABLE IF EXISTS `gep15_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep15_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep15_06`
--

DROP TABLE IF EXISTS `gep15_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep15_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep16_00`
--

DROP TABLE IF EXISTS `gep16_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep16_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep16_06`
--

DROP TABLE IF EXISTS `gep16_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep16_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep17_00`
--

DROP TABLE IF EXISTS `gep17_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep17_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep17_06`
--

DROP TABLE IF EXISTS `gep17_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep17_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep18_00`
--

DROP TABLE IF EXISTS `gep18_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep18_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep18_06`
--

DROP TABLE IF EXISTS `gep18_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep18_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep19_00`
--

DROP TABLE IF EXISTS `gep19_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep19_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep19_06`
--

DROP TABLE IF EXISTS `gep19_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep19_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep20_00`
--

DROP TABLE IF EXISTS `gep20_00`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep20_00` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep20_06`
--

DROP TABLE IF EXISTS `gep20_06`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep20_06` (
  `ID` int(11) default NULL,
  `date` date default NULL,
  `D8Hidx` float default NULL,
  `D11Hidx` float default NULL,
  `Mn06` float default NULL,
  `Mn07` float default NULL,
  `Mn08` float default NULL,
  `Mn09` float default NULL,
  `Mn10` float default NULL,
  `Mn11` float default NULL,
  `Mn12` float default NULL,
  `Mn13` float default NULL,
  `Mn14` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `heat_obs`
--

DROP TABLE IF EXISTS `heat_obs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `heat_obs` (
  `ID` char(6) default NULL,
  `date` date default NULL,
  `D8Max` float default NULL,
  `D11Max` float default NULL,
  `Mean` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `station_list`
--

DROP TABLE IF EXISTS `station_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `station_list` (
  `wmo` int(11) default NULL,
  `lat` float default NULL,
  `lon` float default NULL,
  `city` text,
  `st` char(2) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stations`
--

DROP TABLE IF EXISTS `stations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stations` (
  `wmo` int(11) default NULL,
  `icao` char(4) default NULL,
  `lat` float default NULL,
  `lon` float default NULL,
  `firstflag` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Current Database: `log`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `log` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `log`;

--
-- Current Database: `mysql`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `mysql` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `mysql`;

--
-- Table structure for table `columns_priv`
--

DROP TABLE IF EXISTS `columns_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `columns_priv` (
  `Host` char(60) collate utf8_bin NOT NULL default '',
  `Db` char(64) collate utf8_bin NOT NULL default '',
  `User` char(16) collate utf8_bin NOT NULL default '',
  `Table_name` char(64) collate utf8_bin NOT NULL default '',
  `Column_name` char(64) collate utf8_bin NOT NULL default '',
  `Timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `Column_priv` set('Select','Insert','Update','References') character set utf8 NOT NULL default '',
  PRIMARY KEY  (`Host`,`Db`,`User`,`Table_name`,`Column_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `db`
--

DROP TABLE IF EXISTS `db`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `db` (
  `Host` char(60) collate utf8_bin NOT NULL default '',
  `Db` char(64) collate utf8_bin NOT NULL default '',
  `User` char(16) collate utf8_bin NOT NULL default '',
  `Select_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Insert_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Update_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Delete_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Drop_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Grant_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `References_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Index_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Alter_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_tmp_table_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Lock_tables_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  PRIMARY KEY  (`Host`,`Db`,`User`),
  KEY `User` (`User`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `func`
--

DROP TABLE IF EXISTS `func`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `func` (
  `name` char(64) collate utf8_bin NOT NULL default '',
  `ret` tinyint(1) NOT NULL default '0',
  `dl` char(128) collate utf8_bin NOT NULL default '',
  `type` enum('function','aggregate') character set utf8 NOT NULL default 'function',
  PRIMARY KEY  (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User defined functions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `help_category`
--

DROP TABLE IF EXISTS `help_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help_category` (
  `help_category_id` smallint(5) unsigned NOT NULL default '0',
  `name` varchar(64) NOT NULL default '',
  `parent_category_id` smallint(5) unsigned default NULL,
  `url` varchar(128) NOT NULL default '',
  PRIMARY KEY  (`help_category_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='help categories';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `help_keyword`
--

DROP TABLE IF EXISTS `help_keyword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help_keyword` (
  `help_keyword_id` int(10) unsigned NOT NULL default '0',
  `name` varchar(64) NOT NULL default '',
  PRIMARY KEY  (`help_keyword_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='help keywords';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `help_relation`
--

DROP TABLE IF EXISTS `help_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help_relation` (
  `help_topic_id` int(10) unsigned NOT NULL default '0',
  `help_keyword_id` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`help_keyword_id`,`help_topic_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='keyword-topic relation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `help_topic`
--

DROP TABLE IF EXISTS `help_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help_topic` (
  `help_topic_id` int(10) unsigned NOT NULL default '0',
  `name` varchar(64) NOT NULL default '',
  `help_category_id` smallint(5) unsigned NOT NULL default '0',
  `description` text NOT NULL,
  `example` text NOT NULL,
  `url` varchar(128) NOT NULL default '',
  PRIMARY KEY  (`help_topic_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='help topics';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `host`
--

DROP TABLE IF EXISTS `host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host` (
  `Host` char(60) collate utf8_bin NOT NULL default '',
  `Db` char(64) collate utf8_bin NOT NULL default '',
  `Select_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Insert_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Update_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Delete_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Drop_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Grant_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `References_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Index_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Alter_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_tmp_table_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Lock_tables_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  PRIMARY KEY  (`Host`,`Db`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Host privileges;  Merged with database privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `proc`
--

DROP TABLE IF EXISTS `proc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proc` (
  `db` char(64) character set utf8 collate utf8_bin NOT NULL default '',
  `name` char(64) NOT NULL default '',
  `type` enum('FUNCTION','PROCEDURE') NOT NULL,
  `specific_name` char(64) NOT NULL default '',
  `language` enum('SQL') NOT NULL default 'SQL',
  `sql_data_access` enum('CONTAINS_SQL','NO_SQL','READS_SQL_DATA','MODIFIES_SQL_DATA') NOT NULL default 'CONTAINS_SQL',
  `is_deterministic` enum('YES','NO') NOT NULL default 'NO',
  `security_type` enum('INVOKER','DEFINER') NOT NULL default 'DEFINER',
  `param_list` blob NOT NULL,
  `returns` char(64) NOT NULL default '',
  `body` longblob NOT NULL,
  `definer` char(77) character set utf8 collate utf8_bin NOT NULL default '',
  `created` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `modified` timestamp NOT NULL default '0000-00-00 00:00:00',
  `sql_mode` set('REAL_AS_FLOAT','PIPES_AS_CONCAT','ANSI_QUOTES','IGNORE_SPACE','NOT_USED','ONLY_FULL_GROUP_BY','NO_UNSIGNED_SUBTRACTION','NO_DIR_IN_CREATE','POSTGRESQL','ORACLE','MSSQL','DB2','MAXDB','NO_KEY_OPTIONS','NO_TABLE_OPTIONS','NO_FIELD_OPTIONS','MYSQL323','MYSQL40','ANSI','NO_AUTO_VALUE_ON_ZERO','NO_BACKSLASH_ESCAPES','STRICT_TRANS_TABLES','STRICT_ALL_TABLES','NO_ZERO_IN_DATE','NO_ZERO_DATE','INVALID_DATES','ERROR_FOR_DIVISION_BY_ZERO','TRADITIONAL','NO_AUTO_CREATE_USER','HIGH_NOT_PRECEDENCE') NOT NULL default '',
  `comment` char(64) character set utf8 collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`db`,`name`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stored Procedures';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `procs_priv`
--

DROP TABLE IF EXISTS `procs_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `procs_priv` (
  `Host` char(60) collate utf8_bin NOT NULL default '',
  `Db` char(64) collate utf8_bin NOT NULL default '',
  `User` char(16) collate utf8_bin NOT NULL default '',
  `Routine_name` char(64) collate utf8_bin NOT NULL default '',
  `Routine_type` enum('FUNCTION','PROCEDURE') collate utf8_bin NOT NULL,
  `Grantor` char(77) collate utf8_bin NOT NULL default '',
  `Proc_priv` set('Execute','Alter Routine','Grant') character set utf8 NOT NULL default '',
  `Timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`Host`,`Db`,`User`,`Routine_name`,`Routine_type`),
  KEY `Grantor` (`Grantor`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Procedure privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tables_priv`
--

DROP TABLE IF EXISTS `tables_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tables_priv` (
  `Host` char(60) collate utf8_bin NOT NULL default '',
  `Db` char(64) collate utf8_bin NOT NULL default '',
  `User` char(16) collate utf8_bin NOT NULL default '',
  `Table_name` char(64) collate utf8_bin NOT NULL default '',
  `Grantor` char(77) collate utf8_bin NOT NULL default '',
  `Timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `Table_priv` set('Select','Insert','Update','Delete','Create','Drop','Grant','References','Index','Alter') character set utf8 NOT NULL default '',
  `Column_priv` set('Select','Insert','Update','References') character set utf8 NOT NULL default '',
  PRIMARY KEY  (`Host`,`Db`,`User`,`Table_name`),
  KEY `Grantor` (`Grantor`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_zone`
--

DROP TABLE IF EXISTS `time_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_zone` (
  `Time_zone_id` int(10) unsigned NOT NULL auto_increment,
  `Use_leap_seconds` enum('Y','N') NOT NULL default 'N',
  PRIMARY KEY  (`Time_zone_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Time zones';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_zone_leap_second`
--

DROP TABLE IF EXISTS `time_zone_leap_second`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_zone_leap_second` (
  `Transition_time` bigint(20) NOT NULL default '0',
  `Correction` int(11) NOT NULL default '0',
  PRIMARY KEY  (`Transition_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Leap seconds information for time zones';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_zone_name`
--

DROP TABLE IF EXISTS `time_zone_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_zone_name` (
  `Name` char(64) NOT NULL default '',
  `Time_zone_id` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`Name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Time zone names';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_zone_transition`
--

DROP TABLE IF EXISTS `time_zone_transition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_zone_transition` (
  `Time_zone_id` int(10) unsigned NOT NULL default '0',
  `Transition_time` bigint(20) NOT NULL default '0',
  `Transition_type_id` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`Time_zone_id`,`Transition_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Time zone transitions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_zone_transition_type`
--

DROP TABLE IF EXISTS `time_zone_transition_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_zone_transition_type` (
  `Time_zone_id` int(10) unsigned NOT NULL default '0',
  `Transition_type_id` int(10) unsigned NOT NULL default '0',
  `Offset` int(11) NOT NULL default '0',
  `Is_DST` tinyint(3) unsigned NOT NULL default '0',
  `Abbreviation` char(8) NOT NULL default '',
  PRIMARY KEY  (`Time_zone_id`,`Transition_type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Time zone transition types';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `Host` varchar(60) collate utf8_bin NOT NULL default '',
  `User` varchar(16) collate utf8_bin NOT NULL default '',
  `Password` varchar(41) collate utf8_bin NOT NULL default '',
  `Select_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Insert_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Update_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Delete_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Drop_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Reload_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Shutdown_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Process_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `File_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Grant_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `References_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Index_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Alter_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Show_db_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Super_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Create_tmp_table_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Lock_tables_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Execute_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Repl_slave_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `Repl_client_priv` enum('N','Y') character set utf8 NOT NULL default 'N',
  `ssl_type` enum('','ANY','X509','SPECIFIED') character set utf8 NOT NULL default '',
  `ssl_cipher` blob NOT NULL,
  `x509_issuer` blob NOT NULL,
  `x509_subject` blob NOT NULL,
  `max_questions` int(11) unsigned NOT NULL default '0',
  `max_updates` int(11) unsigned NOT NULL default '0',
  `max_connections` int(11) unsigned NOT NULL default '0',
  PRIMARY KEY  (`Host`,`User`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and global privileges';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Current Database: `test`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `test` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `test`;

--
-- Table structure for table `climatePhenomena_seasonal`
--

DROP TABLE IF EXISTS `climatePhenomena_seasonal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `climatePhenomena_seasonal` (
  `date_valid` date default NULL,
  `ENSO` varchar(20) default NULL,
  KEY `index_date` (`date_valid`),
  KEY `index_enso` (`ENSO`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Current Database: `verification`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `verification` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `verification`;

--
-- Current Database: `wc`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `wc` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `wc`;

--
-- Table structure for table `cal_gec0000`
--

DROP TABLE IF EXISTS `cal_gec0000`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gec0000` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gec0006`
--

DROP TABLE IF EXISTS `cal_gec0006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gec0006` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0100`
--

DROP TABLE IF EXISTS `cal_gep0100`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0100` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0106`
--

DROP TABLE IF EXISTS `cal_gep0106`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0106` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0200`
--

DROP TABLE IF EXISTS `cal_gep0200`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0200` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0206`
--

DROP TABLE IF EXISTS `cal_gep0206`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0206` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0300`
--

DROP TABLE IF EXISTS `cal_gep0300`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0300` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0306`
--

DROP TABLE IF EXISTS `cal_gep0306`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0306` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0400`
--

DROP TABLE IF EXISTS `cal_gep0400`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0400` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0406`
--

DROP TABLE IF EXISTS `cal_gep0406`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0406` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0500`
--

DROP TABLE IF EXISTS `cal_gep0500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0500` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0506`
--

DROP TABLE IF EXISTS `cal_gep0506`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0506` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0600`
--

DROP TABLE IF EXISTS `cal_gep0600`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0600` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0606`
--

DROP TABLE IF EXISTS `cal_gep0606`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0606` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0700`
--

DROP TABLE IF EXISTS `cal_gep0700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0700` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0706`
--

DROP TABLE IF EXISTS `cal_gep0706`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0706` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0800`
--

DROP TABLE IF EXISTS `cal_gep0800`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0800` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0806`
--

DROP TABLE IF EXISTS `cal_gep0806`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0806` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0900`
--

DROP TABLE IF EXISTS `cal_gep0900`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0900` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep0906`
--

DROP TABLE IF EXISTS `cal_gep0906`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep0906` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1000`
--

DROP TABLE IF EXISTS `cal_gep1000`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1000` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1006`
--

DROP TABLE IF EXISTS `cal_gep1006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1006` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1100`
--

DROP TABLE IF EXISTS `cal_gep1100`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1100` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1106`
--

DROP TABLE IF EXISTS `cal_gep1106`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1106` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1200`
--

DROP TABLE IF EXISTS `cal_gep1200`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1200` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1206`
--

DROP TABLE IF EXISTS `cal_gep1206`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1206` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1300`
--

DROP TABLE IF EXISTS `cal_gep1300`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1300` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1306`
--

DROP TABLE IF EXISTS `cal_gep1306`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1306` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1400`
--

DROP TABLE IF EXISTS `cal_gep1400`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1400` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1406`
--

DROP TABLE IF EXISTS `cal_gep1406`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1406` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1500`
--

DROP TABLE IF EXISTS `cal_gep1500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1500` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1506`
--

DROP TABLE IF EXISTS `cal_gep1506`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1506` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1600`
--

DROP TABLE IF EXISTS `cal_gep1600`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1600` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1606`
--

DROP TABLE IF EXISTS `cal_gep1606`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1606` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1700`
--

DROP TABLE IF EXISTS `cal_gep1700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1700` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1706`
--

DROP TABLE IF EXISTS `cal_gep1706`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1706` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1800`
--

DROP TABLE IF EXISTS `cal_gep1800`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1800` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1806`
--

DROP TABLE IF EXISTS `cal_gep1806`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1806` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1900`
--

DROP TABLE IF EXISTS `cal_gep1900`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1900` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep1906`
--

DROP TABLE IF EXISTS `cal_gep1906`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep1906` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep2000`
--

DROP TABLE IF EXISTS `cal_gep2000`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep2000` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cal_gep2006`
--

DROP TABLE IF EXISTS `cal_gep2006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cal_gep2006` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL,
  `d8_lwcf_bias` float default NULL,
  `d8_lmnf_bias` float default NULL,
  `d11_lwcf_bias` float default NULL,
  `d11_lmnf_bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calibrated`
--

DROP TABLE IF EXISTS `calibrated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calibrated` (
  `fcst` float default NULL,
  `bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d11_0_reliab`
--

DROP TABLE IF EXISTS `d11_0_reliab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d11_0_reliab` (
  `stn` char(6) default NULL,
  `f10` int(11) default NULL,
  `o10` int(11) default NULL,
  `f20` int(11) default NULL,
  `o20` int(11) default NULL,
  `f30` int(11) default NULL,
  `o30` int(11) default NULL,
  `f40` int(11) default NULL,
  `o40` int(11) default NULL,
  `f50` int(11) default NULL,
  `o50` int(11) default NULL,
  `f60` int(11) default NULL,
  `o60` int(11) default NULL,
  `f70` int(11) default NULL,
  `o70` int(11) default NULL,
  `f80` int(11) default NULL,
  `o80` int(11) default NULL,
  `f90` int(11) default NULL,
  `o90` int(11) default NULL,
  `f100` int(11) default NULL,
  `o100` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d11_10_reliab`
--

DROP TABLE IF EXISTS `d11_10_reliab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d11_10_reliab` (
  `stn` char(6) default NULL,
  `f10` int(11) default NULL,
  `o10` int(11) default NULL,
  `f20` int(11) default NULL,
  `o20` int(11) default NULL,
  `f30` int(11) default NULL,
  `o30` int(11) default NULL,
  `f40` int(11) default NULL,
  `o40` int(11) default NULL,
  `f50` int(11) default NULL,
  `o50` int(11) default NULL,
  `f60` int(11) default NULL,
  `o60` int(11) default NULL,
  `f70` int(11) default NULL,
  `o70` int(11) default NULL,
  `f80` int(11) default NULL,
  `o80` int(11) default NULL,
  `f90` int(11) default NULL,
  `o90` int(11) default NULL,
  `f100` int(11) default NULL,
  `o100` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d11_20_reliab`
--

DROP TABLE IF EXISTS `d11_20_reliab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d11_20_reliab` (
  `stn` char(6) default NULL,
  `f10` int(11) default NULL,
  `o10` int(11) default NULL,
  `f20` int(11) default NULL,
  `o20` int(11) default NULL,
  `f30` int(11) default NULL,
  `o30` int(11) default NULL,
  `f40` int(11) default NULL,
  `o40` int(11) default NULL,
  `f50` int(11) default NULL,
  `o50` int(11) default NULL,
  `f60` int(11) default NULL,
  `o60` int(11) default NULL,
  `f70` int(11) default NULL,
  `o70` int(11) default NULL,
  `f80` int(11) default NULL,
  `o80` int(11) default NULL,
  `f90` int(11) default NULL,
  `o90` int(11) default NULL,
  `f100` int(11) default NULL,
  `o100` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d11_28_reliab`
--

DROP TABLE IF EXISTS `d11_28_reliab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d11_28_reliab` (
  `stn` char(6) default NULL,
  `f10` int(11) default NULL,
  `o10` int(11) default NULL,
  `f20` int(11) default NULL,
  `o20` int(11) default NULL,
  `f30` int(11) default NULL,
  `o30` int(11) default NULL,
  `f40` int(11) default NULL,
  `o40` int(11) default NULL,
  `f50` int(11) default NULL,
  `o50` int(11) default NULL,
  `f60` int(11) default NULL,
  `o60` int(11) default NULL,
  `f70` int(11) default NULL,
  `o70` int(11) default NULL,
  `f80` int(11) default NULL,
  `o80` int(11) default NULL,
  `f90` int(11) default NULL,
  `o90` int(11) default NULL,
  `f100` int(11) default NULL,
  `o100` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d11_32_reliab`
--

DROP TABLE IF EXISTS `d11_32_reliab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d11_32_reliab` (
  `stn` char(6) default NULL,
  `f10` int(11) default NULL,
  `o10` int(11) default NULL,
  `f20` int(11) default NULL,
  `o20` int(11) default NULL,
  `f30` int(11) default NULL,
  `o30` int(11) default NULL,
  `f40` int(11) default NULL,
  `o40` int(11) default NULL,
  `f50` int(11) default NULL,
  `o50` int(11) default NULL,
  `f60` int(11) default NULL,
  `o60` int(11) default NULL,
  `f70` int(11) default NULL,
  `o70` int(11) default NULL,
  `f80` int(11) default NULL,
  `o80` int(11) default NULL,
  `f90` int(11) default NULL,
  `o90` int(11) default NULL,
  `f100` int(11) default NULL,
  `o100` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d11_M20_reliab`
--

DROP TABLE IF EXISTS `d11_M20_reliab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d11_M20_reliab` (
  `stn` char(6) default NULL,
  `f10` int(11) default NULL,
  `o10` int(11) default NULL,
  `f20` int(11) default NULL,
  `o20` int(11) default NULL,
  `f30` int(11) default NULL,
  `o30` int(11) default NULL,
  `f40` int(11) default NULL,
  `o40` int(11) default NULL,
  `f50` int(11) default NULL,
  `o50` int(11) default NULL,
  `f60` int(11) default NULL,
  `o60` int(11) default NULL,
  `f70` int(11) default NULL,
  `o70` int(11) default NULL,
  `f80` int(11) default NULL,
  `o80` int(11) default NULL,
  `f90` int(11) default NULL,
  `o90` int(11) default NULL,
  `f100` int(11) default NULL,
  `o100` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d11_M40_reliab`
--

DROP TABLE IF EXISTS `d11_M40_reliab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d11_M40_reliab` (
  `stn` char(6) default NULL,
  `f10` int(11) default NULL,
  `o10` int(11) default NULL,
  `f20` int(11) default NULL,
  `o20` int(11) default NULL,
  `f30` int(11) default NULL,
  `o30` int(11) default NULL,
  `f40` int(11) default NULL,
  `o40` int(11) default NULL,
  `f50` int(11) default NULL,
  `o50` int(11) default NULL,
  `f60` int(11) default NULL,
  `o60` int(11) default NULL,
  `f70` int(11) default NULL,
  `o70` int(11) default NULL,
  `f80` int(11) default NULL,
  `o80` int(11) default NULL,
  `f90` int(11) default NULL,
  `o90` int(11) default NULL,
  `f100` int(11) default NULL,
  `o100` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d11_belnor_reliab`
--

DROP TABLE IF EXISTS `d11_belnor_reliab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d11_belnor_reliab` (
  `stn` char(6) default NULL,
  `f10` int(11) default NULL,
  `o10` int(11) default NULL,
  `f20` int(11) default NULL,
  `o20` int(11) default NULL,
  `f30` int(11) default NULL,
  `o30` int(11) default NULL,
  `f40` int(11) default NULL,
  `o40` int(11) default NULL,
  `f50` int(11) default NULL,
  `o50` int(11) default NULL,
  `f60` int(11) default NULL,
  `o60` int(11) default NULL,
  `f70` int(11) default NULL,
  `o70` int(11) default NULL,
  `f80` int(11) default NULL,
  `o80` int(11) default NULL,
  `f90` int(11) default NULL,
  `o90` int(11) default NULL,
  `f100` int(11) default NULL,
  `o100` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d11_obs`
--

DROP TABLE IF EXISTS `d11_obs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d11_obs` (
  `date` date default NULL,
  `stn` char(5) default NULL,
  `lwcf` float default NULL,
  `lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d11_verf`
--

DROP TABLE IF EXISTS `d11_verf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d11_verf` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `numfcsts` int(11) default NULL,
  `corfcsts` int(11) default NULL,
  `obscat` int(11) default NULL,
  `frps` float default NULL,
  `crps` float default NULL,
  `fBrBel` float default NULL,
  `cBrBel` float default NULL,
  `fBr32` float default NULL,
  `cBr32` float default NULL,
  `fBr28` float default NULL,
  `cBr28` float default NULL,
  `fBr20` float default NULL,
  `cBr20` float default NULL,
  `fBr10` float default NULL,
  `cBr10` float default NULL,
  `fBr0` float default NULL,
  `cBr0` float default NULL,
  `fBrM20` float default NULL,
  `cBrM20` float default NULL,
  `fBrM40` float default NULL,
  `cbrM40` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d11tmp_calfcst`
--

DROP TABLE IF EXISTS `d11tmp_calfcst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d11tmp_calfcst` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `lwcf` float default NULL,
  `prbb` float default NULL,
  `prbn` float default NULL,
  `prba` float default NULL,
  `tp32` float default NULL,
  `tp28` float default NULL,
  `tp20` float default NULL,
  `tp10` float default NULL,
  `tp00` float default NULL,
  `tm20` float default NULL,
  `tm40` float default NULL,
  `bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d11wc_calfcst`
--

DROP TABLE IF EXISTS `d11wc_calfcst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d11wc_calfcst` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `lwcf` float default NULL,
  `prbb` float default NULL,
  `prbn` float default NULL,
  `prba` float default NULL,
  `tp32` float default NULL,
  `tp28` float default NULL,
  `tp20` float default NULL,
  `tp10` float default NULL,
  `tp00` float default NULL,
  `tm20` float default NULL,
  `tm40` float default NULL,
  `bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d8_0_reliab`
--

DROP TABLE IF EXISTS `d8_0_reliab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d8_0_reliab` (
  `stn` char(6) default NULL,
  `f10` int(11) default NULL,
  `o10` int(11) default NULL,
  `f20` int(11) default NULL,
  `o20` int(11) default NULL,
  `f30` int(11) default NULL,
  `o30` int(11) default NULL,
  `f40` int(11) default NULL,
  `o40` int(11) default NULL,
  `f50` int(11) default NULL,
  `o50` int(11) default NULL,
  `f60` int(11) default NULL,
  `o60` int(11) default NULL,
  `f70` int(11) default NULL,
  `o70` int(11) default NULL,
  `f80` int(11) default NULL,
  `o80` int(11) default NULL,
  `f90` int(11) default NULL,
  `o90` int(11) default NULL,
  `f100` int(11) default NULL,
  `o100` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d8_10_reliab`
--

DROP TABLE IF EXISTS `d8_10_reliab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d8_10_reliab` (
  `stn` char(6) default NULL,
  `f10` int(11) default NULL,
  `o10` int(11) default NULL,
  `f20` int(11) default NULL,
  `o20` int(11) default NULL,
  `f30` int(11) default NULL,
  `o30` int(11) default NULL,
  `f40` int(11) default NULL,
  `o40` int(11) default NULL,
  `f50` int(11) default NULL,
  `o50` int(11) default NULL,
  `f60` int(11) default NULL,
  `o60` int(11) default NULL,
  `f70` int(11) default NULL,
  `o70` int(11) default NULL,
  `f80` int(11) default NULL,
  `o80` int(11) default NULL,
  `f90` int(11) default NULL,
  `o90` int(11) default NULL,
  `f100` int(11) default NULL,
  `o100` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d8_20_reliab`
--

DROP TABLE IF EXISTS `d8_20_reliab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d8_20_reliab` (
  `stn` char(6) default NULL,
  `f10` int(11) default NULL,
  `o10` int(11) default NULL,
  `f20` int(11) default NULL,
  `o20` int(11) default NULL,
  `f30` int(11) default NULL,
  `o30` int(11) default NULL,
  `f40` int(11) default NULL,
  `o40` int(11) default NULL,
  `f50` int(11) default NULL,
  `o50` int(11) default NULL,
  `f60` int(11) default NULL,
  `o60` int(11) default NULL,
  `f70` int(11) default NULL,
  `o70` int(11) default NULL,
  `f80` int(11) default NULL,
  `o80` int(11) default NULL,
  `f90` int(11) default NULL,
  `o90` int(11) default NULL,
  `f100` int(11) default NULL,
  `o100` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d8_28_reliab`
--

DROP TABLE IF EXISTS `d8_28_reliab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d8_28_reliab` (
  `stn` char(6) default NULL,
  `f10` int(11) default NULL,
  `o10` int(11) default NULL,
  `f20` int(11) default NULL,
  `o20` int(11) default NULL,
  `f30` int(11) default NULL,
  `o30` int(11) default NULL,
  `f40` int(11) default NULL,
  `o40` int(11) default NULL,
  `f50` int(11) default NULL,
  `o50` int(11) default NULL,
  `f60` int(11) default NULL,
  `o60` int(11) default NULL,
  `f70` int(11) default NULL,
  `o70` int(11) default NULL,
  `f80` int(11) default NULL,
  `o80` int(11) default NULL,
  `f90` int(11) default NULL,
  `o90` int(11) default NULL,
  `f100` int(11) default NULL,
  `o100` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d8_32_reliab`
--

DROP TABLE IF EXISTS `d8_32_reliab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d8_32_reliab` (
  `stn` char(6) default NULL,
  `f10` int(11) default NULL,
  `o10` int(11) default NULL,
  `f20` int(11) default NULL,
  `o20` int(11) default NULL,
  `f30` int(11) default NULL,
  `o30` int(11) default NULL,
  `f40` int(11) default NULL,
  `o40` int(11) default NULL,
  `f50` int(11) default NULL,
  `o50` int(11) default NULL,
  `f60` int(11) default NULL,
  `o60` int(11) default NULL,
  `f70` int(11) default NULL,
  `o70` int(11) default NULL,
  `f80` int(11) default NULL,
  `o80` int(11) default NULL,
  `f90` int(11) default NULL,
  `o90` int(11) default NULL,
  `f100` int(11) default NULL,
  `o100` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d8_M20_reliab`
--

DROP TABLE IF EXISTS `d8_M20_reliab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d8_M20_reliab` (
  `stn` char(6) default NULL,
  `f10` int(11) default NULL,
  `o10` int(11) default NULL,
  `f20` int(11) default NULL,
  `o20` int(11) default NULL,
  `f30` int(11) default NULL,
  `o30` int(11) default NULL,
  `f40` int(11) default NULL,
  `o40` int(11) default NULL,
  `f50` int(11) default NULL,
  `o50` int(11) default NULL,
  `f60` int(11) default NULL,
  `o60` int(11) default NULL,
  `f70` int(11) default NULL,
  `o70` int(11) default NULL,
  `f80` int(11) default NULL,
  `o80` int(11) default NULL,
  `f90` int(11) default NULL,
  `o90` int(11) default NULL,
  `f100` int(11) default NULL,
  `o100` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d8_M40_reliab`
--

DROP TABLE IF EXISTS `d8_M40_reliab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d8_M40_reliab` (
  `stn` char(6) default NULL,
  `f10` int(11) default NULL,
  `o10` int(11) default NULL,
  `f20` int(11) default NULL,
  `o20` int(11) default NULL,
  `f30` int(11) default NULL,
  `o30` int(11) default NULL,
  `f40` int(11) default NULL,
  `o40` int(11) default NULL,
  `f50` int(11) default NULL,
  `o50` int(11) default NULL,
  `f60` int(11) default NULL,
  `o60` int(11) default NULL,
  `f70` int(11) default NULL,
  `o70` int(11) default NULL,
  `f80` int(11) default NULL,
  `o80` int(11) default NULL,
  `f90` int(11) default NULL,
  `o90` int(11) default NULL,
  `f100` int(11) default NULL,
  `o100` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d8_belnor_reliab`
--

DROP TABLE IF EXISTS `d8_belnor_reliab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d8_belnor_reliab` (
  `stn` char(6) default NULL,
  `f10` int(11) default NULL,
  `o10` int(11) default NULL,
  `f20` int(11) default NULL,
  `o20` int(11) default NULL,
  `f30` int(11) default NULL,
  `o30` int(11) default NULL,
  `f40` int(11) default NULL,
  `o40` int(11) default NULL,
  `f50` int(11) default NULL,
  `o50` int(11) default NULL,
  `f60` int(11) default NULL,
  `o60` int(11) default NULL,
  `f70` int(11) default NULL,
  `o70` int(11) default NULL,
  `f80` int(11) default NULL,
  `o80` int(11) default NULL,
  `f90` int(11) default NULL,
  `o90` int(11) default NULL,
  `f100` int(11) default NULL,
  `o100` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d8_obs`
--

DROP TABLE IF EXISTS `d8_obs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d8_obs` (
  `date` date default NULL,
  `stn` char(5) default NULL,
  `lwcf` float default NULL,
  `lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d8_verf`
--

DROP TABLE IF EXISTS `d8_verf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d8_verf` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `numfcsts` int(11) default NULL,
  `corfcsts` int(11) default NULL,
  `obscat` int(11) default NULL,
  `frps` float default NULL,
  `crps` float default NULL,
  `fBrBel` float default NULL,
  `cBrBel` float default NULL,
  `fBr32` float default NULL,
  `cBr32` float default NULL,
  `fBr28` float default NULL,
  `cBr28` float default NULL,
  `fBr20` float default NULL,
  `cBr20` float default NULL,
  `fBr10` float default NULL,
  `cBr10` float default NULL,
  `fBr0` float default NULL,
  `cBr0` float default NULL,
  `fBrM20` float default NULL,
  `cBrM20` float default NULL,
  `fBrM40` float default NULL,
  `cbrM40` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d8tmp_calfcst`
--

DROP TABLE IF EXISTS `d8tmp_calfcst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d8tmp_calfcst` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `lwcf` float default NULL,
  `prbb` float default NULL,
  `prbn` float default NULL,
  `prba` float default NULL,
  `tp32` float default NULL,
  `tp28` float default NULL,
  `tp20` float default NULL,
  `tp10` float default NULL,
  `tp00` float default NULL,
  `tm20` float default NULL,
  `tm40` float default NULL,
  `bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `d8wc_calfcst`
--

DROP TABLE IF EXISTS `d8wc_calfcst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d8wc_calfcst` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `lwcf` float default NULL,
  `prbb` float default NULL,
  `prbn` float default NULL,
  `prba` float default NULL,
  `tp32` float default NULL,
  `tp28` float default NULL,
  `tp20` float default NULL,
  `tp10` float default NULL,
  `tp00` float default NULL,
  `tm20` float default NULL,
  `tm40` float default NULL,
  `bias` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gec0000`
--

DROP TABLE IF EXISTS `gec0000`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gec0000` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gec0006`
--

DROP TABLE IF EXISTS `gec0006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gec0006` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0100`
--

DROP TABLE IF EXISTS `gep0100`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0100` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0106`
--

DROP TABLE IF EXISTS `gep0106`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0106` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0200`
--

DROP TABLE IF EXISTS `gep0200`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0200` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0206`
--

DROP TABLE IF EXISTS `gep0206`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0206` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0300`
--

DROP TABLE IF EXISTS `gep0300`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0300` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0306`
--

DROP TABLE IF EXISTS `gep0306`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0306` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0400`
--

DROP TABLE IF EXISTS `gep0400`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0400` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0406`
--

DROP TABLE IF EXISTS `gep0406`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0406` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0500`
--

DROP TABLE IF EXISTS `gep0500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0500` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0506`
--

DROP TABLE IF EXISTS `gep0506`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0506` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0600`
--

DROP TABLE IF EXISTS `gep0600`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0600` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0606`
--

DROP TABLE IF EXISTS `gep0606`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0606` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0700`
--

DROP TABLE IF EXISTS `gep0700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0700` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0706`
--

DROP TABLE IF EXISTS `gep0706`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0706` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0800`
--

DROP TABLE IF EXISTS `gep0800`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0800` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0806`
--

DROP TABLE IF EXISTS `gep0806`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0806` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0900`
--

DROP TABLE IF EXISTS `gep0900`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0900` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep0906`
--

DROP TABLE IF EXISTS `gep0906`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep0906` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1000`
--

DROP TABLE IF EXISTS `gep1000`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1000` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1006`
--

DROP TABLE IF EXISTS `gep1006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1006` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1100`
--

DROP TABLE IF EXISTS `gep1100`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1100` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1106`
--

DROP TABLE IF EXISTS `gep1106`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1106` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1200`
--

DROP TABLE IF EXISTS `gep1200`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1200` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1206`
--

DROP TABLE IF EXISTS `gep1206`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1206` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1300`
--

DROP TABLE IF EXISTS `gep1300`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1300` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1306`
--

DROP TABLE IF EXISTS `gep1306`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1306` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1400`
--

DROP TABLE IF EXISTS `gep1400`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1400` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1406`
--

DROP TABLE IF EXISTS `gep1406`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1406` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1500`
--

DROP TABLE IF EXISTS `gep1500`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1500` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1506`
--

DROP TABLE IF EXISTS `gep1506`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1506` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1600`
--

DROP TABLE IF EXISTS `gep1600`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1600` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1606`
--

DROP TABLE IF EXISTS `gep1606`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1606` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1700`
--

DROP TABLE IF EXISTS `gep1700`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1700` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1706`
--

DROP TABLE IF EXISTS `gep1706`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1706` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1800`
--

DROP TABLE IF EXISTS `gep1800`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1800` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1806`
--

DROP TABLE IF EXISTS `gep1806`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1806` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1900`
--

DROP TABLE IF EXISTS `gep1900`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1900` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep1906`
--

DROP TABLE IF EXISTS `gep1906`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep1906` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep2000`
--

DROP TABLE IF EXISTS `gep2000`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep2000` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gep2006`
--

DROP TABLE IF EXISTS `gep2006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gep2006` (
  `date` date default NULL,
  `stn` char(6) default NULL,
  `d8_lwcf` float default NULL,
  `d8_lmnf` float default NULL,
  `d11_lwcf` float default NULL,
  `d11_lmnf` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `station_list`
--

DROP TABLE IF EXISTS `station_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `station_list` (
  `wmo` int(11) default NULL,
  `lat` float default NULL,
  `lon` float default NULL,
  `city` text,
  `st` char(2) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Current Database: `wind_climo`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `wind_climo` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `wind_climo`;

--
-- Table structure for table `climo_5day_smoothed`
--

DROP TABLE IF EXISTS `climo_5day_smoothed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `climo_5day_smoothed` (
  `jul_day` int(11) default NULL,
  `stn` int(11) default NULL,
  `tbel` double default NULL,
  `tnor` double default NULL,
  `tabv` double default NULL,
  `tp32` double default NULL,
  `tp28` double default NULL,
  `tp20` double default NULL,
  `tp10` double default NULL,
  `tp0` double default NULL,
  `tm20` double default NULL,
  `tm40` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `climo_7day_smoothed`
--

DROP TABLE IF EXISTS `climo_7day_smoothed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `climo_7day_smoothed` (
  `jul_day` int(11) default NULL,
  `stn` int(11) default NULL,
  `tbel` double default NULL,
  `tnor` double default NULL,
  `tabv` double default NULL,
  `tp32` double default NULL,
  `tp28` double default NULL,
  `tp20` double default NULL,
  `tp10` double default NULL,
  `tp0` double default NULL,
  `tm20` double default NULL,
  `tm40` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `daily`
--

DROP TABLE IF EXISTS `daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `daily` (
  `date` date default NULL,
  `wc` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hourly`
--

DROP TABLE IF EXISTS `hourly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hourly` (
  `date` date default NULL,
  `time` int(11) default NULL,
  `wc` float default NULL,
  `tqc` int(11) default NULL,
  `wqc` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pentad`
--

DROP TABLE IF EXISTS `pentad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pentad` (
  `date` date default NULL,
  `stn` int(11) default NULL,
  `wc` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pentad_temp`
--

DROP TABLE IF EXISTS `pentad_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pentad_temp` (
  `date` date default NULL,
  `stn` int(11) default NULL,
  `tmp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seven_day`
--

DROP TABLE IF EXISTS `seven_day`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seven_day` (
  `date` date default NULL,
  `stn` int(11) default NULL,
  `wc` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seven_day_temp`
--

DROP TABLE IF EXISTS `seven_day_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seven_day_temp` (
  `date` date default NULL,
  `stn` int(11) default NULL,
  `tmp` float default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stations`
--

DROP TABLE IF EXISTS `stations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stations` (
  `wmo` int(11) default NULL,
  `icao` char(4) default NULL,
  `lat` float default NULL,
  `lon` float default NULL,
  `firstflag` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_climo_5day_smoothed`
--

DROP TABLE IF EXISTS `temp_climo_5day_smoothed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_climo_5day_smoothed` (
  `jul_day` int(11) default NULL,
  `stn` int(11) default NULL,
  `tbel` double default NULL,
  `tnor` double default NULL,
  `tabv` double default NULL,
  `tp32` double default NULL,
  `tp28` double default NULL,
  `tp20` double default NULL,
  `tp10` double default NULL,
  `tp0` double default NULL,
  `tm20` double default NULL,
  `tm40` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp_climo_7day_smoothed`
--

DROP TABLE IF EXISTS `temp_climo_7day_smoothed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `temp_climo_7day_smoothed` (
  `jul_day` int(11) default NULL,
  `stn` int(11) default NULL,
  `tbel` double default NULL,
  `tnor` double default NULL,
  `tabv` double default NULL,
  `tp32` double default NULL,
  `tp28` double default NULL,
  `tp20` double default NULL,
  `tp10` double default NULL,
  `tp0` double default NULL,
  `tm20` double default NULL,
  `tm40` double default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-09-04 17:57:10
