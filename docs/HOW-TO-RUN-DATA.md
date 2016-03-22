# VWT Data – How to Run

> Written by [Mike Charles](mailto:mike.charles@noaa.gov)

## Table of Contents

<!-- TOC depthFrom:2 depthTo:3 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Table of Contents](#table-of-contents)
- [Background](#background)
- [Reasons to Run](#reasons-to-run)
	- [Verification System reports failing QC](#verification-system-reports-failing-qc)
	- [The Missing Data Script running on cron reports missing data](#the-missing-data-script-running-on-cron-reports-missing-data)
- [Quick Facts About this Software](#quick-facts-about-this-software)
	- [Operational Status](#operational-status)
	- [Development](#development)
- [Requirements](#requirements)
- [Database Information](#database-information)

<!-- /TOC -->

## Background

The Verification System uses a MySQL database to store the necessary forecasts, observations, climatologies, and reference data to generate verification scores. The data is imported using a set of Perl scripts that can run independently of the Verification System itself.

## Reasons to Run

### Verification System reports failing QC

Data is probably missing for one or more dates for a given forecast. See the [Data Handbook section on checking for missing data](https://docs.google.com/a/noaa.gov/document/d/1wnD4myU63NSj0HVDrtVeDeDxzeuF7S2YPy3iJ9Cff1M/edit#heading=h.unylidy9nhi5).

### The Missing Data Script running on cron reports missing data

First, discuss this with the data owner, which can be found in the [Data Settings Google Doc](https://docs.google.com/a/noaa.gov/spreadsheet/ccc?key=0Ao4v21vizXv0dE9fdkE0ZjZjUDJzNW1vWVhMbGY1M0E&usp=sharing). Once they’ve fixed the problem and regenerated the data, you can import the data again, referring to the [Data Handbook section on importing data from a single forecast](https://docs.google.com/a/noaa.gov/document/d/1wnD4myU63NSj0HVDrtVeDeDxzeuF7S2YPy3iJ9Cff1M/edit#heading=h.911tfy7ijoi).

## Quick Facts About this Software

### Operational Status

<table>
  <tr>
    <td>Operational machine</td>
    <td>Compute Farm (vm-lnx-cpccf1 or vm-lnx-cpccf7)</td>
  </tr>
  <tr>
    <td>Operational account</td>
    <td>cpcfcst.cf</td>
  </tr>
  <tr>
    <td>Process owner</td>
    <td>Mike Charles</td>
  </tr>
  <tr>
    <td>Backup process owner</td>
    <td>Adam Allgood</td>
  </tr>
  <tr>
    <td>Cron run time</td>
    <td>ERF data import: 2100z every day
LLF data import: 2110z the 4th of every month
Climate phenomena import: 2120z the 4th of every month
ERF missing data check: 2200z every day
monthly missing data check: 2210z the 4th of every month
monthly revised missing data check: 2220z the 4th of every month
seasonal missing data check: 2230z the 4th of every month</td>
  </tr>
  <tr>
    <td>Initiation script</td>
    <td>$VERIF_HOME/init_db_import_extendedRange.csh
$VERIF_HOME/init_db_import_longRange.csh
$VERIF_HOME/init_db_import_climPhenom.csh</td>
  </tr>
  <tr>
    <td>Log file or path</td>
    <td>$VERIF_HOME/logs</td>
  </tr>
</table>


### Development

<table>
  <tr>
    <td>GitLab Project</td>
    <td>https://gitlab.ncep.noaa.gov/cpc/verif-system</td>
  </tr>
  <tr>
    <td>Git Repository</td>
    <td>https://gitlab.ncep.noaa.gov/cpc/verif-system.git</td>
  </tr>
</table>

## Requirements

The VWT should have been downloaded (see the [How to Install Data document](HOW-TO-INSTALL-DATA.md)).

## Database Information

See the [Database Design document](https://docs.google.com/a/noaa.gov/document/d/1SmiM0dqyc6iBiIKlQSglWrU4XDRw184ibab9yIjsl5Y/edit)
