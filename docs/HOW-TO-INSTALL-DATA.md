# VWT Data –  How to Install

## Table of Contents

<!-- TOC depthFrom:2 depthTo:3 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Table of Contents](#table-of-contents)
- [This Document](#this-document)
- [Background](#background)
- [Requirements](#requirements)
- [Installation](#installation)
	- [Setting Up the Database](#setting-up-the-database)
	- [Downloading the Verification System](#downloading-the-verification-system)
	- [Setting Up the Config File](#setting-up-the-config-file)
	- [Setting Up the Data Import Scripts on Cron](#setting-up-the-data-import-scripts-on-cron)
	- [Setting Up the Missing Data Checking Scripts on Cron](#setting-up-the-missing-data-checking-scripts-on-cron)

<!-- /TOC -->

## This Document

This document provides instructions for installing the Verification System data import scripts.

## Background

The Verification System uses a MySQL database to store the necessary forecasts, observations, climatologies, and reference data to generate verification scores. The data is imported using a set of Perl scripts that can run independently of the Verification System itself.

## Requirements

The following software is required:

* MySQL >= 4.1.22 (local or on a server)
* Perl >= 5.8.8, and the following Perl modules:
    * Cwd
    * Date::Manip
    * Getopt::Long
    * Log::Dispatch::Email::MailSend;
    * Log::Log4perl;
    * LWP::Simple;
    * Mysql;
    * Pod::Usage;
    * POSIX;
    * Switch;
    * Time::Local;

## Installation

### Setting Up the Database

Refer to the [Data Handbook](https://docs.google.com/a/noaa.gov/document/d/1wnD4myU63NSj0HVDrtVeDeDxzeuF7S2YPy3iJ9Cff1M).

### Downloading the Verification System

The Verification System is currently installed in the directory defined by the `$VERIF_HOME` environment variable.

If you're installing the Verification System elsewhere, then you can follow the instructions on downloading the Verification System in the [VWT How to Install document](HOW-TO-INSTALL.md).

### Setting Up the Config File

The data scripts all need a config file input/verif_data.conf. Do the following to setup these config files:

1. Copy the example config file to a real config file:

    cd input
    cp verif_data.conf.example verif_data.conf

2. Edit the config files, following the instructions in the files.

  Here are the MySQL settings in the server config file that should be used on the Compute Farm:

    * host – vm-lnx-cpccfmysql.ncep.noaa.gov
    * user – vwt_admin
    * password – contact Mike Charles
    * db_fcst – cpc_forecasts
    * db_obs – cpc_observations
    * db_clim – cpc_climatologies
    * db_ref – cpc_reference
    * db_vwt – cpc_vwt
    * toEmail – mike.charles@noaa.gov
    * subject – [leave blank]
    * fromEmail – cpc_verif@noaa.gov
    * fromName – CPC Verif Data
    * logLevel – ERROR

### Setting Up the Data Import Scripts on Cron

The script `scripts/init_db_import_extendedRange.csh` imports the past 2 weeks of ERF data into the VWT database. The script `scripts/init_db_import_longRange.csh` imports the past year of LLF data into the VWT database. The script `scripts/init_db_import_climPhenom.csh` imports climate phenomena into the VWT database.

Here is a table describing all the data import scripts that need to run on cron:

<table>
  <tr>
    <td>Type</td>
    <td>Script</td>
    <td>Time</td>
    <td>Log file</td>
  </tr>
  <tr>
    <td>ERF</td>
    <td>init_db_import_extendedRange.csh</td>
    <td>2100Z</td>
    <td>db_import_extendedRange.log</td>
  </tr>
  <tr>
    <td>LLF</td>
    <td>init_db_import_longRange.csh</td>
    <td>2110Z</td>
    <td>db_import_longRange.log</td>
  </tr>
  <tr>
    <td>Climate phenom.</td>
    <td>init_db_import_climPhenom.csh</td>
    <td>2120Z</td>
    <td>db_import_climPhenom.log</td>
  </tr>
</table>

#### Examples from test account on CF

##### Extended range - 21 UTC every night

    00 21  *  *  * /situation/bin/flagrun.pl CPCTEST "/cpc/prod_tst/mcharles/sandboxes/verif/trunk/scripts/init_db_import_extendedRange.csh > /cpc/prod_tst/mcharles/sandboxes/verif/trunk/logs/db_import_extendedRange.log 2>&1"

##### Long range - 21:10 UTC on the 4th of every month

    10 21  4  *  * /situation/bin/flagrun.pl CPCTEST "/cpc/prod_tst/mcharles/sandboxes/verif/trunk/scripts/init_db_import_longRange.csh > /cpc/prod_tst/mcharles/sandboxes/verif/trunk/logs/db_import_longRange.log 2>&1"

##### Climate phenomena data - 21:20 UTC on the 4th of every month

    20 21  4  *  * /situation/bin/flagrun.pl CPCTEST "/cpc/prod_tst/mcharles/sandboxes/verif/trunk/scripts/init_db_import_climPhenom.csh -i http://www.cpc.ncep.noaa.gov/data/indices/oni.ascii.txt -c ENSO -t seasonal -m 1 -y 2 -v 3 -f MMM -hasheader > /cpc/prod_tst/mcharles/sandboxes/verif/trunk/logs/db_import_climPhenom.log 2>&1"

### Setting Up the Missing Data Checking Scripts on Cron

The script `scripts/init_db_test_findMissing_batch.csh` checks for missing data, and has command line options for specifying the type of data, be it ERF, LLF, etc.

Here is a table describing all the data checking scripts that need to run on cron:

<table>
  <tr>
    <td>Type</td>
    <td>Script</td>
    <td>Time</td>
    <td>Log file</td>
  </tr>
  <tr>
    <td>ERF</td>
    <td>init_db_test_findMissing_batch.csh -f ERF</td>
    <td>2200Z</td>
    <td>db_test_findMissing_ERF.log</td>
  </tr>
  <tr>
    <td>monthly</td>
    <td>init_db_test_findMissing_batch.csh -f monthly</td>
    <td>2210Z</td>
    <td>db_test_findMissing_monthly.log</td>
  </tr>
  <tr>
    <td>monthly revised</td>
    <td>init_db_test_findMissing_batch.csh -f monthly_revised</td>
    <td>2220Z</td>
    <td>db_test_findMissing_monthly_revised.log</td>
  </tr>
  <tr>
    <td>seasonal</td>
    <td>init_db_test_findMissing_batch.csh -f seasonal</td>
    <td>2230Z</td>
    <td>db_test_findMissing_seasonal.log</td>
  </tr>
</table>

#### Examples from the test account on CF

##### ERF - 22 UTC every night

    00 22 * * * /situation/bin/flagrun.pl CPCTEST "/cpc/prod_tst/mcharles/sandboxes/verif/trunk/scripts/init_db_test_findMissing_batch.csh -f ERF -loglevel error -email > /cpc/prod_tst/mcharles/sandboxes/verif/trunk/logs/db_test_findMissing_ERF.log 2>&1"

##### monthly - 10 UTC on the 4th of every month

    10 22 4 * * /situation/bin/flagrun.pl CPCTEST "/cpc/prod_tst/mcharles/sandboxes/verif/trunk/scripts/init_db_test_findMissing_batch.csh -f monthly -loglevel error -email > /cpc/prod_tst/mcharles/sandboxes/verif/trunk/logs/db_test_findMissing_monthly.log 2>&1"

##### monthly revised - 10:10 UTC on the 4th of every month

    20 22 4 * * /situation/bin/flagrun.pl CPCTEST "/cpc/prod_tst/mcharles/sandboxes/verif/trunk/scripts/init_db_test_findMissing_batch.csh -f monthly_revised -loglevel error -email > /cpc/prod_tst/mcharles/sandboxes/verif/trunk/logs/db_test_findMissing_monthly_revised.log 2>&1"

##### seasonal - 10:20 UTC on the 4th of every month

    30 22 4 * * /situation/bin/flagrun.pl CPCTEST "/cpc/prod_tst/mcharles/sandboxes/verif/trunk/scripts/init_db_test_findMissing_batch.csh -f seasonal -loglevel error -email > /cpc/prod_tst/mcharles/sandboxes/verif/trunk/logs/db_test_findMissing_seasonal.log 2>&1"
