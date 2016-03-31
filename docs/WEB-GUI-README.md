# VWT Web GUI README

## Table of Contents

<!-- TOC depthFrom:2 depthTo:3 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Table of Contents](#table-of-contents)
- [Overview](#overview)
	- [Files/Directories](#filesdirectories)
	- [Page Components](#page-components)
	- [High Level Diagrams](#high-level-diagrams)
- [Using the Web GUI](#using-the-web-gui)
	- [Chart Page](#chart-page)
	- [Map Page](#map-page)
- [Making Changes to the Code](#making-changes-to-the-code)
	- [Chart Page](#chart-page)
	- [Map Page](#map-page)

<!-- /TOC -->

## Overview

The VWT Web GUI is comprised of PHP and HTML (page content), CSS (look & feel), and Javascript (dynamic portions of the page and chart/map plotting). The code for all parts of the page is found under the `web` directory under the VWT main directory.

This web directory gets packaged by the Ant tasks `compile_web_tool` and `package_web_dir` to make it easier to deploy the VWT web pages on any server. Once placed somewhere under the Apache Document Root on a server, navigating to the root of this web directory will initialize the main VWT Web GUI.

### Files/Directories

The main web directory is broken down as follows:

* `index.php` – Main page – navigate here for the VWT itself
* `admin` – Contains admin pages, including working with the databases and adding news items
* `images` – Contains any images that can be found on the VWT web pages
* `include` – Contains PHP files that are included (embedded) in other pages of the VWT
* `library` – Contains prepackaged and custom Javascript files that contain common functions
* `styles` – Contains CSS files used to style the VWT pages

The `index.php` file serves as the home page of the VWT. Here is a high level overview of what this file does:

1. Imports all necessary Javascript functions and the jQuery libraries
2. Sets up all dynamic functionality, including popup calendars, dynamic forms, etc.
3. Sets up the outside container that the Map, Chart, and Tutorial Pages are embedded in
4. Includes (embeds) the desired page

### Page Components

The VWT Web GUI is comprised of panels, which are basically defined as white boxes containing specific functionality.

The VWT Web GUI is divided into several distinct pages: Chart, Map, and the Tutorial. The Chart page is used to create a chart-representation of a verification score, including timeseries and reliability diagrams. The Map page is used to create a map-representation of a verification score. The Tutorial page contains tutorials and information about the tool.

### High Level Diagrams

Here are high level process flow diagrams for the VWT pages:

* [Chart Page](https://docs.google.com/a/noaa.gov/drawings/d/1IeRezqS7tJJDRo2FqQbdH4ZJQ-uo0J_NZrs34pWzxPY/edit)

* [Map Page](https://docs.google.com/a/noaa.gov/drawings/d/1_kYfmIhFgDm0dK6jhXKU5KuYEP8ioP0T6453jgLdNxg/edit)

Here are overviews of the panels contained on the VWT pages:

* [Chart Page](https://docs.google.com/a/noaa.gov/drawings/d/1W7HOSKgJysml7HXlRzDVTYQG7Dp8FiJU-txcVxEq6Es/edit)

* [Map Page](https://docs.google.com/a/noaa.gov/drawings/d/1ucm2azKhUIf3-6HOuKfMEc2m7Wcw0c2ELFTCbmIka20/edit)

**<span style='color: #D00'>THIS INFORMATION NEEDS TO BE UPDATED</span>**

## Using the Web GUI

### Chart Page

Follow these steps to generate verification results (see the [Chart Page Panels Overview](https://docs.google.com/a/noaa.gov/drawings/d/1W7HOSKgJysml7HXlRzDVTYQG7Dp8FiJU-txcVxEq6Es/edit) for help locating a panel):

#### Step 1 – Select options

Select the desired options in the Settings Panel, from the top down.

*Some options are dependent on others, so making a certain selection may change the available options.*

#### Step 2 – Select region(s) to verify in

By default, all CONUS regions will be included in the verification. If you want to verify in one or more specific regions, click them in the map in the Regions Panel.

You can revert to all CONUS regions (unselecting all currently selected regions) by clicking the "Revert to CONUS" button in the Regions Panel.

You can change between region type (Climate Regions, States, or Climate Divisions) using the tabs at the top of the Regions Panel.

*The available region types depends on the data format selected in the Settings Panel.*

#### Step 3 – Click Get Scores button

Once you’ve made your settings and region selections, click the Get scores button on the bottom left of the Settings Panel. Generating scores can take up to a minute or two for long selections (more than a year of forecasts). Once completed, a message will be displayed at the bottom of the Settings Panel informing you that you can scroll down for the results.

The results will be displayed in the Results Panel

Any warnings or errors related to generating the verification score will be displayed in the Error Panel.

The Info Panel will contain a summary of the results, information about reading the results, information about how the score was calculated, etc.

**<span style='color: #D00'>INFO PANEL WILL BE COMPLETED IN v2.1</span>**

### Map Page

Follow these steps to generate verification results (see the [Map Page Panels Overview](https://docs.google.com/a/noaa.gov/drawings/d/1ucm2azKhUIf3-6HOuKfMEc2m7Wcw0c2ELFTCbmIka20/edit) for help locating a panel):

#### Step 1 – Select options

Select the desired options in the Settings Panel, from the top down.

*Some options are dependent on others, so making a certain selection may change the available options.*

#### Step 2 – Select dates to verify over

You can choose dates 3 different ways:

1. By date range
2. By months/seasons and years
3. By climate phenomena

You can change the method of date selection using the tabs above the Dates Valid Panel.

#### Step 3 – Click Get Scores button

Once you’ve made your settings and region selections, click the Get scores button on the bottom left of the Settings Panel. Generating scores can take up to a minute or two for long selections (more than a year of forecasts). Once completed, a message will be displayed at the bottom of the Settings Panel informing you that you can scroll down for the results.

The results will be displayed in the Results Panel

Any warnings or errors related to generating the verification score will be displayed in the Error Panel.

The Info Panel will contain a summary of the results, information about reading the results, information about how the score was calculated, etc.

**<span style='color: #D00'>INFO PANEL WILL BE COMPLETED IN v2.1</span>**

## Making Changes to the Code

### Chart Page

* **Overview Panel **– Included in [index.php](https://svn-gburg/cpc-trac/projects/Verif_System/browser/trunk/web/index.php?rev=4307&marks=529#L525), content in [include/content_overviewPanel.php](https://svn-gburg/cpc-trac/projects/Verif_System/browser/trunk/web/include/content_overviewPanel.php?rev=4001)

* **Overview Panel More Info Link – **Content in [include/content_overviewPanel.php](https://svn-gburg/cpc-trac/projects/Verif_System/browser/trunk/web/include/content_overviewPanel.php?rev=4001&marks=13-39)

* **Page Tabs (Chart, Map, Tutorial) – **Defined in [index.php](https://svn-gburg/cpc-trac/projects/Verif_System/browser/trunk/web/index.php?rev=4307&marks=534-538#L533)

* **Settings Panel – **Included in [include/chart.php](http://www.google.com/url?q=https%3A%2F%2Fsvn-gburg%2Fcpc-trac%2Fprojects%2FVerif_System%2Fbrowser%2Ftrunk%2Fweb%2Finclude%2Fchart.php%3Frev%3D4307%26marks%3D14%23L10&sa=D&sntz=1&usg=AFQjCNHQbMQMSHdt8Obz6-11mNJZJzN1Nw), content in [include/settingsForm.php](https://svn-gburg/cpc-trac/projects/Verif_System/browser/trunk/web/include/settingsForm.php?rev=4001)

* **Regions Panel Tabs – **Defined in [include/chart.php](http://www.google.com/url?q=https%3A%2F%2Fsvn-gburg%2Fcpc-trac%2Fprojects%2FVerif_System%2Fbrowser%2Ftrunk%2Fweb%2Finclude%2Fchart.php%3Frev%3D4307%26marks%3D17-21%23L16&sa=D&sntz=1&usg=AFQjCNFvmvtuQHsSkeoZuXXlRETqyLHg2w)

* **Regions Panel – **Defined in [include/chart.php](https://svn-gburg/cpc-trac/projects/Verif_System/browser/trunk/web/include/chart.php?rev=4307&marks=23-31#L22)

* **Results Panel – **Defined in [include/chart.php](https://svn-gburg/cpc-trac/projects/Verif_System/browser/trunk/web/include/chart.php?rev=4307&marks=34-51#L33)

* **Error Panel – **Defined in [include/chart.php](https://svn-gburg/cpc-trac/projects/Verif_System/browser/trunk/web/include/chart.php?rev=4001&marks=53-57#L52), updated by methods in [source/.../qc/Log.java](https://svn-gburg/cpc-trac/projects/Verif_System/browser/trunk/source/gov/noaa/ncep/cpc/qc/Log.java?rev=4001)

* **Info Panel – **Defined in [include/chart.php](https://svn-gburg/cpc-trac/projects/Verif_System/browser/trunk/web/include/chart.php?rev=4001&marks=59-63#L58)

* **Print Settings Panel – **Defined in [include/chart.php](https://svn-gburg/cpc-trac/projects/Verif_System/browser/trunk/web/include/chart.php?rev=4001&marks=65-68#L64)

### Map Page

* **Overview Panel **– Included in *[index.ph*p](https://svn-gburg/cpc-trac/projects/Verif_System/browser/trunk/web/index.php?rev=4307&marks=529#L525), content in *[include/content_overviewPanel.ph*p](https://svn-gburg/cpc-trac/projects/Verif_System/browser/trunk/web/include/content_overviewPanel.php?rev=4001)

* **Overview Panel More Info Link – **Content in *[include/content_overviewPanel.ph*p](https://svn-gburg/cpc-trac/projects/Verif_System/browser/trunk/web/include/content_overviewPanel.php?rev=4001&marks=13-39)

* **Page Tabs (Chart, Map, Tutorial) – **Defined in *[index.ph*p](https://svn-gburg/cpc-trac/projects/Verif_System/browser/trunk/web/index.php?rev=4307&marks=534-538#L533)

* **Settings Panel – **Included in *[include/map.ph*p](https://svn-gburg/cpc-trac/projects/Verif_System/browser/trunk/web/include/map.php?rev=4001&marks=8-12#L7), content in *[include/settingsForm.ph*p](https://svn-gburg/cpc-trac/projects/Verif_System/browser/trunk/web/include/settingsForm.php?rev=4001)

* **Dates Valid Panel Tabs – **Defined in *[include/map.ph*p](https://svn-gburg/cpc-trac/projects/Verif_System/browser/trunk/web/include/map.php?rev=4001&marks=15-21#L14)

* **Dates Valid Panel – **Defined in *[include/map.ph*p](https://svn-gburg/cpc-trac/projects/Verif_System/browser/trunk/web/include/map.php?rev=4001&marks=23-27#L22)

* **Results Panel – **Defined in *[include/map.ph*p](https://svn-gburg/cpc-trac/projects/Verif_System/browser/trunk/web/include/map.php?rev=4001&marks=30-48#L29)

* **Error Panel – **Defined in *[include/map.ph*p](https://svn-gburg/cpc-trac/projects/Verif_System/browser/trunk/web/include/map.php?rev=4001&marks=52-56#L51), updated by methods in *[source/.../qc/Log.jav*a](https://svn-gburg/cpc-trac/projects/Verif_System/browser/trunk/source/gov/noaa/ncep/cpc/qc/Log.java?rev=4001)

* **Info Panel – **Defined in *[include/map.ph*p](https://svn-gburg/cpc-trac/projects/Verif_System/browser/trunk/web/include/map.php?rev=4001&marks=58-62#L57)

* **Print Settings Panel – **Defined in *[include/map.ph*p](https://svn-gburg/cpc-trac/projects/Verif_System/browser/trunk/web/include/map.php?rev=4001&marks=64-67#L63)

**<span style='color: #D00'>THIS INFORMATION NEEDS TO BE UPDATED</span>**
