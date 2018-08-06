#!/usr/bin/perl

=head1 NAME

db_test_findMissing.pl - A Perl script to find missing forecast and/or obs data in the database

=head1 SYNOPSIS

 db_test_findMissing.pl [OPTIONS]

 Required arguments:
   -d, -datatype         Type of data to search for             forecast, observation
   -g, -spatialtype      Type of spatial data                   cd, stn, grid2deg
   -s, -startdate        Date (valid) to begin processing       YYYYMMDD or YYYYMM
   -e, -enddate          Date (valid) to begin end processing   YYYYMMDD or YYYYMM
   -f, -fcsttype         type of forecast (or corresponding     extendedRange, longRange
                         forecast when datatype=observation)
 Optional arguments:
   -h, -help             print this help message
   -n, -dontcountnulls   If this option is used, then rows containing NULL values will
                         *not* count as missing. Since missing ASCII data files result
                         in NULL rows being inserted into the database when the import
                         script runs, this option will will reveal when the script 
                         itself hasn't run properly.
   -tableinclude         Regexp string of what tables to include. For example,
                         '-tableinclude ^temp_.*_grid2deg$' will check all tables
                         beginning with 'temp' and ending with 'grid2deg'.
   -tableexclude         Regexp string of what tables to exclude. For example,
                         '-tableinclude ^temp_.*_grid2deg$' will check all tables
                         beginning with 'temp' and ending with 'grid2deg'.
       -logfile          specifies a log file name, instead of printing to the screen
       -email            email any errors to the process owner
   -l, -loglevel         Sets the log4perl logging level (DEBUG - least important, INFO,
                         WARN, ERROR, FATAL - most important ). Setting a threshold means
                         you'll see messages of that importance level, plus all higher levels:
                             DEBUG: shows very detailed information (like SQL queries)
                             INFO:  shows general information
                             WARN:  shows days missing a small percentage of values
                             ERROR: shows days missing a large percentage of values
                             FATAL: shows problems executing the script itself

=head1 DESCRIPTION



=head1 REQUIRES

Pod::Usage, Getopt::Long, Mysql, Time::Local, Date::Manip, Log::Log4perl

=head1 SEE ALSO


=cut

my $HOME;
BEGIN {
    #--------------------------------------------------------------------
    # Check for VERIF_HOME environment variable
    #--------------------------------------------------------------------
    if ($ENV{'VERIF_HOME'}) {
        $HOME = $ENV{'VERIF_HOME'};
    } else {
        print "[error] VERIF_HOME environment variable not set, please set it and rerun\n";
        exit;
    }
}

#--------------------------------------------------------------------
# Import modules
#--------------------------------------------------------------------
use lib "$HOME/library/perl";
use Pod::Usage;
use Getopt::Long;
use Switch;
use DBI;
use Time::Local;
use Date::Manip;
use Switch;
use Log::Log4perl;
use CPC::Config_File;
use Log::Dispatch::Email::MailSend;
use POSIX;
use strict;
use warnings;

#--------------------------------------------------------------------
# Get command line arguments
#--------------------------------------------------------------------
my %args;
GetOptions ('datatype|d=s'		=> \$args{dataType},
			'spatialtype|g=s'	=> \$args{spatialType},
			'startdate|s=s'		=> \$args{startDate},
			'enddate|e=s'		=> \$args{endDate},
			'fcsttype|f=s'		=> \$args{fcstType},
			'dontcountnulls|n'	=> \$args{dontCountNullsOpt},
			'loglevel|l=s'		=> \$args{logLevel},
			'logfile=s'			=> \$args{logFile},
			'email'				=> \$args{emailOpt},
			'tableinclude=s'	=> \$args{tableInclude},
			'tableexclude=s'	=> \$args{tableExclude},
			'help|h'			=> \$args{help}
);

#--------------------------------------------------------------------
# Read in settings from a configuration file
#--------------------------------------------------------------------
# Use load_settings() to load the settings
my $configFile="$HOME/input/verif_data.conf";
my %settings = load_settings($configFile,"multi");
# Extract separate settings sections
my %mysqlSettings = %{$settings{mysql}};
my %emailSettings = %{$settings{email}};

#--------------------------------------------------------------------
# Additional settings
#--------------------------------------------------------------------
# Define the percent of missing points to warrant logging as an error
my $errorThreshold = 75;
# Flag whether to email data owners or not upon finding missing data
my $email_data_owner_flag = 0;

#--------------------------------------------------------------------
# If the user wants help (or no args are provided), print the usage
#--------------------------------------------------------------------
if ($args{help}) {
	pod2usage();
}

# Convert log level to Upper Case
if ($args{logLevel}) {
	# Convert the given log level to ALL CAPS
	$args{logLevel} = uc($args{logLevel});
} else {
	# Default to INFO
	$args{logLevel} = "INFO";
}

#--------------------------------------------------------------------
# Validate arguments
#--------------------------------------------------------------------
validateArgs(%args);

#--------------------------------------------------------------------
# Update any settings (if necessary)
#--------------------------------------------------------------------
# Default dontCountNullsOpt to 0
if (! defined($args{dontCountNullsOpt})) {
	$args{dontCountNullsOpt} = 0;
}
# Create an email subject if necessary
unless ($emailSettings{subject}) {
	$emailSettings{subject} = "Found missing data: $args{dataType} - $args{fcstType} - $args{spatialType}";
}

#--------------------------------------------------------------------
# Set up log4perl logger
#--------------------------------------------------------------------
# Set up the logger configuration for just the file appender (if necessary)
my $loggerConfig;
# Define optional loggers (if necessary)
my %loggerConfig = (
	'log4perl.rootLogger'								=> "DEBUG, Screen",
	'log4perl.appender.Screen'							=> "Log::Log4perl::Appender::Screen",
	'log4perl.appender.Screen.layout'					=> "Log::Log4perl::Layout::PatternLayout",
	'log4perl.appender.Screen.layout.ConversionPattern'	=> "\%m\%n",
	'log4perl.appender.Screen.Threshold'				=> "$args{logLevel}"
);
# If the email option is turned on
if (defined($args{emailOpt})) {
	# Add "Mailer" to the root logger
	$loggerConfig{'log4perl.rootLogger'} .= ", Mailer";
	# Add a Mailer appender (will send out email when an ERROR-level log call occurs)
	%loggerConfig = (%loggerConfig, (
'log4perl.appender.Mailer'							=> "Log::Dispatch::Email::MailSend",
'log4perl.appender.Mailer.to'						=> "$emailSettings{toEmail}",
'log4perl.appender.Mailer.from'						=> "\"$emailSettings{fromName}\" <$emailSettings{fromEmail}>",
'log4perl.appender.Mailer.subject'					=> "$emailSettings{subject}",
'log4perl.appender.Mailer.layout'					=> "Log::Log4perl::Layout::PatternLayout",
'log4perl.appender.Mailer.layout.ConversionPattern'	=> "\%m\%n",
'log4perl.appender.Mailer.Threshold'				=> "$emailSettings{logLevel}",
'log4perl.appender.Mailer.buffered' => 1
));
}
# Initialize the logger
Log::Log4perl::init( \%loggerConfig ) or die "Cannot initialize logger: $!";
my $logger = Log::Log4perl::get_logger("");

#--------------------------------------------------------------------
# Get the current date/time
#--------------------------------------------------------------------
my $currentTime = &UnixDate("today",'%T %Z %Y-%m-%d');

#--------------------------------------------------------------------
# Settings
#--------------------------------------------------------------------
# Ensure we're using all UTC times
$ENV{TZ}='UTC';
# Set the database
if ($args{dataType} eq "forecast") {
	$mysqlSettings{database} = $mysqlSettings{db_fcst};
} elsif ($args{dataType} eq "observation") {
	$mysqlSettings{database} = $mysqlSettings{db_obs};
}

#--------------------------------------------------------------------
# Create list of options if any are set
#--------------------------------------------------------------------
my $optionsSet;
if ($args{dontCountNullsOpt})	{ $optionsSet = $optionsSet . "  -dontcountnulls\n"; }
if ($args{tableInclude})		{ $optionsSet = $optionsSet . "  -tableinclude   $args{tableInclude}\n"; }
if ($args{tableExclude})		{ $optionsSet = $optionsSet . "  -tableexclude   $args{tableExclude}\n"; }
if ($args{logLevel})			{ $optionsSet = $optionsSet . "  -loglevel       $args{logLevel}\n"; }
if ($args{emailOpt})			{ $optionsSet = $optionsSet . "  -email\n"; }

#--------------------------------------------------------------------
# Make a connection to the database
#--------------------------------------------------------------------
# Connect to MySQL server
my $db = DBI->connect("DBI:mysql:$mysqlSettings{database};host=$mysqlSettings{host}",$mysqlSettings{user},$mysqlSettings{password});

#--------------------------------------------------------------------
# Get all tables
#--------------------------------------------------------------------
my $sqlQuery;
my $aveWindowUnit;
if ($args{fcstType} eq "extendedRange") {
	$aveWindowUnit = "d";
} elsif ($args{fcstType} eq "longRange") {
	$aveWindowUnit = "m";
}
# Build query to get table list
$sqlQuery = "SHOW TABLES FROM $mysqlSettings{database} WHERE Tables_in_$mysqlSettings{database} REGEXP '.*_$args{spatialType}\$'";
if ($args{tableInclude} and $args{tableExclude}) {
	$sqlQuery .= " AND Tables_in_$mysqlSettings{database} REGEXP '$args{tableInclude}' AND Tables_in_$mysqlSettings{database} NOT REGEXP '$args{tableExclude}'";
} elsif ($args{tableInclude}) {
	$sqlQuery .= " AND Tables_in_$mysqlSettings{database} REGEXP '$args{tableInclude}'";
} elsif ($args{tableExclude}) {
	$sqlQuery .= " AND Tables_in_$mysqlSettings{database} NOT REGEXP '$args{tableExclude}'";
}
$logger->debug("Query to find all $mysqlSettings{database} tables: $sqlQuery");
# Execute the SQL query
my $results = $db->prepare($sqlQuery) ; $results->execute();
# Initialize an empty hash to store the missing days for each table
my %daysMissing    = ();
my %numMissing     = ();
my %percentMissing = ();
# Loop over all tables
while (my $table = $results->fetchrow()) {
	$logger->debug("Processing table $table");
	#--------------------------------------------------------------------
	# Determine the lead time
	#--------------------------------------------------------------------
	my $leadTime;
	my $leadTimeUnit;
	if ($args{dataType} eq "forecast") {
		$leadTime = mysql_getSettingFromTableName($table,"leadTime");
		$logger->debug("The lead time was determined from the table name to be $leadTime");
		# If the lead time has 'pt' in it, then convert to a decimal
		$leadTime =~ s/pt/\./g;
		# Get the lead time unit
		$leadTimeUnit = mysql_getSettingFromTableName($table,"leadTimeUnit");
		if ($leadTimeUnit =~ /m/) {
			$leadTimeUnit = "month";
		} elsif ($leadTimeUnit =~ /d/) {
			$leadTimeUnit = "day";
		}
	}
	#--------------------------------------------------------------------
	# Calculate epoch dates
	#--------------------------------------------------------------------
	my $epochDate;
	my $epochEnd;
	# Convert from the date string to epoch date
	if ($args{startDate} =~ m/\b\d{8}\b/) {
		$epochDate = ParseDate($args{startDate});
		$epochEnd  = ParseDate($args{endDate});
	} else {
		$epochDate = ParseDate($args{startDate}.'15');
		$epochEnd  = ParseDate($args{endDate}.'15');
	}
	# For forecasts, shift the date given (valid date) to the issued date
	# by subtracting the lead time
	if ($args{dataType} eq "forecast") {
		$logger->debug("Valid date: $epochDate");
		$logger->debug("Lead time: $leadTime ($leadTimeUnit)");
		# Round leadTime up to integer - for example, revised monthly has as lead of
		# 0pt5, but the issued is still the month before the valid date, and since
		# we're only concerned about YYYYMM, we'll just make the lead time 01m when
		# calculating the issued date.
		my $leadTimeRoundedUp = ceil($leadTime);
		$epochDate = DateCalc($epochDate, " - $leadTimeRoundedUp $leadTimeUnit");
		$logger->debug("Issued date: $epochDate");
		$epochEnd  = DateCalc($epochEnd, " - $leadTimeRoundedUp $leadTimeUnit");
	}

	#--------------------------------------------------------------------
	# Loop over all days
	#--------------------------------------------------------------------
	# Temporary arrays to store a single table's information
	my @tempDaysArray    = (); # Date string
	my @tempNumArray     = (); # Number missing
	my @tempPercentArray = (); # Percent missing
	# Loop over all days
	while ($epochDate le $epochEnd) {
		# Get an SQL-formatted date
		my $sqlDate;
		my $sqlDateStr;
		if ($args{fcstType} eq "extendedRange") {
			$logger->debug("Getting sqlDate for extendedRange...");
			$sqlDate = UnixDate($epochDate, "%Y-%m-%d"); # Date used in SQL query
			$sqlDateStr = $sqlDate   ;                   # Date that gets printed for user
		} elsif ($args{fcstType} eq "longRange") {
			$logger->debug("Getting sqlDate for longRange...");
			$sqlDate = UnixDate($epochDate, "%Y-%m-15"); # Date used in SQL query
			$sqlDateStr = UnixDate($epochDate, "%Y-%m"); # Date that gets printed for user
		}
		# Calculate the number of spatial points missing
		$logger->debug("Calling calcNumMissing($mysqlSettings{'database'},$table,$sqlDate,$args{dontCountNullsOpt})");
		my $numMissing = calcNumMissing($mysqlSettings{'database'},$table,$sqlDate,$args{dontCountNullsOpt});
		if ($numMissing > 0) {
			push(@tempDaysArray,$sqlDateStr);
			push(@tempNumArray,$numMissing);
			push(@tempPercentArray,100*(1-((getTotalSpatialPoints()-$numMissing)/mysql_getNumExpectedLocations($table))));
		}
		# Increment the date
		my $dateIncrement;
		if ($args{fcstType} eq "extendedRange") {
			$dateIncrement = "1 day";
		} elsif ($args{fcstType} eq "longRange") {
			$dateIncrement = "1 month";
		}
		$epochDate = DateCalc($epochDate, " + $dateIncrement");
	}
	# Add this table's information to a hash array containing all tables' information
	$daysMissing{$table}    = [@tempDaysArray]    if scalar(@tempDaysArray);
	$numMissing{$table}     = [@tempNumArray]     if scalar(@tempNumArray);
	$percentMissing{$table} = [@tempPercentArray] if scalar(@tempPercentArray);
}

#--------------------------------------------------------------------
# Create a welcome message
#--------------------------------------------------------------------
my $welcomeMessage = "
-----------------------------------------------------------
|               Database Missing-Data Finder              |
-----------------------------------------------------------

 Program started at $currentTime

- Settings -

  Data type:      $args{dataType}
  Forecast type:  $args{fcstType}
  Spatial type:   $args{spatialType}
  Date range:     $args{startDate} to $args{endDate}
";

if ($optionsSet) {
	$welcomeMessage .= "\n- Options set -\n\n$optionsSet";
}

$welcomeMessage .= "\n- Searching for missing data -";

#--------------------------------------------------------------------
# See if there's any missing data. If not, we're done.
#--------------------------------------------------------------------
# Exit if there are no days in the %daysMissing hash array
unless (keys %daysMissing) {
	$logger->info($welcomeMessage);
	$logger->info("\n  No missing data found!");
	exit;
}

#--------------------------------------------------------------------
# Do this section if the email option is turned on
#--------------------------------------------------------------------
if ($args{emailOpt}) {
	#--------------------------------------------------------------------
	# Loop over tables to determine which have missing data and add the
	# data owner to a list of emails to receive the log message
	#--------------------------------------------------------------------
	# Loop over each table
	foreach my $table (keys %daysMissing) {
		# Get the owner of the data in this table
		my $dataOwner = "";
		if ($email_data_owner_flag) {
			$dataOwner = mysql_getDataOwner($table);
		}
		# Add the data owner unless they were already added
		unless ($loggerConfig{'log4perl.appender.Mailer.to'} =~ m/$dataOwner/) {
			$loggerConfig{'log4perl.appender.Mailer.to'} .= ", $dataOwner";
			$logger->debug("Mailer appender changed to $loggerConfig{'log4perl.appender.Mailer.to'}");
			# Reinitialize the logger
			Log::Log4perl::init( \%loggerConfig ) or die "Cannot initialize logger: $!";
		}
	}
	# Now that we've established the final list of emailees, anything we
	# log will be seen in the email message that everyone receives (if
	# the email option is turned on

	#--------------------------------------------------------------------
	# Add the email-specific message to the top of the welcome message
	#--------------------------------------------------------------------
	$welcomeMessage = "You are receiving this email because you were identified as the owner of one of the verification datasets with missing data. Please review the log message below to determine which of your datasets are missing data. Note that this log file contains all the missing data, some of which may not be yours.\n" . $welcomeMessage . "\n";
}
#--------------------------------------------------------------------
# Loop over hash array and print missing days
#--------------------------------------------------------------------
# Keeps track of whether the welcome message has been printed
my $welcome_message_printed = 0;
# Keep track of whether any missing data exceeds the threshold
my $missing_data = 0;
# Loop over each table
foreach my $table (keys %daysMissing) {
	# See if this table has any days missing more than the threshold
	my $missingAllPoints = grep {$_ >= $errorThreshold} @{$percentMissing{$table}};
	# Get number of days missing
	my $numDays = scalar(@{$daysMissing{$table}});
	# Make this an error-level log if this table contains any days
	# missing all points
	if ($missingAllPoints > 0) {
		$missing_data = 1;
		# Print welcome message (only the first time)
		unless ($welcome_message_printed) {
			$logger->error("$welcomeMessage");
			$welcome_message_printed = 1;
		}
		$logger->error("\n    $table\n\n");
	} else {
		$logger->warn("\n    $table\n\n");
	}
	# Loop over all days
	for (my $i=0; $i<$numDays; $i++) {
		my $day     = @{$daysMissing{$table}}[$i];
		my $num     = @{$numMissing{$table}}[$i];
		my $percent = @{$percentMissing{$table}}[$i];
		my $string  = sprintf("      %s: Missing %d %s points (%d%%)\n",$day,$num,$args{spatialType},$percent);
		if ($percent >= $errorThreshold) {
			$logger->error("$string");
		} else {
			$logger->warn("$string");
		}
	}
}

#--------------------------------------------------------------------
# Print a message informing the user that some missing data was found
#--------------------------------------------------------------------
if ($args{logLevel} =~ /ERROR|FATAL/ ) {
	unless ($welcome_message_printed) {
		print "$welcomeMessage\n";
	}
	print "\n  Some missing data was found, but the number of missing points was less than the threshold of $errorThreshold. To see more detailed information, run the script again with -loglevel WARN\n";
}

if ($missing_data == 1) {
	exit 1;
}


#====================================================================
#                           SUBROUTINES
#====================================================================

=head1 SUBROUTINES

=head2 calcNumMissing()

Checks to see how many spatial points are missing for a particular day

    Input
        database          - database containing the desired table
        table             - table containing the desired data
        sqlDate           - SQL-formatted (YYYY-MM-DD) date to check for missing data
        dontCountNullsOpt - Whether to count NULLs toward the number of missing points
    Output
        The number of missing spatial data points

=cut
sub calcNumMissing {
	# Get input arguments
	my $database          = $_[0];
	my $table             = $_[1];
	my $sqlDate           = $_[2];
	my $dontCountNullsOpt = $_[3];
	my $sqlQuery;
	# Determine the date column name, based on the data type
	my $dateColumn;
	if ($args{dataType} eq "forecast") {
		$dateColumn = "date_issued";
	} elsif ($args{dataType} eq "observation") {
		$dateColumn = "date_valid";
	}
	# Determine the day of the week
	my $dayOfTheWeek = UnixDate(ParseDate($sqlDate), '%w');

	#--------------------------------------------------------------------------
	# Construct the SQL to retrieve the list of spatial points with missing data
	#
	# Manual weekends - Don't count NULLs as missing, because there are always NULLs
	if ($args{dataType} eq "forecast" && (mysql_getSettingFromTableName($table,"fcstSource") eq "manual" or mysql_getSettingFromTableName($table,"model") eq "manual") && mysql_getSettingFromTableName($table,"fcstType") eq "extendedRange" && ($dayOfTheWeek == 6 || $dayOfTheWeek == 7)) {
		$sqlQuery = "SELECT fullId FROM (SELECT full.id AS fullId, partial.id AS partialID, partial.$dateColumn FROM $mysqlSettings{db_ref}.$args{spatialType} AS full LEFT JOIN (SELECT * FROM `$database`.`$table` WHERE $dateColumn='$sqlDate') AS partial ON full.id=partial.id WHERE partial.id IS NULL) AS missing";
	# Everything else - Counting NULLs or not is left up to the user
	} else {
		if (! $dontCountNullsOpt) {
			if ($args{dataType} eq "forecast") {
				$sqlQuery = "SELECT fullId FROM (SELECT full.id AS fullId, partial.id AS partialID, partial.$dateColumn FROM $mysqlSettings{db_ref}.$args{spatialType} AS full LEFT JOIN (SELECT * FROM `$database`.`$table` WHERE $dateColumn='$sqlDate') AS partial ON full.id=partial.id WHERE (partial.id IS NULL OR partial.prob_below IS NULL OR partial.prob_normal IS NULL OR partial.prob_above IS NULL)) AS missing";
			} elsif ($args{dataType} eq "observation") {
				$sqlQuery = "SELECT fullId FROM (SELECT full.id AS fullId, partial.id AS partialID, partial.$dateColumn FROM $mysqlSettings{db_ref}.$args{spatialType} AS full LEFT JOIN (SELECT * FROM `$database`.`$table` WHERE $dateColumn='$sqlDate') AS partial ON full.id=partial.id WHERE (partial.id IS NULL OR partial.category IS NULL)) AS missing";
			}
		} else {
			$sqlQuery = "SELECT fullId FROM (SELECT full.id AS fullId, partial.id AS partialID, partial.$dateColumn FROM $mysqlSettings{db_ref}.$args{spatialType} AS full LEFT JOIN (SELECT * FROM `$database`.`$table` WHERE $dateColumn='$sqlDate') AS partial ON full.id=partial.id WHERE partial.id IS NULL) AS missing";
		}
	}
	$logger->debug("Query to find missing data: $sqlQuery");
	# Execute the SQL query
    my $results = $db->prepare($sqlQuery) ; $results->execute();
	# Get the number of locations missing
	my $numRows = $results->rows;
	return $numRows;
}

=head2 getTotalSpatialPoints()

Determines the total number of spatial datapoints using the reference database.

    Output
        The total number of spatial data points

=cut
sub getTotalSpatialPoints {
	# Construct an SQL query
	my $sqlQuery = "SELECT * FROM $mysqlSettings{db_ref}.$args{spatialType}";
	# Execute the SQL query
    my $results = $db->prepare($sqlQuery) ; $results->execute();
	# Get the number of locations missing
	my $numRows = $results->rows;
	return $numRows;
}

=head2 mysql_getDataOwner()

Retrieves the owner of the data from the dataSettings table.

This subroutine uses the provided arguments to construct a MySQL query that
retrieves the 'owner' column from the dataSettings table in the reference database.

	Output
		Database status:
			1 if the hash variable is successfully populated
			0 if no row was found matching the given arguments

=cut
sub mysql_getDataOwner {
	# Get the table
	my $table = $_[0];
	# Initialize all possible variables
	my ($dataType, $variable, $fcstSource, $fcstType, $tool, $model, $cycle, $spatialType, $leadTime, $aveWindow) = 0;
	# Determine the type of data and generate the appropriate SQL string
	if (mysql_getSettingFromTableName($table,"dataType") eq "observation") { # Observation
		$sqlQuery = "SELECT owner FROM $mysqlSettings{db_ref}.dataSettings WHERE dataType='$dataType' AND variable='$variable' AND fcstType='$fcstType' AND spatialType='$spatialType'";
	} elsif (mysql_getSettingFromTableName($table,"tool") == 0) { # Forecast, not a tool
		$sqlQuery = "SELECT owner FROM $mysqlSettings{db_ref}.dataSettings WHERE dataType='$dataType' AND variable='$variable' AND fcstSource='$fcstSource' AND fcstType='$fcstType' AND spatialType='$spatialType'";
	} elsif (mysql_getSettingFromTableName($table,"cycle") == 0) { # Forecast, tool with no cycle
		$sqlQuery = "SELECT owner FROM $mysqlSettings{db_ref}.dataSettings WHERE dataType='$dataType' AND variable='$variable' AND fcstSource='$fcstSource' AND fcstType='$fcstType' AND tool='$tool' AND model='$model' AND spatialType='$spatialType'";
	} else { # Forecast, tool with a cycle
		$sqlQuery = "SELECT owner FROM $mysqlSettings{db_ref}.dataSettings WHERE dataType='$dataType' AND variable='$variable' AND fcstSource='$fcstSource' AND fcstType='$fcstType' AND tool='$tool' AND model='$model' AND spatialType='$spatialType'";
	}
	$logger->debug("Query to get the data owner for table $table: $sqlQuery");
	# Execute query to get data owner
    my $results = $db->prepare($sqlQuery) ; $results->execute();
	my @resultsArray = $results->fetchrow_array();
	return $resultsArray[0];
}

=head2 mysql_getNumExpectedLocations()

Retrieves the number of expected locations for this model from the dataSettings table.

This subroutine uses the provided arguments to construct a MySQL query that
retrieves the 'numExpectedLocations' column from the dataSettings table in the reference database.

	Output
		Database status:
			1 if the hash variable is successfully populated
			0 if no row was found matching the given arguments

=cut
sub mysql_getNumExpectedLocations {
	# Get the table
	my $table = $_[0];
	# Initialize all possible variables
	my ($dataType, $variable, $fcstSource, $fcstType, $tool, $model, $cycle, $spatialType, $leadTime, $aveWindow);
	$dataType		= mysql_getSettingFromTableName($table,"dataType");
	$variable		= mysql_getSettingFromTableName($table,"variable");
	$fcstType		= mysql_getSettingFromTableName($table,"fcstType");
	$fcstSource		= mysql_getSettingFromTableName($table,"fcstSource");
	$spatialType	= mysql_getSettingFromTableName($table,"spatialType");
	$tool			= mysql_getSettingFromTableName($table,"tool");
	$model			= mysql_getSettingFromTableName($table,"model");
	$cycle			= mysql_getSettingFromTableName($table,"cycle");
	# Determine the type of data and generate the appropriate SQL string
	if ($dataType eq 'observation') { # Observation
		$sqlQuery = "SELECT numExpectedLocations FROM $mysqlSettings{db_ref}.dataSettings WHERE dataType='observation' AND variable='$variable' AND fcstType='$fcstType' AND spatialType='$spatialType'";
	} elsif ($tool eq "") { # Forecast, not a tool
		$sqlQuery = "SELECT numExpectedLocations FROM $mysqlSettings{db_ref}.dataSettings WHERE dataType='forecast' AND variable='$variable' AND fcstSource='$fcstSource' AND fcstType='$fcstType' AND spatialType='$spatialType'";
	} elsif ($cycle eq "") { # Forecast, tool with no cycle
		$sqlQuery = "SELECT numExpectedLocations FROM $mysqlSettings{db_ref}.dataSettings WHERE dataType='forecast' AND variable='$variable' AND fcstSource='$fcstSource' AND fcstType='$fcstType' AND tool='$tool' AND model='$model' AND spatialType='$spatialType'";
	} else { # Forecast, tool with a cycle
		$sqlQuery = "SELECT numExpectedLocations FROM $mysqlSettings{db_ref}.dataSettings WHERE dataType='forecast' AND variable='$variable' AND fcstSource='$fcstSource' AND fcstType='$fcstType' AND tool='$tool' AND model='$model' AND spatialType='$spatialType'";
	}
	$logger->debug("Query to get the number of locations for table $table: $sqlQuery");
	# Execute query to get data owner
    my $results = $db->prepare($sqlQuery) ; $results->execute();
	my @resultsArray = $results->fetchrow_array();
	return $resultsArray[0];
}

=head2 mysql_getSettingFromTableName()

Parses the given table name into parts and returns the desired setting.

For example, for the table precip_analog_gfs_06z_11d_07d_stn:

    variable    = precip
    tool        = analog
    model       = gfs
    cycle       = 06z
    lead        = 11d
    aveWindow   = 07d
    spatialType = stn

    Input
        tableName
        settingName

    Output
        settingValue

=cut
sub mysql_getSettingFromTableName {
	# Get the args
	my $table = $_[0];
	my $settingName = $_[1];
	# Split table into parts
	my @tableParts = split('_',$table);
	# Initialize all possible variables
	my ($dataType, $variable, $fcstSource, $fcstType, $tool, $model, $cycle, $spatialType, $leadTime, $aveWindow, $leadTimeUnit);
	$dataType = "";
	# Extract parts
	if (scalar (@tableParts) == 3) { # Observation
		$dataType    = "observation";
		$variable    = $tableParts[0];
		$aveWindow   = $tableParts[1];
		$spatialType = $tableParts[2];
		if ($aveWindow =~ m/d$/) { # Extended range
			$fcstType = "extendedRange";
		} elsif ($aveWindow =~ m/m$/) { # Long range
			$fcstType = "longRange";
		}
		$leadTime     = "";
		$leadTimeUnit = "";
	} elsif (scalar (@tableParts) == 5) { # Forecast, not a tool
		$dataType    = "forecast";
		$variable    = $tableParts[0];
		$fcstSource  = $tableParts[1];
		$leadTime    = $tableParts[2];
		$aveWindow   = $tableParts[3];
		$spatialType = $tableParts[4];
		if ($leadTime =~ m/d$/) { # Extended range
			$fcstType = "extendedRange";
		} elsif ($leadTime =~ m/m$/) { # Long range
			$fcstType = "longRange";
		}
		$tool        = "";
		$model       = "";
		$cycle       = "";
	} elsif (scalar (@tableParts) == 6) { # Forecast, tool with no cycle
		$dataType    = "forecast";
		$variable    = $tableParts[0];
		$tool        = $tableParts[1];
		$model       = $tableParts[2];
		$leadTime    = $tableParts[3];
		$aveWindow   = $tableParts[4];
		$spatialType = $tableParts[5];
		$fcstSource  = "tool";
		if ($leadTime =~ m/d$/) { # Extended range
			$fcstType = "extendedRange";
		} elsif ($leadTime =~ m/m$/) { # Long range
			$fcstType = "longRange";
		}
		$cycle       = "";
	} elsif (scalar (@tableParts) == 7) { # Forecast, tool with a cycle
		$dataType    = "forecast";
		$variable    = $tableParts[0];
		$tool        = $tableParts[1];
		$model       = $tableParts[2];
		$cycle       = $tableParts[3];
		$leadTime    = $tableParts[4];
		$aveWindow   = $tableParts[5];
		$spatialType = $tableParts[6];
		$fcstSource  = "tool";
		if ($leadTime =~ m/d$/) { # Extended range
			$fcstType = "extendedRange";
		} elsif ($leadTime =~ m/m$/) { # Long range
			$fcstType = "longRange";
		}
	}
	# Extract leadTimeUnit from leadTime
	$leadTimeUnit = substr($leadTime,-1,1);
	$leadTime = substr($leadTime,0,-1);
	switch ($settingName) {
		case "dataType"		{ return $dataType }
		case "variable"		{ return $variable }
		case "tool"			{ return $tool }
		case "model"		{ return $model }
		case "cycle"		{ return $cycle }
		case "leadTime"		{ return $leadTime }
		case "leadTimeUnit"	{ return $leadTimeUnit }
		case "aveWindow"	{ return $aveWindow }
		case "spatialType"	{ return $spatialType }
		case "fcstSource"	{ return $fcstSource }
		case "fcstType"		{ return $fcstType }
	}
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
	unless (defined($args{dataType}) and $args{dataType} =~ m/\b($regex)\b/) { pod2usage("\nThe -dataType option is not set properly, was expecting: $regex\n"); }
	#--------------------------------------------------------------------
	# spatialType
	#--------------------------------------------------------------------
	$regex = 'stn|cd|grid2deg';
	unless (defined($args{spatialType}) and $args{spatialType} =~ m/\b($regex)\b/) { pod2usage("\nThe -spatialType option is not set properly, was expecting: $regex\\n"); }
	#--------------------------------------------------------------------
	# fcstType
	#--------------------------------------------------------------------
	$regex = 'extendedRange|longRange';
	unless (defined($args{fcstType}) and $args{fcstType} =~ m/\b($regex)\b/) { pod2usage("\nThe -fcstType option is not set properly, was expecting: $regex\\n"); }
	#--------------------------------------------------------------------
	# startDate
	#--------------------------------------------------------------------
	if ($args{fcstType} eq "extendedRange") {
		$regex = '\d{8}';
		unless (defined($args{startDate}) and $args{startDate} =~ m/\b$regex\b/) { pod2usage("\nThe -startDate option is not set properly, was expecting: $regex\\n"); }
	} elsif ($args{fcstType} eq "longRange") {
		$regex = '\d{6}';
		unless (defined($args{startDate}) and $args{startDate} =~ m/\b$regex\b/) { pod2usage("\nThe -startDate option is not set properly, was expecting: $regex\\n"); }
	}
	#----------------------------------------------------------------
	# endDate
	#--------------------------------------------------------------------
	if ($args{fcstType} eq "extendedRange") {
		$regex = '\d{8}';
		unless (defined($args{endDate}) and $args{endDate} =~ m/\b$regex\b/) { pod2usage("\nThe -endDate option is not set properly, was expecting: $regex\\n"); }
	} elsif ($args{fcstType} eq "longRange") {
		$regex = '\d{6}';
		unless (defined($args{endDate}) and $args{endDate} =~ m/\b$regex\b/) { pod2usage("\nThe -endDate option is not set properly, was expecting: $regex\\n"); }
	}
	# Make sure endDate > startDate
	unless (compareDates($args{startDate},$args{endDate}) <= 0) { pod2usage("\nThe end date provided does not come after the start date provided\n"); }
	#----------------------------------------------------------------
	# logLevel
	#--------------------------------------------------------------------
	# Since this is optional, only validate if it's defined
	if (defined($args{logLevel})) {
		$regex = 'TRACE|DEBUG|INFO|WARN|ERROR|FATAL';
		unless ($args{logLevel} =~ m/\b($regex)\b/) { pod2usage("\nThe -loglevel option is not set properly, was expecting: $regex\\n"); }
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
	my ($dateFormat,$dateObj1,$dateObj2);
	# Validate dates
	if ($dateStr1 =~ m/\b\d{8}\b/ and $dateStr2 =~ m/\b\d{8}\b/) {
		$dateFormat = "%Y%m%d";
		# Create new Date objects
		$dateObj1 = ParseDate($dateStr1);
		$dateObj2 = ParseDate($dateStr2);
	} elsif ($dateStr1 =~ m/\b\d{6}\b/ and $dateStr2 =~ m/\b\d{6}\b/) {
		$dateFormat = "%Y%m";
		# Create new Date objects
		$dateObj1 = ParseDate($dateStr1."15");
		$dateObj2 = ParseDate($dateStr2."15");
	} else {
		warn "compareDates() Cannot compare these two dates";
		return;
	}

	return Date_Cmp($dateObj1,$dateObj2);
}
