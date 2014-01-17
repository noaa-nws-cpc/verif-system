#!/usr/bin/perl

use Date::Manip;

#----------------------------------------------------------
# Settings
#
# Set environment variables
$ENV{'VERIF_HOME'} = "/export/lnx215/mcharles/Projects/sandboxes/verif_trunk";
$ENV{'DISPLAY'} = ":0.0";
# Set properties of run
$HOME = $ENV{'VERIF_HOME'};
# Ensure we're using all UTC times
$ENV{TZ}='UTC';

#----------------------------------------------------------
# Clean the work directory
#
system "rm -f $HOME/work/*";

#----------------------------------------------------------
# Write settings XML file
#
# Get dates
# 
# Note that we are verifying 4 days in the past, since the 
# 8-14 day forecasts valid for that day use observations
# ending yesterday.
$startDate_30d  = UnixDate(" 33 days ago",'%Y%m%d');
$startDate_90d  = UnixDate(" 93 days ago",'%Y%m%d');
$startDate_365d = UnixDate("368 days ago",'%Y%m%d');
$endDate = UnixDate("4 days ago",'%Y%m%d');
# Write file
makeSettingsXML();

#----------------------------------------------------------
# Run the verification code
#
system "java -jar $HOME/classes/verification.jar -f $HOME/work/settings.xml -l $HOME/input/logConfig.txt";

###########################################################
# Subroutines
###########################################################

#----------------------------------------------------------
# makeSettingsXML
#
sub makeSettingsXML {
	$xmlContent = "<?xml version=\"1.0\"?>
<data>
	<!--~~~~~~~~~~~~~~~~~~~~ D+8 Temp ~~~~~~~~~~~~~~~~~~~~-->
	<!-- Manual / Heidke / Last 30d -->
	<settings>
		<variable>temp</variable>
		<fcstSource>manual</fcstSource>
		<leadTime>08d</leadTime>
		<aveWindow>05d</aveWindow>
		<startDate>$startDate_30d</startDate>
		<endDate>$endDate</endDate>
		<regionType>climateRegion</regionType>
		<region>All</region>
		<spatialType>station</spatialType>
		<outputType>chart</outputType>
		<scoreType>heidke</scoreType>
	</settings>
	<!-- Manual / Heidke / Last 90d -->
	<settings>
		<variable>temp</variable>
		<fcstSource>manual</fcstSource>
		<leadTime>08d</leadTime>
		<aveWindow>05d</aveWindow>
		<startDate>$startDate_90d</startDate>
		<endDate>$endDate</endDate>
		<regionType>climateRegion</regionType>
		<region>All</region>
		<spatialType>station</spatialType>
		<outputType>chart</outputType>
		<scoreType>heidke</scoreType>
	</settings>
	<!-- Manual / Heidke / Last 365d -->
	<settings>
		<variable>temp</variable>
		<fcstSource>manual</fcstSource>
		<leadTime>08d</leadTime>
		<aveWindow>05d</aveWindow>
		<startDate>$startDate_365d</startDate>
		<endDate>$endDate</endDate>
		<regionType>climateRegion</regionType>
		<region>All</region>
		<spatialType>station</spatialType>
		<outputType>chart</outputType>
		<scoreType>heidke</scoreType>
	</settings>
	<!--~~~~~~~~~~~~~~~~~~~~ D+8 Precip ~~~~~~~~~~~~~~~~~~~~-->
	<!-- Manual / Heidke / Last 30d -->
	<settings>
		<variable>precip</variable>
		<fcstSource>manual</fcstSource>
		<leadTime>08d</leadTime>
		<aveWindow>05d</aveWindow>
		<startDate>$startDate_30d</startDate>
		<endDate>$endDate</endDate>
		<regionType>climateRegion</regionType>
		<region>All</region>
		<spatialType>station</spatialType>
		<outputType>chart</outputType>
		<scoreType>heidke</scoreType>
	</settings>
	<!-- Manual / Heidke / Last 90d -->
	<settings>
		<variable>precip</variable>
		<fcstSource>manual</fcstSource>
		<leadTime>08d</leadTime>
		<aveWindow>05d</aveWindow>
		<startDate>$startDate_90d</startDate>
		<endDate>$endDate</endDate>
		<regionType>climateRegion</regionType>
		<region>All</region>
		<spatialType>station</spatialType>
		<outputType>chart</outputType>
		<scoreType>heidke</scoreType>
	</settings>
	<!-- Manual / Heidke / Last 365d -->
	<settings>
		<variable>precip</variable>
		<fcstSource>manual</fcstSource>
		<leadTime>08d</leadTime>
		<aveWindow>05d</aveWindow>
		<startDate>$startDate_365d</startDate>
		<endDate>$endDate</endDate>
		<regionType>climateRegion</regionType>
		<region>All</region>
		<spatialType>station</spatialType>
		<outputType>chart</outputType>
		<scoreType>heidke</scoreType>
	</settings>
	<!--~~~~~~~~~~~~~~~~~~~~ D+11 Temp ~~~~~~~~~~~~~~~~~~~~-->
	<!-- Manual / Heidke / Last 30d -->
	<settings>
		<variable>temp</variable>
		<fcstSource>manual</fcstSource>
		<leadTime>11d</leadTime>
		<aveWindow>07d</aveWindow>
		<startDate>$startDate_30d</startDate>
		<endDate>$endDate</endDate>
		<regionType>climateRegion</regionType>
		<region>All</region>
		<spatialType>station</spatialType>
		<outputType>chart</outputType>
		<scoreType>heidke</scoreType>
	</settings>
	<!-- Manual / Heidke / Last 90d -->
	<settings>
		<variable>temp</variable>
		<fcstSource>manual</fcstSource>
		<leadTime>11d</leadTime>
		<aveWindow>07d</aveWindow>
		<startDate>$startDate_90d</startDate>
		<endDate>$endDate</endDate>
		<regionType>climateRegion</regionType>
		<region>All</region>
		<spatialType>station</spatialType>
		<outputType>chart</outputType>
		<scoreType>heidke</scoreType>
	</settings>
	<!-- Manual / Heidke / Last 365d -->
	<settings>
		<variable>temp</variable>
		<fcstSource>manual</fcstSource>
		<leadTime>11d</leadTime>
		<aveWindow>07d</aveWindow>
		<startDate>$startDate_365d</startDate>
		<endDate>$endDate</endDate>
		<regionType>climateRegion</regionType>
		<region>All</region>
		<spatialType>station</spatialType>
		<outputType>chart</outputType>
		<scoreType>heidke</scoreType>
	</settings>
	<!--~~~~~~~~~~~~~~~~~~~~ D+11 Precip ~~~~~~~~~~~~~~~~~~~~-->
	<!-- Manual / Heidke / Last 30d -->
	<settings>
		<variable>precip</variable>
		<fcstSource>manual</fcstSource>
		<leadTime>11d</leadTime>
		<aveWindow>07d</aveWindow>
		<startDate>$startDate_30d</startDate>
		<endDate>$endDate</endDate>
		<regionType>climateRegion</regionType>
		<region>All</region>
		<spatialType>station</spatialType>
		<outputType>chart</outputType>
		<scoreType>heidke</scoreType>
	</settings>
	<!-- Manual / Heidke / Last 90d -->
	<settings>
		<variable>precip</variable>
		<fcstSource>manual</fcstSource>
		<leadTime>11d</leadTime>
		<aveWindow>07d</aveWindow>
		<startDate>$startDate_90d</startDate>
		<endDate>$endDate</endDate>
		<regionType>climateRegion</regionType>
		<region>All</region>
		<spatialType>station</spatialType>
		<outputType>chart</outputType>
		<scoreType>heidke</scoreType>
	</settings>
	<!-- Manual / Heidke / Last 365d -->
	<settings>
		<variable>precip</variable>
		<fcstSource>manual</fcstSource>
		<leadTime>11d</leadTime>
		<aveWindow>07d</aveWindow>
		<startDate>$startDate_365d</startDate>
		<endDate>$endDate</endDate>
		<regionType>climateRegion</regionType>
		<region>All</region>
		<spatialType>station</spatialType>
		<outputType>chart</outputType>
		<scoreType>heidke</scoreType>
	</settings>
</data>
";
	# Write file
	open(SETTINGS,">$HOME/work/settings.xml");
	print SETTINGS $xmlContent;
	close(SETTINGS);	
}
