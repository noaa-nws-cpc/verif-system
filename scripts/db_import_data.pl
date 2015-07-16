#!/usr/bin/perl

=head1 NAME

db_import_data - A Perl script to import ascii forecast and observation data into MySQL

=head1 SYNOPSIS

 db_import_data.pl [OPTIONS]

 Required arguments:
   General:
     -d, -datatype         Type of data being processed                forecast or observation
     -v, -variable         variable to process                         temp, tmax, tmin or precip
     -a, -avewindow        averaging window with appended units        05d, 07d, 01m, 03m
     -g, -spatialtype      type of spatial data                        cd, stn, grid2deg
     -s, -startdate        date to begin processing                    yyyymmdd (yyyymm for longRange)
     -e, -enddate          date to begin end processing                yyyymmdd (yyyymm for longRange)
   datatype=forecast:
     -f, -fcstsource       source of the forecast                      manual, auto, tool
     -l, -leadtime         lead time with appended units               08d, 11d, 02m...14m
   fcstsource=tool:
     -t, -tool             Specific tool to process                    kleinCat, analogs...
     -m, -model            Specific model tool is based on             gfs, gefs, cmce, ecm, ecens, cdcgfs, naefs
     -c, -cycle            Specific model cycle                        00z, 06z, 12z, 18z, al

   Note: -cycle not required for model = (obs, manual, auto, or cdcgfs)

 Optional arguments:
   -h, -help         Print this help message
   -validdate        Assume dates are when the forecast is valid, not issued
   -destroy          Delete the entire database table before importing
   -convert          If -spatialtype is set to stn, convert to cd before import
   -skip-header      Skip the header line in the input text file
   -loglevel         Sets the log4perl logging level (DEBUG, INFO, WARN,ERROR, FATAL)
   -logfile          specifies a log file name, instead of printing to the screen
   -email            email any errors to the process owner

=head1 DESCRIPTION

This script requires arguments that will allow it to narrow down a specific dataset to
import. When I<datatype> is set to "forecast", then the I<fcstsource> and I<leadtime> arguments
must be set. When I<fcstsource> is set to "tool", then the I<tool>, I<model>, and I<cycle> arguments must be set.

=head1 SEE ALSO

L<db_import_daily>

=cut

my $HOME;
BEGIN {
	#--------------------------------------------------------------------
	# Check for VERIF_HOME environment variable
	#
	if ($ENV{'VERIF_HOME'}) {
		$HOME = $ENV{'VERIF_HOME'};
	} else {
		print "[error] VERIF_HOME environment variable not set, please set it and rerun\n";
		exit;
	}
	# Hide warnings from 'eval'
	$SIG{__WARN__} = sub {};
}

use Getopt::Long;
use Switch;
use DBI;
use Time::Local;
use Date::Manip;
use lib "$HOME/library/perl";
use ConfigFile;
use Month;
use Pod::Usage;
use Log::Log4perl;
#use Log::Dispatch::Email::MailSend;
use strict;
use warnings;

#--------------------------------------------------------------------
# Get command line arguments
#
my (%dataSettings, @dataSettings, $startDate, $endDate, $validDateOpt, $destroyOpt, %args, $help, $headerLine, %data, $skipHeaderOpt);
GetOptions ('datatype|d=s'		=> \$args{dataType},
			'variable|v=s'		=> \$args{variable},
			'fcstsource|f=s'	=> \$args{fcstSource},
			'model|m=s'			=> \$args{model},
			'tool|t=s'			=> \$args{tool},
			'cycle|c=s'			=> \$args{cycle},
			'leadtime|l=s'		=> \$args{leadTime},
			'avewindow|a=s'		=> \$args{aveWindow},
			'spatialtype|g=s'	=> \$args{spatialType},
			'startdate|s=s'		=> \$startDate,
			'enddate|e=s'		=> \$endDate,
			'skip-header'		=> \$skipHeaderOpt,
			'destroy'       	=> \$destroyOpt,
			'validdate'			=> \$validDateOpt,
			'loglevel=s'		=> \$args{logLevel},
			'logfile=s'			=> \$args{logFile},
			'email'				=> \$args{emailOpt},
			'help|h'			=> \$help
);

#--------------------------------------------------------------------
# If the user wants help, print the usage
#
if ($help) {
	pod2usage(1);
}

#--------------------------------------------------------------------
# Validate arguments
#--------------------------------------------------------------------
validateArgs(%args);

#--------------------------------------------------------------------
# Set up log4perl logger
#--------------------------------------------------------------------
if ($args{logLevel}) {
	# Convert the given log level to ALL CAPS
	$args{logLevel} = uc($args{logLevel});
} else {
	# Default to INFO
	$args{logLevel} = "INFO";
}
# Set up the logger configuration for just the file appender (if necessary)
my $loggerConfig;
if (defined($args{logFile})) {
	# Remove existing logfile
	if (defined($args{logFile})) { unlink $args{logFile};}
	# Define logger config string
	$loggerConfig = "
log4perl.rootLogger                             = $args{logLevel}, Screen, File
log4perl.appender.File                          = Log::Log4perl::Appender::File
log4perl.appender.File.filename                 = $args{logFile}
log4perl.appender.File.layout                   = Log::Log4perl::Layout::PatternLayout
log4perl.appender.File.layout.ConversionPattern = \%m\%n
log4perl.appender.File.Threshold                = $args{logLevel}
";
} else {
	$loggerConfig = "log4perl.rootLogger = $args{logLevel}, Screen";
}
# Set up the logger config string for any other appenders
$loggerConfig = $loggerConfig . "
log4perl.appender.Screen                           = Log::Log4perl::Appender::Screen
log4perl.appender.Screen.layout                    = Log::Log4perl::Layout::PatternLayout
#log4perl.appender.Screen.layout.ConversionPattern = [\%d] ( \%C L\%L ) \%p - \%m\%n
log4perl.appender.Screen.layout.ConversionPattern  = \%m\%n
#log4perl.appender.Screen.Threshold                 = $args{logLevel}
#log4perl.category                = ERROR, Mailer
#log4perl.appender.Mailer         = Log::Dispatch::Email::MailSend
#log4perl.appender.Mailer.to      = \$mailSettings{processOwnerEmail}
#log4perl.appender.Mailer.subject = \$mailSettings{subject}
#log4perl.appender.Mailer.layout  = SimpleLayout
";
# Initialize the logger
Log::Log4perl::init( \$loggerConfig );
my $logger = Log::Log4perl::get_logger("");

#--------------------------------------------------------------------
# Settings
#
# Ensure we're using all UTC times
$ENV{TZ}='UTC';
# Read in settings from a configuration file
my $configFile="$HOME/input/verif_data.conf";
my %settings = load_settings($configFile,"multi");
# Extract only the MySQL settings
my %mysqlSettings = %{$settings{mysql}};
# Set the rest of the MySQL settings
$mysqlSettings{'database'} = mysql_getDatabaseName();
#$mysqlSettings{'database'} = mysql_getDatabaseName() . "_testing";
$mysqlSettings{'settingsTable'} = "$mysqlSettings{db_ref}.dataSettings";
$mysqlSettings{'dataTable'} = mysql_getDataTableName();
# Determine fcstType based on the leadTime
if ($args{'aveWindow'} eq '01d') {
	$args{fcstType} = "probabilisticHazards";
} elsif ($args{'aveWindow'} =~ /m$/) {
	$args{fcstType} = "longRange";
} elsif ($args{'aveWindow'} =~ /d$/) {
	$args{fcstType} = "extendedRange";
}

# Email settings (for emailing a report)
#
# my %mailSettings;
# $mailSettings{processOwnerEmail} = "mike.charles\@noaa.gov"; # Use a '\' in front of the '@'
# $mailSettings{subject}           = "[Verification] Found missing data - $args{dataType} - $args{fcstType} - $args{spatialType}";
# $mailSettings{fromEmail}         = "cpc_VerifSystem\@noaa.gov";
# $mailSettings{fromName}          = "CPC VerifSystem";

# Other
my @mysqlColumns;
if ($args{'dataType'} eq "forecast") {
	if ($args{'fcstType'} =~ /extendedRange|probabilisticHazards/) {
		@mysqlColumns = ('id','cdf','prob_below','prob_normal','prob_above');
	} elsif ($args{'fcstType'} eq "longRange") {
		@mysqlColumns = ('id','cdf','prob_below','prob_normal','prob_above','skill','standardAnomaly');
	}
} elsif ($args{'dataType'} eq "observation") {
	@mysqlColumns = ('id','category');
}

#--------------------------------------------------------------------
# If this is an "observation" run and validdate is set, remove
# validdate, since dates are already valid for observations.
#
if ($args{'dataType'} eq "observation") {
	undef $validDateOpt;
}

#--------------------------------------------------------------------
# Print diagnostic information
#
# Get the current date/time
my $currentTime = &UnixDate("today",'%T %Y-%m-%d');
# Create list of options if any are set
my $optionsSet;
if ($validDateOpt)   { $optionsSet = $optionsSet . "  -validdate   Start and end dates are assumed to be valid dates, not issued dates\n"; }
if ($destroyOpt)     { $optionsSet = $optionsSet . "  -destroy     The entire database table will be wiped before importing!\n"; }
if ($args{logLevel}) { $optionsSet = $optionsSet . "  -loglevel      $args{logLevel}\n"; }
if ($args{emailOpt}) { $optionsSet = $optionsSet . "  -email\n"; }

$logger->info("
--------------------------
- Database Import Script -
--------------------------

  Program started at $currentTime

- Settings -

  Data type:    $args{dataType}
  Variable:     $args{variable}
  Source:       $args{fcstSource}
  Lead time:    $args{leadTime}
  Ave window:   $args{aveWindow}
  Spatial type: $args{spatialType}
");

if ($optionsSet) {
	$logger->info("
- Options set -

$optionsSet");
}

$logger->info("
- MySQL info -

  Host:     $mysqlSettings{host}
  User:     $mysqlSettings{user}
  Database: $mysqlSettings{database}
  Table:    $mysqlSettings{dataTable}

- Making MySQL connection -

");

#--------------------------------------------------------------------
# Make a connection to the database
#
# Connect to MySQL server
my $db = DBI->connect("DBI:mysql:$mysqlSettings{database};host=$mysqlSettings{host}",$mysqlSettings{user},$mysqlSettings{password});
unless ($db) {
	$logger->fatal("  Cannot connect to the MySQL server: $DBI::errstr\n");
	exit;
}
$logger->info("  Successfully connected to the MySQL server...\n");
# Connect to the database
if (!$mysqlSettings{database}) {
	$logger->fatal("  There is no database specified, check your -datatype flag...\n");
	exit;
} else {
	# Try to select the database
	unless($db->do("use $mysqlSettings{database}")) {
		$logger->fatal("  Cannot connect to the MySQL database $mysqlSettings{database}: $DBI::errstr\n");
		exit;
	};
}
#--------------------------------------------------------------------
# Ensure the required data table exists
#
if (mysql_dataTableExists()) {
	$logger->info("  MySQL table \'$mysqlSettings{'dataTable'}\' exists\n");
} else {
	$logger->fatal("  MySQL table \'$mysqlSettings{'dataTable'}\' does not exist, exiting...\n");
	exit;
}

#--------------------------------------------------------------------
# If the "destroy" option is set, truncate the database table
#
if ($destroyOpt) {
	mysql_wipeTable($mysqlSettings{'dataTable'});
}

#--------------------------------------------------------------------
# Get the data settings for this run from the dataSettings MySQL table
#
unless (mysql_getDataSettings()) {
	$logger->fatal("  No match found in the MySQL table '$mysqlSettings{'settingsTable'}' for the provided arguments!\n");
	exit;
}

$logger->info("\n- Beginning text file processing -\n\n");

#--------------------------------------------------------------------
# Print information about the columns being obtained
#
my @columnList = @dataSettings{grep /column_.*/, keys( %args )};

#--------------------------------------------------------------------
# Convert user-given valid dates to issued dates, since this program
# uses issued dates internally, but it's easier for a user to give
# a valid date (like today's date), rather than figuring out what
# date to put if they want to insert the latest (today's) data.
#
# Convert user-given start/end dates into machine dates
#
# Get machine dates

# AA --------------- Account for monthly and seasonal forecasts --------------- AA
#    Check -avewindow to see if forecast is monthly or seasonal.
#    We are expecting -avewindow to be in an integer format with a single alphabetical character appended to the
#    end to represent a time interval (e.g., 05d for 5 days, 03m for 3 months).
#    Quick if to get at monthly/seasonal forecasts... should extend this to account for other units or bad input.

my $nleadMos = 0;  # Declare in this scope to use inside date loop.

my ($sdate1, $sdate2, $dateInt);
if ($args{'aveWindow'} =~ /m/) {
	# Assume $startDate and $endDate are in YYYYMM format!
	# Could code a check, but it would break after the year 9999.
	my $startyr = substr($startDate, 0, -2);
	my $startmo = substr($startDate, -2);
	my $endyr   = substr($endDate, 0, -2);
	my $endmo   = substr($endDate, -2);
	$sdate1     = Month->new($startmo, $startyr);
	$sdate2     = Month->new($endmo, $endyr);
	$dateInt    = 1;

	if($validDateOpt) {
		if($args{'leadTime'} !~ /m/) { die "Unmatched units: -leadTime and -aveWindow"; }
		$nleadMos = substr($args{'leadTime'},0,-1); # Pinch off trailing m.
		# Convert leadtime from a string to a number, if necessary
		# For example, convert 0pt5 to 0.5
		$nleadMos =~ s/pt/\./g;
		# Round nleadMos to nearest integer (e.g., if month is Feb 2010, and lead is
		# 0.5m, will assume forecast was made in Jan 2010 and set nleadMos to 1).
		$nleadMos    = int($nleadMos + 0.5);
		$sdate1      = $sdate1 - $nleadMos;
		$sdate2      = $sdate2 - $nleadMos;
	}

}
# AA -------------------------------------------------------------------------- AA
elsif ($validDateOpt) {
	$sdate1 = date_str2mach($startDate) - (substr($args{'leadTime'},0,2))*86400;
	$sdate2 = date_str2mach($endDate) - (substr($args{'leadTime'},0,2))*86400;
	$dateInt = 86400;  # Time interval, in seconds, between files (86400 secs = 1 day).
} else {
	$sdate1 = date_str2mach($startDate);
	$sdate2 = date_str2mach($endDate);
	$dateInt = 86400;
}

#--------------------------------------------------------------------
# Loop over all dates
#
for (my $date=$sdate1; $date<=$sdate2; $date=$date+$dateInt) {
	#--------------------------------------------------------------------
	# Get the date strings
	#
	# If $dataType is "forecast", then this date is issued date. Otherwise,
	# it's the valid date, even if the user gives the "validdate" option. In
	# this case, the range of dates is first shifted by the lead time, then
	# we continue as usual.
	#
	# YYYYMMDD format AA --------------- Or YYYYMM format! --------------- AA
	# Declare these in this scope.
	my $yyyy;
	my $mm;
	my $dd;
	my $windowSize = 0;
	my $dateStr;

	if(ref($date) eq 'Month') {  # We're dealing with a monthly or seasonal update
		$yyyy = $date->Year();
		$mm   = $date->Number();
		# YYYYMM format, append 01 at the end so YYYYMMDD can go into Unixdate...
		$dateStr = $yyyy.sprintf("%02d", $mm)."15"; chomp($dateStr);
		$logger->info("\n  - $dateStr -\n\n");

		# Get averaging window in days (in case needed).
		my $aveMos = substr($args{'aveWindow'},0,-1);
		my $m = $date + $nleadMos;

		for(my $i=0; $i<$aveMos; $i++) {
			$windowSize += $m->Length;
			$m++;
		}

	}
	else {  # We're dealing with a daily type update
		$dateStr = date_mach2str($date) . "\n";
		chomp($dateStr); # Remove trailing return character
		# Separate Y, M, D
		($yyyy, $mm, $dd) = date_strParse($dateStr);
		$logger->info("\n  - $dateStr -\n\n");
	}

	#--------------------------------------------------------------------
	# Delete this day from the database before importing
	#
	mysql_deleteDay($dateStr);

	#--------------------------------------------------------------------
	# Construct a full file name
	#
	my $file = file_getFileName($dateStr);
	$logger->info("    Processing $file\n");

	#--------------------------------------------------------------------
	# Open the input file
	#
	if (-e $file) {
		open('FILE', "<$file") or die "Can't open file $file - $!\n";

		#--------------------------------------------------------------------
		# Get the index of all necessary columns
		#
		# %columnIndex is a hash array where:
		#     keys   indicate the names of the text file columns
		#     values indicate the placement of each text file column, starting with zero
		#
		# For example, the new reforecast-calibrated forecast tool has a single
        # header line, unlike GEMPAK ascii data files, so the GEMPAK files need the
        # -skip-header option.
		my %columnIndex;
        if ($skipHeaderOpt) {
			$logger->debug("Skipping a header line");
			%columnIndex = file_getColumns('FILE',1);
		} else {
			$logger->debug("Not skipping a header line");
			%columnIndex = file_getColumns('FILE',0);
		}

		#--------------------------------------------------------------------
		# Switch to the appropriate database
		#
		mysql_setDatabase();

		#--------------------------------------------------------------------
		# Loop over the text file and read in each line of data and insert into the database
		#
		my $count = 0;
		while (my $line = <FILE>) {
			chomp($line); # Remove newline character
			$logger->debug("      $headerLine\n");
			$logger->debug("      $line\n");
			# Skip this line if it's empty
			next unless length($line) >= 3;
			# Split line into an array
			my @splitLine = split(' ',$line);
			my %data;
			# Loop over all MySQL columns and get data from associated text file column
			foreach my $column (@mysqlColumns) {
				# Get the text file column name
				my $fileColumn = $dataSettings{"column_$column"};
				$logger->debug("Column $column is named $fileColumn, and was found at $columnIndex{$fileColumn}\n");
				# Get the correct array index from the @splitLine array.
				if ($columnIndex{$fileColumn} >= 0) {
					$data{$column} = $splitLine[$columnIndex{$fileColumn}];
				} elsif ($column =~ m/^prob/i) {
					$data{$column} = file_getProbFromCDF($column,$data{'cdf'});
				}
			}
			# QC the data
			data_qc(\%data); # '\' means pass a 'reference' of %data to the subroutine
			# Insert data into database
			mysql_insertData($dateStr, \%data);
			$count++;
		}
		$logger->info("    Inserted $count data points into the database\n");

		#--------------------------------------------------------------------
		# Close input file
		#
		close('FILE');
	} else {
		$logger->warn("    File not found for this day...\n");
	}

	#----------------------------------------------------------------
	# Check to see what locations are missing for this day
	#
	# Get a MySQL formatted date
	my $sqlDate = date_str2mysql($dateStr);
	my $sqlQuery;
	# Construct the SQL to retrieve the list of locations with missing data
	if ($args{'dataType'} eq "forecast") {
		$sqlQuery = "SELECT fullId FROM (SELECT full.id AS fullId, partial.id AS partialID, partial.date_issued FROM $mysqlSettings{db_ref}.$args{spatialType} AS full LEFT JOIN (SELECT * FROM $mysqlSettings{'database'}.`$mysqlSettings{'dataTable'}` WHERE date_issued='$sqlDate') AS partial ON full.id=partial.id WHERE partial.id IS NULL) AS missing";
	} elsif ($args{'dataType'} eq "observation") {
		$sqlQuery = "SELECT fullId FROM (SELECT full.id AS fullId, partial.id AS partialID, partial.date_valid FROM $mysqlSettings{db_ref}.$args{spatialType} AS full LEFT JOIN (SELECT * FROM $mysqlSettings{'database'}.`$mysqlSettings{'dataTable'}` WHERE date_valid='$sqlDate') AS partial ON full.id=partial.id WHERE partial.id IS NULL) AS missing"
	}
	$logger->debug("Query to find missing data: $sqlQuery\n");
	# Execuate the SQL query
    my $results = $db->prepare($sqlQuery);
    $results->execute();
	# Get the number of locations missing
	my $numRows = $results->rows;
	# If we found any missing data, then fill
	if ($numRows == 0) {
		next;
	}
	$logger->warn("    Found $numRows missing rows, filling missing data...\n");
	# Loop over all locations
	while (my $location = $results->fetchrow_array) {
		# Insert this location with NULL values
		$data{id}              = $location;
		$data{date_issued}     = $sqlDate;
		$data{date_valid}      = $sqlDate;
		$data{prob_below}      = "NULL";
		$data{prob_normal}     = "NULL";
		$data{prob_above}      = "NULL";
		$data{category}        = "NULL";
		$data{cdf}             = "NULL";
		$data{skill}           = "NULL";
		$data{standardAnomaly} = "NULL";
		mysql_insertData($dateStr, \%data);
	}
}
# Get the current date/time
$currentTime = &UnixDate("today",'%T %Y-%m-%d');
$logger->info("\n  Program finished at $currentTime\n");

#####################################################################

=head1 SUBROUTINES

=cut

#--------------------------------------------------------------------
# Date manipulation
#

=head2 date_str2mysql(date)

Converts a date formatted as YYYYMMDD to a MySQL formatted date (YYYY-MM-DD)

	Input
		date - date string formatted as YYYYMMDD
	Output
		MySQL date string formatted as YYYY-MM-DD

=cut
sub date_str2mysql {
	my $date = $_[0];
	my ($y, $m, $d) = date_strParse($date);
	return "$y-$m-$d";
}

=head2 date_str2mach(date)

Converts a date formatted as YYYYMMDD to a machine date using Time::Local's timegm()

	Input
		date - date string formatted as YYYYMMDD
	Output
		Machine date

=cut
sub date_str2mach {
	my $date = $_[0];
	my ($y, $m, $d) = date_strParse($date);
	return timegm(0,0,0,$d,$m-1,$y-1900)
}

=head2 date_mach2str(date)

Converts a machine date formatted as YYYYMMDD to a machine date using Time::Local's gmtime()

	Input
		date - machine date
	Output
		Date string formatted as YYYYMMDD

=cut
sub date_mach2str {
	my $date = $_[0];
	my ($j, $y, $m, $d);
	my ($j,$j,$j,$d,$m,$y) = gmtime($date);
	$m = $m+1 ;
	$y = $y+1900;
	return sprintf('%4d%02d%02d',$y,$m,$d);
}

=head2 date_strParse(date)

Parses a date string, formatted as YYYYMMDD, to separate year, month, and day variables

	Input
		date - date string formatted as YYYYMMDD
	Output
		Array (year, month, day)

=cut
sub date_strParse {
	my $date = $_[0];
	my $y = substr($date,0,4) ;
	my $m = substr($date,4,2) ;
	my $d = substr($date,6,2) ;
	return ($y, $m, $d);
}

#--------------------------------------------------------------------
# Mysql
#

=head2 mysql_getDataTableName()

Constructs a MySQL table name containing the specific data requested.

The exact table name depends on several properties of the data, including
the data type, forecast source (if the data type is "forecast"), the lead
time, etc.

	Output
		Database table name

=cut
sub mysql_getDataTableName {
	my $newFcstSource;
	my $dataTableName;
	if ($args{'dataType'} eq "forecast") {
		if ($args{'fcstSource'} eq "tool") {
			# If the model for this tool is manual, auto, or obs, then there's no cycle
			if ($args{'model'} eq "manual" or $args{'model'} eq "auto" or $args{'model'} eq "obs" or $args{model} eq "cdcgfs") {
				$newFcstSource = "$args{'tool'}_$args{'model'}";
			} else {
				$newFcstSource = "$args{'tool'}_$args{'model'}_$args{'cycle'}";
			}
		} else {
			$newFcstSource = $args{'fcstSource'};
		}
		$dataTableName =  "$args{'variable'}_${newFcstSource}_$args{'leadTime'}_$args{'aveWindow'}_$args{spatialType}";
	} elsif ($args{'dataType'} eq "observation" ) {
		$dataTableName = "$args{'variable'}_$args{'aveWindow'}_$args{'spatialType'}";
	} else {
		return "";
	}
# 	$dataTableName = "$dataTableName" . "_beta";
	return $dataTableName;
}

=head2 mysql_getDatabaseName()

Constructs a MySQL database name for the data type requested.

Currently the database will be either "forecasts" or "observations"

	Output
		Database name

=cut
sub mysql_getDatabaseName {
	if ($args{'dataType'} eq "forecast") {
		return $mysqlSettings{db_fcst};
	} elsif ($args{'dataType'} eq "observation") {
		return $mysqlSettings{db_obs};
	} else {
		return 0;
	}
}

=head2 mysql_dataTableExists()

Checks if the database table specified in $mysqlSettings{'dataTable'} exists.

	Output
		Database status:
			1 if table exists
			0 if table doesn't exist, or if there is no database connection

=cut
sub mysql_dataTableExists {
	# If there's no DB connection, return 0 immediately
	unless ($db) {
		$logger->error("No DB connection to determine dataTable existance!\n");
		return 0;
	}
	my $sqlQuery;
	if ($args{'dataType'} eq "forecast") {
		$sqlQuery = "SHOW TABLES FROM $mysqlSettings{'database'} LIKE '$mysqlSettings{'dataTable'}'";
	} elsif ($args{'dataType'} eq "observation") {
		$sqlQuery = "SHOW TABLES FROM $mysqlSettings{'database'} LIKE '$mysqlSettings{'dataTable'}'";
	}
	my $results = $db->prepare($sqlQuery);
	$results->execute();
	if ($results->rows > 0) {
		return 1;
	} else {
		return 0;
	}
}

=head2 mysql_getDataSettings()

Populates the %args hash variables with properties of the ascii forecast
or observation data files, such as file location and name, columns names, etc.

This subroutine uses the provided arguments to construct a MySQL query that
retrieves a row from the dataSettings table in the reference database. The data
in this row is inserted into the %args hash variable, and a status flag
is returned.

	Output
		Database status:
			1 if the hash variable is successfully populated
			0 if no row was found matching the given arguments

=cut
sub mysql_getDataSettings {
	my $sqlQuery;
	if ($args{'dataType'} eq "forecast") {
		$sqlQuery = "SELECT * FROM $mysqlSettings{'settingsTable'} WHERE dataType='$args{'dataType'}' AND variable='$args{'variable'}' AND fcstSource='$args{'fcstSource'}' AND fcstType='$args{'fcstType'}' AND tool='$args{'tool'}' AND model='$args{'model'}' AND spatialType='$args{'spatialType'}'";
	} elsif ($args{'dataType'} eq "observation") {
		$sqlQuery = "SELECT * FROM $mysqlSettings{'settingsTable'} WHERE dataType='$args{'dataType'}' AND variable='$args{'variable'}' AND fcstType='$args{'fcstType'}' AND spatialType='$args{'spatialType'}'";
	}
 	$logger->debug("SQL to get dataSettings: $sqlQuery\n");
	my $results = $db->prepare($sqlQuery);
	$results->execute();
	if ($results->rows  < 1) {
		return 0;
	} else {
		my $tempHash = $results->fetchrow_hashref();
		%dataSettings = %$tempHash;
		return 1;
	}
}

=head2 mysql_setDatabase()

Sets the database connection to use the appropriate database.

Currently either the I<forecasts> or I<observations> database will be selected

=cut
sub mysql_setDatabase {
	if ($args{dataType} eq "forecast") {
		$db->do("use $mysqlSettings{'database'}") or die "Can't switch to the forecasts database: $!\n";
	} elsif ($args{dataType} eq "observation") {
		$db->do("use $mysqlSettings{'database'}") or die "Can't switch to the observations database: $!\n";
	}
}

=head2 mysql_deleteDay(date)

Deletes all data from the appropriate database table where the date column
matches the provided date.

The database in question depends on the I<dataType> variable.

	Input
		date - date at which to remove data

	Output
		Database status:
			-1 if the subroutine cannot delete the data (if dataType is not set properly)

=cut
sub mysql_deleteDay {
	my $date = $_[0];
	my $sqlQuery;
	if ($args{'dataType'} eq "forecast") {
		$sqlQuery = "DELETE FROM `$mysqlSettings{'dataTable'}` WHERE date_issued='" . date_str2mysql($date) . "'";
	} elsif ($args{'dataType'} eq "observation") {
		$sqlQuery = "DELETE FROM `$mysqlSettings{'dataTable'}` WHERE date_valid='" . date_str2mysql($date) . "'";
	} else {
		return -1;
	}
	$logger->debug("SQL to get days to delete: $sqlQuery\n");
	my $results = $db->prepare($sqlQuery);
	$results->execute();
}

=head2 mysql_wipeTable(mysqlTable)

Deletes all data from the appropriate database table.

The database in question depends on the I<dataType> variable.

	Input
		mysqlTable - MySQL table to delete all rows from

=cut
sub mysql_wipeTable {
	my $mysqlTable = $_[0];
	my $sqlQuery = "TRUNCATE $mysqlTable";
	my $results = $db->do($sqlQuery);
}

=head2 mysql_insertData(date,data)

Inserts data into the appropriate database table at the given date.

	Input
		date - date of the data to insert
		data - hash variable containing data to insert

=cut
sub mysql_insertData {
	my $date = $_[0];
	my %data = %{$_[1]};
	my $mysqlDate = date_str2mysql($date);
	my $sqlQuery;
	# Forecast data
	if ($args{'dataType'} eq "forecast") {
		# Some tools don't have CDF columns
		if ($args{'tool'} eq "kleinCat") {
			$sqlQuery = "INSERT INTO `$mysqlSettings{'dataTable'}` (id, date_issued, cdf, prob_below, prob_normal, prob_above) VALUES (\'$data{'id'}\',\'$mysqlDate\',$data{'cdf'},$data{'prob_below'},$data{'prob_normal'},$data{'prob_above'})";
		# ERF data has no skill or standard anomaly
		} elsif ($args{fcstType} =~ /extendedRange|probabilisticHazards/) {
			$sqlQuery = "INSERT INTO `$mysqlSettings{'dataTable'}` (id, date_issued, prob_below, prob_normal, prob_above) VALUES (\'$data{'id'}\',\'$mysqlDate\',$data{'prob_below'},$data{'prob_normal'},$data{'prob_above'})";
		# LLF data
		} elsif ($args{fcstType} eq "longRange") {
			# Every spatialType, except grid2deg, and all fcstSources, except manual and con, have skill and standard anomaly
			if ($args{spatialType} eq "grid2deg" or $args{fcstSource} eq "manual" or $args{fcstSource} eq "con") {
				$sqlQuery = "INSERT INTO `$mysqlSettings{'dataTable'}` (id, date_issued, prob_below, prob_normal, prob_above) VALUES (\'$data{'id'}\',\'$mysqlDate\',$data{'prob_below'},$data{'prob_normal'},$data{'prob_above'})";
			} else {
				$sqlQuery = "INSERT INTO `$mysqlSettings{'dataTable'}` (id, date_issued, prob_below, prob_normal, prob_above, skill, standardAnomaly) VALUES (\'$data{'id'}\',\'$mysqlDate\',$data{'prob_below'},$data{'prob_normal'},$data{'prob_above'},$data{'skill'},$data{'standardAnomaly'})";
			}
		}
	# Observation data
	} elsif ($args{'dataType'} eq "observation") {
		$sqlQuery = "INSERT INTO `$mysqlSettings{'dataTable'}` (id, date_valid, category) VALUES (\'$data{'id'}\',\'$mysqlDate\',$data{'category'})";
	}
	$logger->debug("      Query to insert observations: $sqlQuery\n");
	# Submit query
	$db->do($sqlQuery);
}

#--------------------------------------------------------------------
# File processing
#

=head2 file_getColumns()

Gets the index of each required column in the current data file.

For each column in the @mysqlColumns array (set at the top of the script),
the associated ascii file column header (usually a GEMPAK 3 or 4 character
code) is grepped for in the ascii file header, and the position is saved in
the %columnIndex hash variable.

=cut
sub file_getColumns {
	# Settings
	my @fileColumns;
	my %columnIndex;
	# Translate MySQL column names to file column names
	foreach my $column (@mysqlColumns) {
		push(@fileColumns,$dataSettings{"column_$column"});
	}
	# Get input args
	my $fileHandle = $_[0];
	my $linesToSkip = $_[1];
	# Skip a certain number of lines
	for (my $i=0; $i<$linesToSkip; $i++) {
		<$fileHandle>;
	}
	# Repeat until you reach a non-empty line
	while ($headerLine = <$fileHandle>) {
		# If this line is at least 3 characters long, it's not empty,
		# and we'll assume its the column header line
		last if length($headerLine) >= 3;
	}
	chomp($headerLine);
	# Split this into an array of column names
	my @columnsFound = split(' ',$headerLine);
	# Get the index of each column
	foreach my $column (@fileColumns) {
		($columnIndex{$column}) = grep { $columnsFound[$_] eq $column } 0..$#columnsFound;
		if ($columnIndex{$column} eq "") {
			$columnIndex{$column} = -1;
		}
	}
	return %columnIndex;
}

=head2 file_getFileName(date)

Determines the file name of the ascii data file.

The filename is determined by the fileName column in the I<dataSettings>
table in the I<reference> database.

	Input
		date - date of the ascii data file
	Output
		Name of the ascii data file

=cut
sub file_getFileName {
	my $date = $_[0];
	# Get a number-only version of lead time and cycle
	my $leadTime = $args{'leadTime'};
	my $leadTimeNum = substr($leadTime, 0, -1);
	my $leadTimeUnit = substr($leadTime, -1, 1);
	my $cycleNum = substr($args{'cycle'}, 0, 2);
	# Get the ave window
	my $aveWindow = $args{'aveWindow'};
	my $aveWindowNum = substr($aveWindow, 0, -1);
	# Some data will use the lead start and end (ex. d08_d14 in filename)
	my $leadStart = $leadTimeNum - ($aveWindowNum - 1)/2;
	my $leadEnd   = $leadTimeNum + ($aveWindowNum - 1)/2;
	my $leadRange;
	if ($args{'aveWindow'} eq '01d') {
		$leadRange = sprintf('%s%02d',$leadTimeUnit,$leadStart,$leadTimeUnit);
	} else {
		$leadRange = sprintf('%s%02d_%s%02d',$leadTimeUnit,$leadStart,$leadTimeUnit,$leadEnd);
	}
	# Since the DB is storing the path with variables in it ($cycle, $leadTime, etc.), we
	# must use Perl's eval() function to take those strings from the DB, and convert them
	# into Perl code, so the value of the variable can be obtained. In this case, we'll
	# place the result of the path variable into $dateFormatStr to be used in the
	# UnixDate() Perl method.
	my $dateFormatStr;
	my $evalStr = "\$dateFormatStr = \"$dataSettings{'pathName'}/$dataSettings{'fileName'}\"";
	$logger->debug("Evaluation string to retrieve file name: $evalStr\n");
    eval($evalStr);
	my $fileName = &UnixDate($date,$dateFormatStr);
	# Remove excess '/'s
	$fileName =~ s/\/\//\//g;
	return $fileName;
}

=head2 file_getProbFromCDF(column,cdfVal)

Determines the forecast probabilities based solely on the CDF value.

This subroutine is called when the ascii data file contains a CDF forecast
but no probabilities.

	Input
		column - database column needing a forecast probability
		cdfVal - cdf forecast
	Output
		Forecast probability

=cut
sub file_getProbFromCDF {
	my $column = $_[0];
	my $cdfVal = $_[1];
	my $prob;
	# Get the probability just from the CDF value
	if ($cdfVal > 0.66666666667) {
		switch ($column) {
			case "prob_below"  { $prob = 0; }
			case "prob_normal" { $prob = 0; }
			case "prob_above"  { $prob = 1; }
		}
	} elsif ($cdfVal > 0.3333333333) {
		switch ($column) {
			case "prob_below"  { $prob = 0; }
			case "prob_normal" { $prob = 1; }
			case "prob_above"  { $prob = 0; }
		}
	} else {
		switch ($column) {
			case "prob_below"  { $prob = 1; }
			case "prob_normal" { $prob = 0; }
			case "prob_above"  { $prob = 0; }
		}
	}
	$logger->debug("column=$column and cdfVal=$cdfVal and prob=$prob\n");
	return $prob;
}

#--------------------------------------------------------------------
# Data manipulation
#

=head2 data_qc(data)

Applies quality control to the data hash array. The input data hash array
must be a reference, since the QC will overwrite the hash array after
applying the QC.

	Input
		data - a reference to the hash array of data to be QC'd

=cut
sub data_qc {
	# Set missing data to NULL
	if ($_[0]{'prob_below'} <= -99 || $_[0]{'prob_normal'} <= -99 || $_[0]{'prob_above'} <= -99) {
		$_[0]{'prob_below'} = "NULL";
		$_[0]{'prob_normal'} = "NULL";
		$_[0]{'prob_above'} = "NULL";
		if ($args{'fcstType'} eq "longRange") {
			$_[0]{'skill'} = "NULL";
			$_[0]{'standardAnomaly'} = "NULL";
		}
	}
	# Set observations of '0' to NULL
	if ($args{'dataType'} eq "observation" && !($_[0]{category} =~ m/1|2|3/)) {
		$_[0]{category} = "NULL";
	}
	# Convert probabilities of 0-100 to probabilities of 0-1. Here I'm just
	# summing all probabilities, and if that's greater than 1.1 (leaving 0.1
	# worth of slack for our poor probability-calculating routine), then
	# these probabilities must be 0-100
	if ($_[0]{'prob_below'}+$_[0]{'prob_normal'}+$_[0]{'prob_above'} > 1.1) {
		$_[0]{'prob_below'}   = $_[0]{'prob_below'}  / 100;
		$_[0]{'prob_normal'}  = $_[0]{'prob_normal'} / 100;
		$_[0]{'prob_above'}   = $_[0]{'prob_above'}  / 100;
	}
	# Fix negative probabilities
	#
	# See http://cpc-devtools/trac/projects/ERF/ticket/30 for more details on this bug
	if ($_[0]{'prob_below'} < 0) {
		$_[0]{'prob_normal'} = $_[0]{'prob_normal'} + $_[0]{'prob_below'};
		$_[0]{'prob_below'} = 0;
	} elsif ($_[0]{'prob_above'} < 0) {
		$_[0]{'prob_normal'} = $_[0]{'prob_normal'} + $_[0]{'prob_above'};
		$_[0]{'prob_above'} = 0;
	}
	# Force EC values to have probs of 0.3333 for all cats
	my $ecProbThresh = 0.0002;
	# If all three cats have probs within a certain threshold, set all probs to 0.3333
	if (abs($_[0]{'prob_below'}-$_[0]{'prob_normal'}) <= $ecProbThresh and
		abs($_[0]{'prob_above'}-$_[0]{'prob_normal'}) <= $ecProbThresh) {
		$_[0]{'prob_below'} = 0.3333;
		$_[0]{'prob_normal'} = 0.3333;
		$_[0]{'prob_above'} = 0.3333;
	}
	# Check the bounds on all probabilites one last time
	if (($_[0]{prob_below} < 0 || $_[0]{prob_below} > 1) || ($_[0]{prob_normal} < 0 || $_[0]{prob_normal} > 1) || ($_[0]{prob_above} < 0 || $_[0]{prob_above} > 1)) {
		$_[0]{prob_below}  = "NULL";
		$_[0]{prob_normal} = "NULL";
		$_[0]{prob_above}  = "NULL";
	}
	# Set the normal category if it's not provided
	if ($_[0]{prob_normal} == 0 and $_[0]{prob_below} != 0) {
		$_[0]{prob_normal} = 1 - ($_[0]{prob_below} + $_[0]{prob_above});
	}
}

=head2 printHash(data)

Applies quality control to the data hash array. The input data hash array
must be a reference, since the QC will overwrite the hash array after
applying the QC.

	Input
		data - a reference to the hash array of data to be QC'd

=cut
sub printHash {
	my %myHash = %{$_[0]};
	for (keys %myHash) {
		print "hash{$_} = $myHash{$_}\n";
	}
}

=head2 checkArgs(requiredArgs)

Checks to see each that element of the @requiredArgs array was set by
the user. This array should be set before running this subroutine, like
so:

	my @requiredArgs = ($dataType, $startDate, $endDate);

assuming those three variables were the required arguments.

	Input
		requiredArgs - array containing
	Output
		Argument status:
			1 if all arguments are set
			0 if one or more arguments are not set

=cut
sub checkArgs {
	my $argsGood = 1;
	foreach my $var (@_) {
		if (!defined($var)) {
			$argsGood = 0;
			last;
		}
	}
	return $argsGood;
}

=head2 validateArgs()

Validates all input arguments. Nothing is returned, the subroutine simply validates each
against a regex string, and calls pod2usage() if an invalid argument was found. This will
print the usage and exit the program.

    Input
        args - Hash array of all input arguments

=cut
sub validateArgs {
	# Retrieve the arguments passed to this subroutine
	my (%args) = @_;

	# Define an empty regex string for use below
	my $regex;

	#--------------------------------------------------------------------
	# dataType
	#--------------------------------------------------------------------
	$regex = 'observation|forecast';
	unless (defined($args{dataType}) and $args{dataType} =~ m/\b($regex)\b/) { pod2usage("\nThe -dataType option was not set properly. Must match the following regex: $regex\n"); }
	#--------------------------------------------------------------------
	# variable
	#--------------------------------------------------------------------
	$regex = 'temp|tmax|tmin|precip';
	unless (defined($args{variable}) and $args{variable} =~ m/\b($regex)\b/) { pod2usage("\nThe -variable option was not set properly. Must match the following regex: $regex\n"); }
	#--------------------------------------------------------------------
	# aveWindow
	#--------------------------------------------------------------------
	$regex = '\d{2}[md]';
	unless (defined($args{aveWindow}) and $args{aveWindow} =~ m/\b($regex)\b/) { pod2usage("\nThe -aveWindow option was not set properly. Must match the following regex: $regex\n"); }
	#--------------------------------------------------------------------
	# spatialType
	#--------------------------------------------------------------------
	$regex = 'stn|cd|grid2deg';
	unless (defined($args{spatialType}) and $args{spatialType} =~ m/\b($regex)\b/) { pod2usage("\nThe -spatialType option was not set properly. Must match the following regex: $regex\n"); }
	#--------------------------------------------------------------------
	# startDate
	#--------------------------------------------------------------------
	# If the aveWindow ends in a 'd'
	if ($args{aveWindow} =~ m/.*d$/) {
		$regex = '\d{8}';
		unless (defined($startDate) and $startDate =~ m/\b$regex\b/) { pod2usage("\nThe -startDate option was not set properly. Must match the following regex: $regex\n"); }
	# If the aveWindow ends in an 'm'
	} elsif ($args{aveWindow} =~ m/.*m$/) {
		$regex = '\d{6}';
		unless (defined($startDate) and $startDate =~ m/\b$regex\b/) { pod2usage("\nThe -startDate option was not set properly. Must match the following regex: $regex\n"); }
	}
	#--------------------------------------------------------------------
	# endDate
	#--------------------------------------------------------------------
	# If the aveWindow ends in a 'd'
	if ($args{aveWindow} =~ m/d$/) {
		$regex = '\d{8}';
		unless (defined($endDate) and $endDate =~ m/\b$regex\b/) { pod2usage("\nThe -endDate option was not set properly. Must match the following regex: $regex\n"); }
	# If the aveWindow ends in an 'm'
	} elsif ($args{aveWindow} =~ m/m$/) {
		$regex = '\d{6}';
		unless (defined($endDate) and $endDate =~ m/\b$regex\b/) { pod2usage("\nThe -endDate option was not set properly. Must match the following regex: $regex\n"); }
	}
	# Make sure endDate > startDate
	unless (compareDates($startDate,$endDate) <= 0) { pod2usage("\nThe end date provided does not come after the start date provided\n"); }

	#|||||||||||||||||||||||||| If dataType=forecast |||||||||||||||||||||||#

	if ($args{dataType} eq "forecast") {
		#--------------------------------------------------------------------
		# fcstSource
		#--------------------------------------------------------------------
		unless (defined($args{fcstSource})) { pod2usage("\nThe -fcstSource option was not defined\n"); }
		#--------------------------------------------------------------------
		# leadTime
		#--------------------------------------------------------------------
		unless (defined($args{leadTime})) { pod2usage("\nThe -leadtime option was not defined\n"); }
		# longRange
		if ($args{aveWindow} =~ m/\b\d{2}m\b/) {
			$regex = '\d{2}m|\dpt5m';
		# extendedRange or probabilisticHazards
		} elsif ($args{aveWindow} =~ m/\b\d{2}d\b/) {
			$regex = '\d{2}d';
		}
		unless ($args{leadTime} =~ m/\b($regex)\b/) { pod2usage("\nThe -leadtime option was not set properly. Make sure leadtime and avewindow end in the same character. Must match the following regex: $regex\n"); }
	
		#|||||||||||||||||||||||||| If dataType=forecast |||||||||||||||||||||||#

		if ($args{fcstSource} eq "tool") {
			#--------------------------------------------------------------------
			# tool
			#--------------------------------------------------------------------
			unless (defined($args{tool})) { pod2usage("\nThe -tool option was not defined.\n"); }
			#--------------------------------------------------------------------
			# model
			#--------------------------------------------------------------------
			unless (defined($args{model})) { pod2usage("\nThe -model option was not defined.\n"); }
			#--------------------------------------------------------------------
			# cycle
			#--------------------------------------------------------------------
			# Cycle not required for the following models:
			#   - cdcgfs
			#   - manual
			#   - auto
			unless ($args{model} =~ m/\b(cdcgfs|manual|auto)\b/) {
				$regex = '\d{2}z|al';
				unless (defined($args{cycle}) and $args{cycle} =~ m/\b($regex)\b/) { pod2usage("\nThe -cycle option was not set properly. Must match the following regex: $regex\n"); }
			}
		}
	}

	#--------------------------------------------------------------------
	# logLevel
	#--------------------------------------------------------------------
	# Since this is optional, only validate if it's defined
	if (defined($args{logLevel})) {
		$regex = 'TRACE|DEBUG|INFO|WARN|ERROR|FATAL';
		unless ($args{logLevel} =~ m/\b($regex)\b/i) { pod2usage("\nThe -loglevel option was not set properly. Must match the following regex: $regex\\n"); }
	}
}

=head2 compareDates()

Compares two dates to ensure the end date is greater than or equal to the start date.

    Input
        dateStr1 - First date in comparison
        dateStr2 - Second date in comparison
    Output
        A flag indicating the order of the two dates:
            <0 indicates that dateStr1 is earlier
            =0 indicates that the two dates are identical
            >0 indicates that dateStr2 is earlier

=cut
sub compareDates() {
    # Read in dates provided
    my $dateStr1 = $_[0];
    my $dateStr2 = $_[1];
    my $dateFormat;
    # Validate dates
    my $dateObj1;
    my $dateObj2;
    if ($dateStr1 =~ m/\b\d{8}\b/ and $dateStr2 =~ m/\b\d{8}\b/) {
        $dateFormat = "%Y%m%d";
        $dateObj1 = ParseDate($dateStr1);
    	$dateObj2 = ParseDate($dateStr2);
    } elsif ($dateStr1 =~ m/\b\d{6}\b/ and $dateStr2 =~ m/\b\d{6}\b/) {
        $dateFormat = "%Y%m";
        $dateObj1 = ParseDate($dateStr1.'15');
    	$dateObj2 = ParseDate($dateStr2.'15');
    } else {
        warn "compareDates() Cannot compare these two dates";
        return;
    }

    return Date_Cmp($dateObj1,$dateObj2);
}

