VWT How to Install

## Table of Contents

<!-- TOC depthFrom:2 depthTo:3 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Table of Contents](#table-of-contents)
- [This Document](#this-document)
- [Background](#background)
- [Requirements](#requirements)
	- [Command Line Direct Access Mode](#command-line-direct-access-mode)
	- [Command Line Web Services Mode](#command-line-web-services-mode)
	- [Web Tool Mode](#web-tool-mode)
- [Setting Up the Database](#setting-up-the-database)
- [Downloading the Verification System](#downloading-the-verification-system)
- [Compiling and Deploying](#compiling-and-deploying)
	- [Command Line Direct Access Mode](#command-line-direct-access-mode)
	- [Command Line Web Services Mode](#command-line-web-services-mode)
	- [Web Tool Mode](#web-tool-mode)

<!-- /TOC -->

## This Document

This document provides instructions for installing the Verification System.

## Background

The Verification System was written in such a way that it can be used for 2 different purposes. One purpose is to generate static graphics and/or ascii files on a cron. This mode (from here on known as command line mode) can be run entirely on command line. The other purpose is to be loaded as web application in a browser, allowing the user to interact with the Verification System (from here on known as the Verification Web Tool [VWT]). Each mode has slightly different requirements and installation instructions. This will be addressed in each section below.

*A particular installation of the Verification System can only be run in one mode at a time (eg. an installation compiled for running on command line must be recompiled to run as a web tool, and vice versa).*

## Requirements

The requirements vary depending on the mode the system will be run in

### Command Line Direct Access Mode

#### Server-side

* MySQL >= 4.1.22

#### Client-side

* Ant (software used to build the system)
* Write permission in the ./output subdirectory of the process
* X11 (to generate images from the command line)
* Xvfb (to generate images on cron)

### Command Line Web Services Mode

#### Server-side

* MySQL >= 4.1.22 (to serve the data)
* Tomcat >= 5.5.23 (to run the Java servlet)
* Java JRE >= 1.6 (to run the Java servlet)

#### Client-side

* Ant (software used to build the system)
* Write permission in the ./output subdirectory of the process
* X11 (to generate images from the command line)
* Xvfb (to generate images on cron)

### Web Tool Mode

*In this mode, it’s assumed that the system will be built on the server, and the client is the user running the web tool.*

#### Server-side

* MySQL >= 4.1.22 (to serve the data)
* Tomcat >= 5.5.23 (to run the Java servlet)
* Java JRE >= 1.6 (to run the Java servlet)
* Java SDK >= 1.6 (to build the system)
* PHP >= 5.0
* Apache >= 2.0

#### Client-side

* Web browser with Javascript enabled. The following browsers have been tested:
    * Mozilla Firefox 3.6.4 on Linux
    * Mozilla Firefox 3.0 on Windows
    * Firefox ? on Mac OSX
    * Safari ? on Max OSX
    * Internet Explorer

## Setting Up the Database

Refer to the [Data Handbook](https://docs.google.com/a/noaa.gov/document/d/1wnD4myU63NSj0HVDrtVeDeDxzeuF7S2YPy3iJ9Cff1M).

## Downloading the Verification System

The Verification System is located in a Git repository at the following URL:

    gitlab@gitlab.ncep.noaa.gov:cpc/verif-system.git

To get the latest version, clone the repository:

    git clone gitlab@gitlab.ncep.noaa.gov:cpc/verif-system.git

This will create a directory called verif-system containing all the Verification System code.

## Compiling and Deploying

The instructions for building the system depend on which mode you plan to run the system in. Again, there are 2 main ways of running the Verification System, on the command line and as a web application. On the command line, the Verification System can access the MySQL database both directly and using web services. When running on the CF, direct access is allowed. When running outside the CF (cpc-lw-work1 or a Linux machine), web services must be used. In summary there are 3 distinct modes of running the Verification System. The instructions for compiling and deploying follow for each mode.

### Command Line Direct Access Mode

**<span style='color: #D00'>THIS SECTION IS NOT ACCURATE YET, WILL BE COMPLETED IN v2.1</span>**

Use this mode if you’re on the CF and want to run the Verification System on the command line or on cron. Note that when you compile for this mode, you can’t use the Verification System in any other mode until you compile it specifically for that mode.

#### Step 1 – Setting up the config files

When running in Command Line Direct Access Mode, the config files `input/verif_direct_access.conf` and `input/verif_data.conf` are used. Do the following to setup these config files:

1. Copy the example config files to real config files:  

    ```sh
    cd input    cp verif_direct_access.conf.example verif_direct_access.conf    cp verif_data.conf.example verif_data.conf
    ```

2. Edit the config files, following the instructions in the file.

Here are the MySQL settings that should be used if you’re running on the CF:

* host – vm-lnx-cpccfmysql
* user – vwt_user
* password – contact Mike Charles
* db_fcst – cpc_forecasts
* db_obs – cpc_observations
* db_clim – cpc_climatologies
* db_ref – cpc_reference
* db_vwt – cpc_vwt
* dateFormat – yyyy-MM-dd

Here are the QC settings that should be used if you’re running on the CF:

* goodDataThreshold – 95
* goodScoreThreshold – 95
* goodScoreThresholdReliability – 95

Here are the email settings that should be used if you’re running on the CF:

* toEmail – first.last@noaa.gov (whoever is the process owner)
* subject – leave blank (constructed on the fly)
* fromEmail – cpc_verif@noaa.gov
* fromName – CPC Verif
* logLevel – ERROR

#### Step 2 – Compiling the system

Run the following command inside the Verification System root directory:

**ant compile_command_line_direct_access**

This will compile the Verification System and place a jar file in the ./build directory. This jar file is necessary to run the Verification System.

*The command-line tool*[ Ant](http://ant.apache.org/)* is required for this step.*

#### Step 3 – Running the system

More detailed instructions for running the system can be found in the[ Verification System README](https://docs.google.com/a/noaa.gov/document/d/1n5q2-so1wr7Rd5M6yFH1vJYJy6_QHYpQQtz9APg72Dw/edit), however here is a quick way to run the system to make sure the installation worked:

1. The Verification System needs to have the $VERIF_HOME environment variable defined to run. Set it to the path of the[ main directory](https://docs.google.com/a/noaa.gov/document/d/1c_t7Rh6hSeJ5byG8INlq4I_iG3AlFEzbfV54yQjcVZQ/edit#heading=h.830hamdjq96a) that you downloaded above.

2. The Verification System reads in settings (eg. variable, date range, score type, etc.) from an XML file in the ./input directory. Copy the quicktest settings XML file over the existing settings XML file:

**cd inputcp settings_quicktest.xml settings.xml**

1. Run the following command to run the Verification System using settings from this XML file:

**ant run_command_line_direct_access**

If you used the quicktest XML file, you should now see a timeseries image in the ./output directory.

### Command Line Web Services Mode

**<span style='color: #D00'>THIS SECTION IS NOT ACCURATE YET, WILL BE COMPLETED IN v2.1</span>**

*Use this mode if you’re on the cpc-lw-work1 or a Linux machine and want to run the Verification System on the command line or on cron. Note that when you compile for this mode, you can’t use the Verification System in any other mode until you compile it specifically for that mode.*

#### Step 1 – Setting up the config file

When running in Command Line Web Services Mode, the config files input/verif_client.conf, input/verif_server.conf, and input/verif_data.conf are used. Do the following to setup these config files:

1. Copy the example config file to a real config file:

**cd inputcp verif_client.conf.example verif_client.confcp verif_server.conf.example verif_server.confcp verif_data.conf.example verif_data.conf**

1. Edit the config files, following the instructions in the files.

Here are the MySQL settings in the server config file that should be used if you’re using wwwdev1.ncep.noaa.gov as the development server (which is currently the case here at CPC):

* host – localhost
* public_user – vwt_user
* public_password – contact Mike Charles
* admin_user – vwt_admin
* admin_password – contact Mike Charles
* db_fcst – cpc_forecasts
* db_obs – cpc_observations
* db_ref – cpc_reference
* db_vwt – cpc_vwt
* dateFormat – yyyy-MM-dd

Here are the QC settings that should be used if you’re running on the CF:

* goodDataThreshold – 95
* goodScoreThreshold – 95
* goodScoreThresholdReliability – 95

Here are the feedback settings that should be used if you’re running on the CF:

    * email – mike.charles@noaa.gov

Here is the URL that should be specified under the "services" section in the client config file:

[http://cpcintradev.ncep.noaa.gov/webapps/verif/services/VerificationSystemToolService](http://cpcintradev.ncep.noaa.gov/webapps/verif_first.last/services/VerificationSystemToolService)

#### Step 2 – Compiling the system

Run the following command inside the Verification System root directory:

    ant compile_command_line_web_services

This command will compile the Verification System and place client and server jar files in the ./build directory, as well as a war file. These files are necessary to run the Verification System.

This command also supports an optional argument that sets the name of the resulting WAR file:

-Dwar_file_name=[name.war]

If installing operationally on the Compute Farm, this option should not be used, which will result in the war file being named, by default, vwt.war.

*The command-line tool*[ Ant](http://ant.apache.org/)* is required for this step.*

#### Step 3 – Deploying the server-side code

In order to run the VWT in Command Line Web Services Mode, the war file must be placed on a server running[ Tomcat](http://tomcat.apache.org) 5.5 or later.

1. Go to the[ Tomcat Manager](http://cpcintradev.ncep.noaa.gov/webapps/manager/) page (get login info from Mike Charles) and see if there’s an application called "vwt". If so, then click STOP, then UNDEPLOY, in that row on the right side. If not, continue to the next step.

2. In the[ Tomcat Manager](http://cpcintradev.ncep.noaa.gov/webapps/manager/) page, click the Browse... button under WAR file to deploy

3. Select the vwt.war file created in the step above, then click Deploy.

The manager page will be refreshed and you should see a new application in the list matching the name of your .war file (without the .war).

*For Windows users, you’ll have to use WinSCP to copy the file from cpcwork1 to your Windows computer. Then you can upload the file using the Tomcat Manager.*

#### Step 4 – Running the system

More detailed instructions for running the system can be found in the[ Verification System README](https://docs.google.com/a/noaa.gov/document/d/1n5q2-so1wr7Rd5M6yFH1vJYJy6_QHYpQQtz9APg72Dw/edit), however here is a quick way to run the system to make sure the installation worked:

1. The Verification System needs to have the $VERIF_HOME environment variable defined to run. Set it to the path of the [main directory](https://docs.google.com/a/noaa.gov/document/d/1c_t7Rh6hSeJ5byG8INlq4I_iG3AlFEzbfV54yQjcVZQ/edit#heading=h.830hamdjq96a) that you downloaded above.

2. The Verification System reads in settings (eg. variable, date range, score type, etc.) from an XML file in the ./input directory. Copy the quicktest settings XML file over the existing settings XML file:

**cd inputcp settings_quicktest.xml settings.xml**

1. Run the following command to run the Verification System using settings from this XML file:

**ant run_command_line_web_services**

If you used the quicktest XML file, you should now see a timeseries image in the ./output directory.

### Web Tool Mode

Use this mode if you want to run the Verification Web Tool in a browser. Note that when you compile for this mode, you can’t use the Verification System in any other mode until you compile it specifically for that mode.

#### Step 1 – Setting up the config files

When running in Web Tool mode, the config files `input/verif_server.conf` and `input/web_settings.php` are used. Do the following to setup these config files:

1. Copy the example config files to real config files:

    ```sh
    cd input    cp verif_server.conf.example verif_server.conf    cp web_settings.example.php web_settings.php
    ```

2. Edit the config files, following the instructions in the files.

Here are the MySQL settings in the server config file that should be used if you’re using wwwdev1.ncep.noaa.gov as the development server (which is currently the case here at CPC):

* *host* – localhost
* *public_user* – vwt_user
* *public_password* – contact Mike Charles for CF installation
* *admin_user* – vwt_admin
* *admin_password* – contact Mike Charles for CF installation
* *db_fcst* – cpc_forecasts
* *db_obs* – cpc_observations
* *db_clim* – cpc_climatologies
* *db_ref* – cpc_reference
* *db_vwt* – cpc_vwt
* *dateFormat* – yyyy-MM-dd

Here are the QC settings that should be used if you’re running on the CF:

* *goodDataThreshold* – 95
* *goodScoreThreshold* – 95
* *goodScoreThresholdReliability* – 95

Here are examples for `web_settings.php`:

- servlet_url: 'http://cpcintradev/verif_mike.charles/services/VerificationSystemToolService'
- servlet_function: 'getResults'

#### Step 2 – Compiling the system

Run the following command inside the Verification System root directory:

**ant compile_web_tool**

This will compile the Verification System and place a server jar file in the ./build directory, as well as a war file and a .tar.gz file. These files are necessary to run the Verification System.

This command also supports an optional argument that sets the name of the resulting WAR file:

-Dwar_file_name=[name.war]

If installing operationally on the Compute Farm, this option should not be used, which will result in the war file being named, by default, *vwt.war*.

*The command-line tool [Ant](http://ant.apache.org/) is required for this step.*

#### Step 3 – Deploying the server-side Java code

In order to run the VWT in Web Tool mode, the war file must be placed on a server running [Tomcat](http://tomcat.apache.org) 5.5 or later.

1. Go to the[ Tomcat Manager](http://cpcintradev.ncep.noaa.gov/webapps/manager/) page (get login info from Mike Charles) and see if there’s an application called "vwt". If so, then click STOP, then UNDEPLOY, in that row on the right side. If not, continue to the next step.
2. Click the Browse... button under WAR file to deploy
3. Select the *vwt.war *file created in the step above, then click Deploy.

The manager page will be refreshed and you should see a new application called "vwt".

*For Windows users, you’ll have to use WinSCP to copy the file from cpcwork1 to your Windows computer. Then you can upload the file using the Tomcat Manager.*

#### Step 4 – Deploying the server-side webpage files

In order to view the VWT in a web browser, the webpage files need to be placed on a server running an Apache web server.

1. In order to set up the webpage files on the web server, you need to copy the .tar.gz file to the web server. Assuming this installation is internal:

        scp build/vwt.tar.gz <user>@wwwdev1.ncep.noaa.gov:/usr2/cpc/cpcintradev/htdocs/apps

  where user is a user account with write permission to the web area (/usr2/cpc/cpcintradev/htdocs)

2. Log into the web server:

        ssh user@wwwdev1.ncep.noaa.gov

3. Change into the web area:

        cd /usr2/cpc/cpcintradev/htdocs/apps

4. Unpackage the webpage files:

        tar -xzf vwt.tar.gz

You should see a new directory </path/to/webroot/vwt>

The VWT itself will now be available at[ http://cpcintradev.ncep.noaa.gov/apps/vwt](http://cpcintradev.ncep.noaa.gov/vwt/admin)
