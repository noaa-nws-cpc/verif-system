#!/usr/bin/perl

=head1 NAME

db_test_findDuplicates.pl - A Perl script to check for duplicate forecast and/or obs data in the database

=head1 SYNOPSIS

 db_test_findDuplicates.pl [OPTIONS]

 Required arguments:
   -d, -datatype         Type of data to check                 forecast, observation
   -g, -spatialtype      Type of spatial data                  cd, stn, grid2deg
   -f, -fcsttype         type of forecast (or corresponding    extendedRange, longRange
                         forecast when datatype=observation)
   -s, -startdate        Date to begin processing              YYYYMMDD (YYYYMM) for extendedRange (longRange)
   -e, -enddate          Date to begin end processing          YYYYMMDD (YYYYMM) for extendedRange (longRange)
 Optional arguments:
   -t, -tablefilter      String used to narrow down the tables checked. This will
                         be directly used in the SQL statement, after a 'LIKE'.
                         For example, '-t \%grid2deg' will check all tables ending
                         in 'grid2deg'.
   -l, -loglevel         Sets the log4perl logging level (DEBUG, INFO, WARN,
                         ERROR, FATAL)
       -logfile          specifies a log file name, instead of printing to the screen
       -email            email any errors to the process owner

=head1 DESCRIPTION



=head1 REQUIRES

Pod::Usage, Getopt::Long, DBI, Time::Local, Date::Manip, Log::Log4perl

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

use lib "$HOME/library/perl";
use Pod::Usage;
use Getopt::Long;
use Switch;
use DBI;
use Time::Local;
use Date::Manip;
use Switch;
use Log::Log4perl;
use Log::Dispatch::Email::MailSend;
use ConfigFile;
use strict;
use warnings;

#--------------------------------------------------------------------
# Get command line arguments
#--------------------------------------------------------------------
my %args;
GetOptions ('datatype|d=s'		=> \$args{dataType},
			'spatialtype|g=s'	=> \$args{spatialType},
			'fcsttype|f=s'		=> \$args{fcstType},
			'startdate|s=s'		=> \$args{startDate},
			'enddate|e=s'		=> \$args{endDate},
			'loglevel|l=s'		=> \$args{logLevel},
			'logfile=s'			=> \$args{logFile},
			'email'				=> \$args{emailOpt},
			'tablefilter|t=s'	=> \$args{tableFilter},
			'help|h'			=> \$args{help}
);
# Convert log level to Upper Case
if ($args{logLevel}) {
	# Convert the given log level to ALL CAPS
	$args{logLevel} = uc($args{logLevel});
} else {
	# Default to INFO
	$args{logLevel} = "INFO";
}

#--------------------------------------------------------------------
# If the user wants help, print the usage
#--------------------------------------------------------------------
if ($args{help}) {
	pod2usage();
}

#--------------------------------------------------------------------
# Validate arguments
#--------------------------------------------------------------------
validateArgs(%args);

#--------------------------------------------------------------------
# Settings
#--------------------------------------------------------------------
# Ensure we're using all UTC times
$ENV{TZ}='UTC';
# Read in settings from a configuration file
my $configFile="$HOME/input/verif_data.conf";
my %settings = load_settings($configFile,"multi");
# Extract separate settings sections
my %mysqlSettings = %{$settings{mysql}};
my %emailSettings = %{$settings{email}};
# Create an email subject if necessary
unless ($emailSettings{subject}) {
	$emailSettings{subject} = "Found duplicate data: $args{dataType} - $args{fcstType} - $args{spatialType}";
}
# Set the rest of the MySQL settings
if ($args{dataType} eq "forecast") {
	$mysqlSettings{database} = $mysqlSettings{db_fcst};
} elsif ($args{dataType} eq "observation") {
	$mysqlSettings{database} = $mysqlSettings{db_obs};
}

#--------------------------------------------------------------------
# Create list of options if any are set
#--------------------------------------------------------------------
my $optionsSet;
if ($args{tableFilter})     { $optionsSet = $optionsSet . "  -tablefilter   $args{tableFilter}\n"; }
if ($args{logLevel})        { $optionsSet = $optionsSet . "  -loglevel      $args{logLevel}\n"; }

#--------------------------------------------------------------------
# Set up log4perl logger
#--------------------------------------------------------------------
# Set up the logger configuration for just the file appender (if necessary)
my $loggerConfig;
# Define optional loggers (if necessary)
my $rootLogger = "log4perl.rootLogger = DEBUG, Screen";
my $appender = "log4perl.appender.Screen                           = Log::Log4perl::Appender::Screen
log4perl.appender.Screen.layout                    = Log::Log4perl::Layout::PatternLayout
#log4perl.appender.Screen.layout.ConversionPattern = [\%d] ( \%C L\%L ) \%p - \%m\%n
log4perl.appender.Screen.layout.ConversionPattern  = \%m\%n
log4perl.appender.Screen.Threshold                 = $args{logLevel}
";
if (defined($args{logFile})) {
	# Remove existing logfile
	if (defined($args{logFile})) { unlink $args{logFile};}
	# Add "File" to the root logger
	$rootLogger .= ", File";
	# Add a File appender
	$appender .= "log4perl.appender.File                          = Log::Log4perl::Appender::File
log4perl.appender.File.filename                 = $args{logFile}
log4perl.appender.File.layout                   = Log::Log4perl::Layout::PatternLayout
log4perl.appender.File.layout.ConversionPattern = \%m\%n
log4perl.appender.File.Threshold                = $args{logLevel}
";
}
if (defined($args{emailOpt})) {
	# Add "Mailer" to the root logger
	$rootLogger .= ", Mailer";
	# Add a Mailer appender (will send out email when an ERROR-level log call occurs)
	$appender .= "log4perl.appender.Mailer                           = Log::Dispatch::Email::MailSend
log4perl.appender.Mailer.to                        = $emailSettings{toEmail}
log4perl.appender.Mailer.from                      = \"$emailSettings{fromName}\" <$emailSettings{fromEmail}>
log4perl.appender.Mailer.subject                   = $emailSettings{subject}
log4perl.appender.Mailer.layout                    = Log::Log4perl::Layout::PatternLayout
log4perl.appender.Mailer.layout.ConversionPattern  = \%m\%n
log4perl.appender.Mailer.Threshold                 = $emailSettings{logLevel},
log4perl.appender.Mailer.buffered                  = 1
";
}
# Now set up the full logger config string
$loggerConfig = "
$rootLogger
$appender
";

Log::Log4perl::init( \$loggerConfig ) or die "Cannot initialize logger: $!";
my $logger = Log::Log4perl::get_logger("");

#--------------------------------------------------------------------
# Print diagnostic information
#--------------------------------------------------------------------
# Get the current date/time
my $currentTime = &UnixDate("today",'%T %Y-%m-%d');

$logger->info("

------------------------------------
- Duplicate Database-Record Finder -
------------------------------------

  Program started at $currentTime

- Settings -

  Data type:      $args{dataType}
  Spatial type:   $args{spatialType}
  Date range:     $args{startDate} to $args{endDate}
  Forecast type:  $args{fcstType}
");

if ($optionsSet) {
	$logger->info("
- Options set -

$optionsSet");
}

$logger->info("
- Searching for duplicate records...
");

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
if ($args{tableFilter}) {
	$sqlQuery = "SHOW TABLES FROM $mysqlSettings{database} LIKE '$args{tableFilter}'";
} else {
	$sqlQuery = "SHOW TABLES FROM $mysqlSettings{database} LIKE '\%\\\___$aveWindowUnit\_$args{spatialType}'";
}
$logger->debug("Query to find all $mysqlSettings{database} tables: $sqlQuery");
# Execute the SQL query
my $results = $db->do($sqlQuery);
# Initialize an empty hash to store the number of duplicates for each table
my %daysWithDuplicates = ();
my %numDuplicates = ();

# Loop over all tables
while (my $table = $results->fetchrow_array) {
	#--------------------------------------------------------------------
	# Calculate epoch dates
	#--------------------------------------------------------------------
	my $epochDate;
	my $epochEnd;
	if ($args{fcstType} eq "extendedRange")
	{
		$epochDate = ParseDate($args{startDate});
		$epochEnd  = ParseDate($args{endDate});
	}
	elsif ($args{fcstType} eq "longRange")
	{
		$epochDate = ParseDate($args{startDate}.'15');
		$epochEnd  = ParseDate($args{endDate}.'15');
	}
	#--------------------------------------------------------------------
	# Loop over all days
	#--------------------------------------------------------------------
	my @tempDaysArray = ();
	my @tempNumArray  = ();
	while ($epochDate le $epochEnd) {
		# Get an SQL-formatted date
		my $sqlDate;
		my $sqlDateStr;
		if ($args{fcstType} eq "extendedRange") {
			$sqlDate = UnixDate($epochDate, "%Y-%m-%d"); # Date used in SQL query
			$sqlDateStr = $sqlDate;                      # Date that gets printed for user
		} elsif ($args{fcstType} eq "longRange") {
			$sqlDate = UnixDate($epochDate, "%Y-%m-15"); # Date used in SQL query
			$sqlDateStr = UnixDate($epochDate, "%Y-%m"); # Date that gets printed for user
		}
		# Calculate the number of duplicate records
		my $numDuplicates = calcNumDuplicates($mysqlSettings{'database'},$table,$sqlDate);
		if ($numDuplicates > 0) {
			push(@tempDaysArray,$sqlDateStr);
			push(@tempNumArray,$numDuplicates);
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
	$daysWithDuplicates{$table} = [@tempDaysArray] if scalar(@tempDaysArray);
	$numDuplicates{$table}      = [@tempNumArray] if scalar(@tempNumArray);
}

#--------------------------------------------------------------------
# Loop over hash array and print duplicates
#--------------------------------------------------------------------
foreach my $table (keys %daysWithDuplicates) {
	$logger->error("\n  - $table -\n\n");
	# Get number of days missing
	my $numDays = scalar(@{$daysWithDuplicates{$table}});
	for (my $i=0; $i<$numDays; $i++) {
		my $day = @{$daysWithDuplicates{$table}}[$i];
		my $num = @{$numDuplicates{$table}}[$i];
		$logger->error("    $day: $num duplicate records found\n");
	}
}

#====================================================================
#                           SUBROUTINES
#====================================================================

=head1 SUBROUTINES

=head2 calcNumDuplicates()

Checks to see how many duplicate spatial points exist for a particular day

    Input
        database        - database containing the desired table
        table           - table containing the desired data
        sqlDate         - SQL-formatted (YYYY-MM-DD) date to check for missing data
    Output
        The number of duplicate spatial data points

=cut
sub calcNumDuplicates {
	# Get input arguments
	my $database        = $_[0];
	my $table           = $_[1];
	my $sqlDate         = $_[2];
	my $sqlQuery;
	# Determine the date column name, based on the data type
	my $dateColumn;
	if ($args{dataType} eq "forecast") {
		$dateColumn = "date_issued";
	} elsif ($args{dataType} eq "observation") {
		$dateColumn = "date_valid";
	}
	# Construct the SQL to retrieve the list of spatial points with duplicate records
	$sqlQuery = "SELECT id, COUNT(*) AS num FROM $database.$table WHERE $dateColumn='$sqlDate' GROUP BY id, $dateColumn HAVING num > 1";
	$logger->debug("Query to find duplicates: $sqlQuery");
	# Execute the SQL query
	my $results = $db->do($sqlQuery);
	# Get the number of duplicates
	my $numDuplicates = $results->rows;
	return $numDuplicates;
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

	#----------------------------------------------------------------
	# dataType
	#
	unless (defined($args{dataType}) and $args{dataType} =~ m/\b(observation|forecast)\b/) { pod2usage("\nThe -dataType option is not set properly\n"); }
	#----------------------------------------------------------------
	# spatialType
	#
	unless (defined($args{spatialType}) and $args{spatialType} =~ m/\b(stn|cd|grid2deg)\b/) { pod2usage("\nThe -spatialType option is not set properly\n"); }
	#----------------------------------------------------------------
	# fcstType
	#
	unless (defined($args{fcstType}) and $args{fcstType} =~ m/\b(extendedRange|longRange)\b/) { pod2usage("\nThe -fcstType option is not set properly\n"); }
	#----------------------------------------------------------------
	# startDate
	#
	if ($args{fcstType} eq "extendedRange") {
		unless (defined($args{startDate}) and $args{startDate} =~ m/\b\d{8}\b/) { pod2usage("\nThe -startDate option is not set properly\n"); }
	} elsif ($args{fcstType} eq "longRange") {
		unless (defined($args{startDate}) and $args{startDate} =~ m/\b\d{6}\b/) { pod2usage("\nThe -startDate option is not set properly\n"); }
	}
	#----------------------------------------------------------------
	# endDate
	#
	if ($args{fcstType} eq "extendedRange") {
		unless (defined($args{endDate}) and $args{endDate} =~ m/\b\d{8}\b/) { pod2usage("\nThe -endDate option is not set properly\n"); }
	} elsif ($args{fcstType} eq "longRange") {
		unless (defined($args{endDate}) and $args{endDate} =~ m/\b\d{6}\b/) { pod2usage("\nThe -endDate option is not set properly\n"); }
	}
	# Make sure endDate > startDate
	unless (compareDates($args{startDate},$args{endDate}) <= 0) { pod2usage("\nThe end date provided does not come after the start date provided\n"); }
	#----------------------------------------------------------------
	# logLevel
	#
	# Since this is optional, only validate if it's defined
	if (defined($args{logLevel})) {
		unless ($args{logLevel} =~ m/\b(TRACE|DEBUG|INFO|WARN|ERROR|FATAL)\b/) { pod2usage("\nThe -loglevel option is not set properly\n"); }
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
	if ($dateStr1 =~ m/\b\d{8}\b/ and $dateStr2 =~ m/\b\d{8}\b/) {
		$dateFormat = "%Y%m%d"
	} elsif ($dateStr1 =~ m/\b\d{6}\b/ and $dateStr2 =~ m/\b\d{6}\b/) {
		$dateFormat = "%Y%m"
	} else {
		warn "compareDates() Cannot compare these two dates";
		return;
	}
	# Create new Date objects
	my $dateObj1 = ParseDate($dateStr1);
	my $dateObj2 = ParseDate($dateStr2);

	return Date_Cmp($dateObj1,$dateObj2);
}
