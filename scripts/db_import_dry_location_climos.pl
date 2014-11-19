#!/usr/bin/perl

=head1 NAME

db_import_dry_location_climos - A Perl script to import ascii-formatted dry location climagologies

=head1 SYNOPSIS

db_import_dry_location_climos.pl [OPTIONS]

 Required arguments:
   General:
     -f, -file             ASCII file containing the climatology data
     -y, -years            Years the climatology file is valid over      yyyy-yyyy
     -a, -avewindow        Averaging window with appending units         05d, 07d
     -g, -spatialtype      Type of spatial data                          cd, stn, grid2deg

 Optional arguments:
   -h, -help         Print this help message
   -headerlines      Number of header lines (which will be ignored)
   -loglevel         Sets the log4perl logging level (DEBUG, INFO, WARN,ERROR, FATAL)
   -email            Email any errors to the process owner

=head1 DESCRIPTION

This script reads in an ASCII file containing dry location climagology data, specifically
the percent of days within a given climatology window where a given location receives no
precipitation. This is required for dry location correction.

=head1 SEE ALSO

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
use Log::Dispatch::Email::MailSend;
use strict;
use warnings;

#--------------------------------------------------------------------
# Get command line arguments
#
my (%args, $help);
GetOptions (
'file|f=s'			=> \$args{file},
'years|y=s'			=> \$args{years},
'avewindow|a=s'		=> \$args{ave_window},
'spatialtype|g=s'	=> \$args{spatial_type},
'headerlines=s'		=> \$args{header_lines},
'loglevel=s'		=> \$args{log_level},
'email'				=> \$args{email_opt},
'help|h'			=> \$help
);

#--------------------------------------------------------------------
# Read in settings from a configuration file
#--------------------------------------------------------------------
# Use load_settings() to load the settings
my $config_file="$HOME/input/verif_data.conf";
my %settings = load_settings($config_file,"multi");
# Extract separate settings sections
my %mysql_settings = %{$settings{mysql}};
my %email_settings = %{$settings{email}};

#--------------------------------------------------------------------
# If the user wants help, print the usage
#
if ($help) {
	pod2usage(1);
}

#--------------------------------------------------------------------
# Validate arguments
#--------------------------------------------------------------------
validate_args(%args);

#--------------------------------------------------------------------
# Get the name of the data table
#--------------------------------------------------------------------
$mysql_settings{data_table_name} = mysql_get_data_table_name();

#--------------------------------------------------------------------
# Specify the name of the database
#--------------------------------------------------------------------
$mysql_settings{database} = "cpc_climatologies";

#--------------------------------------------------------------------
# Update any settings (if necessary)
#--------------------------------------------------------------------
# Create an email subject if necessary
unless ($email_settings{subject}) {
	    $email_settings{subject} = "Problem with importing climo data";
}

#--------------------------------------------------------------------
# Create list of options if any are set
#--------------------------------------------------------------------
my $options_set;
if ($args{header_lines}) { $options_set = $options_set . "  -headerlines  $args{header_lines}\n"; }
if ($args{log_level})    { $options_set = $options_set . "  -loglevel     $args{log_level}\n"; }
if ($args{email_opt})    { $options_set = $options_set . "  -email\n"; }

#--------------------------------------------------------------------
# Set up log4perl logger
#--------------------------------------------------------------------
if ($args{log_level}) {
	# Convert the given log level to ALL CAPS
	$args{log_level} = uc($args{log_level});
} else {
	# Default to INFO
	$args{log_level} = "INFO";
}
my $logger = initialize_logger();

#--------------------------------------------------------------------
# Get the current date/time
#--------------------------------------------------------------------
my $current_time = &UnixDate("today",'%T %Z %Y-%m-%d');

#--------------------------------------------------------------------
# Create a welcome message
#--------------------------------------------------------------------
my $welcome_message = "
|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
|           Dry-location Climatology Importer             |
|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Program started at $current_time

- General Settings -

  Data file:          $args{file}
  Climatology years:  $args{years}
  Averaging window:   $args{ave_window}
  Spatial type:       $args{spatial_type}

- MySQL Settings -

  Host:  $mysql_settings{host}
  User:  $mysql_settings{user}
  Table: $mysql_settings{data_table_name}
";

# If the email option is on, also print email information
if ($args{email_opt}) {
	$welcome_message .= "
- Email Settings -

  Recipient:  $email_settings{toEmail}
  Subject:    $email_settings{subject}
  From Email: $email_settings{fromEmail}
  From Name:  $email_settings{fromName}\n";
}

if ($options_set) {
	$welcome_message .= "\n- Options set -\n\n$options_set~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n";
}

#--------------------------------------------------------------------
# Print the welcome message
#--------------------------------------------------------------------
$logger->info($welcome_message);

#--------------------------------------------------------------------
# Make a connection to the database
#
# Connect to MySQL server
my $db = DBI->connect("DBI:mysql:$mysqlSettings{database};host=$mysqlSettings{host}",$mysqlSettings{user},$mysqlSettings{password});
unless ($db) {
	$logger->fatal("  Cannot connect to the MySQL server: " . $DBI::errstr . "\n");
	exit;
}
$logger->info("  Successfully connected to the MySQL server...\n");
# Connect to the database
if (!$mysql_settings{database}) {
	$logger->fatal("  There is no database specified, check your -datatype flag...\n");
	exit;
} else {
	# Try to select the database
	unless($db->selectdb($mysql_settings{database})) {
		$logger->fatal("  Cannot connect to the MySQL database $mysql_settings{database}: " . $DBI::errstr . "\n");
		exit;
	};
}
#--------------------------------------------------------------------
# Ensure the required data table exists
#--------------------------------------------------------------------
if (mysql_data_table_exists()) {
	$logger->info("  MySQL table \'$mysql_settings{data_table_name}\' exists\n");
} else {
	$logger->fatal("  MySQL table \'$mysql_settings{data_table_name}\' does not exist, exiting...\n");
	exit;
}

#--------------------------------------------------------------------
# Delete everything from the data table
#--------------------------------------------------------------------
mysql_wipe_table($mysql_settings{data_table_name});

#--------------------------------------------------------------------
# Open file
#--------------------------------------------------------------------
if (-e $args{file}) {
	open(FILE, "<", $args{file});
} else {
	$logger->fatal("File $args{file} was not found...");
	exit 1;
}

#--------------------------------------------------------------------
# Skip file headers (if applicable)
#--------------------------------------------------------------------
if ($args{header_lines}) { # if the number of headerlines is given
	# Read one line at a time up the given number of header lines
	<FILE> for 1 .. $args{header_lines};
}

#--------------------------------------------------------------------
# Read through the rest of the file
#--------------------------------------------------------------------
while (my $line = <FILE>) {

	#--------------------------------------------------------------------
	# Insert data into database
	#--------------------------------------------------------------------
	# Trim beginning whitespace
	$line =~ s/^\s+//;
	# Split line into components
	my ($id, @percents) = split(/[\s+,]/,$line);
	# Loop over all 12 months
	for (my $month=1; $month<=12; $month++) {
		# Create an epoch date for the first of the month
		my $epoch_date = ParseDate(sprintf("2000-%02d-01", $month));
		# Get the epoch date of the last of the month
		my $epoch_end  = ParseDate("last day in " . UnixDate($epoch_date,'%B') . ", 2000");
		my $end_day = UnixDate($epoch_end, '%d');
		# Loop over all days of the month
		foreach my $day (1 .. $end_day) {
			# Convert date to a MySQL date
			my $mysql_date = sprintf("2000-%02d-%02d", $month, $day);
			# Create an SQL statement which will insert the climo for the given day/location
			my $sql_query = "INSERT INTO $mysql_settings{data_table_name}(id, date_valid, percentDry) VALUES('$id', '$mysql_date', " . $percents[($month - 1)] . ")";
			$logger->debug("  SQL query to insert daily climo percentDry: $sql_query");
			# Submit SQL statement
			$db->do($sql_query);
		}
	}
}

$logger->info("  Finished importing the data");

#--------------------------------------------------------------------
# Close the ASCII data file
#--------------------------------------------------------------------
close(FILE);

#--------------------------------------------------------------------
# Printing closing statement
#--------------------------------------------------------------------
# Get the current date/time
$current_time = &UnixDate("today",'%T %Y-%m-%d');
$logger->info("\n  Program finished at $current_time\n");

=head2 initialize_logger()

Creates a log4perl configuration string and initializes the logger

See http://search.cpan.org/dist/Log-Log4perl/lib/Log/Log4perl.pm

Output:
  logger - log4perl logger object

=cut
sub initialize_logger() {
	
	my %logger_config = (
		'log4perl.rootLogger'                               => "DEBUG, Screen",
		'log4perl.appender.Screen'                          => "Log::Log4perl::Appender::Screen",
		'log4perl.appender.Screen.layout'                   => "Log::Log4perl::Layout::PatternLayout",
		'log4perl.appender.Screen.layout.ConversionPattern' => "\%m\%n",
		'log4perl.appender.Screen.Threshold'                => "$args{log_level}"
	);
	# If the email option is turned on
	if (defined($args{email_opt})) {
		# Add "Mailer" to the root logger
		$logger_config{'log4perl.rootLogger'} .= ", Mailer";
		# Add a Mailer appender (will send out email when an ERROR-level log call occurs)
		%logger_config = (%logger_config, (
			'log4perl.appender.Mailer'                          => "Log::Dispatch::Email::MailSend",
			'log4perl.appender.Mailer.to'                       => "$email_settings{toEmail}",
			'log4perl.appender.Mailer.from'                     => "\"$email_settings{fromName}\" <$email_settings{fromEmail}>",
			'log4perl.appender.Mailer.subject'                  => "$email_settings{subject}",
			'log4perl.appender.Mailer.layout'                   => "Log::Log4perl::Layout::PatternLayout",
			'log4perl.appender.Mailer.layout.ConversionPattern' => "\%m\%n",
			'log4perl.appender.Mailer.Threshold'                => "$email_settings{logLevel}",
			'log4perl.appender.Mailer.buffered'                 => 0
		));
	}
	# Initialize the logger
	Log::Log4perl::init( \%logger_config ) or die "Cannot initialize logger: $!";

	return Log::Log4perl::get_logger("");
}

=head2 validate_args()

Validates all input arguments. Nothing is returned, the subroutine simply validates each
against a regex string, and calls pod2usage() if an invalid argument was found. This will
print the usage and exit the program.

Input
	args - Hash array of all input arguments

=cut
sub validate_args {
	# Retrieve the arguments passed to this subroutine
	my (%args) = @_;

	# Define an empty regex string for use below
	my $regex;

	#--------------------------------------------------------------------
	# file
	#--------------------------------------------------------------------
	unless (defined($args{file})) { pod2usage("\nThe -file option is not set\n"); }

	#--------------------------------------------------------------------
	# years
	#--------------------------------------------------------------------
	$regex = '\d{4}-\d{4}';
	unless (defined($args{years}) and $args{years} =~ m/\b($regex)\b/) { pod2usage("\nThe -years option is not set properly, was expecting: $regex\n"); }

	#--------------------------------------------------------------------
	# avewindow
	#--------------------------------------------------------------------
	$regex = '\d{2}[md]';
	unless (defined($args{ave_window}) and $args{ave_window} =~ m/\b($regex)\b/) { pod2usage("\nThe -avewindow option is not set properly, was expecting: $regex\n"); }

	#--------------------------------------------------------------------
	# spatialtype
	#--------------------------------------------------------------------
	$regex = 'stn|cd|grid2deg';
	unless (defined($args{spatial_type}) and $args{spatial_type} =~ m/\b($regex)\b/) { pod2usage("\nThe -spatialtype option is not set properly, was expecting: $regex\n"); }

	#--------------------------------------------------------------------
	# headerlines
	#--------------------------------------------------------------------
	# Since this is optional, only validate if it's defined
	$regex = '\d+';
	if (defined($args{header_lines})) {
		unless ($args{header_lines} =~ m/\b($regex)\b/) { pod2usage("\nThe -headerlines option is not set properly, was expecting: $regex\n"); }
	}

	#----------------------------------------------------------------
	# logLevel
	#--------------------------------------------------------------------
	# Since this is optional, only validate if it's defined
	$regex = 'TRACE|DEBUG|INFO|WARN|ERROR|FATAL';
	if (defined($args{log_level})) {
		unless ($args{log_level} =~ m/\b($regex)\b/i) { pod2usage("\nThe -loglevel option is not set properly, was expecting: $regex\\n"); }
	}
}

#--------------------------------------------------------------------
# Mysql
#

=head2 mysql_get_data_table_name()

Constructs a MySQL table name containing the specific data requested.

The exact table name depends on several properties of the data, including
the climatology years and average window size, etc.

Output
	Database table name

=cut
sub mysql_get_data_table_name {
	my $data_table_name;
	# Convert years from yyyy-yyyy to yyyy_yyyy (dashes not allowed in MySQL table name)
	(my $years = $args{years}) =~ s/-/_/;
	$data_table_name = "percentDry_" . $args{ave_window} . "_" . $years . "_" . $args{spatial_type};
	return $data_table_name;
}

=head2 mysql_data_table_exists()

Checks if the database table specified in $mysql_settings{data_table_name} exists.

Output
	Database status:
		1 if table exists
		0 if table doesn't exist, or if there is no database connection

=cut
sub mysql_data_table_exists {
	# If there's no DB connection, return 0 immediately
	unless ($db) {
		$logger->error("No DB connection to determine data table existance!\n");
		return 0;
	}
	my $sql_query = "SHOW TABLES FROM $mysql_settings{database} LIKE '$mysql_settings{data_table_name}'";
	$logger->debug("  SQL to determine whether the table exists: $sql_query");
	my $results = $db->query($sql_query);
	if ($results->numrows() > 0) {
		return 1;
	} else {
		return 0;
	}
}

=head2 mysql_wipeTable(mysqlTable)

Deletes all data from the appropriate database table.

The database in question depends on the I<dataType> variable.

Input
	mysqlTable - MySQL table to delete all rows from

=cut
sub mysql_wipe_table {
	my $mysql_table = $_[0];
	my $sql_query = "TRUNCATE $mysql_table";
	$logger->debug("  SQL to delete everything from the data table: $sql_query");
	my $results = $db->do($sql_query);
}

