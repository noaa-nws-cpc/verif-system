#!/usr/bin/perl

=head1 NAME

db_import_climPhenom - A Perl script to import ascii climate phenomenon data into MySQL

=head1 SYNOPSIS

 db_import_climPhenom.pl [OPTIONS]

 Required arguments:
   -i, -input        file containing the data (file path or web URL)
   -c, -climphenom   climate phenomenon in question (ENSO)
   -t, -timescale    timescale of the data (seasonal, monthly)
   -m, -monthcol     ASCII column containing the month/season (name or # of column)
   -y, -yearcol      ASCII column containing the year (name or # of column)
   -v, -valuecol     ASCII column containing the value of the climate phenomenon (name or # of column)
   -f, -monthformat  format of the month/season column (MMM [eg. JFM] or MM [eg. 05])

 Optional arguments:
   -h, -help         print this help message
   -l, -loglevel     sets the log4perl logging level (DEBUG, INFO, WARN, ERROR, FATAL)
   -hasheader        removes the first (header) line of the input file
   -destroy          delete the entire database table before importing

=head1 DESCRIPTION

=head2 Introduction

This script imports climate phenomenon data from a text file into a MySQL database. Once in
the database, this data is used by the Verification System to stratify forecasts and
observations by climate phenomena.

When importing data, existing rows are always left intact (unless the C<-destroy> option is
set). The only thing that gets updated is the value of the climate phenomenon specified. In
other words, if there's already an ENSO and AO at 1995-05-15, and you run the script to update
ENSO, then the ENSO at that date will get updated, but the AO will be unaffected.

If the table or climate phenomena (set as a variable type in the database) does not exist, this process should create it. Process will die if not able to create it.

=head2 Dates

Dates inserted for data is the date valid. Daily values are imported/created even though data may be monthly or seasonal. The monthly or seasonal value is copied into daily values. This is for easy of matching dates to forecasts or observations. Years that do not have a leap day get a value inserted but the date_valid column contains '0000-00-00' so would not be used or matched when paired with forecast or observation data in ie. the verification system.

=head2 Database Structure

The I<reference> database is used to store the climate phenomena data. The table storing the
data is climatePhenomena_seasonal for climate phenomena that have a seasonal signal. Here is
an example of what the table looks like:

 +------------+------+------+
 | date_valid | ENSO | AO   |
 +------------+------+------+
 | 1995-01-15 | warm | NULL |
 | 1995-02-15 | warm | NULL |
 | 1995-03-15 | warm | NULL |
 | 1997-05-15 | warm | NULL |
 | 1997-06-15 | warm | NULL |
 | 1997-07-15 | warm | NULL |
 | 1997-08-15 | warm | NULL |
 | 1997-09-15 | warm | NULL |
 | 1997-10-15 | warm | NULL |
 | 1997-11-15 | warm | NULL |
 +------------+------+------+

=head2 Argument Details

=head3 Required Arguments

=head4 -input

The file must be in ASCII format. A header line is optional, but if there is one, it must have
the same number of columns as the data lines, and column headers I<cannot> contain any spaces.

The file can either reside on the filesystem, in which case the argument provided must be the
full or relative path to the file, or on a webserver, in which case the argument provided must
be a valid URL where the file can be accessed. The script automatically recognizes whether the
argument provided is a file path or a URL.

=head4 -climphenom

This is the climate phenomenon that will be inserted into the database. In the database table,
this is the name of the column.

=head4 -timescale

This is the timescale of the climate phenomena, and can be seasonal or monthly.

=head4 -monthcol

This describes the position of the column containing the month by either explicitly defining
the number of the column, or defining the heading for this column. Either can be provided, and
the script will automatically recognize whether the column number or column name is provided.

=head4 -yearcol

Same as C<-monthcol>, except this is for the column containing the year.

=head4 -valuecol

Same as C<-monthcol>, except this is for the column containing the value of the climate phenomenon.

=head4 -monthformat

This describes how the month is formatted in the file. This can either be a 3-character season, which
combines the first letter of each month (eg. JFM for January through March), or a 2-digit month (eg.
04 for April) or 3-character month (eg. Jan for January).

=head3 Optional Arguments

=head4 -help

Prints the script usage.

=head4 -loglevel

This sets the log4perl (exactly like Java's log4j) logging level, which determines to what level of
verbosity the script prints information. Here are the supported levels, from highest to lowest
verbosity:

=over

=item * DEBUG

=item * INFO

=item * WARN

=item * ERROR

=item * FATAL

=back

=head4 -destroy

This option will result in the database table being completely wiped out before inserting any
new data. It's usually good to do this the first time you're importing data, but from then on
you should leave this option off so that database rows are simply I<updated> with data. This is
especially the case when you are importing one type of climate phenomenon when another type
already exists in the database table.

=head1 REQUIRES

Getopt::Long, Date::Manip, Switch, Mysql, Pod::Usage, Log::Log4perl, LWP::Simple

=head1 SEE ALSO



=cut

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
}

use lib "$HOME/library/perl";
use warnings;
use Getopt::Long;
use Date::Manip;
use Switch;
use Mysql;
use Pod::Usage;
use Log::Log4perl;
use LWP::Simple;
use ConfigFile;

#--------------------------------------------------------------------
# Get command line arguments
#
my %args;
GetOptions ('help|h'			=> \$args{help},
			'input|i=s'			=> \$args{input},
			'climphenom|c=s'	=> \$args{climPhenom},
			'timescale|t=s'		=> \$args{timeScale},
			'monthcol|m=s'		=> \$args{monthCol},
			'yearcol|y=s'		=> \$args{yearCol},
			'valuecol|v=s'		=> \$args{valueCol},
			'monthformat|f=s'	=> \$args{monthFormat},
			'hasheader'			=> \$args{hasHeader},
			'loglevel|l=s'		=> \$args{logLevel},
			'destroy'       	=> \$args{destroyOpt},
);

#--------------------------------------------------------------------
# If the user wants help, print the usage
#
if ($args{help}) {
	pod2usage(1);
}

#--------------------------------------------------------------------
# Validate arguments
#
checkArgs(%args);

#--------------------------------------------------------------------
# Get the current date/time
#
my $currentTime = &UnixDate("today",'%T %Y-%m-%d');

#--------------------------------------------------------------------
# Settings
#
# Ensure we're using all UTC times
$ENV{TZ}='UTC';
# Read in MySQL settings from a configuration file
my $configFile="$HOME/input/verif_data.conf";
my %settings = load_settings($configFile,"multi");
# Extract separate settings sections
my %mysqlSettings = %{$settings{mysql}};
my %emailSettings = %{$settings{email}};
# Set the rest of the MySQL settings
$mysqlSettings{database} = $mysqlSettings{db_ref};
$mysqlSettings{table} = mysql_getTableName();

#--------------------------------------------------------------------
# Set up log4perl logger
#
if ($args{logLevel}) {
	# Convert the given log level to ALL CAPS
	$args{logLevel} = uc($args{logLevel});
} else {
	# Default to INFO
	$args{logLevel} = "INFO";
}
my $loggerConfig = "
# Send to screen
log4perl.rootLogger                                = DEBUG, Screen
log4perl.appender.Screen                           = Log::Log4perl::Appender::Screen
log4perl.appender.Screen.layout                    = Log::Log4perl::Layout::PatternLayout
#log4perl.appender.Screen.layout.ConversionPattern = [\%d] ( \%C L\%L ) \%p - \%m\%n
log4perl.appender.Screen.layout.ConversionPattern  = \%m\%n
log4perl.appender.Screen.Threshold                 = $args{logLevel}
# Append to a file
#log4perl.appender.File                          = Log::Log4perl::Appender::File
#log4perl.appender.File.filename                 =
#log4perl.appender.File.layout                   = Log::Log4perl::Layout::PatternLayout
#log4perl.appender.File.layout.ConversionPattern = \%m\%n
#log4perl.appender.File.Threshold                = WARN
# Send an email
#log4perl.category                = ERROR, Mailer
#log4perl.appender.Mailer         = Log::Dispatch::Email::MailSend
#log4perl.appender.Mailer.to      =
#log4perl.appender.Mailer.subject =
#log4perl.appender.Mailer.layout  = SimpleLayout
";
Log::Log4perl::init( \$loggerConfig );
my $logger = Log::Log4perl::get_logger("");

#--------------------------------------------------------------------
# Create list of options if any are set
#
my $optionsSet;
if ($args{logLevel}  )	{ $optionsSet = $optionsSet . "  -loglevel    $args{logLevel}\n"; }
if ($args{destroyOpt})	{ $optionsSet = $optionsSet . "  -destroy     The entire database table will be wiped before importing!\n"; }
if ($args{hasHeader})	{ $optionsSet = $optionsSet . "  -hasheader   The header line will be removed from the input file\n"; }

#--------------------------------------------------------------------
# Print diagnostic information
#
$logger->info("
----------------------------------------
- Climate Phenomena -> Database Script -
----------------------------------------

Program started at $currentTime

- Settings -

  Input file:     $args{input}
  Timescale:      $args{timeScale}
  ASCII columns:
      Month:      $args{monthCol}
      Year:       $args{yearCol}
      Value:      $args{valueCol}
  Month format:   $args{monthFormat}
");

if ($optionsSet) {
$logger->info("\n- Options set -\n\n$optionsSet");
}

$logger->info("
- MySQL info -

  Host:     $mysqlSettings{'host'}
  User:     $mysqlSettings{'user'}
  Database: $mysqlSettings{'database'}
  Table:    $mysqlSettings{'table'}

- Making MySQL connection -

");

#--------------------------------------------------------------------
# Make a connection to the database
#
# Connect to MySQL server
my $db = Mysql->connect($mysqlSettings{'host'},$mysqlSettings{'database'},$mysqlSettings{'user'},$mysqlSettings{'password'}) or die "  Cannot connect to MySQL server: $!\n";

#--------------------------------------------------------------------
# Ensure the required table exists. If it does not, create it.
#
if (mysql_tableExists($mysqlSettings{database}, $mysqlSettings{table})) {
	$logger->info("  MySQL table \'$mysqlSettings{'table'}\' exists");
} else {
	$logger->info("  Creating MySQL table \'$mysqlSettings{'table'}\'...");
	$sqlQuery = "CREATE TABLE $mysqlSettings{'table'} (date_valid DATE)";
	$db->query($sqlQuery) or die "Cannot create table $mysqlSettings{'table'}: $!";
	$sqlQuery = "CREATE INDEX index_date ON $mysqlSettings{'table'} (date_valid)";
	$db->query($sqlQuery) or die "Cannot create index on column date_valid: $!";
}
#--------------------------------------------------------------------
# Ensure the required column (climate phenomena type) exists. If it does not, create it.
# The column will be set to VARCHAR(20) in the database.
#
if (mysql_colExists($args{climPhenom}, $mysqlSettings{table})) {
	$logger->info("	MySQL column \'$args{'climPhenom'}\' exists in table \'$mysqlSettings{'table'}\'");
} else {
	$sqlQuery = "ALTER TABLE $mysqlSettings{'table'} ADD $args{'climPhenom'} VARCHAR(20)";
	$db->query($sqlQuery) or die "Could not add column $args{'climPhenom'} in table \'$mysqlSettings{'table'}\': $!";
	$sqlQuery = "CREATE INDEX index_".(lc($args{climPhenom}))." ON $mysqlSettings{'table'} ($args{climPhenom})";
	$db->query($sqlQuery) or die "Cannot create index on column $args{climPhenom}: $!";
}
#--------------------------------------------------------------------
# If the "destroy" option is set, removing all data from the table
#
if ($args{destroyOpt}) {
	mysql_wipeTable($mysqlSettings{database}, $mysqlSettings{table});
}

#--------------------------------------------------------------------
# Read the input file into a variable
#
$logger->info("\n- Processing input -\n\n");
$logger->info("\nTimescale : $args{timeScale}, month format $args{monthFormat} \n\n");
# If it's a URL
my $inputContent;
if (validateUrl($args{input})) {
	$inputContent = get $args{input};
} else {
	open (INPUT, $args{input}) or die "Cannot open $args{input}: $!";
	$inputContent = do { local $/; <INPUT> };
	close (INPUT);
}
# Remove the first line if the -hasheader arg was used
$inputContent =~ s/^(?:.*\n){1}//;

#--------------------------------------------------------------------
# Loop over all lines - this assumes that the data is either for monthly or seasonal.
# The read in monthly/seasonal value is inserted as daily data (for ease of reference in verification system).
# Daily data is not able to be handled in the script yet.
if ($args{timeScale} =~ m/\b(monthly|seasonal)\b/) {
	foreach my $inputLine (split /\n/, $inputContent) {
		$logger->debug("  Input line: $inputLine");

		#--------------------------------------------------------------------
		# Split line
		#
		my @splitLine = split ' ', $inputLine;

		#--------------------------------------------------------------------
		# Calculate dates
		#
		# Convert from a 3-digit season to a month number
		my $month;
		# If the timescale is monthly and format is MMM, it is a 3-char string format representing the month (ie. JAN)
		if (($args{timeScale} =~ m/\b(monthly)\b/) && ($args{monthFormat} =~ m/\b(MMM)\b/)) {
		#if (($args{timeScale} eq "monthly") && ($args{monthformat} eq "sMMM")) {
			$month = convert_date_month2num($splitLine[$args{monthCol}-1]);
		} 
		# If the timescale is seasonal and format is MMM, it is a 3-char string format representing season (ie. JJA)
		elsif (($args{timeScale} =~ m/\b(seasonal)\b/) && ($args{monthFormat} =~ m/\b(MMM)\b/)) {
			$month = convert_date_season2num($splitLine[$args{monthCol}-1]);
		}
		# Else, if timescale is monthly or seasonal and format is MM, value should be assumed to be already in numeric format
		# and that it should be imported as a value
		else {
			$logger->debug("In else");
			$month = $splitLine[$args{monthCol}-1];
			#Check for numeric value of the month value
			unless ($month =~ m/^[0-9]+$/i) {
				$logger->fatal("Non-numeric month/season value $month was passed for a month but not specified in options. See options for -f for specifying format.");
				die "Non-numeric month/season value $month was passed for a month but not specified in options. See options for -f for specifying format.";
			} 
		}
		my $year      = $splitLine[$args{yearCol}-1];
		my $value     = $splitLine[$args{valueCol}-1];
		$logger->debug("year, month, value = ".$year.",".$month.",".$value);
		# Create an epoch date
		my $epoch_date = ParseDate(sprintf("%04d-%02d-01", $year, $month));
		# Get the epoch date of the last of the month
		# The year 2000 is used to find out the number of days in each month so that the leap year is considered
		# For years that don't actually have a leap year, a value for the month will be inserted into a date
		# for '0000-00-00' which would be ignored in the verification system.
		my $epoch_end  = ParseDate("last day in " . UnixDate($epoch_date,'%B') . ", 2000");
		my $end_day = UnixDate($epoch_end, '%d');

		#--------------------------------------------------------------------
		# Convert value
		#
		my $mysqlValue = convert_value_num2str($value, $args{climPhenom});

	    	#--------------------------------------------------------------------
		# Loop over all days of the month
		#
		foreach my $day (1 .. $end_day) {
			# Get a MySQL date for this day
			$mysqlDate = sprintf("%04d-%02d-%02d", $year, $month, $day);
			$logger->debug("MySQL date: $mysqlDate insert value $mysqlValue");
			#--------------------------------------------------------------------
			# Insert data into the database
			#
			# This will either update an already-existing row (if one exists with
			# the given date), or insert a new row.
			#
			if (mysql_countRows($mysqlDate) > 0) {
				mysql_updateData($mysqlDate, $args{climPhenom}, $mysqlValue);
			} else {
				mysql_insertData($mysqlDate, $mysqlValue);
			}
		} # End loop over all days of the month
	} # End foreach line in input
	$logger->info("---------- Completed importing data to database. ----------");
} # End if monthly or seasonal
# Kill process if not monthly or seasonal since script does not yet work for other timescales
else {
	$logger->fatal("Option for timescale not valid - $args{timeScale}. Must either be monthly or seasonal");
	die;
}



#####################################################################
#                           SUBROUTINES                             #
#####################################################################

#--------------------------------------------------------------------
# Converters
#
sub convert_date_month2num {
	$logger->debug("In subroutine convert_date_month2num");
	# Get input args
	my $month = $_[0];
	# Hash array relating 3-digit months to a month number
	my %monthNum = (Jan => '01', Feb => '02', Mar => '03', Apr => '04',
					May => '05', Jun => '06', Jul => '07', Aug => '08',
					Sep => '09', Oct => '10', Nov => '11', Dec => '12');
	return $monthNum{$month};
}

sub convert_date_season2num {
	$logger->debug("In subroutine convert_date_season2num");
	# Get input args
	my $season = $_[0];
	# Hash array relating 3-digit months to a month number
	my %monthNum = (DJF => '01', JFM => '02', FMA => '03', MAM => '04',
					AMJ => '05', MJJ => '06', JJA => '07', JAS => '08',
					ASO => '09', SON => '10', OND => '11', NDJ => '12');
	return $monthNum{$season};
}

=head2 convert_value_num2str()

Converts the value read in as value for climate phenomena, to a string value. This can include logic to convert from a numeric value to an assigned string, ie. a numeric value for ENSO to 'warm', 'cold', or 'neutral'. If there is no 'if' statement in the logic in this subroutine for a climate phenomena (passed argument $args{climPhenom}, then a string format of the passed value will be used as default.

	Input
		dbName    - Database name
		tableName - Table name
	Output
		Database status:
			1 if table exists
			0 if table doesn't exist, or if there is no database connection

=cut
sub convert_value_num2str {
	$logger->debug("In subroutine convert_value_num2str");
	# Get input args
	my $value      = $_[0];
	my $climPhenom = $_[1];
	# Convert value to decimal if in scientific notation
	if($value =~ /[e]/i) {
    		$value = convert_scientific2decimal($value);
		$logger->debug("Converted scientific notation value to decimal : $value");
	}
	# * Add if statements below to convert any values read in to a different value to input into database
	# ENSO
	if ($climPhenom eq "ENSO") {
		if    ($value >=  0.5) { return "warm"   ; }
		elsif ($value <= -0.5) { return "cold"   ; }
		else                   { return "neutral"; }
	}
	# Else return the value itself
	else {
		$logger->debug("Value returned is the read in file from input : $value");
		return $value;
	}
}

sub convert_scientific2decimal {
	$logger->debug("In subroutine convert_scientific2decimal");
	# Get input arg
	my $scientific_notation = $_[0];
	# Convert scientific notation to decimal
	$decimal_notation = sprintf("%.10f", $scientific_notation);
	return $decimal_notation;
}
#--------------------------------------------------------------------
# Mysql
#

=head2 mysql_getTableName()

Constructs a MySQL table name containing the specific data requested.

The exact table name depends on the time scale of the data requested.

	Output
		Database table name

=cut
sub mysql_getTableName {
	# Append the time scale to "climatePhenomena"
	return "climatePhenomena_$args{timeScale}";
}

=head2 mysql_tableExists()

Checks if the speficied database table exists.

	Input
		dbName    - Database name
		tableName - Table name
	Output
		Database status:
			1 if table exists
			0 if table doesn't exist, or if there is no database connection

=cut
sub mysql_tableExists {
	# If there's no DB connection, return 0 immediately
	unless ($db) {
		print "No database connection is present...\n";
		return 0;
	}
	# Get input args
	my $dbName    = $_[0];
	my $tableName = $_[1];
	my $sqlQuery = "SHOW TABLES FROM $dbName LIKE '$tableName'";
	$logger->debug("  [mysql_tableExists()] SQL query: $sqlQuery");
	my $results = $db->query($sqlQuery);
	if ($results->numrows() > 0) {
		return 1;
	} else {
		return 0;
	}
}

=head2 mysql_checkVar(varName)

Checks for existence of column (type climate phenomena) in table

	Input
		varName - Name of climate phenomena that a column should exist for in database
		tableName - Table name
	Output
		Database column status:
			1 if column exists
			0 if column doesn't exist

=cut
sub mysql_colExists {
	my $varName  = $_[0];
	my $tableName = $_[1];
	my $sqlQuery = "SHOW columns from $tableName WHERE field='$varName'";
	$logger->debug("  [mysql_insertData] SQL query: $sqlQuery");
	$logger->debug("  [mysql_tableExists()] SQL query: $sqlQuery");
	my $results = $db->query($sqlQuery);
	if ($results->numrows() > 0) {
		return 1;
	} else {
		return 0;
	}
}

=head2 mysql_wipeTable(database,table)

Deletes all data from the appropriate database table.

The database in question depends on the I<dataType> variable.

	Input
		database - MySQL database containing the table to delete all rows from
		table    - MySQL table to delete all rows from

=cut
sub mysql_wipeTable {
	# Get input args
	my $database = $_[0];
	my $table    = $_[1];
	# Generate SQL query
	my $sqlQuery = "TRUNCATE ${database}.${table}";
	$logger->debug("  Truncating ${database}.${table}...");
	my $results = $db->query($sqlQuery);
}

=head2 mysql_countRows(date)

Counts the number of rows for a given date.

	Input
		date - date to find rows at
	Output
		rows - number of rows for the given date

=cut
sub mysql_countRows {
	# Get input args
	my $date = $_[0];
	# If there's no DB connection, return 0 immediately
	unless ($db) {
		print "No DB connection to determine dataTable existance!\n";
		return 0;
	}
	# Create the SQL
	my $sqlQuery = "SELECT * FROM $mysqlSettings{'database'}.$mysqlSettings{'table'} WHERE date_valid='$date'";
	$logger->debug("  [mysql_countRows()] SQL query: $sqlQuery");
	# Execute query
	my $results = $db->query($sqlQuery);
	$logger->debug("  [mysql_countRows()] Returning " . $results->numrows() . " rows");
	return $results->numrows();
}

=head2 mysql_updateData(date,climphenom,value)

Updates the appropriate climate phenomenon at the given date.

	Input
		date       - date of the data to insert
		climphenom - climate phenomenon to update
		value      - value of the climate phenomenon to insert

=cut
sub mysql_updateData {
	my $date       = $_[0];
	my $climPhenom = $_[1];
	my $value      = $_[2];
	my $sqlQuery = "UPDATE $mysqlSettings{table} SET $climPhenom='$value' WHERE date_valid='$date'";
	$logger->debug("  [mysql_updateData()] SQL query: $sqlQuery");
	# Submit query
	$db->query($sqlQuery);
}

=head2 mysql_insertData(date,value)

Inserts data into the appropriate database table at the given date.

	Input
		date  - date of the data to insert
		value - value of the climate phenomenon to insert

=cut
sub mysql_insertData {
	my $date  = $_[0];
	my $value = $_[1];
	my $sqlQuery = "INSERT INTO $mysqlSettings{table} (date_valid, $args{climPhenom}) VALUES ('$date','$value')";
	$logger->debug("  [mysql_insertData] SQL query: $sqlQuery");
	# Submit query
	$db->query($sqlQuery);
}

sub checkArgs {
	# Retrieve the arguments passed to this subroutine
	my (%args) = @_;

	#----------------------------------------------------------------
	# Climate phenomenon
	#
	unless (defined($args{climPhenom})) { pod2usage("\nThe -climPhenom argument is not set. \n"); }

	#----------------------------------------------------------------
	# Timescale
	#
	unless (defined($args{timeScale}) and $args{timeScale} =~ m/\b(seasonal|monthly)\b/) { pod2usage("\nThe -timescale argument is not set properly\n"); }

	#----------------------------------------------------------------
	# ASCII columns
	#
	# Month
	unless (defined($args{monthCol}) and $args{monthCol} =~ m/\b(\d+|\w|)\b/i) { pod2usage("\nThe -monthCol argument is not set properly\n"); }
	unless (defined($args{yearCol} ) and $args{yearCol}  =~ m/\b(\d+|\w|)\b/i) { pod2usage("\nThe -yearCol argument is not set properly\n"); }
	unless (defined($args{valueCol}) and $args{valueCol} =~ m/\b(\d+|\w|)\b/i) { pod2usage("\nThe -valueCol argument is not set properly\n"); }

	#----------------------------------------------------------------
	# Month format
	#
	unless (defined($args{monthFormat}) and $args{monthFormat} =~ m/\b(m|mm|mmm)\b/i) { pod2usage("\nThe -monthformat argument is not set properly\n"); }

	#----------------------------------------------------------------
	# Input
	#
	# Is it defined?
	unless (defined($args{input})) { pod2usage("\nThe -input argument is not defined\n"); }
	# Is it a valid URL or file?
	unless (validateUrl($args{input}) or (-e $args{input})) { pod2usage("\nThe -input argument is not a valid file or URL\n"); }

	#----------------------------------------------------------------
	# Log level
	#
	# Since this is optional, only validate if it's defined
	if (defined($args{logLevel})) {
		unless ($args{logLevel} =~ m/\b(DEBUG|INFO)\b/i) { pod2usage("\nThe -loglevel argument is not set properly\n"); }
	}
}

# From http://www.bigprism.com/cgi-perl-snippets/regexp-to-validate-url-syntax.html
sub validateUrl {
  my($strUrl) = shift;
  return
  $strUrl =~ m!(http:|https:|ftp:)//([A-z\d]+)\:([A-z\d]+)\@([A-z\d\-\.]+\.)+[A-z]!i ||
  $strUrl =~ m!^(http:|https:|ftp:)//([A-z\d\-\.]+\.)+[A-z]!i ||
  $strUrl =~ m!^(http:|https:|ftp:)//(\d){1,3}\.(\d){1,3}\.(\d){1,3}\.(\d){1,3}!i ? 1 : 0;
}
