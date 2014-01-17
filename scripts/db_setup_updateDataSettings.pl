#!/usr/bin/perl

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

use Getopt::Long;
use Switch;
use Mysql;
use Time::Local;
use Date::Manip;
use Cwd 'abs_path';
use lib "$HOME/library/perl";
use ConfigFile;

#--------------------------------------------------------------------
# Get command line arguments
#
GetOptions ('help|h'	=> \$help,
			'file|f=s'	=> \$file,
			'table|t=s'	=> \$args{'settingsTable'}
);

#--------------------------------------------------------------------
# If the user wants help, print the usage
#
if ($help) {
	printUsage();
}

#--------------------------------------------------------------------
# Check for required options
#
my @requiredArgs = ($file, $args{'settingsTable'});
if (checkArgs(@requiredArgs)==0) { printUsage(); }
# Convert provided file to full path
$file = abs_path($file);

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
$mysqlSettings{database} = $mysqlSettings{db_ref};
$mysqlSettings{settingsTable} = $args{'settingsTable'};

#--------------------------------------------------------------------
# Print diagnostic information
#
# Get the current date/time
$currentTime = &UnixDate("today",'%T %Y-%m-%d');

print "

--------------------------
- Data Settings Updater  -
--------------------------

  Program started at $currentTime

- Settings -

  Settings file:    $file
  Settings table:   $mysqlSettings{settingsTable}
";

print "
- MySQL info -

  Host:     $mysqlSettings{host}
  User:     $mysqlSettings{user}
  Database: $mysqlSettings{database}
  Table:    $mysqlSettings{settingsTable}

- Making MySQL connection -

";

#--------------------------------------------------------------------
# Make a connection to the database
#
# Connect to MySQL server
my $db = Mysql->connect($mysqlSettings{'host'},$mysqlSettings{'database'},$mysqlSettings{'user'},$mysqlSettings{'password'}) or die "Cannot connect to the MySQL server: $!\n";
print "  Successfully connected to the MySQL server...\n";
# Connect to the database
if (!$mysqlSettings{'database'}) {
	die "  There is no database specified, check your -datatype flag...\n";
} else {
	$db->selectdb($mysqlSettings{'database'}) or die "Cannot connect to the MySQL database $mysqlSettings{'database'}: $!\n";
}

#--------------------------------------------------------------------
# Ensure the required settings table exists
#
if (mysql_tableExists($db, $mysqlSettings{'database'}, $mysqlSettings{'settingsTable'})) {
	print "  MySQL table \'$mysqlSettings{'settingsTable'}\' exists\n";
} else {
	print "  MySQL table \'$mysqlSettings{'settingsTable'}\' does not exist, exiting...\n";
	exit;
}

#--------------------------------------------------------------------
# Truncate the settings table
#
mysql_wipeTable($db, $mysqlSettings{'database'}, $mysqlSettings{'settingsTable'});

#--------------------------------------------------------------------
# Insert data settings into settings table
#
$sqlQuery = "LOAD DATA LOCAL INFILE '$file' INTO TABLE $mysqlSettings{'database'}.$mysqlSettings{'settingsTable'} FIELDS TERMINATED BY ',' LINES TERMINATED BY '\\n' IGNORE 1 LINES";
$results = $db->query($sqlQuery);
$affectedRows = $results->affectedrows($sqlQuery);
print "  Added $affectedRows rows\n";

sub printUsage {
	print "
Usage: db_setup_updateDataSettings.pl [OPTIONS]

Required arguments:
  -f, --file            File containing data settings
  -t, --table           Database table to insert data settings into

Optional arguments:
  -h, -help         Print this help message
";
	exit;
}

sub checkArgs {
	my $argsGood = 1;
	foreach $var (@_) {
		if (!defined($var)) {
			$argsGood = 0;
			last;
		}
	}
	return $argsGood;
}

sub mysql_tableExists {
	my ($databaseConnection, $databaseName, $tableName) = @_;
	if (not($databaseConnection and $databaseName and $tableName)) {
		warn("mysql_tableExists requires more args...\n");
		return 0;
	}
	# If there's no DB connection, return
	unless ($databaseConnection) {
		print "No DB connection to determine dataTable existance!\n";
		return 0;
	}
	my $sqlQuery = "SHOW TABLES FROM $databaseName LIKE '$tableName'";
# 	print "SQL Query: $sqlQuery\n";
	my $results = $databaseConnection->query($sqlQuery);
	if ($results->numrows() > 0) {
		return 1;
	} else {
		return 0;
	}
}

sub mysql_wipeTable {
	my ($databaseConnection, $databaseName, $tableName) = @_;
	if (not($databaseConnection and $databaseName and $tableName)) {
		warn("mysql_tableExists requires more args...\n");
	}
	my $sqlQuery = "TRUNCATE $databaseName.$tableName";
	$results = $db->query($sqlQuery);
}
