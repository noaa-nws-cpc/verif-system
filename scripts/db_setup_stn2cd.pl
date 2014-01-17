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

use lib "$HOME/library/perl";
use Getopt::Long;
use Switch;
use Mysql;
use Time::Local;
use ConfigFile;

#--------------------------------------------------------------------
# Get command line arguments
#
GetOptions ('help|h' => \$help);
$numArgs = $#ARGV + 1;
$file = $ARGV[0];

#--------------------------------------------------------------------
# Check for requirements
#
unless ($numArgs > 0) {
	$argsMissing = 1;
}

# Determine if all arguments were provided
if ($help or $argsMissing) {
	print "Usage: db_setup_stn2cd.pl file

Required arguments:
  file              CSV file containing the station and the climate division
                    in columns 1 & 2, respectively

Optional arguments:
  -h, -help         Print this help message
";
	exit;
}

#--------------------------------------------------------------------
# MySQL options
#
# Read in MySQL settings from a configuration file
my $configFile="$HOME/input/mysql.conf";
my %mysqlSettings = load_settings($configFile,"multi");
# Set the rest of the MySQL settings
$mysql{'database'} = 'reference';
$mysql{'table'} = "stations";

#--------------------------------------------------------------------
# Print diagnostic information
#
print "--------------------------------------------------------------------

- MySQL info -

  Host:     $mysql{'host'}
  User:     $mysql{'user'}
  Database: $mysql{'database'}
  Table:    $mysql{'table'}

- Making MySQL connection -

";

#--------------------------------------------------------------------
# Make a connection to the database
#
# Connect to MySQL server
my $db = Mysql->connect($mysql{'host'},$mysql{'database'},$mysql{'user'},$mysql{'password'}) or die "Cannot connect to MySQL server: $!\n";
print "  Successfully connected to database...\n";
# If the table doesn't exist, exit the script
$sqlQuery = "SHOW TABLES LIKE '$mysql{'table'}'";
$results = $db->query($sqlQuery);
if ($results->numrows() > 0) {
	print "  Table '$mysql{'table'}' exists...\n\n";
} else {
	print "  Table '$mysql{'table'}' does not exist, exiting...\n\n";
	exit;
}

#--------------------------------------------------------------------
# Open the text file
#
open (FILE, "<$file") or die "Can't open $file: $!";

#--------------------------------------------------------------------
# Loop over all rows
#
while ($line = <FILE>) {
	# Split the line into two variables
	($station, $climateDivision) = split(",", $line);
	# Chomp both variables
	chomp $station;
	chomp $climateDivision;
	# Update the mysql table with the climate division #
	$sql = "UPDATE $mysql{'table'} SET climateDivision=$climateDivision WHERE id=$station";
	print "Submitting SQL: $sql\n";
	$results = $db->query($sql);
}

#--------------------------------------------------------------------
# Close the text file
#
close(FILE)
